import type { PsalmUsage } from "./types";

/**
 * Mirrors Swift `PsalmUsage` decoding: e.g. "118 aleph", "9 A", "50 :Alleluia" (antiphon after colon is ignored for lookup).
 */
export function parsePsalmUsageString(raw: string): PsalmUsage {
  const trimmed = raw.trim();
  const colon = trimmed.indexOf(":");
  const mainPart = (colon >= 0 ? trimmed.slice(0, colon) : trimmed).trim();
  const parts = mainPart.split(/\s+/).filter(Boolean);
  if (!parts[0]) {
    return { number: "", category: null };
  }
  const number = parts[0];
  const category = parts.length > 1 ? parts.slice(1).join(" ") : null;
  return { number, category };
}
