// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::prelude::*;

use crate::{consts::*, state::StaticGameState};

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct Options;
#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct OptionsExit;

pub(crate) struct OptionsPlugin;
impl Plugin for OptionsPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<OptionsMaterials>()
            .add_system_set(
                SystemSet::on_enter(AppState::Options).with_system(setup_options.system()),
            )
            .add_system_set(
                SystemSet::on_update(AppState::Options)
                    .label(Options)
                    .with_system(options_color_system.system())
                    .with_system(options_button_press_system.system())
                    .with_system(options_update_button_text.system()),
            )
            .add_system_set(
                SystemSet::on_exit(AppState::Options)
                    .label(OptionsExit)
                    .with_system(close_options.system()),
            );
    }
}

struct ButtonMaterials {
    normal: UiColor,
    hovered: UiColor,
    clicked: UiColor,
}

impl ButtonMaterials {
    fn get_material_for(&self, interaction: Interaction) -> UiColor {
        match interaction {
            Interaction::None => self.normal.clone(),
            Interaction::Hovered => self.hovered.clone(),
            Interaction::Clicked => self.clicked.clone(),
        }
    }
}

/// options materials
struct OptionsMaterials {
    background: UiColor,
    regular: ButtonMaterials,
    enabled: ButtonMaterials,
    disabled: ButtonMaterials,
    font: Handle<Font>,
    font_color: Color,
}

impl FromWorld for OptionsMaterials {
    fn from_world(world: &mut World) -> Self {
        let world = world.cell();
        let asset_server = world
            .get_resource_mut::<AssetServer>()
            .expect("AssetServer not accessible");

        OptionsMaterials {
            background: color::LIGHT_ORANGE.into(),
            regular: ButtonMaterials {
                normal: color::LIGHT_BLUE.into(),
                hovered: color::BLUE.into(),
                clicked: color::DARK_BLUE.into(),
            },
            enabled: ButtonMaterials {
                normal: color::LIGHT_GREEN.into(),
                hovered: color::GREEN.into(),
                clicked: color::DARK_GREEN.into(),
            },
            disabled: ButtonMaterials {
                normal: color::LIGHT_RED.into(),
                hovered: color::RED.into(),
                clicked: color::DARK_RED.into(),
            },
            font: asset_server.load(FONT_PATH),
            font_color: color::VERY_DARK_GRAY,
        }
    }
}

impl OptionsMaterials {
    fn get_button_material(
        &self,
        button: &OptionsButton,
        enabled: bool,
        interaction: Interaction,
    ) -> UiColor {
        if button.is_toggle() {
            if enabled {
                self.enabled.get_material_for(interaction).clone()
            } else {
                self.disabled.get_material_for(interaction).clone()
            }
        } else {
            self.regular.get_material_for(interaction).clone()
        }
    }
}

#[derive(Component)]
enum OptionsButton {
    ShowIntersections,
    ShowFps,
    Difficulty,
    Back,
}

impl OptionsButton {
    fn name_with_state(&self, static_state: &Res<StaticGameState>) -> String {
        match self {
            Self::ShowIntersections => {
                format!(
                    "Show Intersections ({})",
                    if static_state.draw_intersections {
                        "on"
                    } else {
                        "off"
                    }
                )
            }
            Self::ShowFps => format!(
                "Show FPS ({})",
                if static_state.show_fps { "on" } else { "off" }
            ),
            Self::Difficulty => {
                format!(
                    "Increase Difficulty ({})",
                    static_state.display_difficulty()
                )
            }
            Self::Back => "Back".to_string(),
        }
    }

    /// returns true, if the option is on/off
    fn is_toggle(&self) -> bool {
        match self {
            Self::ShowIntersections => true,
            Self::ShowFps => true,
            _ => false,
        }
    }

    fn get_state_as_bool(&self, static_state: &Res<StaticGameState>) -> bool {
        match self {
            Self::ShowIntersections => static_state.draw_intersections,
            Self::ShowFps => static_state.show_fps,
            Self::Difficulty => static_state.display_difficulty() == 0,
            Self::Back => false,
        }
    }

