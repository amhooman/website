const musicPlayer = new Audio();
const effectPlayer = new Audio();

const tracksDir = "/sound/tracks";
const effectsDir = "/sound/effects";

const loadAudio = (path) => {
  const audio = document.createElement("audio");
  audio.src = path;
};

export default class SoundController {
  tracks = {
    mainTheme: `${tracksDir}/main-theme.mp3`,
  };

  musicVolume = 0;

  constructor() {
    musicPlayer.volume = this.musicVolume;

    this.playTrack("mainTheme");
  }

  setMusicVolume(volume) {
    if (volume < 0 || volume > 1) return;

    this.musicVolume = volume;
    musicPlayer.volume = volume;
  }

  playTrack(name) {
    musicPlayer.pause();

    if (this.tracks[name]) {
      musicPlayer.src = this.tracks[name];
    } else {
      console.log("Track does not exist: " + name);
    }

    musicPlayer.play();
  }
}
