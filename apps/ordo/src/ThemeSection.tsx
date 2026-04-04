import type { ConceptualTheme, StructuralTheme } from "./themeTypes";

function LemmaTags({ lemmas }: { lemmas: string[] }) {
  if (lemmas.length === 0) {
    return null;
  }
  return (
    <p className="theme-lemmas">
      <span className="theme-lemmas-label">Lemmas:</span>{" "}
      {lemmas.map((l) => (
        <span key={l} className="lemma-tag">
          {l}
        </span>
      ))}
    </p>
  );
}

function StructuralCard({ t }: { t: StructuralTheme }) {
  return (
    <article className="theme-card theme-card-structural">
      <h4 className="theme-card-title">{t.name}</h4>
      <p className="theme-card-desc">{t.description}</p>
      <p className="theme-meta">
        Lines {t.startLine}–{t.endLine}
      </p>
      <LemmaTags lemmas={t.lemmas} />
      {t.comment ? <p className="theme-comment">{t.comment}</p> : null}
      {t.comment2 ? <p className="theme-comment theme-comment2">{t.comment2}</p> : null}
    </article>
  );
}

function ConceptualCard({ t }: { t: ConceptualTheme }) {
  const range =
    t.lineRange &&
    typeof t.lineRange.start === "number" &&
    typeof t.lineRange.end === "number"
      ? `Lines ${t.lineRange.start}–${t.lineRange.end}`
      : null;
  return (
    <article className="theme-card theme-card-conceptual">
      <h4 className="theme-card-title">
        {t.name}{" "}
        <span className="theme-category-pill">{t.category}</span>
      </h4>
      <p className="theme-card-desc">{t.description}</p>
      {range ? <p className="theme-meta">{range}</p> : null}
      <LemmaTags lemmas={t.lemmas} />
    </article>
  );
}

export function ThemeSection({
  structural,
  conceptual,
}: {
  structural: StructuralTheme[];
  conceptual: ConceptualTheme[];
}) {
  if (structural.length === 0 && conceptual.length === 0) {
    return null;
  }

  return (
    <details className="theme-section">
      <summary>Themes</summary>
      {structural.length > 0 ? (
        <div className="theme-group">
          <h3 className="theme-group-title">Structural</h3>
          <div className="theme-cards">
            {structural.map((t) => (
              <StructuralCard key={`${t.name}-${t.startLine}-${t.endLine}`} t={t} />
            ))}
          </div>
        </div>
      ) : null}
      {conceptual.length > 0 ? (
        <div className="theme-group">
          <h3 className="theme-group-title">Conceptual</h3>
          <div className="theme-cards">
            {conceptual.map((t, i) => (
              <ConceptualCard key={`c-${i}-${t.name}`} t={t} />
            ))}
          </div>
        </div>
      ) : null}
    </details>
  );
}