    /// return list of buttons
    fn all() -> Vec<OptionsButton> {
        vec![
            Self::ShowIntersections,
            Self::ShowFps,
            Self::Difficulty,
            Self::Back,
        ]
    }
}

/// marker for options entity
#[derive(Component)]
struct OptionsUi;

/// marker for button text
#[derive(Component)]
struct OptionsButtonText;

fn setup_options(
    mut commands: Commands,
    options_materials: Res<OptionsMaterials>,
    static_state: Res<StaticGameState>,
) {
    let buttons = OptionsButton::all();

    commands.spawn_bundle(UiCameraBundle::default());
    commands
        .spawn_bundle(NodeBundle {
            style: Style {
                size: Size::new(Val::Percent(100.), Val::Percent(100.)),
                display: Display::Flex,
                flex_direction: FlexDirection::ColumnReverse,
                align_items: AlignItems::FlexStart,
                justify_content: JustifyContent::FlexStart,
                ..Default::default()
            },
            color: options_materials.background,
            ..Default::default()
        })
        .insert(OptionsUi)
        .with_children(|parent| {
            for button in buttons {
                let button_material = options_materials.get_button_material(
                    &button,
                    button.get_state_as_bool(&static_state),
                    Interaction::None,
                );
                // Spawn a new button
                parent
                    .spawn_bundle(ButtonBundle {
                        style: Style {
                            size: Size::new(Val::Px(500.0), Val::Px(65.0)),
                            margin: Rect::all(Val::Auto),
                            justify_content: JustifyContent::Center,
                            align_items: AlignItems::Center,
                            ..Default::default()
                        },
                        color: button_material,
                        ..Default::default()
                    })
                    .with_children(|parent| {
                        parent
                            .spawn_bundle(TextBundle {
                                text: Text::with_section(
                                    button.name_with_state(&static_state),
                                    TextStyle {
                                        font: options_materials.font.clone(),
                                        font_size: DEFAULT_FONT_SIZE,
                                        color: options_materials.font_color.clone(),
                                    },
                                    TextAlignment {
                                        ..Default::default()
                                    },
                                ),
                                ..Default::default()
                            })
                            .insert(OptionsButtonText);
                    })
                    .insert(button);
            }
        });
}

fn options_color_system(
    options_materials: Res<OptionsMaterials>,
    static_state: Res<StaticGameState>,
    mut query: Query<
        (&Interaction, &OptionsButton, &mut UiColor),
        (Changed<Interaction>, With<Button>),
    >,
) {
    for (interaction, button, mut color) in query.iter_mut() {
        *color = options_materials.get_button_material(
            button,
            button.get_state_as_bool(&static_state),
            *interaction,
        );
    }
}

fn options_button_press_system(
    query: Query<(&Interaction, &OptionsButton), (Changed<Interaction>, With<Button>)>,
    mut static_state: ResMut<StaticGameState>,
    mut state: ResMut<State<AppState>>,
) {
    for (interaction, button) in query.iter() {
        if *interaction == Interaction::Clicked {
            match *button {
                OptionsButton::ShowIntersections => {
                    static_state.draw_intersections = !static_state.draw_intersections;
                }
                OptionsButton::ShowFps => {
                    static_state.show_fps = !static_state.show_fps;
                }
                OptionsButton::Difficulty => {
                    static_state.difficulty += 1;
                }
                OptionsButton::Back => state
                    .replace(AppState::Menu)
                    .expect("Couldn't switch state to Menu"),
            };
        }
    }
}

fn options_update_button_text(
    buttons: Query<(&OptionsButton, &Children), With<Button>>,
    mut button_texts: Query<&mut Text, With<OptionsButtonText>>,
    static_state: Res<StaticGameState>,
) {
    for (button, children) in buttons.iter() {
        for &child in children.iter() {
            let mut text = button_texts.get_mut(child).expect("button must have text");
            text.sections[0].value = button.name_with_state(&static_state);
        }
    }
}

fn close_options(mut commands: Commands, query: Query<Entity, With<OptionsUi>>) {
    let entity = query.single();
    commands.entity(entity).despawn_recursive();
}
