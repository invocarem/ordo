@testable import LatinService
import XCTest

class Psalm150Tests: XCTestCase {
  private var latinService: LatinService!
  private let utilities = PsalmTestUtilities.self

  let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  // MARK: - Test Data

  let psalm150 = [
    "Laudate Dominum in sanctis eius: laudate eum in firmamento virtutis eius.",
    "Laudate eum in virtutibus eius: laudate eum secundum multitudinem magnitudinis eius.",
    "Laudate eum in sono tubae: laudate eum in psalterio, et cithara.",
    "Laudate eum in tympano, et choro: laudate eum in chordis, et organo.",
    "Laudate eum in cymbalis benesonantibus: laudate eum in cymbalis iubilationis. Omnis spiritus laudet Dominum.",
  ]

  let englishText = [
    "Praise ye the Lord in his holy places: praise ye him in the firmament of his power.",
    "Praise ye him for his mighty acts: praise ye him according to the multitude of his greatness.",
    "Praise him with sound of trumpet: praise him with psaltery and harp.",
    "Praise him with timbrel and choir: praise him with strings and organs.",
    "Praise him on high sounding cymbals: praise him on cymbals of joy. Let every spirit praise the Lord.",
  ]

  let id = PsalmIdentity(number: 150, category: nil)

  // MARK: - Line-by-line key lemmas (Psalm 150)

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["laudo", "dominus", "sanctus", "firmamentum", "virtus"]),
    (2, ["laudo", "virtus", "multitudo", "magnitudo"]),
    (3, ["laudo", "sonus", "tuba", "psalterium", "cithara"]),
    (4, ["laudo", "tympanum", "chorus", "chorda", "organum"]),
    (5, ["laudo", "cymbalum", "benesonus", "iubilatio", "omnis", "spiritus", "laudo", "dominus"]),
  ]

  // MARK: - Structural Themes

  private let structuralThemes = [
    (
      "Sanctuary → Majesty",
      "From holy places to divine greatness",
      ["sanctus", "firmamentum", "virtus", "magnitudo"],
      1,
      2,
      "The call to praise begins in God's holy places and extends to the cosmic firmament, emphasizing His power and immeasurable greatness.",
      "Augustine sees this as praise moving from the earthly temple to the heavenly realm, where God's power and majesty are fully revealed. The 'sanctuary' represents the Church, while the 'firmament' signifies the celestial dwelling of God."
    ),
    (
      "Instruments → Universal Praise",
      "From musical instruments to all creation praising",
      ["tuba", "psalterium", "cithara", "tympanum", "organum", "cymbalum", "spiritus"],
      3,
      5,
      "The psalm progresses through various musical instruments, culminating in the call for every living spirit to praise the Lord, representing the universal scope of worship.",
      "Augustine interprets the instruments as different aspects of the faithful soul: the trumpet as proclamation, psaltery as good works, harp as heavenly desire, etc. The final call for 'every spirit' to praise shows that all creation, both visible and invisible, should worship God."
    ),
  ]

  // MARK: - Conceptual Themes

  private let conceptualThemes = [
    (
      "Divine Worship",
      "Praise and adoration of God",
      ["laudo", "dominus"],
      ThemeCategory.worship,
      nil as ClosedRange<Int>?
    ),
    (
      "Divine Majesty",
      "God's power and greatness",
      ["virtus", "magnitudo", "firmamentum"],
      .divine,
      1 ... 2
    ),
    (
      "Sacred Space",
      "Holy places and sanctuary",
      ["sanctus"],
      .worship,
      1 ... 1
    ),
    (
      "Musical Worship",
      "Instruments of praise",
      ["tuba", "psalterium", "cithara", "tympanum", "organum", "cymbalum"],
      .worship,
      3 ... 5
    ),
    (
      "Universal Praise",
      "All creation worshiping",
      ["omnis", "spiritus"],
      .worship,
      5 ... 5
    ),
    (
      "Joyful Worship",
      "Exuberant celebration",
      ["iubilatio", "benesonus"],
      .worship,
      5 ... 5
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    let expectedVerseCount = 5
    XCTAssertEqual(
      psalm150.count, expectedVerseCount, "Psalm 150 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 150 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm150.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm150,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm150,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm150,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm150_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testStructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: psalm150,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: psalm150,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSavePsalm150Themes() {
    guard let jsonString = utilities.generateCompleteThemesJSONString(
      psalmNumber: id.number,
      conceptualThemes: conceptualThemes,
      structuralThemes: structuralThemes
    ) else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm150_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
