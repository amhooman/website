// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use crate::consts::*;
use crate::state::*;
use bevy::diagnostic::{Diagnostics, FrameTimeDiagnosticsPlugin};
use bevy::prelude::*;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct GameUiLabel;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
enum GameUiLabels {
    GameUiUpdate,
    DifficultyUpdate,
    FpsUpdate,
    IntersectionsUpdate,
    VictoryUpdate,
    ButtonPressed,
}

/// in game HUD
pub(crate) struct GameUiPlugin;
impl Plugin for GameUiPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<GameUiMaterials>()
            .init_resource::<StaticGameState>()
            .init_resource::<DynamicGameState>()
            .add_system_set(
                SystemSet::on_enter(AppState::Game)
                    .label(GameUiLabel)
                    .with_system(game_ui_setup.system()),
            )
            .add_system_set(
                SystemSet::on_update(AppState::Game)
                    .label(GameUiLabel)
                    .with_system(button_material_system.system())
                    .label(GameUiLabels::GameUiUpdate)
                    .with_system(difficulty_update_system.system())
                    .label(GameUiLabels::DifficultyUpdate)
                    .with_system(fps_update_system.system())
                    .label(GameUiLabels::FpsUpdate)
                    .with_system(intersections_update_system.system())
                    .label(GameUiLabels::IntersectionsUpdate)
                    .with_system(victory_update_system.system())
                    .label(GameUiLabels::VictoryUpdate)
                    .with_system(button_press_system.system())
                    .label(GameUiLabels::ButtonPressed),
            )
            .add_system_set(
                SystemSet::on_exit(AppState::Game)
                    .label(GameUiLabel)
                    .with_system(game_ui_cleanup_system.system()),
            )
            .add_system_set(
                SystemSet::on_update(AppState::Respawn).with_system(respawn_game_system.system()),
            );
    }
}

// Resources

/// color and font resources for the HUD
struct GameUiMaterials {
    normal_green: UiColor,
    hovered_green: UiColor,
    pressed_green: UiColor,
    normal_red: UiColor,
    hovered_red: UiColor,
    pressed_red: UiColor,
    none: UiColor,
    font_color: Color,
    font: Handle<Font>,
}

impl FromWorld for GameUiMaterials {
    fn from_world(world: &mut World) -> Self {
        let world = world.cell();
        let asset_server = world
            .get_resource_mut::<AssetServer>()
            .expect("AssetServer not accessible");
        GameUiMaterials {
            normal_green: color::LIGHT_GREEN.into(),
            hovered_green: color::GREEN.into(),
            pressed_green: color::DARK_GREEN.into(),
            normal_red: color::LIGHT_RED.into(),
            hovered_red: color::RED.into(),
            pressed_red: color::DARK_RED.into(),
            none: Color::NONE.into(),
            font_color: color::VERY_DARK_GRAY,
            font: asset_server.load(FONT_PATH),
        }
    }
}

// marker structs

// marker for top-level ui entity
#[derive(Component)]
struct GameUi;

// marker for bottom ui bar
#[derive(Component)]
struct UiBottomBar;

// marker for ui buttons
#[derive(Debug, Copy, Clone, Eq, PartialEq, Component)]
enum GameUiButton {
    QuitPuzzle,
    Victory,
}

// marker for difficulty label
#[derive(Component)]
struct DifficultyUi;

// marker for FPS label
#[derive(Component)]
struct FpsUi;

// marker for intersections label
#[derive(Component)]
struct IntersectionsUi;

// marker for howto text
#[derive(Component)]
struct HowtoUi;

