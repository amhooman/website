var sounds_loaded = {
	1: false,
	101: false,
	102: false,
	103: false,
	104: false,
	105: false,
}

// sounds that need to load before starting the game

function reg_sound(n) {
	return function() {
		sounds_loaded[n] = true;
		for (var i in sounds_loaded) {
			if (sounds_loaded[i] == false) return;
		}
		markAssetLoaded("sounds");
	}
}

// define sound names here. Maybe make a manifest for them later.


var bgm_battle = new Howl({
	onload: reg_sound(1),
	src: "audio/battle.ogg",
	loop: true,
	volume: 0.5,
});


var se_throw = new Howl({
	onload: reg_sound(101),
	src: "audio/snd_heavyswing.wav",
	loop: false,
	volume: 0.7,
});

var se_attack = new Howl({
	onload: reg_sound(102),
	src: "audio/snd_hit.wav",
	loop: false,
	volume: 0.7,
});

var se_kick = new Howl({
	onload: reg_sound(103),
	src: "audio/snd_smallswing.wav",
	loop: false,
	volume: 0.7,
});

var se_replay = new Howl({
	onload: reg_sound(104),
	src: "audio/replay.wav",
	loop: false,
	volume: 0.7,
});

var se_hammer = new Howl({
	onload: reg_sound(105),
	src: "audio/snd_squeaky.wav",
	loop: false,
	volume: 0.7,
});