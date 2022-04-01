import { Octokit } from "octokit";

const token = require("../githubToken");

const gist_id = "3fbffb9c94575acd9aac4d1c58b8b8d0";

const octokit = new Octokit({ auth: token });

export async function fetchStats() {
  return JSON.parse(
    await octokit
      .request("GET /gists/{gist_id}", {
        gist_id,
      })
      .then((res) => {
        return res.data.files ? res.data.files["scuffed-uno-stats.json"]?.content || "{}" : "{}";
      })
      .catch((err) => {
        console.log(err);
        return "{}";
      })
  );
}

export async function writeStats(content: string) {
  try {
    await octokit.request("PATCH /gists/{gist_id}", {
      gist_id,
      files: {
        "scuffed-uno-stats.json": {
          content,
        },
      },
    });

    return true;
  } catch (error) {
    console.log(error);
    return false;
  }
}
