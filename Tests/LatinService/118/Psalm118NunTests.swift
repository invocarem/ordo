@testable import LatinService
import XCTest

class Psalm118NunTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  private let minimumLemmasPerTheme = 3
  let id = PsalmIdentity(number: 118, category: "nun")

  // MARK: - Test Data Properties

  private let psalm118Nun = [
    "Lucerna pedibus meis verbum tuum, et lumen semitis meis.",
    "Iuravi et statui custodire iudicia iustitiae tuae.",
    "Humiliatus sum usquequaque, Domine; vivifica me secundum verbum tuum.",
    "Voluntaria oris mei beneplacita fac, Domine, et iudicia tua doce me.",
    "Anima mea in manibus tuis semper, et legem tuam non sum oblitus.",
    "Posuerunt peccatores laqueum mihi, et de mandatis tuis non erravi.",
    "Hereditate acquisivi testimonia tua in aeternum, quia exsultatio cordis mei sunt.",
    "Inclinavi cor meum ad faciendas iustificationes tuas in aeternum, propter retributionem.",
  ]

  private let englishText = [
    "Thy word is a lamp to my feet, and a light to my paths.",
    "I have sworn and am determined to keep the judgments of thy justice.",
    "I am humbled, O Lord, exceedingly: quicken me according to thy word.",
    "Make the way of thy commandments agreeable to me, O Lord, and teach me thy judgments.",
    "My soul is always in my hands, and I have not forgotten thy law.",
    "The wicked have laid a snare for me, but I have not strayed from thy commandments.",
    "I have purchased thy testimonies for an inheritance for ever, because they are the joy of my heart.",
    "I have inclined my heart to do thy justifications for ever, for the reward.",
  ]

  private let lineKeyLemmas = [
    (1, ["lucerna", "pes", "verbum", "lumen", "semita"]),
    (2, ["iuro", "statuo", "custodio", "iudicium", "iustitia"]),
    (3, ["humilio", "usquequaque", "dominus", "vivifico", "secundum", "verbum"]),
    (4, ["voluntarius", "os", "beneplacitum", "facio", "dominus", "iudicium", "doceo"]),
    (5, ["anima", "manus", "semper", "lex", "obliviscor"]),
    (6, ["pono", "peccator", "laqueus", "mandatum", "erro"]),
    (7, ["hereditas", "acquiro", "testimonium", "aeternum", "exsultatio", "cor"]),
    (8, ["inclino", "cor", "facio", "iustificatio", "aeternum", "retributio"]),
  ]

  private let structuralThemes = [
    (
      "Guidance → Commitment",
      "God's word as lamp and light, teaching and direction leading to commitment",
      ["lucerna", "lumen", "semita", "pes",  "custodio", "iuro", "statuo"],
      1,
      2,
      "The psalmist begins by acknowledging God's word as a lamp and light for guidance, then commits to keeping His judgments through oath and determination.",
      "Augustine sees this as the soul's recognition of divine illumination. The 'lucerna' and 'lumen' represent the grace of understanding, while the oath represents the soul's response to this divine light."
    ),
    (
      "Humility → Dependence",
      "The psalmist's humility and dependence on God's word for life and teaching",
      ["humilio", "dominus", "vivifico", "verbum", "voluntarius", "beneplacitum", "doceo"],
      3,
      4,
      "The psalmist acknowledges his profound humility and asks God to quicken him according to His word, offering voluntary praise and seeking instruction in His judgments.",
      "For Augustine, this represents the soul's complete dependence on grace. The 'humiliatus sum usquequaque' shows the depth of human need, while the request for 'vivifica me' reveals the soul's recognition that life comes only from God."
    ),
    (
      "Preservation → Steadfastness",
      "The soul's preservation in God's hands and steadfastness against temptation",
      ["anima", "manus", "semper", "lex", "obliviscor", "pono", "peccator", "laqueus", "mandatum", "erro"],
      5,
      6,
      "The psalmist's soul is always in God's hands, never forgetting His law, while the wicked lay snares but he does not stray from God's commandments.",
      "Augustine interprets this as the soul's security in divine providence. The 'anima mea in manibus tuis' expresses complete trust, while the contrast with the wicked's snares shows the protection that comes from keeping God's law."
    ),
    (
      "Inheritance → Eternal Reward",
      "The eternal inheritance of God's testimonies and the reward of keeping His justifications",
      ["hereditas", "acquiro", "testimonium", "aeternum", "exsultatio", "cor", "inclino", "iustificatio", "retributio"],
      7,
      8,
      "The psalmist has acquired God's testimonies as an eternal inheritance, finding joy in them, and has inclined his heart to do God's justifications forever for the reward.",
      "For Augustine, this represents the soul's participation in eternal life. The 'hereditas' is not earthly but spiritual, and the 'inclinavi cor meum' shows the soul's deliberate choice to align with divine will for eternal reward."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Guidance",
      "Focus on God's word as lamp, light, and teaching",
      ["lucerna", "lumen", "semita", "doceo", "verbum", "custodio"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Commitment and Oaths",
      "Emphasis on swearing, establishing, and keeping commitments",
      ["iuro", "statuo", "custodio", "inclino", "facio", "usquequaque"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Humility and Dependence",
      "Themes of humility, voluntary offerings, and dependence on God",
      ["humilio", "voluntarius", "beneplacitum", "vivifico", "anima", "manus"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Eternal Inheritance",
      "References to eternal testimonies, inheritance, and reward",
      ["aeternum", "hereditas", "testimonium", "retributio", "acquiro", "exsultatio"],
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
      psalm118Nun.count, 8, "Psalm 118 Nun should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Nun English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Nun.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Nun,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Nun,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Nun_texts.json"
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
      filename: "output_psalm118Nun_themes.json"
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
      psalmText: psalm118Nun,
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
      psalmText: psalm118Nun,
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
      psalmText: psalm118Nun,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
