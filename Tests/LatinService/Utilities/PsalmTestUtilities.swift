import XCTest

@testable import LatinService

public enum PsalmTestUtilities {
  public static let latinService = LatinService.shared

  // Normalize Latin text to classical orthography for testing consistency.
  // Examples: "ejus" → "eius", "jurat" → "iurat", "judica" → "iudica",
  // and general replacement of 'j'/'J' with 'i'/'I'.
  public static func validateLatinText(_ text: String) -> String {
    var result = text

    // Specific fixes first (case-insensitive), then general 'j' → 'i'.
    result = replaceCaseInsensitive(in: result, target: "ejus", replacement: "eius")
    result = replaceCaseInsensitive(in: result, target: "jud", replacement: "iud")
    result = replaceCaseInsensitive(in: result, target: "jur", replacement: "iur")
    result = replaceCaseInsensitive(in: result, target: "just", replacement: "iust")

    // General replacements for remaining 'j' characters
    result = result.replacingOccurrences(of: "j", with: "i")
    result = result.replacingOccurrences(of: "J", with: "I")

    return result
  }

  private static func replaceCaseInsensitive(in text: String, target: String, replacement: String)
    -> String
  {
    let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
    var output = text
    var searchRange = output.startIndex..<output.endIndex

    while let range = output.range(of: target, options: options, range: searchRange) {
      output.replaceSubrange(range, with: replacement)
      let nextStart = output.index(range.lowerBound, offsetBy: replacement.count)
      searchRange = nextStart..<output.endIndex
    }
    return output
  }

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
      let lines = psalmText[startLine - 1..<endLine]
      let textToAnalyze = lines.joined(separator: " ")

