@testable import LatinService
import XCTest

class Psalm92Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 92, category: nil)
  private let expectedVerseCount = 6

  // MARK: - Test Data

  private let text = [
    "Dominus regnavit, decorem indutus est; indutus est Dominus fortitudinem, et praecinxit se.",
    "Etenim firmavit orbem terrae, qui non commovebitur.",
    "Parata sedes tua ex tunc; a saeculo tu es.",
    "Elevaverunt flumina, Domine, elevaverunt flumina vocem suam; ",
    "Elevaverunt flumina fluctus suos, a vocibus aquarum multarum",
    
    "Mirabiles elationes maris; mirabilis in altis Dominus.",
    "Testimonia tua credibilia facta sunt nimis; domum tuam decet sanctitudo, Domine, in longitudinem dierum."
  ]

  private let englishText = [
    "The Lord hath reigned, he is clothed with beauty; the Lord is clothed with strength, and hath girded himself.",
    "For he hath established the world which shall not be moved.",
    "Thy throne is prepared from of old; thou art from everlasting.",
    "The floods have lifted up, O Lord, the floods have lifted up their voice;",
    "The floods have lifted up their waves, above the voices of many waters",
   
    "the wonderful surges of the sea; the Lord is wonderful on high.",
    "Thy testimonies are become exceedingly credible; holiness becometh thy house, O Lord, unto length of days."
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "regno", "decor", "induō", "fortitudo", "praecingo"]),
    (2, ["firmo", "orbis", "terra", "commoveo"]),
    (3, ["paratus", "sedes", "saeculum"]),
    (4, ["elevo", "flumen", "vox", "fluctus"]),
    (5, ["vox", "aqua", "multus", "mirabilis" ]),
    (6, ["mirabilis", "elatio", "mare", "altus", "dominus"]),
    (7, ["testimonium", "credibilis", "facio", "nimis", "domus", "decet", "sanctitas", "longitudo", "dies"]),
  ]

  private let structuralThemes = [
    (
      "Royal Enthronement → Cosmic Stability",
      "From God's kingly attire to the unshakable foundation of creation",
      ["regno", "induō", "decor", "fortitudo", "firmo", "orbis", "terra"],
      1,
      2,
      "The Lord is crowned with beauty and strength, establishing the world as an immovable foundation.",
      "Augustine sees the 'beauty' as grace and 'strength' as power in governing creation (Enarr. Ps. 92.1–2)."
    ),
    (
      "Eternal Throne → Chaotic Waters",
      "From everlasting sovereignty to the tumult of creation's waters",
      ["sedes", "saeculum", "elevo", "flumen", "vox", "fluctus"],
      3,
      4,
      "God's throne stands from eternity, while the floods raise their voices and waves.",
      "Augustine interprets the floods as chaotic forces that roar against God, yet His throne remains eternal (Enarr. Ps. 92.3–4)."
    ),
    (
      "Divine Wonder → Sacred Testimony",
      "From God's majesty above the waters to the credibility of His holy house",
      ["mirabilis", "aqua", "mare", "altus", "testimonium", "credibilis", "sanctitas", "domus"],
      5,
      6,
      "The Lord is wonderful above the tumultuous sea, and His testimonies are supremely credible.",
      "Augustine reads the 'wonderful' Lord as transcendent over all chaos, while the 'credible testimonies' point to Scripture (Enarr. Ps. 92.5–6)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "God's eternal kingship and throne",
      ["dominus", "regno", "sedes", "saeculum"],
      ThemeCategory.divine,
      1 ... 3
    ),
    (
      "Divine Majesty",
      "God's beauty, strength, and wonder",
      ["decor", "fortitudo", "mirabilis", "altus"],
      ThemeCategory.divine,
      1 ... 5
    ),
    (
      "Cosmic Order",
      "The established and unshakable world",
      ["firmo", "orbis", "terra", "commoveo"],
      ThemeCategory.divine,
      2 ... 2
    ),
    (
      "Creation's Chaos",
      "The tumultuous waters and floods",
      ["flumen", "vox", "fluctus", "aqua", "mare", "elatio"],
      ThemeCategory.conflict,
      4 ... 5
    ),
    (
      "Divine Testimony",
      "The credible and holy word of God",
      ["testimonium", "credibilis", "facio"],
      ThemeCategory.worship,
      6 ... 6
    ),
    (
      "Sacred Worship",
      "Holiness that befits God's house",
      ["sanctitas", "domus", "decet", "longitudo", "dies"],
      ThemeCategory.worship,
      6 ... 6
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 92 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 92 English text should have \(expectedVerseCount) verses")
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
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false
    )

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
      filename: "output_psalm92_themes.json"
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
      filename: "output_psalm92_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
