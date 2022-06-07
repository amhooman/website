// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::prelude::*;

use rbtag::BuildInfo;

use crate::consts::*;

#[derive(BuildInfo)]
struct VersionInfo;

#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct Credits;
#[derive(Debug, Clone, Eq, PartialEq, Hash, SystemLabel)]
pub struct CreditsExit;

pub(crate) struct CreditsPlugin;
impl Plugin for CreditsPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<CreditsMaterials>()
            .add_system_set(
                SystemSet::on_enter(AppState::Credits).with_system(setup_credits.system()),
            )
            .add_system_set(
                SystemSet::on_update(AppState::Credits)
                    .label(Credits)
                    .with_system(credits_color_system.system())
                    .with_system(button_press_system.system()),
            )
            .add_system_set(
                SystemSet::on_exit(AppState::Credits)
                    .label(CreditsExit)
                    .with_system(close_credits.system()),
            );
    }
}

/// Credits materials
struct CreditsMaterials {
    background: UiColor,
    normal: UiColor,
    hovered: UiColor,
    pressed: UiColor,
    font: Handle<Font>,
    font_color: Color,
}

impl FromWorld for CreditsMaterials {
    fn from_world(world: &mut World) -> Self {
        let world = world.cell();
        let asset_server = world
            .get_resource_mut::<AssetServer>()
            .expect("AssetServer not accessible");

        CreditsMaterials {
            background: color::LIGHT_ORANGE.into(),
            normal: color::LIGHT_BLUE.into(),
            hovered: color::BLUE.into(),
            pressed: color::DARK_BLUE.into(),
            font: asset_server.load(FONT_PATH),
            font_color: color::VERY_DARK_GRAY,
        }
    }
}

#[derive(Component)]
enum CreditsButton {
    Back,
}

impl CreditsButton {
    fn name(&self) -> String {
        match self {
            Self::Back => "Back".to_string(),
        }
    }
}

/// marker for credits ui entity
#[derive(Component)]
struct CreditsUi;

fn setup_credits(mut commands: Commands, credits_materials: Res<CreditsMaterials>) {
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
            color: credits_materials.background,
            ..Default::default()
        })
        .insert(CreditsUi)
        .with_children(|parent| {
            // spawn back button
            parent
                .spawn_bundle(ButtonBundle {
                    style: Style {
                        size: Size::new(Val::Px(450.0), Val::Px(65.0)),
                        margin: Rect::all(Val::Auto),
                        justify_content: JustifyContent::Center,
                        align_items: AlignItems::Center,
                        ..Default::default()
                    },
                    color: credits_materials.normal,
                    ..Default::default()
                })
                .with_children(|parent| {
                    parent.spawn_bundle(TextBundle {
                        text: Text::with_section(
                            CreditsButton::Back.name(),
                            TextStyle {
                                font: credits_materials.font.clone(),
                                font_size: DEFAULT_FONT_SIZE,
                                color: credits_materials.font_color.clone(),
                            },
                            TextAlignment {
                                ..Default::default()
                            },
                        ),
                        ..Default::default()
                    });
                })
                .insert(CreditsButton::Back);
            // spawn the credits text
            parent.spawn_bundle(TextBundle {
                text: Text {
                    sections: vec![
                        TextSection {
                            value: "UnFlock is brought to you by\n\n\nCentral Gaming System\n\nhttps://centralgamingsystem.itch.io/\n\n\nPowered by Rust and Bevy\n\n\nUnFlock Build ".to_string() + VersionInfo {}.get_build_commit(),
                            style: TextStyle {
                                font: credits_materials.font.clone(),
                                font_size: DEFAULT_FONT_SIZE * 0.75,
                                color: credits_materials.font_color.clone(),
                            },
                        },
                    ],
                    alignment: TextAlignment {
                        vertical: VerticalAlign::Top,
                        horizontal: HorizontalAlign::Center,
                    },
                    ..Default::default()
                },
                style: Style {
                    margin: Rect::all(Val::Auto),
                    justify_content: JustifyContent::Center,
                    align_items: AlignItems::Center,
                    ..Default::default()
                },
                ..Default::default()
            });
            // spawn credits title
            parent.spawn_bundle(TextBundle {
                text: Text {
                    sections: vec![
                        TextSection {
                            value: "Credits".to_string(),
                            style: TextStyle {
                                font: credits_materials.font.clone(),
                                font_size: DEFAULT_FONT_SIZE,
                                color: credits_materials.font_color.clone(),
                            },
                        },
                    ],
                    alignment: TextAlignment {
                        vertical: VerticalAlign::Top,
                        horizontal: HorizontalAlign::Center,
                    },
                    ..Default::default()
                },
                style: Style {
                    margin: Rect::all(Val::Auto),
                    justify_content: JustifyContent::Center,
                    align_items: AlignItems::Center,
                    ..Default::default()
                },
                ..Default::default()
            });
        });
}

fn credits_color_system(
    menu_materials: Res<CreditsMaterials>,
    mut query: Query<(&Interaction, &mut UiColor), (Changed<Interaction>, With<Button>)>,
) {
    for (interaction, mut color) in query.iter_mut() {
        match *interaction {
            Interaction::Clicked => {
                *color = menu_materials.pressed;
            }
            Interaction::Hovered => {
                *color = menu_materials.hovered;
            }
            Interaction::None => {
                *color = menu_materials.normal;
            }
        }
    }
}

fn button_press_system(
    query: Query<(&Interaction, &CreditsButton), (Changed<Interaction>, With<Button>)>,
    mut state: ResMut<State<AppState>>,
) {
    for (interaction, button) in query.iter() {
        if *interaction == Interaction::Clicked {
            match button {
                CreditsButton::Back => state
                    .replace(AppState::Menu)
                    .expect("Couldn't switch state to Menu"),
            };
        }
    }
}

fn close_credits(mut commands: Commands, query: Query<Entity, With<CreditsUi>>) {
    let entity = query.single();
    commands.entity(entity).despawn_recursive();
}
