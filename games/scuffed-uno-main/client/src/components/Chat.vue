<script>
export default {
  name: "Chat",
  data() {
    return {
      isOpen: false,
      message: "",
      msgSinceOpen: 0,
    };
  },
  computed: {
    room() {
      return this.$store.state.room;
    },
  },
  watch: {
    room(room, oldRoom) {
      if (!this.isOpen && room.chat.length > oldRoom.chat.length) {
        this.msgSinceOpen++;
      }
    },
  },
  methods: {
    sendMessage() {
      const socket = this.$store.state.socket;
      if (!socket) return;

      if (this.message.length === 0 || this.message.length > 300) return;

      const m = {
        text: this.message,
        username: this.$store.state.room.you.username,
        id: this.$store.state.room.you.id,
        time: Date.now(),
      };

      socket.emit("room-send-message", m);
      this.message = "";
    },
  },
};
</script>

<template>
  <div class="chat-container" :class="{ open: isOpen }">
    <button
      class="open-btn"
      @click="
        isOpen = !isOpen;
        msgSinceOpen = 0;
      "
    >
      <div class="chat-alert" v-show="msgSinceOpen > 0">
        {{ msgSinceOpen > 9 ? `9+` : msgSinceOpen }}
      </div>
    </button>

    <div class="chat">
      <div class="messages">
        <div
          class="message"
          v-for="(m, i) in [...$store.state.room.chat].reverse()"
          :key="i"
          :class="{ you: m.id === $store.state.room.you.id }"
        >
          <p>{{ m.text }}</p>

          <div class="tag">
            <p class="username">{{ m.username }}</p>
            ,
            <p class="time">
              {{ new Date(m.time).toTimeString().substr(0, 5) }}
            </p>
          </div>
        </div>
      </div>

      <form @submit.prevent="sendMessage">
        <input
          name="message"
          placeholder="Type your message here..."
          maxlength="300"
          v-model="message"
        />
        <button type="submit">Send</button>
      </form>
    </div>
  </div>
</template>


<style lang="scss" scoped>
.chat-container {
  --chat-width: min(35rem, 45vw);
  --chat-height: min(40rem, 100vh);

  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%) translateX(calc(var(--chat-width) * -1));
  display: flex;
  flex-direction: row-reverse;
  align-items: center;
  z-index: 1004;
  transition: transform 0.5s ease;
  color: white;

  .chat {
    width: var(--chat-width);
    height: var(--chat-height);
    background-color: rgba(0, 0, 0, 0.65);
    border-radius: 0 1rem 1rem 0;
    border: 4px solid white;
    border-left: none;
    padding: 0.5rem;
    display: grid;
    grid-template-rows: 1fr auto;
    gap: 0.5rem;

    .messages {
      display: flex;
      flex-direction: column-reverse;
      row-gap: 0.5rem;
      overflow-y: scroll;
      padding-right: 0.4rem;

      &::-webkit-scrollbar {
        background: rgba(0, 0, 0, 0.425);
        border-radius: 0.2rem;
        width: 0.9rem;
      }

      &::-webkit-scrollbar-thumb {
        background: rgba(0, 0, 0, 0.733);
        border-radius: 2rem;
        opacity: 0.5;
      }

      .message {
        background-color: hsla(3, 76%, 43%, 0.5);
        border-radius: 0.4rem;
        padding: 0.6rem 0.8rem;
        width: max-content;
        min-width: 8rem;
        max-width: 90%;
        position: relative;
        margin-bottom: 1.6rem;

        p {
          word-wrap: break-word;
          width: max-content;
          max-width: 100%;
        }

        .tag {
          position: absolute;
          display: flex;
          bottom: -1.45rem;
          right: 0;
          opacity: 0.6;
          font-weight: 500;
          font-size: 0.9rem;
        }

        &.you {
          background-color: rgba(26, 112, 193, 0.5);
          margin-left: auto;

          .tag {
            right: unset;
            left: 0;
          }
        }
      }
    }

    form {
      display: flex;
      column-gap: 0.5rem;

      input {
        background-color: black;
        border: 2px solid white;
        flex-grow: 1;
        resize: none;
        border-radius: 0.4rem;
        opacity: 0.6;
        padding: 0.2rem 0.4rem;
        font-size: 1rem;
        outline: none;
        transition: opacity 0.3s ease;
        width: 100%;

        &:focus {
          opacity: 0.8;
        }
      }

      button {
        background-color: #ff520d;
        font-size: 1.1rem;
        color: white;
        border-radius: 0.4rem;
        font-weight: bold;
        transition: background-color 0.2s ease;
        padding: 0.7rem 1rem;
        outline: none;

        &:hover {
          background-color: #e72300;
        }
      }
    }
  }

  .open-btn {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    height: clamp(7.5rem, 20vh, 10rem);
    width: 3.3rem;
    background-color: black;
    border-radius: 0 0.8rem 0.8rem 0;
    outline: none;
    border: 4px solid white;
    border-left: none;

    .chat-alert {
      --size: 1.5rem;
      position: absolute;
      top: calc(var(--size) / -2);
      right: calc(var(--size) / -2);
      width: var(--size);
      height: var(--size);
      border-radius: var(--size);
      background-color: rgb(231, 59, 59);
      animation: pulse 2s infinite;
      color: white;
      font-weight: bold;
      font-size: 1rem;
      display: flex;
      justify-content: center;
      align-items: center;

      --shadow-color: rgb(255, 0, 0);

      @keyframes pulse {
        from {
          box-shadow: 0px 0px 12px 0px var(--shadow-color);
        }

        50% {
          box-shadow: 0px 0px 0px 0px var(--shadow-color);
        }

        to {
          box-shadow: 0px 0px 12px 0px var(--shadow-color);
        }
      }
    }

    &::before,
    &::after {
      content: "";
      position: absolute;
      display: flex;
      width: 18%;
      height: 30%;
      border-radius: 5rem;
      background-color: white;
      transition: transform 0.5s ease;
    }

    &::before {
      transform: translateY(-40%) rotate(-18deg);
    }

    &::after {
      transform: translateY(40%) rotate(18deg);
    }

    @media screen and (max-width: 900px) {
      transform: scale(0.75);
      transform-origin: left center;
    }
  }

  &.open {
    transform: translateY(-50%);

    .chat {
      margin-left: 0;
    }

    .open-btn {
      &::before {
        transform: translateY(-42%) rotate(18deg);
      }

      &::after {
        transform: translateY(42%) rotate(-18deg);
      }
    }
  }
}
</style>