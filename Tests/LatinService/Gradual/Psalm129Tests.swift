@testable import LatinService
import XCTest

class Psalm129Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 129, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 8
  private let text = [
    "De profundis clamavi ad te, Domine;",
    "Domine, exaudi vocem meam. Fiant aures tuae intendentes in vocem deprecationis meae.",
    "Si iniquitates observaveris, Domine, Domine, quis sustinebit?",
    "Quia apud te propitiatio est, et propter legem tuam sustinui te, Domine.",
    "Sustinuit anima mea in verbo eius; speravit anima mea in Domino.",
    "A custodia matutina usque ad noctem, speret Israel in Domino.",
    "Quia apud Dominum misericordia, et copiosa apud eum redemptio.",
    "Et ipse redimet Israel ex omnibus iniquitatibus eius.",
  ]

  private let englishText = [
    "Out of the depths I have cried to thee, O Lord;",
    "Lord, hear my voice. Let thine ears be attentive to the voice of my supplication.",
    "If thou, O Lord, wilt mark iniquities: Lord, who shall stand it?",
    "For with thee there is merciful forgiveness: and by reason of thy law, I have waited for thee, O Lord.",
    "My soul hath relied on his word: my soul hath hoped in the Lord.",
    "From the morning watch even until night: let Israel hope in the Lord.",
    "Because with the Lord there is mercy: and with him plentiful redemption.",
    "And he shall redeem Israel from all his iniquities.",
  ]

  private let lineKeyLemmas = [
    (1, ["profundum", "clamo", "dominus"]),
    (2, ["exaudio", "vox", "auris", "deprecatio"]),
    (3, ["iniquitas", "observo", "sustineo", "quis"]),
    (4, ["propitiatio", "sustineo", "lex", "dominus"]),
    (5, ["sustineo", "anima", "verbum", "spero", "dominus"]),
    (6, ["custodia", "matutinus", "nox", "spero", "israel", "dominus"]),
    (7, ["misericordia", "redemptio", "copiosus", "dominus"]),
    (8, ["redimo", "israel", "iniquitas"]),
  ]

  private let structuralThemes = [
    (
      "Cry from the Depths",
      "The psalmist begins with a desperate plea from the lowest place of need",
      ["profundum", "clamo", "dominus"],
      1,
      1,
      "The psalmist begins with a desperate plea from the lowest place of need",
      "A prayer launched from the symbolic depths of suffering or sin."
    ),
    (
      "Prayerful Appeal",
      "A heartfelt call for God to hear and attend to the supplicant's voice",
      ["exaudio", "vox", "auris", "deprecatio"],
      2,
      2,
      "A heartfelt call for God to hear and attend to the supplicant's voice",
      "Layered plea for divine attentiveness and mercy."
    ),
    (
      "Recognition of Guilt",
      "Acknowledgment of human iniquity and unworthiness before divine justice",
      ["iniquitas", "observo", "sustineo"],
      3,
      3,
      "Acknowledgment of human iniquity and unworthiness before divine justice",
      "No one can stand before God if sins are accounted."
    ),
    (
      "Hope in Mercy and Word",
      "Despite guilt, the psalmist waits for God's mercy and trusts in His word",
      ["propitiatio", "sustineo", "verbum", "spero", "anima"],
      4,
      5,
      "Despite guilt, the psalmist waits for God's mercy and trusts in His word",
      "Patience, waiting, and reliance on the Lord's promise."
    ),
    (
      "Communal Invitation to Hope",
      "The entire people of Israel are called to wait in faith for the Lord",
      ["custodia", "matutinus", "nox", "spero", "israel"],
      6,
      6,
      "The entire people of Israel are called to wait in faith for the Lord",
      "Israel is summoned to collective, persistent hope."
    ),
    (
      "Abundant Redemption",
      "God is portrayed as rich in mercy and redemption",
      ["misericordia", "redemptio", "copiosus"],
      7,
      7,
      "God is portrayed as rich in mercy and redemption",
      "Confidence in divine fullness and capacity to forgive."
    ),
    (
      "Promise of Deliverance",
      "God Himself will redeem Israel from all sin",
      ["redimo"],
      8,
      8,
      "God Himself will redeem Israel from all sin",
      "Final assurance of total salvation through the Lord."
    ),
  ]

  private let conceptualThemes = [
    (
      "Cry from the Depths",
      "The psalmist's desperate plea from the depths of suffering",
      ["profundum", "clamo", "dominus"],
      ThemeCategory.opposition,
      1 ... 1
    ),
    (
      "Divine Hearing and Mercy",
      "God's attentiveness to prayer and supplication",
      ["exaudio", "auris", "deprecatio", "propitiatio"],
      ThemeCategory.divine,
      2 ... 4
    ),
    (
      "Sin and Iniquity",
      "Recognition of human sinfulness and need for forgiveness",
      ["iniquitas", "observo", "sustineo"],
      ThemeCategory.sin,
      3 ... 3
    ),
    (
      "Hope and Waiting",
      "Patient waiting and hope in God's promises",
      ["spero", "sustineo", "custodia", "matutinus", "nox"],
      ThemeCategory.virtue,
      4 ... 6
    ),
    (
      "Redemption and Salvation",
      "God's abundant mercy and power to redeem",
      ["redemptio", "misericordia", "copiosus", "redimo"],
      ThemeCategory.divine,
      6 ... 8
    ),
    (
      "Israel and Community",
      "The communal aspect of hope and redemption",
      ["israel", "anima", "verbum"],
      ThemeCategory.worship,
      5 ... 8
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 129 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 129 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm129_texts.json"
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
      filename: "output_psalm129_themes.json"
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
