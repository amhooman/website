function Ralsei() {

	this.pos_x = 0; // metres
	this.pos_y = 0; // metres above ground

	this.vel_x = 0; // m/s
	this.vel_y = 0;

	this.hp = 100;
	this.reawake_timer = 0;

	this.pause_ms = 0;

}

const gravity = 30;
const elasticity = 0.60;

Ralsei.prototype.bounce = function(delta_ms) {

	this.pos_y = 0;

	this.vel_y = Math.max(0, (-this.vel_y - (gravity * delta_ms / 1000)) * Math.sqrt(elasticity));
	this.vel_x = Math.max(0, this.vel_x * Math.sqrt(elasticity));

}


var pos_y_history = [NaN, NaN, NaN];

Ralsei.prototype.update = function(delta_ms) {

	if (this.pause_ms > 0) {
		this.pause_ms -= delta_ms;
		if (this.pause_ms <= 0) {
			delta_ms = -this.pause_ms;
			this.pause_ms = 0;
		} else {
			return;
		}
	}

	// horizontal velocity is constant until something happens to it
	var dx = this.vel_x * delta_ms / 1000;
	var dy = this.vel_y * delta_ms / 1000 - gravity * (delta_ms * delta_ms / 2000000);

	this.pos_x += dx;
	this.pos_y += dy;

	// peak detection
	/*
	pos_y_history.shift();
	pos_y_history.push(this.pos_y);
	if (pos_y_history[0] < pos_y_history[1] && pos_y_history[1] > pos_y_history[2]) {
		console.log(pos_y_history[1]);
	}
	*/

	if (this.pos_y <= 0) {
		this.bounce(delta_ms);
	} else {
		this.vel_y = this.vel_y - (gravity * delta_ms / 1000);
	}

}