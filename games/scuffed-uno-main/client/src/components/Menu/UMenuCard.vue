<script>
export default {
  name: "UMenuCard",
  props: {
    action: {
      type: String,
      default: "Create Room",
    },
    alwaysShowAction: {
      type: Boolean,
      default: false,
    },
    graphic: {
      type: String,
      required: true,
    },
  },
};
</script>

<template>
  <div class="card-container">
    <div class="action-text" :style="{ opacity: alwaysShowAction ? 1 : null }">
      {{ action }}
    </div>
    <div class="gradient"></div>
    <div class="card">
      <img draggable="false" :src="graphic" alt="" class="graphic" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.card-container {
  display: flex;
  justify-content: center;
  height: 492px;
  width: 317px;
  position: relative;
  transform: rotate(6deg) scale(0.9);
  transition: transform 0.5s ease, margin 0.3s ease;
  cursor: pointer;

  &:hover {
    transform: rotate(2deg) scale(1.02);

    .action-text {
      opacity: 1;
    }

    .gradient {
      transform: scale(1.3);
    }
  }
}

.action-text {
  opacity: 0;
  transition: opacity 0.2s ease;
  margin: 0 auto;
  position: absolute;
  z-index: 2;
  top: -68px;
  font-size: 2.5rem;
  font-weight: bold;
  color: black;
  text-shadow: -1px -1px 0 white, 1px -1px 0 white, -1px 1px 0 white,
    1px 1px 0 white;
}

.gradient {
  background: linear-gradient(
    0deg,
    rgba(255, 225, 54, 0) 0%,
    rgba(255, 225, 54, 0.9) 30%,
    rgba(255, 225, 54, 1) 50%,
    rgba(255, 225, 54, 0.9) 70%,
    rgba(255, 225, 54, 0) 100%
  );
  position: absolute;
  width: 100%;
  height: 100%;
  transition: transform 0.1s ease-out;
  filter: brightness(1.3);
}

.card {
  position: absolute;
  height: 100%;
  width: 100%;
  background: black;
  border-radius: 33px;
  border: 20px solid white;
  z-index: 2;
  display: flex;
  justify-content: center;
  align-items: center;

  .graphic {
    display: block;
    width: 100%;
    height: auto;
    padding: 15px;
  }
}
</style>
