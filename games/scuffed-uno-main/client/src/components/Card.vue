<script>
export default {
  name: "Card",
  data() {
    return {
      height: 197,
      width: 127,
      bgY: 0,
      bgX: 0,
      rotate: 0,
    };
  },
  props: {
    index: {
      type: Number,
      default: null,
    },
    color: {
      type: Number,
      default: 0,
    },
    number: {
      type: Number,
      default: 0,
    },
    type: {
      type: Number,
      default: 0,
    },
    playable: {
      type: Boolean,
      default: false,
    },
    back: {
      type: Boolean,
      default: false,
    },
    pile: {
      type: Boolean,
      default: false,
    },
    animate: {
      type: Boolean,
      default: false,
    },
    start: {
      type: Object,
      default() {
        return {
          x: 0,
          y: 0,
        };
      },
    },
    dest: {
      type: Object,
      default() {
        return {
          x: 0,
          y: 0,
        };
      },
    },
    transform: {
      type: String,
      default: "",
    },
  },
  computed: {
    windowWidth() {
      return this.$store.state.windowWidth;
    },
  },
  watch: {
    windowWidth(width, oldWidth) {
      if (width <= 900 && oldWidth > 900) {
        this.bgX /= 2;
        this.bgY /= 2;
      } else if (oldWidth <= 900 && width > 900) {
        this.bgX *= 2;
        this.bgY *= 2;
      }
    },
  },
  methods: {
    handleClick(e) {
      if (this.back || this.index === null || !this.playable) return;

      // let user pick color of plus 4 or wildcard
      if (this.type === 4 || this.type === 5) {
        this.$emit("pick-color", this.index);
      }

      const box = e.target.getBoundingClientRect();
      const centerX = window.innerWidth / 2;
      const centerY = window.innerHeight / 2;

      this.$store.commit("ADD_ANIMATE_CARD", {
        type: this.type,
        color: this.color,
        number: this.number,
        player: true,
        steps: 2,
        isTransitionComplete: false,
        start: {
          x: box.x,
          y: box.y,
        },
        dest: {
          x: centerX - box.width / 2 - 5,
          y: centerY - box.height / 2 - 13,
        },
      });

      // this.$refs.card.style.marginLeft = `-${box.width}px`;
      // this.$refs.card.style.opacity = "0";
      this.$refs.card.classList.add("hidden");

      this.$emit("card-played", this.index);
    },
    calculateColor() {
      const gap = 1.85;
      this.bgY = (this.height + gap) * this.color;
    },
    calculateNumber() {
      const number = this.number === 0 ? 10 : this.number;
      this.bgX = (this.width + 1.85) * (number - 1);
    },
    calculateType() {
      const gap = 1.85;

      switch (this.type) {
        case 1:
        case 2:
        case 3:
          this.bgX = (this.width + gap) * (9 + this.type);
          break;
        case 4:
        case 5:
          this.bgY = (this.height + gap) * this.type;
          if (this.color !== 4) {
            this.bgX = this.width + gap;
            switch (this.color) {
              case 0:
                this.bgX *= 2;
                break;
              case 1:
                this.bgX *= 4;
                break;
              case 2:
                this.bgX *= 1;
                break;
              case 3:
                this.bgX *= 3;
                break;
            }
          } else this.bgX = 0;
      }
    },
    calculateRotate() {
      return (this.color + this.type + this.number) * 30;
    },
    findAnimateCardsIndex(id) {
      return this.$store.state.animateCards.findIndex((c) => c.id === id);
    },
  },
  mounted() {
    if (this.back) {
      this.bgY = (this.height + 1.85) * 5;
      this.bgX = (this.width + 1.85) * 5;
    } else {
      this.calculateColor();
      this.calculateNumber();
      this.calculateType();
    }

    if (this.windowWidth <= 900) {
      this.bgX /= 2;
      this.bgY /= 2;
    }

    if (this.pile) {
      this.rotate = this.calculateRotate();
    }

    if (this.animate) {
      this.$refs.card.style.left = `${this.dest.x}px`;
      this.$refs.card.style.top = `${this.dest.y}px`;
      this.$refs.card.style.transform = `translate(${
        this.start.x - this.dest.x
      }px, ${this.start.y - this.dest.y}px) ${this.transform}`;

      window.requestAnimationFrame(() => {
        if (!this.$refs.card) return;

        const card = this.$store.state.animateCards[this.index];
        const id = card.id;

        if (!card.draw)
          this.$refs.card.style.transform = `rotateX(58deg) rotate(${this.calculateRotate()}deg)`;
        else if (card.other)
          this.$refs.card.style.transform = card.endTransform;
        else this.$refs.card.style.transform = "";

        this.$refs.card.ontransitionend = () => {
          const card =
            this.$store.state.animateCards[this.findAnimateCardsIndex(id)];
          if (!card) return;

          card.steps--;
          // console.log(card.steps);
          card.isTransitionComplete = true;

          if (card.steps === 0) {
            if (this.$refs.card) this.$refs.card.ontransitionend = undefined;

            if (card.draw && card.player) {
              document
                .querySelector(
                  `.cards.you :nth-of-type(${card.drawnIndex + 1})`
                )
                .classList.remove("hidden");
            }

            this.$store.commit("REMOVE_ANIMATE_CARD", this.index);
          }
        };

        // if after 200ms card isnt removed then remove it manually (exclude player's cards)
        setTimeout(() => {
          const card =
            this.$store.state.animateCards[this.findAnimateCardsIndex(id)];
          if (card && card.draw && card.player) {
            document
              .querySelector(`.cards.you :nth-of-type(${card.drawnIndex + 1})`)
              .classList.remove("hidden");

            this.$store.commit(
              "REMOVE_ANIMATE_CARD",
              this.findAnimateCardsIndex(id)
            );
          } else if (
            this.$refs.card &&
            this.$refs.card.ontransitionend &&
            !card.player
          ) {
            this.$store.commit(
              "REMOVE_ANIMATE_CARD",
              this.findAnimateCardsIndex(id)
            );
          }
        }, 240);

        // if after 5s player card isnt removed then remove it manually
        if (card.player) {
          setTimeout(() => {
            if (this.$refs.card && this.$refs.card.ontransitionend)
              this.$store.commit(
                "REMOVE_ANIMATE_CARD",
                this.findAnimateCardsIndex(id)
              );
          }, 5000);
        }
      });
    }
  },
};
</script>

