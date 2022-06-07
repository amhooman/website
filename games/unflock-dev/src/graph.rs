// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::prelude::*;

use crate::basic_setup::{Cursor, CursorState};
use crate::consts::*;
use crate::graph_generator::*;
use crate::math::*;
use crate::state::*;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct GraphLabel;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
enum GraphSystem {
    CheckIntersections,
    Hoverable,
    Draggable,
    Drag,
    DragEdge,
    Drop,
    HoverMaterial,
}

pub(crate) struct GraphPlugin;
impl Plugin for GraphPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<GraphMaterials>()
            .add_system_set(SystemSet::on_enter(AppState::Game).with_system(graph_setup.system()))
            .add_system_set(
                SystemSet::on_update(AppState::Game)
                    //.label(GraphLabel)
                    // check intersections before rest of update,
                    // so that they are shown on first render
                    .with_system(check_intersections.system())
                    .label(GraphSystem::CheckIntersections)
                    .with_system(hoverable.system())
                    .label(GraphSystem::Hoverable)
                    .with_system(draggable.system())
                    .label(GraphSystem::Draggable)
                    // POST_UPDATE
                    .with_system(drag.system())
                    .label(GraphSystem::Drag)
                    .with_system(update_edges.system())
                    .label(GraphSystem::DragEdge)
                    .with_system(drop.system())
                    .label(GraphSystem::Drop)
                    .with_system(change_material.system())
                    .label(GraphSystem::HoverMaterial),
            )
            .add_system_set(SystemSet::on_exit(AppState::Game).with_system(cleanup_graph.system()));
    }
}

/// Resources
struct GraphMaterials {
    normal_material: Handle<Image>,
    drag_material: Handle<Image>,
    vertex_sprite_size: f32,
    edge_material: Color,
    highlight_edge_material: Color,
    intersect_material: Color,
    edge_thickness: f32,
}

impl FromWorld for GraphMaterials {
    fn from_world(world: &mut World) -> Self {
        let world = world.cell();
        let asset_server = world
            .get_resource_mut::<AssetServer>()
            .expect("AssetServer not accessible");
        let normal_vertex_texture = asset_server.load(sprites::BLUE_BIRD_SPRITE_PATH);
        let drag_vertex_texture = asset_server.load(sprites::ORANGE_BIRD_SPRITE_PATH);
        GraphMaterials {
            normal_material: normal_vertex_texture.clone(),
            drag_material: drag_vertex_texture.clone(),
            vertex_sprite_size: GRAPH_VERTEX_SPRITE_SIZE,
            edge_material: color::VERY_DARK_BLUE,
            highlight_edge_material: color::ORANGE,
            intersect_material: color::RED,
            edge_thickness: GRAPH_EDGE_THICKNESS,
        }
    }
}

// components
#[derive(Component)]
struct GraphVertex;
#[derive(Clone, Component)]
struct GraphEdge(Entity, Entity);

#[derive(Component)]
struct Draggable;
#[derive(Component)]
struct Dragging;
#[derive(Component)]
struct Dropped;
/// this component is added to dragged vertices to trigger an edge redraw
/// redraw might be required, if the edge was dragged offscreen and the transform adjusted
#[derive(Component)]
struct UpdateConnectedEdges;

#[derive(Component)]
struct Hoverable;
#[derive(Component)]
struct Hovering;

#[derive(Component)]
struct DraggedEdge;

#[derive(Component)]
pub struct Intersections;

/// graph systems

fn graph_setup(
    mut commands: Commands,
    windows: Res<Windows>,
    static_game_state: Res<StaticGameState>,
    mut dynamic_game_state: ResMut<DynamicGameState>,
    graph_materials: Res<GraphMaterials>,
) {
    let window = windows.get_primary().expect("No Ui available");

    let g = generate_graph(static_game_state.difficulty);
    let offset = get_offset(window.height(), window.width(), g.vertices().count() as u32);

    // generate vertices
    let vertices: Vec<(Entity, Polar2d)> = g
        .vertices()
        .map(|i| {
            let pos = Polar2d {
                r: offset.r,
                d: offset.d * (i - 1) as f32,
            };
            let entity = commands
                .spawn_bundle(SpriteBundle {
                    sprite: Sprite {
                        custom_size: Some(Vec2::new(
                            graph_materials.vertex_sprite_size,
                            graph_materials.vertex_sprite_size,
                        )),
                        ..Default::default()
                    },
                    texture: graph_materials.normal_material.clone(),
                    transform: Transform::from_translation(
                        pos.clone().into_3d(GRAPH_VERTEX_Z_ORDER),
                    ),
                    ..Default::default()
                })
                .insert(GraphVertex)
                .insert(Hoverable)
                .insert(Draggable)
                .id();
            (entity, pos)
        })
        .collect();

    // generate edges
    g.edges().iter().for_each(|e| {
        let i = e.0 as usize - 1;
        let j = e.1 as usize - 1;

        let (transform, length) = xy_transform_for(
            vertices[i].1.clone().into(),
            vertices[j].1.clone().into(),
            GRAPH_EDGE_Z_ORDER,
        );
        commands
            .spawn_bundle(SpriteBundle {
                sprite: Sprite {
                    custom_size: Some(Vec2::new(length, graph_materials.edge_thickness)),
                    color: graph_materials.edge_material,
                    ..Default::default()
                },
                transform,
                ..Default::default()
            })
            .insert(GraphEdge(vertices[i].0, vertices[j].0));
    });

    // reset move count
    dynamic_game_state.move_count = 0;
}

