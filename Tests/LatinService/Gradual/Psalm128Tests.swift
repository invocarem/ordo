@testable import LatinService
import XCTest

class Psalm128Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 128, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 7
  private let text = [
    "Saepe expugnaverunt me a iuventute mea, dicat nunc Israel;",
    "saepe expugnaverunt me a iuventute mea, etenim non potuerunt mihi.",
    "Supra dorsum meum fabricaverunt peccatores; prolongaverunt iniquitatem suam.",
    "Dominus iustus concidit cervices peccatorum. confundantur et convertantur retrorsum omnes qui oderunt Sion.",
    "Fiant sicut foenum tectorum, quod priusquam evellatur exaruit,",
    "De quo non implevit manum suam qui metit, et sinum suum qui manipulos colligit.",
    "Et non dixerunt qui praeteribant: Benedictio Domini super vos; benediximus vobis in nomine Domini.",
  ]

  private let englishText = [
    "Often have they fought against me from my youth, let Israel now say.",
    "Often have they fought against me from my youth: yet they could not prevail over me.",
    "The wicked have wrought upon my back: they have lengthened their iniquity.",
    "The Lord who is just will cut the necks of sinners. Let them all be confounded and turned back that hate Sion.",
    "Let them be as grass upon the tops of houses, which withereth before it be plucked up:",
    "Wherewith the mower filleth not his hand: nor he that gathereth sheaves his bosom.",
    "Neither have they that passed by said: The blessing of the Lord be upon you: we have blessed you in the name of the Lord.",
  ]

  private let lineKeyLemmas = [
    (1, ["saepe", "expugno", "iuventus", "dico", "nunc", "israel"]),
    (2, ["saepe", "expugno", "iuventus", "etenim", "possum"]),
    (3, ["supra", "dorsum", "fabricor", "peccator", "prolongo", "iniquitas"]),
    (4, ["dominus", "iustus", "concido", "cervix", "peccator", "confundo", "converto", "retrorsum", "odi", "sion"]),
    (5, ["fio", "sicut", "foenum", "tectum", "priusquam", "evello", "exaresco"]),
    (6, ["impleo", "manus", "meto", "sinus", "manipulus", "colligo"]),
    (7, ["dico", "praetereo", "benedictio", "dominus", "super", "benedico", "nomen", "dominus"]),
  ]

  private let structuralThemes = [
    (
      "Persecution → Endurance",
      "Repeated attacks from youth are met with a declaration of Israel's endurance, as the enemies ultimately could not prevail",
      ["saepe", "expugno", "iuventus", "possum"],
      1,
      2,
      "Repeated attacks from youth are met with a declaration of Israel's endurance, as the enemies ultimately could not prevail",
      "The psalmist recounts being fought against since his youth, but declares that his persecutors were ultimately unable to overcome him or Israel. Augustine sees this as the Church's testimony of enduring persecution throughout history, yet remaining unconquered by the enemies of God (Enarr. Ps. 128.1-2)."
    ),
    (
      "Oppression → Judgment",
      "The prolonged iniquity of sinners who plotted on the psalmist's back is met with the Lord's just judgment, cutting them down and turning back the haters of Zion",
      ["dorsum", "fabricor", "peccator", "prolongo", "concido", "confundo", "converto", "odi"],
      3,
      4,
      "The prolonged iniquity of sinners who plotted on the psalmist's back is met with the Lord's just judgment, cutting them down and turning back the haters of Zion",
      "Sinners wove their plots upon the psalmist's back and prolonged their iniquity. The just Lord responds by cutting the necks of sinners, confounding them and turning back all who hate Zion. Augustine interprets the 'back' as Christ bearing the cross of human sin. God's justice ultimately cuts down the proud and reverses the schemes of those who oppose His holy city, the Church (Enarr. Ps. 128.3-4)."
    ),
    (
      "Insignificance → Absence of Blessing",
      "The haters of Zion become as insignificant as withered roof grass, which is not gathered by reapers and receives no blessing from passersby",
      ["fio", "foenum", "tectum", "evello", "exaresco", "impleo", "meto", "sinus", "manipulus", "colligo", "praetereo"],
      5,
      7,
      "The haters of Zion become as insignificant as withered roof grass, which is not gathered by reapers and receives no blessing from passersby",
      "The fate of God's enemies is to be like roof grass that withers before being plucked. It is so worthless that no reaper fills his hand with it or gathers it into his bosom. Those who pass by do not even bestow a blessing upon it in the Lord's name. Augustine sees this as the ultimate fruitlessness of evil: it produces nothing of value worthy of harvest or blessing. Those who oppose God become spiritually barren and are excluded from the community of blessing (Enarr. Ps. 128.5-7)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Persecution and Endurance",
      "The psalmist's experience of being attacked from youth and Israel's endurance",
      ["saepe", "expugno", "iuventus", "possum"],
      ThemeCategory.opposition,
      1 ... 2
    ),
    (
      "Divine Justice",
      "God's just judgment against sinners and those who oppose Zion",
      ["dominus", "iustus", "concido", "confundo", "converto", "odi"],
      ThemeCategory.divine,
      3 ... 4
    ),
    (
      "Agricultural Imagery",
      "Metaphors of grass, harvesting, and agricultural work",
      ["foenum", "tectum", "evello", "exaresco", "meto", "manipulus", "colligo"],
      ThemeCategory.virtue,
      5 ... 6
    ),
    (
      "Blessing and Community",
      "The importance of blessing and community recognition",
      ["benedictio", "benedico", "nomen", "dominus", "praetereo"],
      ThemeCategory.worship,
      6 ... 7
    ),
    (
      "Wickedness and Iniquity",
      "The actions and consequences of the wicked",
      ["peccator", "iniquitas", "fabricor", "prolongo", "dorsum"],
      ThemeCategory.sin,
      2 ... 3
    ),
    (
      "Zion and Holy City",
      "References to Zion as the holy city and center of blessing",
      ["sion", "israel", "benedictio", "dominus"],
      ThemeCategory.worship,
      1 ... 7
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 128 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 128 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm128_texts.json"
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
      filename: "output_psalm128_themes.json"
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
