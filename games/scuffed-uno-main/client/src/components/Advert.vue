
<script>
export default {
  name: "Advert",
  components: {},
  data() {
    return {
      adtest: "",
    };
  },
  props: {
    adSlot: {
      type: String,
      require: true,
    },
    width: {
      type: Number,
      require: true,
    },
    height: {
      type: Number,
      require: true,
    },
    timeout: {
      type: Number,
      default: 0,
    },
    viewWidth: {
      type: Number,
      default: 0,
    },
    viewHeight: {
      type: Number,
      default: 0,
    },
  },
  mounted() {
    const ad = this.$refs.ad;
    if (
      !ad ||
      window.innerWidth < this.viewWidth ||
      window.innerHeight < this.viewHeight ||
      this.$store.state.reloading
    )
      return;

    const conf = document.createElement("script");
    conf.innerHTML = `(adsbygoogle = window.adsbygoogle || []).push({});`;

    const script = document.createElement("script");
    script.async = true;
    script.crossOrigin = "anonymous";
    script.src = `https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${this.$store.state.adClient}`;

    if (window.location.hostname === "localhost") {
      this.adtest = "on";
    }

    ad.appendChild(conf);
    ad.appendChild(script);
  },
};
</script>

<template>
  <div class="ad" ref="ad">
    <ins
      class="adsbygoogle"
      :style="{
        display: `inline-block`,
        width: `${width}px`,
        height: `${height}px`,
        background: adtest ? `white` : ``,
      }"
      :data-ad-client="$store.state.adClient"
      :data-ad-slot="adSlot"
      :data-adtest="adtest"
    ></ins>
  </div>
</template>

<style lang="scss" scoped>
</style>