// graphics

var graphics_loader = new PIXI.loaders.Loader();

graphics_loader

	.add("by", "img/by.png")

	.add("susie_walk0", "img/susie_walk0.png")
	.add("susie_walk1", "img/susie_walk1.png")
	.add("susie_walk2", "img/susie_walk0.png")
	.add("susie_walk3", "img/susie_walk3.png")
	.add("susie_grab", "img/susie_grab.png")
	.add("susie_throw0", "img/susie_throw0.png")
	.add("susie_throw1", "img/susie_throw1.png")
	.add("susie_throw2", "img/susie_throw2.png")
	.add("susie_throw3", "img/susie_throw3.png")
	.add("susie_throw4", "img/susie_throw4.png")

	.add("ralsei_stand", "img/ralsei.png")
	.add("ralsei_throw", "img/ralsei_throw.png")
	.add("ralsei_head", "img/ralsei_head.png")

	.add("kris", "img/kris.png")
	.add("kris_hug", "img/kris_hug.png")

	.add("kround", "img/kround.png")
	.add("kround_kick1", "img/kround_kick1.png")
	.add("kround_kick2", "img/kround_kick2.png")
	.add("kround_kick3", "img/kround_kick3.png")
	.add("kround_kick4", "img/kround_kick4.png")
	.add("kround_kick", "img/kround_kick.png")

	.add("hammer", "img/hammer.png")
	.add("hammer_whack1", "img/hammer_whack1.png")
	.add("hammer_whack2", "img/hammer_whack2.png")
	.add("hammer_whack3", "img/hammer_whack3.png")
	.add("hammer_whack4", "img/hammer_whack4.png")
	.add("hammer_whack5", "img/hammer_whack5.png")
	.add("hammer_whack6", "img/hammer_whack6.png")
	.add("hammer_whack7", "img/hammer_whack7.png")
	.add("hammer_whack8", "img/hammer_whack8.png")
	.add("hammer_whack9", "img/hammer_whack9.png")
	.add("hammer_whack", "img/hammer_whack.png")
	
	.add("lancer_idle1", "img/lancer_idle1.png")
	.add("lancer_idle2", "img/lancer_idle2.png")
	.add("lancer_idle3", "img/lancer_idle3.png")
	.add("lancer_idle4", "img/lancer_idle4.png")
	.add("lancer_idle5", "img/lancer_idle5.png")
	.add("lancer_idle6", "img/lancer_idle6.png")
	.add("lancer_launch1", "img/lancer_launch1.png")
	.add("lancer_launch2", "img/lancer_launch2.png")
	.add("lancer_launch3", "img/lancer_launch3.png")
	.add("lancer_launch4", "img/lancer_launch4.png")
	.add("lancer_launch5", "img/lancer_launch5.png")
	.add("lancer_launch6", "img/lancer_launch6.png")

	.add("letter_a", "img/letters/a.png")
	.add("letter_d", "img/letters/d.png")
	.add("letter_e", "img/letters/e.png")
	.add("letter_h", "img/letters/h.png")
	.add("letter_i", "img/letters/i.png")
	.add("letter_l", "img/letters/l.png")
	.add("letter_n", "img/letters/n.png")
	.add("letter_o", "img/letters/o.png")
	.add("letter_r", "img/letters/r.png")
	.add("letter_s", "img/letters/s.png")
	.add("letter_t", "img/letters/t.png")
	.add("letter_u", "img/letters/u.png")
	.add("letter_w", "img/letters/w.png")

	.add("aim_arrow", "img/aim_arrow.png")
	
	.add("default_background", "img/bg_grid.png")
	.add("default_foreground", "img/fg_grid.png")
	.add("ground", "img/ground.png")

	.on("complete", function(_, resources) {
		process_graphics(resources);
	})

;


function render_pixelated(textures) {
	textures.forEach(texture => {
		texture.texture.baseTexture.scaleMode = PIXI.SCALE_MODES.NEAREST;
	})
}


var loaded_resources;

function process_graphics(resources) {

	loaded_resources = resources;

	tsl_texture = resources["by"];

	susie_walk_textures = [
		resources["susie_walk0"],
		resources["susie_walk1"],
		resources["susie_walk2"],
		resources["susie_walk3"],
	];
	susie_walk_textures.forEach(walk_texture => {
		walk_texture.time = 250; // ms
	})

	susie_grab_texture = resources["susie_grab"];

	susie_throw_textures = [
		resources["susie_throw0"],
		resources["susie_throw1"],
		resources["susie_throw2"],
		resources["susie_throw3"],
		resources["susie_throw4"]
	];
	susie_throw_textures.forEach(throw_texture => {
		throw_texture.time = 75; // ms
	})

	ralsei_stand_texture = resources["ralsei_stand"];
	ralsei_throw_texture = resources["ralsei_throw"];
	ralsei_head_texture = resources["ralsei_head"];

	kris_texture = resources["kris"];
	kris_hug_texture = resources["kris_hug"];

	kround_texture = resources["kround"];
	kround_kick_textures = [
		resources["kround_kick1"],
		resources["kround_kick2"],
		resources["kround_kick3"],
		resources["kround_kick4"],
		resources["kround_kick"]
	];
	kround_kick_textures.forEach(kick_texture => {
		kick_texture.time = 100;
	});

	hammer_texture = resources["hammer"];
	hammer_whack_textures = [
		resources["hammer_whack1"],
		resources["hammer_whack2"],
		resources["hammer_whack3"],
		resources["hammer_whack4"],
		resources["hammer_whack5"],
		resources["hammer_whack6"],
		resources["hammer_whack7"],
		resources["hammer_whack8"],
		resources["hammer_whack9"],
		resources["hammer_whack"]
	];
	hammer_whack_textures.forEach(whack_texture => {
		whack_texture.time = 100;
	});
	hammer_whack_textures[0].time = 200;

	lancer_idle_textures = [
		resources["lancer_idle1"],
		resources["lancer_idle2"],
		resources["lancer_idle3"],
		resources["lancer_idle4"],
		resources["lancer_idle5"],
		resources["lancer_idle6"]
	];
	lancer_idle_textures.forEach(idle_texture => {
		idle_texture.time = 100;
	});

	lancer_launch_textures = [
		resources["lancer_launch1"],
		resources["lancer_launch2"],
		resources["lancer_launch3"],
		resources["lancer_launch4"],
		resources["lancer_launch5"],
		resources["lancer_launch6"]
	];
	lancer_launch_textures.forEach(launch_texture => {
		launch_texture.time = 100;
	});


	aim_arrow_texture = resources["aim_arrow"];

	background_tile_texture = resources["default_background"];
	foreground_tile_texture = resources["default_foreground"];
	ground_texture = resources["ground"];

	render_pixelated([
		tsl_texture,
		susie_grab_texture,
		ralsei_stand_texture,
		ralsei_throw_texture,
		background_tile_texture,
		foreground_tile_texture,
		ralsei_head_texture,
		kris_texture,
		kris_hug_texture,
		kround_texture,
		hammer_texture,
	].concat(susie_walk_textures
	).concat(susie_throw_textures
	).concat(kround_kick_textures
	).concat(hammer_whack_textures
	).concat(lancer_idle_textures
	));
	
	markAssetLoaded("graphics");

}
