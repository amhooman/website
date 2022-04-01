function GroundObject(left, right, top, bottom, object_type) {
	this.left = left;
	this.right = right;
	this.top = top;
	this.bottom = bottom;
	this.hit = false;

	this.doStuffTo = object_type.hit_fn;

	this.cleared = false;

	if (ground_object_sprite_factories[object_type.image] != null) {
		this.sprite = ground_object_sprite_factories[object_type.image]();
		this.sprite.position.set(640, 480);
		this.sprite.anchor.set(object_type.anchor_x, object_type.anchor_y);
		this.sprite.scale.set(2.0, 2.0);
		gameplay_stage.addChild(this.sprite);
	}
}


GroundObject.prototype.interactWith = function(ralsei) {
	if (this.hit) return;
	if (
		this.left < ralsei.pos_x && ralsei.pos_x < this.right &&
		this.bottom < ralsei.pos_y && ralsei.pos_y < this.top
	) {
		this.hit = true;
		this.doStuffTo(ralsei);
	}
}


GroundObject.prototype.cleanup = function() {
	if (this.sprite != null) {
		gameplay_stage.removeChild(this.sprite);
		this.sprite.destroy();
	}
	this.cleared = true;
}


const ground_object_sprite_factories = {
	"lancer": () => {
		var sprite = new PIXI.extras.AnimatedSprite(lancer_idle_textures);
		sprite.play();
		return sprite;
	},
	"kround": () => new PIXI.Sprite(kround_texture.texture),
	"hammer": () => new PIXI.Sprite(hammer_texture.texture),
	"kris": () => new PIXI.Sprite(kris_texture.texture),
}
// set in the load graphics callback


const ground_object_types = [
	{
		// Hits at a 15-degree angle.
		image: "lancer",
		width: 0.5,
		height: 1,
		anchor_x: 0,
		anchor_y: 1.0,
		hit_fn: function (ralsei) {
			ralsei.vel_x = Math.sqrt(ralsei.vel_x * ralsei.vel_x + 300);
			ralsei.vel_y = Math.sqrt(ralsei.vel_y * ralsei.vel_y + 100);
			ralsei.pause_ms = 500;
			gameplay_stage.removeChild(this.sprite);
			gameplay_stage.removeChild(game_scene.ralsei_throw_sprite);
			this.sprite.destroy();
			this.sprite = new PIXI.extras.AnimatedSprite(lancer_launch_textures);
			this.sprite.loop = false;
			this.sprite.anchor.set(0.5, 1.0);
			this.sprite.scale.set(2.0, 2.0);
			gameplay_stage.addChild(this.sprite);
			gameplay_stage.addChild(game_scene.ralsei_throw_sprite);
			this.sprite.play();
		},
	},
	{
		// K.ROUND: Does a powerful kick. Hits at a 45-degree angle.
		image: "kround",
		width: 1,
		height: 1.5,
		anchor_x: 0.9, 
		anchor_y: 1.0,
		hit_fn: function (ralsei) {
			ralsei.vel_x = Math.sqrt(ralsei.vel_x * ralsei.vel_x + 200);
			ralsei.vel_y = Math.sqrt(ralsei.vel_y * ralsei.vel_y + 200);
			ralsei.pause_ms = 300;
			gameplay_stage.removeChild(this.sprite);
			gameplay_stage.removeChild(game_scene.ralsei_throw_sprite);
			this.sprite.destroy();
			this.sprite = new PIXI.extras.AnimatedSprite(kround_kick_textures);
			this.sprite.loop = false;
			this.sprite.anchor.set(0.9, 1.0);
			this.sprite.scale.set(2.0, 2.0);
			setTimeout(se_kick.play.bind(se_kick), 200);
			gameplay_stage.addChild(this.sprite);
			gameplay_stage.addChild(game_scene.ralsei_throw_sprite);
			this.sprite.play();
		},
	},
	{
		// Hammer guy: Smashes you with his hammer. Hits at a 75-degree angle.
		image: "hammer",
		width: 0.5,
		height: 1,
		anchor_x: 0.7,
		anchor_y: 1.0,
		hit_fn: function (ralsei) {
			ralsei.vel_x = Math.sqrt(ralsei.vel_x * ralsei.vel_x + 100);
			ralsei.vel_y = Math.sqrt(ralsei.vel_y * ralsei.vel_y + 300);
			ralsei.pause_ms = 500;
			gameplay_stage.removeChild(this.sprite);
			gameplay_stage.removeChild(game_scene.ralsei_throw_sprite);
			this.sprite.destroy();
			this.sprite = new PIXI.extras.AnimatedSprite(hammer_whack_textures);
			this.sprite.loop = false;
			this.sprite.anchor.set(0.7, 1.0);
			this.sprite.scale.set(2.0, 2.0);
			setTimeout(se_hammer.play.bind(se_hammer), 200);
			gameplay_stage.addChild(this.sprite);
			gameplay_stage.addChild(game_scene.ralsei_throw_sprite);
			this.sprite.play();
		},
	},
	{
		// KRIS: Stops Ralsei's run completely by hugging him.
		image: "kris",
		width: 0.5,
		height: 1,
		anchor_x: 0.5,
		anchor_y: 1.0,
		hit_fn: function (ralsei) {
			ralsei.vel_x = 0;
			ralsei.vel_y = 0;
			ralsei.pos_x = (this.left + this.right) / 2;
			ralsei.pos_y = this.bottom;
			gameplay_stage.removeChild(this.sprite);
			this.sprite.destroy();
			this.sprite = new PIXI.Sprite(kris_hug_texture.texture);
			this.sprite.anchor.set(0.5, 1.0);
			this.sprite.scale.set(2.0, 2.0);
			bgm_battle.stop();
			gameplay_stage.addChild(this.sprite);
			gameplay_stage.removeChild(game_scene.ralsei_throw_sprite);
		}
	}
]

function createNewGroundObject(x) {
	var object_type = ground_object_types[Math.floor(Math.random() * ground_object_types.length)]
	return new GroundObject(
		x - object_type.width / 2, x + object_type.width / 2, object_type.height, 0,
		object_type
	);
}