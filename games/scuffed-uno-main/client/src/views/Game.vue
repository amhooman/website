<script>
import Card from "@/components/Card.vue";
import UMenuModal from "@/components/Menu/UMenuModal.vue";
import UGameOtherCards from "@/components/Game/UGameOtherCards.vue";
import UGameStack from "@/components/Game/UGameStack.vue";
import UGameColorPicker from "@/components/Game/UGameColorPicker.vue";
import UGamePlayerCards from "@/components/Game/UGamePlayerCards.vue";
import UMenuBtn from "@/components/Menu/UMenuBtn.vue";
import USettingsMenu from "../components/USettingsMenu.vue";
import Advert from "../components/Advert.vue";
import Chat from "../components/Chat.vue";
import UGamePickHand from "../components/Game/UGamePickHand.vue";

export default {
  name: "Game",
  components: {
    Card,
    UMenuModal,
    UGameOtherCards,
    UGameStack,
    UGameColorPicker,
    UGamePlayerCards,
    UMenuBtn,
    USettingsMenu,
    Advert,
    Chat,
    UGamePickHand,
  },
  data() {
    return {
      topCardTransform: null,
      pickColor: false,
      wildcardColor: null,
      wildcardIndex: -1,
      drawing: false,
      hasCalledUnoClient: false,
      canDrawClient: true,
      canPlayClient: true,
      showSettings: false,
      turnTimer: null,
      turnTimerInterval: null,
      forcePlayOfDrawnCard: false,
      showKeepCard: false,
      showBluff: false,
      showPickHand: false,
      swapHandAnim: false,
      swap: {
        right: false,
        left: false,
        top: false,
        you: false,
      },
      isPlayAgain: false,
      playerCardTimes: [],
    };
  },
  computed: {
    room() {
      return this.$store.state.room;
    },
    hideTopCard() {
      let hide = false;
      const animateCards = this.$store.state.animateCards;

      const playerCardIndex = animateCards.findIndex(
        (c) => !c.draw && c.player
      );
      if (playerCardIndex !== -1) {
        const card = animateCards[playerCardIndex];
        if (!card.isTransitionComplete && card.steps === 1) {
          hide = true;
        }
      } else if (
        animateCards.findIndex((c) => c.steps !== 0 && !c.draw && c.other) !==
        -1
      ) {
        hide = true;
      }

      return hide;
    },
    pile() {
      let pile;
      const limit = this.$store.state.isMobile ? 5 : 12;

      if (this.room.pile.length > limit) {
        pile = this.room.pile.slice(this.room.pile.length - limit);
      } else {
        pile = this.room.pile;
      }

      return this.hideTopCard ? pile.slice(0, pile.length - 1) : pile;
    },
    playableCardCount() {
      if (!this.room.you.cards) return null;

      const count = this.room.you.cards.reduce(
        (total, c) => total + c.playable,
        0
      );

      return count;
    },
    isTurn() {
      return this.room.turn === this.room.you.id || this.room.you.canJumpIn;
    },
    // currentPlayer() {
    //   for (const p of ["you", "left", "right", "top"]) {
    //     if (this.room[p] && this.room.turn === this.room[p].id)
    //       return this.room[p];
    //   }
    // },
    // isPlayerDrawing() {
    //   let drawing = false;
    //   const animateCards = this.$store.state.animateCards;

    //   const playerCardIndex = animateCards.findIndex((c) => c.draw && c.player);
    //   if (playerCardIndex !== -1) {
    //     const card = animateCards[playerCardIndex];
    //     if (!card.isTransitionComplete && card.steps !== 0) {
    //       drawing = true;
    //     }
    //   }

    //   return drawing;
    // },
    playerCards() {
      return this.room.you.cards;
    },
    animateCards() {
      return this.$store.state.animateCards;
    },
  },
  watch: {
    playableCardCount(count, oldCount) {
      if (
        oldCount === 0 &&
        count === 1 &&
        this.forcePlayOfDrawnCard &&
        this.turnTimer === null
      ) {
        this.forcePlayOfDrawnCard = false;
        this.forcePlay();
      }
    },
    isTurn(val) {
      if (val) {
        this.startPlayersTurn();
      } else {
        this.canDrawClient = false;
        this.canPlayClient = false;

        this.turnTimer = null;
        clearInterval(this.turnTimerInterval);
      }
    },
    playerCards(cards, oldCards) {
      if (!cards) return;

      if (cards.length !== oldCards.length) {
        this.playerCardTimes = [];

        for (let i = 0; i < cards.length; i++) {
          this.playerCardTimes.push(
            performance ? performance.now() : Date.now()
          );
        }
      }

      // player draw card animation
      if (cards.length > oldCards.length) {
        const card = cards[this.room.you.lastDrawnCard];

        window.requestAnimationFrame(() => {
          const cardElement = document.querySelector(
            `.cards.you :nth-of-type(${this.room.you.lastDrawnCard + 1})`
          );

          if (cardElement) {
            cardElement.classList.add("hidden");

            const startBox = document
              .getElementById("stack-top-card")
              .getBoundingClientRect();
            const destBox = cardElement.getBoundingClientRect();

            this.$store.commit("ADD_ANIMATE_CARD", {
              ...card,
              steps: 1,
              draw: true,
              player: true,
              isTransitionComplete: false,
              drawnIndex: this.room.you.lastDrawnCard,
              start: {
                x: startBox.x,
                y: startBox.y,
              },
              dest: {
                x: destBox.x,
                y: destBox.y,
              },
              transform: `rotate(-30deg) rotateY(20deg) rotateX(20deg) scale(${
                this.room.you.canPlay ? 0.8 : 0.6
              })`,
            });
          }
        });
      }
    },
    wildcardColor(color) {
      if (this.pickColor && color !== null) {
        this.$store.state.socket.emit("play-card", this.wildcardIndex, color);
      }

      this.pickColor = false;
      this.wildcardColor = null;
      this.wildcardIndex = -1;
    },
    room(room, oldRoom) {
      if (room.id === "") return this.$router.push({ name: "Home" });

      if (this.isTurn && room.you.canJumpIn && !this.canPlayClient)
        this.startPlayersTurn();

      // console.log(
      //   this.isTurn,
      //   room.you.canJumpIn,
      //   this.canPlayClient,
      //   this.isTurn && room.you.canJumpIn && !this.canPlayClient
      // );

      if (room.you.count === 2 && this.hasCalledUnoClient)
        this.hasCalledUnoClient = false;

      // update check for drawing cards client side
      if (this.drawing) this.drawing = room.you.drawing;

      // remove all animated cards after turn change
      if (room.turn !== oldRoom.turn) {
        if (oldRoom.turn === room.you.id) {
          setTimeout(() => {
            this.$store.state.animateCards.forEach((c, i) => {
              this.$store.commit("REMOVE_ANIMATE_CARD", i);
            });
          }, 1000);
        } else {
          this.$store.state.animateCards.forEach((c, i) => {
            this.$store.commit("REMOVE_ANIMATE_CARD", i);
          });
        }
      }

      // player playing card animation
      const index = this.$store.state.animateCards.findIndex((c) => c.player);
      if (index !== -1 && oldRoom.pile.length !== room.pile.length) {
        const card = this.$store.state.animateCards[index];
        card.steps--;

        if (card.steps === 0) {
          this.$store.commit("REMOVE_ANIMATE_CARD", index);
        }
      }

      // other players playing card animations
      const others = ["right", "top", "left"];
      for (let i = 0; i < others.length; i++) {
        const other = others[i];
        if (!room[other]) continue;

        const card = room.pile[room.pile.length - 1];

        // play card animation
        if (room[other].count < oldRoom[other].count) {
          this.animateOtherPlayCard(other, card, true);
        } else if (room[other].count > oldRoom[other].count) {
          this.animateOtherPlayCard(other, card, false);
        }
      }

      // call uno animation
      const players = ["you", ...others];
      for (let i = 0; i < players.length; i++) {
        const player = players[i];

        if (!room[player]) continue;

        if (room[player].calledUno && !oldRoom[player].calledUno) {
          this.playCallUnoAnimation(player);
        }
      }

      // handle wildcard animation
      if (room.wildcard && room.turn !== room.you.id) {
        let other = "";
        if (room.right && room.right.id === room.turn) other = "right";
        else if (room.left && room.left.id === room.turn) other = "left";
        else other = "top";

        this.animateOtherPlayCard(other, room.wildcard, true);
      }

      if (room.winner && window.innerHeight >= 650) {
        setTimeout(() => {
          window.GameAdsRenew("gameadsbanner");
        }, 600);
      }
    },
  },
  methods: {
    gameadsClicked() {
      window.gameadsClicked();
    },
    animateOtherPlayCard(player, card, toStack) {
      let transform;
      if (player === "right") {
        transform =
          "rotate(15deg) rotateY(50deg) rotateZ(5deg) rotateX(20deg) scale(0.75)";
      } else if (player === "left") {
        transform =
          "rotate(-15deg) rotateY(-50deg) rotateZ(-5deg) rotateX(20deg) scale(0.75)";
      } else {
        transform = "scale(0.6)";
      }

      const cardElement = document.querySelector(
        `.cards.other.${player} :nth-of-type(${Math.ceil(
          Math.random() * this.room[player].count
        )})`
      );
      if (!cardElement) return;

      if (this.swapHandAnim) return;

      if (toStack) {
        const box = cardElement.getBoundingClientRect();
        const centerX = window.innerWidth / 2;
        const centerY = window.innerHeight / 2;

        this.$store.commit("ADD_ANIMATE_CARD", {
          ...card,
          steps: 1,
          other: true,
          isTransitionComplete: false,
          start: {
            x: box.x,
            y: box.y,
          },
          dest: {
            x: centerX - box.width / 2 - 25,
            y: centerY - box.height / 2 - 30,
          },
          transform: transform,
        });
      } else {
        const startBox = document
          .getElementById("stack-top-card")
          .getBoundingClientRect();
        const destBox = cardElement.getBoundingClientRect();

        this.$store.commit("ADD_ANIMATE_CARD", {
          ...card,
          steps: 1,
          draw: true,
          other: true,
          isTransitionComplete: false,
          drawnIndex: this.room.you.lastDrawnCard,
          start: {
            x: startBox.x,
            y: startBox.y,
          },
          dest: {
            x: destBox.x,
            y: destBox.y,
          },
          transform: "rotate(-30deg) rotateY(20deg) rotateX(20deg) scale(0.85)",
          endTransform: transform,
        });
      }
    },
    pickWildcardColor(index) {
      this.pickColor = true;
      this.wildcardIndex = index;
      this.$store.state.socket.emit(
        "play-wildcard",
        this.playerCards[index].type
      );
    },
    pickHand(pos) {
      if (!this.$store.state.room[pos]) return;

      const id = this.$store.state.room[pos].id;
      this.$store.state.socket.emit("pick-hand", id);
      this.showPickHand = false;
    },
    forcePlay() {
      if (!this.canPlayClient || !this.room.you.canPlay || this.turnTimer > 0)
        return;

      if (this.playableCardCount === 0) {
        this.drawCard();
        this.forcePlayOfDrawnCard = true;
        return;
      }

      const cardIndex = this.playerCards.findIndex((c) => c.playable);
      const card = this.playerCards[cardIndex];

      this.showKeepCard = false;

      // click card
      setTimeout(
        () =>
          document
            .querySelector(`.cards.you .card:nth-of-type(${cardIndex + 1})`)
            .click(),
        1000
      );

      // pick color if wildcard
      if (card.type === 4 || card.type === 5) {
        setTimeout(
          () =>
            document
              .querySelector(
                `.color-picker .container button:nth-of-type(${
                  Math.floor(Math.random() * 4) + 1
                })`
              )
              .click(),
          2500
        );
      }
    },
    leaveRoom() {
      this.$store.state.socket.emit("leave-room");
      this.$store.commit("RESET_ROOM");

      // this.$store.state.reloading = true;
      if (this.$route.name !== "Home") this.$router.push({ name: "Home" });
      // window.location.replace("/");
    },
    drawCard() {
      if (
        !this.room.started ||
        !this.isTurn ||
        this.drawing ||
        !this.room.you.canDraw ||
        !this.canDrawClient ||
        this.room.you.mustStack
      )
        return;

      this.$store.state.socket.emit("draw-card");
      this.canDrawClient = false;
      this.drawing = true;
    },
    playCard(index) {
      if (!this.room.you.canPlay || !this.canPlayClient) return;

      this.showKeepCard = false;

      // stop player from drawing or playing while awaiting response from server
      this.canDrawClient = false;
      this.canPlayClient = false;

      this.$store.state.socket.emit("play-card", index);
    },
    callUno() {
      this.$store.state.socket.emit("call-uno");
      this.hasCalledUnoClient = true;
    },
    playCallUnoAnimation(p) {
      let transform = "scale(1) ";
      let anchor = "";
      switch (p) {
        case "you":
          anchor = "bottom";
          transform += "translate(0, -35vh)";
          break;
        case "right":
          anchor = "right";
          transform += "translate(-35vh)";
          break;
        case "top":
          anchor = "top";
          transform += "translate(0, 35vh)";
          break;
        case "left":
          anchor = "left";
          transform += "translate(35vh)";
          break;
        default:
          break;
      }

      this.$nextTick(() => {
        this.$refs.unoAlert.style[anchor] = "4vh";
        setTimeout(() => {
          this.$refs.unoAlert.style.transform = transform;
        }, 20);

        setTimeout(() => {
          this.$refs.unoAlert.style.transform = "";
          setTimeout(() => (this.$refs.unoAlert.style[anchor] = ""), 650);
        }, 900);
      });
    },
    startPlayersTurn() {
      this.canDrawClient = true;
      this.canPlayClient = true;

      // start turn timer if player is not being skipped
      if (this.room.you.canPlay) {
        if (this.turnTimerInterval) {
          clearInterval(this.turnTimerInterval);
        }

        this.turnTimer =
          this.room.you.canJumpIn || this.room.awaitingJumpIn ? 2 : 20;
        this.turnTimerInterval = setInterval(() => {
          if (this.drawing) return;

          this.turnTimer--;

          if (this.turnTimer === 0) {
            this.turnTimer = null;
            clearInterval(this.turnTimerInterval);

            if (this.room.you.canJumpIn || this.room.awaitingJumpIn) return;
            this.forcePlay();
          }
        }, 1000);
      }
    },
    choicePlayCard() {
      setTimeout(() => {
        const card = document.querySelector(
          `.cards.you .card:nth-of-type(${
            this.playerCards.findIndex((c) => c.playable) + 1
          })`
        );
        if (card) card.click();
      }, 600);

      this.showKeepCard = false;
    },
    getPositionFromId(id) {
      if (this.room.right && this.room.right.id === id) {
        return "right";
      } else if (this.room.left && this.room.left.id === id) {
        return "left";
      } else if (this.room.top && this.room.top.id === id) {
        return "top";
      } else if (this.room.you && this.room.you.id === id) {
        return "you";
      }
    },
    playAgain() {
      this.$store.commit("RESET_ROOM");
      this.$store.state.socket.emit("play-again");
      this.isPlayAgain = true;

      this.$router.push({ name: "Home", params: { playAgain: true } });
    },
  },
  mounted() {
    if (!this.room.id) return;

    window.onblur = () => (this.$store.state.animateCards = []);
    window.onfocus = () => (this.$store.state.animateCards = []);

    this.$store.state.socket.on("can-keep-card", () => {
      this.showKeepCard = true;
    });

    this.$store.state.socket.on("can-bluff", () => {
      this.showBluff = true;
    });

    this.$store.state.socket.on("can-pick-hand", () => {
      this.showPickHand = true;
    });

    this.$store.state.socket.on("swap-hand-anim", (pId, sId) => {
      this.swapHandAnim = true;

      const p = this.getPositionFromId(pId);
      const s = this.getPositionFromId(sId);

      this.swap[p] = true;
      this.swap[s] = true;

      setTimeout(() => {
        this.swapHandAnim = false;
        this.swap[p] = false;
        this.swap[s] = false;
      }, 800);
    });

    if (this.isTurn) {
      this.startPlayersTurn();
    }
  },
  beforeDestroy() {
    if (!this.isPlayAgain) this.leaveRoom();
  },
  destroyed() {
    window.onblur = null;
    window.onfocus = null;

    this.$store.state.socket.off("can-keep-card");
    this.$store.state.socket.off("can-bluff");
    this.$store.state.socket.off("can-pick-hand");
    this.$store.state.socket.off("swap-hand-anim");
  },
};
</script>

