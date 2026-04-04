# Ordo web

Vite + React + TypeScript app that shows **psalms for each hour of the day** (Matins through Compline) in **Latin** and **English**, using the same rules as Swift `HoursService.getPsalmsForWeekday` and `ordo/Services/HoursService/horas.json`, with text from `ordo/Services/PsalmService/psalms_classic.json`.

## Commands

From this directory:

```bash
npm install
npm run dev
```

The dev server uses port **5180** (see `vite.config.ts`). Override anytime: `npm run dev -- --port 5190`.

Production build:

```bash
npm run build
npm run preview
```

Serve `dist/` behind Tailscale, Caddy, nginx, or any static host.

## Data

- **Schedule:** `../../ordo/Services/HoursService/horas.json` — choose **Hour**, **Weekday**, and **Winter/Summer** (Matins and Lauds follow the seasonal tables; other hours ignore season when they have no `winter`/`summer` block).
- **Text:** `../../ordo/Services/PsalmService/psalms_classic.json` (not the gitignored `psalms.json`).
- **Themes:** `../../ordo/Services/LatinService/themes_classic.json` — `structuralThemes` and `conceptualThemes` per psalm number + category, resolved in `src/themes.ts` (same idea as Swift `PsalmThemeManager`).

To use your full `psalms.json` instead, replace the import in `src/liturgy.ts` and ensure the JSON is either `{ "psalms": [...] }` or a flat array, matching `PsalmService` expectations.
