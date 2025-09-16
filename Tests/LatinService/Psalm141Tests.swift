import XCTest

@testable import LatinService

class Psalm141Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  let id = PsalmIdentity(number: 141, category: nil)
  private let expectedVerseCount = 10

  // MARK: - Test Data

  private let text = [
    "Voce mea ad Dominum clamavi: voce mea ad Dominum deprecatus sum:",
    "Effundo in conspectu eius orationem meam, et tribulationem meam ante ipsum pronuntio.",
    "In deficiendo in me spiritum meum: et tu cognovisti semitas meas.",
    "In via hac, qua ambulabam, absconderunt laqueum mihi.",
    "Considerabam ad dexteram, et videbam: et non erat qui cognosceret me.",
    "Periit fuga a me, et non est qui requirat animam meam.",
    "Clamavi ad te, Domine, dixi: Tu es spes mea, portio mea in terra viventium.",
    "Intende ad deprecationem meam: quia humiliatus sum nimis.",
    "Libera me a persequentibus me: quia confortati sunt super me.",
    "Educ de custodia animam meam ad confitendum nomini tuo: me exspectant iusti, donec retribuas mihi.",
  ]

  private let englishText = [
    "I cried to the Lord with my voice: with my voice I made supplication to the Lord.",
    "In his sight I pour out my prayer, and before him I declare my trouble.",
    "When my spirit failed me, then thou knewest my paths.",
    "In this way wherein I walked, they have hidden a snare for me.",
    "I looked on my right hand, and beheld, and there was no one that would know me.",
    "Flight hath failed me: and there is no one that hath regard to my soul.",
    "I cried to thee, O Lord: I said: Thou art my hope, my portion in the land of the living.",
    "Attend to my supplication: for I am brought very low.",
    "Deliver me from my persecutors: for they are stronger than I.",
    "Bring my soul out of prison, that I may praise thy name: the just wait for me, until thou reward me.",
  ]

  private let lineKeyLemmas = [
    (1, ["vox", "dominus", "clamo", "deprecor"]),
    (2, ["effundo", "conspectus", "oratio", "tribulatio", "pronuntio"]),
    (3, ["deficio", "spiritus", "cognosco", "semita"]),
    (4, ["via", "ambulo", "abscondo", "laqueus"]),
    (5, ["considero", "dexter", "video", "cognosco"]),
    (6, ["pereo", "fuga", "requiro", "anima"]),
    (7, ["clamo", "dominus", "dico", "spes", "portio", "terra", "vivo"]),
    (8, ["intendo", "deprecatio", "humilio"]),
    (9, ["libero", "persequor", "conforto"]),
    (
      10,
      ["educo", "custodia", "anima", "confiteor", "nomen", "exspecto", "iustus", "retribuo"]
    ),
  ]

  private let structuralThemes = [
    (
      "Cry → Pouring Out",
      "From vocal plea to heartfelt outpouring before God",
      ["vox", "clamo", "deprecor", "effundo", "oratio", "tribulatio"],
      1,
      2,
      "The psalmist begins with loud cries to God and progresses to pouring out his prayer and trouble openly before the Lord.",
      "Augustine sees this as the soul's raw honesty before God—moving from external cries to internal vulnerability, where true prayer transforms complaint into communion (Enarr. Ps. 141.1-2)."
    ),
    (
      "Weakness → Divine Knowledge",
      "From spiritual depletion to God's intimate awareness",
      ["deficio", "spiritus", "cognosco", "semita"],
      3,
      4,
      "As the psalmist's spirit fails, he acknowledges God's perfect knowledge of his paths, even when hidden snares threaten.",
      "For Augustine, this expresses the paradox of faith: human weakness becomes the occasion for divine strength, and God's omniscience comforts when human understanding fails (Enarr. Ps. 141.3-4)."
    ),
    (
      "Abandonment → Recognition",
      "From social isolation to divine acknowledgment",
      ["considero", "video", "cognosco", "pereo", "fuga", "requiro"],
      5,
      6,
      "The psalmist looks for recognition but finds none, experiences the loss of escape, and feels utterly abandoned by human help.",
      "Augustine interprets this as the soul's realization that human recognition means nothing compared to being known by God—true refuge is found only in divine, not human, acknowledgment (Enarr. Ps. 141.5-6)."
    ),
    (
      "Declaration → Humility",
      "From confident confession to profound humility",
      ["clamo", "dico", "spes", "portio", "intendo", "deprecatio", "humilio"],
      7,
      8,
      "The psalmist boldly declares God as his hope and portion, then immediately follows with intense humility in his plea for attention.",
      "Augustine sees this as the proper posture of prayer: confident faith in God's character coupled with deep humility about one's own condition (Enarr. Ps. 141.7-8)."
    ),
    (
      "Deliverance → Vindication",
      "From rescue from pursuers to final vindication among the righteous",
      [
        "libero", "persequor", "conforto", "educo", "custodia", "confiteor", "exspecto",
        "iustus", "retribuo",
      ],
      9,
      10,
      "The psalm concludes with pleas for deliverance from enemies and liberation from prison, culminating in confession and expectation of God's repayment among the righteous.",
      "Augustine views this as the journey from temporal deliverance to eternal vindication—the soul's release from spiritual bondage to joyful confession among the communion of saints (Enarr. Ps. 141.9-10)."
    ),
  ]

  private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = [
    (
      "Divine Omniscience",
      "God's perfect knowledge and awareness",
      ["cognosco", "semita"],
      ThemeCategory.divine,
      3 ... 4
    ),
    (
      "Divine Justice",
      "God's righteous judgment and repayment",
      ["retribuo", "iustus"],
      ThemeCategory.justice,
      10 ... 10
    ),
    (
      "Prayerful Worship",
      "Heartfelt communication with God",
      ["clamo", "deprecor", "oratio", "effundo", "intendo", "deprecatio"],
      ThemeCategory.worship,
      1 ... 8
    ),
    (
      "Spiritual Hope",
      "Confident trust in God's provision",
      ["spes", "portio", "confiteor", "exspecto"],
      ThemeCategory.virtue,
      7 ... 10
    ),
    (
      "Human Abandonment",
      "Experience of isolation and betrayal",
      ["cognosco", "requiro", "pereo", "fuga"],
      ThemeCategory.sin,
      5 ... 6
    ),
    (
      "Persecution Conflict",
      "Struggle against enemies and oppression",
      ["persequor", "conforto", "laqueus", "abscondo"],
      ThemeCategory.conflict,
      4 ... 9
    ),
    (
      "Imprisonment Opposition",
      "Confinement and spiritual bondage",
      ["custodia", "educo", "deficio", "spiritus"],
      ThemeCategory.opposition,
      3 ... 10
    ),
    (
      "Divine Deliverance",
      "God's rescue and liberation",
      ["libero", "educo", "retribuo"],
      ThemeCategory.divine,
      9 ... 10
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 141 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 141 English text should have \(expectedVerseCount) verses")
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveThemes() {
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm141_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm141_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
