import Foundation
public struct LatinWordEntity: Codable {
    public let lemma: String
    public let partOfSpeech: String?  // New field: "noun", "verb", "pronoun" etc.
 
    public let declension: Int? // 1-5
    public let gender: String? // "masculine", "feminine", "neuter"

    public let nominative: String?
    public let dative: String?
    public let accusative: String?
    public let genitive: String?
    public let ablative: String?
    public let possessive: [String: String]?
    
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
        nominative: String? = nil,
        dative: String? = nil,
        accusative: String? = nil,
        genitive: String? = nil,
        ablative: String? = nil,
        possessive: [String: String]? = nil,
        perfect: String? = nil,
        infinitive: String? = nil,
        forms: [String: [String]]? = nil,
        translations: [String: String]? = nil 
    ) {
        self.lemma = lemma
        self.partOfSpeech = partOfSpeech
        self.gender = gender
        self.declension = declension
        self.nominative = nominative
        self.dative = dative
        self.accusative = accusative
        self.genitive = genitive
        self.ablative = ablative
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
        case nominative, dative, accusative, genitive, ablative
        case possessive
        case perfect, infinitive, forms
        case translations
    }

    public func getTranslation(_ language: String = "en") -> String? {
        return translations?[language] ?? translations?["la"] ?? lemma
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
        do {
            try loadWords()
            try loadTranslations()
        } catch {
           print("Error loading resources: \(error)")
        }

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
    
    //print("Normalized Text:", normalizedText) // Debug log
    
    let words = normalizedText.components(separatedBy: .whitespaces)
        .filter { !$0.isEmpty }
    
    //print("Split Words:", words)

    // Rest of the method remains the same...
    let formToLemma = createFormToLemmaMapping()
    
    // Count occurrences by lemma and track forms
    var lemmaCounts: [String: Int] = [:]
    var formCounts: [String: [String: Int]] = [:]
    
    for word in words {
        // Map word to its lemma
        let lemma = formToLemma[word] ?? word
        
        // Update counts
        lemmaCounts[lemma, default: 0] += 1
        formCounts[lemma, default: [:]][word, default: 0] += 1
    }
    
    // Build results
    var resultDictionary: [String: PsalmAnalysisResult.LemmaInfo] = [:]
    for (lemma, count) in lemmaCounts {
        let entity = wordEntities.first { $0.lemma == lemma }
        resultDictionary[lemma] = PsalmAnalysisResult.LemmaInfo(
            count: count,
            translation: entity?.getTranslation() ?? translations[lemma],
            forms: formCounts[lemma] ?? [:],
            entity: wordEntities.first { $0.lemma == lemma }
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

            if entity.partOfSpeech == "verb" {
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
                // 1. Add explicitly declared forms
            [entity.nominative, entity.dative, entity.accusative, 
            entity.genitive, entity.ablative].forEach {
                if let form = $0 {
                    mapping[form.lowercased()] = lemma
                }
            }
            
            // 2. Add generated forms
            let generated = entity.generatedForms
            generated.values.forEach { form in
                mapping[form.lowercased()] = lemma
            }
 
            // 2. Map all possessive forms (pronouns)
            entity.possessive?.values.forEach {
                mapping[$0.lowercased()] = lemma
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