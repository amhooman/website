import { v4 as uuid } from "uuid";
import { performance } from "perf_hooks";

import { Card, CardColor, CardType } from "./Card";
import Deck from "./Deck";
import Player from "./Player";
import { decrementStat, incrementStat } from "./Stats";

export interface Settings {
  stacking: boolean;
  forcePlay: boolean;
  bluffing: boolean;
  drawToPlay: boolean;
  jumpIn: boolean;
  seven0: boolean;
  public: boolean;
  maxPlayers: number;
}

export interface ChatMessage {
  text: string;
  username: string;
  id: string;
  time: number;
}

export class Room {
  id = "";
  started: boolean = false;
  host: Player;
  players: Player[] = [];
  deck: Deck = new Deck();
  pile: Card[] = [];
  turn: Player;
  directionReversed: boolean = false;
  stack: number = 0;
  winner: Player | null = null;
  isRoomEmpty: boolean = false;
  inactivityTimer: number = 0;
  inactivityTimerInterval: NodeJS.Timeout | null = null;
  wildcard: Card | null = null;
  settings: Settings;
  chat: ChatMessage[] = [];
  nextId = "";
  awaitingJumpIn = false;
  jumpInTime = 0;

  constructor(host: Player, settings: Settings, id: string = "") {
    this.id = id || uuid().substr(0, 7);
    this.host = host;
    this.turn = host;
    this.settings = settings;
    this.addPlayer(host);

    incrementStat("lobbiesCreated", 1);
    incrementStat("lobbiesOnline", 1);
  }

  addPlayer(player: Player) {
    player.roomId = this.id;
    player.inRoom = true;

    this.players.push(player);
    this.broadcastState();
  }

  removePlayer(player: Player, replace: boolean = true) {
    const players = this.players.filter((p) => !p.bot && p.id !== player.id);
    if (players.length === 0) {
      this.isRoomEmpty = true;
      decrementStat("lobbiesOnline", 1);
    } else if (this.host.id === player.id) {
      this.host = players[Math.floor(Math.random() * players.length)];
    }

    if (replace && !this.isRoomEmpty) {
      // create replacement bot
      const bot = this.createBot(player);
      this.addBot(bot, player);

      if (this.turn === player) {
        this.turn = bot;
        this.turn.canPlay = true;
        this.turn.canDraw = true;
        this.turn.botPlay(this);
      }
    } else {
      this.players = this.players.filter((p) => p.id !== player.id);
    }

    this.broadcastState();

    player.roomId = "";
    player.inRoom = false;
    player.cards = [];

    // if only 1 player is left and remove is not replaced then kick last player as game cannot be played
    if (this.players.length === 1 && !replace && this.started && this.host !== player && !this.winner) {
      this.removePlayer(this.host, false);
      this.host.socket?.emit("kicked");
    }

    if (this.turn === player) {
      this.nextTurn();
    }
  }

  async startGame() {
    this.deck.generateDeck();
    this.deck.shuffleDeck();

    // place starting card on pile
    this.pile.push(this.deck.pickCard());
    if (this.topCard().type === CardType.Plus4 || this.topCard().type === CardType.Wildcard) {
      this.topCard().color = Math.floor(Math.random() * 4);
    }

    // give players cards
    this.players.forEach((p) => {
      p.cards = [];

      for (let i = 0; i < 7; i++) {
        this.giveCard(p);
      }

      p.sortCards();
    });

    this.started = true;

    this.broadcastState();

    // pick player to start (player after randIndex will actually play first)
    const randIndex = Math.floor(Math.random() * this.players.length);
    this.turn = this.players[randIndex];

    this.nextTurn();

    // start inactivity timer
    this.inactivityTimerInterval = setInterval(async () => {
      this.inactivityTimer++;

      if (this.inactivityTimer === 300) {
        this.players.forEach((p) => {
          if (p.bot) return;

          this.removePlayer(p, false);
          p.socket?.emit("kicked");
        });
      }
    }, 1000);
  }

  // giveCard takes the first card from the deck array and pushes it onto player's cards
  // then updates the player's playable cards if it is their turn
  // returns the given Card
  giveCard(player: Player): Card {
    if (this.deck.cards.length === 0) {
      this.refillDeckFromPile();

      // if there is still no cards then just generate another deck
      if (this.deck.cards.length === 0) {
        this.deck.generateDeck(false);
        this.deck.shuffleDeck();
      }
    }

    const card = this.deck.pickCard();
    player.cards.push(card);

    if (this.turn.id === player.id && this.started) {
      player.findPlayableCards(this.topCard());
    }

    return card;
  }

