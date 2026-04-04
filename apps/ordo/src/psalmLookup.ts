import type { PsalmRecord, PsalmUsage } from "./types";

function normalizeSection(s: string | undefined): string {
  return (s ?? "").trim();
}

/**
 * Match Swift `PsalmService.getPsalm(number:section:)` semantics.
 */
export function findPsalm(
  psalms: PsalmRecord[],
  usage: PsalmUsage,
): PsalmRecord | undefined {
  const num = Number.parseInt(usage.number, 10);
  if (Number.isNaN(num)) {
    return undefined;
  }

  const wantCat = usage.category;
  const wantEmpty = !wantCat || wantCat.length === 0;

  return psalms.find((p) => {
    if (p.number !== num) {
      return false;
    }
    const sec = normalizeSection(p.section);
    if (wantEmpty) {
      return sec === "";
    }
    return sec.toLowerCase() === wantCat!.toLowerCase();
  });
}