      let analysis = latinService.analyzePsalm(psalmId, text: textToAnalyze)
      let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })

      let foundLemmas = lemmas.filter { detectedLemmas.contains($0.lowercased()) }
      let missingLemmas = lemmas.filter { !detectedLemmas.contains($0.lowercased()) }

      if verbose {
        let status = missingLemmas.isEmpty ? "✅" : "❌"
        print("\n\(status) [STRUCTURAL] \(name) (Lines \(startLine)-\(endLine))")
        print("   \(description)")
        print(
          "   Found \(foundLemmas.count)/\(lemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))"
        )

        if !missingLemmas.isEmpty {
          print("   MISSING: \(missingLemmas.joined(separator: ", "))")
        }

        print("   Comment: \(comment)")
        print("   Augustine: \(comment2)")
      }

      if !missingLemmas.isEmpty {
        allFailures.append(
          "Structural theme '\(name)': Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))"
        )
      }
    }

    if !allFailures.isEmpty {
      XCTFail(
        "Structural theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
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
        let lines = psalmText[lineRange.lowerBound - 1...lineRange.upperBound - 1]
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
        print(
          "\n\(status) [\(category.rawValue.uppercased())] \(name) (\(rangeDescription)): \(description)"
        )
        print(
          "   Found \(foundLemmas.count)/\(lemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))"
        )

        if !missingLemmas.isEmpty {
          print("   MISSING: \(missingLemmas.joined(separator: ", "))")
        }
      }

      if !missingLemmas.isEmpty {
        allFailures.append(
          "Theme \(name) (\(category.rawValue)): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))"
        )
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

      // Filter out common words from lemmas
      let filteredLemmas = filterCommonWords(from: lemmas)

      // Escape quotes for JSON safety
      let escapedComment = comment.replacingOccurrences(of: "\"", with: "\\\"")
      let escapedComment2 = comment2.replacingOccurrences(of: "\"", with: "\\\"")

      output += "    {\n"
      output += "      \"name\": \"\(name)\",\n"
      output += "      \"description\": \"\(description)\",\n"
      output += "      \"lemmas\": ["

      // Add filtered lemmas in a single line for compactness
      let lemmaString = filteredLemmas.map { "\"\($0)\"" }.joined(separator: ", ")
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

      // Filter out common words from lemmas
      let filteredLemmas = filterCommonWords(from: lemmas)

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
      for (lemmaIndex, lemma) in filteredLemmas.enumerated() {
        output += "        \"\(lemma)\""
        output += lemmaIndex < filteredLemmas.count - 1 ? ",\n" : "\n"
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
    guard
      let conceptualJSON = generateConceptualThemesJSONString(conceptualThemes: conceptualThemes),
      let structuralJSON = generateStructuralThemesJSONString(structuralThemes: structuralThemes)
    else {
      print("❌ Failed to generate individual theme JSONs")
      return nil
    }

    // Remove the outer braces from both JSON strings
    let conceptualContent =
      conceptualJSON
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .dropFirst()  // Remove first {
      .dropLast()  // Remove last }

    let structuralContent =
      structuralJSON
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .dropFirst()  // Remove first {
      .dropLast()  // Remove last }

    // Combine them into a single JSON object
    let combinedJSON = """
      {
       "psalmNumber": \(psalmNumber),
       "category": "\(category.lowercased())",
      \(structuralContent),
      \(conceptualContent)
      }
      """

    return combinedJSON
  }

  public static func generatePsalmTextsJSONString(
    psalmNumber: Int,
    category: String = "",
    text: [String],
    englishText: [String]
  ) -> String {
    let textJson = text.map { "\"\($0.replacingOccurrences(of: "\"", with: "\\\""))\"" }.joined(
      separator: ",\n    ")
    let englishTextJson = englishText.map {
      "\"\($0.replacingOccurrences(of: "\"", with: "\\\""))\""
    }.joined(separator: ",\n    ")

    return """
      {
        "number": \(psalmNumber),
        "section": "\(category)",
        "text": [
          \(textJson)
        ],
        "englishText": [
          \(englishTextJson)
        ]
      }
      """
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

  /// Filters out common words from theme lemmas to focus on more distinctive vocabulary
  /// Removes: cor, anima, dominus, and words starting with "iudi" or "iust"
  public static func filterCommonWords(from lemmas: [String]) -> [String] {
    let commonWords = Set(["cor", "anima", "dominus"])

    return lemmas.filter { lemma in
      let lowercased = lemma.lowercased()

      // Filter out common words
      if commonWords.contains(lowercased) {
        return false
      }

      // Filter out words starting with "iudi" or "iust"
      if lowercased.hasPrefix("iudi") || lowercased.hasPrefix("iust") {
        return false
      }

      return true
    }
  }

  /// Verifies that all lemmas from a source set are present in a target set
  ///
  /// Usage examples:
  /// ```swift
  /// // Check if structural theme lemmas are in lineKeyLemmas
  /// let isValid = utilities.verifyLemmasInSet(
  ///   sourceLemmas: structuralThemes.flatMap { $0.2 },
  ///   targetLemmas: lineKeyLemmas.flatMap { $0.1 },
  ///   sourceName: "structural themes",
  ///   targetName: "lineKeyLemmas"
  /// )
  ///
  /// // Check if conceptual theme lemmas are in structural themes
  /// utilities.testLemmasInSet(
  ///   sourceLemmas: conceptualThemes.flatMap { $0.2 },
  ///   targetLemmas: structuralThemes.flatMap { $0.2 },
  ///   sourceName: "conceptual themes",
  ///   targetName: "structural themes",
  ///   failOnMissing: false // Don't fail test if missing
  /// )
  /// ```
  ///
  /// - Parameters:
  ///   - sourceLemmas: The lemmas to check for presence
  ///   - targetLemmas: The set that should contain the source lemmas
  ///   - sourceName: Name of the source set for error reporting
  ///   - targetName: Name of the target set for error reporting
  ///   - verbose: Whether to print detailed information
  /// - Returns: True if all source lemmas are present in target, false otherwise
  public static func verifyLemmasInSet(
    sourceLemmas: [String],
    targetLemmas: [String],
    sourceName: String,
    targetName: String,
    verbose: Bool = true
  ) -> Bool {
    let sourceSet = Set(sourceLemmas.map { $0.lowercased() })
    let targetSet = Set(targetLemmas.map { $0.lowercased() })

    let missingLemmas = sourceSet.subtracting(targetSet)

    if !missingLemmas.isEmpty {
      if verbose {
        print("❌ Missing lemmas from \(sourceName) in \(targetName):")
        for lemma in missingLemmas.sorted() {
          print("  - \(lemma)")
        }
        print("  Total missing: \(missingLemmas.count) out of \(sourceSet.count)")
      }
      return false
    }

    if verbose {
      print("✅ All \(sourceSet.count) lemmas from \(sourceName) are present in \(targetName)")
    }

    return true
  }

  /// Verifies lemmas between two sets with detailed analysis and XCTest integration
  /// - Parameters:
  ///   - sourceLemmas: The lemmas to check for presence
  ///   - targetLemmas: The set that should contain the source lemmas
  ///   - sourceName: Name of the source set for error reporting
  ///   - targetName: Name of the target set for error reporting
  ///   - verbose: Whether to print detailed information
  ///   - failOnMissing: Whether to call XCTFail if lemmas are missing (default: true)
  public static func testLemmasInSet(
    sourceLemmas: [String],
    targetLemmas: [String],
    sourceName: String,
    targetName: String,
    verbose: Bool = true,
    failOnMissing: Bool = true
  ) {
    let sourceSet = Set(sourceLemmas.map { $0.lowercased() })
    let targetSet = Set(targetLemmas.map { $0.lowercased() })

    let missingLemmas = sourceSet.subtracting(targetSet)

    if !missingLemmas.isEmpty {
      if verbose {
        print("❌ Missing lemmas from \(sourceName) in \(targetName):")
        for lemma in missingLemmas.sorted() {
          print("  - \(lemma)")
        }
        print("  Total missing: \(missingLemmas.count) out of \(sourceSet.count)")
      }

      if failOnMissing {
        XCTFail(
          "Missing lemmas from \(sourceName) in \(targetName): \(Array(missingLemmas).sorted().joined(separator: ", "))"
        )
      }
    } else {
      if verbose {
        print("✅ All \(sourceSet.count) lemmas from \(sourceName) are present in \(targetName)")
      }
    }
  }
}
