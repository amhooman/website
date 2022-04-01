function GameScene() {

	this.reset_time = 0;
	this.reset_done = true;

	this.initializeSprites();

	this.reset();
	
	this.selection_stage = SelectAngle;
	
}

const 
	SelectAngle = 0,
	SelectPower = 1,
	GameStart = 2,
	GameOver = 3,
	Resetting = 4
; // no enums in plain JavaScript T^T 


GameScene.prototype.reset = function() {

	// switch out sprites
	gameplay_stage.addChild(this.susie_grab_sprite);
	gameplay_stage.addChild(this.aim_sprite);
	gameplay_stage.removeChild(this.susie_throw_sprite);
	gameplay_stage.removeChild(this.ralsei_throw_sprite);

	this.ralsei = new Ralsei();
	this.osc_time = 0;

	this.reset_done = true;
	this.game_over_time = 0;

	this.ralsei_angle = 45;
	this.throwing_power = 100;
	this.aim_sprite.scale.set(1, 1);

	this.distance_text.text = "0.00m";

	// the coordinate of the last ground object.
	this.ground_object_cutoff = 10;
	if (this.ground_objects)
		this.ground_objects.forEach(object => { object.cleanup(); })
	this.ground_objects = [];

	this.updateGroundObjects();
	this.repositionSprites();

}


GameScene.prototype.animateReset = function() {
	this.reset_done = false;
	this.reset_time = 0;
	this.selection_stage = Resetting;
}


GameScene.prototype.update = function(delta_ms) {

	this.osc_time += delta_ms;

	switch (this.selection_stage) {
		case SelectAngle: 
			this.ralsei_angle = 45 + 30 * Math.sin(this.osc_time / 500 * Math.PI);
			this.aim_sprite.rotation = -this.ralsei_angle / 180 * Math.PI;
		break;
		case SelectPower:
			this.throwing_power = 100 - 80 * Math.abs(Math.sin(this.osc_time / 500 * Math.PI));
			this.aim_sprite.scale.set(this.throwing_power / 100, 1);
		break;
		case GameStart:
			this.ralsei.update(delta_ms);
			this.updateGroundObjects();
			this.repositionSprites();
			this.distance_text.text = this.ralsei.pos_x.toFixed(2) + "m";
			if (
				Math.abs(this.ralsei.vel_x) < 0.01 &&
				Math.abs(this.ralsei.vel_y) < 0.01
			) {
				this.selection_stage = GameOver;
			}
		break;
		case GameOver:
			this.game_over_time += delta_ms;
			this.retry_text.position.set(
				320,
				interp_clamp(this.game_over_time, 0, 300, 520, 470) +
				parabola(this.game_over_time, 0, 300, 0, -25)
			);
		break;
		case Resetting:
			this.reset_time += delta_ms;
			var rotation = interp_ease(this.reset_time, 0, 1000, 0, Math.PI * 8);
			gameplay_stage.rotation = rotation;
			gameplay_stage.position.set(
				// linear algebra saves the day again!
				320 - 320 * Math.cos(rotation) + 240 * Math.sin(rotation),
				240 - 240 * Math.cos(rotation) - 320 * Math.sin(rotation),
			);
			var scale = parabola(this.reset_time, 0, 1000, 0, 20);
			this.ralsei_head.scale.set(scale, scale);
			if (this.reset_time >= 500 && this.reset_done == false) {
				this.reset();
				this.retry_text.position.set(320, 520);
			} else if (this.reset_time >= 500) {
				this.ralsei_angle = 45 + 30 * Math.sin(this.osc_time / 500 * Math.PI);
				this.aim_sprite.rotation = -this.ralsei_angle / 180 * Math.PI;
			}
			if (this.reset_time >= 1000) {
				gameplay_stage.rotation = 0;
				this.selection_stage = SelectAngle;
			}
		break;
	}

}


GameScene.prototype.repositionSprites = function() {

	const bg_dx = Math.min(-240, -this.ralsei.pos_x * 64);
	const bg_dy = Math.max(160, this.ralsei.pos_y * 64);

	const ralsei_x = Math.min(320, 80 + this.ralsei.pos_x * 64);
	const ralsei_y = Math.max(240, 368 - this.ralsei.pos_y * 64);

	// 1 m = 64 px
	this.susie_throw_sprite.position.set(320 + bg_dx, 240 + bg_dy);

	this.ralsei_throw_sprite.position.set(ralsei_x, ralsei_y);

	if (this.ralsei.pos_y == 0 || this.ralsei.pause_ms > 0) {
		this.ralsei_throw_sprite.rotation = 0;
	} else this.ralsei_throw_sprite.rotation = Math.atan2(
		this.ralsei.vel_x,
		this.ralsei.vel_y,																																																																																																																												  
	) - Math.PI / 2;

	this.default_background.tilePosition.set(bg_dx / 10, bg_dy / 10);
	this.default_foreground.tilePosition.set(bg_dx + 40, bg_dy + 40);

	this.ground.tilePosition.set(bg_dx, 0);
	this.ground.position.set(0, bg_dy + 204);

	this.ground_object_g.clear();
	this.ground_object_g.beginFill(0x007f00);
	this.ground_objects.forEach(object => {
		if (object.sprite) {
			object.sprite.position.set(
				object.left * 64 + bg_dx + 320,
				-object.bottom * 64 + bg_dy + 240,
			);
		} else {
			this.ground_object_g.drawRect(
				object.left * 64 + bg_dx + 320,
				-object.bottom * 64 + bg_dy + 240,
				32,
				64,
			);
		}
	})
	this.ground_object_g.endFill();

}