// setup top-level ui
// split up into top bar, center area, and bottom bar
// all of them horizontal flex boxes
fn game_ui_setup(
    mut commands: Commands,
    static_state: Res<StaticGameState>,
    game_ui_materials: Res<GameUiMaterials>,
) {
    commands.spawn_bundle(UiCameraBundle::default());
    commands
        .spawn_bundle(NodeBundle {
            style: Style {
                size: Size::new(Val::Percent(100.), Val::Percent(100.)),
                display: Display::Flex,
                flex_direction: FlexDirection::ColumnReverse,
                ..Default::default()
            },
            color: game_ui_materials.none,
            ..Default::default()
        })
        .insert(GameUi)
        // add horizontal flex boxes
        .with_children(|parent| {
            // top bar
            parent
                .spawn_bundle(NodeBundle {
                    style: Style {
                        size: Size::new(Val::Percent(100.), Val::Px(70.)),
                        justify_content: JustifyContent::SpaceBetween,
                        align_items: AlignItems::Center,
                        ..Default::default()
                    },
                    color: game_ui_materials.none,
                    ..Default::default()
                })
                .with_children(|top| {
                    insert_difficulty_label(top, &game_ui_materials);
                    insert_fps_label(top, &game_ui_materials);
                    insert_quit_button(top, &game_ui_materials);
                });
            // center
            parent
                .spawn_bundle(NodeBundle {
                    style: Style {
                        size: Size::new(Val::Percent(100.), Val::Percent(100.)),
                        justify_content: JustifyContent::Center,
                        align_items: AlignItems::Center,
                        ..Default::default()
                    },
                    color: game_ui_materials.none,
                    ..Default::default()
                })
                .with_children(|center| {
                    if static_state.display_difficulty() == 0 {
                        insert_howto(center, &game_ui_materials);
                    }
                });
            // bottom bar
            parent
                .spawn_bundle(NodeBundle {
                    style: Style {
                        size: Size::new(Val::Percent(100.), Val::Px(70.)),
                        justify_content: JustifyContent::Center,
                        align_items: AlignItems::Center,
                        ..Default::default()
                    },
                    color: game_ui_materials.none,
                    ..Default::default()
                })
                .insert(UiBottomBar)
                .with_children(|bottom| {
                    insert_intersections_label(bottom, &game_ui_materials);
                });
        });
}

// systems

/// update button material based on interactions
fn button_material_system(
    button_materials: Res<GameUiMaterials>,
    mut interaction_query: Query<
        (&Interaction, &mut UiColor, &GameUiButton),
        (Changed<Interaction>, With<Button>),
    >,
) {
    for (interaction, mut color, ui_button) in interaction_query.iter_mut() {
        match *interaction {
            Interaction::Clicked => {
                *color = match ui_button {
                    GameUiButton::Victory => button_materials.pressed_green,
                    GameUiButton::QuitPuzzle => button_materials.pressed_red,
                };
            }
            Interaction::Hovered => {
                *color = match ui_button {
                    GameUiButton::Victory => button_materials.hovered_green,
                    GameUiButton::QuitPuzzle => button_materials.hovered_red,
                };
            }
            Interaction::None => {
                *color = match ui_button {
                    GameUiButton::Victory => button_materials.normal_green,
                    GameUiButton::QuitPuzzle => button_materials.normal_red,
                };
            }
        }
    }
}

/// handle button presses
fn button_press_system(
    query: Query<(&Interaction, &GameUiButton), (Changed<Interaction>, With<Button>)>,
    mut static_state: ResMut<StaticGameState>,
    mut app_state: ResMut<State<AppState>>,
) {
    for (interaction, button) in query.iter() {
        if *interaction == Interaction::Clicked {
            match button {
                GameUiButton::QuitPuzzle => app_state
                    .replace(AppState::Menu)
                    .expect("Couldn't switch state to Menu"),
                GameUiButton::Victory => {
                    static_state.difficulty += 1;
                    app_state
                        .replace(AppState::Respawn)
                        .expect("Couldn't switch to Respawn");
                }
            };
        }
    }
}

/// update the difficulty label
fn difficulty_update_system(
    mut query: Query<&mut Text, With<DifficultyUi>>,
    state: Res<StaticGameState>,
) {
    if !state.is_changed() {
        return;
    }
    for mut text in query.iter_mut() {
        text.sections[1].value = state.display_difficulty().to_string();
    }
}

