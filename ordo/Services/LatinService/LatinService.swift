import Foundation
public struct LatinWordEntity: Codable {
    public let lemma: String
    public let partOfSpeech: String?  // New field: "noun", "verb", "pronoun" etc.
 
    public let declension: Int? // 1-5
    public let gender: String? // "masculine", "feminine", "neuter"

    public let vocative: String?
    
    public let nominative: String?
    public let dative: String?
    public let accusative: String?
    public let genitive: String?
    public let ablative: String?

    public let nominative_plural: String?
    public let genitive_plural: String?
    public let dative_plural: String?
    public let accusative_plural: String?
    public let ablative_plural: String?

    
    
    public struct PossessiveForms: Codable {
        public let singular: [String: [String: String]]?
        public let plural: [String: [String: String]]?
    }
    
    public let possessive: PossessiveForms?

    // Verb-specific properties
    public let perfect: String?                // Principal part
    public let infinitive: String?             // Principal part
    public let forms: [String: [String]]?      // Dictionary of form types to arrays
    
    
    public let translations: [String: String]?
    
    
    public init(
        lemma: String,
        partOfSpeech: String? = nil,
        declension: Int? = nil,
        gender: String? = nil,
        
        vocative: String? = nil,
        
        nominative: String? = nil,
        dative: String? = nil,
        accusative: String? = nil,
        genitive: String? = nil,
        ablative: String? = nil,
        
        nominative_plural: String? = nil,
        genitive_plural: String? = nil,
        dative_plural: String? = nil,
        accusative_plural: String? = nil,
        ablative_plural: String? = nil,
        possessive: PossessiveForms? = nil,
        perfect: String? = nil,
        infinitive: String? = nil,
        forms: [String: [String]]? = nil,
        translations: [String: String]? = nil 
    ) {
        self.lemma = lemma
        self.partOfSpeech = partOfSpeech
        self.gender = gender
        self.declension = declension
        self.vocative = vocative
        
        self.nominative = nominative
        self.dative = dative
        self.accusative = accusative
        self.genitive = genitive
        self.ablative = ablative
        self.nominative_plural = nominative_plural
        self.genitive_plural = genitive_plural
        self.dative_plural = dative_plural
        self.accusative_plural = accusative_plural
        self.ablative_plural = ablative_plural
        self.possessive = possessive
        self.perfect = perfect
        self.infinitive = infinitive
        self.forms = forms
        self.translations = translations
    }
    
    // CodingKeys for backward compatibility
    private enum CodingKeys: String, CodingKey {
        case lemma
        case partOfSpeech = "part_of_speech"
        case gender
        case declension
        case vocative
        case nominative, dative, accusative, genitive, ablative
        case nominative_plural = "nominative_plural"
        case genitive_plural = "genitive_plural"
        case dative_plural = "dative_plural"
        case accusative_plural = "accusative_plural"
        case ablative_plural = "ablative_plural"
        case possessive
        case perfect, infinitive, forms
        case translations
    }

