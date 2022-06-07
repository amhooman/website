// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use crate::consts::MINIMUM_GRAPH_COMPLEXITY;

/// store global state of the game that is static during a level
pub struct StaticGameState {
    pub difficulty: u32,
    pub draw_intersections: bool,
    pub show_fps: bool,
}

impl Default for StaticGameState {
    fn default() -> Self {
        Self {
            difficulty: MINIMUM_GRAPH_COMPLEXITY,
            draw_intersections: false,
            show_fps: false,
        }
    }
}

impl StaticGameState {
    pub fn display_difficulty(&self) -> u32 {
        // subtract MINIMUM_GRAPH_COMPLEXITY, so that the easiest graph has difficulty 0
        self.difficulty - MINIMUM_GRAPH_COMPLEXITY
    }
}

#[derive(Default)]
pub struct DynamicGameState {
    pub intersections: u32,
    pub move_count: u32,
}
