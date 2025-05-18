import Foundation

extension LatinService {
    
    func addThematicAnalysis(
        to result: PsalmAnalysisResult,
        lines: [String],
        startingLineNumber: Int = 1
    ) -> PsalmAnalysisResult {
        var mutableResult = result
        mutableResult.themes = []
        
        // Build word-to-line mapping
        let wordLineMap = buildWordLineMap(lines: lines, startingLineNumber: startingLineNumber)
        
        // Process each 2-line group
        for lineIndex in stride(from: 0, to: lines.count, by: 2) {
            let currentLineNumber = startingLineNumber + lineIndex
            let lineRange = currentLineNumber...(currentLineNumber + 1)
            
            // Get all lemmas that appear in this line group
            let groupLemmas = getLemmasInRange(
                result: result,
                wordLineMap: wordLineMap,
                lineRange: lineRange
            )
            
            // Check themes for this group
            for theme in themesForLine(currentLineNumber) {
                let hasSupport = theme.lemmas.allSatisfy { groupLemmas.contains($0) }
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
        
        return mutableResult
    }
    
    private func buildWordLineMap(lines: [String], startingLineNumber: Int) -> [String: Int] {
        var wordLineMap = [String: Int]()
        var currentPosition = 0
        
        for (index, line) in lines.enumerated() {
            let words = line.lowercased()
                .components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
            
            words.forEach { word in
                wordLineMap[word] = startingLineNumber + index
                currentPosition += 1
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
    
    private func themesForLine(_ lineNumber: Int) -> [(name: String, description: String, lemmas: [String])] {
        switch lineNumber {
        case 1: // Lines 1-2
            return [
                ("Divine Response", "God's answer to prayer", ["invoco", "exaudio"]),
                ("Divine Justice", "God's righteous nature", ["deus", "justitia"]),
                ("Human Need", "Human dependence on God", ["tribulatio", "misereor"])
            ]
        case 3: // Lines 3-4
            return [
                ("Human Folly", "Vanity of worldly pursuits", ["vanitas", "mendacium"]),
                ("Divine Revelation", "God's marvelous works", ["mirifico", "sanctus"])
            ]
        // ... other line groups ...
        default:
            return []
        }
    }
}