<template>
  <div class="game">
    <div
      v-if="room.winner"
      class="gameads-container-win"
      @click="gameadsClicked"
    >
      <div id="gameadsbanner"></div>
    </div>

    <chat />

    <advert
      v-if="!room.winner"
      adSlot="8788085732"
      :width="468"
      :height="60"
      :viewWidth="900"
      class="ad-top ad-top-game"
      :class="{ win: room.winner }"
    />

    <advert
      v-if="room.winner"
      adSlot="8062339187"
      :width="336"
      :height="280"
      :viewHeight="810"
      :viewWidth="340"
      class="ad-top-win"
    />

    <!-- <advert
      v-if="room.winner"
      adKey="5bd0055c6997223ceecc4982f220e09a"
      :width="468"
      :height="60"
      :timeout="600"
      class="ad-top ad-top2-win"
    /> -->

    <advert
      v-if="room.winner"
      adSlot="6389670028"
      :width="160"
      :height="600"
      :viewWidth="1180"
      class="ad-left ad-left-win"
    />

    <advert
      v-if="room.winner"
      adSlot="6453249207"
      :width="250"
      :height="250"
      :viewWidth="1350"
      class="ad-right ad-right-win"
    />

    <u-menu-modal
      v-if="room.winner"
      :title="`Congratulations to ${room.winner.username} on winning the game!`"
      hideClose
    >
      <div style="display: flex; gap: 2rem">
        <button class="btn rounded-btn success" @click="playAgain">
          Play Again
        </button>
        <button class="btn rounded-btn" @click="leaveRoom">Main Menu</button>
      </div>
    </u-menu-modal>

    <button class="settings-btn" @click="showSettings = !showSettings"></button>
    <u-settings-menu
      v-if="showSettings"
      title="Settings"
      @close="showSettings = false"
      @exit="leaveRoom"
    />

    <u-game-color-picker
      v-if="pickColor || (room.wildcard && !isTurn)"
      :isTurn="isTurn"
      @pick-color="wildcardColor = $event"
    />

    <u-game-pick-hand
      v-if="showPickHand"
      :isTurn="isTurn"
      @pick-hand="pickHand"
    />

    <u-game-pick-hand
      v-else-if="$store.state.room.right && $store.state.room.right.canPickHand"
      :isTurn="false"
      class="right"
    />

    <u-game-pick-hand
      v-else-if="$store.state.room.left && $store.state.room.left.canPickHand"
      :isTurn="false"
      class="left"
    />

    <u-game-pick-hand
      v-else-if="$store.state.room.top && $store.state.room.top.canPickHand"
      :isTurn="false"
      class="top"
    />

    <img ref="unoAlert" class="uno-alert" src="@/assets/logo.png" alt="" />

    <div class="animation-cards">
      <Card
        v-for="(card, i) in $store.state.animateCards"
        :key="`${i}-animate-${card.color}${card.number}${card.type}`"
        :index="i"
        :color="card.color"
        :number="card.number"
        :type="card.type"
        :start="card.start"
        :dest="card.dest"
        :transform="card.transform"
        :back="card.other && card.draw"
        animate
      />
    </div>

    <div class="pile">
      <Card
        v-for="(card, i) in pile"
        :key="`${i}-pile-${card.color}${card.number}${card.type}`"
        :color="card.color"
        :number="card.number"
        :type="card.type"
        pile
      />
    </div>

    <div class="direction" :class="{ reverse: !room.directionReversed }" />

    <u-game-other-cards :room="room" :swap="swap" />

    <div class="hud">
      <h1 class="stack-count" v-if="room.stack > 0">+{{ room.stack }}</h1>
      <h1
        class="stack-count"
        style="transform: scale(0.7)"
        v-if="room.you.canJumpIn"
      >
        Jump In
      </h1>
      <div
        class="turn-timer"
        v-if="turnTimer !== null && room.you.canPlay && canPlayClient"
      >
        {{ turnTimer }}
      </div>

      <u-game-stack
        :applyDrawClass="
          playableCardCount === 0 &&
          isTurn &&
          canDrawClient &&
          !drawing &&
          room.you.canDraw
        "
        @draw-card="drawCard"
      />

      <div v-if="showKeepCard" class="keep-card-option">
        <u-menu-btn
          class="keep-btn"
          @click="
            $store.state.socket.emit('keep-card');
            showKeepCard = false;
          "
          >Keep Card</u-menu-btn
        >
        <u-menu-btn class="play-btn" @click="choicePlayCard"
          >Play Card</u-menu-btn
        >
      </div>

      <div v-if="showBluff" class="keep-card-option">
        <u-menu-btn
          class="keep-btn"
          @click="
            $store.state.socket.emit('accept-plus4');
            showBluff = false;
          "
          >Accept</u-menu-btn
        >
        <u-menu-btn
          class="play-btn"
          @click="$store.state.socket.emit('challenge-plus4')"
          >Challenge</u-menu-btn
        >
      </div>

      <div
        v-if="room.you"
        class="cards you"
        :class="{
          turn:
            isTurn &&
            room.you.canPlay &&
            canPlayClient &&
            !(room.awaitingJumpIn && !room.you.canJumpIn),
          swap: swap.you,
        }"
        :style="{ '--count': `${room.you.count}` }"
      >
        <Card
          v-for="(card, i) in playerCards"
          :key="`${i}-you-${card.color}${card.number}${card.type}-${playerCardTimes[i]}`"
          :index="i"
          :color="card.color"
          :number="card.number"
          :type="card.type"
          :playable="
            card.playable &&
            (isTurn || room.you.canJumpIn) &&
            !drawing &&
            room.you.canPlay
          "
          @card-played="playCard"
          @pick-color="pickWildcardColor"
        />
      </div>

      <u-game-player-cards :room="room" :is-turn="isTurn" :swap="swap" />

      <button
        v-if="room.isHost && !room.started && room.playerCount > 1"
        class="start-btn rounded-btn"
        @click="$store.state.socket.emit('start-game')"
      >
        Start Game
      </button>

      <img
        v-if="
          room.you &&
          room.you.cards &&
          room.you.cards.length === 2 &&
          isTurn &&
          !room.you.hasCalledUno &&
          !hasCalledUnoClient &&
          playableCardCount !== 0
        "
        src="@/assets/logo.png"
        class="uno-btn"
        @click="callUno"
      />
    </div>
  </div>