    public func getTranslation(_ language: String = "en") -> String? {
        return translations?[language] ?? translations?["la"] ?? lemma
    }
    func analyzeFormWithMeaning(_ form: String) -> String {
        let formLower = form.lowercased()
        let translation = getTranslation() ?? lemma.lowercased()
        if partOfSpeech == "adverb" {
               return "\(translation) (adverb)"
           }
           
        
        // 0. Handle vocative first
        if let vocativeForm = vocative?.lowercased(), vocativeForm == formLower {
               if partOfSpeech == "pronoun" {
                   let pronounMap: [String: String] = [
                       "tu": "you",
                       "vos": "you all"
                   ]
                   return "O \(pronounMap[lemma.lowercased()] ?? translation)! (vocative)"
               }
               return "O \(translation)! (vocative)"
           }
        // 1. Handle Pronouns
        if partOfSpeech == "pronoun" {
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
            
            switch formLower {
            case vocative?.lowercased(): return "O \(pronounText)! (vocative)"
            case nominative?.lowercased(): return "\(pronounText) (nominative)"
            case dative?.lowercased(): return "to/for \(pronounText) (dative)"
            case accusative?.lowercased(): return "\(pronounText) (accusative)"
            case genitive?.lowercased(): return "of \(pronounText) (genitive)"
            case ablative?.lowercased(): return "by/with \(pronounText) (ablative)"
            default: break
            }
        }
        
        // 2. Enhanced Verb Analysis
        if partOfSpeech == "verb" {
            // Handle principal parts first
            if let infinitive = infinitive, infinitive.lowercased() == formLower {
                return "to \(translation) (infinitive)"
            }
            if let perfect = perfect, perfect.lowercased() == formLower {
                return "has/have \(translation)ed (perfect)"
            }
            
            if let analysis = analyzeVerbForm(form: formLower, translation: translation) {
                        return analysis
                    }
            
        }
        
        // 3. Possessive Forms (Improved)
        if let possessive = possessive {
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
                    for (caseName, form) in cases {
                        if form.lowercased() == formLower {
                            return "\(possessor) \(gender) (\(number) \(caseName))"
                        }
                    }
                }
            }
        }
        
        // 4. Noun/Adjective Analysis
        let isPlural = [nominative_plural, genitive_plural, dative_plural,
                       accusative_plural, ablative_plural].contains { $0?.lowercased() == formLower }
        
        let pluralSuffix = isPlural ? " (pl)" : ""
        let pluralTranslation = isPlural ? translation + "s" : translation
        
        switch formLower {
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
        default:
            return "[unknown form: \(form)]"
        }
    }
    
   
    private func analyzeVerbForm(form: String, translation: String) -> String? {
        guard let forms = forms else { return nil }
        
        for (tense, formArray) in forms {
            for (index, formVariants) in formArray.enumerated() {
                guard matchesVariant(form: form, target: formVariants) else { continue }
                
                let (person, number) = getPersonAndNumber(index: index)
                
                switch tense {
                case "present":
                    return "\(person) \(translation)\(number)"
                case "imperfect":
                    return "\(person) was \(translation)ing\(number)"
                case "future":
                    return "\(person) will \(translation)\(number)"
                case "perfect":
                    return "\(person) has \(translation)ed\(number)"
                case "pluperfect":
                    return "\(person) had \(translation)ed\(number)"
                case "imperative_singular":
                    return "\(translation.capitalized)! (command)"
                case "imperative_plural":
                    return "\(translation.capitalized)! (pl command)"
                default:
                    return "\(translation) (\(tense))"
                }
            }
        }
        return nil
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
    public var generatedForms: [String: String] {
        guard let declension = declension, let nominative = nominative else { return [:] }
        var forms = [String: String]()
        let stem: String
        
        switch declension {
        case 1: // -a (feminine)
            let stem = String(nominative.dropLast())
            forms["genitive"] = stem + "ae"
            forms["dative"] = stem + "ae"
            forms["accusative"] = stem + "am"
            forms["ablative"] = stem + "ā"
            
        case 2 where gender == "neuter": // -um (neuter)
            let stem = String(nominative.dropLast(2))
            forms["genitive"] = stem + "i"
            forms["dative"] = stem + "o"
            forms["accusative"] = nominative // Same as nominative for neuters
            forms["ablative"] = stem + "o"
            forms["nominative_plural"] = stem + "a"
            forms["genitive_plural"] = stem + "orum"

             forms["nominative_plural"] = stem + "a"
            forms["genitive_plural"] = stem + "orum"
            forms["dative_plural"] = stem + "is"
            forms["accusative_plural"] = stem + "a"
            forms["ablative_plural"] = stem + "is"
            
        case 2: // -us (masculine)
            let stem = String(nominative.dropLast())
            forms["genitive"] = stem + "i"
            forms["dative"] = stem + "o"
            forms["accusative"] = stem + "um"
            forms["ablative"] = stem + "o"
        
            forms["nominative_plural"] = stem + "i"
            forms["genitive_plural"] = stem + "orum"
            forms["dative_plural"] = stem + "is"
            forms["accusative_plural"] = stem + "os"
            forms["ablative_plural"] = stem + "is"
            
            
        case 3 where gender == "neuter":
            stem = String(nominative.dropLast(2)) // e.g. "nomen" -> "nomin"
            forms["genitive"] = stem + "is"
            forms["dative"] = stem + "i"
            forms["accusative"] = nominative
            forms["ablative"] = stem + "e"
            forms["nominative_plural"] = stem + "a"
            forms["genitive_plural"] = stem + "um"

           // Plural
            forms["nominative_plural"] = stem + "a"
            forms["genitive_plural"] = stem + "um"
            forms["dative_plural"] = stem + "ibus"
            forms["accusative_plural"] = stem + "a"
            forms["ablative_plural"] = stem + "ibus"
            
        case 3: // Masculine/Feminine
            let genitive = self.genitive ?? "" // Require genitive to find stem
            guard genitive.count > 2 else { break }
            stem = String(genitive.dropLast(2)) // e.g. "regis" -> "reg"
            forms["genitive"] = genitive
            forms["dative"] = stem + "i"
            forms["accusative"] = stem + "em"
            forms["ablative"] = stem + "e"
            forms["nominative_plural"] = stem + "es"
            forms["genitive_plural"] = stem + "um"
            
        case 4 where gender == "neuter": // -u
            stem = String(nominative.dropLast())
            forms["genitive"] = stem + "ūs"
            forms["dative"] = stem + "ū"
            forms["accusative"] = nominative
            forms["ablative"] = stem + "ū"
            forms["nominative_plural"] = stem + "ua"
            forms["genitive_plural"] = stem + "uum"

             
            forms["dative_plural"] = stem + "ibus"
            forms["accusative_plural"] = stem + "ua"
            forms["ablative_plural"] = stem + "ibus"
            
        case 4: // Masculine/Feminine -us
            stem = String(nominative.dropLast(2))
            forms["genitive"] = stem + "ūs"
            forms["dative"] = stem + "uī"
            forms["accusative"] = stem + "um"
            forms["ablative"] = stem + "ū"
            forms["nominative_plural"] = stem + "ūs"
            forms["genitive_plural"] = stem + "uum"


            forms["dative_plural"] = stem + "ibus"
            forms["accusative_plural"] = stem + "ūs"
            forms["ablative_plural"] = stem + "ibus"
            
        case 5:
            stem = String(nominative.dropLast(2)) // "res" -> "r"
             forms["nominative"] = nominative
            forms["genitive"] = stem + "i"  // Simplified from "eī"
            forms["dative"] = stem + "i"    // Simplified from "eī"
            forms["accusative"] = stem + "em"
            forms["ablative"] = stem + "e"  // Note: This one is truly just "e"
                    
        default:
            break
        }
        return forms
    }
    
}


