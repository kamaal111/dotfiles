import os from "node:os";
import path from "node:path";
import fs from "node:fs/promises";
import asyncExec from "@kamaalio/kamaal/shell/async-exec";

async function getOrCloneRepository({
  url,
  destination,
}: {
  url: string;
  destination: string;
}) {
  const gitPath = path.join(destination, ".git");
  const gitExists = await fs.exists(gitPath);
  if (!gitExists) {
    fs.rm(destination, { recursive: true, force: true });
  }
  const repoExists = await fs.exists(destination);
  if (repoExists) {
    console.log("updating repo");
    return asyncExec("git pull --rebase", destination);
  }

  console.log("cloning repo");
  await fs.mkdir(destination, { recursive: true });
  return asyncExec(`git clone ${url}`, destination);
}

async function main() {
  const result = await getOrCloneRepository({
    url: "https://github.com/kamaal111/kickstart.nvim.git",
    destination: path.join(os.homedir(), ".config/nvim-kickstart"),
  });

  console.log("result", result.unwrap());
}

main();
