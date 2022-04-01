import { Socket } from "socket.io";
import { Card, CardColor, CardType } from "./Card";
import Player from "./Player";
import { ChatMessage, Room, Settings } from "./Room";
import { decrementStat, incrementPickedColors, incrementStat } from "./Stats";
import { RateLimiter } from "limiter";

import Filter from "bad-words";
const filter = new Filter();

const players: { [index: string]: Player } = {};
const rooms: { [index: string]: Room } = {};
const publicRooms: { host: string; code: string; maxPlayers: number; playerCount: number }[] = [];

// prune public rooms for finished rooms every 8 minutes
// to clear glitched persisting rooms
setInterval(() => {
  for (let i = publicRooms.length - 1; i > 0; i--) {
    const pr = publicRooms[i];
    if (!rooms[pr.code] || rooms[pr.code].players.length === 0 || rooms[pr.code].isRoomEmpty) {
      publicRooms.splice(i, 1);
      if (rooms[pr.code]) delete rooms[pr.code];
    }
  }
}, 60000 * 3);

const defaultSettings: Settings = {
  maxPlayers: 4,
  public: false,
  stacking: true,
  forcePlay: false,
  drawToPlay: false,
  bluffing: false,
  jumpIn: false,
  seven0: false,
};

const validateSettings = (settings: any): Settings | false => {
  if (!settings || typeof settings !== "object") return false;

  // merge settings with default (settings overwrites duplicate properties in defaultSettings)
  settings = { ...defaultSettings, ...settings };

  const requiredSettings: {
    key: string;
    type: string;
  }[] = [
    { key: "maxPlayers", type: "number" },
    { key: "public", type: "boolean" },
    { key: "stacking", type: "boolean" },
    { key: "forcePlay", type: "boolean" },
    { key: "drawToPlay", type: "boolean" },
    { key: "bluffing", type: "boolean" },
    { key: "jumpIn", type: "boolean" },
    { key: "seven0", type: "boolean" },
  ];

  for (const rs of requiredSettings) {
    if (settings[rs.key] === undefined || typeof settings[rs.key] !== rs.type) return false;
  }

  const s = <Settings>settings;

  if (s.maxPlayers < 2 || s.maxPlayers > 4) return false;

  return s;
};

const updatePublicRoomPlayerCount = (player: Player, num: number, id = "") => {
  const roomId = id || player.roomId;
  if (rooms[roomId]?.settings.public) {
    const i = publicRooms.findIndex((r) => r.code === roomId);
    if (i === -1) return;

    publicRooms[i].playerCount += num;

    if (publicRooms[i].playerCount === 0 || rooms[roomId].isRoomEmpty) {
      publicRooms.splice(i, 1);
    }
  }
};

