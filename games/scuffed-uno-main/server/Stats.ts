import { fetchStats, writeStats } from "../modules/github";

type STAT =
  | "lobbiesOnline"
  | "playersOnline"
  | "totalVisits"
  | "lobbiesCreated"
  | "gamesPlayed"
  | "botsUsed"
  | "unosCalled"
  | "cardsPlayed"
  | "plus4sDealt"
  | "pickedColors";

interface Stats {
  [index: string]: any;
  lobbiesOnline: number;
  playersOnline: number;
  totalVisits: number;
  lobbiesCreated: number;
  gamesPlayed: number;
  botsUsed: number;
  unosCalled: number;
  cardsPlayed: number;
  plus4sDealt: number;

  pickedColors: {
    red: number;
    blue: number;
    green: number;
    yellow: number;
  };
}

let STATS: Stats = {
  lobbiesOnline: 0,
  playersOnline: 0,
  totalVisits: 0,
  lobbiesCreated: 0,
  gamesPlayed: 0,
  botsUsed: 0,
  unosCalled: 0,
  cardsPlayed: 0,
  plus4sDealt: 0,
  pickedColors: {
    red: 0,
    blue: 0,
    green: 0,
    yellow: 0,
  },
};

const incrementStat = (stat: STAT, inc: number): boolean => {
  if (
    STATS[stat] === undefined ||
    stat === "pickedColors" ||
    STATS[stat] + inc < 0 ||
    STATS[stat] + inc >= Number.POSITIVE_INFINITY
  )
    return false;

  STATS[stat] += inc;
  return true;
};

const decrementStat = (stat: STAT, dec: number): boolean => {
  if (
    STATS[stat] === undefined ||
    stat === "pickedColors" ||
    STATS[stat] - dec < 0 ||
    STATS[stat] - dec >= Number.POSITIVE_INFINITY
  )
    return false;

  STATS[stat] -= dec;
  return true;
};

const incrementPickedColors = (color: "red" | "blue" | "green" | "yellow", inc: number): boolean => {
  if (
    STATS.pickedColors[color] == undefined ||
    STATS.pickedColors[color] + inc < 0 ||
    STATS.pickedColors[color] + inc >= Number.POSITIVE_INFINITY
  )
    return false;

  STATS.pickedColors[color] += inc;
  return true;
};

const decrementPickedColors = (color: "red" | "blue" | "green" | "yellow", dec: number): boolean => {
  if (
    STATS.pickedColors[color] == undefined ||
    STATS.pickedColors[color] - dec < 0 ||
    STATS.pickedColors[color] - dec >= Number.POSITIVE_INFINITY
  )
    return false;

  STATS.pickedColors[color] -= dec;
  return true;
};

// update stats github gist

setInterval(async () => {
  if (process.env.NODE_ENV !== "production") return;

  const cloud = await fetchStats();
  if (cloud.lobbiesOnline === undefined) return console.log("Empty cloud");

  const total: Stats = {
    lobbiesOnline: STATS.lobbiesOnline,
    playersOnline: STATS.playersOnline,
    totalVisits: STATS.totalVisits + cloud.totalVisits,
    lobbiesCreated: STATS.lobbiesCreated + cloud.lobbiesCreated,
    gamesPlayed: STATS.gamesPlayed + cloud.gamesPlayed,
    botsUsed: STATS.botsUsed + cloud.botsUsed,
    unosCalled: STATS.unosCalled + cloud.unosCalled,
    cardsPlayed: STATS.cardsPlayed + cloud.cardsPlayed,
    plus4sDealt: STATS.plus4sDealt + cloud.plus4sDealt,
    pickedColors: {
      red: STATS.pickedColors.red + cloud.pickedColors.red,
      blue: STATS.pickedColors.blue + cloud.pickedColors.blue,
      green: STATS.pickedColors.green + cloud.pickedColors.green,
      yellow: STATS.pickedColors.yellow + cloud.pickedColors.yellow,
    },
  };

  STATS = {
    lobbiesOnline: 0,
    playersOnline: 0,
    totalVisits: 0,
    lobbiesCreated: 0,
    gamesPlayed: 0,
    botsUsed: 0,
    unosCalled: 0,
    cardsPlayed: 0,
    plus4sDealt: 0,
    pickedColors: {
      red: 0,
      blue: 0,
      green: 0,
      yellow: 0,
    },
  };

  await writeStats(JSON.stringify(total));
}, 300000);

export { incrementStat, decrementStat, incrementPickedColors, decrementPickedColors };
