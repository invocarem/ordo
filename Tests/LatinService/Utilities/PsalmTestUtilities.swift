@testable import LatinService
import XCTest

public enum PsalmTestUtilities {
    public static let latinService = LatinService.shared

    public static func testLineByLineKeyLemmas(
        psalmText: [String],
        lineKeyLemmas: [(Int, [String])],
        psalmId: PsalmIdentity,
        verbose: Bool = true
    ) {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalmText[lineNumber - 1]
            let analysis = latinService.analyzePsalm(psalmId, text: line, startingLineNumber: lineNumber)

            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let foundLemmas = expectedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = expectedLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                print(
                    "\(status) Line \(lineNumber): Found \(foundLemmas.count)/\(expectedLemmas.count) key lemmas: \(foundLemmas.joined(separator: ", "))"
                )

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                    print("   Available: \(detectedLemmas.sorted().joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append(
                    "Line \(lineNumber): Missing lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Missing lemmas detected:\n" + allFailures.joined(separator: "\n"))
        }
    }

    public static func testStructuralThemes(
        psalmText: [String],
        structuralThemes: [(String, String, [String], Int, Int, String, String)],
        psalmId: PsalmIdentity,
        verbose: Bool = true
    ) {
        var allFailures: [String] = []

        for theme in structuralThemes {
            let (name, description, lemmas, startLine, endLine, comment, comment2) = theme

            // Extract the relevant lines
            let lines = psalmText[startLine - 1 ..< endLine]
            let textToAnalyze = lines.joined(separator: " ")

            let analysis = latinService.analyzePsalm(psalmId, text: textToAnalyze)
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })

            let foundLemmas = lemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = lemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                print("\n\(status) [STRUCTURAL] \(name) (Lines \(startLine)-\(endLine))")
                print("   \(description)")
                print("   Found \(foundLemmas.count)/\(lemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }

                print("   Comment: \(comment)")
                print("   Augustine: \(comment2)")
            }

            if !missingLemmas.isEmpty {
                allFailures.append("Structural theme '\(name)': Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Structural theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }

    public static func testConceptualThemes(
        psalmText: [String],
        conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)],
        psalmId: PsalmIdentity,
        verbose: Bool = true
    ) {
        var allFailures: [String] = []

        for theme in conceptualThemes {
            let (name, description, lemmas, category, lineRange) = theme
            let textToAnalyze: String
            if let lineRange = lineRange {
                let lines = psalmText[lineRange.lowerBound - 1 ... lineRange.upperBound - 1]
                textToAnalyze = lines.joined(separator: " ")
            } else {
                textToAnalyze = psalmText.joined(separator: " ")
            }

            let analysis = latinService.analyzePsalm(psalmId, text: textToAnalyze)
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })

            let foundLemmas = lemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = lemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                let rangeDescription = lineRange.map { "Lines \($0)" } ?? "Entire Psalm"
                print("\n\(status) [\(category.rawValue.uppercased())] \(name) (\(rangeDescription)): \(description)")
                print("   Found \(foundLemmas.count)/\(lemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append("Theme \(name) (\(category.rawValue)): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }

    public static func generateStructuralThemesJSONString(
        structuralThemes: [(String, String, [String], Int, Int, String, String)]
    ) -> String? {
        guard !structuralThemes.isEmpty else {
            return "{\n  \"structuralThemes\": []\n}"
        }

        var output = "{\n  \"structuralThemes\": [\n"

        for (index, theme) in structuralThemes.enumerated() {
            let (name, description, lemmas, startLine, endLine, comment, comment2) = theme

            // Escape quotes for JSON safety
            let escapedComment = comment.replacingOccurrences(of: "\"", with: "\\\"")
            let escapedComment2 = comment2.replacingOccurrences(of: "\"", with: "\\\"")

            output += "    {\n"
            output += "      \"name\": \"\(name)\",\n"
            output += "      \"description\": \"\(description)\",\n"
            output += "      \"lemmas\": ["

            // Add lemmas in a single line for compactness
            let lemmaString = lemmas.map { "\"\($0)\"" }.joined(separator: ", ")
            output += "\(lemmaString)],\n"

            output += "      \"startLine\": \(startLine),\n"
            output += "      \"endLine\": \(endLine),\n"
            output += "      \"comment\": \"\(escapedComment)\",\n"
            output += "      \"comment2\": \"\(escapedComment2)\"\n"
            output += "    }"
            output += index < structuralThemes.count - 1 ? ",\n" : "\n"
        }

        output += "  ]\n}"
        return output
    }

    public static func generateConceptualThemesJSONString(
        conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)]
    ) -> String? {
        var output = "{\n  \"conceptualThemes\": [\n"

        for (index, theme) in conceptualThemes.enumerated() {
            let (name, description, lemmas, category, lineRange) = theme

            output += "    {\n"
            output += "      \"name\": \"\(name)\",\n"
            output += "      \"description\": \"\(description)\",\n"
            output += "      \"category\": \"\(category.rawValue)\",\n"

            if let lineRange = lineRange {
                output += "      \"lineRange\": {\n"
                output += "        \"start\": \(lineRange.lowerBound),\n"
                output += "        \"end\": \(lineRange.upperBound)\n"
                output += "      },\n"
            }

            output += "      \"lemmas\": [\n"
            for (lemmaIndex, lemma) in lemmas.enumerated() {
                output += "        \"\(lemma)\""
                output += lemmaIndex < lemmas.count - 1 ? ",\n" : "\n"
            }
            output += "      ]\n"
            output += "    }"
            output += index < conceptualThemes.count - 1 ? ",\n" : "\n"
        }

        output += "  ]\n}"
        return output
    }

    public static func generateCompleteThemesJSONString(
        psalmNumber: Int,
        category: String = "",
        conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)],
        structuralThemes: [(String, String, [String], Int, Int, String, String)]
    ) -> String? {
        // Generate individual JSON strings
        guard let conceptualJSON = generateConceptualThemesJSONString(conceptualThemes: conceptualThemes),
              let structuralJSON = generateStructuralThemesJSONString(structuralThemes: structuralThemes)
        else {
            print("❌ Failed to generate individual theme JSONs")
            return nil
        }

        // Remove the outer braces from both JSON strings
        let conceptualContent = conceptualJSON
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .dropFirst() // Remove first {
            .dropLast() // Remove last }

        let structuralContent = structuralJSON
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .dropFirst() // Remove first {
            .dropLast() // Remove last }

        // Combine them into a single JSON object
        let combinedJSON = """
        {
         "psalmNumber": \(psalmNumber),
         "category": "\(category)",
        \(structuralContent),
        \(conceptualContent)
        }
        """

        return combinedJSON
    }

    public static func saveToFile(
        content: String,
        filename: String
    ) -> Bool {
        do {
            // Always use /app directory (mounted from host)
            let fileURL = URL(fileURLWithPath: "/app").appendingPathComponent(filename)

            // Write content to file
            try content.write(to: fileURL, atomically: true, encoding: .utf8)

            print("✅ File saved: \(fileURL.path)")
            return true

        } catch {
            print("❌ Failed to save file: \(error)")
            return false
        }
    }
}
