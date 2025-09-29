import XCTest

@testable import LatinService

class Psalm42Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data
  let id = PsalmIdentity(number: 42, category: "")
  private let expectedVerseCount = 6

  private let text = [
    /* 1 */
    "iudica me, Deus, et discerne causam meam de gente non sancta; ab homine iniquo et doloso erue me.",
    /* 2 */
    "Quia tu es Deus fortitudo mea; quare me repulisti, et quare tristis incedo, dum affligit me inimicus?",
    /* 3 */
    "Emitte lucem tuam et veritatem tuam; ipsa me deduxerunt, et adduxerunt in montem sanctum tuum, et in tabernacula tua.",
    /* 4 */
    "Et introibo ad altare Dei, ad Deum qui laetificat iuventutem meam.",
    /* 5 */
    "Confitebor tibi in cithara, Deus, Deus meus; quare tristis es, anima mea, et quare conturbas me?",
    /* 6 */
    "Spera in Deo, quoniam adhuc confitebor illi; salutare vultus mei, et Deus meus."
  ]

  private let englishText = [
    /* 1 */
    "Judge me, O God, and distinguish my cause from the nation that is not holy; deliver me from the unjust and deceitful man.",
    /* 2 */
    "For thou art God my strength; why hast thou cast me off, and why do I go sorrowful whilst the enemy afflicteth me?",
    /* 3 */
    "Send forth thy light and thy truth; they have conducted me, and brought me unto thy holy hill, and into thy tabernacles.",
    /* 4 */
    "And I will go in to the altar of God, to God who giveth joy to my youth.",
    /* 5 */
    "To thee, O God my God, I will give praise upon the harp; why art thou sad, O my soul, and why dost thou disquiet me?",
    /* 6 */
    "Hope in God, for I will still give praise to him; the salvation of my countenance, and my God."
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["iudico", "deus", "discerno", "causa", "gens", "sanctus", "homo", "iniquus", "dolosus", "eruo"]),
    (2, ["deus", "fortitudo", "repello", "tristis", "incedo", "affligo", "inimicus"]),
    (3, ["emitto", "lux", "veritas", "deduco", "adduco", "mons", "sanctus", "tabernaculum"]),
    (4, ["introeo", "altare", "deus", "laetifico", "iuventus"]),
    (5, ["confiteor", "cithara", "deus", "tristis", "anima", "conturbo"]),
    (6, ["spero", "deus", "confiteor", "salus", "vultus", "deus"])
  ]

  private let structuralThemes = [
    (
      "Judgment → Rejection",
      "Divine judgment distinguishing the righteous from the wicked, yet the psalmist feels rejected",
      [
        "iudico", "deus", "discerno", "causa", "gens", "sanctus", "homo", "iniquus", "dolosus", "eruo", "fortitudo", "repello", "tristis", "incedo", "affligo", "inimicus"
      ],
      1,
      2,
      "The psalmist calls for divine judgment to distinguish his cause from the unholy nation, yet questions why God has cast him off and why he goes sorrowful while enemies afflict him",
      "Augustine sees this as the paradox of the righteous soul - confident in divine justice yet experiencing the apparent absence of God's protection. The psalmist's plea for judgment ('iudica me, Deus') shows his trust in God's righteousness, while his lament ('quare me repulisti') reveals the soul's struggle when divine favor seems withdrawn. Augustine interprets this as the Church's experience of persecution and the soul's longing for God's presence in times of trial."
    ),
    (
      "Light → Joy",
      "Divine light and truth leading to holy places and the joy of approaching God's altar",
      [
        "emitto", "lux", "veritas", "deduco", "adduco", "mons", "sanctus", "tabernaculum", "introeo", "altare", "deus", "laetifico", "iuventus"
      ],
      3,
      4,
      "The psalmist asks for God's light and truth to guide him to the holy mountain and tabernacles, and will go to the altar of God who gives joy to his youth",
      "Augustine interprets the light and truth as Christ and the Holy Spirit, who guide the soul to the heavenly Jerusalem. The holy mountain represents the Church, and the tabernacles are the dwelling places of God's people. The altar symbolizes Christ's sacrifice, and the joy of youth represents the spiritual renewal that comes from approaching God. Augustine sees this as the soul's journey from darkness to light, from questioning to worship, through the guidance of divine truth."
    ),
    (
      "Praise → Hope",
      "Praise with harp while questioning the soul's sadness, leading to hope in God's salvation",
      [
        "confiteor", "cithara", "deus", "tristis", "anima", "conturbo", "spero", "deus", "confiteor", "salus", "vultus", "deus"
      ],
      5,
      6,
      "The psalmist will praise God with the harp while questioning why his soul is sad and troubled, then exhorts his soul to hope in God and continue praising Him as his salvation",
      "Augustine sees this as the soul's internal dialogue between faith and doubt, between praise and sorrow. The harp represents the harmony of the soul's worship, while the questioning shows the ongoing struggle of the spiritual life. The final exhortation to hope ('Spera in Deo') is Augustine's key to understanding the psalm - the soul must hope in God even when it cannot see or feel His presence. The 'salutare vultus mei' (salvation of my countenance) represents the transformation that comes from this hope, restoring the soul's countenance from sorrow to joy through divine grace."
    )
  ]

  private let conceptualThemes = [
    (
      "Judgment Imagery",
      "Divine courtroom scene with judge, cause, and distinction between holy and unholy",
      ["iudico", "deus", "discerno", "causa", "gens", "sanctus", "homo", "iniquus", "dolosus"],
      ThemeCategory.divine,
      1...1
    ),
    (
      "Rejection and Sorrow Imagery",
      "The image of being cast off and walking in sorrow while enemies afflict",
      ["fortitudo", "repello", "tristis", "incedo", "affligo", "inimicus"],
      ThemeCategory.virtue,
      2...2
    ),
    (
      "Light and Truth Imagery",
      "Divine light and truth as personified guides leading to holy mountain and tabernacles",
      ["emitto", "lux", "veritas", "deduco", "adduco", "mons", "sanctus", "tabernaculum"],
      ThemeCategory.divine,
      3...3
    ),
    (
      "Altar and Joy Imagery",
      "Approaching the altar of God who gives joy to youth",
      ["introeo", "altare", "deus", "laetifico", "iuventus"],
      ThemeCategory.divine,
      4...4
    ),
    (
      "Harp and Soul Imagery",
      "Praise with harp while the soul questions its own sadness and disquiet",
      ["confiteor", "cithara", "deus", "tristis", "anima", "conturbo"],
      ThemeCategory.worship,
      5...5
    ),
    (
      "Hope and Countenance Imagery",
      "Hope in God as salvation that transforms the countenance from sorrow to joy",
      ["spero", "deus", "confiteor", "salus", "vultus"],
      ThemeCategory.virtue,
      6...6
    ),
    (
      "Divine Theophany",
      "God's manifestation through light, truth, and holy places",
      ["emitto", "lux", "veritas", "mons", "sanctus", "tabernaculum", "altare"],
      ThemeCategory.divine,
      3...4
    ),
    (
      "Soul's Internal Dialogue",
      "The psalmist's conversation with his own soul about sadness and hope",
      ["tristis", "anima", "conturbo", "spero", "confiteor"],
      ThemeCategory.virtue,
      5...6
    ),
    (
      "Enemy and Affliction Imagery",
      "The reality of spiritual enemies and the affliction they cause",
      ["iniquus", "dolosus", "inimicus", "affligo", "gens", "sanctus"],
      ThemeCategory.virtue,
      1...2
    ),
    (
      "Worship and Music Imagery",
      "The commitment to praise God through musical instruments and confession",
      ["confiteor", "cithara", "altare", "deus"],
      ThemeCategory.worship,
      4...6
    )
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 42 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 42 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm42_texts.json"
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

  func testDivineJudgmentTheme() {
    let judgmentTerms = [
      ("iudico", ["iudica"], "judge"),
      ("discerno", ["discerne"], "distinguish"),
      ("causa", ["causam"], "cause"),
      ("gens", ["gente"], "nation"),
      ("sanctus", ["sancta"], "holy"),
      ("eruo", ["erue"], "rescue")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: judgmentTerms,
      verbose: verbose
    )
  }

  func testDivineGuidanceTheme() {
    let guidanceTerms = [
      ("emitto", ["Emitte"], "send out"),
      ("lux", ["lucem"], "light"),
      ("veritas", ["veritatem"], "truth"),
      ("deduco", ["deduxerunt"], "lead"),
      ("adduco", ["adduxerunt"], "bring"),
      ("mons", ["montem"], "mountain"),
      ("tabernaculum", ["tabernacula"], "tabernacle")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: guidanceTerms,
      verbose: verbose
    )
  }

  func testSpiritualStruggleTheme() {
    let struggleTerms = [
      ("tristis", ["tristis", "tristis"], "sorrowful"),
      ("anima", ["anima"], "soul"),
      ("conturbo", ["conturbas"], "trouble"),
      ("spero", ["Spera"], "hope"),
      ("confiteor", ["Confitebor", "confitebor"], "praise")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: struggleTerms,
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
      filename: "output_psalm42_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testJudgmentImagery() {
    let judgmentTerms = [
      ("iudico", ["iudica"], "judge"),
      ("discerno", ["discerne"], "distinguish"),
      ("causa", ["causam"], "cause"),
      ("gens", ["gente"], "nation"),
      ("sanctus", ["sancta"], "holy"),
      ("homo", ["homine"], "man"),
      ("iniquus", ["iniquo"], "unjust"),
      ("dolosus", ["doloso"], "deceitful"),
      ("eruo", ["erue"], "rescue")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: judgmentTerms,
      verbose: verbose
    )
  }

  func testRejectionAndSorrowImagery() {
    let rejectionTerms = [
      ("fortitudo", ["fortitudo"], "strength"),
      ("repello", ["repulisti"], "reject"),
      ("tristis", ["tristis"], "sorrowful"),
      ("incedo", ["incedo"], "go"),
      ("affligo", ["affligit"], "afflict"),
      ("inimicus", ["inimicus"], "enemy")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: rejectionTerms,
      verbose: verbose
    )
  }

  func testLightAndTruthImagery() {
    let lightTerms = [
      ("emitto", ["Emitte"], "send"),
      ("lux", ["lucem"], "light"),
      ("veritas", ["veritatem"], "truth"),
      ("deduco", ["deduxerunt"], "lead"),
      ("adduco", ["adduxerunt"], "bring"),
      ("mons", ["montem"], "mountain"),
      ("sanctus", ["sanctum"], "holy"),
      ("tabernaculum", ["tabernacula"], "tabernacle")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: lightTerms,
      verbose: verbose
    )
  }

  func testAltarAndJoyImagery() {
    let altarTerms = [
      ("introeo", ["introibo"], "go in"),
      ("altare", ["altare"], "altar"),
      ("deus", ["Dei"], "God"),
      ("laetifico", ["laetificat"], "give joy"),
      ("iuventus", ["iuventutem"], "youth")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: altarTerms,
      verbose: verbose
    )
  }

  func testHarpAndSoulImagery() {
    let harpTerms = [
      ("confiteor", ["Confitebor"], "praise"),
      ("cithara", ["cithara"], "harp"),
      ("deus", ["Deus"], "God"),
      ("tristis", ["tristis"], "sad"),
      ("anima", ["anima"], "soul"),
      ("conturbo", ["conturbas"], "trouble")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: harpTerms,
      verbose: verbose
    )
  }

  func testHopeAndCountenanceImagery() {
    let hopeTerms = [
      ("spero", ["Spera"], "hope"),
      ("deus", ["Deo"], "God"),
      ("confiteor", ["confitebor"], "praise"),
      ("salus", ["salutare"], "salvation"),
      ("vultus", ["vultus"], "countenance")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: hopeTerms,
      verbose: verbose
    )
  }
}
