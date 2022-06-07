# SPDX-License-Identifier: MIT
# UnFlock Authors: see AUTHORS.txt

# run with nix-shell .
# https://github.com/bevyengine/bevy/blob/master/docs/linux_dependencies.md
{ pkgs ? import <nixpkgs> {}
, unstable ? import <nixos-unstable> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.zip
        pkgs.pkgconfig
        pkgs.alsaLib
        pkgs.libudev
        pkgs.vulkan-headers
        pkgs.vulkan-loader
        pkgs.vulkan-tools
        unstable.vulkan-validation-layers
        pkgs.x11
        pkgs.linuxPackages.nvidia_x11
        pkgs.xorg.libXcursor
        pkgs.xorg.libXi
        pkgs.xorg.libXrandr
        #pkgs.nvtop

        # https://blog.thomasheartman.com/posts/bevy-getting-started-on-nixos/
        pkgs.clang
        pkgs.lld

        pkgs.cargo-edit
        pkgs.cargo-update
        pkgs.cargo-outdated
        pkgs.cargo-flamegraph
        pkgs.cargo-fuzz
        pkgs.cargo-release
        #pkgs.cargo-audit

        pkgs.cargo-make
        pkgs.cargo-watch
        pkgs.cargo-bloat

        pkgs.cargo-license
    ];

#    shellHook =
#    ;
#    extraCmds = ''
#    '';
}
