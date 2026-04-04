import { useMemo, useState } from "react";
import "./App.css";
import {
  allPsalms,
  availableHourKeys,
  HOUR_LABEL,
  isWeekday,
  usagesForHour,
  weekdayFromDate,
  type HourKey,
  type Weekday,
} from "./liturgy";
import { findPsalm } from "./psalmLookup";
import { ThemeSection } from "./ThemeSection";
import { findThemeEntry } from "./themes";

const WEEKDAY_LABEL: Record<Weekday, string> = {
  sunday: "Sunday",
  monday: "Monday",
  tuesday: "Tuesday",
  wednesday: "Wednesday",
  thursday: "Thursday",
  friday: "Friday",
  saturday: "Saturday",
};

function isHourKey(s: string): s is HourKey {
  return s in HOUR_LABEL;
}

/** Hour, weekday, and position in this hour’s psalm list (not the biblical psalm number). */
function psalmContextLine(
  hourLabel: string,
  weekday: Weekday,
  index: number,
  total: number,
): string {
  return `${hourLabel} · ${WEEKDAY_LABEL[weekday]} · ${index + 1} of ${total}`;
}

function PsalmBody({
  title,
  context,
  latin,
  english,
}: {
  title: string;
  context: string;
  latin: string[];
  english: string[];
}) {
  const n = Math.max(latin.length, english.length);
  const rows = Array.from({ length: n }, (_, i) => ({
    i: i + 1,
    la: latin[i] ?? "",
    en: english[i] ?? "",
  }));
  return (
    <section
      className="psalm-block"
      aria-label={`${title}. ${context}`}
    >
      <h2>{title}</h2>
      <p className="psalm-context">{context}</p>
      <div className="verses">
        {rows.map(({ i, la, en }) => (
          <div key={i} className="verse-row">
            <div className="la">
              <span className="verse-num">{i}</span> {la}
            </div>
            <div className="en">
              <span className="verse-num" aria-hidden />
              {en}
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}

export default function App() {
  const hours = availableHourKeys();
  const today = weekdayFromDate(new Date());
  const [weekday, setWeekday] = useState<Weekday>(today);
  const [hour, setHour] = useState<HourKey>(() =>
    hours.includes("prime") ? "prime" : hours[0] ?? "prime",
  );
  const [season, setSeason] = useState<"winter" | "summer">("winter");

  const usages = useMemo(
    () => usagesForHour(hour, weekday, season),
    [hour, weekday, season],
  );

  const hourTitle = HOUR_LABEL[hour];

  return (
    <div className="app">
      <header className="app-header">
        <h1>{hourTitle}</h1>
        <p>
          Benedictine divine office — psalms in Latin and English (Douay–Rheims
          style English where present). Matins and Lauds use the winter/summer
          psalter from <code>horas.json</code>.
        </p>
        <div className="controls">
          <label>
            Hour
            <select
              value={hour}
              onChange={(e) => {
                const v = e.target.value;
                if (isHourKey(v)) {
                  setHour(v);
                }
              }}
            >
              {hours.map((h) => (
                <option key={h} value={h}>
                  {HOUR_LABEL[h]}
                </option>
              ))}
            </select>
          </label>
          <label>
            Weekday
            <select
              value={weekday}
              onChange={(e) => {
                const v = e.target.value;
                if (isWeekday(v)) {
                  setWeekday(v);
                }
              }}
            >
              {(Object.keys(WEEKDAY_LABEL) as Weekday[]).map((d) => (
                <option key={d} value={d}>
                  {WEEKDAY_LABEL[d]}
                  {d === today ? " (today)" : ""}
                </option>
              ))}
            </select>
          </label>
          <label>
            Season
            <select
              value={season}
              onChange={(e) => {
                const v = e.target.value;
                if (v === "winter" || v === "summer") {
                  setSeason(v);
                }
              }}
            >
              <option value="winter">Winter</option>
              <option value="summer">Summer</option>
            </select>
          </label>
        </div>
      </header>

      <main>
        {usages.map((usage, index) => {
          const found = findPsalm(allPsalms, usage);
          const titleParts = [
            `Psalm ${usage.number}`,
            usage.category ? `(${usage.category})` : "",
          ]
            .filter(Boolean)
            .join(" ");

          const n = Number.parseInt(usage.number, 10);
          const themeEntry =
            !Number.isNaN(n) ? findThemeEntry(n, usage.category) : undefined;
          const structural = themeEntry?.structuralThemes ?? [];
          const conceptual = themeEntry?.conceptualThemes ?? [];

          const context = psalmContextLine(
            hourTitle,
            weekday,
            index,
            usages.length,
          );

          if (!found) {
            return (
              <div
                key={`${usage.number}-${usage.category ?? ""}-${index}`}
                className="psalm-stack"
              >
                <section
                  className="psalm-block"
                  aria-label={`${titleParts}. ${context}`}
                >
                  <h2>{titleParts}</h2>
                  <p className="psalm-context">{context}</p>
                  <p className="missing">
                    Text not found in bundled psalter. If you use a custom{" "}
                    <code>psalms.json</code>, ensure it includes this psalm and
                    section.
                  </p>
                </section>
                <ThemeSection structural={structural} conceptual={conceptual} />
              </div>
            );
          }

          const latin = found.text;
          const english = found.englishText ?? [];

          return (
            <div
              key={`${usage.number}-${usage.category ?? ""}-${index}`}
              className="psalm-stack"
            >
              <PsalmBody
                title={titleParts}
                context={context}
                latin={latin}
                english={english}
              />
              <ThemeSection structural={structural} conceptual={conceptual} />
            </div>
          );
        })}
      </main>
    </div>
  );
}
