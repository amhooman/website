// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use bevy::app::AppExit;
use bevy::prelude::*;

use crate::consts::*;

pub(crate) struct ExitPlugin;
impl Plugin for ExitPlugin {
    fn build(&self, app: &mut App) {
        app.add_system(bevy::input::system::exit_on_esc_system.system())
            .add_system_set(SystemSet::on_enter(AppState::Exit).with_system(exit_system.system()));
    }
}

fn exit_system(mut exit: EventWriter<AppExit>, mut state: ResMut<State<AppState>>) {
    if !cfg!(target_arch = "wasm32") {
        exit.send(AppExit);
    } else {
        state
            .replace(AppState::Menu)
            .expect("Couldn't switch state to Menu");
    }
}
