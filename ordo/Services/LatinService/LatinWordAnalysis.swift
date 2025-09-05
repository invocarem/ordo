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

        case .numeral:
            return "\(translation) (numeral)"            
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
                        let (caseName, gender) = parseFormKey(key)
                        return "\(translation) (\(caseName) \(gender))"
                    }
                }
            }
        }

         // 3. Check gendered forms in "forms_plural" dictionary (plural)
        if let formsPlural = formsPlural {
            for (key, formVariants) in formsPlural {
                for formVariant in formVariants {
                    if formVariant.lowercased() == lowerForm {
                        let (caseName, gender) = parseFormKey(key)
                        return "\(translation) (\(caseName) plural \(gender))"
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

        if let passiveAnalysis = analyzeVerbPassive(form: lowerForm, translation: translation) {
            return passiveAnalysis
        }

        if let gerundResult = analyzeGerund(form: lowerForm, translation: translation) {
            return gerundResult
        }
           
          
        
        // Handle conjugated forms
        if let conjugationResult = analyzeVerbConjugation(form: form, translation: translation) {
            return conjugationResult
        }

        print("⚠️ Unknown verb form: \(form)")
        return nil
    }

private func analyzeVerbPassive(form: String, translation: String) -> String? {
    guard let forms = forms else { return nil }
    let allForms = forms.merging(generatedVerbForms()) { user, _ in user }
    
    let lowerForm = form.lowercased()
    let persons = ["I", "you", "he/she/it", "we", "you", "they"]
    
   let base = extractPrimaryVerb(translation)
   let cleanTranslation = base.replacingOccurrences(of: "^to\\s+", with: "", options: .regularExpression)



    // Present Passive
    if let presentPassive = allForms["present_passive"],
       let index = presentPassive.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) is [\(translation)] (present passive)"
    }
    
    // Imperfect Passive
    if let imperfectPassive = allForms["imperfect_passive"],
       let index = imperfectPassive.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) was being [\(translation)] (imperfect passive)"
    }
    
    // Future Passive
    if let futurePassive = allForms["future_passive"],
       let index = futurePassive.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) will be [\(cleanTranslation)] (future passive)"
    }
    
    // Perfect Passive (using perfect passive participle + esse)
    if let perfectPassive = allForms["perfect_passive"],
       let index = perfectPassive.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) has been [\(cleanTranslation)] (perfect passive)"
    }
    
    // Pluperfect Passive
    if let pluperfectPassive = allForms["pluperfect_passive"],
       let index = pluperfectPassive.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) had been [\(translation)] (pluperfect passive)"
    }
    
    // Future Perfect Passive
    if let futurePerfectPassive = allForms["future_perfect_passive"],
       let index = futurePerfectPassive.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) will have been [\(cleanTranslation)] (future perfect passive)"
    }
    
    // Present Passive Subjunctive
    if let presentPassiveSubj = allForms["present_passive_subjunctive"],
       let index = presentPassiveSubj.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) may be [\(cleanTranslation)] (present passive subjunctive)"
    }
    
    // Imperfect Passive Subjunctive
    if let imperfectPassiveSubj = allForms["imperfect_passive_subjunctive"],
       let index = imperfectPassiveSubj.firstIndex(where: { $0.lowercased() == lowerForm }) {
        return "\(persons[index]) might be [\(cleanTranslation)] (imperfect passive subjunctive)"
    }
    
    return nil
}


    private func parseGenderNumber(_ key: String) -> String {
        let components = key.components(separatedBy: "_")
        guard components.count >= 2 else { return key }
        
        let gender: String
        switch components[0] {
        case "m": gender = "masculine"
        case "f": gender = "feminine"
        case "n": gender = "neuter"
        default: gender = components[0]
        }
        
        let number = components[1] == "sg" ? "singular" : "plural"
        return "\(gender) \(number)"
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

    private func stripInfinitivePrefix(from translation: String) -> String {
        var trimmed = translation
        if trimmed.hasPrefix("to ") {
            trimmed = String(trimmed.dropFirst(3))
        }
        return trimmed
    }
    private func extractPrimaryVerb(_ translation: String) -> String {
        // Strip "to " and take first meaning before comma
        let base = translation
            .replacingOccurrences(of: "to ", with: "")
            .components(separatedBy: ",")
            .first?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? translation
        return base
    }

     private func analyzeConjugation(tense: String, index: Int, translation: String, isPlural: Bool) -> String? {
        let (person, number) = getPersonAndNumber(index: index)
        let effectiveNumber = isPlural ? " (pl)" : number
        
        let base = extractPrimaryVerb(translation)
        let cleanTranslation = base.replacingOccurrences(of: "^to\\s+", with: "", options: .regularExpression)

        switch tense {
        case "perfect_passive_participle_m", "perfect_passive_participle_f", "perfect_passive_participle_n":
            let gender = tense.hasSuffix("_f") ? "feminine" :
                     tense.hasSuffix("_n") ? "neuter" :
                     tense.hasSuffix("_m") ? "masculine" : "unknown"
    
            let helperVerb = (person == "I" || person == "they" || person == "we" || (person == "you" && isPlural)) ? "have" : "has"
            return "\(person) \(helperVerb) been [\(cleanTranslation)] \(effectiveNumber) (perfect passive \(gender))"
        case "present", "present_active_indicative":
            return "\(person) \(cleanTranslation)\(effectiveNumber) (present)"
        case "present_passive_indicative":
            return "\(person) \(isPlural ? "are" : "is") [\(translation)]\(effectiveNumber) (present passive \(gender))"
        case "imperfect_active":
            let base = extractPrimaryVerb(translation)
            let verb = (person == "they" || person == "we" || (person == "you" && isPlural)) ? "were" : "was"
            return "\(person) \(verb) \(base)ing (imperfect active)"
        case "imperfect_active_indicative":
            return "\(person) was [\(translation)] \(effectiveNumber) (imperfect active)"
        case "imperfect_passive_indicative":
            return "\(person) was being [\(translation)] \(effectiveNumber) (imperfect passive)"
        case "future", "future_active_indicative":
            return "\(person) will \(cleanTranslation) \(effectiveNumber) (future)"
        case "future_passive_indicative":
            return "\(person) will be \(cleanTranslation) \(effectiveNumber) (future passive)"

        case "future_perfect_eccl":
            return "\(person) will have  [\(cleanTranslation)] \(effectiveNumber) (future perfect eccl)"
        case "future_perfect":
            return "\(person) will have  [\(cleanTranslation)] \(effectiveNumber) (future perfect)"


        case "perfect_subjunctive":
            let helperVerb = ((person == "I") || person == "they" || person == "we" || (person == "you" && isPlural)) ? "have" : "has"
            return "\(person) \(helperVerb)  \(cleanTranslation)ed \(effectiveNumber) (perfect subjunctive)"



        case "perfect", "perfect_active_indicative":
            let helperVerb = (person == "I" || person == "they" || person == "we" || (person == "you" && isPlural)) ? "have" : "has"
            return "\(person) \(helperVerb) \(cleanTranslation)ed\(effectiveNumber) (perfect)"

        case "perfect_passive_indicative":
            let helperVerb = (person == "I" || person == "they" || person == "we" || (person == "you" && isPlural)) ? "have" : "has"
            return "\(person) \(helperVerb) been \(translation)ed\(effectiveNumber) (perfect passive)"

        case "pluperfect_active_indicative":
            return "\(person) had \(translation)ed\(effectiveNumber)"
        case "pluperfect_passive_indicative":
            return "\(person) had been \(translation)ed\(effectiveNumber)"
        case "present_active_subjunctive":
            return "\(person) may \(cleanTranslation)\(effectiveNumber) (present active subjunctive)"
        case "present_passive_subjunctive":
            return "\(person) may be \(cleanTranslation)ed\(effectiveNumber) (present passive subjunctive)"
        case "imperfect_active_subjunctive":
            return "\(person) might \(translation)\(effectiveNumber) (subjunctive)"
        case "imperfect_passive_subjunctive":
            return "\(person) might be \(translation)ed\(effectiveNumber) (subjunctive)"
        case "imperative_active":
            return "\(translation.capitalized)! (\(isPlural ? "plural" : "singular") command)"
        case "present_participle":
            return "\(translation)ing (participle)"

        default:
            return "default: \(cleanTranslation) (\(tense) \(isPlural ? "plural" : "singular"))"
        }
    }
      private func analyzeVerbConjugation(form: String, translation: String) -> String? {
        let lowerForm = form.lowercased()

        // 1. Combine all available verb forms
        let allForms = (forms ?? [:])
            .merging(generatedVerbForms()) { manual, _ in manual }


         for (tense, formArray) in allForms {
                for (index, variant) in formArray.enumerated() {
                    if matchesVariant(form: lowerForm, target: variant) {
                        return analyzeConjugation(tense: tense, index: index, translation: translation, isPlural: false)
                }
            }
        }

        // Check singular forms
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
                                    caseKey.contains("_n") ? "neuter" : 
                                    caseKey.contains("_m") ? "masculine" :
                                    self.gender?.rawValue ?? "unknown"
                                    
                        let cleanCase = caseKey
                            .replacingOccurrences(of: "_f", with: "")
                            .replacingOccurrences(of: "_n", with: "")
                            .replacingOccurrences(of: "_m", with: "")
                            .replacingOccurrences(of: "_", with: " ")
                        return "\(translation) (\(cleanCase) \(gender))"
                    }
                }
            }
        }

         // 3. Check forms_plural dictionary (plural)
        if let formsPlural = formsPlural {
            for (caseKey, formVariants) in formsPlural {
                for formVariant in formVariants {
                    if formVariant.lowercased() == lowerForm {
                        let (caseName, gender) = parseFormKey(caseKey)
                        return "\(translation) (\(caseName) plural \(gender))"
                    }
                }
            }
        }
        
        for (caseKey, formVariant) in generatedForms {
                if formVariant.lowercased() == lowerForm {
                    let (caseName, gender) = parseFormKey(caseKey)
                    let plurality = caseKey.contains("plural") ? "plural " : ""
                    return "\(translation) (\(caseName) \(plurality)\(gender))"
                }
            }
        
        
        if lowerForm == lemma.lowercased() {
            return translation
        }
         let caseDescriptions: [String: String] = [
        "nominative": translation,
        "genitive": "of \(translation)",
        "dative": "to/for \(translation)",
        "accusative": translation, // Direct object doesn't need preposition in English
        "ablative": "by/with/from \(translation)",
        "vocative": "O \(translation)!",
        "nominative plural": "\(translation)s",
        "genitive plural": "of \(translation)s",
        "dative plural": "to/for \(translation)s",
        "accusative plural": "\(translation)s",
        "ablative plural": "by/with/from \(translation)s"
    ]
        for (caseName, caseForm) in rootCases {
        if caseForm?.lowercased() == lowerForm {
            return caseDescriptions[caseName] ?? "\(translation) (\(caseName))"
        }
    }

    if let formsDict = forms {
        for (caseKey, formVariants) in formsDict {
            for formVariant in formVariants where formVariant.lowercased() == lowerForm {
                let (cleanCase, gender) = parseFormKey(caseKey)
                let genderText = gender == "unknown" ? "" : " (\(gender))"
                return caseDescriptions[cleanCase] ?? "\(translation) (\(cleanCase)\(genderText))"
            }
        }
    }
    
        return "\(translation) [unknown form: \(form)]"
    }
        
    // MARK: - Helper Methods
     private func parseFormKey(_ key: String) -> (caseName: String, gender: String) {
        let gender = key.contains("_f") ? "feminine" :
                     key.contains("_n") ? "neuter" :
                     key.contains("_m") ? "masculine" : "unknown"
        let caseName = key
            .replacingOccurrences(of: "_f", with: "")
            .replacingOccurrences(of: "_n", with: "")
            .replacingOccurrences(of: "_m", with: "")
            .replacingOccurrences(of: "_", with: " ")
        return (caseName, gender)
    }
    
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
    private func getGenderAndNumber(index: Int, isPlural: Bool) -> String {
        // Assuming forms array order: [masc_sg, fem_sg, neut_sg, masc_pl, fem_pl, neut_pl]
        let gender = index % 3 == 0 ? "masc" : index % 3 == 1 ? "fem" : "neut"
        let number = isPlural ? "pl" : "sg"
        return "\(gender) \(number)"
    }
   
}


    
   
 
