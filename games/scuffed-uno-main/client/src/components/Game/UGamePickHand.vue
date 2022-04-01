<script>
export default {
  name: "UGamePickHand",
  props: {
    isTurn: {
      type: Boolean,
      default: false,
    },
  },
};
</script>

<template>
  <div class="hand-picker" :style="{ pointerEvents: !isTurn ? 'none' : null }">
    <button @click="$emit('pick-hand', 'top')" class="triangle top"></button>
    <button @click="$emit('pick-hand', 'left')" class="triangle left"></button>
    <button
      @click="$emit('pick-hand', 'right')"
      class="triangle right"
    ></button>
    <!-- <button @click="$emit('pick-hand', 'you')" class="triangle you"></button> -->
  </div>
</template>

<style lang="scss">
.hand-picker {
  &.right {
    transform: rotate(-90deg);
  }

  &.left {
    transform: rotate(90deg);
  }

  &.top {
    transform: rotate(180deg);
  }
}
</style>

<style lang="scss" scoped>
$table-rotatex: 0deg;

.hand-picker {
  width: 100vw;
  height: 100vh;
  position: absolute;
  z-index: 1001;
  display: flex;

  button {
    --size: 5rem;
    --background: #ffee00;
    --shadow-color: #ffe60079;
    display: block;
    opacity: 0.8;
    outline: none;
    transition: opacity 0.3s ease, box-shadow 0.3s ease, transform 0.3s ease;
    transform: translateY(-1rem) var(--transform);
    position: absolute;
    margin: auto;
    transform-origin: center;

    &:hover {
      opacity: 1;
      z-index: 5;
    }

    &.top {
      grid-column: 1 / span 2;
      top: 25vh;
      right: 0;
      left: 0;
    }

    &.right,
    &.left {
      column-span: 1;
    }

    --dist: 30vw;

    @media screen and (max-width: 1550px) {
      --dist: 25vw;
    }

    @media screen and (max-width: 900px) {
      --size: 2.5rem;

      &.top {
        top: 20vh;
      }
    }

    &.right {
      --transform: rotate(90deg);
      right: var(--dist);
      top: 0;
      bottom: 0;
    }

    &.left {
      --transform: rotate(-90deg);
      left: var(--dist);
      top: 0;
      bottom: 0;
    }
  }
}

.triangle {
  width: 0;
  height: 0;
  border-left: var(--size) solid transparent;
  border-right: var(--size) solid transparent;
  border-bottom: var(--size) solid var(--background);
}
</style>