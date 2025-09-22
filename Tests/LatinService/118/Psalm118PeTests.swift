@testable import LatinService
import XCTest

class Psalm118PeTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 118, category: "pe")

  // MARK: - Test Data Properties

  private let psalm118Pe = [
    "Mirabilia testimonia tua, ideo scrutata est ea anima mea.",
    "Declaratio sermonum tuorum illuminat, et intellectum dat parvulis.",
    "Os meum aperui et attraxi spiritum, quia mandata tua desiderabam.",
    "Aspice in me et miserere mei, secundum iudicium diligentium nomen tuum.",
    "Gressus meos dirige secundum eloquium tuum, et non dominetur mei omnis iniquitas.",
    "Redime me a calumniis hominum, ut custodiam mandata tua.",
    "Faciem tuam illumina super servum tuum, et doce me iustificationes tuas.",
    "Exitus aquae deduxerunt oculi mei, quia non custodierunt legem tuam.",
  ]

  private let englishText = [
    "Thy testimonies are wonderful, therefore my soul hath sought them.",
    "The declaration of thy words giveth light, and giveth understanding to little ones.",
    "I opened my mouth and panted, because I longed for thy commandments.",
    "Look thou upon me and have mercy on me, according to the judgment of them that love thy name.",
    "Direct my steps according to thy word, and let no iniquity have dominion over me.",
    "Redeem me from the calumnies of men, that I may keep thy commandments.",
    "Make thy face to shine upon thy servant, and teach me thy justifications.",
    "My eyes have sent forth streams of water, because they have not kept thy law.",
  ]

  private let lineKeyLemmas = [
    (1, ["mirabilis", "testimonium", "ideo", "scrutor", "anima"]),
    (2, ["declaratio", "sermo", "illumino", "intellectus", "do", "parvulus"]),
    (3, ["os", "aperio", "attraho", "spiritus", "quia", "mandatum", "desidero"]),
    (4, ["aspicio", "misereor", "secundum", "iudicium", "diligo", "nomen"]),
    (5, ["gressus", "dirigo", "secundum", "eloquium", "non", "dominor", "omnis", "iniquitas"]),
    (6, ["redimo", "calumnia", "homo", "ut", "custodio", "mandatum"]),
    (7, ["facies", "illumino", "super", "servus", "doceo", "iustificatio"]),
    (8, ["exitus", "aqua", "deduco", "oculus", "quia", "non", "custodio", "lex"]),
  ]

  private let structuralThemes = [
    (
      "Wonder → Search",
      "The psalmist's wonder at God's testimonies leading to his soul's search for them",
      ["mirabilis", "testimonium", "ideo", "scrutor", "anima", "declaratio", "sermo", "illumino", "intellectus", "parvulus"],
      1,
      2,
      "The psalmist declares God's testimonies wonderful, therefore his soul has sought them, and notes that the declaration of God's words gives light and understanding to little ones.",
      "Augustine sees this as the soul's recognition of divine truth's surpassing beauty. The 'mirabilia testimonia' reveals the psalmist's awe at God's revelation, while the 'scrutata est ea anima mea' shows the soul's active engagement with divine truth."
    ),
    (
      "Longing → Prayer",
      "The psalmist's physical and spiritual longing for God's commandments",
      ["os", "aperio", "attraho", "spiritus", "mandatum", "desidero", "aspicio", "misereor", "iudicium", "diligo", "nomen"],
      3,
      4,
      "The psalmist opens his mouth and pants because he longs for God's commandments, then asks God to look upon him and have mercy according to the judgment of those who love His name.",
      "For Augustine, this represents the soul's complete dependence on divine grace. The 'os meum aperui et attraxi spiritum' shows the intensity of spiritual hunger, while the request for mercy reveals the soul's recognition of its need for divine compassion."
    ),
    (
      "Guidance → Redemption",
      "The psalmist's request for divine guidance and redemption from evil",
      ["gressus", "dirigo", "eloquium", "iniquitas", "dominor", "redimo", "calumnia", "homo", "custodio", "mandatum"],
      5,
      6,
      "The psalmist asks God to direct his steps according to His word so that no iniquity may have dominion over him, then asks to be redeemed from the calumnies of men so he may keep God's commandments.",
      "Augustine interprets this as the soul's prayer for both protection and deliverance. The request for 'dirige secundum eloquium tuum' shows the psalmist's desire for divine guidance, while the plea for redemption reveals his understanding that keeping God's law requires divine intervention."
    ),
    (
      "Illumination → Sorrow",
      "The psalmist's request for divine illumination and his sorrow over lawlessness",
      ["facies", "illumino", "servus", "doceo", "iustificatio", "exitus", "aqua", "deduco", "oculus", "custodio", "lex"],
      7,
      8,
      "The psalmist asks God to make His face shine upon His servant and teach him His justifications, then notes that his eyes have sent forth streams of water because they have not kept God's law.",
      "For Augustine, this represents the soul's response to divine instruction and its grief over human disobedience. The request for illumination shows the psalmist's desire for divine understanding, while the tears reveal his profound sorrow over the world's rejection of divine law."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Revelation",
      "Focus on God's wondrous testimonies and illuminating word",
      ["mirabilis", "testimonium", "declaratio", "illumino", "intellectus", "eloquium"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Spiritual Longing",
      "Soul's yearning and desire for God's commandments",
      ["scrutor", "desidero", "anima", "spiritus", "diligo", "os", "aperio", "attraho"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Divine Guidance",
      "Requests for direction, mercy, and redemption",
      ["dirigo", "aspicio", "misereor", "redimo", "custodio", "facies", "illumino"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Protection from Evil",
      "Deliverance from iniquity and human calumny",
      ["iniquitas", "calumnia", "dominor", "homo", "exitus", "aqua", "deduco"],
      ThemeCategory.virtue,
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
      psalm118Pe.count, 8, "Psalm 118 Pe should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Pe English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Pe.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Pe,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Pe,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Pe_texts.json"
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
      filename: "output_psalm118Pe_themes.json"
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
      psalmText: psalm118Pe,
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
      psalmText: psalm118Pe,
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
      psalmText: psalm118Pe,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
