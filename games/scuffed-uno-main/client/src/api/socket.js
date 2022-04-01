import store from "@/store";
import io from "socket.io-client";
const SERVER_URL =
  process.env.NODE_ENV === "development"
    ? `http://${window.location.hostname}:3000`
    : "https://server.scuffeduno.online";

const socket = io(SERVER_URL);
store.commit("SET_SOCKET", socket);

// track connection status
socket.on("connect", () => store.commit("SET_IS_CONNECTED", true));
socket.on("disconnect", () => store.commit("SET_IS_CONNECTED", false));

socket.on("state", (room) => store.commit("SET_ROOM", room));

socket.on("kicked", () => {
  store.commit("RESET_ROOM");
  store.commit("KICKED");
});
