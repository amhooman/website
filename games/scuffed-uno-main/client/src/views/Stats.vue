<script>
export default {
  name: "Stats",
  components: {},
  data() {
    return {
      stats: {},
      interval: null,
    };
  },
  methods: {
    async updateStats() {
      this.stats = await fetch(
        "https://gist.githubusercontent.com/freddie-nelson/3fbffb9c94575acd9aac4d1c58b8b8d0/raw/scuffed-uno-stats.json"
      )
        .then(async (res) => await res.json())
        .catch((err) => console.log(err));
    },
  },
  beforeMount() {
    this.updateStats();
    this.interval = setInterval(this.updateStats, 60000);
  },
  beforeDestroy() {
    clearInterval(this.interval);
  },
};
</script>

<template>
  <section class="stats">
    <a
      class="watermark"
      href="https://freddienelson.co.uk"
      rel="noopener"
      target="_blank"
    >
      made by <span>Freddie</span>
    </a>

    <router-link class="watermark stats-link" to="/">
      Back to Home
    </router-link>

    <header class="header">
      <img class="logo" src="@/assets/logo.png" alt="Scuffed Uno" />
      <h1 class="title">Stats</h1>
    </header>

    <main>
      <div
        style="
          display: flex;
          justify-content: center;
          gap: 4rem;
          flex-wrap: wrap;
        "
      >
        <div class="online">{{ stats.playersOnline }} Players Online</div>
        <div class="online lobbies">
          {{ stats.lobbiesOnline }} Lobbies Online
        </div>
      </div>

      <p class="stat"><span>Total Visits:</span> {{ stats.totalVisits }}</p>
      <p class="stat">
        <span>Lobbies Created:</span> {{ stats.lobbiesCreated }}
      </p>
      <p class="stat"><span>Games Won:</span> {{ stats.gamesPlayed }}</p>
      <p class="stat"><span>Bots Used:</span> {{ stats.botsUsed }}</p>
      <p class="stat"><span>Unos Called:</span> {{ stats.unosCalled }}</p>
      <p class="stat"><span>Cards Played:</span> {{ stats.cardsPlayed }}</p>
      <p class="stat"><span>Plus 4s Dealt:</span> {{ stats.plus4sDealt }}</p>

      <div class="colors-picked">
        <h2>Plus4/Wildcard Colors</h2>

        <div class="colors" v-if="stats.pickedColors">
          <div class="color red">{{ stats.pickedColors.red }}</div>
          <div class="color blue">{{ stats.pickedColors.blue }}</div>
          <div class="color yellow">{{ stats.pickedColors.yellow }}</div>
          <div class="color green">{{ stats.pickedColors.green }}</div>
        </div>
      </div>
    </main>
  </section>
</template>

<style lang="scss" scoped>
$mobile: 900px;

.watermark {
  color: white;
  opacity: 0.5;
  font-size: clamp(1rem, 2vw, 1.3rem);
  position: absolute;
  bottom: 1.5vh;
  right: 1.1vw;
  font-weight: bold;

  &.stats-link {
    left: 1.1vw;
    right: unset;
    text-decoration: underline;
  }

  span {
    text-decoration: underline;
  }
}

img {
  user-select: none;
  -webkit-user-drag: none;
  -khtml-user-drag: none;
  -moz-user-drag: none;
  -o-user-drag: none;
  user-drag: none;
}

.stats {
  width: 100%;
  height: 100%;
  color: white;
  display: flex;
  flex-direction: column;
  overflow-y: auto;

  .header {
    width: 100%;
    height: MIN(18%, 120px);
    display: flex;
    align-items: center;
    z-index: 1;

    .logo {
      margin-left: 10px;
      width: auto;
      height: 100%;
      user-select: none;
      -webkit-user-drag: none;
      transform: scale(0.9);

      &.back {
        cursor: pointer;
      }
    }

    .title {
      margin-left: clamp(5px, 2vw, 20px);
      font-size: clamp(1.7rem, 4vw, 2.5rem);
      font-weight: bold;
    }
  }

  main {
    margin: 3rem auto;
    display: flex;
    flex-direction: column;

    .online {
      display: flex;
      align-items: center;
      font-weight: bold;
      font-size: 2.5rem;
      position: relative;

      --dot-color: rgb(73, 209, 73);
      --dot-shadow: rgba(73, 209, 73, 0.5);

      &::before {
        content: "";
        position: absolute;
        left: -1.8rem;
        border-radius: 1rem;
        width: 0.9rem;
        height: 0.9rem;
        background-color: var(--dot-color);
        animation: pulse ease-in-out infinite 2.4s;

        @keyframes pulse {
          from {
            box-shadow: 0 0 13px 8px var(--dot-shadow);
          }

          50% {
            box-shadow: 0 0 5px 4px var(--dot-shadow);
          }

          to {
            box-shadow: 0 0 13px 8px var(--dot-shadow);
          }
        }
      }

      &.lobbies {
        --dot-color: rgb(71, 197, 255);
        --dot-shadow: rgba(71, 197, 255, 0.5);
      }
    }

    .stat {
      font-weight: bold;
      font-size: 1.9rem;
      margin: 0 auto;
      text-align: center;
      color: rgb(255, 242, 66);

      span {
        color: white;
        opacity: 0.7;
      }

      &:first-of-type {
        margin-top: 2rem;
      }

      &:last-of-type {
        margin-bottom: 1.5rem;
      }
    }

    .colors-picked {
      display: flex;
      flex-direction: column;
      align-items: center;

      h2 {
        font-weight: bold;
        font-size: 1.9rem;
      }

      .colors {
        display: flex;
        gap: 1.5rem;
        margin-top: 1rem;

        .color {
          width: 6.5rem;
          height: 6.5rem;
          border-radius: 0.6rem;
          display: flex;
          justify-content: center;
          align-items: center;
          font-size: 1.5rem;
          font-weight: bold;
        }

        .red {
          background-color: #ff171a;
        }

        .green {
          background-color: #3fd42c;
        }

        .yellow {
          background-color: #e6c11c;
        }

        .blue {
          background-color: #00a2ff;
        }
      }
    }
  }
}
</style>