/// update the framerate label if FPS display is enabled
fn fps_update_system(
    diagnostics: Res<Diagnostics>,
    mut query: Query<&mut Text, With<FpsUi>>,
    state: Res<StaticGameState>,
) {
    if !state.show_fps {
        return;
    }

    let fps_average = diagnostics
        .get(FrameTimeDiagnosticsPlugin::FPS)
        .and_then(|diagnostics| diagnostics.average())
        .unwrap_or(0.);

    for mut text in query.iter_mut() {
        text.sections[0].value = format!("{:.1} fps", fps_average);
    }
}

/// update intersections label
fn intersections_update_system(
    mut query: Query<&mut Text, With<IntersectionsUi>>,
    state: Res<DynamicGameState>,
) {
    for mut text in query.iter_mut() {
        text.sections[1].value = state.intersections.to_string();
        text.sections[3].value = state.move_count.to_string();
    }
}

/// enable/disable victory button based on intersection count
fn victory_update_system(
    mut commands: Commands,
    game_ui_materials: Res<GameUiMaterials>,
    victory_parent: Query<Entity, With<UiBottomBar>>,
    query: Query<(Entity, &GameUiButton), With<Button>>,
    dyn_state: Res<DynamicGameState>,
) {
    if dyn_state.intersections == 0 {
        for (_, button) in query.iter() {
            if *button == GameUiButton::Victory {
                return;
            }
        }
        let victory_parent_entity = victory_parent.single();
        insert_victory_button(commands, victory_parent_entity, &game_ui_materials);
    } else {
        for (entity, button) in query.iter() {
            if *button == GameUiButton::Victory {
                commands.entity(entity).despawn_recursive();
            }
        }
    }
}

/// despawn all HUD elements
fn game_ui_cleanup_system(mut commands: Commands, query: Query<Entity, With<GameUi>>) {
    let entity = query.single();
    commands.entity(entity).despawn_recursive();
}

/// switch to AppState::Game
fn respawn_game_system(mut app_state: ResMut<State<AppState>>) {
    app_state
        .replace(AppState::Game)
        .expect("Couldn't switch to new game");
}

/// insert label that shows the current difficulty
fn insert_difficulty_label(parent: &mut ChildBuilder, game_ui_materials: &Res<GameUiMaterials>) {
    let text_style = TextStyle {
        font: game_ui_materials.font.clone(),
        font_size: DEFAULT_FONT_SIZE,
        color: color::GREEN,
    };

    parent
        .spawn_bundle(TextBundle {
            text: Text {
                sections: vec![
                    TextSection {
                        value: "Difficulty: ".to_string(),
                        style: text_style.clone(),
                    },
                    // this segment contains the difficulty number
                    TextSection {
                        value: "".to_string(),
                        style: text_style.clone(),
                    },
                ],
                ..Default::default()
            },
            style: Style {
                position_type: PositionType::Absolute,
                position: Rect {
                    left: Val::Px(5.0),
                    ..Default::default()
                },
                ..Default::default()
            },
            ..Default::default()
        })
        .insert(DifficultyUi);
}

/// insert label that shows the current FPS
fn insert_fps_label(parent: &mut ChildBuilder, game_ui_materials: &Res<GameUiMaterials>) {
    let text_style = TextStyle {
        font: game_ui_materials.font.clone(),
        font_size: DEFAULT_FONT_SIZE,
        color: color::GREEN,
    };

    parent
        .spawn_bundle(TextBundle {
            text: Text {
                sections: vec![
                    // this segment contains the framerate
                    TextSection {
                        value: "".to_string(),
                        style: text_style.clone(),
                    },
                ],
                ..Default::default()
            },
            style: Style {
                position_type: PositionType::Absolute,
                position: Rect {
                    left: Val::Px(250.0),
                    ..Default::default()
                },
                ..Default::default()
            },
            ..Default::default()
        })
        .insert(FpsUi);
}

