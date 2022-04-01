<script>
export default {
  name: "UGameColorPicker",
  props: {
    isTurn: {
      type: Boolean,
      default: false,
    },
  },
};
</script>

<template>
  <div class="color-picker" :style="{ pointerEvents: !isTurn ? 'none' : null }">
    <div class="container">
      <button @click="$emit('pick-color', 0)" class="red"></button>
      <button @click="$emit('pick-color', 1)" class="green"></button>
      <button @click="$emit('pick-color', 2)" class="yellow"></button>
      <button @click="$emit('pick-color', 3)" class="blue"></button>
    </div>
  </div>
</template>

<style lang="scss" scoped>
$table-rotatex: 58deg;

.color-picker {
  width: 100vw;
  height: 100vh;
  position: absolute;
  z-index: 1001;
  display: flex;

  .container {
    $transform: rotateX($table-rotatex) translateY(-60px);
    transform: $transform;
    width: MAX(38vw, 350px);
    height: MAX(MIN(38vw, 75vh), 350px);
    border-radius: 20px;
    margin: auto;
    padding: 20px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 1fr 1fr;
    grid-gap: 10px;
    animation: enlarge 9s ease-in-out infinite;

    @keyframes enlarge {
      from {
        transform: $transform scale(1);
      }

      50% {
        transform: $transform scale(1.1);
      }

      to {
        transform: $transform scale(1);
      }
    }

    button {
      --shadow-color: black;
      opacity: 0.8;
      border-radius: 10px;
      width: 100%;
      height: 100%;
      outline: none;
      box-shadow: 0px 25px 30px 5px var(--shadow-color);
      transition: opacity 0.3s ease, box-shadow 0.3s ease, transform 0.3s ease;

      &:hover {
        box-shadow: 0 35px 40px 10px var(--shadow-color);
        opacity: 0.9;
        transform: scale(1.1);
        z-index: 5;
      }
    }

    .red {
      border-top-left-radius: 100%;
      background-color: #ff171a;
      --shadow-color: #ff000479;
    }

    .green {
      border-top-right-radius: 100%;
      background-color: #41dd2c;
      --shadow-color: #00ff0d79;
    }

    .yellow {
      border-bottom-left-radius: 100%;
      background-color: #ffee00;
      --shadow-color: #ffe60079;
    }

    .blue {
      border-bottom-right-radius: 100%;
      background-color: #00a2ff;
      --shadow-color: #00c3ff79;
    }
  }
}
</style>