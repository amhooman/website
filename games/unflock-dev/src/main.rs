// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::prelude::*;

mod basic_setup;
mod consts;
mod credits;
mod exit;
mod game_ui;
mod graph;
mod graph_generator;
mod math;
mod menu;
mod options_ui;
mod state;

#[cfg(test)]
mod tests;

#[bevy_main]
fn main() {
    let mut app = App::new();
    app.add_state(consts::AppState::Menu)
        .add_plugin(basic_setup::BasicSetupPlugin)
        .add_plugin(menu::MenuPlugin)
        .add_plugin(options_ui::OptionsPlugin)
        .add_plugin(credits::CreditsPlugin)
        .add_plugin(game_ui::GameUiPlugin)
        .add_plugin(graph::GraphPlugin)
        .add_plugin(exit::ExitPlugin);

    app.run();
}
