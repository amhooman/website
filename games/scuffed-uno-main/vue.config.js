const path = require("path");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = {
  publicPath: process.env.NODE_ENV === "production" ? "./" : "/",

  chainWebpack: (config) => {
    config.plugin("html").tap((args) => {
      args[0].title = "Scuffed Uno - Play UNO online with friends";
      args[0].template = "client/public/index.html";
      return args;
    });

    config.entry("app").clear();
    config.entry("app").add("./client/src/main.js");
  },

  configureWebpack: {
    resolve: {
      alias: {
        "@": path.resolve(__dirname, "client/src"),
      },
    },

    plugins: [
      new CopyWebpackPlugin({
        patterns: [
          {
            from: path.join(__dirname, "client/public"),
            to: path.join(__dirname, "client/dist"),
            globOptions: {
              ignore: ["index.html"],
            },
          },
        ],
      }),
    ],
  },

  pwa: {
    name: "Scuffed Uno",
    themeColor: "#570001",
    msTileColor: "#570001",
    appleMobileWebAppCapable: "yes",
    appleMobileWebAppStatusBarStyle: "default",
    manifestPath: "remove-manifest.json",
    iconPaths: {
      favicon32: null,
      favicon16: null,
      appleTouchIcon: null,
      maskIcon: null,
      msTileImage: null,
    },
    workboxPluginMode: "InjectManifest",
    workboxOptions: {
      // swSrc is required in InjectManifest mode.
      swSrc: "client/public/service-worker.js",
      // ...other Workbox options...
      exclude: [/\.map$/, /_redirects/],
    },
  },

  outputDir: "client/dist",
};
