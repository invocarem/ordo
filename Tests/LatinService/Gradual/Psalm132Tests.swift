@testable import LatinService
import XCTest

class Psalm132Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 132, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 4
  private let text = [
    "Ecce quam bonum, et quam iucundum habitare fratres in unum.",
    "Sicut unguentum in capite, quod descendit in barbam, barbam Aaron,",
    "Quod descendit in oram vestimenti eius: sicut ros Hermon, qui descendit in montem Sion.",
    "Quoniam illic mandavit Dominus benedictionem, et vitam usque in saeculum.",
  ]

  private let englishText = [
    "Behold how good and how pleasant it is for brethren to dwell together in unity.",
    "Like the precious ointment on the head, that ran down upon the beard, the beard of Aaron,",
    "Which ran down to the skirt of his garment: as the dew of Hermon, which descendeth upon mount Sion.",
    "For there the Lord hath commanded blessing, and life for evermore.",
  ]

  private let lineKeyLemmas = [
    (1, ["ecce", "bonus", "iucundus", "habito", "frater", "unus"]),
    (2, ["sicut", "unguentum", "caput", "descendo", "barba", "aaron"]),
    (3, ["descendo", "ora", "vestimentum", "ros", "hermon", "descendo", "mons", "sion"]),
    (4, ["mando", "dominus", "benedictio", "vita", "saeculum"]),
  ]

  private let structuralThemes = [
    (
      "Fraternal Unity",
      "Unity among brethren is declared good and joyful",
      ["frater", "habito", "bonus", "iucundus", "unus"],
      1,
      1,
      "Unity among brethren is declared good and joyful",
      "Opens with a vision of blessed communal harmony."
    ),
    (
      "Priestly Anointing and Sacred Flow",
      "Unity is likened to anointing oil flowing from Aaron's head to his garments",
      ["unguentum", "caput", "descendo", "barba", "vestimentum", "aaron"],
      2,
      3,
      "Unity is likened to anointing oil flowing from Aaron's head to his garments",
      "Priestly imagery conveys blessing flowing from head to body."
    ),
    (
      "Dew and Blessing from Zion",
      "Divine blessing descends like Hermon's dew on Zion, bringing eternal life",
      ["ros", "hermon", "mons", "sion", "mando", "benedictio", "vita", "saeculum"],
      3,
      4,
      "Divine blessing descends like Hermon's dew on Zion, bringing eternal life",
      "Natural imagery illustrates God's commanded blessing and life."
    ),
  ]

  private let conceptualThemes = [
    (
      "Fraternal Unity",
      "The goodness and pleasantness of brothers dwelling together in unity",
      ["frater", "habito", "bonus", "iucundus", "unus"],
      ThemeCategory.virtue,
      1 ... 1
    ),
    (
      "Priestly Anointing",
      "The imagery of sacred oil flowing from Aaron's head to his garments",
      ["unguentum", "caput", "descendo", "barba", "aaron", "vestimentum"],
      ThemeCategory.worship,
      2 ... 3
    ),
    (
      "Natural Blessing Imagery",
      "The dew of Hermon descending on Zion as a metaphor for divine blessing",
      ["ros", "hermon", "descendo", "mons", "sion"],
      ThemeCategory.divine,
      3 ... 3
    ),
    (
      "Divine Command and Eternal Life",
      "God's commanded blessing and eternal life from Zion",
      ["mando", "dominus", "benedictio", "vita", "saeculum"],
      ThemeCategory.divine,
      4 ... 4
    ),
    (
      "Sacred Geography",
      "The movement from Hermon to Zion as sacred geography",
      ["hermon", "sion", "mons", "descendo"],
      ThemeCategory.worship,
      3 ... 3
    ),
    (
      "Sacred Flow and Descent",
      "The theme of sacred blessing flowing and descending",
      ["descendo", "unguentum", "ros", "benedictio"],
      ThemeCategory.divine,
      2 ... 4
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Grouped Line Tests for Psalm 132

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 132 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 132 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm132_texts.json"
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
      filename: "output_psalm132_themes.json"
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
