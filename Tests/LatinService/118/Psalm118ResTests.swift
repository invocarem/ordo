@testable import LatinService
import XCTest

class Psalm118ResTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 118, category: "res")

  // MARK: - Test Data Properties

  private let psalm118Resh = [
    "Vide humilitatem meam, et eripe me, quia legem tuam non sum oblitus.",
    "Iudica iudicium meum, et redime me, propter eloquium tuum vivifica me.",
    "Longe a peccatoribus salus, quia iustificationes tuas non exquisierunt.",
    "Misericordiae tuae multae, Domine, secundum iudicium tuum vivifica me.",
    "Multi qui persequuntur me, et tribulant me; a testimoniis tuis non declinavi.",
    "Vidi praevaricantes, et tabescebam, quia eloquia tua non custodierunt.",
    "Vide quoniam mandata tua dilexi, Domine, in misericordia tua vivifica me.",
    "Principium verborum tuorum veritas, in aeternum omnia iudicia iustitiae tuae.",
  ]

  private let englishText = [
    "See my humiliation, and deliver me: for I have not forgotten thy law.",
    "Judge my judgment, and redeem me: quicken me for thy word's sake.",
    "Salvation is far from sinners: because they have not sought thy justifications.",
    "Many are thy mercies, O Lord: quicken me according to thy judgment.",
    "Many are they that persecute me, and afflict me: but I have not declined from thy testimonies.",
    "I beheld the transgressors, and I pined away: because they kept not thy words.",
    "Behold that I have loved thy commandments, O Lord: in thy mercy quicken me.",
    "The beginning of thy words is truth: all the judgments of thy justice are for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["video", "humilitas", "eripio", "lex", "obliviscor"]),
    (2, ["iudico", "redimo", "eloquium", "vivifico"]),
    (3, ["longe", "peccator", "salus", "iustificatio", "exquiro"]),
    (4, ["misericordia", "multus", "dominus", "iudicium", "vivifico"]),
    (5, ["multus", "persequor", "tribulo", "testimonium", "declino"]),
    (6, ["video", "praevaricator", "tabesco", "eloquium", "custodio"]),
    (7, ["video", "mandatum", "diligo", "dominus", "misericordia", "vivifico"]),
    (8, ["principium", "verbum", "veritas", "aeternum", "iudicium", "iustitia"]),
  ]

  private let structuralThemes = [
    (
      "Humiliation → Deliverance",
      "The psalmist's plea for God to see his humiliation and deliver him",
      ["video", "humilitas", "eripio", "lex", "obliviscor", "iudico", "redimo", "eloquium", "vivifico"],
      1,
      2,
      "The psalmist asks God to see his humiliation and deliver him because he has not forgotten God's law, and to judge his judgment and redeem him, quickening him for God's word's sake.",
      "Augustine sees this as the soul's recognition of its need for divine intervention. The 'humilitatem meam' shows the psalmist's awareness of his lowly state, while the request for deliverance reveals his faith in God's power to rescue."
    ),
    (
      "Distance → Mercy",
      "The distance of sinners from salvation contrasted with God's abundant mercy",
      ["longe", "peccator", "salus", "iustificatio", "exquiro", "misericordia", "multus", "iudicium"],
      3,
      4,
      "Salvation is far from sinners because they have not sought God's justifications, but God's mercies are many, and the psalmist asks to be quickened according to God's judgment.",
      "For Augustine, this represents the soul's understanding of divine justice and mercy. The distance of sinners shows the consequence of rejecting divine law, while God's abundant mercy reveals His readiness to restore those who seek Him."
    ),
    (
      "Persecution → Faithfulness",
      "The psalmist's experience of persecution contrasted with his faithfulness to God's testimonies",
      ["multus", "persequor", "tribulo", "testimonium", "declino", "video", "praevaricator", "tabesco", "eloquium", "custodio"],
      5,
      6,
      "Many persecute and afflict the psalmist, but he has not declined from God's testimonies, and he has seen transgressors and pined away because they kept not God's words.",
      "Augustine interprets this as the soul's steadfastness in trial. The persecution shows the world's opposition to divine truth, while the psalmist's faithfulness reveals his commitment to God's testimonies despite suffering."
    ),
    (
      "Love → Truth",
      "The psalmist's love for God's commandments and the truth of God's words",
      ["video", "mandatum", "diligo", "misericordia", "vivifico", "principium", "verbum", "veritas", "aeternum", "iudicium", "iustitia"],
      7,
      8,
      "The psalmist asks God to see that he has loved God's commandments and to quicken him in God's mercy, declaring that the beginning of God's words is truth and all judgments of His justice are forever.",
      "For Augustine, this represents the soul's recognition of divine truth. The love for commandments shows the psalmist's devotion to divine will, while the declaration of eternal truth reveals his faith in the permanence of God's justice."
    ),
  ]

  private let conceptualThemes = [
    (
      "Petition and Deliverance",
      "The psalmist's requests for divine intervention and deliverance",
      ["video", "eripio", "iudico", "redimo", "vivifico"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Divine Justice and Mercy",
      "God's judgment, mercy, and the contrast with sinners",
      ["iudicium", "misericordia", "peccator", "salus", "iustificatio", "veritas"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Persecution and Faithfulness",
      "The psalmist's experience of persecution and his steadfastness",
      ["persequor", "tribulo", "testimonium", "declino", "praevaricator", "tabesco"],
      ThemeCategory.conflict,
      1 ... 8
    ),
    (
      "Divine Word and Law",
      "God's words, commandments, and testimonies as sources of truth",
      ["lex", "eloquium", "mandatum", "testimonium", "verbum", "custodio"],
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
      psalm118Resh.count, 8, "Psalm 118 Res should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Res English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Resh.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Resh,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Resh,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Res_texts.json"
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
      filename: "output_psalm118Res_themes.json"
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
      psalmText: psalm118Resh,
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
      psalmText: psalm118Resh,
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
      psalmText: psalm118Resh,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
