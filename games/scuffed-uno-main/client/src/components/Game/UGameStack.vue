<script>
import Card from "@/components/Card.vue";

export default {
  name: "UGameStack",
  components: {
    Card,
  },
  props: {
    applyDrawClass: Boolean,
  },
};
</script>

<template>
  <div class="stack" @click="$emit('draw-card')">
    <Card back />
    <Card back />
    <Card back />
    <Card back />
    <Card back />
    <Card back />
    <Card
      back
      :class="{
        draw: applyDrawClass,
      }"
    />
    <Card id="stack-top-card" back />
  </div>
</template>

<style lang="scss" scoped>
$mobile: 900px;

.stack {
  position: absolute;
  left: 60px;
  bottom: 29vh;
  cursor: pointer;

  @media screen and (max-width: $mobile) {
    transform-origin: bottom left;
    margin-left: -30px;
    margin-bottom: -10px;

    .card:not(:first-of-type) {
      margin-top: -98.5px !important;
    }
  }

  &.canDraw {
    box-shadow: 0px 0px 14px 14px #ffe23f, inset 0px 0px 3px 3px #ffe448;
  }

  .card {
    pointer-events: none;
    transform: rotate(-30deg) rotateY(20deg) rotateX(20deg) scale(0.85) !important;
    cursor: pointer;

    &.draw {
      animation: pulse infinite 3s ease;

      @keyframes pulse {
        from {
          box-shadow: 0px 0px 5px 4px #ffe23f, inset 0px 0px 3px 3px #ffe448;
        }

        50% {
          box-shadow: 0px 0px 14px 14px #ffe23f, inset 0px 0px 3px 3px #ffe448;
        }

        to {
          box-shadow: 0px 0px 3px 2px #ffe23f, inset 0px 0px 3px 3px #ffe448;
        }
      }
    }

    &:not(:first-of-type) {
      margin-left: 0;
      position: absolute;
      margin-top: -197px;
    }

    @for $i from 1 through 6 {
      &:nth-of-type(#{$i}) {
        transform: rotate(-30deg)
          rotateY(20deg)
          rotateX(20deg)
          translate(-14px + $i * 2px, 14px - $i * 2px)
          scale(0.85) !important;
      }
    }
  }
}
</style>