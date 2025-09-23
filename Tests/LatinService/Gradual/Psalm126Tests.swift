@testable import LatinService
import XCTest

class Psalm126Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 126, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 6
  private let text = [
    "Nisi Dominus aedificaverit domum: in vanum laboraverunt qui aedificant eam.",
    "Nisi Dominus custodierit civitatem: frustra vigilat qui custodit eam.",
    "Vanum est vobis ante lucem surgere: surgite postquam sederitis, qui manducatis panem doloris.",
    "Cum dederit dilectis suis somnum: ecce haereditas Domini, filii; merces, fructus ventris.",
    "Sicut sagittae in manu potentis: ita filii excussorum.",
    "Beatus vir qui implevit desiderium suum ex ipsis: non confundetur cum loquetur inimicis suis in porta.",
  ]

  private let englishText = [
    "Unless the Lord build the house: they labour in vain that build it.",
    "Unless the Lord keep the city: he watcheth in vain that keepeth it.",
    "It is vain for you to rise before light: rise ye after you have sitten, you that eat the bread of sorrow.",
    "When he shall give sleep to his beloved: behold the inheritance of the Lord, children; the reward, the fruit of the womb.",
    "As arrows in the hand of the mighty: so the children of them that have been shaken.",
    "Blessed is the man that hath filled his desire with them: he shall not be confounded when he shall speak to his enemies in the gate.",
  ]

  private let lineKeyLemmas = [
    (1, ["nisi", "dominus", "aedifico", "domus", "vanus", "laboro"]),
    (2, ["nisi", "dominus", "custodio", "civitas", "frustra", "vigilo"]),
    (3, ["vanus", "lux", "surgo", "sedeo", "manduco", "panis", "dolor"]),
    (4, ["do", "dilectus", "somnus", "haereditas", "dominus", "filius", "merces", "fructus", "venter"]),
    (5, ["sagitta", "manus", "potens", "filius", "excutio"]),
    (6, ["beatus", "vir", "impleo", "desiderium", "confundo", "loquor", "inimicus", "porta"]),
  ]

  private let structuralThemes = [
    (
      "Third Captivity → Divine Building",
      "Labor without the Lord leads nowhere; true construction comes only from His participation",
      ["nisi", "aedifico", "custodio", "vanus", "laboro"],
      1,
      2,
      "Labor without the Lord leads nowhere; true construction comes only from His participation",
      "Augustine says this is about the soul's construction. We are temples — but not builders. The inner Jerusalem must be built by God, or it collapses. Watchmen and workers without grace only labor in anxiety (Enarr. Ps. 126.1–2)."
    ),
    (
      "Anxious Toil → Beloved Rest",
      "From self-reliant striving and sorrowful labor to the peaceful sleep granted by God to His beloved",
      ["surgo", "sedeo", "manduco", "dolor", "dilectus", "somnus"],
      3,
      4,
      "From self-reliant striving and sorrowful labor to the peaceful sleep granted by God to His beloved",
      "Augustine sees the 'bread of sorrow' as the symbol of unrestful self-effort, a labor born of anxiety. But God gives not wages but sleep — a sign of grace and belovedness. The soul is not built by fear but by trust (Enarr. Ps. 126.3–4)."
    ),
    (
      "Hidden Formation → Public Strength (Faith)",
      "Sons (spiritual or familial) are like arrows — hidden but honed. When the moment of testing comes, the one who has formed them will stand unashamed",
      ["sagitta", "manus", "potens", "filius", "excutio", "beatus", "impleo", "confundo", "inimicus", "porta"],
      5,
      6,
      "Sons (spiritual or familial) are like arrows — hidden but honed. When the moment of testing comes, the one who has formed them will stand unashamed",
      "Augustine reads the arrows as the sons of faith — formed in silence but destined for witness. The blessed man will not be confounded in the gate (symbol of judgment), because he has cultivated spiritual strength (Enarr. Ps. 126.5–6)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Providence",
      "God's essential role in all human endeavors",
      ["nisi", "dominus", "aedifico", "custodio"],
      ThemeCategory.divine,
      1 ... 2
    ),
    (
      "Vain Labor",
      "Human effort without divine participation",
      ["vanus", "laboro", "frustra", "vigilo"],
      ThemeCategory.sin,
      1 ... 3
    ),
    (
      "Rest and Sleep",
      "Divine gift of rest to the beloved",
      ["dilectus", "somnus", "haereditas", "merces"],
      ThemeCategory.divine,
      3 ... 4
    ),
    (
      "Family and Children",
      "Blessings of children and family life",
      ["filius", "venter", "fructus", "desiderium"],
      ThemeCategory.virtue,
      4 ... 6
    ),
    (
      "Military Imagery",
      "Arrows and warfare metaphors for spiritual strength",
      ["sagitta", "manus", "potens", "excutio", "inimicus", "porta"],
      ThemeCategory.virtue,
      5 ... 6
    ),
    (
      "Blessedness and Fulfillment",
      "The blessed state of those who trust in God",
      ["beatus", "impleo", "confundo", "loquor"],
      ThemeCategory.virtue,
      6 ... 6
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 126 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 126 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm126_texts.json"
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
      filename: "output_psalm126_themes.json"
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
