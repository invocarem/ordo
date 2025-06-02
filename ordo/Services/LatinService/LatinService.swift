import Foundation
extension LatinWordEntity{
     
     
    
    
    public func getTranslation(_ language: String = "en") -> String? {
        return translations?[language] ?? translations?["la"] ?? lemma
    }
    
    public var generatedForms: [String: String] {
        guard let declension = declension, let nominative = nominative else { return [:] }
        var forms = [String: String]()
        let stem: String
        
        switch declension {
        case 1 where partOfSpeech == .adjective && gender == .masculine:
            // Handle first-declension masculine adjectives like "beatus"
            stem = String(nominative.dropLast(2)) // e.g., "beatus" -> "beat"
            forms["nominative"] = nominative
            forms["genitive"] = stem + "i"
            forms["dative"] = stem + "o"
            forms["accusative"] = stem + "um"
            forms["ablative"] = stem + "o"
            forms["vocative"] = stem + "e"
            forms["nominative_plural"] = stem + "i"
            forms["genitive_plural"] = stem + "orum"
            forms["dative_plural"] = stem + "is"
            forms["accusative_plural"] = stem + "os"
            forms["ablative_plural"] = stem + "is"
            
        case 1 where partOfSpeech == .noun && nominative.hasSuffix("ae"):
            stem = String(nominative.dropLast(2)) // "tenebrae" -> "tenebr"
            forms["nominative"] = nominative // "tenebrae"
            forms["genitive"] = stem + "arum" // "tenebrarum"
            forms["dative"] = stem + "is" // "tenebris"
            forms["accusative"] = stem + "as" // "tenebras"
            forms["ablative"] = stem + "is" // "tenebris"
            forms["vocative"] = nominative // "tenebrae"
            forms["nominative_plural"] = nominative // "tenebrae"
            forms["genitive_plural"] = stem + "arum" // "tenebrarum"
            forms["dative_plural"] = stem + "is" // "tenebris"
            forms["accusative_plural"] = stem + "as" // "tenebras"
            forms["ablative_plural"] = stem + "is" // "tenebris"

        case 1: // -a (feminine)
            let stem = String(nominative.dropLast())
            forms["genitive"] = stem + "ae"
            forms["dative"] = stem + "ae"
            forms["accusative"] = stem + "am"
            forms["ablative"] = stem + "a"
            forms["nominative_plural"] = stem + "ae"
            forms["genitive_plural"] = stem + "arum"
            forms["dative_plural"] = stem + "is"
            forms["accusative_plural"] = stem + "as"
            forms["ablative_plural"] = stem + "is"

        case 2: // Handles all 2nd declension (-us, -um, -ius)
            let stem: String
            
            // Special -ius handling (filius, genius)
            if nominative.hasSuffix("ius") {
                stem = String(nominative.dropLast(3)) + "i" // "filius" → "fili"
                forms["vocative"] = stem // "fili" (special vocative)
            } 
             else if nominative.hasSuffix("er") {

                 // For -er nouns, check genitive to determine stem
                if let genitive = self.genitive, genitive.hasPrefix(nominative.dropLast(2)) {
                    stem = String(nominative.dropLast(2)) // e.g. "puer" -> "pu" (pueri)
                } else {
                    stem = String(nominative.dropLast(1)) // e.g. "liber" -> "libr" (libri)
                }

               forms["vocative"] = nominative // -er nouns keep full nominative in vocative
            }
            // Regular -us/-um handling
            else {
                stem = String(nominative.dropLast(2)) // "dolus" → "dol", "bellum" → "bell"
                if !nominative.hasSuffix("um") { // Masculine -us gets vocative
                    forms["vocative"] = stem + "e" // "dole"
                }
            }
            
            // Common forms for all subtypes
            forms["genitive"] = stem + "i"
            forms["dative"] = stem + "o"
            forms["ablative"] = stem + "o"
            forms["genitive_plural"] = stem + "orum"
            forms["dative_plural"] = stem + "is"
            forms["ablative_plural"] = stem + "is"
            
            // Gender/type specific forms
            if nominative.hasSuffix("um") { // Neuter
                forms["nominative"] = nominative
                forms["accusative"] = nominative
                forms["nominative_plural"] = stem + "a"
                forms["accusative_plural"] = stem + "a"
            } else { // Masculine (-us or -ius)
                forms["nominative"] = nominative
                forms["accusative"] = stem + "um"
                forms["nominative_plural"] = stem + "i"
                forms["accusative_plural"] = stem + "os"
            }

       

        // ... (remaining cases 3, 4, 5 stay unchanged)
       case 3 where gender == .neuter:
        // 1. Get the genitive form (essential for 3rd declension)
        guard let genitive = self.genitive else { break }
        
        // 2. Extract the true stem (muneris → muner)
        let stem = String(genitive.dropLast(2)) // Drops "-is" from genitive
        
        // 3. Build all forms
        forms["nominative"] = nominative          // munus
        forms["genitive"] = genitive              // muneris
        forms["dative"] = stem + "i"              // muneri
        forms["accusative"] = nominative          // munus
        forms["ablative"] = stem + "e"            // munere
        
        // 4. Plural forms
        forms["nominative_plural"] = stem + "a"   // munera
        forms["genitive_plural"] = stem + "um"    // munerum
        forms["dative_plural"] = stem + "ibus"    // muneribus
        forms["accusative_plural"] = stem + "a"   // munera
        forms["ablative_plural"] = stem + "ibus"  // muneribus
            
        case 3: // Masculine/Feminine
            let genitive = self.genitive ?? ""
            guard genitive.count > 2 else { break }
            stem = String(genitive.dropLast(2))
            forms["genitive"] = genitive
            forms["dative"] = stem + "i"
            forms["accusative"] = stem + "em"
            forms["ablative"] = stem + "e"
            forms["nominative_plural"] = stem + "es"
            forms["genitive_plural"] = stem + "um"
            forms["dative_plural"] = stem + "ibus"
            forms["accusative_plural"] = stem + "es"
            forms["ablative_plural"] = stem + "ibus"

        case 4 where gender == .neuter:
            stem = String(nominative.dropLast())
            forms["genitive"] = stem + "us"
            forms["dative"] = stem + "u"
            forms["accusative"] = nominative
            forms["ablative"] = stem + "u"
            forms["nominative_plural"] = stem + "ua"
            forms["genitive_plural"] = stem + "uum"
            forms["dative_plural"] = stem + "ibus"
            forms["accusative_plural"] = stem + "ua"
            forms["ablative_plural"] = stem + "ibus"

        case 4: // Masculine/Feminine -us
            stem = String(nominative.dropLast(2))
            forms["genitive"] = stem + "us"
            forms["dative"] = stem + "ui"
            forms["accusative"] = stem + "um"
            forms["ablative"] = stem + "u"
            forms["nominative_plural"] = stem + "us"
            forms["genitive_plural"] = stem + "uum"
            forms["dative_plural"] = stem + "ibus"
            forms["accusative_plural"] = stem + "us"
            forms["ablative_plural"] = stem + "ibus"

        case 5:
            stem = String(nominative.dropLast(2))
            forms["nominative"] = nominative
            forms["genitive"] = stem + "i"
            forms["dative"] = stem + "i"
            forms["accusative"] = stem + "em"
            forms["ablative"] = stem + "e"
            // Add plural forms if needed
            forms["nominative_plural"] = stem + "es"
            forms["genitive_plural"] = stem + "erum"
            forms["dative_plural"] = stem + "ebus"
            forms["accusative_plural"] = stem + "es"
            forms["ablative_plural"] = stem + "ebus"

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
    public let orderedLemmas: [String]
    public var themes: [Theme]
    
    public struct LemmaInfo: Codable {
        public let count: Int
        public let translation: String?
        public let forms: [String: Int]
        public let entity: LatinWordEntity?
        public let generatedForms: [String]
    }
    
    public struct Theme: Codable {
            public let name: String
            public let description: String
            public let supportingLemmas: [String]
            public let lineRange: ClosedRange<Int>?
            
            public init(name: String,
                       description: String,
                       supportingLemmas: [String],
                       lineRange: ClosedRange<Int>? = nil) {
                self.name = name
                self.description = description
                self.supportingLemmas = supportingLemmas
                self.lineRange = lineRange
            }
        }
}

public class LatinService {
    // Singleton instance
    public static let shared = LatinService()
    
    // Stored entities and translations
    private var wordEntities: [LatinWordEntity] = []
    private var translations: [String: String] = [:]
    var themeCache: [PsalmThemeData] = [] 

    private lazy var lemmaMapping = LemmaMapping(wordEntities: wordEntities)

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

    public func configureDebugging(target: String?) {
        self.lemmaMapping = LemmaMapping(wordEntities: self.wordEntities, debugTarget: target)
    }

public func analyzePsalm(_ identity: PsalmIdentity? = nil, text: [String], startingLineNumber: Int = 1) -> PsalmAnalysisResult {
    var allWords: [String] = []
    var lemmaCounts: [String: Int] = [:]
    var formCounts: [String: [String: Int]] = [:]
    var lemmaEntities: [String: LatinWordEntity] = [:]
    var orderedLemmas: [String] = []
    let formToLemma = lemmaMapping.createFormToLemmaMapping()
      
    
    let debugForms = ["transgrediar", "immaculatum", "apponatur", "custodit", "excussorum"]
        for form in debugForms {
            print("Form '\(form)' maps to: \(formToLemma[form] ?? [])")
        }
    
    for line in text {
        let normalizedLine = line.lowercased()
            .replacingOccurrences(of: "[.,:;!?]", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "[']", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
        
        let words = normalizedLine.components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }
        
        allWords.append(contentsOf: words)
        for word in words {
            if let lemmas = formToLemma[word] {
                // Deduplicate lemmas to avoid double-counting
                let uniqueLemmas = Set(lemmas) // Ensures we don't count the same lemma twice
                for lemma in uniqueLemmas {
                    if lemmaCounts[lemma] == nil {
                        orderedLemmas.append(lemma)
                    }
                    
                    lemmaCounts[lemma, default: 0] += 1
                    // Only increment form count once per unique (lemma, word) pair
                    formCounts[lemma, default: [:]][word, default: 0] += 1
                    
                    if lemmaEntities[lemma] == nil {
                        lemmaEntities[lemma] = wordEntities.first { $0.lemma.lowercased() == lemma.lowercased() }
                    }
                }
            } else if let entity = wordEntities.first(where: { $0.lemma.lowercased() == word.lowercased() }) {
                let lemma = entity.lemma.lowercased()
                lemmaCounts[lemma, default: 0] += 1
                formCounts[lemma, default: [:]][word, default: 0] += 1
                lemmaEntities[lemma] = entity
            }
        }
        
    }
    
    // Build final dictionary
    var resultDictionary: [String: PsalmAnalysisResult.LemmaInfo] = [:]
    for (lemma, count) in lemmaCounts {
        let entity = lemmaEntities[lemma]
        let translation = entity?.getTranslation() ?? translations[lemma]
        let filteredForms = (formCounts[lemma] ?? [:]).filter { $0.value > 0 }
        let generatedForms = entity?.generatedForms.values.filter {
            !filteredForms.keys.contains($0) && $0.lowercased() != lemma.lowercased()
        } ?? []
       

        resultDictionary[lemma] = PsalmAnalysisResult.LemmaInfo(
            count: count,
            translation: translation,
            forms: filteredForms,
            entity: entity,
            generatedForms: Array(generatedForms))
    }
    
    var result = PsalmAnalysisResult(
        totalWords: allWords.count,
        uniqueWords: Set(allWords).count,
        uniqueLemmas: lemmaCounts.count,
        dictionary: resultDictionary,
        orderedLemmas: orderedLemmas,
        themes: []
    )
    if let identity = identity {
        result =  updateThematicAnalysis(for: result, psalm: identity, lines: text, startingLineNumber: startingLineNumber)
    }
    return result;
}
    
    // Keep original String version for backward compatibility
    public func analyzePsalm(_ identity: PsalmIdentity? = nil, text: String, startingLineNumber: Int = 1) -> PsalmAnalysisResult {
        let lines = text.components(separatedBy: .newlines)
        return analyzePsalm(identity, text: lines, startingLineNumber: startingLineNumber)
    }
    
      
    
    // MARK: - Export Methods
    
    public func exportAnalysisResult(_ result: PsalmAnalysisResult, to filePath: String) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(result)
        try jsonData.write(to: URL(fileURLWithPath: filePath))
    }
}
