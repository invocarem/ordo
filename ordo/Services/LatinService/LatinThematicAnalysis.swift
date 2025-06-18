import Foundation

// MARK: - Data Models
public struct PsalmIdentity {
    let number: Int       // e.g. 4 or 118
    let category: String?  // e.g. "aleph" (nil for most psalms)
    
    var displayName: String {
        category != nil ? "Psalm \(number):\(category!)" : "Psalm \(number)"
    }
}

public struct PsalmThemes: Codable {
    let themes: [PsalmThemeData]
}

public struct PsalmThemeData: Codable {
    let psalmNumber: Int
    let category: String
    let themes: [Theme]
    
    public struct Theme: Codable {
        let name: String
        let description: String
        let lemmas: [String]
        let startLine: Int
        let endLine: Int
        let comment: String?
    }
}

// MARK: - Theme Manager
class PsalmThemeManager {
    static let shared = PsalmThemeManager()
    private var themeData: [PsalmThemeData] = []
    
    private init() {
        loadThemeData()
    }
    
    private func loadThemeData() {

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
            guard let url = bundle.url(forResource: "themes", withExtension: "json"),
                let data = try? Data(contentsOf: url) else  {
                    print("Failed to load theme data")
                    return
                }
            do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(PsalmThemes.self, from: data)
                    themeData = jsonData.themes
                    print("Successfully loaded theme data for \(themeData.count) psalms")
                } catch {
                    print("Error decoding theme data: \(error)")
            }
        }
    }
    
    func getThemes(for psalmNumber: Int, category: String = "") -> [PsalmThemeData.Theme] {
        return themeData
            .filter { $0.psalmNumber == psalmNumber && $0.category == category }
            .flatMap { $0.themes }
    }
    
    func getThemes(forLine lineNumber: Int, psalmNumber: Int, category: String = "") -> [PsalmThemeData.Theme] {
        return themeData
            .filter { $0.psalmNumber == psalmNumber && $0.category == category }
            .flatMap { $0.themes }
            .filter { lineNumber >= $0.startLine && lineNumber <= $0.endLine }
    }
}

// MARK: - Integration with LatinService
extension LatinService {
    func updateThematicAnalysis(

    for result: PsalmAnalysisResult,
    psalm identity: PsalmIdentity,
    lines: [String],
    startingLineNumber: Int
) -> PsalmAnalysisResult {
    var updatedResult = result
    
    // 1. Get all themes for this psalm
    let allThemes = PsalmThemeManager.shared.getThemes(
        for: identity.number,
        category: identity.category ?? ""
    )
    
    // 2. Build word-to-line mapping
    let wordLineMap = buildWordLineMap(lines: lines, startingLineNumber: startingLineNumber)
    
    // 3. Process each theme
    for theme in allThemes {
        let lineRange = theme.startLine...theme.endLine
        let groupLemmas = getLemmasInRange(
            result: result,
            wordLineMap: wordLineMap,
            lineRange: lineRange
        )
        let requiredLemmaCount = 1  //max(1, theme.lemmas.count / 2) 
        let matchingLemmaCount = theme.lemmas.filter { groupLemmas.contains($0) }.count
        let isThemePresent = matchingLemmaCount >= requiredLemmaCount
        
        // Check if all theme lemmas exist in these lines
        //let isThemePresent = theme.lemmas.allSatisfy { groupLemmas.contains($0) }
        
        if isThemePresent {
            updatedResult.themes.append(
                PsalmAnalysisResult.Theme(
                    name: theme.name,
                    description: theme.description,
                    supportingLemmas: theme.lemmas,
                    lineRange: lineRange,
                    comment: theme.comment ?? "N/A",
                )
            )
        }
    }
    
    return updatedResult
}
   
    // Original helper functions remain unchanged
    private func buildWordLineMap(lines: [String], startingLineNumber: Int) -> [String: Int] {
        var wordLineMap = [String: Int]()
        let punctuation = CharacterSet.punctuationCharacters
        
        for (index, line) in lines.enumerated() {
            let words = line.lowercased()
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
                .map { word in
                    String(word.unicodeScalars.filter { !punctuation.contains($0) })
                }
            
            for word in words where !word.isEmpty {
                wordLineMap[word] = startingLineNumber + index
            }
        }
        
        return wordLineMap
    }
    
    private func getLemmasInRange(
        result: PsalmAnalysisResult,
        wordLineMap: [String: Int],
        lineRange: ClosedRange<Int>
    ) -> Set<String> {
        var lemmasInRange = Set<String>()
        
        for (lemma, info) in result.dictionary {
            for form in info.forms.keys {
                if let lineNumber = wordLineMap[form], lineRange.contains(lineNumber) {
                    lemmasInRange.insert(lemma)
                    break
                }
            }
        }
        
        return lemmasInRange
    }
    
    
    
   
}
