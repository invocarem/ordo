//
//  LatinAnalyzer.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-27.
//

import Foundation

extension LatinWordEntity {
    
    // MARK: - Public Analysis Methods
    
    public func analyzeFormWithMeaning(_ form: String) -> String {
        let formLower = form.lowercased()
        let translation = getTranslation() ?? lemma.lowercased()
       
        // Handle by part of speech
        if let analysis = analyzeByPartOfSpeech(form: formLower, translation: translation) {
            return analysis
        }
       
        // Handle possessive forms if no match yet
        if let possessiveAnalysis = analyzePossessiveForm(form: formLower, translation: translation) {
            return possessiveAnalysis
        }
       
        // Default case analysis for nouns/adjectives
        return analyzeNounAdjectiveForm(form: formLower, translation: translation)
    }
    
    // MARK: - Private Analysis Methods
    
    private func analyzeByPartOfSpeech(form: String, translation: String) -> String? {
        guard let partOfSpeech = partOfSpeech else { return nil }
        
        switch partOfSpeech {
        case .adverb:
            return "\(translation) (adverb)"
            
        case .pronoun:
            return analyzePronounForm(form: form, translation: translation)
            
        case .verb:
            return analyzeVerbForm(form: form, translation: translation)
            
        case .preposition, .conjunction:
            return "\(translation) (\(partOfSpeech.rawValue))"
            
        default:
            return nil
        }
    }
    private func analyzePronounForm(form: String, translation: String) -> String? {
        let lowerForm = form.lowercased()
        
        // 1. Handle vocative first (unchanged)
        if let vocativeForm = vocative?.lowercased(), vocativeForm == lowerForm {
            let pronounText = getPronounText(translation: translation)
            return "O \(pronounText)! (vocative)"
        }
        
        // 2. Check gendered forms in "forms" dictionary (e.g., accusative_f for feminine)
       if let forms = forms {
            for (key, formVariants) in forms {
                for formVariant in formVariants {
                    if formVariant.lowercased() == lowerForm {
                        let caseName = key
                            .replacingOccurrences(of: "_f", with: " (feminine)")
                            .replacingOccurrences(of: "_n", with: " (neuter)")
                            .replacingOccurrences(of: "_", with: " ")
                        return "\(translation) (\(caseName))"
                    }
                }
            }
        }
        
        // 3. Fall back to root-level cases (default gender, usually masculine)
        switch lowerForm {
            case nominative?.lowercased(): return "\(getPronounText(translation: translation)) (nominative)"
            case dative?.lowercased(): return "to/for \(getPronounText(translation: translation)) (dative)"
            case accusative?.lowercased(): return "\(getPronounText(translation: translation)) (accusative)"
            case genitive?.lowercased(): return "of \(getPronounText(translation: translation)) (genitive)"
            case ablative?.lowercased(): return "by/with \(getPronounText(translation: translation)) (ablative)"
            default: return nil
        }
    }

    // Helper to map lemma to pronoun text (e.g., "tuus" → "your")
    private func getPronounText(translation: String) -> String {
        let pronounMap: [String: String] = [
            "tu": "you (sg)",
            "ego": "I",
            "nos": "we",
            "vos": "you (pl)",
            "is": "he",
            "ea": "she",
            "id": "it",
            "tuus": "your",  // Possessive pronouns
            "meus": "my",
            "suus": "his/her/its"
        ]
        return pronounMap[lemma.lowercased()] ?? translation
    }
    
    private func analyzeVerbForm(form: String, translation: String) -> String? {
        let lowerForm = form.lowercased()

        // Handle principal parts first
        if let infinitive = infinitive, infinitive.lowercased() == form {
            return "to \(translation) (infinitive)"
        }

        if let perfect = perfect, perfect.lowercased() == form {
            return "has/have \(translation)ed (perfect)"
        }

        if let gerundResult = analyzeGerund(form: lowerForm, translation: translation) {
            return gerundResult
        }
            
          
        
        // Handle conjugated forms
        return analyzeVerbConjugation(form: form, translation: translation)
    }
    private func analyzeGerund(form: String, translation: String) -> String? {
        guard let forms = forms else { return nil }
        
        for (key, values) in forms {
            guard values.contains(where: { $0.lowercased() == form }) else { continue }
            
            if key.hasPrefix("gerund_") {
                let caseName = key.replacingOccurrences(of: "gerund_", with: "")
                return "\(translation)ing (gerund \(caseName))"
            }
            
            if key.hasPrefix("gerundive_") {
                let parts = key.replacingOccurrences(of: "gerundive_", with: "").split(separator: "_")
                let gender = parts.first ?? "unknown"
                let caseName = parts.last ?? "unknown"
                return "must be \(translation)ed (\(gender) \(caseName))"
            }
        }
        return nil
    }
    
