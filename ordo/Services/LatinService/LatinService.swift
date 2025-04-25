import Foundation
public struct LatinWordEntity: Codable {
    public let lemma: String
    public let partOfSpeech: String?  // New field: "noun", "verb", "pronoun" etc.
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
        nominative: String? = nil,
        dative: String? = nil,
        accusative: String? = nil,
        genitive: String? = nil,
        ablative: String? = nil,
        possessive: [String: String]? = nil,
        perfect: String? = nil,
        infinitive: String? = nil,
        forms: [String: [String]]? = nil
    ) {
        self.lemma = lemma
        self.partOfSpeech = partOfSpeech
        self.nominative = nominative
        self.dative = dative
        self.accusative = accusative
        self.genitive = genitive
        self.ablative = ablative
        self.possessive = possessive
        self.perfect = perfect
        self.infinitive = infinitive
        self.forms = forms
    }
    
    // CodingKeys for backward compatibility
    private enum CodingKeys: String, CodingKey {
        case lemma
        case partOfSpeech = "part_of_speech"
        case nominative, dative, accusative, genitive, ablative
        case possessive
        case perfect, infinitive, forms
    }

    public func getTranslation(_ language: String = "en") -> String? {
        return translations?[language] ?? translations?["la"] ?? lemma
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
    
    print("Normalized Text:", normalizedText) // Debug log
    
    let words = normalizedText.components(separatedBy: .whitespaces)
        .filter { !$0.isEmpty }
    
    print("Split Words:", words)

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
        resultDictionary[lemma] = PsalmAnalysisResult.LemmaInfo(
            count: count,
            translation: translations[lemma],
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
            
            // 1. Map all case forms (nouns/pronouns/adjectives)
            [entity.nominative, entity.dative, entity.accusative, 
            entity.genitive, entity.ablative].forEach {
                if let form = $0 {
                    mapping[form.lowercased()] = lemma
                }
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
        
        print("Final Mapping:", mapping.sorted(by: { $0.key < $1.key })) // Alphabetized debug
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