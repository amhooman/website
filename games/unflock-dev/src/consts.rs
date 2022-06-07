// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt
#![allow(dead_code)]

/// States
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum AppState {
    Menu,
    Game,
    Respawn,
    Options,
    Credits,
    Exit,
}

/// Asset: path to font location
pub const FONT_PATH: &str = "fonts/FiraSans-Bold.ttf";

pub mod sprites {
    /// Asset: path to blue bird vertex sprite location
    pub const BLUE_BIRD_SPRITE_PATH: &str = "sprites/bird-blue-512.png";

    /// Asset: path to orange bird vertex sprite location
    pub const ORANGE_BIRD_SPRITE_PATH: &str = "sprites/bird-orange-512.png";

    /// Asset: path to orange bird vertex sprite location
    pub const RED_BIRD_SPRITE_PATH: &str = "sprites/bird-red-512.png";

    /// Asset: path to orange bird vertex sprite location
    pub const GREEN_BIRD_SPRITE_PATH: &str = "sprites/bird-green-512.png";

    /// Asset: path to logo location
    pub const LOGO_SPRITE_PATH: &str = "sprites/unflock-logo-512.png";
}

/// size of the border in pixels, where no nodes can be dropped
pub const WINDOW_BORDER_SIZE: f32 = GRAPH_VERTEX_SPRITE_SIZE + 5.;

/// size of graph vertices in pixel
pub const GRAPH_VERTEX_SPRITE_SIZE: f32 = 35.;

/// thickness of graph edges in pixel
pub const GRAPH_EDGE_THICKNESS: f32 = 5.0;

/// Z-order value for vertex rendering
pub const GRAPH_VERTEX_Z_ORDER: f32 = 1.;

/// Z-order value for edge rendering
pub const GRAPH_EDGE_Z_ORDER: f32 = 0.;

/// the minimum number of lines required to create useful graph
pub const MINIMUM_GRAPH_COMPLEXITY: u32 = 3;

pub const DEFAULT_FONT_SIZE: f32 = 40.;

/// color palette used in the game
/// https://paletton.com/#uid=72X0u0kw0w0jyC+oRxVy4oIDfjr
pub mod color {
    use bevy::prelude::Color;

    pub const VERY_LIGHT_GRAY: Color = Color::rgb(0.9, 0.9, 0.9);
    pub const LIGHT_GRAY: Color = Color::rgb(0.7, 0.7, 0.7);
    pub const GRAY: Color = Color::rgb(0.35, 0.75, 0.35);
    pub const DARK_GRAY: Color = Color::rgb(0.25, 0.25, 0.25);
    pub const VERY_DARK_GRAY: Color = Color::rgb(0.15, 0.15, 0.15);

    pub const VERY_LIGHT_GREEN: Color = Color::rgb(0.31, 0.792, 0.49);
    pub const LIGHT_GREEN: Color = Color::rgb(0.165, 0.741, 0.38);
    pub const GREEN: Color = Color::rgb(0., 0.725, 0.271);
    pub const DARK_GREEN: Color = Color::rgb(0., 0.561, 0.208);
    pub const VERY_DARK_GREEN: Color = Color::rgb(0., 0.439, 0.165);

    pub const VERY_LIGHT_BLUE: Color = Color::rgb(0.298, 0.604, 0.722);
    pub const LIGHT_BLUE: Color = Color::rgb(0.165, 0.518, 0.651);
    pub const BLUE: Color = Color::rgb(0.027, 0.463, 0.627);
    pub const DARK_BLUE: Color = Color::rgb(0.02, 0.357, 0.486);
    pub const VERY_DARK_BLUE: Color = Color::rgb(0.012, 0.278, 0.38);

    pub const VERY_LIGHT_ORANGE: Color = Color::rgb(1., 0.706, 0.388);
    pub const LIGHT_ORANGE: Color = Color::rgb(1., 0.627, 0.224);
    pub const ORANGE: Color = Color::rgb(1., 0.522, 0.);
    pub const DARK_ORANGE: Color = Color::rgb(0.773, 0.404, 0.);
    pub const VERY_DARK_ORANGE: Color = Color::rgb(0.608, 0.318, 0.);

    pub const VERY_LIGHT_RED: Color = Color::rgb(1., 0.494, 0.388);
    pub const LIGHT_RED: Color = Color::rgb(1., 0.357, 0.224);
    pub const RED: Color = Color::rgb(1., 0.173, 0.);
    pub const DARK_RED: Color = Color::rgb(0.773, 0.133, 0.);
    pub const VERY_DARK_RED: Color = Color::rgb(0.608, 0.106, 0.);
}
