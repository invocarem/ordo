@testable import LatinService
import XCTest

class Psalm125Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 125, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 8
  private let text = [
    "In convertendo Dominus captivitatem Sion: facti sumus sicut consolati.",
    "Tunc repletum est gaudio os nostrum: et lingua nostra exsultatione.",
    "Tunc dicent inter gentes: Magnificavit Dominus facere cum eis.",
    "Magnificavit Dominus facere nobiscum: facti sumus laetantes.",
    "Converte, Domine, captivitatem nostram: sicut torrens in austro.",
    "Qui seminant in lacrimis: in exsultatione metent.",
    "Euntes ibant et flebant: mittentes semina sua.",
    "Venientes autem venient cum exsultatione: portantes manipulos suos.",
  ]

  private let englishText = [
    "When the Lord brought back the captivity of Sion, we became like men comforted.",
    "Then was our mouth filled with gladness: and our tongue with joy.",
    "Then shall they say among the Gentiles: The Lord hath done great things for them.",
    "The Lord hath done great things for us: we are become joyful.",
    "Turn again our captivity, O Lord, as a stream in the south.",
    "They that sow in tears shall reap in joy.",
    "Going they went and wept, casting their seeds.",
    "But coming they shall come with joyfulness, carrying their sheaves.",
  ]

  private let lineKeyLemmas = [
    (1, ["converto", "dominus", "captivitas", "sion", "facio", "consolor"]),
    (2, ["tunc", "repleo", "gaudium", "os", "lingua", "exsultatio"]),
    (3, ["tunc", "dico", "inter", "gens", "magnifico", "dominus", "facio"]),
    (4, ["magnifico", "dominus", "facio", "laetor", "nos"]),
    (5, ["converto", "dominus", "captivitas", "torrens", "auster"]),
    (6, ["semino", "lacrima", "exsultatio", "meto"]),
    (7, ["eo", "fleo", "mitto", "semen"]),
    (8, ["venio", "exsultatio", "porto", "manipulus"]),
  ]

  private let structuralThemes = [
    (
      "Captivity → Awakening Joy",
      "The memory of Zion's rescue stirs joy — like the first movement of thawed waters after spiritual winter",
      ["converto", "captivitas", "sion", "consolor", "gaudium", "exsultatio", "os", "lingua"],
      1,
      2,
      "The memory of Zion's rescue stirs joy — like the first movement of thawed waters after spiritual winter",
      "Augustine sees this not as completed joy but as awakening — a slow, heavy movement like ice beginning to melt. The captivity echoes previous suffering (Ps. 123), and the joy is its emotional release, not final triumph. The Church sings here like spring begins: with hope (Enarr. Ps. 125.1–2)."
    ),
    (
      "Foreign Wonder → Internal Praise",
      "What others saw as God's greatness, Israel internalized with rejoicing",
      ["magnifico", "facio", "gens", "nos", "laetor"],
      3,
      4,
      "What others saw as God's greatness, Israel internalized with rejoicing",
      "Augustine sees two levels here: the nations observe God's greatness from the outside, while Israel experiences it intimately. Joy is not just public testimony, but personal transformation (Enarr. Ps. 125.3–4)."
    ),
    (
      "Dry Captivity → Rushing Mercy",
      "The soul prays for renewal like water returning to the desert — sorrowful sowing will yield joyful harvest",
      ["converto", "captivitas", "torrens", "auster", "semino", "lacrima", "meto", "exsultatio"],
      5,
      6,
      "The soul prays for renewal like water returning to the desert — sorrowful sowing will yield joyful harvest",
      "Augustine says the southern torrent is the soul thawing after captivity — slow, muddy, yet promising. Tears are the sowing of this moment; joy will be its reaping. This is not instant triumph, but grace gathering force underground (Enarr. Ps. 125.5–6)."
    ),
    (
      "Weeping → Rejoicing",
      "Those who go out weeping and sowing will return rejoicing with the fruit of endurance",
      ["eo", "fleo", "mitto", "semen", "venio", "exsultatio", "porto", "manipulus"],
      7,
      8,
      "Those who go out weeping and sowing will return rejoicing with the fruit of endurance",
      "Augustine sees the Church walking in tears now — sowing prayers and love in a world of sorrow. But the end is sure: the faithful will return bearing manipuli, the harvest of mercy and endurance. This is pilgrimage language — sorrow transformed by patience (Enarr. Ps. 125.7–8)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Restoration",
      "God's power to restore and bring back from captivity",
      ["converto", "captivitas", "dominus", "facio"],
      ThemeCategory.divine,
      1 ... 5
    ),
    (
      "Joy and Exultation",
      "The overwhelming joy that comes from God's restoration",
      ["gaudium", "exsultatio", "laetor", "magnifico"],
      ThemeCategory.worship,
      2 ... 4
    ),
    (
      "Agricultural Imagery",
      "Metaphors of sowing, reaping, and harvest in spiritual context",
      ["semino","semen", "lacrima", "meto", "manipulus", "torrens", "auster"],
      ThemeCategory.virtue,
      5 ... 8
    ),
    (
      "Movement and Journey",
      "The physical and spiritual journey from sorrow to joy",
      ["eo", "venio", "mitto", "porto", "fleo"],
      ThemeCategory.virtue,
      6 ... 8
    ),
    (
      "Divine Action",
      "God's active intervention in human affairs",
      ["dominus", "facio", "magnifico", "converto"],
      ThemeCategory.divine,
      1 ... 5
    ),
    (
      "Community and Testimony",
      "The collective response and proclamation of God's works",
      ["inter", "gens", "nos", "dico", "magnifico"],
      ThemeCategory.worship,
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
      text.count, expectedVerseCount, "Psalm 125 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 125 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm125_texts.json"
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
      filename: "output_psalm125_themes.json"
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