    private func analyzeVerbConjugation(form: String, translation: String) -> String? {
        guard let forms = forms else { return nil }
        
        for (tense, formArray) in forms {
            for (index, formVariants) in formArray.enumerated() {
                guard matchesVariant(form: form, target: formVariants) else { continue }
                
                let (person, number) = getPersonAndNumber(index: index)
                
                switch tense {
                case "present": return "\(person) \(translation)\(number)"
                case "imperfect": return "\(person) was \(translation)ing\(number)"
                case "future": return "\(person) will \(translation)\(number)"
                case "perfect": return "\(person) has \(translation)ed\(number)"
                case "pluperfect": return "\(person) had \(translation)ed\(number)"
                case "imperative_singular": return "\(translation.capitalized)! (command)"
                case "imperative_plural": return "\(translation.capitalized)! (pl command)"
                case "present_subjunctive": return "\(person) may \(translation)\(number) (subjunctive)"
                case "imperfect_subjunctive": return "\(person) might \(translation)\(number)"
                default: return "\(translation) (\(tense))"
                }
            }
        }
        return nil
    }
    
    private func analyzePossessiveForm(form: String, translation: String) -> String? {
        guard let possessive = possessive else { return nil }
        
        let possessorMap: [String: String] = [
            "meus": "my",
            "tuus": "your",
            "suus": "his/her/its",
            "noster": "our",
            "vester": "your (pl)"
        ]
        
        let possessor = possessorMap[lemma.lowercased()] ?? "your"
        
        // Check both singular and plural forms
        let allForms = [(possessive.singular, "sg"), (possessive.plural, "pl")]
        for (forms, number) in allForms {
            for (gender, cases) in forms ?? [:] {
                for (caseName, formValue) in cases {
                    if formValue.lowercased() == form {
                        return "\(possessor) \(gender) (\(number) \(caseName))"
                    }
                }
            }
        }
        
        return nil
    }
    private func analyzeNounAdjectiveForm(form: String, translation: String) -> String {
        let lowerForm = form.lowercased()
        
        // 1. First check root-level forms (masculine by default)
        let rootCases = [
            ("nominative", nominative),
            ("genitive", genitive),
            ("dative", dative),
            ("accusative", accusative),
            ("ablative", ablative),
            ("vocative", vocative),
            ("nominative_plural", nominative_plural),
            ("genitive_plural", genitive_plural),
            ("dative_plural", dative_plural),
            ("accusative_plural", accusative_plural),
            ("ablative_plural", ablative_plural)
        ]
        
        for (caseName, caseForm) in rootCases {
            if caseForm?.lowercased() == lowerForm {            
                return "\(translation) (\(caseName.replacingOccurrences(of: "_", with: " ")))"
            }
        }
        if let formsDict = forms {
            for (caseKey, formVariants) in formsDict {
                
                for formVariant in formVariants {
                    
                    if formVariant.lowercased() == lowerForm {
                        let gender = caseKey.contains("_f") ? "feminine" : 
                                    caseKey.contains("_n") ? "neuter" : "masculine"
                        let cleanCase = caseKey
                            .replacingOccurrences(of: "_f", with: "")
                            .replacingOccurrences(of: "_n", with: "")
                            .replacingOccurrences(of: "_", with: "")
                        return "\(translation) (\(cleanCase) \(gender))"
                    }
                }
            }
        }
        if lowerForm == lemma.lowercased() {
            return translation
        }
        
        return "[unknown form: \(form)]"
    }
        
    // MARK: - Helper Methods
    
    private func matchesVariant(form: String, target: String) -> Bool {
        return target.lowercased()
            .components(separatedBy: "/")
            .contains { $0 == form }
    }
    
    private func getPersonAndNumber(index: Int) -> (person: String, number: String) {
        switch index {
        case 0: return ("I", "")
        case 1: return ("you", " (sg)")
        case 2: return ("he/she/it", "")
        case 3: return ("we", "")
        case 4: return ("you", " (pl)")
        case 5: return ("they", "")
        default: return ("", "")
        }
    }
}


    
   
 