  // drawCards draws cards from the deck and gives them to player
  async drawCards(player: Player, amount: number = -1) {
    // exit early if player:
    // - is drawing,
    // - player is not able to draw and they aren't being +2ed or +4ed
    if (player.drawing || (!player.canDraw && amount === -1)) return;

    if (amount === -1) player.canDraw = false;
    player.drawing = true;

    const drawn: Card[] = [];
    let i = 0;

    // loops while:
    // - if amount is -1: player hasn't drawn a playable card
    // - else: draws until i === amount
    while (
      (amount === -1 && drawn.findIndex((c) => c.playable) === -1) ||
      (amount !== -1 && amount !== i && !this.isRoomEmpty)
    ) {
      drawn.push(this.giveCard(player));
      player.sortCards();

      // find index of last drawn card in sorted list
      player.lastDrawnCard = player.cards.findIndex((c) => c.id === drawn[drawn.length - 1].id);

      this.broadcastState();

      // delay drawing
      await sleep(amount !== -1 ? 400 : 800);

      i++;

      // handle drawing with custom rules
      if (amount === -1 && !this.settings.drawToPlay) {
        if (drawn.findIndex((c) => c.playable) === -1) {
          await sleep(400);
          player.drawing = false;
          this.nextTurn();
          return;
        }

        break;
      }
    }

    // make last draw card only playable card
    player.cards.forEach((c) => (c.playable = false));
    player.cards[player.lastDrawnCard] ? (player.cards[player.lastDrawnCard].playable = true) : null;

    if (amount === -1 && !this.settings.forcePlay) {
      player.socket?.emit("can-keep-card");
    }

    player.drawing = false;
    this.broadcastState();
  }

  // playCard performs game logic based on what card a player wishes to play
  async playCard(player: Player, cardIndex: number) {
    if (
      !player.canPlay ||
      !player.cards[cardIndex] ||
      (this.turn.id !== player.id && !(this.awaitingJumpIn && player.canJumpIn)) ||
      !player.cards[cardIndex].playable ||
      this.isRoomEmpty ||
      this.winner
    )
      return;

    if (this.awaitingJumpIn) {
      // console.log("play jump in card", this.jumpInTime);
      this.turn = player;

      this.clearJumpIns();
      if (this.topCard().type === CardType.Plus2) this.stack -= 2;
      if (this.stack < 0) this.stack = 0; // just to make sure

      await sleep(500);
      this.broadcastState();
      await sleep(500);
    }

    // prevent anyone else from playing while we perform this card play
    this.players.forEach((p) => {
      if (p === player) return;

      p.canPlay = false;
    });

    incrementStat("cardsPlayed", 1);

    // reset wildcard
    this.wildcard = null;

    // get card and remove from players cards
    const card = player.cards[cardIndex];
    player.cards.splice(cardIndex, 1);

    // put card on pile
    this.pile.push(card);
    this.broadcastState();
    await sleep(500);

    // change turn to player to account for jump in plays
    this.turn = player;

    // check if player has won
    this.checkForWinner();
    if (this.winner) {
      this.broadcastState();
      incrementStat("gamesPlayed", 1);
      return;
    }

    const nextPlayer = this.getNextPlayer();
    let draw = 0;

    // punish player for not calling uno
    const needsUnoPunished = this.needsUnoPunished(player);
    await this.punishMissedUno(player, needsUnoPunished);

    // check jump ins
    if (this.settings.jumpIn) {
      // console.log("checking jump ins");
      const time = await this.checkJumpIns();

      if (this.awaitingJumpIn && time === this.jumpInTime) {
        // console.log("no jump in", this.jumpInTime);
        // a player could have jumped in but didn't
        this.clearJumpIns();
        this.broadcastState();
      } else if (time !== -1) {
        // a player jumped in
        // console.log("player jumped in", time);
        return;
      }
    }

    switch (card.type) {
      case CardType.Plus2:
        if (this.settings.stacking && nextPlayer.cards.findIndex((c) => c.type === CardType.Plus2) !== -1) {
          nextPlayer.mustStack = true;
          this.stack += 2;
        } else {
          draw = this.stack + 2;
          this.clearStack();
        }
        break;
      case CardType.Plus4:
        incrementStat("plus4sDealt", 1);

        if (this.settings.stacking && nextPlayer.cards.findIndex((c) => c.type === CardType.Plus4) !== -1) {
          nextPlayer.mustStack = true;
          this.stack += 4;
        } else {
          draw = this.stack + 4;
          this.clearStack();
        }
        break;
      case CardType.Reverse:
        this.directionReversed = !this.directionReversed;
        break;
      case CardType.None:
        if (this.settings.seven0) {
          if (card.number === 7 || card.number === 0) {
            player.canPlay = false;
            player.canDraw = false;
            this.broadcastState();
            await sleep(500);
          }

          if (card.number === 7) {
            player.canPickHand = true;
            this.broadcastState();

            if (player.bot) {
              await sleep(1200);
              player.botSwapHands(this);
            } else {
              player.socket?.emit("can-pick-hand");
              this.broadcastState();
            }
            return;
          } else if (card.number === 0) {
            const hands = this.players.map((p) => p.cards);

            // swap hands in direction of play
            for (let i = 0; i < this.players.length; i++) {
              const index = this.directionReversed ? this.players.length - 1 - i : i;
              let nextIndex = this.directionReversed ? index - 1 : index + 1;
              if (nextIndex < 0) nextIndex = this.players.length - 1;
              if (nextIndex >= this.players.length) nextIndex = 0;

              this.players[nextIndex].cards = hands[index];

              this.broadcastSwapHand(this.players[index], this.players[nextIndex]);
            }

            await sleep(600);
            this.broadcastState();
            await sleep(600);
          }
        }
        break;
    }

    // go to next turn
    if (
      ((card.type === CardType.Plus2 || card.type === CardType.Plus4) && !nextPlayer.mustStack) ||
      card.type === CardType.Skip
    ) {
      this.nextTurn(true, draw);
    } else {
      this.nextTurn();
    }
  }

