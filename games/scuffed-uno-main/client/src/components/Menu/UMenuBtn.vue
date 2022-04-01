<script>
export default {
  name: "UMenuBtn",
};
</script>

<template>
  <button class="btn" @click="$emit('click', $event)"><slot></slot></button>
</template>

<style lang="scss" scoped>
.btn {
  padding: 14px 25px;
  width: 100%;
  font-size: 1.5rem;
  color: white;
  background-color: #ff520d;
  border-radius: 8px;
  font-weight: bold;
  transition: background-color 0.2s ease;

  &:hover {
    background-color: #e72300;
  }
}
</style>