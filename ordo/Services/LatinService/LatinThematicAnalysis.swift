import Foundation

// MARK: - Data Models

public struct PsalmIdentity {
    let number: Int // e.g. 4 or 118
    let category: String? // e.g. "aleph" (nil for most psalms)

    var displayName: String {
        category != nil ? "Psalm \(number):\(category!)" : "Psalm \(number)"
    }
}

public enum ThemeCategory: String, Codable {
    case divine
    case justice

    case worship
    case virtue

    case sin
    case conflict
    case opposition

    case unknown

    // Provide a fallback initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = ThemeCategory(rawValue: rawValue.lowercased()) ?? .unknown
    }
}

public struct ConceptualTheme: Codable {
    public let name: String
    public let description: String
    public let lemmas: [String]
    public let category: ThemeCategory
    public let lineRange: ClosedRange<Int>?

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case lemmas
        case category
        case lineRange
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        lemmas = try container.decode([String].self, forKey: .lemmas)
        category = try container.decode(ThemeCategory.self, forKey: .category)

        // Decode lineRange as dictionary with start/end keys
        if let rangeDict = try container.decodeIfPresent([String: Int].self, forKey: .lineRange),
           let start = rangeDict["start"],
           let end = rangeDict["end"]
        {
            lineRange = start ... end
        } else {
            lineRange = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(lemmas, forKey: .lemmas)
        try container.encode(category, forKey: .category)

        // Encode lineRange as dictionary with start/end keys
        if let range = lineRange {
            try container.encode(["start": range.lowerBound, "end": range.upperBound], forKey: .lineRange)
        } else {
            try container.encodeNil(forKey: .lineRange)
        }
    }
}

public typealias PsalmThemes = [PsalmThemeData]

public struct PsalmThemeData: Codable {
    let psalmNumber: Int
    let category: String
    let structuralThemes: [StructuralTheme]
    let conceptualThemes: [ConceptualTheme]?

    public struct StructuralTheme: Codable {
        let name: String
        let description: String
        let lemmas: [String]
        let startLine: Int
        let endLine: Int
        let comment: String?
        let comment2: String?
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
                  let data = try? Data(contentsOf: url)
            else {
                print("Failed to load theme data")
                return
            }
            do {
                let decoder = JSONDecoder()
                themeData = try decoder.decode([PsalmThemeData].self, from: data) // Direct array decoding
                print("Successfully loaded theme data for \(themeData.count) psalms")
            } catch {
                print("Error decoding theme data: \(error)")
            }
        }
    }

    func getThemes(for psalmNumber: Int, category: String = "") -> [PsalmThemeData.StructuralTheme] {
        return themeData
            .filter { $0.psalmNumber == psalmNumber && $0.category == category }
            .flatMap { $0.structuralThemes }
    }

    func getConceptualThemes(for psalmNumber: Int, category: String = "") -> [ConceptualTheme] {
        return themeData
            .filter { $0.psalmNumber == psalmNumber && $0.category == category }
            .flatMap { $0.conceptualThemes ?? [] }
    }

    func getThemes(forLine lineNumber: Int, psalmNumber: Int, category: String = "") -> [PsalmThemeData.StructuralTheme] {
        return themeData
            .filter { $0.psalmNumber == psalmNumber && $0.category == category }
            .flatMap { $0.structuralThemes }
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
            let lineRange = theme.startLine ... theme.endLine
            let groupLemmas = getLemmasInRange(
                result: result,
                wordLineMap: wordLineMap,
                lineRange: lineRange
            )
            let requiredLemmaCount = 1 // max(1, theme.lemmas.count / 2)
            let matchingLemmaCount = theme.lemmas.filter { groupLemmas.contains($0) }.count
            let isThemePresent = matchingLemmaCount >= requiredLemmaCount

            // Check if all theme lemmas exist in these lines
            // let isThemePresent = theme.lemmas.allSatisfy { groupLemmas.contains($0) }

            if isThemePresent {
                updatedResult.structuralThemes.append(
                    PsalmAnalysisResult.StructuralTheme(
                        name: theme.name,
                        description: theme.description,
                        supportingLemmas: theme.lemmas,
                        lineRange: lineRange,
                        comment: theme.comment ?? "N/A",
                        comment2: theme.comment2 ?? ""
                    )
                )
            }
        }

        let conceptualThemes = PsalmThemeManager.shared.getConceptualThemes(
            for: identity.number,
            category: identity.category ?? ""
        )

        for theme in conceptualThemes {
            let allLemmas = Set(result.dictionary.keys)
            let requiredLemmaCount = 1 // max(1, theme.lemmas.count / 2)
            let matchingLemmaCount = theme.lemmas.filter { allLemmas.contains($0) }.count
            let isThemePresent = matchingLemmaCount >= requiredLemmaCount

            if isThemePresent {
                updatedResult.conceptualThemes?.append(
                    PsalmAnalysisResult.ConceptualTheme(
                        name: theme.name,
                        description: theme.description,
                        category: theme.category,
                        supportingLemmas: theme.lemmas
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