  needsUnoPunished(player: Player) {
    return player.cards.length === 1 && !player.hasCalledUno;
  }

  async punishMissedUno(player: Player, force = false) {
    // TODO make other players need to call out player to be punished
    if (this.needsUnoPunished(player) || force) {
      await this.drawCards(player, 2);
    }
    player.hasCalledUno = false;
  }

  async checkJumpIns() {
    const tc = this.topCard();
    this.awaitingJumpIn = false;

    for (const p of this.players) {
      p.clearPlayableCards();
      p.canJumpIn = false;

      for (const c of p.cards) {
        let playable = false;
        if (c.type === CardType.None && c.color === tc.color && c.number === tc.number) playable = true;
        else if (c.type !== CardType.None && c.color === tc.color && c.type === tc.type) playable = true;
        // else if ((c.type === CardType.Wildcard || c.type === CardType.Plus4) && c.type === tc.type)
        //   playable = true;
        // TODO implement jump in for wildcards

        if (playable) {
          c.playable = true;
          this.awaitingJumpIn = true;
          p.canJumpIn = true;
          p.canPlay = true;
        }
      }

      if (p.bot && p.canJumpIn && Math.random() > 0.25) {
        p.botPlay(this);
      }
    }

    if (this.awaitingJumpIn) {
      const time = performance.now();
      this.jumpInTime = time;

      this.broadcastState();
      // console.log("waiting for jump ins");
      await sleep(2000);
      return time;
    }

    return -1;
  }

  clearJumpIns() {
    this.awaitingJumpIn = false;
    this.jumpInTime = 0;
    this.players.forEach((p) => (p.canJumpIn = false));
  }

  async swapHands(p: Player, swap: Player, seven: boolean) {
    const h = p.cards;
    p.cards = swap.cards;
    swap.cards = h;

    if (seven) {
      this.broadcastSwapHand(p, swap);
      await sleep(600);

      this.broadcastState();
      await sleep(600);

      await this.punishMissedUno(p);
      this.broadcastState();
      await sleep(600);

      this.nextTurn();
    }
  }

  clearStack() {
    this.stack = 0;
    this.players.forEach((p) => (p.mustStack = false));
  }

  async nextTurn(skip: boolean = false, draw: number = 0) {
    if (this.isRoomEmpty || this.winner) return;

    // console.log("next turn");

    // reset inactivity timer
    this.inactivityTimer = 0;

    this.turn.clearPlayableCards();
    this.turn.canDraw = false;
    this.turn.canPlay = false;
    this.turn.canPickHand = false;

    if (skip || draw !== 0) {
      this.turn = this.getNextPlayer();
      this.turn.canDraw = false;
      this.turn.canPlay = false;

      this.broadcastState();
      await sleep(1500);

      // console.log(this.turn.username);

      if (draw !== 0) {
        await this.drawCards(this.turn, draw);
      }
    }

    // gets next player - works because if player should be skipped then turn has already been incremented above
    // so here next player acts as skip otherwise, just regular increment of next player
    this.turn = this.getNextPlayer();
    if (!this.turn) return;

    // console.log(this.turn.username);

    this.turn.canDraw = true;
    this.turn.canPlay = true;
    this.turn.findPlayableCards(this.topCard());

    this.checkForWinner();
    this.broadcastState();

    if (this.winner) return incrementStat("gamesPlayed", 1);

    if (this.turn.bot) {
      this.turn.botPlay(this);
    }
  }

  getNextPlayer(offset: number = 0): Player {
    let i = this.players.findIndex((p) => p.id === this.turn.id);

    if (this.directionReversed) {
      i -= 1 + offset;
      if (i < 0) i = this.players.length + i;
    } else {
      i += 1 + offset;
      if (i > this.players.length - 1) i -= this.players.length;
    }

    return this.players[i];
  }

