@testable import LatinService
import XCTest

class Psalm57Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 57, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 11
  private let text = [
    "Si vere utique iustitiam loquimini, recta iudicate, filii hominum.",
    "Etenim in corde iniquitates operamini; in terra iniustitias manus vestrae concinnant.",
    "Alienati sunt peccatores a vulva, erraverunt ab utero; locuti sunt falsa.",
    "Furor illis secundum similitudinem serpentis; sicut aspidis surdae, et obturantis aures suas,",
    "Quae non exaudiet vocem incantantium, et venefici incantantis sapienter.",

    "Deus conteret dentes eorum in ore ipsorum; molas leonum confringet Dominus.",
    "Ad nihilum devenient tamquam aqua decurrens; intendit arcum suum donec infirmentur.",
    "Sicut cera quae fluit, auferentur; supercecidit ignis, et non viderunt solem.",
    "Priusquam intelligerent spinae vestrae rhamnum: sicut viventes, sic in ira absorbet eos.",
    "Laetabitur iustus cum viderit vindictam; manus suas lavabit in sanguine peccatoris.",
    
    "Et dicet homo: Si utique est fructus iusto; utique est Deus iudicans eos in terra."
  ]

  private let englishText = [
    "If in very deed you speak justice: judge right things, ye sons of men.",
    "For in your heart you work iniquity: your hands forge injustice in the earth.",
    "The wicked are alienated from the womb; they have gone astray from the womb: they have spoken false things.",
    "Their madness is according to the likeness of a serpent: like the deaf asp that stoppeth her ears;",
    "Which will not hear the voice of the charmers; nor of the wizard that charmeth wisely.",
    "God shall break in pieces their teeth in their mouth: the Lord shall break the grinders of the lions.",
    "They shall come to nothing, like water running down; he hath bent his bow till they be weakened.",
    "Like wax that melteth they shall be taken away: fire hath fallen on them, and they shall not see the sun.",
    "Before your thorns could know the brier; he swalloweth them up, as alive, in his wrath.",
    "The just shall rejoice when he shall see the revenge: he shall wash his hands in the blood of the sinner.",
    "And man shall say: If indeed there be fruit to the just: there is indeed a God that judgeth them on the earth."
  ]

  private let lineKeyLemmas = [
    (1, ["verus", "iustitia", "loquor", "rectus", "iudico", "filius", "homo"]),
    (2, ["cor", "iniquitas", "operor", "terra", "iniustitia", "manus", "concinno"]),
    (3, ["alieno", "peccator", "vulva", "erro", "uterus", "loquor", "falsus"]),
    (4, ["furor", "similitudo", "serpens", "aspis", "surdus", "obturo", "auris"]),
    (5, ["exaudio", "vox", "incanto", "veneficus", "sapienter"]),
    (6, ["deus", "contero", "dens", "os", "mola", "leo", "confringo", "dominus"]),
    (7, ["nihilum", "devenio", "aqua", "decurro", "intendo", "arcus", "infirmo"]),
    (8, ["cera", "fluo", "aufero", "supercado", "ignis", "video", "sol"]),
    (9, ["priusquam", "intelligo", "spina", "rhamnus", "vivo", "ira", "absorbeo"]),
    (10, ["laetor", "iustus", "video", "vindicta", "manus", "lavo", "sanguis", "peccator"]),
    (11, ["dico", "homo", "fructus", "iustus", "deus", "iudico", "terra"]),
  ]

  private let structuralThemes = [
    (
      "Call to Justice → Heart's Iniquity",
      "The psalmist challenges the sons of men to judge rightly while exposing their inner corruption",
      ["iustitia", "iudico", "cor", "iniquitas", "iniustitia"],
      1,
      2,
      "The psalmist begins by calling for true justice and righteous judgment, then immediately exposes the hypocrisy of those who work iniquity in their hearts while their hands commit injustice.",
      "Augustine sees this as exposing the disconnect between outward speech and inner reality. True justice requires alignment between words, thoughts, and actions, which only divine grace can accomplish."
    ),
    (
      "Wicked from Birth → Deaf to Wisdom",
      "The wicked's alienation from birth and their refusal to hear divine wisdom",
      ["alieno", "peccator", "vulva", "falsus", "surdus", "obturo", "exaudio"],
      3,
      5,
      "The psalmist describes how sinners are alienated from the womb, speaking falsehoods, and compares them to deaf serpents that refuse to hear the voice of wisdom.",
      "For Augustine, this represents the depth of human sinfulness that exists from conception and the willful deafness to God's truth that characterizes the unrepentant."
    ),
    (
      "Divine Judgment → Destruction of Power",
      "God's judgment breaking the weapons and strength of the wicked",
      ["deus", "contero", "dens", "leo", "confringo", "nihilum", "infirmo"],
      6,
      7,
      "God breaks the teeth and grinders of the wicked, symbolizing the destruction of their power to harm, and they become like running water that vanishes.",
      "Augustine interprets the teeth as symbols of destructive speech and predatory power. God's judgment dismantles the wicked's ability to harm the righteous."
    ),
    (
      "Swift Destruction → Final Consequences",
      "The sudden and complete destruction of the wicked like melting wax",
      ["cera", "fluo", "ignis", "sol", "spina", "ira", "absorbeo"],
      8,
      9,
      "The wicked melt like wax before fire, are swallowed up in God's wrath before their thorns can mature, and never see the sun of righteousness.",
      "Augustine sees this as the suddenness of divine judgment that overtakes the wicked in their prime, preventing their evil plans from coming to full maturity."
    ),
    (
      "Righteous Vindication → Divine Justice Affirmed",
      "The righteous rejoicing in God's justice and public acknowledgment of God's judgment",
      ["laetor", "iustus", "vindicta", "lavo", "sanguis", "fructus", "iudico"],
      10,
      11,
      "The just rejoice at God's vengeance, washing hands in the blood of sinners, and humanity acknowledges that there is indeed fruit for the righteous and a God who judges on earth.",
      "For Augustine, this represents the ultimate vindication of the righteous and the public demonstration that God's justice prevails, leading to universal acknowledgment of divine governance."
    ),
  ]

  private let conceptualThemes = [
    (
      "Body Parts Metaphors",
      "References to body parts representing spiritual realities",
      ["cor", "manus", "vulva", "uterus", "auris", "dens", "os"],
      ThemeCategory.sin,
      1 ... 6
    ),
    (
      "Animal Imagery",
      "Comparisons to animals symbolizing wickedness and judgment",
      ["serpens", "aspis", "leo"],
      ThemeCategory.sin,
      4 ... 6
    ),
    (
      "Divine Judgment Actions",
      "Verbs describing God's judicial intervention",
      ["contero", "confringo", "intendo", "absorbeo", "iudico"],
      ThemeCategory.divine,
      6 ... 11
    ),
    (
      "Elements of Destruction",
      "Natural elements used to depict the fate of the wicked",
      ["aqua", "cera", "ignis", "sol"],
      ThemeCategory.justice,
      7 ... 9
    ),
    (
      "Justice and Righteousness",
      "Concepts of divine justice and human righteousness",
      ["iustitia", "iudico", "rectus", "iustus", "vindicta"],
      ThemeCategory.virtue,
      1 ... 11
    ),
    (
      "Speech and Hearing",
      "References to communication, truth, and receptivity",
      ["loquor", "falsus", "vox", "exaudio", "surdus" ],
      ThemeCategory.sin,
      1 ... 5
    ),
    (
      "Wicked Characteristics",
      "Descriptions of the nature and behavior of sinners",
      ["iniquitas", "iniustitia", "peccator", "furor"],
      ThemeCategory.sin,
      2 ... 10
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 57 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 57 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm57_texts.json"
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
      filename: "output_psalm57_themes.json"
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