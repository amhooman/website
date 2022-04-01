import Vue from "vue";
import VueRouter from "vue-router";
const Home = () => import("@/views/Home.vue");
const Game = () => import("@/views/Game.vue");
const Stats = () => import("@/views/Stats.vue");

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/game",
    name: "Game",
    component: Game,
  },
  {
    path: "/stats",
    name: "Stats",
    component: Stats,
  },
];

const router = new VueRouter({
  mode: "history",
  routes,
});

export default router;
