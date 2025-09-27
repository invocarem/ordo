import XCTest

@testable import LatinService

class Psalm19Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = false

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 19, category: nil)
  private let expectedVerseCount = 10

  // MARK: - Test Data

  private let text = [
    "Exaudiat te Dominus in die tribulationis; protegat te nomen Dei Iacob.",
    "Mittat tibi auxilium de sancto, et de Sion tueatur te.",
    "Memor sit omnis sacrificii tui, et holocaustum tuum pingue fiat.",
    "Tribuat tibi secundum cor tuum, et omne consilium tuum confirmet.",
    "Laetabimur in salutari tuo; et in nomine Dei nostri magnificabimur.",
    "Impleat Dominus omnes petitiones tuas; nunc cognovi quoniam salvum fecit Dominus christum suum.",
    "Exaudiet illum de caelo sancto suo; in potentatibus salus dexterae eius.",
    "Hi in curribus, et hi in equis; nos autem in nomine Domini Dei nostri invocabimus.",
    "Ipsi obligati sunt, et ceciderunt; nos autem surreximus et erecti sumus.",
    "Domine, salvum fac regem, et exaudi nos in die qua invocaverimus te.",
  ]

  private let englishText = [
    "May the Lord hear thee in the day of tribulation: may the name of the God of Jacob protect thee.",
    "May he send thee help from the sanctuary: and defend thee out of Sion.",
    "May he be mindful of all thy sacrifices: and may thy whole burnt offering be made fat.",
    "May he give thee according to thy own heart; and confirm all thy counsels.",
    "We will rejoice in thy salvation; and in the name of our God we shall be exalted.",
    "The Lord fulfill all thy petitions: now have I known that the Lord hath saved his anointed.",
    "He will hear him from his holy heaven: the salvation of his right hand is in powers.",
    "Some trust in chariots, and some in horses: but we will call upon the name of the Lord our God.",
    "They are bound, and have fallen; but we are risen, and are set upright.",
    "O Lord, save the king: and hear us in the day that we shall call upon thee.",
  ]

  private let lineKeyLemmas = [
    (1, ["exaudio", "dominus", "dies", "tribulatio", "protego", "nomen", "deus", "iacob"]),
    (2, ["mitto", "auxilium", "sanctus", "sion", "tueor"]),
    (3, ["memor", "sacrificium", "holocaustum", "pinguis", "fio"]),
    (4, ["tribuo", "cor", "consilium", "confirmo"]),
    (5, ["laetor", "salus", "nomen", "deus", "magnifico"]),
    (6, ["impleo", "dominus", "petitio", "cognosco", "salvus", "facio", "christus"]),
    (7, ["exaudio", "caelum", "sanctus", "potentatus", "salus", "dextera"]),
    (8, ["currus", "equus", "nos", "nomen", "dominus", "deus", "invoco"]),
    (9, ["obligo", "cado", "nos", "surgo", "erigo"]),
    (10, ["dominus", "salvus", "facio", "rex", "exaudio", "nos", "dies", "invoco"]),
  ]

  private let structuralThemes = [
    (
      "Divine Petition → Divine Help",
      "Prayer for divine hearing and protection, leading to God's sending help from His sanctuary",
      [
        "exaudio", "dominus", "dies", "tribulatio", "protego", "nomen", "deus", "iacob", "mitto",
        "auxilium", "sanctus", "sion", "tueor",
      ],
      1,
      2,
      "The psalm begins with petitions for divine hearing in tribulation and protection by God's name, then requests that God send help from His sanctuary and defend from Zion.",
      "Augustine sees this as the opening pattern of prayer - acknowledging God's protective power and requesting His active intervention from His holy dwelling place."
    ),
    (
      "Sacrificial Worship → Divine Blessing",
      "Sacrificial offerings leading to divine blessing and confirmation",
      ["memor", "sacrificium", "holocaustum", "pinguis", "tribuo", "cor", "consilium", "confirmo"],
      3,
      4,
      "The psalmist asks God to remember all sacrifices and make the burnt offering fat, then to grant according to the heart and confirm all counsels.",
      "For Augustine, this represents the connection between sacrificial worship and divine blessing, where proper offerings lead to God's favor and the confirmation of righteous plans."
    ),
    (
      "Communal Rejoicing → Divine Recognition",
      "The community's joy in salvation and recognition of God's saving work through His anointed",
      [
        "laetor", "salus", "nomen", "deus", "magnifico", "impleo", "dominus", "petitio", "cognosco",
        "salvus", "facio", "christus",
      ],
      5,
      6,
      "The community rejoices in salvation and magnifies God's name, then recognizes that the Lord has fulfilled all petitions and saved His anointed one.",
      "Augustine sees this as the proper response of the faithful community to divine salvation, combining joy with recognition of God's saving work through His anointed."
    ),
    (
      "Divine Response → Earthly Power Contrast",
      "God's response from heaven contrasted with the choice between earthly and divine power",
      [
        "exaudio", "caelum", "sanctus", "potentatus", "salus", "dextera", "currus", "equus", "nos",
        "nomen", "dominus", "deus", "invoco",
      ],
      7,
      8,
      "God hears His anointed from heaven with powerful salvation, while contrasting those who trust in chariots and horses with those who call on God's name.",
      "Augustine sees this as the divine response from heaven combined with the fundamental choice between worldly power and divine power, with the latter being the path of the faithful."
    ),
    (
      "Defeat of Wicked → Final Petition",
      "The fall of the wicked contrasted with the faithful's rise, leading to the final prayer for the king",
      [
        "obligo", "cado", "nos", "surgo", "erigo", "dominus", "salvus", "facio", "rex", "exaudio",
        "nos", "dies", "invoco",
      ],
      9,
      10,
      "The wicked are bound and fall while the faithful rise and stand erect, culminating in the final prayer for the Lord to save the king and hear the people.",
      "Augustine sees this as the resolution of the power contrast - the wicked's defeat versus the faithful's victory - culminating in the community's ongoing prayer for their leader's salvation."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Intervention",
      "God's active response to prayer and His saving actions",
      ["exaudio", "protego", "mitto", "tueor", "impleo", "salvus", "facio"],
      ThemeCategory.divine,
      1...7
    ),
    (
      "Royal and Messianic Language",
      "References to kingship, anointing, and divine authority",
      ["christus", "rex", "potentatus", "dextera", "confirmo"],
      ThemeCategory.divine,
      4...10
    ),
    (
      "Sacrificial Worship",
      "Terms related to offerings, sacrifices, and ritual worship",
      ["sacrificium", "holocaustum", "pinguis", "memor", "invoco"],
      ThemeCategory.worship,
      3...10
    ),
    (
      "Victory and Warfare",
      "Military imagery and the contrast between earthly and divine power",
      ["currus", "equus", "cado", "surgo", "erigo", "obligo"],
      ThemeCategory.justice,
      8...9
    ),
    (
      "Communal Response",
      "The community's collective response to divine action",
      ["laetor", "magnifico", "nos", "nomen", "salus"],
      ThemeCategory.virtue,
      5...10
    ),
    (
      "Human Petition",
      "Human requests, needs, and relationship with God",
      ["cor", "consilium", "petitio", "dies", "tribulatio"],
      ThemeCategory.virtue,
      1...6
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 19 should have \(expectedVerseCount) verses")
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 19 English text should have \(expectedVerseCount) verses")
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
      filename: "output_psalm19_texts.json"
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
      filename: "output_psalm19_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Test Cases

  func testDivineIntervention() {
    let interventionTerms = [
      ("exaudio", ["Exaudiat", "Exaudiet", "exaudi"], "hear"),
      ("protego", ["protegat"], "protect"),
      ("mitto", ["Mittat"], "send"),
      ("tueor", ["tueatur"], "guard"),
      ("impleo", ["Impleat"], "fulfill"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: interventionTerms,
      verbose: verbose
    )
  }

  func testRoyalMessianicLanguage() {
    let royalTerms = [
      ("christus", ["christum"], "anointed"),
      ("rex", ["regem"], "king"),
      ("potentatus", ["potentatibus"], "power"),
      ("dextera", ["dexterae"], "right hand"),
      ("confirmo", ["confirmet"], "strengthen"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: royalTerms,
      verbose: verbose
    )
  }

  func testSacrificialLanguage() {
    let sacrificialTerms = [
      ("sacrificium", ["sacrificii"], "sacrifice"),
      ("holocaustum", ["holocaustum"], "burnt offering"),
      ("pinguis", ["pingue"], "rich"),
      ("memor", ["Memor"], "mindful"),
      ("invoco", ["invocaverimus"], "call upon"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: sacrificialTerms,
      verbose: verbose
    )
  }

  func testVictoryImagery() {
    let victoryTerms = [
      ("currus", ["curribus"], "chariot"),
      ("equus", ["equis"], "horse"),
      ("cado", ["ceciderunt"], "fall"),
      ("surgo", ["surreximus"], "rise"),
      ("erigo", ["erecti"], "stand erect"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: victoryTerms,
      verbose: verbose
    )
  }

  func testCommunalResponse() {
    let communalTerms = [
      ("laetor", ["Laetabimur"], "rejoice"),
      ("magnifico", ["magnificabimur"], "magnify"),
      ("nos", ["nos", "nostri"], "we"),
      ("nomen", ["nomine", "nomen"], "name"),
      ("salus", ["salutari", "salus"], "salvation"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: communalTerms,
      verbose: verbose
    )
  }

  func testHumanPetition() {
    let petitionTerms = [
      ("cor", ["cor"], "heart"),
      ("consilium", ["consilium"], "plan"),
      ("petitio", ["petitiones"], "petition"),
      ("dies", ["die"], "day"),
      ("tribulatio", ["tribulationis"], "tribulation"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: petitionTerms,
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