public struct PsalmAnalysisResult: Codable {
    public let totalWords: Int
    public let uniqueWords: Int
    public let uniqueLemmas: Int
    public let dictionary: [String: LemmaInfo]
    
    public struct LemmaInfo: Codable {
        public let count: Int
        public let translation: String?
        public let forms: [String: Int]
        public let entity: LatinWordEntity?
        public let generatedForms: [String]
    }
}

public class LatinService {
    // Singleton instance
    public static let shared = LatinService()
    
    // Stored entities and translations
    private var wordEntities: [LatinWordEntity] = []
    private var translations: [String: String] = [:]

     private func loadWords() {
        let bundlesToCheck: [Bundle] = {
                #if SWIFT_PACKAGE
                // Docker/SwiftPM environment (uses Bundle.module)
                return [Bundle.module]
                #else
                // Xcode environment (uses Bundle.main or Bundle(for:))
                return [Bundle.main, Bundle(for: Self.self)]
                #endif
            }()
        
        for bundle in bundlesToCheck {
            if let url = bundle.url(forResource: "words", withExtension: "json") { 
                do {
                    let data = try Data(contentsOf: url)

                    print("\(data)")
                    wordEntities = try JSONDecoder().decode([LatinWordEntity].self, from: data)
                    return
                } catch {
                    print("Found words.json but failed to load: \(error)")
                }
            }
        }
        print("Error: words.json not found in any bundle")
    }

