/** Matches `LatinThematicAnalysis.PsalmThemeData` / `themes_classic.json`. */
export type StructuralTheme = {
  name: string;
  description: string;
  lemmas: string[];
  startLine: number;
  endLine: number;
  comment?: string | null;
  comment2?: string | null;
};

export type ConceptualTheme = {
  name: string;
  description: string;
  lemmas: string[];
  category: string;
  lineRange?: { start: number; end: number } | null;
};

export type PsalmThemeEntry = {
  psalmNumber: number;
  category: string;
  structuralThemes: StructuralTheme[];
  conceptualThemes?: ConceptualTheme[] | null;
};
