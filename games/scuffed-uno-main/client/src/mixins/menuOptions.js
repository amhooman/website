export default {
  data() {
    return {
      currentLevel: "main",
      options: {
        mainTitle: "Main Menu",
        main: [
          {
            action: "Solo Play",
            graphic: require("@/assets/solo.jpg"),
            func: () => (this.showCreateRoomSoloModal = true),
          },
          {
            action: "Online Play",
            graphic: require("@/assets/online.jpg"),
            level: "online",
          },
          {
            action: "Settings",
            graphic: require("@/assets/settings.jpg"),
            level: "settings",
            func: () => (this.showSettingsModal = true),
          },
        ],
        soloTitle: "Solo Game",
        soloBack: () => {
          this.$store.state.socket.emit("leave-room");
          this.currentLevel = "main";
        },
        solo: [],

        onlineTitle: "Online Games",
        onlineBack: () => (this.currentLevel = "main"),
        online: [
          {
            action: "Join Room",
            graphic: require("@/assets/arrow.jpg"),
            func: () => (this.showJoinRoomModal = true),
          },
          {
            action: "Create Room",
            graphic: require("@/assets/plus.jpg"),
            func: () => (this.showCreateRoomModal = true),
          },
          {
            action: "Public Rooms",
            graphic: require("@/assets/rooms.jpg"),
            func: () => {
              this.showPublicRoomsModal = true;
              this.fetchPublicRooms();
            },
          },
        ],
        onlineRoomTitle: "Online Room",
        onlineRoomBack: () => {
          this.$store.state.socket.emit("leave-room");
          this.currentLevel = "online";
        },
        onlineRoom: [],
        settingsTitle: "Settings",
        settingsBack: () => {
          this.currentLevel = "main";
          this.showSettingsModal = false;
        },
        settings: [],
      },
    };
  },
};
