@testable import LatinService
import XCTest

class Psalm124Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 124, category: "")

  let psalm124 = [
    "Qui confidunt in Domino, sicut mons Sion: non commovebitur in aeternum, qui habitat in Ierusalem.",
    "Montes in circuitu eius, et Dominus in circuitu populi sui, ex hoc nunc et usque in saeculum.",
    "Quia non relinquet Dominus virgam peccatorum super sortem iustorum, ut non extendant iusti ad iniquitatem manus suas.",
    "Benefac, Domine, bonis, et rectis corde.",
    "Declinantes autem in obligationes, adducet Dominus cum operantibus iniquitatem. Pax super Israel!",
  ]

  private let englishText = [
    "They that trust in the Lord shall be as mount Sion: he shall not be moved for ever that dwelleth in Jerusalem.",
    "Mountains are round about it: so the Lord is round about his people from henceforth now and for ever.",
    "For the Lord will not leave the rod of sinners upon the lot of the just: that the just may not stretch forth their hands to iniquity.",
    "Do good, O Lord, to those that are good, and to the upright of heart.",
    "But such as turn aside into bonds, the Lord shall lead out with the workers of iniquity: peace upon Israel.",
  ]

  private let lineKeyLemmas = [
    (1, ["confido", "dominus", "mons", "sion", "commoveo", "aeternus", "habito", "ierusalem"]),
    (2, ["mons", "circuitus", "dominus", "populus", "nunc", "saeculum"]),
    (3, ["relinquo", "dominus", "virga", "peccator", "sors", "iustus", "extendo", "iniquitas", "manus"]),
    (4, ["benefacio", "dominus", "bonus", "rectus", "cor"]),
    (5, ["declino", "obligatio", "adduco", "dominus", "opero", "iniquitas", "pax", "israel"]),
  ]

  private let structuralThemes = [
    (
      "Escaped → Dweller",
      "The soul transitions from being a rescued fugitive to a secure dweller in God's city",
      ["confido", "mons", "habito", "circuitus", "ierusalem"],
      1,
      2,
      "Augustine contrasts this with Psalm 123: the 'sparrow' (passer) freed from the snare now 'dwells' (habito) in Jerusalem. The 'mountain' (mons) is not geographic Zion but the soul's new stability in God. Divine encirclement (circuitus) replaces the broken snare (Enarr. Ps. 124.2–3).",
      "The soul transitions from being a rescued fugitive to a secure dweller in God's city"
    ),
    (
      "Shielded → Blessed",
      "From potential domination by the wicked to divine protection and blessing",
      ["relinquo", "virga", "benefacio", "rectus"],
      3,
      4,
      "Augustine: God actively withholds the wicked's rod ('non relinquet') to preserve the righteous, then commands blessing ('Benefac') for the upright—not based on merit but grace (Enarr. Ps. 124.5-6).",
      "From potential domination by the wicked to divine protection and blessing"
    ),
    (
      "Bending → Peace",
      "Those inclining toward sin are removed, while peace is declared",
      ["declino", "obligatio", "pax", "israel"],
      5,
      5,
      "Augustine: The 'Declinantes' follow their trajectory into sin, while 'Pax super Israel' is God's final word—a declarative gift mirroring the Church's eschatological hope (Enarr. Ps. 124.8).",
      "Those inclining toward sin are removed, while peace is declared"
    ),
  ]

  private let conceptualThemes = [
    // IMAGERY THEMES
    (
      "Mountain Imagery",
      "Symbolic representation of stability and divine protection through geological metaphors",
      ["mons", "sion", "circuitus"],
      ThemeCategory.virtue,
      1 ... 2
    ),
    (
      "Urban Dwelling Imagery",
      "Metaphors of city life, habitation, and permanent residence",
      ["habito", "ierusalem", "populus"],
      ThemeCategory.virtue,
      1 ... 2
    ),
    (
      "Agricultural/Shepherding Imagery",
      "Rural metaphors of farming, shepherding, and cultivation",
      ["virga", "sors", "manus", "extendo"],
      ThemeCategory.justice,
      3 ... 3
    ),
    (
      "Anatomical Imagery",
      "Body parts and physical attributes representing moral states",
      ["cor", "manus", "rectus"],
      ThemeCategory.virtue,
      3 ... 4
    ),
    (
      "Bondage and Liberation Imagery",
      "Metaphors of chains, bonds, and freedom from constraint",
      ["obligatio", "adduco", "opero"],
      ThemeCategory.sin,
      5 ... 5
    ),
    (
      "Peace and Blessing Imagery",
      "Terms representing divine favor, tranquility, and national blessing",
      ["pax", "israel", "benefacio", "bonus"],
      ThemeCategory.virtue,
      4 ... 5
    ),
    // THEMATIC CATEGORIES
    (
      "Trust and Faith Vocabulary",
      "Terms expressing confidence, reliance, and spiritual stability",
      ["confido", "commoveo", "aeternus"],
      ThemeCategory.virtue,
      1 ... 1
    ),
    (
      "Divine Protection Terms",
      "Vocabulary of God's safeguarding and providential care",
      ["circuitus", "relinquo", "benefacio", "adduco"],
      ThemeCategory.virtue,
      1 ... 5
    ),
    (
      "Moral Categories",
      "Distinction between righteous and wicked behavior patterns",
      ["iustus", "peccator", "bonus", "rectus", "iniquitas"],
      ThemeCategory.virtue,
      3 ... 5
    ),
    (
      "Temporal and Eternal Terms",
      "Vocabulary expressing time, duration, and permanence",
      ["aeternus", "nunc", "saeculum"],
      ThemeCategory.virtue,
      1 ... 2
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    let expectedVerseCount = 5
    XCTAssertEqual(
      psalm124.count, expectedVerseCount, "Psalm 124 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 124 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm124.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm124,
      "Normalized Latin text should match expected classical forms"
    )
  }

  // MARK: - Line by Line Key Lemmas Test

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm124,
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
      psalmText: psalm124,
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
      psalmText: psalm124,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm124,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm124_texts.json"
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
      filename: "output_psalm124_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