</template>

<style lang="scss">
$mobile: 900px;
$table-rotatex: 58deg;

.gameads-container-win {
  position: absolute;
  bottom: 15%;
  transform: translateY(50%);
  z-index: 10000;
}

.game {
  width: 100%;
  height: 100%;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;

  .ad-top-game {
    left: 1vh;
    right: unset;
    transform: translateX(0);
    z-index: 100;

    &.win {
      z-index: 10000;
    }

    @media screen and (max-width: 900px) {
      display: none;
    }
  }

  .ad-top-win {
    top: 1vh;
    z-index: 10000;

    @media screen and (max-height: 810px) {
      display: none;
    }

    @media screen and (max-width: 340px) {
      display: none;
    }
  }

  .ad-top2-win {
    top: calc(8vh + 125px);
    z-index: 10000;

    @media screen and (max-height: 765px) {
      display: none;
    }
  }

  .ad-left-win {
    z-index: 10000;

    @media screen and (max-width: 1180px) {
      display: none;
    }
  }

  .ad-right-win {
    z-index: 10000;

    @media screen and (max-width: 1360px) {
      display: none;
    }
  }
}

.animation-cards {
  * {
    position: absolute;
  }
}

.settings-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  background-image: url("../assets/settings.jpg");
  background-size: 100%;
  height: clamp(60px, 8vw, 100px);
  width: clamp(60px, 8vw, 100px);
  border-radius: 15px;
  cursor: pointer;
  z-index: 10000;
}

