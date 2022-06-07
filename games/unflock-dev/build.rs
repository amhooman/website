// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use std::env;

fn main() {
    let target = env::var("TARGET").expect("TARGET was not set");
    if target.contains("wasm32") {
        return;
    }
    if target.contains("linux") {
        if let Ok(_is_nixos) = env::var("IN_NIX_SHELL") {
            println!("cargo:rustc-link-lib=vulkan");
        }
    }
}