  checkForWinner() {
    this.players.forEach((p) => (p.cards.length === 0 ? (this.winner = p) : null));
  }

  refillDeckFromPile() {
    const cards = this.pile.splice(0, this.pile.length - 1);
    this.deck.cards.push(...cards);

    // clean wildcards
    this.deck.cards.map((c) => {
      if (c.type === CardType.Wildcard || c.type === CardType.Plus4) c.color = CardColor.None;
    });

    this.deck.shuffleDeck();
  }

  // gets the player who is in the seat offset number of positions clockwise from the given player
  getPlayerPosFromOffset(player: Player, offset: number) {
    const playerIndex = this.players.findIndex((p) => p.id === player.id);
    let newIndex = playerIndex + offset;
    newIndex > this.players.length - 1 ? (newIndex -= this.players.length) : null;

    return this.players[newIndex];
  }

  getOtherPlayers(player: Player) {
    let right;
    let top;
    let left;
    switch (this.players.length) {
      case 4:
        left = this.getPlayerPosFromOffset(player, 3);
      case 3:
        top = this.getPlayerPosFromOffset(player, 2);
      case 2:
        right = this.getPlayerPosFromOffset(player, 1);
        break;
    }

    return {
      left,
      right,
      top,
    };
  }

  broadcastState() {
    this.players.forEach((player) => {
      if (player.bot) return;

      const { left, right, top } = this.getOtherPlayers(player);

      const winner = this.winner ? { username: this.winner.username, id: this.winner.id } : undefined;

      const state = {
        id: this.id,
        isHost: this.host.id === player.id,
        host: this.host.id,
        turn: this.turn.id,
        pile: this.pile,
        started: this.started,
        directionReversed: this.directionReversed,
        stack: this.stack,
        playerCount: this.players.length,
        maxPlayers: this.settings.maxPlayers,
        wildcard: this.wildcard,
        chat: this.chat,
        awaitingJumpIn: this.awaitingJumpIn,
        you: {
          ...player,
          count: player.cards.length,
          socket: undefined,
          calledUno: player.hasCalledUno,
          skip: !player.canPlay && this.turn.id === player.id,
        },
        right: right
          ? {
              username: right.username,
              count: right.cards.length,
              id: right.id,
              isBot: right.bot,
              calledUno: right.hasCalledUno,
              skip: !right.canPlay && this.turn.id === right.id,
              canPickHand: right.canPickHand,
            }
          : undefined,
        top: top
          ? {
              username: top.username,
              count: top.cards.length,
              id: top.id,
              isBot: top.bot,
              calledUno: top.hasCalledUno,
              skip: !top.canPlay && this.turn.id === top.id,
              canPickHand: top.canPickHand,
            }
          : undefined,
        left: left
          ? {
              username: left.username,
              count: left.cards.length,
              id: left.id,
              isBot: left.bot,
              calledUno: left.hasCalledUno,
              skip: !left.canPlay && this.turn.id === left.id,
              canPickHand: left.canPickHand,
            }
          : undefined,
        winner,
      };

      player.socket?.emit("state", state);
    });
  }

  broadcastSwapHand(player: Player, swap: Player) {
    this.players.forEach((p) => {
      if (p.bot) return;

      p.socket?.emit("swap-hand-anim", player.id, swap.id);
    });
  }

  createBot(player?: Player): Player {
    const bot = new Player(null, true);
    bot.inRoom = true;
    bot.roomId = this.id;

    const botNames = [
      "John",
      "James",
      "Alice",
      "Sean",
      "Joe",
      "Fred",
      "Bob",
      "Pat",
      "Jack",
      "Adam",
      "Nathaniel",
      "Freddie",
      "Baka",
      "Sussy",
      "Deez",
      "Nutz",
      "Mama",
      "Kai",
      "Ligma",
      "Aidan",
      "Azaan",
      "Luc",
      "Michael",
      "Chris",
      "Matty",
      "Max",
    ];

    do {
      bot.username = `Bot ${botNames[Math.floor(Math.random() * botNames.length)]}`;
    } while (this.players.findIndex((p) => p.username === bot.username) !== -1);

    if (player) bot.cards = [...player.cards];

    incrementStat("botsUsed", 1);

    return bot;
  }

  addBot(bot: Player, player?: Player) {
    if (player) {
      const index = this.players.findIndex((p) => p.id === player.id);
      this.players[index] = bot;

      if (this.turn.id === player.id) {
        this.turn = bot;
        this.turn.botPlay(this);
      }
    } else {
      if (this.players.length === 4) return;

      this.players.push(bot);
    }
  }

  topCard(): Card {
    return this.pile[this.pile.length - 1];
  }
}

function sleep(time: number) {
  return new Promise((resolve) => setTimeout(resolve, time));
}
