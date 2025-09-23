@testable import LatinService
import XCTest

class Psalm127Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 127, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 7
  private let text = [
    "Beati omnes qui timent Dominum, qui ambulant in viis eius.",
    "Labores fructuum tuorum manducabis; beatus es, et bene tibi erit.",
    "Uxor tua sicut vitis abundans in lateribus domus tuae;",
    "Filii tui sicut novellae olivarum in circuitu mensae tuae.",
    "Ecce sic benedicetur homo qui timet Dominum.",
    "Benedicat tibi Dominus ex Sion, et videas bona Ierusalem omnibus diebus vitae tuae.",
    "Et videas filios filiorum tuorum. Pax super Israel!",
  ]

  private let englishText = [
    "Blessed are all they that fear the Lord: that walk in his ways.",
    "For thou shalt eat the labours of thy hands: blessed art thou, and it shall be well with thee.",
    "Thy wife as a fruitful vine, on the sides of thy house.",
    "Thy children as olive plants, round about thy table.",
    "Behold, thus shall the man be blessed that feareth the Lord.",
    "May the Lord bless thee out of Sion: and mayest thou see the good things of Jerusalem all the days of thy life.",
    "And mayest thou see thy children's children, peace upon Israel.",
  ]

  private let lineKeyLemmas = [
    (1, ["beatus", "omnis", "timeo", "dominus", "ambulo", "via"]),
    (2, ["labor", "fructus", "manduco", "beatus", "bene"]),
    (3, ["uxor", "vitis", "abundo", "latus", "domus"]),
    (4, ["filius", "novellus", "oliva", "circuitus", "mensa"]),
    (5, ["ecce", "benedico", "homo", "timeo", "dominus"]),
    (6, ["benedico", "dominus", "sion", "video", "bonus", "ierusalem", "dies", "vita"]),
    (7, ["video", "filius", "pax", "israel"]),
  ]

  private let structuralThemes = [
    (
      "Fear of the Lord and Right Living",
      "Blessing begins with those who fear the Lord and walk in His ways",
      ["beatus", "timeo", "ambulo", "via"],
      1,
      1,
      "Blessing begins with those who fear the Lord and walk in His ways",
      "Foundational condition for the blessings that follow."
    ),
    (
      "Fruit of Labor",
      "The work of one's hands will yield sustenance and well-being",
      ["labor", "fructus", "manduco", "bene"],
      2,
      2,
      "The work of one's hands will yield sustenance and well-being",
      "Earthly blessing tied to faithful diligence."
    ),
    (
      "Domestic Abundance",
      "The home is portrayed as flourishing: wife as vine, children as olive shoots",
      ["uxor", "vitis", "abundo", "filius", "novellus", "oliva", "mensa", "domus"],
      3,
      3,
      "The home is portrayed as flourishing: wife as vine, children as olive shoots",
      "Rich family imagery celebrating household fruitfulness."
    ),
    (
      "Covenantal Blessing",
      "The man who fears the Lord is blessed with this abundance",
      ["benedico", "homo", "timeo"],
      4,
      4,
      "The man who fears the Lord is blessed with this abundance",
      "Repetition reinforces the blessing tied to fear of the Lord."
    ),
    (
      "Zion and Lifelong Prosperity",
      "Blessings come from Zion, extending to the prosperity of Jerusalem and one's lifetime",
      ["benedico", "sion", "video", "bonus", "jerusalem", "dies", "vita"],
      5,
      5,
      "Blessings come from Zion, extending to the prosperity of Jerusalem and one's lifetime",
      "Spatial and temporal expansion of the blessing—from household to holy city."
    ),
    (
      "Generational Continuity and Peace",
      "The final hope is to see one's grandchildren and the peace of Israel",
      ["video", "filius", "pax", "israel"],
      6,
      6,
      "The final hope is to see one's grandchildren and the peace of Israel",
      "Closes with generational vision and national peace."
    ),
  ]

  private let conceptualThemes = [
    (
      "Blessedness and Fear of the Lord",
      "The foundation of all blessings is reverence for God",
      ["beatus", "timeo", "dominus", "ambulo", "via"],
      ThemeCategory.virtue,
      1 ... 1
    ),
    (
      "Labor and Reward",
      "The connection between honest work and divine blessing",
      ["labor", "fructus", "manduco", "bene"],
      ThemeCategory.virtue,
      2 ... 2
    ),
    (
      "Family and Domestic Life",
      "Blessings of marriage, children, and household prosperity",
      ["uxor", "vitis", "filius", "oliva", "mensa", "domus"],
      ThemeCategory.virtue,
      3 ... 4
    ),
    (
      "Divine Blessing",
      "God's active role in bestowing prosperity and peace",
      ["benedico", "dominus", "sion", "video", "bonus"],
      ThemeCategory.divine,
      4 ... 6
    ),
    (
      "Jerusalem and Zion",
      "The holy city as the source of blessing",
      ["sion", "ierusalem", "video", "bonus"],
      ThemeCategory.worship,
      5 ... 6
    ),
    (
      "Generational Continuity",
      "The hope for lasting prosperity through descendants",
      ["video", "filius", "pax", "israel"],
      ThemeCategory.virtue,
      6 ... 7
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 127 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 127 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm127_texts.json"
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
      filename: "output_psalm127_themes.json"
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