<template>
  <div
    ref="card"
    class="card"
    :class="{ playable, animate }"
    :style="{
      backgroundPositionY: -bgY + 'px',
      backgroundPositionX: -bgX + 'px',
      transform: `rotate(${rotate}deg)`,
    }"
    @click="handleClick"
  />
</template>

<style lang="scss" scoped>
.card {
  width: 127px;
  height: 197px;
  background: url("../assets/spritesheet.jpg") no-repeat;
  background-size: 1317%;
  border-radius: 14px;
  box-shadow: 0px 0px 15px 0px #00000073;
  transition: transform 0.3s ease, margin-left 0.4s ease, box-shadow 0.2s ease,
    width 0.2s ease, filter 0.2s ease;
  cursor: pointer;
  pointer-events: none;

  @media screen and (max-width: 900px) {
    width: 63.5px;
    height: 98.5px;
    border-radius: 9px;
  }

  &.animate {
    transition-delay: 0s;
    transition: transform 0.2s linear;
    margin: 0 !important;
    z-index: 1000;
  }

  &.playable {
    transform: translateX(-15px) translateY(-15px) rotate(-4deg) !important;
    animation: pulse infinite 3s ease;
    filter: brightness(1);
    pointer-events: all;

    @keyframes pulse {
      from {
        box-shadow: 0px 0px 2px 1px #ffe23f, inset 0px 0px 2px 2px #ffe448;
      }

      50% {
        box-shadow: 0px 0px 6px 4px #ffe23f, inset 0px 0px 3px 3px #ffe448;
      }

      to {
        box-shadow: 0px 0px 2px 1px #ffe23f, inset 0px 0px 2px 2px #ffe448;
      }
    }

    &:hover {
      animation: none;
    }
  }

  &.noTransition {
    transition: margin-left 0.2s ease, box-shadow 0.2s ease, width 0.2s ease;
  }

  &.hidden {
    opacity: 0;
    margin-left: -127px !important;

    @media screen and (max-width: 900px) {
      margin-left: -63.5px !important;
    }
  }

  &:not(:first-of-type) {
    margin-left: -70px;
  }

  &:hover {
    transform: translateX(-20px) translateY(-55px) !important;
    margin-left: 1px;
    box-shadow: 0px 0px 10px 8px #ffe23f, inset 0px 0px 3px 3px #ffe448;
  }

  &.pile {
    position: absolute;
    margin-left: 0px;

    &:hover {
      margin-left: 0;
      box-shadow: 0px 0px 15px 0px #00000073;
    }
  }
}
</style>