/// hovering
fn hoverable(
    mut commands: Commands,
    cursor_state: Query<&CursorState>,
    hoverable: Query<(Entity, &Transform, &Sprite), (With<Hoverable>, Without<Dragging>)>,
) {
    let cursor_state = cursor_state.iter().next().unwrap();

    if cursor_state.cursor_moved {
        for (entity, transform, sprite) in hoverable.iter() {
            if cursor_state.in_range_xy(transform, sprite) {
                commands.entity(entity).insert(Hovering);
            } else {
                commands.entity(entity).remove::<Hovering>();
            }
        }
    }
}

/// system for changing on-hover and edge highlighting materials
fn change_material(
    graph_materials: Res<GraphMaterials>,
    mut hoverables: Query<
        (&mut Handle<Image>, Option<&Hovering>, Option<&Dragging>),
        (With<Hoverable>, Without<GraphEdge>),
    >,
    mut edges: Query<(&mut Sprite, Option<&DraggedEdge>), (With<GraphEdge>, Without<Hoverable>)>,
) {
    for (mut texture, _hovered, dragged) in hoverables.iter_mut() {
        *texture = if dragged.is_some() {
            graph_materials.drag_material.clone()
        } else {
            graph_materials.normal_material.clone()
        };
    }
    for (mut sprite, dragged_edge) in edges.iter_mut() {
        sprite.color = if dragged_edge.is_some() {
            graph_materials.highlight_edge_material.clone()
        } else {
            graph_materials.edge_material.clone()
        };
    }
}

// dragging
fn draggable(
    mut commands: Commands,
    mut dynamic_game_state: ResMut<DynamicGameState>,
    mouse_input: Res<Input<MouseButton>>,
    pressed: Query<Entity, (With<Hovering>, With<Draggable>)>,
    released: Query<Entity, With<Dragging>>,
    edges: Query<(Entity, &GraphEdge), With<GraphEdge>>,
) {
    if mouse_input.just_pressed(MouseButton::Left) {
        if let Some(vertex_entity) = pressed.iter().next() {
            commands.entity(vertex_entity).insert(Dragging);
            edges
                .iter()
                .filter_map(|(edge_entity, GraphEdge(ent_1, ent_2))| {
                    if *ent_1 == vertex_entity || *ent_2 == vertex_entity {
                        Some(edge_entity)
                    } else {
                        None
                    }
                })
                .for_each(|edge_entity| {
                    commands.entity(edge_entity).insert(DraggedEdge);
                })
        }
    } else if mouse_input.just_released(MouseButton::Left) {
        if released.iter().next().is_some() {
            dynamic_game_state.move_count += 1;
        }
        for entity in released.iter() {
            commands.entity(entity).remove::<Dragging>();
            commands.entity(entity).insert(Dropped);
            edges.iter().for_each(|(edge_entity, _)| {
                commands.entity(edge_entity).remove::<DraggedEdge>();
            });
        }
    }
}

fn drag(
    mut commands: Commands,
    mut dragged: Query<(Entity, &mut Transform, &GlobalTransform), Added<Dragging>>,
    cursor: Query<(Entity, &GlobalTransform), With<Cursor>>,
) {
    if let Some((cursor_entity, cursor_transform)) = cursor.iter().next() {
        for (entity, mut transform, global_transform) in dragged.iter_mut() {
            let global_pos = global_transform.translation - cursor_transform.translation;

            commands.entity(entity).insert(Parent(cursor_entity));

            transform.translation.x = global_pos.x;
            transform.translation.y = global_pos.y;
            transform.translation.z = GRAPH_VERTEX_Z_ORDER;
        }
    }
}

