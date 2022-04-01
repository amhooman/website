var splash_stage;
var gameplay_stage;

function Scene() {

	this.scene_state = "splash";
	this.scene_time = 3000;

	/*
		Possible scene states:
		"splash",
		"gameplay"
	*/

};

Scene.prototype.selectScene = function(name, data) {

	this.scene_state = name;
	this.scene_time = 0;

	switch(this.scene_state) {
		case "splash":
			break;
		case "gameplay":
			/* Put the Ralsei tutorial in? */
			break;
	}

}

Scene.prototype.update = function(delta_ms) {

	this.scene_time += delta_ms;

	switch(this.scene_state) {
		case "splash":
			splash_animation.update(delta_ms);
			break;
		case "gameplay":
			if (this.scene_time < 150) {
				gameplay_stage.alpha = interp_clamp(this.scene_time, 0, 100, 0, 1);
			}
			game_scene.update(delta_ms);
			break;
	}

};


var scene = new Scene();
