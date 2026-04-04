/** One psalm entry from psalms JSON (classic or flat array). */
export type PsalmRecord = {
  number: number;
  section?: string;
  title?: string;
  text: string[];
  englishText?: string[];
  verified?: boolean;
};

export type PsalmUsage = {
  number: string;
  category: string | null;
};
