<template>
  <u-menu-modal title="Settings" @close="$emit('close')">
    <h2 style="font-weight: bold; font-size: 1.6rem">Volume</h2>
    <div
      style="
        padding-top: 0.4rem;
        padding: 0.8rem;
        display: flex;
        flex-direction: column;
        width: 100%;
      "
    >
      <p style="font-size: 1.2rem; font-weight: bold">Sound Effects</p>
      <input
        type="range"
        style="width: 100%"
        name="sound-volume"
        min="0"
        max="1"
        step="0.05"
      />
    </div>

    <div
      style="
        padding: 0.8rem;
        padding-bottom: 1.5rem;
        display: flex;
        flex-direction: column;
        width: 100%;
      "
    >
      <p style="font-size: 1.2rem; font-weight: bold">Music</p>
      <input
        type="range"
        style="width: 100%"
        name="music-volume"
        min="0"
        max="1"
        step="0.01"
        :value="$store.state.soundController.musicVolume"
        @input="
          $store.state.soundController.setMusicVolume(
            Number($event.target.value)
          )
        "
      />
    </div>

    <u-menu-btn class="btn rounded-btn" @click="$emit('exit')">
      Main Menu
    </u-menu-btn>
  </u-menu-modal>
</template>

<script>
import UMenuModal from "@/components/Menu/UMenuModal.vue";
import UMenuBtn from "@/components/Menu/UMenuBtn.vue";

export default {
  name: "USettingsMenu",
  components: {
    UMenuModal,
    UMenuBtn,
  },
};
</script>

<style>
</style>