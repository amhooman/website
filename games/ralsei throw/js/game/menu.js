var menu;

function Menu() {

	this.shown = false;
	this.shown_done = false;

}

Menu.prototype.update = function(delta_ms) {

	if (!this.shown || this.shown_done) return;

}
