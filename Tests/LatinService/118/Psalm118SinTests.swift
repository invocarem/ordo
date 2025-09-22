@testable import LatinService
import XCTest

class Psalm118SinTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 118, category: "sin")

  // MARK: - Test Data Properties

  private let psalm118Sin = [
    "Principes persecuti sunt me gratis, et a verbis tuis formidavit cor meum.",
    "Laetabor ego super eloquia tua, sicut qui invenit spolia multa.",
    "Iniquitatem odio habui et abominatus sum, legem autem tuam dilexi.",
    "Septies in die laudem dixi tibi, super iudicia iustitiae tuae.",
    "Pax multa diligentibus legem tuam, et non est illis scandalum.",
    "Exspectabam salutare tuum, Domine, et mandata tua dilexi.",
    "Custodivit anima mea testimonia tua, et dilexit ea vehementer.",
    "Servavi mandata tua et testimonia tua, quia omnes viae meae in conspectu tuo.",
  ]

  private let englishText = [
    "Princes have persecuted me without cause: and my heart hath feared at thy words.",
    "I will rejoice at thy words: as one that hath found great spoil.",
    "I have hated and abhorred iniquity: but I have loved thy law.",
    "Seven times a day I have given praise to thee: for the judgments of thy justice.",
    "Much peace have they that love thy law: and to them there is no stumbling block.",
    "I looked for thy salvation, O Lord: and I loved thy commandments.",
    "My soul hath kept thy testimonies: and I have loved them exceedingly.",
    "I have kept thy commandments and thy testimonies: because all my ways are in thy sight.",
  ]

  private let lineKeyLemmas = [
    (1, ["princeps", "persequor", "gratis", "verbum", "formido", "cor"]),
    (2, ["laetor", "eloquium", "invenio", "spolium", "multus"]),
    (3, ["iniquitas", "odium", "habeo", "abominor", "lex", "diligo"]),
    (4, ["septies", "dies", "laus", "dico", "iudicium", "iustitia"]),
    (5, ["pax", "multus", "diligo", "lex", "scandalum"]),
    (6, ["exspecto", "salus", "dominus", "mandatum", "diligo"]),
    (7, ["custodio", "anima", "testimonium", "diligo", "vehementer"]),
    (8, ["servo", "mandatum", "testimonium", "omnis", "via", "conspectus"]),
  ]

  private let structuralThemes = [
    (
      "Persecution → Joy",
      "The psalmist's experience of persecution contrasted with his joy in God's words",
      ["princeps", "persequor", "gratis", "verbum", "formido", "cor", "laetor", "eloquium", "invenio", "spolium"],
      1,
      2,
      "Princes have persecuted the psalmist without cause, causing his heart to fear at God's words, yet he will rejoice at God's words as one who has found great spoil.",
      "Augustine sees this as the soul's response to worldly opposition. The persecution 'gratis' shows the injustice of the world, while the joy in God's words reveals the soul's recognition that divine truth is the true treasure."
    ),
    (
      "Hatred → Love",
      "The psalmist's hatred of iniquity contrasted with his love for God's law",
      ["iniquitas", "odium", "abominor", "lex", "diligo", "septies", "dies", "laus", "iudicium", "iustitia"],
      3,
      4,
      "The psalmist has hated and abhorred iniquity but loved God's law, and seven times a day he gives praise to God for the judgments of His justice.",
      "For Augustine, this represents the soul's moral clarity. The hatred of iniquity shows the psalmist's spiritual discernment, while the sevenfold daily praise reveals his constant devotion to divine justice."
    ),
    (
      "Peace → Salvation",
      "The peace of those who love God's law and the psalmist's expectation of salvation",
      ["pax", "diligo", "lex", "scandalum", "exspecto", "salus", "dominus", "mandatum"],
      5,
      6,
      "Much peace belongs to those who love God's law with no stumbling block, and the psalmist looks for God's salvation and loves His commandments.",
      "Augustine interprets this as the soul's recognition of divine order. The peace of law-lovers shows the harmony of divine will, while the expectation of salvation reveals the psalmist's faith in God's ultimate deliverance."
    ),
    (
      "Keeping → Sight",
      "The psalmist's keeping of God's testimonies and his awareness of divine oversight",
      ["custodio", "anima", "testimonium", "diligo", "vehementer", "servo", "mandatum", "omnis", "via", "conspectus"],
      7,
      8,
      "The psalmist's soul has kept God's testimonies and loved them exceedingly, and he has kept God's commandments and testimonies because all his ways are in God's sight.",
      "For Augustine, this represents the soul's consciousness of divine presence. The keeping of testimonies shows the psalmist's faithfulness, while the awareness of divine sight reveals his understanding that all actions are known to God."
    ),
  ]

  private let conceptualThemes = [
    (
      "Persecution and Opposition",
      "The psalmist's experience of unjust persecution and worldly opposition",
      ["princeps", "persequor", "gratis", "formido", "scandalum"],
      ThemeCategory.conflict,
      1 ... 8
    ),
    (
      "Divine Word and Law",
      "God's words, law, commandments, and testimonies as sources of joy and guidance",
      ["verbum", "eloquium", "lex", "mandatum", "testimonium", "iudicium", "iustitia"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Love and Devotion",
      "The psalmist's love for God's law and his devoted response",
      ["diligo", "laetor", "laus", "dico", "custodio", "servo"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Peace and Salvation",
      "The peace of law-lovers and the expectation of divine salvation",
      ["pax", "salus", "exspecto", "anima", "vehementer"],
      ThemeCategory.divine,
      1 ... 8
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm118Sin.count, 8, "Psalm 118 Sin should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Sin English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Sin.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Sin,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Sin,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Sin_texts.json"
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
      filename: "output_psalm118Sin_themes.json"
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
      psalmText: psalm118Sin,
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
      psalmText: psalm118Sin,
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
      psalmText: psalm118Sin,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