export default function(socket: Socket) {
  const player = new Player(socket);
  players[socket.id] = player;

  incrementStat("playersOnline", 1);
  incrementStat("totalVisits", 1);

  const leaveRoom = () => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (!room) return;

    room.removePlayer(player, false);
    updatePublicRoomPlayerCount(player, -1, room.id);

    if (room.isRoomEmpty) delete rooms[room.id];
  };

  socket.on("disconnect", () => {
    leaveRoom();
    decrementStat("playersOnline", 1);

    delete players[socket.id];
  });

  const joinRoom = ({ username = "", roomCode = "" }) => {
    if (player.inRoom) return socket.emit("kicked");

    // validate data
    if (username.length < 2 || username.length > 11) return socket.emit("kicked");
    if (roomCode.length < 4 || roomCode.length > 12) return socket.emit("kicked");

    // get room
    const room = rooms[roomCode];
    if (!room || room.players.length === room.settings.maxPlayers || room.started || room.isRoomEmpty)
      return socket.emit("kicked");

    player.username = username;
    room.addPlayer(player);

    updatePublicRoomPlayerCount(player, 1);
  };

  const createRoom = ({
    username = "",
    roomCode = "",
    settings,
  }: {
    username: string;
    roomCode: string;
    settings: any;
  }) => {
    if (player.inRoom) return;

    // validate data
    if (username.length < 2 || username.length > 11) return;
    if (roomCode && (roomCode.length < 4 || roomCode.length > 12)) return;

    // validate settings
    const s = validateSettings(settings);
    if (!s) return;

    player.username = username;

    // create room
    let room;
    if (roomCode && !rooms[roomCode]) {
      room = new Room(player, s, roomCode);
    } else {
      room = new Room(player, s);
    }

    rooms[room.id] = room;

    if (room.settings.public)
      publicRooms.push({
        host: room.host.username,
        code: room.id,
        maxPlayers: room.settings.maxPlayers,
        playerCount: room.players.length,
      });
  };

  const addBot = () => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (room.host.id !== player.id || room.players.length === room.settings.maxPlayers) return;

    room.addBot(room.createBot());
    room.broadcastState();

    updatePublicRoomPlayerCount(player, 1);
  };

  socket.on("create-room", createRoom);

  socket.on("join-room", joinRoom);

  socket.on("add-bot", addBot);

  socket.on("kick-player", (id: string) => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (room.host.id !== player.id) return;

    const remove = room.players.find((p) => p.id === id);
    if (!remove) return;

    room.removePlayer(remove, false);
    updatePublicRoomPlayerCount(player, -1);

    remove.socket?.emit("kicked");
  });

  socket.on("leave-room", () => {
    leaveRoom();
  });

  socket.on("start-game", () => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (room.started || room.host.id !== player.id) return;

    room.startGame();

    if (room.settings.public)
      publicRooms.splice(
        publicRooms.findIndex((r) => r.code === room.id),
        1
      );
  });

  socket.on("call-uno", () => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];

    if (
      !room ||
      !room.started ||
      (room.turn.id !== player.id && !(room.awaitingJumpIn && player.canJumpIn)) ||
      player.cards.length !== 2
    )
      return;

    incrementStat("unosCalled", 1);

    player.hasCalledUno = true;
    rooms[player.roomId].broadcastState();
  });

  socket.on("draw-card", () => {
    if (!player.inRoom || rooms[player.roomId].turn.id !== player.id || !player.canDraw) return;

    const room = rooms[player.roomId];
    room.drawCards(player);
  });

  socket.on("play-card", (index: number, color: number) => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (
      !room ||
      !room.started ||
      (room.turn.id !== player.id && !(room.awaitingJumpIn && player.canJumpIn)) ||
      !player.cards[index]
    )
      return;

    const card = player.cards[index];
    if (card.type === CardType.Plus4 || card.type === CardType.Wildcard) {
      if (color !== undefined && color >= CardColor.Red && color <= CardColor.Blue) {
        card.color = color;

        switch (color) {
          case CardColor.Red:
            incrementPickedColors("red", 1);
            break;
          case CardColor.Blue:
            incrementPickedColors("blue", 1);
            break;
          case CardColor.Green:
            incrementPickedColors("green", 1);
            break;
          case CardColor.Yellow:
            incrementPickedColors("yellow", 1);
            break;
          default:
            break;
        }
      } else {
        return;
      }
    }

    room.playCard(player, index);
  });

  socket.on("play-wildcard", (type: CardType) => {
    if (!player.inRoom || !(type === CardType.Plus4 || type === CardType.Wildcard)) return;

    const room = rooms[player.roomId];
    if (!room.started || room.turn.id !== player.id || player.cards.findIndex((c) => c.type === type) === -1)
      return;

    room.wildcard = new Card(-1, CardColor.None, type);
    room.broadcastState();
  });

  socket.on("keep-card", () => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (!room.started || room.turn.id !== player.id || !player.cards) return;

    room.nextTurn();
  });

  socket.on("pick-hand", (id: string) => {
    if (!player.inRoom || !player.canPickHand) return;

    const room = rooms[player.roomId];
    if (!room.started || room.turn.id !== player.id) return;

    const swap = room.players.find((p) => p.id === id);
    if (!swap) return;

    room.swapHands(player, swap, true);
  });

  const messageLimiter = new RateLimiter({ tokensPerInterval: 30, interval: "minute" });

  socket.on("room-send-message", async (m: ChatMessage) => {
    if (!player.inRoom || m.id !== player.id) return;
    if (m.text.length === 0 || m.text.length > 300) return;
    if (m.username.length < 2 || m.username.length > 11) return;

    try {
      const remainingMessages = await messageLimiter.removeTokens(1);
    } catch {
      return;
    }

    m.text = filter.clean(m.text);
    m.time = Date.now();

    const room = rooms[player.roomId];
    room.chat.push(m);
    room.broadcastState();
  });

  socket.on("get-public-rooms", () => {
    socket.emit("recieve-public-rooms", publicRooms);
  });

  socket.on("play-again", () => {
    if (!player.inRoom) return;

    const room = rooms[player.roomId];
    if (!room) return;

    leaveRoom();

    if (room.nextId) {
      joinRoom({ username: player.username, roomCode: room.nextId });
    } else {
      createRoom({ username: player.username, roomCode: "", settings: room.settings });
      room.nextId = player.roomId;

      const newRoom = rooms[room.nextId];
      newRoom.chat = room.chat;

      room.players.forEach((p) => {
        if (p.bot) {
          room.removePlayer(p, false);

          newRoom.addBot(p);

          updatePublicRoomPlayerCount(player, 1);
        }
      });

      room.broadcastState();
      newRoom.broadcastState();
    }
  });
}
