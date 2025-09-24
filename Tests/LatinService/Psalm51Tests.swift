@testable import LatinService
import XCTest

class Psalm51Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 51, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 9
  private let text = [
    "Quid gloriaris in malitia, qui potens es in iniquitate?",
    "Tota die iniustitiam cogitavit lingua tua; sicut novacula acuta fecisti dolum.",
    "Dilexisti malitiam super benignitatem; iniquitatem magis quam loqui aequitatem.",
    "Dilexisti omnia verba praecipitationis, lingua dolosa.",
    "Propterea Deus destruet te in finem, evellet te, et emigrabit te de tabernaculo tuo, et radicem tuam de terra viventium.",

    "Videbunt iusti, et timebunt, et super eum ridebunt, et dicent: Ecce homo qui non posuit Deum adiutorem suum; ",
    "Sed speravit in multitudine divitiarum suarum, et praevaluit in vanitate sua.",
    "Ego autem sicut oliva fructifera in domo Dei; speravi in misericordia Dei in aeternum, et in saeculum saeculi.",
    "Confitebor tibi in saeculum, quia fecisti: et exspectábo nomen tuum, quoniam bonum est in conspectu sanctorum tuorum.",
  ]

  private let englishText = [
    "Why dost thou glory in malice, thou that art mighty in iniquity?",
    "All the day long thy tongue hath devised injustice; as a sharp razor, thou hast wrought deceit.",
    "Thou hast loved malice more than goodness; and iniquity rather than to speak righteousness.",
    "Thou hast loved all the words of ruin, O deceitful tongue.",
    "Therefore will God destroy thee for ever: he will pluck thee out, and remove thee from thy dwelling place, and thy root out of the land of the living.",
    "The just shall see and fear, and shall laugh at him, and say:",
    "Behold the man that made not God his helper; but trusted in the abundance of his riches, and prevailed in his vanity.",
    "But I, as a fruitful olive tree in the house of God, have hoped in the mercy of God for ever, and for ever and ever.",
    "I will confess to thee for ever, because thou hast done it: and I will wait on thy name, for it is good in the sight of thy saints.",
  ]

  private let lineKeyLemmas = [
    (1, ["glorior", "malitia", "potens", "iniquitas"]),
    (2, ["totus", "dies", "iniustitia", "cogito", "lingua", "novacula", "acutus", "facio", "dolus"]),
    (3, ["diligo", "malitia", "super", "benignitas", "iniquitas", "magis", "qui", "loquor", "aequitas"]),
    (4, ["diligo", "omnis", "verbum", "praecipitatio", "lingua", "dolosus"]),
    (5, ["propterea", "deus", "destruo", "finis", "evello", "emigro", "tabernaculum", "radix", "terra", "vivens"]),
    (6, ["video", "iustus", "timeo", "super", "rideo", "dico"]),
    (7, ["spero", "multitudo", "divitiae", "praevaleo", "vanitas"]),
    (8, ["oliva", "fructifer", "domus", "deus", "spero", "misericordia", "deus", "aeternum", "saeculum"]),
    (9, ["confiteor", "saeculum", "facio", "exspecto", "nomen", "bonus", "conspectus", "sanctus"]),
  ]

  private let structuralThemes = [
    (
      "Accusation → Description of Wickedness",
      "Direct challenge to the wicked followed by detailed description of their evil deeds",
      ["glorior", "malitia", "iniquitas", "cogito", "lingua", "dolus"],
      1,
      2,
      "The psalm opens with a rhetorical question challenging the wicked who glory in malice, then describes how their tongue constantly devises injustice like a sharp razor crafting deceit.",
      "Augustine sees this as God's confrontation with the proud sinner who boasts in their evil power, revealing how speech becomes an instrument of continuous wickedness when separated from divine truth."
    ),
    (
      "Preference for Evil → Love of Destructive Speech",
      "The wicked's choice of evil over good, specifically their love for destructive words",
      ["diligo", "malitia", "benignitas", "iniquitas", "aequitas", "verbum", "praecipitatio"],
      3,
      4,
      "The psalmist declares that the wicked has loved malice more than goodness, iniquity over righteousness, and has loved all words of ruin with a deceitful tongue.",
      "For Augustine, this represents the fundamental perversion of the will - choosing what destroys over what builds up, and finding pleasure in speech that leads to spiritual ruin rather than edification."
    ),
    (
      "Divine Judgment → Consequences",
      "God's definitive judgment resulting in complete removal from the land of the living",
      ["deus", "destruo", "evello", "emigro", "tabernaculum", "radix", "terra", "vivens"],
      5,
      5,
      "Therefore God will destroy the wicked forever, plucking them out, removing them from their dwelling, and uprooting them from the land of the living.",
      "Augustine interprets this as the ultimate consequence for those who persist in evil - complete separation from the community of the living and eternal destruction by divine justice."
    ),
    (
      "Righteous Response → Contrasting Declaration",
      "The just's reaction to judgment followed by the psalmist's personal testimony of faith",
      ["video", "iustus", "timeo", "rideo", "homo", "deus", "adiutor", "spero", "oliva", "fructifer", "domus", "deus"],
      6,
      8,
      "The just will see, fear, and laugh at the wicked's fate, recognizing the man who didn't make God his helper but trusted in riches. In contrast, the psalmist declares himself like a fruitful olive tree in God's house, hoping in God's mercy forever.",
      "Augustine sees this as the dual response of the righteous: holy fear at God's judgment and recognition of vain trust in worldly things, contrasted with the stable hope of those who dwell in God's house and trust in His eternal mercy."
    ),
    (
      "Eternal Confession → Divine Praise",
      "The psalmist's commitment to eternal confession and waiting on God's name",
      ["confiteor", "saeculum", "facio", "exspecto", "nomen", "bonus", "conspectus", "sanctus"],
      9,
      9,
      "The psalmist commits to confessing to God forever because He has acted, and will wait on God's name, which is good in the sight of His saints.",
      "Augustine sees this as the culmination of the righteous response - eternal confession of God's works and patient waiting on His name, recognizing that God's goodness is evident to all His saints."
    ),
  ]

  private let conceptualThemes = [
    (
      "Speech and Tongue",
      "References to speech, tongue, and words as instruments of good or evil",
      ["lingua", "loquor", "verbum", "dico"],
      ThemeCategory.sin,
      1 ... 8
    ),
    (
      "Moral Choices",
      "Contrast between choosing evil/iniquity versus good/righteousness",
      ["malitia", "iniquitas", "benignitas", "aequitas", "diligo", "super", "magis", "quam"],
      ThemeCategory.sin,
      1 ... 4
    ),
    (
      "Divine Judgment",
      "God's punishment and removal of the wicked",
      ["deus", "destruo", "evello", "emigro", "radix", "terra", "vivens"],
      ThemeCategory.divine,
      5 ... 5
    ),
    (
      "Wealth and Vanity",
      "Trust in riches and empty pursuits versus trust in God",
      ["divitiae", "vanitas", "praevaleo", "spero", "adiutor"],
      ThemeCategory.sin,
      7 ... 8
    ),
    (
      "Righteous Response",
      "How the just react to God's judgment on the wicked",
      ["iustus", "video", "timeo", "rideo", "ecce", "homo"],
      ThemeCategory.virtue,
      6 ... 7
    ),
    (
      "Hope and Dwelling",
      "Trust in God's mercy and abiding in His presence",
      ["spero", "misericordia", "domus", "deus", "oliva", "fructifer", "aeternum", "saeculum"],
      ThemeCategory.virtue,
      8 ... 9
    ),
    (
      "Eternal Confession",
      "Commitment to eternal praise and waiting on God's name",
      ["confiteor", "saeculum", "facio", "exspecto", "nomen", "bonus", "conspectus", "sanctus"],
      ThemeCategory.worship,
      9 ... 9
    ),
    (
      "Destructive Instruments",
      "Tools and imagery used for harm and deceit",
      ["novacula", "acutus", "dolus", "praecipitatio", "dolosus"],
      ThemeCategory.sin,
      2 ... 4
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 51 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 51 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm51_texts.json"
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
      filename: "output_psalm51_themes.json"
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
