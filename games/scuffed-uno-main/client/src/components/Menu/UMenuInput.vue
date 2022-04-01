<script>
export default {
  name: "UMenuInput",
  props: {
    value: {
      required: true,
    },
    label: {
      type: String,
      default: "Input Label",
    },
    placeholder: {
      type: String,
      default: "",
    },
    type: {
      type: String,
      default: "text",
    },
    min: {
      type: Number,
      default: 2,
    },
    max: {
      type: Number,
      default: 4,
    },
  },
};
</script>

<template>
  <div class="input">
    <label for="label">{{ label }}</label>
    <input
      @input="
        $emit(
          'input',
          ((type) => {
            switch (type) {
              case 'checkbox':
                return $event.target.checked;
              case 'range':
                return Number($event.target.value);
              default:
                return $event.target.value;
            }
          })(type)
        )
      "
      :value="value"
      :checked="value"
      name="label"
      :min="min"
      :max="max"
      :type="type"
      :placeholder="placeholder || label"
      :style="type !== 'text' ? { paddingLeft: 0, paddingRight: 0 } : {}"
    />
  </div>
</template>

<style lang="scss" scoped>
.input {
  display: flex;
  flex-direction: column;
  width: 100%;
  margin-bottom: 20px;

  &:last-of-type {
    margin-bottom: 25px;
  }

  label {
    font-weight: bold;
    margin-bottom: 5px;
  }

  input {
    padding: 10px;
    border: 2px solid black;
    border-radius: 7px;
    outline: none;
  }
}
</style>