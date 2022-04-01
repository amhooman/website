function format_time_long(ms) {

	var opt_days = "", opt_hours = "";

	if (ms > 86400000) {
		opt_days = Math.floor(ms / 86400000) + "/";
	} if (ms > 3600000) {
		opt_hours = _.padStart("" + Math.floor((ms % 86400000) / 3600000), 2, "0") + ":";
	}

	var minutes = _.padStart("" + Math.floor((ms % 3600000) / 60000), 2, "0") + ":";
	var seconds = _.padStart("" + Math.floor((ms % 60000) / 1000), 2, "0") + '.';
	var cs = _.padStart("" + Math.floor((ms % 1000) / 10), 2, "0");

	return opt_days + opt_hours + minutes + seconds + cs;

}


function interp(x, f_start, f_end) {
	if (x < 0) return f_start;
	if (x > 1) return f_end;
	return f_start * (1-x) + f_end * (x);
}

function clamp(v, start, end) {
	return interp_clamp(v, start, end, start, end);
}

function interp_clamp(v, start, end, f_start, f_end) {
	/*
		a linear function that clamps function return values
		between min and max and then interpolates outputs between
		f_start and f_end.
	*/
	return interp((v - start) / (end - start), f_start, f_end);
}

function interp_ease(v, start, end, f_start, f_end) {
	var x = (v - start) / (end - start);
	x = 1 / (1 + Math.pow(x / (1 - x), -3));
	return interp(x, f_start, f_end);
}

function parabola(v, start, end, base, peak) {
	if (v < start || v > end) return base;
	else {
		var x = (v - start) / (end - start);
		return base + ((peak - base) * (4 * x - 4 * x * x));
	} 
}

function inverse_parabola(v, start, end, base, peak) {
	if (v < start || v > end) return base;
	else {
		var x = (v - start) / (end - start);
		if (x < 0.5) {
			return base + ((peak - base) * Math.pow(x * 2, 4));
		} else {
			return base + ((peak - base) * Math.pow(x * 2 - 2, 4));
		}
	} 
}

function dot_product(a, b) {
	return a.x * b.x + a.y * b.y;
}


function vnorm(v) {
	return norm(v.x, v.y);
}

function norm(dx, dy) {
	return Math.sqrt(dx * dx + dy * dy);
}

function scalar_mult(v, m){
	return { x: v.x * m, y: v.y * m };
}

function dampen(x, a) {
	if (x < 0) return Math.min(0, x + a);
	else if (x > 0) return Math.max(0, x - a);
	return x;
}