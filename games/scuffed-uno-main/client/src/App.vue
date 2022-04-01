<template>
  <div id="app" @click.once="initSoundController">
    <router-view :key="refresh" />

    <div v-if="$store.state.isOffline" class="offline">
      <div class="message">You are currently offline and cannot play.</div>
    </div>

    <div
      v-else-if="!$store.state.isConnected || this.$store.state.reloading"
      class="connecting"
    >
      <div class="loading">
        <card back />
        <card back />
        <card back />
        <card back />
        <card back />
      </div>

      <h1>Connecting to server...</h1>
    </div>

    <div
      v-if="
        $store.state.isMobile &&
        !$store.state.isLandscape &&
        showLandscapeBanner
      "
      class="banner landscape-alert"
    >
      <p>
        It is recommended to play Scuffed Uno in landscape mode for the best
        possible experience.
      </p>
      <button class="close-btn" @click="showLandscapeBanner = false">
        <div></div>
        <div></div>
      </button>
    </div>
  </div>
</template>

<script>
import "@/api/socket";
import Card from "@/components/Card.vue";
import SoundController from "@/api/sound";

export default {
  components: { Card },
  name: "App",
  data() {
    return {
      refresh: false,
      showLandscapeBanner: true,
    };
  },
  computed: {
    room() {
      return this.$store.state.room;
    },
    route() {
      return this.$route.name;
    },
    disconnected() {
      return !this.$store.state.isConnected || this.$store.state.isOffline;
    },
  },
  watch: {
    route(route) {
      switch (route) {
        case "Game":
          if (!this.room.id) this.$router.push({ name: "Home" });
          // if (this.$store.state.isMobile) this.toggleFullScreen(true);
          break;
        case "Home":
          if (this.room.id) {
            this.$store.state.socket.emit("leave-room");
            this.$store.commit("RESET_ROOM");
          }

          // if (this.$store.state.isMobile) this.toggleFullScreen(false);
          break;
        default:
          break;
      }
    },
    disconnected(val) {
      if (val) {
        if (this.$route.name !== "Home") {
          this.$router.push({ name: "Home", query: this.$route.query });
        } else {
          this.refresh = !this.refresh;
        }

        this.$store.state.socket.emit("leave-room");
        this.$store.commit("RESET_ROOM");
      }
    },
  },
  methods: {
    initSoundController() {
      this.$store.commit("SET_SOUND_CONTROLLER", new SoundController());
    },
  },
};
</script>

<style lang="scss">
html,
body {
  overscroll-behavior-y: contain;
}

body {
  width: 100%;
  height: 100vh;
}

#app {
  width: 100%;
  height: 100vh;
  background: radial-gradient(
    circle,
    rgb(192, 34, 26) 0%,
    rgb(146, 25, 19) 60%,
    rgb(109, 16, 11) 100%
  );
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;

  .offline {
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    position: absolute;
    top: 0;
    left: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1010;

    .message {
      font-size: 1.8rem;
      background-color: white;
      border-radius: 10px;
      padding: 2.5rem;
      font-weight: bold;
    }
  }

  .connecting {
    @extend .offline;
    background: radial-gradient(
      circle,
      rgb(192, 34, 26) 0%,
      rgb(146, 25, 19) 60%,
      rgb(109, 16, 11) 100%
    );

    @media screen and (max-width: 900px) {
      .loading * {
        margin-left: -30px !important;

        &:nth-child(1) {
          margin-left: 0 !important;
        }
      }

      h1 {
        margin-top: 37vh !important;
      }
    }

    h1 {
      position: absolute;
      font-weight: bold;
      color: white;
      font-size: 2rem;
      margin-top: 30vh;
    }

    .loading {
      display: flex;

      * {
        margin-left: -60px;
        animation: lift 2s ease-in-out infinite;

        &:nth-child(1) {
          margin-left: 0;
        }

        &:nth-child(2) {
          animation-delay: 0.4s;
        }

        &:nth-child(3) {
          animation-delay: 0.8s;
        }

        &:nth-child(4) {
          animation-delay: 1.2s;
        }

        &:nth-child(5) {
          animation-delay: 1.6s;
        }

        @keyframes lift {
          from {
            transform: translateY(0);
          }

          25% {
            transform: translateY(-25px);
          }

          50%,
          to {
            transform: translateY(0);
          }
        }
      }
    }
  }

  .banner {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100vw;
    height: 8rem;
    display: flex;
    padding: 1rem 5vw;
    align-items: center;
    background-color: rgb(235, 149, 51);
    color: white;
    z-index: 1005;

    p {
      width: calc(100% - 1.5rem);
      font-size: 1.1rem;
      font-weight: bold;
    }

    .close-btn {
      width: 1.5rem;
      height: 1.5rem;
      position: relative;
      outline: none;
      transition: opacity 0.2s ease;

      &:hover {
        opacity: 0.7;
      }

      div {
        width: 100%;
        height: 0.3rem;
        background-color: white;
        border-radius: 0.15rem;
        position: absolute;

        &:nth-of-type(1) {
          transform: rotate(45deg);
        }

        &:nth-of-type(2) {
          transform: rotate(-45deg);
        }
      }
    }
  }
}

.ad {
  position: absolute;
  display: block;

  &::before {
    // content: "Advertisement";
    position: absolute;
    top: -1.5rem;
    width: 100%;
    text-align: center;
    color: white;
    opacity: 0.7;
    font-size: 0.9rem;
  }

  &.ad-top {
    transform: translate(-50%);
    transform-origin: bottom center;
    left: 50%;
    top: 1vh;

    @media screen and (max-width: 740px) {
      display: none;
    }

    &::before {
      top: unset;
      bottom: -1.5rem;
    }
  }

  &.ad-bottom {
    transform: translate(-50%);
    transform-origin: bottom center;
    left: 50%;
    bottom: 1vh;

    @media screen and (max-width: 650px) {
      width: 52vw;
    }

    @media screen and (max-width: 530px) {
      width: 0;
    }
  }

  &.ad-left {
    transform: translateY(-50%) scale(0.9);
    transform-origin: center;
    top: 50%;
    left: 1vh;
    z-index: 1;

    @media screen and (max-width: 730px) {
      display: none;
    }
  }

  &.ad-right {
    transform: translateY(-50%) scale(0.9);
    transform-origin: center;
    top: 50%;
    right: 1vh;
    z-index: 1;

    @media screen and (max-width: 730px) {
      display: none;
    }
  }

  &.ad-hide {
    display: none;
  }
}
</style>
