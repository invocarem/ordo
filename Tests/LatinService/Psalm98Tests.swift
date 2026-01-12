// Psalm98Tests.swift
// LatinServiceTests
//
// Generated test for Psalm 98 – “The Lord’s Reign and Justice”
// This file follows the **psalm‑tests** specification.

@testable import LatinService
import XCTest

class Psalm98Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  // MARK: - Psalm Identity & Verse Count
  private let id = PsalmIdentity(number: 98, category: nil)
  private let expectedVerseCount = 10

  // MARK: - Latin Text
  private let text = [
    "Dominus regnavit, irascantur populi; qui sedet super cherubim, moveatur terra.",
    "Dominus in Sion magnus, et excelsus super omnes populos.",
    "Confiteantur nomini tuo magno, quoniam terribile et sanctum est.",
    "Et honor regis iudicium diligit. Tu parasti directiones; iudicium et iustitiam in Jacob tu fecisti.",
    "Exaltate Dominum Deum nostrum, et adorate scabellum pedum eius, quoniam sanctum est.",
    
    "Moyses et Aaron in sacerdotibus eius, et Samuel inter eos qui invocant nomen eius; ",
    "Invocabant Dominum, et ipse exaudiebat eos. In columna nubis loquebatur ad eos; ",
    "custodierunt testimonia eius, et praeceptum quod dedit illis.",
    "Domine Deus noster, tu exaudabas eos; Deus, tu propitius fuisti eis, et ulciscens in omnes adinventiones eorum.",
    "Exaltate Dominum Deum nostrum, et adorate in monte sancto eius, quoniam sanctus Dominus Deus noster."
  ]

  // MARK: - English Translation
  private let englishText = [
    "The Lord hath reigned, let the people be angry; he that sitteth above the cherubims, let the earth be moved.",
    "The Lord is great in Sion, and high above all people.",
    "Let them give praise to thy great name: for it is terrible and holy.",
    "And the king’s honour loveth judgment. Thou hast prepared directions: thou hast done judgment and justice in Jacob.",
    "Exalt ye the Lord our God, and adore his footstool, for it is holy.",
    
    "Moses and Aaron among his priests, and Samuel among them that call upon his name; ",
    "they called upon the Lord, and he heard them. He spoke to them in the pillar of the cloud; ",
    "they kept his testimonies, and the commandment which he gave them.",
    "O Lord our God, thou didst hear them: O God, thou wast propitious to them, and taking vengeance on all their inventions.",
    "Exalt ye the Lord our God, and adore at his holy mountain: for the Lord our God is holy."
  ]

  // MARK: - Key Lemmas per Verse (function words omitted)
  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["dominus", "regno", "irascor", "populus", "sedeo", "cherub", "moveo", "terra"]),
    (2, ["dominus", "sion", "magnus", "excelsus", "populus"]),
    (3, ["confiteor", "nomen", "magnus", "terribilis", "sanctus"]),
    (4, ["honor", "rex", "iudicium", "diligo", "paro", "directiones", "iustitia", "jacob", "facio"]),
    (5, ["exalto", "dominus", "deus", "noster", "adoro", "scabellum", "pes", "sanctus"]),
    (6, ["moyses", "aaron", "sacerdos", "samuel", "invoco", "nomen", "exaudio"]),
    (7, ["invoco", "dominus", "exaudio", "columna", "nubes", "loquor"]),
    (8, ["custodio", "testimonium", "praeceptum", "do"]),
    (9, ["dominus", "deus", "noster", "exaudio", "propitius", "ulciscor", "inventio"]),
    (10, ["exalto", "dominus", "deus", "noster", "adoro", "mons", "sanctus"])
  ]

  // MARK: - Structural Themes (pairs, final triple)
  private let structuralThemes = [
    (
      "Reign → Majesty",
      "The Lord’s sovereign rule is proclaimed and the earth responds.",
      ["dominus", "regno", "irascor", "populus", "sedeo", "cherub", "moveo", "terra"],
      1,
      2,
      "The Lord’s sovereign rule is proclaimed and the earth responds.",
      "Augustine sees the opening verses as a cosmic proclamation of divine kingship, where the Lord’s reign over the heavens causes the earth to tremble (Enarr. Ps. 98.1‑2)."
    ),
    (
      "Praise → Greatness",
      "The people are called to bless the Lord’s great name and acknowledge His holiness.",
      ["confiteor", "nomen", "magnus", "terribilis", "sanctus"],
      3,
      4,
      "The people are called to bless the Lord’s great name and acknowledge His holiness.",
      "Augustine interprets the shift to worship as an acknowledgement that the Lord’s greatness is inseparable from His just judgment (Enarr. Ps. 98.3‑4)."
    ),
    (
      "Worship → Covenant",
      "The community lifts the Lord on the footstool and remembers the covenant with Israel.",
      ["exalto", "adoro", "scabellum", "pes", "sanctus", "moyses", "aaron", "sacerdos", "samuel", "invoco", "exaudio"],
      5,
      6,
      "The community lifts the Lord on the footstool and remembers the covenant with Israel.",
      "Augustine links the act of adoration with the historic covenantal figures who mediated God’s law (Enarr. Ps. 98.5‑6)."
    ),
    (
      "Divine Guidance → Vengeance",
      "God speaks through the cloud, gives commandments, hears the faithful, and enacts righteous vengeance.",
      ["columna", "nubes", "loquor", "custodio", "testimonium", "praeceptum", "exaudio"],
      7,
      8,
      "God speaks through the cloud, gives commandments, hears the faithful, and enacts righteous vengeance.",
      "Augustine reads the closing three verses as the culmination of divine guidance, mercy, and just retribution toward the wicked (Enarr. Ps. 98.7‑9)."
    ),
    (
      "Divine Guidance → Vengeance",
      "God speaks through the cloud, gives commandments, hears the faithful, and enacts righteous vengeance.",
      ["domine", "exaudio", "propitius", "ulciscor", "inventio"],
      9,
      10,
      "God speaks through the cloud, gives commandments, hears the faithful, and enacts righteous vengeance.",
      "Augustine reads the closing three verses as the culmination of divine guidance, mercy, and just retribution toward the wicked (Enarr. Ps. 98.7‑9)."
    )
  ]

  // MARK: - Conceptual Themes (throughout the psalm)
  private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = [
    (
      "Divine Sovereignty",
      "The Lord’s supreme reign over heaven and earth.",
      ["dominus", "regno", "magnus", "excelsus"],
      .divine,
      nil
    ),
    (
      "Divine Justice",
      "Judgment, direction, and righteousness granted to Jacob.",
      ["iudicium", "directiones", "iustitia", "jacob"],
      .justice,
      3 ... 4
    ),
    (
      "Worship & Praise",
      "Exalting God, adoring the footstool, and praising His holy name.",
      ["exalto", "adoro", "nomen", "sanctus"],
      .worship,
      5 ... 6
    ),
    (
      "Covenantal Mediation",
      "Moses, Aaron, and Samuel as mediators of the divine law.",
      ["moyses", "aaron", "samuel", "sacerdos", "testimonium", "praeceptum"],
      .virtue,
      6 ... 6
    ),
    (
      "Divine Guidance",
      "God’s voice through the cloud and the pillar of fire.",
      ["columna", "nubes", "loquor", "praeceptum"],
      .divine,
      7 ... 7
    ),
    (
      "Divine Vengeance",
      "God’s propitiousness and retribution against the wicked’s inventions.",
      ["propitius", "ulciscor", "inventio"],
      .justice,
      8 ... 8
    ),
    (
      "Holiness of God",
      "The Lord is declared holy throughout the psalm.",
      ["sanctus", "sanctus"],
      .opposition,
      nil
    )
  ]

  // MARK: - Tests

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount,
                   "Psalm 98 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount,
                   "Psalm 98 English text should have \(expectedVerseCount) verses")
    // Validate orthography
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(normalized, text,
                   "Normalized Latin text should match expected classical forms")
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
    // Verify structural theme lemmas are present in lineKeyLemmas
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyFlat,
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
    // Verify conceptual theme lemmas are present in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false // conceptual themes may include extra imagery
    )

    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveThemes() {
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
      filename: "output_psalm98_themes.json"
    )
    if success { print("✅ Themes JSON saved") } else { print("⚠️ Failed to save themes JSON") }
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
      filename: "output_psalm98_texts.json"
    )
    if success { print("✅ Texts JSON saved") } else { print("⚠️ Failed to save texts JSON") }
  }
}
