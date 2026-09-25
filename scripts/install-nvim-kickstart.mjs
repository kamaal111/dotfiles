import os from "node:os";
import path from "node:path";
import fs from "node:fs/promises";
import { execFileSync } from "node:child_process";

const destination = path.join(os.homedir(), ".config/nvim-kickstart");
const url = "https://github.com/kamaal111/kickstart.nvim.git";

try {
  const repoExists = await fs.stat(destination).then(() => true, () => false);
  if (repoExists) {
    const gitExists = await fs.stat(path.join(destination, ".git")).then(() => true, () => false);
    if (!gitExists) {
      throw new Error(`${destination} exists but is not a Git repository`);
    }
    console.log("updating repo");
    execFileSync("git", ["-C", destination, "pull", "--ff-only"], { stdio: "inherit" });
  } else {
    console.log("cloning repo");
    await fs.mkdir(path.dirname(destination), { recursive: true });
    execFileSync("git", ["clone", url, destination], { stdio: "inherit" });
  }
} catch (error) {
  console.error(error);
  process.exitCode = 1;
}
