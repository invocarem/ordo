import Foundation

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
    let startLine: Int
    let themes: [Theme]

    public struct Theme: Codable {
        let name: String
        let description: String
        let lemmas: [String]
        let comment: String?
    }
}
extension LatinService {
    
    func addThematicAnalysis(
        to result: PsalmAnalysisResult,
        psalm identity: PsalmIdentity,  // Added this parameter
        lines: [String],
        startingLineNumber: Int = 1
    ) -> PsalmAnalysisResult {
        var mutableResult = result
        mutableResult.themes = []
        
        print("Starting analysis for \(identity.displayName), startingLineNumber: \(startingLineNumber)")
            print("Input lines (\(lines.count)): \(lines)")
            
        // Build word-to-line mapping
        let wordLineMap = buildWordLineMap(lines: lines, startingLineNumber: startingLineNumber)
        
        print("Word-line map: \(wordLineMap)")
           
        // Process each 2-line group
        for lineIndex in stride(from: 0, to: lines.count, by: 2) {
            let currentLineNumber = startingLineNumber + lineIndex
            let lineRange = currentLineNumber...(currentLineNumber + 1)
            print("Processing line group: \(currentLineNumber)...\(currentLineNumber + 1)")
                   
            // Get all lemmas that appear in this line group
            let groupLemmas = getLemmasInRange(
                result: result,
                wordLineMap: wordLineMap,
                lineRange: lineRange
            )
            
            print("Line \(currentLineNumber): groupLemmas = \(groupLemmas.sorted())")
            print("Dictionary lemmas (sample): \(result.dictionary.keys.sorted().prefix(10))")
            
            // Check themes for this group - now passing psalm identity
            for theme in themesForLineFromJSON(currentLineNumber, psalm: identity) {
                let missingLemmas = theme.lemmas.filter { !groupLemmas.contains($0) }
                           let hasSupport = missingLemmas.isEmpty
                           print("Theme '\(theme.name)' (lemmas: \(theme.lemmas)) hasSupport: \(hasSupport)")
                           if !hasSupport {
                               print("  Missing lemmas: \(missingLemmas)")
                           }
               
                print("Theme '\(theme.name)' (lemmas: \(theme.lemmas)) hasSupport: \(hasSupport)")
                           if !hasSupport {
                               print("  Missing lemmas:")
                           }
                if hasSupport {
                    mutableResult.themes.append(
                        PsalmAnalysisResult.Theme(
                            name: theme.name,
                            description: theme.description,
                            supportingLemmas: theme.lemmas,
                            lineRange: currentLineNumber...currentLineNumber
                        )
                    )
                }
            }
        }
        print("Total themes added: \(mutableResult.themes.count)")
           print("Added themes: \(mutableResult.themes.map { $0.name })")
        
        return mutableResult
    }
    
    private func buildWordLineMap(lines: [String], startingLineNumber: Int) -> [String: Int] {
        var wordLineMap = [String: Int]()
        let punctuation = CharacterSet.punctuationCharacters
        
        for (index, line) in lines.enumerated() {
            let words = line.lowercased()
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
                .map { word in
                    // Strip trailing punctuation
                    String(word.unicodeScalars.filter { !punctuation.contains($0) })
                }
            
            words.forEach { word in
                if !word.isEmpty {
                    wordLineMap[word] = startingLineNumber + index
                }
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
        
        // Check each word in the dictionary
        for (lemma, info) in result.dictionary {
            // Check all forms of this lemma
            for form in info.forms.keys {
                if let lineNumber = wordLineMap[form],
                   lineRange.contains(lineNumber) {
                    lemmasInRange.insert(lemma)
                    break
                }
            }
        }
        
        return lemmasInRange
    }
    private func themesForLineFromJSON(_ lineNumber: Int, psalm identity: PsalmIdentity) -> [(name: String, description: String, lemmas: [String])] {
        let effectiveSection = identity.category?.lowercased() ?? ""
        print("Filtering for psalm \(identity.number), category: '\(effectiveSection)', startLine: \(lineNumber)")
        
        let matchingThemes = self.themeCache
            .filter {
                let categoryMatches = $0.category.lowercased() == effectiveSection || ($0.category.isEmpty && effectiveSection.isEmpty)
                let psalmMatches = $0.psalmNumber == identity.number
                let lineMatches = $0.startLine == lineNumber
                //print("Checking entry: psalm \($0.psalmNumber), category '\($0.category)', startLine \($0.startLine) -> Matches: \(psalmMatches && categoryMatches && lineMatches)")
                return psalmMatches && categoryMatches && lineMatches
            }
            .flatMap { $0.themes }
            .map { (name: $0.name, description: $0.description, lemmas: $0.lemmas) }
        
        print("!!! Line \(lineNumber), Psalm \(identity.number): Found \(matchingThemes.count) themes: \(matchingThemes.map { $0.name })")
        return matchingThemes
    }
    
    
   
}