GameScene.prototype.updateGroundObjects = function() {

	// generate objects up to 200 m in advance
	while (this.ground_object_cutoff < this.ralsei.pos_x + 200) {
		// average of one object every 10 m
		this.ground_object_cutoff += Math.random() * 16 + 2;
		this.ground_objects.push(createNewGroundObject(this.ground_object_cutoff));
	}
	
	// delete the objects more than 10 m behind
	this.ground_objects.forEach(
		object => {
			if (object.right < this.ralsei.pos_x - 10) {
				object.cleanup();
			}
		}
	);
	
	this.ground_objects = this.ground_objects.filter(
		object => object != null && object.cleared == false
	);

	this.ground_objects.forEach(object => {
		object.interactWith(this.ralsei);
	});

}




var max_power = 0.3;

GameScene.prototype.handleInput = function(input) {

	if (input == "C" || input == "A") {
		switch (this.selection_stage) {
			case SelectAngle: 
				this.ralsei_angle = 45 + 30 * Math.sin(this.osc_time / 500 * Math.PI);
				this.osc_time = 0;
				this.selection_stage = SelectPower;
				se_attack.play();
			break;
			case SelectPower:
				this.throwing_power = 100 - 80 * Math.abs(Math.sin(this.osc_time / 500 * Math.PI));
				this.selection_stage = GameStart;
				// switch out sprites
				gameplay_stage.removeChild(this.susie_grab_sprite);
				gameplay_stage.removeChild(this.aim_sprite);
				gameplay_stage.addChild(this.susie_throw_sprite);
				gameplay_stage.addChild(this.ralsei_throw_sprite);
				// start the music
				bgm_battle.play();
				se_throw.play();
				// and we're off!
				this.ralsei.pos_x = 0;
				this.ralsei.pos_y = 0.7;
				this.ralsei.vel_x = max_power * this.throwing_power * Math.cos(this.ralsei_angle / 180 * Math.PI);
				this.ralsei.vel_y = max_power * this.throwing_power * Math.sin(this.ralsei_angle / 180 * Math.PI);
				
				this.susie_throw_sprite.gotoAndPlay(0);
			break;
			case GameStart:
				// possible in-game inputs?
			break;
			case GameOver: 
				this.animateReset();
				// stop the music
				bgm_battle.stop();
				se_replay.play();
			break;
		}
	}

}






GameScene.prototype.initializeSprites = function() {

	this.susie_grab_sprite = new PIXI.Sprite(susie_grab_texture.texture);
	this.susie_grab_sprite.anchor.set(0.5, 1.0);
	this.susie_grab_sprite.scale.set(2.0, 2.0);
	this.susie_grab_sprite.position.set(80, 400);

	this.aim_sprite = new PIXI.Sprite(aim_arrow_texture.texture);
	this.aim_sprite.anchor.set(0, 0.5);
	this.aim_sprite.position.set(80, 360);

	this.susie_throw_sprite = new PIXI.extras.AnimatedSprite(susie_throw_textures);
	this.susie_throw_sprite.loop = false;
	this.susie_throw_sprite.anchor.set(0.5, 1.0);
	this.susie_throw_sprite.scale.set(2.0, 2.0);
	this.susie_throw_sprite.position.set(80, 400);
	
	this.ralsei_throw_sprite = new PIXI.Sprite(ralsei_throw_texture.texture);
	this.ralsei_throw_sprite.anchor.set(0.5, 0.5);
	this.ralsei_throw_sprite.scale.set(2.0, 2.0);
	this.ralsei_throw_sprite.position.set(336, 368);
	
	this.ralsei_head = new PIXI.Sprite(ralsei_head_texture.texture);
	this.ralsei_head.anchor.set(0.5, 0.5);
	this.ralsei_head.scale.set(0, 0);
	this.ralsei_head.position.set(320, 240);

	this.distance_text = new PIXI.extras.BitmapText("0.00m", {font: "18px Undertale"});
	this.distance_text.anchor.set(1.0, 1.0);
	this.distance_text.position.set(625, 40);
	this.distance_text.maxWidth = 180;

	this.default_background = new PIXI.extras.TilingSprite(background_tile_texture.texture);
	this.default_background.anchor.set(0, 0);
	this.default_background.position.set(0, 0);
	this.default_background.width = 640;
	this.default_background.height = 480;
	this.default_background.tileScale.set(2.0, 2.0);

	this.default_foreground = new PIXI.extras.TilingSprite(foreground_tile_texture.texture);
	this.default_foreground.anchor.set(0, 0);
	this.default_foreground.position.set(0, 0);
	this.default_foreground.width = 640;
	this.default_foreground.height = 480;
	this.default_foreground.tileScale.set(2.0, 2.0);

	this.ground = new PIXI.extras.TilingSprite(ground_texture.texture);
	this.ground.anchor.set(0, 0);
	this.ground.position.set(0, 364);
	this.ground.width = 640;
	this.ground.height = 128;

	this.ground_object_g = new PIXI.Graphics();

	this.retry_text = new PIXI.extras.BitmapText("Press Z to retry!", {font: "18px Undertale"});
	this.retry_text.anchor.set(0.5, 1.0);
	this.retry_text.position.set(320, 540);
	this.retry_text.maxWidth = 640;

	gameplay_stage.addChild(this.default_background);
	gameplay_stage.addChild(this.default_foreground);

	gameplay_stage.addChild(this.ground);
	gameplay_stage.addChild(this.ground_object_g);

	gameplay_stage.addChild(this.susie_grab_sprite);
	gameplay_stage.addChild(this.aim_sprite);
	gameplay_stage.addChild(this.distance_text);

	gameplay_stage.addChild(this.retry_text);

	ralsei_overlay.addChild(this.ralsei_head);

}