    private func loadTranslations() {
        let bundlesToCheck: [Bundle] = {
                #if SWIFT_PACKAGE
                // Docker/SwiftPM environment (uses Bundle.module)
                return [Bundle.module]
                #else
                // Xcode environment (uses Bundle.main or Bundle(for:))
                return [Bundle.main, Bundle(for: Self.self)]
                #endif
            }()
        
        for bundle in bundlesToCheck {
            if let url = bundle.url(forResource: "translations", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)

                    print("\(data)")
                    translations = try JSONDecoder().decode([String: String].self, from: data)
                    return
                } catch {
                    print("Found translations.json but failed to load: \(error)")
                }
            }
        }
        print("Error: translations.json not found in any bundle")
    }
    private init() {
        
            loadWords()
            loadTranslations()
       

    }
    public func getWordEntities() -> [LatinWordEntity]{
        return self.wordEntities
    }
    public func getTranslations() -> [String: String] {
        return self.translations
    }

    // MARK: - Configuration Methods
    
    public func configure(with wordEntities: [LatinWordEntity], translations: [String: String]) {
        //self.wordEntities = wordEntities
        self.translations = translations
    }
    
    public func addWordEntity(_ entity: LatinWordEntity) {
        wordEntities.append(entity)
    }
    
    public func addTranslation(latin: String, english: String) {
        translations[latin] = english
    }
    public func analyzePsalm(text: [String]) -> PsalmAnalysisResult {
        let combinedText = text.joined(separator: " ")
        let normalizedText = combinedText.lowercased()
            .replacingOccurrences(of: "[.,:;!?]", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "[']", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
        
        let words = normalizedText.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
        
        let formToLemma = createFormToLemmaMapping()
        
        var lemmaCounts: [String: Int] = [:]
        var formCounts: [String: [String: Int]] = [:]
        var lemmaEntities: [String: LatinWordEntity] = [:] // Track entities for lemmas
        
        // First pass: count actual occurrences
        for word in words {
            let lemma = formToLemma[word] ?? word
            lemmaCounts[lemma, default: 0] += 1
            formCounts[lemma, default: [:]][word, default: 0] += 1
            
            // Store entity reference if not already stored
            if lemmaEntities[lemma] == nil {
                lemmaEntities[lemma] = wordEntities.first { $0.lemma.lowercased() == lemma.lowercased() }
            }
        }
        
        // Build results - only include forms with count > 0
        var resultDictionary: [String: PsalmAnalysisResult.LemmaInfo] = [:]
        for (lemma, count) in lemmaCounts {
            let entity = lemmaEntities[lemma]
            let translation = entity?.getTranslation() ?? translations[lemma] ?? lemma
            
            // Filter out forms with 0 counts
            let filteredForms = (formCounts[lemma] ?? [:]).filter { $0.value > 0 }
            
            // Get generated forms but only for display purposes
            let generatedForms = entity?.generatedForms.values.filter { form in
                // Exclude forms that already appear in the text
                !filteredForms.keys.contains(form) &&
                // Exclude forms that are the same as the lemma
                form.lowercased() != lemma.lowercased()
            } ?? []
            
            resultDictionary[lemma] = PsalmAnalysisResult.LemmaInfo(
                count: count,
                translation: translation,
                forms: filteredForms,
                entity: entity,
                generatedForms: Array(generatedForms) // Pass as array for display
            )
        }
        
        return PsalmAnalysisResult(
            totalWords: words.count,
            uniqueWords: Set(words).count,
            uniqueLemmas: lemmaCounts.count,
            dictionary: resultDictionary
        )
    }
    
    // Keep original String version for backward compatibility
    public func analyzePsalm(text: String) -> PsalmAnalysisResult {
        let lines = text.components(separatedBy: .newlines)
        return analyzePsalm(text: lines)
    }
    
    
    // MARK: - Helper Methods  
     private func createFormToLemmaMapping() -> [String: String] {
        var mapping: [String: String] = [:]
        for entity in wordEntities {
            let lemma = entity.lemma
            // 1. Map ALL case forms (both singular and plural)
            let caseForms = [
                entity.nominative,
                entity.vocative,
                entity.dative,
                entity.accusative,
                entity.genitive,
                entity.ablative,
                entity.nominative_plural,
                entity.genitive_plural,
                entity.dative_plural,
                entity.accusative_plural,
                entity.ablative_plural
            ]
            
            caseForms.compactMap { $0?.lowercased() }
                    .forEach { mapping[$0] = lemma }
            
            // 2. Map generated forms (from generatedForms)
            entity.generatedForms.values
                .map { $0.lowercased() }
                .forEach { mapping[$0] = lemma }
            
            // 3. Map possessive forms (now properly structured)
            if let possessive = entity.possessive {
                // Singular forms
                possessive.singular?.values.forEach { genderForms in
                    genderForms.values.forEach { form in
                        mapping[form.lowercased()] = lemma
                    }
                }
                
                // Plural forms
                possessive.plural?.values.forEach { genderForms in
                    genderForms.values.forEach { form in
                        mapping[form.lowercased()] = lemma
                    }
                }
            }
           
            
            if entity.partOfSpeech == "verb" {
                
                if let verbForms = entity.forms {
                            for (_, formArray) in verbForms {
                                for formVariants in formArray {
                                    // Split variants and map each one
                                    formVariants.lowercased()
                                        .components(separatedBy: "/")
                                        .forEach { variant in
                                            mapping[variant] = lemma
                                        }
                                }
                            }
                        }
                
                // Imperative (like "sede")
                if let imperative = entity.forms?["imperative_singular"] {
                    imperative.forEach { mapping[$0.lowercased()] = lemma }
                }
                
                // Principal parts
                [entity.infinitive, entity.perfect].compactMap { $0 }
                    .forEach { mapping[$0.lowercased()] = lemma }
                
                // All other verb forms
                entity.forms?.values.flatMap { $0 }
                    .forEach { mapping[$0.lowercased()] = lemma }
            }
               
            // 3. Map verb forms (new)
            if let verbForms = entity.forms {
                // Handle perfect tense array
                if let perfectForms = verbForms["perfect"] as? [String] {
                    perfectForms.forEach { mapping[$0.lowercased()] = lemma }
                }
                
                // Handle other verb forms if present in future
                // (Add similar blocks for other tenses/moods)
            }
            
            // 4. Map principal parts (verbs)
            if let perfectForm = entity.perfect {
                mapping[perfectForm.lowercased()] = lemma
            }
        }
        
        //print("Final Mapping:", mapping.sorted(by: { $0.key < $1.key })) // Alphabetized debug
        return mapping
    }

   
    
    // MARK: - Export Methods
    
    public func exportAnalysisResult(_ result: PsalmAnalysisResult, to filePath: String) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(result)
        try jsonData.write(to: URL(fileURLWithPath: filePath))
    }
}
