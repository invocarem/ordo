@testable import LatinService
import XCTest

class Psalm130Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 130, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 5
  private let text = [
    "Domine, non est exaltatum cor meum, neque elati sunt oculi mei;",
    "neque ambulavi in magnis, neque in mirabilibus super me.",
    "Si non humiliter sentiebam, sed exaltavi animam meam; ",
    "Sicut ablactatus est super matre sua, ita retributio in anima mea.",
    "Speret Israel in Domino, ex hoc nunc et usque in saeculum.",
  ]

  private let englishText = [
    "Lord, my heart is not exalted: nor are mine eyes lofty.",
    "Neither have I walked in great matters, nor in wonders above me.",
    "If I was not humbly minded, but exalted my soul:",
    "As a child that is weaned is towards his mother, so reward in my soul.",
    "Let Israel hope in the Lord, from henceforth now and for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "exalto", "cor", "elatus", "oculus"]),
    (2, ["ambulo", "magnus", "mirabilis", "super"]),
    (3, ["humilis", "sentio", "exalto", "anima"]),
    (4, ["sicut", "ablacto", "mater", "ita", "retributio"]),
    (5, ["spero", "israel", "dominus", "hic", "nunc", "usque", "saeculum"]),
  ]

  private let structuralThemes = [
    (
      "Humility Declaration → Contrast with Pride",
      "The psalmist's declaration of humility contrasted with what pride would look like",
      ["dominus", "exalto", "cor", "elatus", "oculus", "ambulo", "magnus", "mirabilis"],
      1,
      2,
      "The psalmist declares that his heart is not exalted, his eyes are not lofty, and he has not walked in great matters or wonders above him.",
      "Augustine sees this as the soul's recognition of its proper place before God - not seeking to elevate itself above its station or to grasp at divine prerogatives."
    ),
    (
      "Humble Mind → Weaning Metaphor",
      "The psalmist's humble mindset compared to a weaned child's relationship with its mother",
      ["humilis", "sentio", "exalto", "anima", "sicut", "ablacto", "mater", "retributio"],
      3,
      4,
      "The psalmist describes his humble mindset and uses the metaphor of a weaned child with its mother to illustrate the peace and contentment of humility.",
      "Augustine interprets this as the soul's progression from spiritual infancy to maturity - the weaned child no longer seeks the breast but finds contentment in the mother's presence, just as the humble soul finds satisfaction in God's presence without demanding signs and wonders."
    ),
    (
      "Individual Trust → Collective Hope",
      "Personal humility leading to Israel's collective hope in the Lord",
      ["spero", "israel", "dominus", "hic", "nunc", "usque", "saeculum"],
      5,
      5,
      "The psalmist moves from personal testimony to calling all Israel to hope in the Lord from now and forever.",
      "Augustine sees this as the natural progression from individual spiritual maturity to calling others to the same trust - the humble soul becomes a witness to God's faithfulness."
    ),
  ]

  private let conceptualThemes = [
    (
      "Humility and Lowliness",
      "The psalmist's emphasis on humility and rejection of pride",
      ["humilis", "exalto", "elatus", "magnus", "mirabilis"],
      ThemeCategory.virtue,
      1 ... 4
    ),
    (
      "Body Parts and Physical References",
      "References to physical body parts in spiritual context",
      ["cor", "oculus", "anima"],
      ThemeCategory.virtue,
      1 ... 4
    ),
    (
      "Movement and Action",
      "Verbs describing physical and spiritual movement",
      ["ambulo", "sentio", "exalto"],
      ThemeCategory.virtue,
      1 ... 4
    ),
    (
      "Divine Relationship",
      "References to God and the relationship with the divine",
      ["dominus", "retributio", "spero"],
      ThemeCategory.divine,
      1 ... 5
    ),
    (
      "Family Metaphors",
      "Family relationships used as spiritual metaphors",
      ["ablacto", "mater", "sicut", "ita"],
      ThemeCategory.virtue,
      3 ... 4
    ),
    (
      "Temporal Scope",
      "References to time and eternity",
      ["hic", "nunc", "usque", "saeculum"],
      ThemeCategory.divine,
      5 ... 5
    ),
    (
      "Collective Identity",
      "References to Israel as a people",
      ["israel", "spero"],
      ThemeCategory.worship,
      5 ... 5
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 130 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 130 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm130_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testSaveThemes() {
    let utilities = PsalmTestUtilities.self
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        category: id.category ?? "",
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm130_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testLineByLineKeyLemmas() {
    let utilities = PsalmTestUtilities.self
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
    let utilities = PsalmTestUtilities.self

    // First, verify that all structural theme lemmas are in lineKeyLemmas
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Then run the standard structural themes test
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    let utilities = PsalmTestUtilities.self

    // First, verify that conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Then run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
