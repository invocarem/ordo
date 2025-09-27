@testable import LatinService
import XCTest

class Psalm75Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 75, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 12
  private let text = [
    "Notus in Iudaea Deus; in Israel magnum nomen eius.",
    "Et factus est in pace locus eius, et habitatio eius in Sion.",
    "Ibi confregit potentias arcuum, scutum, gladium, et bellum.",
    "Illuminas tu mirabiliter a montibus aeternis. Turbati sunt omnes insipientes corde; ",
    "Dormierunt somnum suum, et nihil invenerunt omnes viri divitiarum in manibus suis.", /* 5 */
    "Ab increpatione tua, Deus Iacob, dormitaverunt qui ascenderunt equos.",
    "Tu terribilis es, et quis resistet tibi? ex tunc ira tua.",
    "De caelo auditum fecisti iudicium; terra tremuit et quievit.",
    "Cum exsurgeret in iudicium Deus, ut salvos faceret omnes mansuetos terrae.",
    "Quoniam cogitatio hominis confitebitur tibi, et reliquiae cogitationis diem festum agent tibi.",
    "Vovete, et reddite Domino Deo vestro: omnes, qui in circuitu eius affertis munera.",
    "Terribili et ei qui aufert spiritum principum, terribili apud reges terrae.",
  ]

  private let englishText = [
    "In Judea God is known; his name is great in Israel.",
    "And his place is in peace, and his abode in Sion.",
    "There hath he broken the powers of bows, the shield, the sword, and the battle.",
    "Thou enlightenest wonderfully from the everlasting hills. All the foolish of heart were troubled;",
    "They have slept their sleep, and all the men of riches have found nothing in their hands.",
    "At thy rebuke, O God of Jacob, they have all slumbered that mounted on horseback.",
    "Thou art terrible, and who shall resist thee? from that time thy wrath.",
    "Thou hast caused judgment to be heard from heaven; the earth trembled and was still.",
    "When God arose in judgment, to save all the meek of the earth.",
    "For the thought of man shall give praise to thee, and the remainders of the thought shall keep holiday to thee.",
    "Vow ye, and pay to the Lord your God: all you that are round about him bring presents.",
    "To him who takes away the spirit of princes: to the terrible with the kings of the earth.",
  ]

  private let lineKeyLemmas = [
    (1, ["notus", "iudaea", "deus", "israel", "nomen"]),
    (2, ["facio", "pax", "locus", "habitatio", "sion"]),
    (3, ["confringo", "potentia", "arcus", "scutum", "gladius", "bellum"]),
    (4, ["illumino", "mirabilis", "mons", "aeternus", "turbo", "insipiens", "cor"]),
    (5, ["dormio", "somnus", "invenio", "vir", "divitiae", "manus"]),
    (6, ["increpatio", "deus", "iacob", "dormio", "ascendo", "equus"]),
    (7, ["terribilis", "resisto", "ira"]),
    (8, ["caelum", "auditus", "facio", "iudicium", "terra", "tremo", "quiesco"]),
    (9, ["exsurgo", "iudicium", "deus", "salvus", "facio", "mansuetus", "terra"]),
    (10, ["cogitatio", "homo", "confiteor", "reliquiae", "dies", "festus", "ago"]),
    (11, ["voveo", "reddo", "dominus", "deus", "omnis", "circuitus", "affero", "munus"]),
    (12, ["terribilis", "aufero", "spiritus", "princeps", "terribilis", "rex", "terra"]),
  ]

  private let structuralThemes = [
    (
      "Divine Recognition → Sacred Geography",
      "God's recognition in Judah/Israel leading to His peaceful establishment in Zion",
      ["notus", "judaea", "deus", "israel", "pax", "locus", "habitatio", "sion"],
      1,
      2,
      "God is known in Judah and His name is great in Israel, and His place is established in peace with His dwelling in Zion.",
      "Augustine sees this as the progression from divine revelation to sacred geography - God's self-disclosure leads to His establishment of a holy dwelling place where His people can encounter Him."
    ),
    (
      "Divine Warrior → Eternal Light",
      "God's destruction of weapons of war contrasted with His eternal illumination",
      ["confringo", "potentia", "arcus", "scutum", "gladius", "bellum", "illumino", "mirabilis", "mons", "aeternus"],
      3,
      4,
      "God shatters the powers of bows, shields, swords, and war, while illuminating wonderfully from the eternal mountains.",
      "For Augustine, this represents God's power over human warfare and His eternal nature - He destroys temporal weapons while providing eternal light from His everlasting dwelling."
    ),
    (
      "Foolish Disturbance → Divine Rebuke",
      "The foolish are troubled and sleep, while God's rebuke affects the mighty",
      ["turbo", "insipiens", "cor", "dormio", "somnus", "increpatio", "deus", "iacob", "ascendo", "equus"],
      5,
      6,
      "All the foolish of heart are troubled and sleep their sleep, while at God's rebuke those who mounted horses slumber.",
      "Augustine sees this as divine judgment on both the foolish and the powerful - the foolish are disturbed in their sleep, while even the mighty horsemen are put to sleep by God's rebuke."
    ),
    (
      "Divine Terror → Cosmic Judgment",
      "God's terrifying nature leading to cosmic judgment from heaven to earth",
      ["terribilis", "resisto", "ira", "caelum", "auditus", "facio", "iudicium", "terra", "tremo", "quiesco"],
      7,
      8,
      "God is terrible and none can resist Him, and He has caused judgment to be heard from heaven while the earth trembled and was still.",
      "Augustine sees this as the progression from divine awe to cosmic response - God's terrifying nature leads to heavenly judgment that causes the earth to tremble then be still in submission."
    ),
    (
      "Saving Judgment → Human Praise",
      "God's judgment that saves the meek leading to human confession and celebration",
      ["exsurgo", "iudicium", "deus", "salvus", "facio", "mansuetus", "cogitatio", "homo", "confiteor", "reliquiae", "dies", "festus", "ago"],
      9,
      10,
      "When God arose in judgment to save all the meek of the earth, the thought of man shall give praise to Him and the remainders of thought shall keep holiday to Him.",
      "For Augustine, this represents the eschatological hope - God's final judgment saves the meek, and all human thought will ultimately confess and celebrate His goodness."
    ),
    (
      "Vows and Offerings → Divine Terror",
      "Human vows and offerings to God contrasted with His terrifying power over princes and kings",
      ["voveo", "reddo", "dominus", "deus", "omnis", "circuitus", "affero", "munus", "terribilis", "aufero", "spiritus", "princeps", "rex", "terra"],
      11,
      12,
      "All are called to vow and pay to the Lord their God and bring presents, while God is terrible to him who takes away the spirit of princes and is terrible with the kings of the earth.",
      "Augustine sees this as the proper response to divine judgment - humans should offer vows and gifts to God, recognizing His terrifying power over all earthly rulers and authorities."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Names and Titles",
      "Various names and titles for God throughout the psalm",
      ["deus", "iacob", "dominus"],
      ThemeCategory.divine,
      1 ... 12
    ),
    (
      "Geographic References",
      "Sacred geography from Judah/Israel to Zion",
      ["iudaea", "israel", "sion", "terra"],
      ThemeCategory.divine,
      1 ... 12
    ),
    (
      "War and Weapons",
      "Imagery of warfare and divine power over weapons",
      ["confringo", "potentia", "arcus", "scutum", "gladius", "bellum", "ascendo", "equus"],
      ThemeCategory.divine,
      3 ... 6
    ),
    (
      "Light and Illumination",
      "Divine light and eternal illumination",
      ["illumino", "mirabilis", "mons", "aeternus"],
      ThemeCategory.divine,
      4 ... 4
    ),
    (
      "Sleep and Rest",
      "Sleep as metaphor for judgment and divine action",
      ["dormio", "somnus", "dormitaverunt"],
      ThemeCategory.justice,
      5 ... 6
    ),
    (
      "Divine Judgment",
      "God's judicial power and cosmic judgment",
      ["terribilis", "ira", "iudicium", "exsurgo"],
      ThemeCategory.justice,
      7 ... 9
    ),
    (
      "Human Response",
      "Human confession, praise, and celebration",
      ["cogitatio", "homo", "confiteor", "reliquiae", "dies", "festus", "ago"],
      ThemeCategory.worship,
      10 ... 10
    ),
    (
      "Salvation and Mercy",
      "God's saving action for the meek",
      ["salvus", "facio", "mansuetus"],
      ThemeCategory.justice,
      9 ... 9
    ),
    (
      "Vows and Offerings",
      "Human vows and offerings to God",
      ["voveo", "reddo", "affero", "munus"],
      ThemeCategory.worship,
      11 ... 11
    ),
    (
      "Divine Power over Rulers",
      "God's terrifying power over earthly princes and kings",
      ["terribilis", "aufero", "spiritus", "princeps", "rex"],
      ThemeCategory.divine,
      12 ... 12
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 75 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 75 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm75_texts.json"
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
      filename: "output_psalm75_themes.json"
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
