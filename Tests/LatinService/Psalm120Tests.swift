@testable import LatinService
import XCTest

class Psalm120Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private var latinService: LatinService!
  let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  let id = PsalmIdentity(number: 120, category: nil)
  private let expectedVerseCount = 8

  // MARK: - Test Data

  let psalm120 = [
    "Levavi oculos meos in montes, unde veniet auxilium mihi.",
    "Auxilium meum a Domino, qui fecit caelum et terram.",
    "Non det in commotionem pedem tuum, neque dormitet qui custodit te.",
    "Ecce non dormitabit neque dormiet, qui custodit Israel.",
    "Dominus custodit te; Dominus protectio tua super manum dexteram tuam.",
    "Per diem sol non uret te, neque luna per noctem.",
    "Dominus custodit te ab omni malo; custodiat animam tuam Dominus.",
    "Dominus custodiat introitum tuum et exitum tuum, ex hoc nunc et usque in saeculum",
  ]

  private let englishText = [
    "I have lifted up mine eyes to the mountains, from whence help shall come to me.",
    "My help is from the Lord, who made heaven and earth.",
    "May he not suffer thy foot to be moved: neither let him slumber that keepeth thee.",
    "Behold he shall neither slumber nor sleep, that keepeth Israel.",
    "The Lord keepeth thee, the Lord is thy protection, upon thy right hand.",
    "The sun shall not burn thee by day: nor the moon by night.",
    "The Lord keepeth thee from all evil: may the Lord keep thy soul.",
    "The Lord keep thy coming in and thy going out, from henceforth now and for ever",
  ]

  private let lineKeyLemmas = [
    (1, ["levo", "oculus", "mons", "unde", "venio", "auxilium"]),
    (2, ["auxilium", "dominus", "qui", "facio", "caelum", "terra"]),
    (3, ["non", "do", "commotio", "pes", "neque", "dormito", "custodio"]),
    (4, ["ecce", "non", "dormito", "neque", "dormio", "custodio", "israel"]),
    (5, ["dominus", "custodio", "protectio", "super", "manus", "dexter"]),
    (6, ["per", "dies", "sol", "non", "uro", "neque", "luna", "nox"]),
    (7, ["dominus", "custodio", "a", "omnis", "malus", "anima"]),
    (8, ["dominus", "custodio", "introitus", "exitus", "ex", "hic", "nunc", "usque", "saeculum"]),
  ]

  private let structuralThemes = [
    (
      "Seeking → Assurance",
      "From looking to mountains for help to finding assurance in the Lord",
      ["levo", "oculus", "mons", "auxilium", "dominus", "facio"],
      1,
      2,
      "The psalmist lifts his eyes to the mountains seeking help, but finds that his true help comes from the Lord who made heaven and earth.",
      "Augustine sees this as the soul's natural inclination to seek help from created things (mountains) before recognizing that all help ultimately comes from the Creator. The movement from created to Creator marks the beginning of true faith (Enarr. Ps. 120.1–2)."
    ),
    (
      "Vigilance → Protection",
      "From the promise of divine watchfulness to comprehensive protection",
      ["dormito", "custodio", "israel", "protectio", "manus"],
      3,
      5,
      "The Lord who keeps Israel neither slumbers nor sleeps, providing protection over the right hand of the faithful.",
      "Augustine interprets this as God's constant vigilance over His people. The 'right hand' represents the active power of divine protection, while the sleepless guardian symbolizes God's eternal care that never fails (Enarr. Ps. 120.3–5)."
    ),
    (
      "Elements → Preservation",
      "From natural dangers to divine preservation from all harm",
      ["sol", "luna", "nox", "malus", "custodio", "anima"],
      6,
      7,
      "Neither sun by day nor moon by night will harm the protected one, for the Lord keeps from all evil and preserves the soul.",
      "Augustine sees this as God's power over creation itself - the very elements that could cause harm become instruments of His protective care. The preservation of the soul (anima) represents the ultimate spiritual protection (Enarr. Ps. 120.6–7)."
    ),
    (
      "Journey → Eternity",
      "From temporal comings and goings to eternal divine accompaniment",
      ["introitus", "exitus", "custodio", "hic", "nunc", "usque", "saeculum"],
      8,
      8,
      "The Lord will keep the going out and coming in from this time forth and forevermore.",
      "Augustine interprets this final verse as the comprehensive scope of divine protection - from the present moment (hic nunc) to eternity (usque in saeculum). Every movement of life is under God's watchful care (Enarr. Ps. 120.8)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Human Body Imagery",
      "References to physical body parts representing spiritual experience",
      ["oculus", "pes", "manus", "anima"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Celestial Imagery",
      "Heavenly and earthly elements representing divine power and protection",
      ["sol", "luna", "caelum", "terra", "mons"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Protection Verbs",
      "Verbs describing divine guardianship and care",
      ["custodio", "dormito", "dormio", "uro"],
      ThemeCategory.virtue,
      3 ... 7
    ),
    (
      "Movement Imagery",
      "Verbs and nouns describing physical and spiritual movement",
      ["levo", "venio", "introitus", "exitus"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Divine Attributes",
      "Terms describing God's nature and relationship to creation",
      ["dominus", "auxilium", "protectio", "israel"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Temporal References",
      "Words indicating time and duration of divine care",
      ["dies", "nox", "hic", "nunc", "usque", "saeculum"],
      ThemeCategory.divine,
      6 ... 8
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      psalm120.count, expectedVerseCount, "Psalm 120 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 120 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm120.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm120,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm120,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
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
      psalmText: psalm120,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    // First, verify that conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false // Conceptual themes may have additional imagery lemmas
    )

    // Then run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: psalm120,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Save JSON Methods

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm120,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm120_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
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
      filename: "output_psalm120_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
