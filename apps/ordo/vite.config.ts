import path from "node:path";
import { fileURLToPath } from "node:url";
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

const appsOrdo = path.dirname(fileURLToPath(new URL(import.meta.url)));
const repoRoot = path.resolve(appsOrdo, "../..");

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5180,
    fs: {
      allow: [repoRoot],
    },
  },
});