/// insert button that quits the current level when pressed
fn insert_quit_button(parent: &mut ChildBuilder, game_ui_materials: &Res<GameUiMaterials>) {
    parent
        .spawn_bundle(ButtonBundle {
            style: Style {
                position_type: PositionType::Absolute,
                position: Rect {
                    right: Val::Px(0.),
                    ..Default::default()
                },
                size: Size::new(Val::Px(150.0), Val::Percent(100.)),
                // center button
                margin: Rect::all(Val::Auto),
                // horizontally center child text
                justify_content: JustifyContent::Center,
                // vertically center child text
                align_items: AlignItems::Center,
                ..Default::default()
            },
            color: game_ui_materials.normal_red,
            ..Default::default()
        })
        .with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Quit",
                    TextStyle {
                        font: game_ui_materials.font.clone(),
                        font_size: DEFAULT_FONT_SIZE,
                        color: game_ui_materials.font_color.clone(),
                    },
                    TextAlignment {
                        ..Default::default()
                    },
                ),
                ..Default::default()
            });
        })
        .insert(GameUiButton::QuitPuzzle);
}

/// insert "how to play" overlay in the first level
fn insert_howto(parent: &mut ChildBuilder, game_ui_materials: &Res<GameUiMaterials>) {
    let text_style = TextStyle {
        font: game_ui_materials.font.clone(),
        font_size: DEFAULT_FONT_SIZE,
        color: color::ORANGE,
    };

    parent
        .spawn_bundle(NodeBundle {
            style: Style {
                align_self: AlignSelf::Center,
                ..Default::default()
            },
            color: game_ui_materials.none,
            ..Default::default()
        })
        .with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text {
                    sections: vec![
                        TextSection {
                            value: "Drag & Drop The Birds\n\nRemove All Intersections\n\nVictory Button Appears With Valid Solution \n\nPress Victory Button For Next Level".to_string(),
                            style: text_style.clone(),
                        },
                    ],
                    ..Default::default()
                },
                ..Default::default()
            });
        })
        .insert(HowtoUi);
}

/// insert label that shows intersection count
fn insert_intersections_label(parent: &mut ChildBuilder, game_ui_materials: &Res<GameUiMaterials>) {
    let text_style = TextStyle {
        font: game_ui_materials.font.clone(),
        font_size: DEFAULT_FONT_SIZE,
        color: color::GREEN,
    };

    parent
        .spawn_bundle(TextBundle {
            text: Text {
                sections: vec![
                    TextSection {
                        value: "Intersections: ".to_string(),
                        style: text_style.clone(),
                    },
                    // this segment contains the count
                    TextSection {
                        value: "".to_string(),
                        style: text_style.clone(),
                    },
                    TextSection {
                        value: "    Moves: ".to_string(),
                        style: text_style.clone(),
                    },
                    // this segment contains the count
                    TextSection {
                        value: "".to_string(),
                        style: text_style.clone(),
                    },
                ],
                ..Default::default()
            },
            style: Style {
                position_type: PositionType::Absolute,
                position: Rect {
                    left: Val::Px(5.0),
                    ..Default::default()
                },
                ..Default::default()
            },
            ..Default::default()
        })
        .insert(IntersectionsUi);
}

/// insert button that advances you to the next level
fn insert_victory_button(
    mut commands: Commands,
    parent_ui_entity: Entity,
    game_ui_materials: &Res<GameUiMaterials>,
) {
    commands
        .spawn_bundle(ButtonBundle {
            style: Style {
                //display: Display::None,
                position_type: PositionType::Absolute,
                position: Rect {
                    right: Val::Px(0.),
                    ..Default::default()
                },
                size: Size::new(Val::Px(150.0), Val::Percent(100.)),
                // center button
                margin: Rect::all(Val::Auto),
                // horizontally center child text
                justify_content: JustifyContent::Center,
                // vertically center child text
                align_items: AlignItems::Center,
                ..Default::default()
            },
            color: game_ui_materials.normal_green,
            ..Default::default()
        })
        .with_children(|parent| {
            parent.spawn_bundle(TextBundle {
                text: Text::with_section(
                    "Victory",
                    TextStyle {
                        font: game_ui_materials.font.clone(),
                        font_size: DEFAULT_FONT_SIZE,
                        color: game_ui_materials.font_color.clone(),
                        ..Default::default()
                    },
                    TextAlignment {
                        ..Default::default()
                    },
                ),
                ..Default::default()
            });
        })
        .insert(GameUiButton::Victory)
        .insert(Parent(parent_ui_entity));
}
