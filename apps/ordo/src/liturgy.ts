import horasJson from "../../../ordo/Services/HoursService/horas.json";
import psalmsClassic from "../../../ordo/Services/PsalmService/psalms_classic.json";
import { parsePsalmUsageString } from "./parseUsage";
import type { PsalmRecord, PsalmUsage } from "./types";

const WEEKDAYS = [
  "sunday",
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday",
] as const;

export type Weekday = (typeof WEEKDAYS)[number];

/** Liturgical hours present in `horas.json` (display order). */
export const HOUR_ORDER = [
  "matins",
  "lauds",
  "prime",
  "terce",
  "sext",
  "none",
  "vespers",
  "compline",
] as const;

export type HourKey = (typeof HOUR_ORDER)[number];

export const HOUR_LABEL: Record<HourKey, string> = {
  matins: "Matins",
  lauds: "Lauds",
  prime: "Prime",
  terce: "Terce",
  sext: "Sext",
  none: "None",
  vespers: "Vespers",
  compline: "Compline",
};

export function isWeekday(s: string): s is Weekday {
  return (WEEKDAYS as readonly string[]).includes(s);
}

export function weekdayFromDate(d: Date): Weekday {
  return WEEKDAYS[d.getDay()];
}

function parseStringArray(v: unknown): string[] {
  if (!Array.isArray(v)) {
    return [];
  }
  return v.filter((x): x is string => typeof x === "string");
}

/**
 * Matches `HoursService.getPsalmsForWeekday` (prefix / weekday / winter|summer / default / suffix).
 * Pass `season` like Swift (`"winter"` / `"summer"`). Hours without seasonal blocks ignore it.
 */
export function getPsalmStringsForHour(
  hourKey: string,
  weekday: Weekday,
  season: "winter" | "summer",
): string[] {
  const horas = horasJson as Record<string, { psalms?: Record<string, unknown> } | undefined>;
  const hour = horas[hourKey];
  const ps = hour?.psalms;
  if (!ps || typeof ps !== "object") {
    return [];
  }

  const weekdayOnly = parseStringArray(ps[weekday]);
  if (weekdayOnly.length > 0) {
    return weekdayOnly;
  }

  const out: string[] = [];
  out.push(...parseStringArray(ps.prefix));

  const group = ps[season] as Record<string, unknown> | undefined;
  if (group && typeof group === "object") {
    let dayList = parseStringArray(group[weekday]);
    if (dayList.length === 0 && weekday !== "sunday") {
      dayList = parseStringArray(group.weekday);
    }
    out.push(...dayList);
  }

  if (out.length === 0) {
    out.push(...parseStringArray(ps.default));
  }

  out.push(...parseStringArray(ps.suffix));

  return out;
}

export function usagesForHour(
  hourKey: string,
  weekday: Weekday,
  season: "winter" | "summer",
): PsalmUsage[] {
  return getPsalmStringsForHour(hourKey, weekday, season).map(parsePsalmUsageString);
}

export function availableHourKeys(): HourKey[] {
  const horas = horasJson as Record<string, unknown>;
  return HOUR_ORDER.filter((k) => k in horas);
}

const classic = psalmsClassic as { psalms: PsalmRecord[] };

export const allPsalms: PsalmRecord[] = classic.psalms;
