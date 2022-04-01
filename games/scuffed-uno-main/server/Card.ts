import { v4 as uuid } from "uuid";

export enum CardColor {
  Red = 0,
  Green,
  Yellow,
  Blue,
  None,
}

export enum CardType {
  None = 0,
  Plus2,
  Skip,
  Reverse,
  Wildcard,
  Plus4,
}

export class Card {
  id: string;
  number = 0;
  color: CardColor = 0;
  type: CardType = 0;
  playable: boolean = false;

  constructor(number: number, color: CardColor, type: CardType) {
    this.number = number;
    this.color = color;
    this.type = type;
    this.id = uuid();
  }

  checkIfPlayable(topCard: Card, mustStack: boolean) {
    this.playable = false;

    if (mustStack) {
      if (this.type === topCard.type) this.playable = true;
    } else {
      if (this.type === CardType.Plus4 || this.type === CardType.Wildcard) this.playable = true;
      else if (topCard.type === CardType.Plus4 || topCard.type === CardType.Wildcard) {
        if (this.color === topCard.color) this.playable = true;
      } else if (
        topCard.type === CardType.Plus2 ||
        topCard.type === CardType.Reverse ||
        topCard.type === CardType.Skip
      ) {
        if (this.type === topCard.type || this.color === topCard.color) this.playable = true;
      } else if (this.color === topCard.color || this.number === topCard.number) {
        this.playable = true;
      }
    }
  }
}
