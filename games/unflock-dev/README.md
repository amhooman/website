ABOUT
-----

UnFlock implements the excellent [Planarity game](http://www.planarity.net/)
using [Rust](https://rust-lang.org/) and the [Bevy game engine](https://bevyengine.org/).

The goal is to use drag and drop to rearrange a shuffeld graph so that all line intersections are removed.

Play it on [itch.io](https://centralgamingsystem.itch.io/unflock)

<iframe src="https://itch.io/embed/991079?linkback=true&amp;bg_color=0776a0&amp;fg_color=ffffff&amp;link_color=ff8500" width="552" height="167" frameborder="0"><a href="https://centralgamingsystem.itch.io/unflock">UnFlock by Central Gaming System</a></iframe>

ORIGINAL PLANARITY GAME AND PLANAR GRAPHS
-----------------------------------------

* http://johntantalo.com/wiki/Planarity/
* https://en.wikipedia.org/wiki/Planarity
* https://en.wikipedia.org/wiki/Planar_graph

REQUIREMENTS
------------

Any modern browser that supports WebAssembly and WebGl.


LICENSE
-------

The UnFlock sourcecode is licensed under the MIT license (see [LICENSE.txt](LICENSE.txt)).
The UnFlock graphics are licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).

[bevy](https://github.com/bevyengine/bevy/) is licensed under the MIT license.
[bevy_webgl2](https://github.com/mrk-its/bevy_webgl2) is licensed under the MIT license.
[bevy_web_fullscreen](https://github.com/ostwilkens/bevy_web_fullscreen) is licensed under the MIT license.

FiraSans-Bold is licensed under the Open Font License, version 1.1 or later



DOWNLOADING
-----------

The sourcecode can be downloaded from the GitLab repository:

https://gitlab.com/central-gaming-system/unflock


BUILDING
--------

Install the following tools

* rustup
* cargo install cargo-make
* cargo install wasm-bindgen-cli  --version "=0.2.69"

Building for the web

* cargo make build-web

Building for Desktop (only Linux is currently tested)

* NixOS: first run nix-shell in the projet directory
* cargo make build-native

PREVIOUS JAVASCRIPT VERSION
---------------------------

http://github.com/mkroehnert/JSPlanarity