.rounded-btn {
  padding: 14px 22px;
  background-color: #ff520d;
  color: #fff;
  border: 2px solid white;
  border-radius: 6px;
  font-size: 1.5rem;
  font-weight: bold;
  transition: background-color 0.2s ease;
  outline: none;

  &:hover {
    background-color: #ff8e0d;
  }

  &.success {
    background-color: #0cb40c;

    &:hover {
      background-color: #1fc91f;
    }
  }
}

.uno-alert {
  position: absolute;
  z-index: 1002;
  height: 35%;
  transform: scale(0);
  transition: transform 0.6s ease;
}

.hud {
  margin-top: auto;
  z-index: 400;

  @media screen and (max-width: $mobile) {
    .top-left-text {
      font-size: 0.8rem !important;

      .btn {
        transform: scale(0.8);
        transform-origin: top left;
      }
    }
  }

  .stack-count {
    font-weight: 800;
    color: white;
    font-size: clamp(3rem, 8vw, 6rem);
    -webkit-text-stroke: black clamp(2px, 0.5vw, 5px);
    text-align: center;
    z-index: 200;
  }

  .turn-timer {
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    bottom: 40px;
    right: 10px;
    background: black;
    width: clamp(5rem, 10vw, 12rem);
    height: clamp(5rem, 10vw, 12rem);
    font-size: clamp(3rem, 8vw, 6rem);
    font-weight: 700;
    border-radius: 50%;
    color: white;
  }

  .start-btn {
    position: absolute;
    top: 20px;
    right: 20px;
  }

  .uno-btn {
    position: absolute;
    bottom: 90px;
    right: 15vw;
    width: 200px;
    cursor: pointer;
    animation: grow 2.5s ease-in-out infinite;
    --start-transform: 1;
    --end-transform: 1.15;

    @keyframes grow {
      from {
        transform: scale(var(--start-transform));
      }

      50% {
        transform: scale(var(--end-transform));
      }

      to {
        transform: scale(--start-transform);
      }
    }

    @media screen and (max-width: $mobile) {
      transform: scale(0.7);
      bottom: 20px;
      --start-transform: 0.7;
      --end-transform: 0.8;
    }
  }

  .keep-card-option {
    display: flex;
    z-index: 50;
    width: 40vw;
    max-width: 50rem;
    position: absolute;
    bottom: 30vh;
    left: 0;
    right: 0;
    margin: 0 auto;

    @media screen and (max-width: $mobile) {
      width: 60vw;

      .keep-btn,
      .play-btn {
        font-size: 1.1rem;
        padding: 0.8rem;
      }
    }

    .keep-btn,
    .play-btn {
      margin: 1rem;
    }

    .play-btn {
      background-color: rgb(41, 173, 15);

      &:hover {
        background-color: rgb(56, 138, 39);
      }
    }
  }
}

