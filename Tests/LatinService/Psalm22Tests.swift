@testable import LatinService
import XCTest

class Psalm22Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 22, category: "")

  // MARK: - Test Data Properties

  private let psalm22 = [
    "Dominus regit me, et nihil mihi deerit: in loco pascuae ibi me collocavit;",
    "Super aquam refectionis educavit me. Animam meam convertit;",
    "Deduxit me super semitas iustitiae propter nomen suum.",
    "Nam et si ambulavero in medio umbrae mortis, non timebo mala, quoniam tu mecum es;",
    "Virga tua et baculus tuus, ipsa me consolata sunt.",
    "Parasti in conspectu meo mensam adversus eos qui tribulant me; ",
    "Impinguasti in oleo caput meum, et calix meus inebrians quam praeclarus est!",
    "Et misericordia tua subsequetur me omnibus diebus vitae meae; ",
    "Et ut inhabitem in domo Domini in longitudinem dierum.",
  ]

  private let englishText = [
    "The Lord is my shepherd, and I shall want nothing: in a place of pasture there he hath set me;",
    "He hath brought me up on the water of refreshment: he hath converted my soul.",
    "He hath led me on the paths of justice, for his own name's sake.",
    "For though I should walk in the midst of the shadow of death, I will fear no evils, for thou art with me;",
    "Thy rod and thy staff, they have comforted me.",
    "Thou hast prepared a table before me against them that afflict me;",
    "Thou hast anointed my head with oil; and my chalice which inebriateth me, how goodly is it!",
    "And thy mercy will follow me all the days of my life;",
    "And that I may dwell in the house of the Lord unto length of days.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "rego", "nihil", "desum", "locus", "pascuum", "colloco"]),
    (2, ["aqua", "refectio", "educo", "anima", "converto"]),
    (3, ["deduco", "semita", "iustitia", "nomen"]),
    (4, ["ambulo", "medius", "umbra", "mors", "timeo", "malum", "mecum"]),
    (5, ["virga", "baculus", "consolor"]),
    (6, ["paro", "conspectus", "mensa", "tribulo"]),
    (7, ["impinguo", "oleum", "caput", "calix", "inebrio", "praeclarus"]),
    (8, ["misericordia", "subsequor", "omnis", "dies", "vita"]),
    (9, ["inhabito", "domus", "dominus", "longitudo", "dies"]),
  ]

  private let structuralThemes = [
    (
      "Shepherd → Provision",
      "The Lord as shepherd providing for the psalmist's needs",
      ["dominus", "rego", "nihil", "desum", "locus", "pascuum", "colloco", "aqua", "refectio", "educo"],
      1,
      2,
      "The Lord shepherds the psalmist, ensuring he lacks nothing, placing him in a place of pasture and leading him to waters of refreshment, converting his soul.",
      "Augustine sees this as describing the Christian's relationship with Christ the Good Shepherd. The 'nihil mihi deerit' shows complete divine provision, while the waters of refreshment represent the life-giving grace that converts the soul."
    ),
    (
      "Guidance → Protection",
      "God's guidance along paths of justice and protection through the valley of death",
      ["deduco", "semita", "iustitia", "nomen", "ambulo", "medius", "umbra", "mors", "timeo", "malum", "mecum"],
      3,
      4,
      "God leads the psalmist on paths of justice for His name's sake, and though he walks through the valley of the shadow of death, he fears no evil because God is with him.",
      "For Augustine, this represents the soul's journey through this world. The paths of justice are the ways of righteousness, while the valley of death represents the trials of earthly life, from which God's presence protects the faithful."
    ),
    (
      "Comfort → Provision",
      "God's rod and staff providing comfort, and His preparation of a table",
      ["virga", "baculus", "consolor", "paro", "conspectus", "mensa", "tribulo", "impinguo", "oleum", "caput", "calix"],
      5,
      7,
      "God's rod and staff comfort the psalmist, and He prepares a table before him against his enemies, anointing his head with oil and providing an overflowing cup.",
      "Augustine interprets this as the spiritual feast of the Eucharist. The rod and staff represent divine discipline and guidance, while the table, oil, and overflowing cup symbolize the abundant spiritual nourishment God provides to His people."
    ),
    (
      "Mercy → Dwelling",
      "God's mercy following the psalmist and his hope of dwelling in God's house",
      ["misericordia", "subsequor", "omnis", "dies", "vita", "inhabito", "domus", "dominus", "longitudo"],
      8,
      9,
      "God's mercy follows the psalmist all the days of his life, and he will dwell in the house of the Lord for length of days.",
      "For Augustine, this represents the eternal hope of the Christian. God's mercy is not temporary but follows the believer throughout life, culminating in eternal dwelling in God's presence, which is the ultimate fulfillment of the shepherd's care."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Shepherding",
      "The Lord as shepherd providing guidance and care",
      ["dominus", "rego", "pascuum", "educo", "deduco", "semita"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Provision and Abundance",
      "God's abundant provision for His people's needs",
      ["nihil", "desum", "aqua", "refectio", "mensa", "oleum", "calix", "impinguo"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Protection and Comfort",
      "Divine protection in times of danger and comfort through trials",
      ["umbra", "mors", "timeo", "malum", "mecum", "virga", "baculus", "consolor"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Eternal Hope",
      "The promise of God's mercy and eternal dwelling with Him",
      ["misericordia", "subsequor", "vita", "inhabito", "domus", "longitudo"],
      ThemeCategory.divine,
      1 ... 9
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm22.count, 9, "Psalm 22 should have 9 verses"
    )
    XCTAssertEqual(
      englishText.count, 9,
      "Psalm 22 English text should have 9 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm22.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm22,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm22,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm22_texts.json"
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
      filename: "output_psalm22_themes.json"
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
      psalmText: psalm22,
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
      psalmText: psalm22,
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
      psalmText: psalm22,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
