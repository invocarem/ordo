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
        let pronounMap: [String: String] = [
            "tu": "you (sg)",
            "ego": "I",
            "nos": "we",
            "vos": "you (pl)",
            "is": "he",
            "ea": "she",
            "id": "it"
        ]
        
        let pronounText = pronounMap[lemma.lowercased()] ?? translation
        
        // Handle vocative first
        if let vocativeForm = vocative?.lowercased(), vocativeForm == form {
            return "O \(pronounText)! (vocative)"
        }
        
        // Handle other cases
        switch form {
        case nominative?.lowercased(): return "\(pronounText) (nominative)"
        case dative?.lowercased(): return "to/for \(pronounText) (dative)"
        case accusative?.lowercased(): return "\(pronounText) (accusative)"
        case genitive?.lowercased(): return "of \(pronounText) (genitive)"
        case ablative?.lowercased(): return "by/with \(pronounText) (ablative)"
        default: return nil
        }
    }
    
    private func analyzeVerbForm(form: String, translation: String) -> String? {
        // Handle principal parts first
        if let infinitive = infinitive, infinitive.lowercased() == form {
            return "to \(translation) (infinitive)"
        }
        if let perfect = perfect, perfect.lowercased() == form {
            return "has/have \(translation)ed (perfect)"
        }
        
        // Handle conjugated forms
        return analyzeVerbConjugation(form: form, translation: translation)
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
        let isPlural = [nominative_plural, genitive_plural, dative_plural,
                       accusative_plural, ablative_plural].contains { $0?.lowercased() == form }
        
        let pluralSuffix = isPlural ? " (pl)" : ""
        let pluralTranslation = isPlural ? translation + "s" : translation
        
        switch form {
        case nominative?.lowercased(), nominative_plural?.lowercased():
            return "\(pluralTranslation)\(pluralSuffix)"
        case genitive?.lowercased(), genitive_plural?.lowercased():
            return "of \(pluralTranslation)\(pluralSuffix)"
        case dative?.lowercased(), dative_plural?.lowercased():
            return "to/for \(pluralTranslation)\(pluralSuffix)"
        case accusative?.lowercased(), accusative_plural?.lowercased():
            return "\(pluralTranslation)\(pluralSuffix) (direct object)"
        case ablative?.lowercased(), ablative_plural?.lowercased():
            return "with/by \(pluralTranslation)\(pluralSuffix)"
        case vocative?.lowercased():
            return "O \(pluralTranslation)!\(pluralSuffix)"
        default:
            return "[unknown form: \(form)]"
        }
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


    
   
 