.direction {
  display: inline-block;
  position: absolute;
  vertical-align: middle;
  width: 350px;
  height: 350px;
  border: 14px solid transparent;
  border-top-color: #ffffff50;
  border-bottom-color: #ffffff50;
  border-radius: 50%;
  animation: rotate 8s linear infinite;
  transform: scale(1.2) rotateX($table-rotatex);

  @media screen and (max-width: $mobile) {
    transform: scale(0.58) rotateX($table-rotatex);
    animation: rotate-mobile 8s linear infinite;
  }

  &.reverse {
    animation-direction: reverse;

    &::after {
      top: 36px;
      left: 8px;
      transform: rotate(-133deg);
    }

    &::before {
      bottom: 36px;
      right: 8px;
      left: auto;
      transform: rotate(44deg);
    }
  }

  &::after,
  &::before {
    position: absolute;
    content: "";
    width: 0;
    height: 0;
    border: 20px solid transparent;
    border-bottom-color: #ffffff50;
  }

  &::after {
    top: 36px;
    right: 8px;
    transform: rotate(135deg);
  }

  &::before {
    bottom: 36px;
    left: 8px;
    transform: rotate(-45deg);
  }

  @keyframes rotate {
    to {
      transform: scale(1.2) rotateX($table-rotatex) rotate(360deg);
    }
  }

  @keyframes rotate-mobile {
    to {
      transform: scale(0.58) rotateX($table-rotatex) rotate(360deg);
    }
  }
}

