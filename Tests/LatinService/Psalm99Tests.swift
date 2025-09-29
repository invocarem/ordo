import XCTest

@testable import LatinService

class Psalm99Tests: XCTestCase {
  private var latinService: LatinService!
  private let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  // MARK: - Test Data
  let id = PsalmIdentity(number: 99, category: "")
  private let expectedVerseCount = 5

  private let text = [
    /* 1 */
    "Iubilate Deo, omnis terra; servite Domino in laetitia.",
    /* 2 */ "Introite in conspectu eius in exsultatione.",
    /* 3 */ "Scitote quoniam Dominus ipse est Deus; ipse fecit nos, et non ipsi nos.",
    /* 4 */
    "Populus eius, et oves pascuae eius:, introite portas eius in confessione, atria eius in hymnis; confitemini illi.",
    /* 5 */
    "Laudate nomen eius, quoniam suavis est Dominus, in aeternum misericordia eius, et usque in generationem et generationem veritas eius.",
  ]

  private let englishText = [
    /* 1 */
    "Sing joyfully to God, all the earth; serve ye the Lord with gladness.",
    /* 2 */ "Come in before his presence with exceeding great joy.",
    /* 3 */ "Know ye that the Lord he is God; he made us, and not we ourselves.",
    /* 4 */
    "We are his people and the sheep of his pasture: go ye into his gates with praise, into his courts with hymns; and give glory to him.",
    /* 5 */
    "Praise ye his name, for the Lord is sweet, his mercy endureth for ever, and his truth to generation and generation.",
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["iubilo", "deus", "omnis", "terra", "servio", "dominus", "laetitia"]),
    (2, ["introeo", "conspectus", "exsultatio"]),
    (3, ["scio", "quoniam", "dominus", "ipse", "deus", "facio", "nos", "non"]),
    (
      4,
      [
        "populus", "ovis", "pascua", "introeo", "porta", "confessio", "atrium", "hymnus",
        "confiteor", "ille",
      ]
    ),
    (
      5,
      [
        "laudo", "nomen", "quoniam", "suavis", "dominus", "aeternum", "misericordia", "usque",
        "generatio", "veritas",
      ]
    ),
  ]

  private let structuralThemes = [
    (
      "Universal Call → Joyful Entry",
      "From global worship summons to intimate presence with exultation",
      [
        "iubilo", "deus", "omnis", "terra", "servio", "dominus", "laetitia", "introeo",
        "conspectus", "exsultatio",
      ],
      1,
      2,
      "The psalm begins with a universal call for all the earth to shout for joy to God and serve with gladness, then moves to entering His presence with exceeding joy.",
      "Augustine sees this progression as the movement from external worship to internal communion. The universal call represents God's invitation to all creation, while the joyful entry shows the believer's response in drawing near to the divine presence."
    ),
    (
      "Divine Sovereignty → Temple Approach",
      "From recognizing God as Creator to approaching His temple as His people",
      [
        "scio", "quoniam", "dominus", "ipse", "deus", "facio", "nos", "non", "populus", "ovis",
        "pascua", "introeo", "porta", "confessio", "atrium", "hymnus", "confiteor",
      ],
      3,
      4,
      "The people are called to know that the Lord is God and that He made us, not we ourselves. We are His people and sheep of His pasture, entering His gates with thanksgiving and His courts with praise.",
      "Augustine interprets this as the foundational recognition of our creaturehood leading to proper worship. Knowing we are made by God establishes our dependence, while the shepherd-sheep metaphor shows God's care, and temple worship demonstrates our grateful response through structured praise."
    ),
    (
      "Divine Attributes",
      "God's sweetness, eternal mercy, and enduring truth",
      [
        "laudo", "nomen", "quoniam", "suavis", "dominus", "aeternum", "misericordia", "generatio",
        "veritas",
      ],
      5,
      5,
      "Praise His name, for the Lord is good; His mercy endures forever, and His faithfulness to all generations.",
      "Augustine sees this final declaration as the culmination of worship - recognizing God's essential goodness that grounds all His actions. The eternal mercy and truth reveal God's unchanging character that provides security for all generations of believers."
    ),
  ]

  private let conceptualThemes = [
    (
      "Universal Worship",
      "The call for all creation to worship God with joy and gladness",
      ["iubilo", "deus", "omnis", "terra", "servio", "laetitia", "introeo", "exsultatio"],
      ThemeCategory.worship,
      1...2
    ),
    (
      "Divine Creator",
      "God as Creator and Lord over all creation",
      ["dominus", "ipse", "deus", "facio", "nos", "non"],
      ThemeCategory.divine,
      3...3
    ),
    (
      "Shepherd and Temple",
      "God as caring shepherd and proper temple worship",
      ["populus", "ovis", "pascua", "porta", "atrium", "confiteor"],
      ThemeCategory.divine,
      4...4
    ),
    (
      "Divine Attributes",
      "God's goodness, mercy, and eternal faithfulness",
      ["laudo", "nomen", "suavis", "misericordia", "veritas", "aeternum"],
      ThemeCategory.divine,
      5...5
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 99 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 99 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm99_texts.json"
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

  // MARK: - Thematic Tests

  func testUniversalPraiseTheme() {
    let universalPraiseTerms = [
      ("iubilo", ["Iubilate"], "shout for joy"),
      ("deus", ["Deo"], "God"),
      ("omnis", ["omnis"], "all"),
      ("terra", ["terra"], "earth"),
      ("servio", ["servite"], "serve"),
      ("dominus", ["Domino"], "Lord"),
      ("laetitia", ["laetitia"], "gladness"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: universalPraiseTerms,
      verbose: verbose
    )
  }

  func testJoyfulEntryTheme() {
    let joyfulEntryTerms = [
      ("introeo", ["Introite"], "enter"),
      ("conspectus", ["conspectu"], "presence"),
      ("exsultatio", ["exsultatione"], "exultation"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: joyfulEntryTerms,
      verbose: verbose
    )
  }

  func testDivineSovereigntyTheme() {
    let divineSovereigntyTerms = [
      ("scio", ["Scitote"], "know"),
      ("dominus", ["Dominus", "dominus"], "Lord"),
      ("ipse", ["ipse", "ipse"], "he himself"),
      ("deus", ["Deus"], "God"),
      ("facio", ["fecit"], "made"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: divineSovereigntyTerms,
      verbose: verbose
    )
  }

  func testShepherdAndTempleTheme() {
    let shepherdAndTempleTerms = [
      ("populus", ["Populus"], "people"),
      ("ovis", ["oves"], "sheep"),
      ("pascua", ["pascuae"], "pasture"),
      ("introeo", ["introite"], "enter"),
      ("porta", ["portas"], "gate"),
      ("confessio", ["confessione"], "confession"),
      ("atrium", ["atria"], "courts"),
      ("hymnus", ["hymnis"], "hymns"),
      ("confiteor", ["confitemini"], "confess"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: shepherdAndTempleTerms,
      verbose: verbose
    )
  }

  func testDivineAttributesTheme() {
    let divineAttributesTerms = [
      ("laudo", ["Laudate"], "praise"),
      ("nomen", ["nomen"], "name"),
      ("suavis", ["suavis"], "sweet"),
      ("misericordia", ["misericordia"], "mercy"),
      ("veritas", ["veritas"], "truth"),
      ("aeternum", ["aeternum"], "forever"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: divineAttributesTerms,
      verbose: verbose
    )
  }

  func testTempleImagery() {
    let templeTerms = [
      ("porta", ["portas"], "gates"),
      ("atrium", ["atria"], "courts"),
      ("introeo", ["introite"], "enter"),
      ("confessio", ["confessione"], "thanksgiving"),
      ("hymnus", ["hymnis"], "hymns"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: templeTerms,
      verbose: verbose
    )
  }

  func testShepherdImagery() {
    let shepherdTerms = [
      ("populus", ["Populus"], "people"),
      ("ovis", ["oves"], "sheep"),
      ("pascua", ["pascuae"], "pasture"),
      ("dominus", ["eius"], "his"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: shepherdTerms,
      verbose: verbose
    )
  }

  func testWorshipProgression() {
    let worshipTerms = [
      ("iubilo", ["Iubilate"], "shout for joy"),
      ("servio", ["servite"], "serve"),
      ("introeo", ["Introite", "introite"], "enter"),
      ("laudo", ["Laudate"], "praise"),
      ("confiteor", ["confitemini"], "confess"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: worshipTerms,
      verbose: verbose
    )
  }

  func testDivineCreator() {
    let creatorTerms = [
      ("scio", ["Scitote"], "know"),
      ("dominus", ["Dominus"], "Lord"),
      ("ipse", ["ipse"], "he himself"),
      ("deus", ["Deus"], "God"),
      ("facio", ["fecit"], "made"),
      ("nos", ["nos"], "us"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: creatorTerms,
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
      filename: "output_psalm99_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
