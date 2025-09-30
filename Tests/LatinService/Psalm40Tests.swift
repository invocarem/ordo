import XCTest

@testable import LatinService

class Psalm40Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 40, category: "")
  private let expectedVerseCount = 14

  private let text = [
    /* 1 */
    "Beatus qui intelligit super egenum et pauperem; in die mala liberabit eum Dominus.",
    /* 2 */
    "Dominus conservet eum, et vivificet eum, et beatum faciat eum in terra, et non tradat eum in animam inimicorum eius.",
    /* 3 */
    "Dominus opem ferat illi super lectum doloris eius; universum stratum eius versasti in infirmitate eius.",
    /* 4 */
    "Ego dixi: Domine, miserere mei; sana animam meam, quia peccavi tibi.",
    /* 5 */
    "Inimici mei dixerunt mala mihi: Quando morietur, et peribit nomen eius?",
    /* 6 */
    "Et si ingrediebatur ut videret, vana loquebatur; cor eius congregavit iniquitatem sibi.",
    /* 7 */
    "Egrediebatur foras, et loquebatur in idipsum.",
    /* 8 */
    "Adversum me susurrabant omnes inimici mei; adversum me cogitabant mala mihi.",
    /* 9 */
    "Verbum iniquum constituerunt adversum me: Numquid qui dormit non adiiciet ut resurgat?",
    /* 10 */
    "Etenim homo pacis meae, in quo speravi, qui edebat panes meos, magnificavit super me supplantationem.",
    /* 11 */
    "Tu autem, Domine, miserere mei, et resuscita me, et retribuam eis.",
    /* 12 */
    "In hoc cognovi quoniam voluisti me, quoniam non gaudebit inimicus meus super me.",
    /* 13 */
    "Me autem propter innocentiam suscepisti, et confirmasti me in conspectu tuo in aeternum.",
    /* 14 */
    "Benedictus Dominus, Deus Israel, a saeculo et usque in saeculum. Fiat, fiat.",
  ]

  private let englishText = [
    /* 1 */
    "Blessed is he that understandeth concerning the needy and the poor; the Lord will deliver him in the evil day.",
    /* 2 */
    "The Lord preserve him and give him life, and make him blessed upon the earth; and deliver him not up to the will of his enemies.",
    /* 3 */
    "The Lord help him on his bed of sorrow; thou hast turned all his couch in his sickness.",
    /* 4 */
    "I said: O Lord, be thou merciful to me; heal my soul, for I have sinned against thee.",
    /* 5 */
    "My enemies have spoken evils against me: When shall he die and his name perish?",
    /* 6 */
    "And if he came in to see me, he spoke vain things; his heart gathered together iniquity to itself.",
    /* 7 */
    "He went out and spoke to the same purpose.",
    /* 8 */
    "All my enemies whispered together against me; they devised evils to me.",
    /* 9 */
    "They determined against me an unjust word: Shall he that sleepeth rise again no more?",
    /* 10 */
    "For even the man of my peace, in whom I trusted, who ate my bread, hath greatly supplanted me.",
    /* 11 */
    "But thou, O Lord, have mercy on me, and raise me up again; and I will requite them.",
    /* 12 */
    "By this I know, that thou hast had a good will for me; because my enemy shall not rejoice over me.",
    /* 13 */
    "But thou hast upheld me by reason of my innocence; and hast established me in thy sight for ever.",
    /* 14 */
    "Blessed be the Lord the God of Israel from eternity to eternity. So be it, so be it.",
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["beatus", "intelligo", "egenus", "pauper", "dies", "malus", "libero", "dominus"]),
    (2, ["dominus", "conservo", "vivifico", "beatus", "facio", "terra", "trado", "anima", "inimicus"]),
    (3, ["dominus", "ops", "fero", "lectus", "dolor", "universus", "stratum", "verto", "infirmitas"]),
    (4, ["dico", "dominus", "misereor", "sano", "anima", "pecco"]),
    (5, ["inimicus", "dico", "malus", "morior", "pereo", "nomen"]),
    (6, ["ingredior", "video", "vanus", "loquor", "cor", "congrego", "iniquitas"]),
    (7, ["egredior", "foras", "loquor", "idipsum"]),
    (8, ["adversus", "susurro", "inimicus", "cogito", "malus"]),
    (9, ["verbum", "iniquus", "constituo", "adversus", "dormio", "resurgo"]),
    (10, ["homo", "pax", "spero", "edo", "panis", "magnifico", "supplantatio"]),
    (11, ["dominus", "misereor", "resuscito", "retribuo"]),
    (12, ["cognosco", "volo", "gaudeo", "inimicus"]),
    (13, ["innocentia", "suscipio", "confirmo", "conspectus", "aeternum"]),
    (14, ["benedictus", "dominus", "deus", "israel", "saeculum"]),
  ]
  private let structuralThemes = [
    (
      "Blessing → Preservation",
      "Divine favor for the compassionate leading to protection",
      ["beatus", "intelligo", "egenus", "pauper", "libero", "conservo"],
      1,
      2,
      "Blessedness through understanding the poor leads to divine deliverance",
      "Augustine sees Christ as the truly blessed one who understands human poverty and becomes poor for our salvation."
    ),
    (
      "Suffering → Confession",
      "Divine help in sickness leading to personal repentance",
      ["ops", "lectus", "dolor", "infirmitas", "misereor", "pecco"],
      3,
      4,
      "The bed of sorrow becomes the place of divine help and confession",
      "Augustine interprets the 'bed of sorrow' as Christ's passion, where he bears our sins though sinless."
    ),
    (
      "Mockery → Deception",
      "Enemies mocking mortality while gathering iniquity",
      ["inimicus", "morior", "pereo", "vanus", "congrego", "iniquitas"],
      5,
      6,
      "External mockery about death parallels internal sin",
      "Augustine sees the enemies as persecutors and demonic powers mocking Christ's mortality."
    ),
    (
      "Conspiracy → Unity",
      "Whispered plots and unified speech against the righteous",
      ["susurro", "cogito", "malus", "loquor", "idipsum"],
      7,
      8,
      "The conspiracy grows from individual to collective opposition",
      "Augustine sees this as the false witnesses at Christ's trial, showing how evil conspires against innocence."
    ),
    (
      "Hopelessness → Betrayal",
      "Questions about resurrection and intimate betrayal",
      ["dormio", "resurgo", "pax", "spero", "panis", "supplantatio"],
      9,
      10,
      "Hopeless questioning followed by ultimate betrayal",
      "Augustine identifies this as Judas' betrayal and the challenge to Christ's resurrection."
    ),
    (
      "Supplication → Knowledge",
      "Cry for mercy leading to certainty of divine favor",
      ["misereor", "resuscito", "retribuo", "cognosco", "volo", "gaudeo"],
      11,
      12,
      "Plea for resurrection leads to knowledge of God's will",
      "Augustine sees this as post-resurrection certainty of divine favor through answered prayer."
    ),
    (
      "Vindication → Eternal Blessing",
      "Innocence upheld forever culminating in perpetual worship",
      ["innocentia", "suscipio", "confirmo", "aeternum", "benedictus", "saeculum"],
      13,
      14,
      "Divine establishment based on righteousness leads to eternal praise",
      "Augustine sees the double 'fiat' affirming both Testaments and Christ's eternal priesthood."
    ),
  ]

  private let conceptualThemes = [
    (
      "Compassionate Understanding",
      "Blessedness through empathy for the poor and needy",
      ["beatus", "intelligo", "egenus", "pauper"],
      ThemeCategory.virtue,
      1 ... 2
    ),
    (
      "Divine Deliverance",
      "God's protection in times of trouble and from enemies",
      ["libero", "dominus", "conservo", "vivifico", "trado", "inimicus"],
      ThemeCategory.divine,
      1 ... 3
    ),
    (
      "Sickness and Suffering",
      "Physical and spiritual affliction as context for divine help",
      ["lectus", "dolor", "stratum", "verto", "infirmitas", "sano", "anima"],
      ThemeCategory.virtue,
      3 ... 4
    ),
    (
      "Enemy Opposition",
      "Various forms of persecution, mockery, and conspiracy",
      ["inimicus", "malus", "morior", "pereo", "nomen", "susurro", "cogito"],
      ThemeCategory.virtue,
      5 ... 9
    ),
    (
      "Betrayal Trauma",
      "Violation of trust by intimate associates",
      ["homo", "pax", "spero", "edo", "panis", "supplantatio"],
      ThemeCategory.virtue,
      10 ... 11
    ),
    (
      "Divine Mercy and Resurrection",
      "God's compassion leading to restoration and new life",
      ["misereor", "resuscito", "retribuo", "volo", "gaudeo"],
      ThemeCategory.divine,
      11 ... 12
    ),
    (
      "Innocence Vindicated",
      "Divine establishment based on righteousness",
      ["innocentia", "suscipio", "confirmo", "conspectus", "aeternum"],
      ThemeCategory.virtue,
      13 ... 14
    ),
    (
      "Eternal Worship",
      "Perpetual blessing of God across all ages",
      ["benedictus", "dominus", "deus", "israel", "saeculum"],
      ThemeCategory.worship,
      14 ... 14
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 40 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 40 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm40_texts.json"
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

  func testBetrayalImagery() {
    let betrayalTerms = [
      ("homo", ["homo"], "man"),
      ("pax", ["pacis"], "peace"),
      ("spero", ["speravi"], "hope/trust"),
      ("edo", ["edebat"], "eat"),
      ("panis", ["panes"], "bread"),
      ("supplantatio", ["supplantationem"], "supplanting/betrayal"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: betrayalTerms,
      verbose: verbose
    )
  }

  func testSicknessImagery() {
    let sicknessTerms = [
      ("lectus", ["lectum"], "bed"),
      ("dolor", ["doloris"], "sorrow/pain"),
      ("stratum", ["stratum"], "couch/bed"),
      ("verto", ["versasti"], "turn/overturn"),
      ("infirmitas", ["infirmitate"], "sickness/weakness"),
      ("sano", ["sana"], "heal"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: sicknessTerms,
      verbose: verbose
    )
  }

  func testEnemyConspiracy() {
    let conspiracyTerms = [
      ("inimicus", ["inimici", "inimicus", "inimicorum", "inimicus"], "enemy"),
      ("susurro", ["susurrabant"], "whisper"),
      ("cogito", ["cogitabant"], "think/devise"),
      ("malus", ["mala", "mala"], "evil"),
      ("constituo", ["constituerunt"], "establish/determine"),
      ("verbum", ["verbum"], "word"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: conspiracyTerms,
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
      filename: "output_psalm40_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
