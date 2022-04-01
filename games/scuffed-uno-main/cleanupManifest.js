const fs = require("fs");
let html = fs.readFileSync("./client/dist/index.html", "utf-8");
html = html.replace('<link rel="manifest" href="/remove-manifest.json">', "");
fs.writeFileSync("./client/dist/index.html", html);
fs.unlinkSync("./client/dist/remove-manifest.json");
