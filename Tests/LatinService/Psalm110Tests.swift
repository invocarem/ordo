import XCTest

@testable import LatinService

class Psalm110Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data
  let id = PsalmIdentity(number: 110, category: nil)
  private let expectedVerseCount = 11

  private let text = [
    /* 1 */
    "Confitebor tibi, Domine, in toto corde meo, in concilio iustorum, et congregatione.",
    /* 2 */ "Magna opera Domini: exquisita in omnes voluntates eius.",
    /* 3 */ "Confessio et magnificentia opus eius; et iustitia eius manet in saeculum saeculi.",
    /* 4 */ "Memoriam fecit mirabilium suorum, misericors et miserator Dominus.",
    /* 5 */ "Escam dedit timentibus se; memor erit in saeculum testamenti sui.",
    /* 6 */ "Virtutem operum suorum annuntiabit populo suo:",
    /* 7 */ "Ut det illis haereditatem gentium: opera manuum eius veritas et iudicium.",
    /* 8 */
    "Fidelia omnia mandata eius, confirmata in saeculum saeculi, facta in veritate et aequitate.",
    /* 9 */ "Redemptionem misit populo suo; mandavit in aeternum testamentum suum.",
    /* 10 */ "Sanctum et terribile nomen eius: initium sapientiae timor Domini.",
    /* 11 */ "Intellectus bonus omnibus facientibus eum: laudatio eius manet in saeculum saeculi.",
  ]

  private let englishText = [
    /* 1 */
    "I will praise thee, O Lord, with my whole heart; in the council of the just, and in the congregation.",
    /* 2 */ "Great are the works of the Lord: sought out according to all his wills.",
    /* 3 */ "His work is praise and magnificence: and his justice continueth for ever and ever.",
    /* 4 */
    "He hath made a remembrance of his wonderful works, being a merciful and gracious Lord.",
    /* 5 */
    "He hath given food to them that fear him: he will be mindful for ever of his covenant.",
    /* 6 */ "He will show forth to his people the power of his works:",
    /* 7 */
    "That he may give them the inheritance of the Gentiles: the works of his hands are truth and judgment.",
    /* 8 */
    "All his commandments are faithful, confirmed for ever and ever, made in truth and equity.",
    /* 9 */ "He hath sent redemption to his people: he hath commanded his covenant for ever.",
    /* 10 */ "Holy and terrible is his name: the fear of the Lord is the beginning of wisdom.",
    /* 11 */ "A good understanding to all that do it: his praise continueth for ever and ever.",
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["confiteor", "dominus", "totus", "cor", "concilium", "iustus", "congregatio"]),
    (2, ["magnus", "opus", "dominus", "exquiro", "voluntas"]),
    (3, ["confessio", "magnificentia", "opus", "iustitia", "maneo", "saeculum"]),
    (4, ["memoria", "facio", "mirabile", "misericors", "miserator", "dominus"]),
    (5, ["esca", "do", "timeo", "memor", "saeculum", "testamentum"]),
    (6, ["virtus", "opus", "annuntio", "populus"]),
    (7, ["do", "haereditas", "gens", "opus", "manus", "veritas", "iudicium"]),
    (8, ["fidelis", "omnis", "mandatum", "confirmo", "saeculum", "facio", "veritas", "aequitas"]),
    (9, ["redemptio", "mitto", "populus", "mando", "aeternus", "testamentum"]),
    (10, ["sanctus", "terribilis", "nomen", "initium", "sapientia", "timor", "dominus"]),
    (11, ["intellectus", "bonus", "omnis", "facio", "laudatio", "maneo", "saeculum"]),
  ]

  private let structuralThemes = [
    (
      "Praise → Works",
      "Personal praise expanding to recognition of God's great works",
      [
        "confiteor", "dominus", "cor", "concilium", "iustus", "congregatio", "magnus", "opus",
        "exquiro", "voluntas",
      ],
      1,
      2,
      "The psalm begins with personal praise in the council of the just, then declares the greatness of God's works according to His will.",
      "Augustine sees this as the foundation of all worship - personal confession leading to recognition of God's sovereignty. The council of the just represents the community of believers, while the congregation includes all who gather to worship."
    ),
    (
      "Justice → Remembrance",
      "God's eternal justice leading to remembrance of His wonderful works",
      [
        "confessio", "magnificentia", "opus", "iustitia", "maneo", "saeculum", "memoria", "facio",
        "mirabile", "misericors", "miserator",
      ],
      3,
      4,
      "God's work is praise and magnificence, His justice endures forever, and He has made remembrance of His wonderful works as merciful and gracious Lord.",
      "Augustine interprets this as the connection between divine justice and mercy. The remembrance of wonderful works shows God's faithfulness to His people, while His mercy and graciousness reveal His character."
    ),
    (
      "Provision → Covenant",
      "Divine provision for the faithful leading to eternal covenant promise",
      [
        "esca", "do", "timeo", "memor", "saeculum", "testamentum", "virtus", "opus", "annuntio",
        "populus",
      ],
      5,
      6,
      "He gives food to those who fear Him and will remember His covenant forever. He will show the power of His works to His people.",
      "Augustine sees the food as both physical and spiritual nourishment, while the covenant represents God's eternal commitment to His people. The power of His works demonstrates His ability to fulfill His promises."
    ),
    (
      "Inheritance → Commandments",
      "Promise of Gentile inheritance leading to faithful commandments",
      [
        "do", "haereditas", "gens", "opus", "manus", "veritas", "iudicium", "fidelis", "omnis",
        "mandatum", "confirmo", "aequitas",
      ],
      7,
      8,
      "That He may give them the inheritance of the Gentiles: the works of His hands are truth and judgment. All His commandments are faithful, confirmed forever, made in truth and equity.",
      "Augustine interprets the Gentile inheritance as the expansion of God's people to include all nations. The commandments being faithful and confirmed forever shows the reliability of God's law as the foundation of His kingdom."
    ),
    (
      "Redemption → Wisdom",
      "Divine redemption leading to the beginning of wisdom through fear of the Lord",
      [
        "redemptio", "mitto", "populus", "mando", "aeternus", "testamentum", "sanctus",
        "terribilis", "nomen", "initium", "sapientia", "timor", "dominus",
      ],
      9,
      10,
      "He has sent redemption to His people and commanded His covenant forever. Holy and terrible is His name: the fear of the Lord is the beginning of wisdom.",
      "Augustine sees redemption as the ultimate act of God's love, while the fear of the Lord as the beginning of wisdom shows that true knowledge starts with reverence for God. The holy and terrible name reveals both God's transcendence and His power."
    ),
    (
      "Understanding → Praise",
      "Good understanding for the obedient leading to eternal praise",
      ["intellectus", "bonus", "omnis", "facio", "laudatio", "maneo", "saeculum"],
      11,
      11,
      "A good understanding to all that do it: His praise continues forever and ever.",
      "Augustine interprets this as the culmination of the psalm - those who obey God receive understanding, and their praise of Him endures eternally. This shows the reciprocal relationship between divine wisdom and human worship."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Praise",
      "Personal and communal praise of God's greatness and works",
      ["confiteor", "laudatio", "magnificentia"],
      ThemeCategory.worship,
      1...11
    ),
    (
      "Divine Works",
      "Recognition of God's great works, power, and faithfulness",
      ["opus", "magnus", "virtus", "mirabile"],
      ThemeCategory.divine,
      1...8
    ),
    (
      "Eternal Justice",
      "God's justice and righteousness that endures forever",
      ["iustitia", "iustus", "veritas", "aequitas"],
      ThemeCategory.divine,
      1...8
    ),
    (
      "Divine Mercy",
      "God's merciful and gracious character toward His people",
      ["misericors", "miserator", "esca", "redemptio"],
      ThemeCategory.divine,
      4...9
    ),
    (
      "Covenant Faithfulness",
      "God's eternal covenant and commandments with His people",
      ["testamentum", "mandatum", "fidelis", "confirmo"],
      ThemeCategory.divine,
      5...9
    ),
    (
      "Divine Wisdom",
      "The fear of the Lord as the beginning of wisdom and understanding",
      ["sapientia", "timor", "dominus", "intellectus", "bonus"],
      ThemeCategory.divine,
      10...11
    ),
    (
      "Community Worship",
      "Praise and worship in the context of the community of believers",
      ["concilium", "iustus", "congregatio", "populus"],
      ThemeCategory.worship,
      1...7
    ),
    (
      "Divine Inheritance",
      "The promise of inheritance and blessing for God's people",
      ["haereditas", "gens", "do"],
      ThemeCategory.divine,
      7...7
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 110 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 110 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
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
      filename: "output_psalm110_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
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

  func testDivineWorks() {
    let divineWorksTerms = [
      ("opus", ["opera", "opus"], "work"),
      ("magnus", ["Magna"], "great"),
      ("dominus", ["Domini", "dominus"], "lord"),
      ("virtus", ["Virtutem"], "power"),
      ("mirabile", ["mirabilium"], "wonder"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: divineWorksTerms,
      verbose: verbose
    )
  }

  func testCovenantThemes() {
    let covenantTerms = [
      ("testamentum", ["testamenti", "testamentum"], "covenant"),
      ("mandatum", ["mandata"], "commandment"),
      ("fidelis", ["Fidelia"], "faithful"),
      ("confirmo", ["confirmata"], "confirm"),
      ("aeternus", ["aeternum"], "eternal"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: covenantTerms,
      verbose: verbose
    )
  }

  func testWisdomThemes() {
    let wisdomTerms = [
      ("sapientia", ["sapientiae"], "wisdom"),
      ("timor", ["timor"], "fear"),
      ("intellectus", ["Intellectus"], "understanding"),
      ("initium", ["initium"], "beginning"),
      ("bonus", ["bonus"], "good"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: wisdomTerms,
      verbose: verbose
    )
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
      filename: "output_psalm110_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
