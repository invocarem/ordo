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
               forms["nominative"] = nominative // "beatus"
               forms["genitive"] = stem + "i" // "beati"
               forms["dative"] = stem + "o" // "beato"
               forms["accusative"] = stem + "um" // "beatum"
               forms["ablative"] = stem + "o" // "beato"
               forms["vocative"] = stem + "e" // "beate"
               forms["nominative_plural"] = stem + "i" // "beati"
               forms["genitive_plural"] = stem + "orum" // "beatorum"
               forms["dative_plural"] = stem + "is" // "beatis"
               forms["accusative_plural"] = stem + "os" // "beatos"
               forms["ablative_plural"] = stem + "is" // "beatis"
        case 1: // -a (feminine)
            let stem = String(nominative.dropLast())
            forms["genitive"] = stem + "ae" // "puellae"
            forms["dative"] = stem + "ae" // "puellae"
            forms["accusative"] = stem + "am" // "puellam"
            forms["ablative"] = stem + "a" // "puellā"
            forms["nominative_plural"] = stem + "ae" // "puellae"
            forms["genitive_plural"] = stem + "arum" // "puellarum"
            forms["dative_plural"] = stem + "is" // "puellis"
            forms["accusative_plural"] = stem + "as" // "puellas"
            forms["ablative_plural"] = stem + "is" // "puellis"
            
        case 2 where gender == .neuter: // -um (neuter)
            
            let stem = String(nominative.dropLast(2)) // e.g., "bellum" -> "bell"
                   forms["genitive"] = stem + "i" // "belli"
                   forms["dative"] = stem + "o" // "bello"
                   forms["accusative"] = nominative // "bellum"
                   forms["ablative"] = stem + "o" // "bello"
                   forms["nominative_plural"] = stem + "a" // "bella"
                   forms["genitive_plural"] = stem + "orum" // "bellorum"
                   forms["dative_plural"] = stem + "is" // "bellis"
                   forms["accusative_plural"] = stem + "a" // "bella"
                   forms["ablative_plural"] = stem + "is" // "bellis"
            
        case 2: // -us (masculine)
           
            let stem = String(nominative.dropLast()) // e.g., "dominus" -> "domin"
                    forms["genitive"] = stem + "i" // "domini"
                    forms["dative"] = stem + "o" // "domino"
                    forms["accusative"] = stem + "um" // "dominum"
                    forms["ablative"] = stem + "o" // "domino"
                    forms["nominative_plural"] = stem + "i" // "domini"
                    forms["genitive_plural"] = stem + "orum" // "dominorum"
                    forms["dative_plural"] = stem + "is" // "dominis"
                    forms["accusative_plural"] = stem + "os" // "dominos"
                    forms["ablative_plural"] = stem + "is" // "dominis"
            
            
        case 3 where gender == .neuter:
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
            forms["dative_plural"] = stem + "ibus"
            forms["ablative_plural"] = stem + "ibus"
            
        case 4 where gender == .neuter: // -u
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
public func analyzePsalm(text: [String]) -> PsalmAnalysisResult {
    var allWords: [String] = []
    var lemmaCounts: [String: Int] = [:]
    var formCounts: [String: [String: Int]] = [:]
    var lemmaEntities: [String: LatinWordEntity] = [:]
    let formToLemma = lemmaMapping.createFormToLemmaMapping()
     //   print("!!!multiplio forms in mapping:")
     // print(formToLemma.filter { $0.value.contains("multiplio") }.keys.sorted())
   let debugForms = formToLemma.filter { $0.value.contains("pascuum") }.keys.sorted()
    print("Debug - Forms mapping to 'pascuum': \(debugForms)")

    //let multiplioForms = formToLemma.filter { $0.value.contains("multiplio") }.keys.sorted()
    //print("Debug - Forms mapping to 'multiplio': \(multiplioForms)")
    //print("Does 'multiplicati' map to multiplio?: \(multiplioForms.contains("multiplicati"))")
     
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
    
    return PsalmAnalysisResult(
        totalWords: allWords.count,
        uniqueWords: Set(allWords).count,
        uniqueLemmas: lemmaCounts.count,
        dictionary: resultDictionary
    )
}
    
    // Keep original String version for backward compatibility
    public func analyzePsalm(text: String) -> PsalmAnalysisResult {
        let lines = text.components(separatedBy: .newlines)
        return analyzePsalm(text: lines)
    }
    
    
    // MARK: - Export Methods
    
    public func exportAnalysisResult(_ result: PsalmAnalysisResult, to filePath: String) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(result)
        try jsonData.write(to: URL(fileURLWithPath: filePath))
    }
}
