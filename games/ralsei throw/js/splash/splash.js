function SplashScene() {

	this.tsl_sprite = new PIXI.Sprite(tsl_texture.texture);
	this.tsl_sprite.anchor.set(0.5, 0.5);
	this.tsl_sprite.position.set(320, 240);
	this.tsl_sprite.alpha = 0;

	this.ralsei_sprite = new PIXI.Sprite(ralsei_stand_texture.texture);
	this.ralsei_sprite.anchor.set(0.5, 1.0);
	this.ralsei_sprite.scale.set(2.0, 2.0);
	this.ralsei_sprite.position.set(336, 400);
	this.ralsei_sprite.alpha = 0;

	this.ralsei_throw_sprite = new PIXI.Sprite(ralsei_throw_texture.texture);
	this.ralsei_throw_sprite.anchor.set(0.5, 0.5);
	this.ralsei_throw_sprite.scale.set(2.0, 2.0);
	this.ralsei_throw_sprite.position.set(336, 368);
	this.ralsei_throw_sprite.alpha = 1;

	this.susie_walk_sprite = new PIXI.extras.AnimatedSprite(susie_walk_textures);
	this.susie_walk_sprite.anchor.set(0.5, 1.0);
	this.susie_walk_sprite.scale.set(2.0, 2.0);
	this.susie_walk_sprite.position.set(-32, 400);
	this.susie_walk_sprite.alpha = 1;

	this.susie_grab_sprite = new PIXI.Sprite(susie_grab_texture.texture);
	this.susie_grab_sprite.anchor.set(0.5, 1.0);
	this.susie_grab_sprite.scale.set(2.0, 2.0);
	this.susie_grab_sprite.position.set(320, 400);

	this.susie_throw_sprite = new PIXI.extras.AnimatedSprite(susie_throw_textures);
	this.susie_throw_sprite.loop = false;
	this.susie_throw_sprite.anchor.set(0.5, 1.0);
	this.susie_throw_sprite.scale.set(2.0, 2.0);
	this.susie_throw_sprite.position.set(304, 400);
	this.susie_throw_sprite.alpha = 1;

	
	splash_stage.addChild(this.tsl_sprite);
	splash_stage.addChild(this.ralsei_sprite);
	splash_stage.addChild(this.susie_walk_sprite);

	letters.map(letter => {
		var sprite = new PIXI.Sprite(loaded_resources[letter.texture].texture);
		sprite.anchor.set(0.5, 1.0);
		sprite.scale.set(1.0, 1.0);
		sprite.position.set(letter.x + 1000, letter.y);
		splash_stage.addChild(sprite);
		letter.sprite = sprite;
	})

	this.flash_g = new PIXI.Graphics();
	this.flash_g.beginFill(0xffffff);
	this.flash_g.drawRect(0, 0, 640, 480);
	this.flash_g.alpha = 0;

	splash_stage.addChild(this.flash_g);

	this.press_start_text = new PIXI.extras.BitmapText("Press Z or C to start!", {font: "18px Undertale"});
	this.press_start_text.position.set(320, 50);
	this.press_start_text.anchor.set(0.5, 1);
	this.press_start_text.alpha = 0;

	splash_stage.addChild(this.press_start_text);

	// scene state
	this.ralsei_impact = false;
	this.outro = false;
	this.outro_time = 0;

}

SplashScene.prototype.update = function(delta_ms) {

	// animation steps

	if (this.outro == true) {
		this.outro_time += delta_ms;
		Howler.ctx.resume();
		splash_stage.alpha = interp_clamp(this.outro_time, 0, 1000, 1, 0);
		if (this.outro_time >= 1000) {
			scene.selectScene("gameplay");
		}
	}

	if (scene.scene_time < 600) { // fade "presented by" in
		this.tsl_sprite.alpha = interp_clamp(scene.scene_time, 0, 600, 0, 1);
	} else if (scene.scene_time < 2400) {
		this.tsl_sprite.alpha = 1;
	} else if (scene.scene_time < 3000) { // fade "presented by" out
		this.tsl_sprite.alpha = interp_clamp(scene.scene_time, 2400, 3000, 1, 0);
	} else if (scene.scene_time < 3600) { // Susie runs in with Asri--I mean Ralsei
		this.tsl_sprite.alpha = 0;
		this.ralsei_sprite.alpha = interp_clamp(scene.scene_time, 3000, 3600, 0, 1);
	} else if (scene.scene_time < 6000) { // Susie walks over
		this.susie_walk_sprite.play();
		this.susie_walk_sprite.position.set(
			interp_clamp(scene.scene_time, 3600, 6000, -32, 304),
			400,
		);
	} else if (scene.scene_time < 7500) { // Susie stops walking.
		this.susie_walk_sprite.gotoAndStop(0);
	} else if (scene.scene_time < 9000) { // Susie grabs Ralsei!
		splash_stage.removeChild(this.susie_walk_sprite);
		splash_stage.removeChild(this.ralsei_sprite);
		splash_stage.addChild(this.susie_grab_sprite);
	} else if (scene.scene_time < 10000) { // Susie throws Ralsei!
		splash_stage.removeChild(this.susie_grab_sprite);
		splash_stage.addChild(this.susie_throw_sprite);
		splash_stage.addChild(this.ralsei_throw_sprite);
		this.susie_throw_sprite.play();
		this.ralsei_throw_sprite.position.set(
			interp_clamp(scene.scene_time, 9000, 10000, 336, 1536),
			parabola(scene.scene_time, 9000, 13000, 368, -900),
		);
		this.ralsei_throw_sprite.rotation = (scene.scene_time - 9000) * Math.PI / 50;
	} else if (scene.scene_time < 12500) { // The "camera pans" to the right, where "undertale throw asriel" comes into view
		var camera_distance = interp_ease(scene.scene_time, 10000, 11500, 0, 1000);
		this.susie_throw_sprite.position.set(304 - camera_distance, 400);
		this.ralsei_throw_sprite.rotation = (scene.scene_time - 12500) * Math.PI / 50;
		this.ralsei_throw_sprite.position.set(
			interp_clamp(scene.scene_time, 11500, 12500, -864, 336),
			parabola(scene.scene_time, 8500, 12500, 368, -900),
		);
		letters.forEach(letter => {
			letter.sprite.position.set(letter.x + 1000 - camera_distance, letter.y);
		})
	} else if (scene.scene_time < 15500) {
		document.getElementById("throw-asriel").innerText = "Ralsei Hwrot";
		splash_stage.removeChild(this.ralsei_throw_sprite);
		this.flash_g.alpha = interp_clamp(scene.scene_time, 12500, 13000, 1, 0);
		letters.forEach(letter => {
			letter.sprite.position.set.apply(letter.sprite.position, letter.bounce_fn(scene.scene_time - 12500));
		})
	} else {
		splash_stage.addChild(this.susie_walk_sprite);
		splash_stage.addChild(this.ralsei_sprite);
		this.ralsei_sprite.position.set(interp_clamp(scene.scene_time, 15500, 16000, 680, 560), 400);
		this.susie_walk_sprite.position.set(interp_clamp(scene.scene_time, 15500, 16000, -40, 80), 400);
		letters.forEach(letter => {
			letter.sprite.position.set.apply(letter.sprite.position, letter.bounce_fn(scene.scene_time - 12500));
		})
		this.press_start_text.alpha = Math.round(Math.sin(2 * Math.PI * scene.scene_time / 1000) + 0.2);
	}

}

var splash_animation;
