import themesClassic from "../../../ordo/Services/LatinService/themes_classic.json";
import type { PsalmThemeEntry } from "./themeTypes";

const entries = themesClassic as PsalmThemeEntry[];

/** Match Swift `PsalmThemeManager`: empty string vs section letter (JSON uses lowercase, e.g. `"a"`, `"aleph"`). */
export function normalizeThemeCategory(category: string | null | undefined): string {
  if (category == null) {
    return "";
  }
  const t = category.trim();
  if (t === "") {
    return "";
  }
  return t.toLowerCase();
}

/**
 * One row in `themes_classic.json` per psalm + section; same filter as
 * `getThemes(for:category:)` / `getConceptualThemes(for:category:)`.
 */
export function findThemeEntry(
  psalmNumber: number,
  category: string | null,
): PsalmThemeEntry | undefined {
  const c = normalizeThemeCategory(category);
  return entries.find(
    (e) =>
      e.psalmNumber === psalmNumber &&
      normalizeThemeCategory(e.category) === c,
  );
}
