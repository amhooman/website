// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::prelude::*;

use crate::consts::*;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct Menu;
#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct MenuExit;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
enum MenuLabels {
    MenuColor,
    MenuButtonPress,
}

pub(crate) struct MenuPlugin;
impl Plugin for MenuPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<MenuMaterials>()
            .add_system_set(SystemSet::on_enter(AppState::Menu).with_system(setup_menu.system()))
            .add_system_set(
                SystemSet::on_update(AppState::Menu)
                    .label(Menu)
                    .with_system(menu_color_system.system().label(MenuLabels::MenuColor))
                    .with_system(
                        button_press_system
                            .system()
                            .label(MenuLabels::MenuButtonPress)
                            .after(MenuLabels::MenuColor),
                    ),
            )
            .add_system_set(
                SystemSet::on_exit(AppState::Menu)
                    .label(MenuExit)
                    .with_system(close_menu.system()),
            );
    }
}

/// Menu materials
struct MenuMaterials {
    background: UiColor,
    normal: UiColor,
    hovered: UiColor,
    pressed: UiColor,
    font: Handle<Font>,
    font_color: Color,
}

impl FromWorld for MenuMaterials {
    fn from_world(world: &mut World) -> Self {
        let world = world.cell();
        let asset_server = world
            .get_resource_mut::<AssetServer>()
            .expect("AssetServer not accessible");

        MenuMaterials {
            background: color::LIGHT_BLUE.into(),
            normal: color::LIGHT_ORANGE.into(),
            hovered: color::ORANGE.into(),
            pressed: color::DARK_ORANGE.into(),
            font: asset_server.load(FONT_PATH),
            font_color: color::VERY_DARK_GRAY,
        }
    }
}

#[derive(Component)]
enum MenuButton {
    StartGame,
    Options,
    Credits,
    #[allow(dead_code)]
    ExitGame,
}

impl MenuButton {
    fn name(&self) -> String {
        match self {
            Self::StartGame => "Start Game".to_string(),
            Self::Options => "Options".to_string(),
            Self::Credits => "Credits".to_string(),
            Self::ExitGame => "Exit Game".to_string(),
        }
    }

    fn all() -> Vec<MenuButton> {
        vec![
            #[cfg(not(target_arch = "wasm32"))]
            Self::ExitGame,
            Self::Credits,
            Self::Options,
            Self::StartGame,
        ]
    }
}

/// marker for menu entity
#[derive(Component)]
struct MenuUi;

fn setup_menu(mut commands: Commands, menu_materials: Res<MenuMaterials>) {
    let buttons = MenuButton::all();

    commands.spawn_bundle(UiCameraBundle::default());
    commands
        .spawn_bundle(NodeBundle {
            style: Style {
                size: Size::new(Val::Percent(100.), Val::Percent(100.)),
                display: Display::Flex,
                flex_direction: FlexDirection::Column,
                align_items: AlignItems::FlexStart,
                justify_content: JustifyContent::FlexStart,
                ..Default::default()
            },
            color: menu_materials.background,
            ..Default::default()
        })
        .insert(MenuUi)
        .with_children(|parent| {
            for button in buttons {
                // Spawn a new button
                parent
                    .spawn_bundle(ButtonBundle {
                        style: Style {
                            size: Size::new(Val::Px(350.0), Val::Px(65.0)),
                            margin: Rect::all(Val::Auto),
                            justify_content: JustifyContent::Center,
                            align_items: AlignItems::Center,
                            ..Default::default()
                        },
                        color: menu_materials.normal,
                        ..Default::default()
                    })
                    .with_children(|parent| {
                        parent.spawn_bundle(TextBundle {
                            text: Text::with_section(
                                button.name(),
                                TextStyle {
                                    font: menu_materials.font.clone(),
                                    font_size: DEFAULT_FONT_SIZE,
                                    color: menu_materials.font_color.clone(),
                                },
                                TextAlignment {
                                    ..Default::default()
                                },
                            ),
                            ..Default::default()
                        });
                    })
                    .insert(button);
            }
        });
}

fn close_menu(mut commands: Commands, query: Query<Entity, With<MenuUi>>) {
    let entity = query.single();
    commands.entity(entity).despawn_recursive();
}

fn menu_color_system(
    menu_materials: Res<MenuMaterials>,
    mut query: Query<(&Interaction, &mut UiColor), (Changed<Interaction>, With<Button>)>,
) {
    for (interaction, mut color) in query.iter_mut() {
        match *interaction {
            Interaction::Clicked => {
                *color = menu_materials.pressed.clone();
            }
            Interaction::Hovered => {
                *color = menu_materials.hovered.clone();
            }
            Interaction::None => {
                *color = menu_materials.normal.clone();
            }
        }
    }
}

fn button_press_system(
    query: Query<(&Interaction, &MenuButton), (Changed<Interaction>, With<Button>)>,
    mut state: ResMut<State<AppState>>,
) {
    for (interaction, button) in query.iter() {
        if *interaction == Interaction::Clicked {
            match button {
                MenuButton::StartGame => state
                    .replace(AppState::Game)
                    .expect("Couldn't switch state to Game"),
                MenuButton::Options => state
                    .replace(AppState::Options)
                    .expect("Couldn't switch state to Options"),
                MenuButton::Credits => state
                    .replace(AppState::Credits)
                    .expect("Couldn't switch state to Credits"),
                MenuButton::ExitGame => state
                    .replace(AppState::Exit)
                    .expect("Couldn't switch state to ExitGame"),
            };
        }
    }
}
