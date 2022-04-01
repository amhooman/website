<script>
import Card from "@/components/Card.vue";

export default {
  name: "UGameOtherCards",
  components: {
    Card,
  },
  props: {
    room: {
      type: Object,
      default() {
        return {};
      },
    },
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
  <div class="other-cards-container">
    <div
      v-if="room.right"
      class="cards other right"
      :style="{ '--count': `${room.right.count}` }"
      :class="{ swap: swap.right }"
    >
      <Card
        v-for="i in room.right.count"
        :key="i + 'right'"
        back
        :style="{ zIndex: i }"
      />
    </div>
    <div
      v-if="room.left"
      class="cards other left"
      :style="{ '--count': `${room.left.count}` }"
      :class="{ swap: swap.left }"
    >
      <Card
        v-for="i in room.left.count"
        :key="i + 'left'"
        back
        :style="{ zIndex: i }"
      />
    </div>
    <div
      v-if="room.top"
      class="cards other top"
      :style="{ '--count': `${room.top.count}` }"
      :class="{ swap: swap.top }"
    >
      <Card
        v-for="i in room.top.count"
        :key="i + 'top'"
        back
        :style="{ zIndex: i }"
      />
    </div>
  </div>
</template>

<style lang="scss" scoped>
$mobile: 900px;

.other-cards-container {
  width: 100%;
  height: 100%;
  position: absolute;
  display: flex;
  justify-content: center;
}

.other {
  position: absolute;

  .card {
    margin-left: max(calc(-5.5px * var(--count)), -105px);

    @media screen and (max-width: $mobile) {
      margin-left: max(calc(-2.75px * var(--count)), -52.5px);
    }
  }

  &.right {
    right: 120px;
    bottom: 48%;
    transform-origin: bottom right;
    transform: rotate(15deg) rotateY(50deg) rotateZ(5deg) rotateX(20deg)
      scale(0.75);

    @media screen and (max-width: $mobile) {
      right: 50px;
      bottom: 46%;
    }
  }

  &.left {
    left: 120px;
    bottom: 48%;
    transform-origin: bottom left;
    transform: rotate(-15deg) rotateY(-50deg) rotateZ(-5deg) rotateX(20deg)
      scale(0.75);

    @media screen and (max-width: $mobile) {
      left: 50px;
      bottom: 46%;
    }

    .card:first-of-type {
      margin-left: 0 !important;
    }
  }

  &.top {
    top: 20px;
    transform: scale(0.6);

    @media screen and (max-width: $mobile) {
      transform-origin: top center;
      top: 20px;
    }
  }
}
</style>