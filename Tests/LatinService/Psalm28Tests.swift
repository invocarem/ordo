@testable import LatinService
import XCTest

class Psalm28Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 28, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 10
  private let text = [
    "Afferte Domino, filii Dei, afferte Domino filios arietum.",
    "Afferte Domino gloriam et honorem, afferte Domino gloriam nomini eius: adorate Dominum in atrio sancto eius.",
    "Vox Domini super aquas, Deus maiestatis intonuit: Dominus super aquas multas.",
    "Vox Domini in virtute, vox Domini in magnificentia.",
    "Vox Domini confringentis cedros: et confringet Dominus cedros Libani.",
    "Et comminuet eas tamquam vitulum Libani: et dilectus quemadmodum filius unicornium.", /* 6 */
    "Vox Domini intercidentis flammam ignis. Vox Domini concutientis desertum: et commovebit Dominus desertum Cades.",
    "Vox Domini praeparantis cervos, et revelabit condensa: et in templo eius omnes dicent gloriam.",
    "Dominus diluvium inhabitare facit: et sedebit Dominus rex in aeternum.",
    "Dominus virtutem populo suo dabit: Dominus benedicet populo suo in pace.",
  ]

  private let englishText = [
    "Bring to the Lord, O ye children of God; bring to the Lord the offspring of rams.",
    "Bring to the Lord glory and honour; bring to the Lord glory to his name; adore ye the Lord in his holy court.",
    "The voice of the Lord is upon the waters; the God of majesty hath thundered; the Lord is upon many waters.",
    "The voice of the Lord is in power; the voice of the Lord in magnificence.",
    "The voice of the Lord breaketh the cedars; yea, the Lord shall break the cedars of Libanus.",
    "And shall reduce them to pieces, as a calf of Libanus, and as the beloved son of unicorns.",
    "The voice of the Lord divideth the flame of fire. The voice of the Lord shaketh the desert; and the Lord shall shake the desert of Cades.",
    "The voice of the Lord prepareth the stags, and he will discover the thick woods; and in his temple all shall speak his glory.",
    "The Lord maketh the flood to dwell; and the Lord shall sit king for ever.",
    "The Lord will give strength to his people; the Lord will bless his people with peace.",
  ]

  private let lineKeyLemmas = [
    (1, ["affero", "dominus", "filius", "deus", "aries"]),
    (2, ["affero", "dominus", "gloria", "honor", "nomen", "adoro", "atrium", "sanctus"]),
    (3, ["vox", "dominus", "super", "aqua", "deus", "maiestas", "intono", "dominus", "multus"]),
    (4, ["vox", "dominus", "virtus", "vox", "dominus", "magnificentia"]),
    (5, ["vox", "dominus", "confringo", "cedrus", "dominus", "confringo", "cedrus", "libanus"]),
    (6, ["comminuo", "vitulus", "libanus", "dilectus", "filius", "unicornis"]),
    (7, ["vox", "dominus", "intercido", "flamma", "ignis", "concutio", "desertum", "commoveo", "cades"]),
    (8, ["vox", "dominus", "praeparo", "cervus", "revelo", "condensus", "templum", "dico", "gloria"]),
    (9, ["dominus", "diluvium", "inhabito", "facio", "sedeo", "dominus", "rex", "aeternum"]),
    (10, ["dominus", "virtus", "populus", "do", "dominus", "benedico", "populus", "pax"]),
  ]

  private let structuralThemes = [
    (
      "Call to Worship → Divine Honor",
      "Summons to bring offerings and honor to God in His holy court",
      ["affero", "dominus", "gloria", "honor", "adoro", "atrium", "sanctus"],
      1,
      2,
      "The psalm opens with a call to bring offerings and honor to the Lord, culminating in worship in His holy court.",
      "Augustine sees this as the soul's fundamental duty to offer spiritual sacrifices of praise and honor to God, approaching Him in the holiness He requires."
    ),
    (
      "Voice of Majesty → Power and Magnificence",
      "The thunderous voice of the Lord over the waters, demonstrating power and magnificence",
      ["vox", "dominus", "aqua", "maiestas", "intono", "virtus", "magnificentia"],
      3,
      4,
      "The voice of the Lord thunders over the waters, demonstrating God's majestic power and magnificence.",
      "For Augustine, this represents God's authoritative word that governs creation and reveals His sovereign power to those who have ears to hear."
    ),
    (
      "Breaking Cedars → Reducing to Pieces",
      "The voice of the Lord breaking mighty cedars and reducing them like a calf",
      ["vox", "dominus", "confringo", "cedrus", "comminuo", "vitulus", "dilectus"],
      5,
      6,
      "The Lord's voice breaks the mighty cedars of Lebanon and reduces them to pieces like a young calf.",
      "Augustine interprets this as God's power to humble the proud and mighty, breaking down human arrogance and reducing it to humility before Him."
    ),
    (
      "Dividing Fire → Preparing Stags",
      "The voice that divides flames of fire and shakes the desert, then prepares stags and reveals thick woods",
      ["vox", "dominus", "intercido", "flamma", "concutio", "desertum", "commoveo", "praeparo", "cervus", "revelo", "condensus", "templum", "gloria"],
      7,
      8,
      "The Lord's voice divides the flame of fire and shakes the desert of Cades, then prepares the stags and reveals the thick woods while in His temple all speak His glory.",
      "This signifies for Augustine God's ability to purify through fire and shake the barren places of the soul, while also preparing His people and revealing hidden truths, culminating in worship of the King."
    ),
    (
      "Eternal Kingship → Divine Blessing",
      "The Lord making the flood to dwell and sitting as king forever, then giving strength and peace to His people",
      ["dominus", "diluvium", "inhabito", "facio", "sedeo", "rex", "aeternum", "virtus", "populus", "do", "benedico", "pax"],
      9,
      10,
      "The Lord makes the flood to dwell and sits as king forever, giving strength to His people and blessing them with peace.",
      "For Augustine, this represents God's eternal sovereignty and His providential control over all creation, reigning as the eternal King who strengthens and blesses His people with divine peace."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Voice",
      "References to the power and effects of God's voice",
      ["vox", "dominus", "intono", "confringo", "intercido", "concutio", "praeparo"],
      ThemeCategory.divine,
      3 ... 9
    ),
    (
      "Worship and Offering",
      "Acts of worship, offering, and adoration to God",
      ["affero", "gloria", "honor", "adoro", "templum", "benedico"],
      ThemeCategory.worship,
      1 ... 10
    ),
    (
      "Nature Imagery",
      "References to natural elements demonstrating God's power",
      ["aqua", "cedrus", "libanus", "flamma", "desertum", "cervus", "condensus", "diluvium"],
      ThemeCategory.unknown,
      3 ... 10
    ),
    (
      "Divine Sovereignty",
      "God's eternal kingship and rule over creation",
      ["dominus", "rex", "aeternum", "virtus", "populus", "pax"],
      ThemeCategory.divine,
      3 ... 10
    ),
    (
      "Power and Strength",
      "Expressions of divine power and the strength given to God's people",
      ["virtus", "magnificentia", "confringo", "comminuo", "concutio"],
      ThemeCategory.divine,
      4 ... 10
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 28 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 28 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm28_texts.json"
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
      filename: "output_psalm28_themes.json"
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