.pile {
  width: 300px;
  height: 300px;
  display: flex;
  justify-content: center;
  align-items: center;
  transform: rotateX($table-rotatex);
  position: absolute;

  @media screen and (max-width: $mobile) {
    transform: rotateX($table-rotatex);
  }

  .card {
    position: absolute;
    margin-left: 0 !important;
  }
}

.you {
  .card {
    filter: brightness(0.7);
  }
}

.cards {
  display: flex;
  flex-direction: row;
  margin-bottom: 50px;
  margin-top: auto;

  &.swap {
    .card {
      margin-left: -127px !important;

      @media screen and (max-width: $mobile) {
        margin-left: -63.5px !important;
      }
    }
  }

  &.you {
    transition: transform 0.5s ease, filter 0.5s ease;
    transform-origin: bottom center;
    transform: scale(0.8);
    filter: brightness(0.5);

    &.turn {
      transform: scale(1);
      filter: brightness(1);
    }

    .card {
      margin-left: max(calc(-4.5px * var(--count)), -90px);

      &:first-of-type {
        margin-left: 0 !important;
      }

      @media screen and (max-width: $mobile) {
        margin-left: max(calc(-2.25px * var(--count)), -45px);
      }
    }

    @media screen and (max-width: $mobile) {
      margin-bottom: 30px;
    }
  }
}
</style>
