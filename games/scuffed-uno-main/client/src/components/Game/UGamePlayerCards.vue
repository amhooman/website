<script>
export default {
  name: "UGamePlayerCards",
  props: {
    room: {
      type: Object,
      default() {
        return {
          right: {},
          left: {},
          top: {},
          you: {},
        };
      },
    },
    isTurn: Boolean,
    swap: {
      type: Object,
      default() {
        return {};
      },
    },
  },
};
</script>

<template>
  <div class="player-cards">
    <div
      v-if="room.you && room.started"
      class="player-card you"
      :class="{ playing: isTurn, skip: room.you.skip, swap: swap.you }"
    >
      {{ room.you.username }} : {{ room.you.count }}
    </div>
    <div
      v-if="room.right && room.started"
      class="player-card right"
      :class="{
        playing: room.turn === room.right.id,
        skip: room.right.skip,
        swap: swap.right,
      }"
    >
      {{ room.right.username }} : {{ room.right.count }}
    </div>
    <div
      v-if="room.left && room.started"
      class="player-card left"
      :class="{
        playing: room.turn === room.left.id,
        skip: room.left.skip,
        swap: swap.left,
      }"
    >
      {{ room.left.username }} : {{ room.left.count }}
    </div>
    <div
      v-if="room.top && room.started"
      class="player-card top"
      :class="{
        playing: room.turn === room.top.id,
        skip: room.top.skip,
        swap: swap.top,
      }"
    >
      {{ room.top.username }} : {{ room.top.count }}
    </div>
  </div>
</template>

<style lang="scss" scoped>
$mobile: 900px;

.player-card {
  padding: 12px 22px;
  background-color: white;
  border: 6px solid black;
  border-radius: 8px;
  position: absolute;
  z-index: 100;
  font-weight: bold;
  display: flex;

  @media screen and (max-width: $mobile) {
    transform: scale(0.6);
    transform-origin: center;
  }

  &.playing {
    box-shadow: 0px 0px 8px 7px #fcc81c;
  }

  &.skip {
    animation: skip 2s ease;
    animation-fill-mode: forwards;

    @keyframes skip {
      from {
        box-shadow: 0px 0px 5px 5px #ff0000;
      }

      50% {
        box-shadow: 0px 0px 20px 14px #ff0000;
        color: #a70000;
        border-color: #a70000;
      }

      to {
        box-shadow: 0px 0px 0px 0px #ff0000;
      }
    }
  }

  &.swap {
    animation: swap 2s ease;
    animation-fill-mode: forwards;

    @keyframes swap {
      from {
        box-shadow: 0px 0px 5px 5px #006eff;
      }

      50% {
        box-shadow: 0px 0px 20px 14px #006eff;
        color: #0056a7;
        border-color: #0056a7;
      }

      to {
        box-shadow: 0px 0px 0px 0px #006eff;
      }
    }
  }

  &.right {
    right: 105px;
    bottom: 51%;

    @media screen and (max-width: $mobile) {
      right: 20px;
    }
  }

  &.left {
    left: 105px;
    bottom: 51%;

    @media screen and (max-width: $mobile) {
      left: 10px;
    }
  }

  &.top {
    left: 44%;
    top: 160px;

    @media screen and (max-width: $mobile) {
      left: 40.5%;
      top: 50px;
    }
  }

  &.you {
    left: 45.5%;
    bottom: 15px;
    filter: brightness(0.6);

    @media screen and (max-width: $mobile) {
      bottom: 3px;
    }

    &.playing {
      filter: unset;
    }
  }
}
</style>