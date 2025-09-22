@testable import LatinService
import XCTest

class Psalm118TauTests: XCTestCase {
  private var latinService: LatinService!
  private let verbose = true
  let id = PsalmIdentity(number: 118, category: "tau")

  // MARK: - Test Data Properties

  private let psalm118Tau = [
    "Appropinquet deprecatio mea in conspectu tuo, Domine; iuxta eloquium tuum da mihi intellectum.",
    "Intret postulatio mea in conspectu tuo; secundum eloquium tuum eripe me.",
    "Eructabunt labia mea hymnum, cum docueris me iustificationes tuas.",
    "Pronuntiabit lingua mea eloquium tuum, quia omnia mandata tua aequitas.",
    "Fiat manus tua ut salvet me, quoniam mandata tua elegi.",
    "Concupivi salutare tuum, Domine, et lex tua meditatio mea est.",
    "Vivet anima mea, et laudabit te, et iudicia tua adiuvabunt me.",
    "Erravi sicut ovis quae periit; quaere servum tuum, quia mandata tua non sum oblitus.",
  ]

  private let englishText = [
    "Let my supplication come near in thy sight, O Lord: give me understanding according to thy word.",
    "Let my request come in before thee: deliver me according to thy word.",
    "My lips shall utter a hymn: when thou hast taught me thy justifications.",
    "My tongue shall pronounce thy word: because all thy commandments are justice.",
    "Let thy hand be to save me: for I have chosen thy commandments.",
    "I have longed for thy salvation, O Lord: and thy law is my meditation.",
    "My soul shall live, and shall praise thee: and thy judgments shall help me.",
    "I have gone astray like a sheep that is lost: seek thy servant, because I have not forgotten thy commandments.",
  ]

  private let lineKeyLemmas = [
    (1, ["appropinquo", "deprecatio", "conspectus", "dominus", "iuxta", "eloquium", "do", "intellectus"]),
    (2, ["intro", "postulatio", "conspectus", "secundum", "eloquium", "eripio"]),
    (3, ["eructo", "labium", "hymnus", "doceo", "iustificatio"]),
    (4, ["pronuntio", "lingua", "eloquium", "omnis", "mandatum", "aequitas"]),
    (5, ["fio", "manus", "salvo", "quoniam", "mandatum", "eligo"]),
    (6, ["concupio", "salutare", "dominus", "lex", "meditatio"]),
    (7, ["vivo", "anima", "laudo", "iudicium", "adiuvo"]),
    (8, ["erro", "sicut", "ovis", "pereo", "quaero", "servus", "mandatum", "obliviscor"]),
  ]

  private let structuralThemes = [
    (
      "Supplication → Understanding",
      "The psalmist's prayer for his supplication to be heard and for understanding according to God's word",
      ["appropinquo", "deprecatio", "dominus", "eloquium", "intellectus"],
      1,
      2,
      "The psalmist asks that his prayer come before the Lord and for understanding according to His word, seeking deliverance through divine promise.",
      "Augustine sees this as the soul's final approach to God, where prayer and understanding converge. The 'juxta eloquium tuum' emphasizes that true understanding comes only through God's revealed word."
    ),
    (
      "Praise → Instruction",
      "The response of praise following divine instruction in God's justifications",
      ["eructo", "labium", "hymnus", "doceo", "iustificatio", "pronuntio"],
      3,
      4,
      "The psalmist's lips will utter praise when taught God's justifications, and his tongue will declare God's word because all commandments are righteous.",
      "For Augustine, this represents the proper human response to divine teaching. Praise flows naturally from a heart instructed in God's ways, and the declaration of God's word testifies to its inherent justice."
    ),
    (
      "Salvation → Choice",
      "The connection between God's saving hand and the psalmist's deliberate choice of His commandments",
      ["manus", "salvo", "mandatum", "eligo", "salutare", "concupio"],
      5,
      6,
      "The psalmist asks for God's hand to save him because he has chosen God's commandments, and expresses longing for God's salvation with the law as his meditation.",
      "Augustine interprets this as the soul's recognition that salvation comes through God's power, not human merit. The choice of commandments reflects a will aligned with God's, and the longing for salvation shows proper spiritual desire."
    ),
    (
      "Life → Restoration",
      "The theme of spiritual life, praise, and restoration after going astray",
      ["vivo", "anima", "laudo", "iudicium", "adiuvo", "erro", "quaero", "servus"],
      7,
      8,
      "The psalmist's soul will live and praise God, helped by His judgments, acknowledging having strayed like a lost sheep but asking to be sought as a servant who hasn't forgotten God's commandments.",
      "For Augustine, this final section represents the Christian's hope: though we wander, God seeks us. The living soul praises God not by its own power but through divine help, completing the psalm's journey from law to grace."
    ),
  ]

  private let conceptualThemes = [
    (
      "Prayer and Supplication",
      "Themes of approaching God with requests and prayers",
      ["deprecatio", "postulatio", "appropinquo", "intro", "conspectus"],
      ThemeCategory.worship,
      1 ... 8
    ),
    (
      "Divine Word",
      "Emphasis on God's word, commandments, and judgments",
      ["eloquium", "mandatum", "iustificatio", "iudicium", "lex"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Salvation and Deliverance",
      "Themes of God's saving action and the soul's longing for salvation",
      ["salvo", "eripio", "salutare", "concupio", "manus"],
      ThemeCategory.justice,
      1 ... 8
    ),
    (
      "Praise and Testimony",
      "The response of praise, declaration, and meditation on God's law",
      ["hymnus", "pronuntio", "laudo", "meditatio", "eructo"],
      ThemeCategory.worship,
      1 ... 8
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm118Tau.count, 8, "Psalm 118 Tau should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Tau English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Tau.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Tau,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Tau,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Tau_texts.json"
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
      filename: "output_psalm118Tau_themes.json"
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
      psalmText: psalm118Tau,
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
      psalmText: psalm118Tau,
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
      psalmText: psalm118Tau,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
