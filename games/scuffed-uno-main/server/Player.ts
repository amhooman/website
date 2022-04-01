import { Socket } from "socket.io";
import { v4 as uuid } from "uuid";
import { Card, CardColor, CardType } from "./Card";
import { Room } from "./Room";
import { incrementPickedColors } from "./Stats";

export default class Player {
  id = "";
  socket;

  username = "";
  bot = false;
  inRoom = false;
  roomId = "";
  cards: Card[] = [];
  mustStack = false;
  hasCalledUno = false;
  lastDrawnCard = -1;
  canDraw = false;
  drawing = false;
  canPlay = false;
  canPickHand = false;
  canJumpIn = false;

  constructor(socket: Socket | null, bot: boolean = false) {
    this.bot = bot;
    this.id = uuid();
    this.socket = socket;
  }

  sortCards() {
    // order - red, green, blue, yellow, wildcard, plus4
    // - number 0 - 9, reverse, skip, plus2

    const cardColors: { [index: string]: Card[] } = {
      Red: [],
      Green: [],
      Blue: [],
      Yellow: [],
      Wildcard: [],
      Plus4: [],
    };

    const newCards: Card[] = [];
    Object.keys(cardColors).forEach((s: string) => {
      const color: CardColor = CardColor[s as keyof typeof CardColor];

      this.cards.forEach((c) => {
        if (c && (c.color === color || c.type === CardType[s as keyof typeof CardType]))
          cardColors[s].push(c);
      });

      // sort number cards
      cardColors[s].sort((c1, c2) => c1.number - c2.number);

      // sort reverse, skip, plus2
      const specialCards = cardColors[s].filter((c) => c.type !== CardType.None);
      specialCards.sort((c1, c2) => c2.type - c1.type);

      // remove special cards from array
      cardColors[s] = cardColors[s].filter((c) => c.type === CardType.None);

      // put special cards at the end
      cardColors[s].push(...specialCards);

      // merge into total cards
      newCards.push(...cardColors[s]);
    });

    this.cards = newCards;
  }

  clearPlayableCards() {
    this.cards = this.cards.map((c) => {
      c.playable = false;
      return c;
    });
  }

  findPlayableCards(topCard: Card) {
    this.cards.forEach((card) => (card ? card.checkIfPlayable(topCard, this.mustStack) : null));
  }

  botPlay(room: Room) {
    setTimeout(async () => {
      if (!this.cards) return;
      if (this.cards.findIndex((c) => c.playable) === -1) {
        if (!this.canDraw) return;

        await room.drawCards(this);
      }

      const playableCards = this.cards.filter((c) => c.playable);
      if (room.turn.id !== this.id || playableCards.length === 0) return;

      const card = playableCards[Math.floor(Math.random() * playableCards.length)];
      if (card && (card.type === CardType.Plus4 || card.type === CardType.Wildcard)) {
        room.wildcard = card;
        room.broadcastState();
        await sleep(2000);

        const colors = new Map<CardColor, number>();
        this.cards.forEach((c) => colors.set(c.color, (colors.get(c.color) || 0) + 1));

        if (Math.random() < 0.3) {
          card.color = Math.floor(Math.random() * 4);
        } else {
          const tuple = Array.from(colors.entries())
            .sort((a, b) => b[1] - a[1])
            .filter((t) => t[0] !== CardColor.None);

          card.color = tuple.length > 0 ? tuple[0][0] : <CardColor>(undefined as any);

          if (card.color === undefined) {
            card.color = Math.floor(Math.random() * 4);
          }
        }

        switch (card.color) {
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
      }

      if (this.cards.length === 2 && Math.random() > 0.3) {
        this.hasCalledUno = true;
        room.broadcastState();
      }

      room.playCard(
        this,
        this.cards.findIndex((c) => c === card)
      );
    }, 1500);
  }

  botSwapHands(r: Room) {
    const swap = r.players.filter((p) => p.id !== this.id).sort((a, b) => a.cards.length - b.cards.length)[0];
    r.swapHands(this, swap, true);
  }
}

function sleep(time: number) {
  return new Promise((resolve) => setTimeout(resolve, time));
}