fn drop(
    mut commands: Commands,
    windows: Res<Windows>,
    mut dropped: Query<(Entity, &mut Transform, &GlobalTransform), Added<Dropped>>,
) {
    let window = windows.get_primary().expect("No Ui available");
    let window_half_height = (window.height() - WINDOW_BORDER_SIZE) / 2.;
    let window_half_width = (window.width() - WINDOW_BORDER_SIZE) / 2.;

    for (entity, mut transform, global_transform) in dropped.iter_mut() {
        let global_pos = global_transform.translation;

        // clamp
        transform.translation.x = global_pos.x.clamp_to(-window_half_width, window_half_width);
        transform.translation.y = global_pos
            .y
            .clamp_to(-window_half_height, window_half_height);

        transform.translation.z = GRAPH_VERTEX_Z_ORDER;

        commands.entity(entity).remove::<Parent>();
        commands.entity(entity).remove::<Dropped>();
        // if the edge transform was adjusted, the edges must be repainted
        commands.entity(entity).insert(UpdateConnectedEdges);
    }
}

// edge systems
fn update_edges(
    mut commands: Commands,
    dragged: Query<
        (Entity, Option<&UpdateConnectedEdges>),
        Or<(With<Dragging>, With<UpdateConnectedEdges>)>,
    >,
    all_vertices: Query<&GlobalTransform, With<GraphVertex>>,
    mut edges: Query<
        (&mut GlobalTransform, &Sprite, &GraphEdge),
        (With<GraphEdge>, With<DraggedEdge>, Without<GraphVertex>),
    >,
) {
    for (dragged_vertex_entity, dropped) in dragged.iter() {
        for (mut g_transform, sprite, GraphEdge(ent_1, ent_2)) in edges.iter_mut() {
            let (e1, e2) = if *ent_1 == dragged_vertex_entity {
                (ent_1, ent_2)
            } else {
                (ent_2, ent_1)
            };
            let t1 = all_vertices.get(*e1).expect("node must exist").translation;
            let t2 = all_vertices.get(*e2).expect("node must exist").translation;
            let (new_transform, length) = xy_transform_for(t1, t2, GRAPH_EDGE_Z_ORDER);

            *g_transform = new_transform.into();
            sprite.custom_size.unwrap().x = length;
        }
        if dropped.is_some() {
            commands
                .entity(dragged_vertex_entity)
                .remove::<UpdateConnectedEdges>();
        }
    }
}

// This function checks if the edges of the graph intersect.
fn check_intersections(
    mut commands: Commands,
    all_vertices: Query<&GlobalTransform, With<GraphVertex>>,
    edges: Query<&GraphEdge, With<GraphEdge>>,
    intersections: Query<(Entity, &Intersections)>,
    static_game_state: Res<StaticGameState>,
    mut dyn_game_state: ResMut<DynamicGameState>,
    graph_materials: Res<GraphMaterials>,
) {
    let mut intersection_count = 0;
    let mut edges: Vec<GraphEdge> = edges.iter().map(|e| (*e).clone()).collect();

    for (ent, _) in intersections.iter() {
        commands.entity(ent).despawn();
    }

    while 1 < edges.len() {
        let GraphEdge(id1, id2) = &edges.pop().expect("there must be elements in vector");
        let current1 = all_vertices.get(*id1).expect("node must exist").translation;
        let current2 = all_vertices.get(*id2).expect("node must exist").translation;
        let current_segment = LineSegment::from((&current1, &current2));

        for GraphEdge(e1, e2) in &edges {
            let vertex1 = all_vertices.get(*e1).expect("node must exist").translation;
            let vertex2 = all_vertices.get(*e2).expect("node must exist").translation;
            let seg = LineSegment::from((&vertex1, &vertex2));

            let intersection = current_segment.intersect_segments(&seg);
            if let SegmentIntersectionType::Some(intersection) = intersection {
                intersection_count += 1;
                if static_game_state.draw_intersections {
                    commands
                        .spawn_bundle(SpriteBundle {
                            sprite: Sprite {
                                custom_size: Some(Vec2::new(10., 10.)),
                                color: graph_materials.intersect_material,
                                ..Default::default()
                            },
                            transform: Transform {
                                translation: Vec3::new(
                                    intersection.x as f32,
                                    intersection.y as f32,
                                    5.0,
                                ),
                                //scale: Vec3::splat(5.),
                                ..Default::default()
                            },
                            ..Default::default()
                        })
                        .insert(Intersections);
                }
            }
        }
    }
    // only update resource if value changes
    if dyn_game_state.intersections != intersection_count {
        dyn_game_state.intersections = intersection_count;
    }
}

fn cleanup_graph(
    mut commands: Commands,
    vertices: Query<Entity, With<GraphVertex>>,
    edges: Query<Entity, With<GraphEdge>>,
    intersections: Query<Entity, With<Intersections>>,
) {
    for entity in vertices.iter() {
        commands.entity(entity).despawn_recursive();
    }
    for entity in edges.iter() {
        commands.entity(entity).despawn_recursive();
    }
    for entity in intersections.iter() {
        commands.entity(entity).despawn_recursive();
    }
}
