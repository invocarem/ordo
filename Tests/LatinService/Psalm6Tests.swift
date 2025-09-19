@testable import LatinService
import XCTest

class Psalm6Tests: XCTestCase {
  private var latinService: LatinService!
  private let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  let id = PsalmIdentity(number: 6, category: nil)

  // MARK: - Test Data

  private let psalm6 = [
    "Domine, ne in furore tuo arguas me, neque in ira tua corripias me.",
    "Miserere mei, Domine, quoniam infirmus sum; sana me, Domine, quoniam conturbata sunt ossa mea.",
    "Et anima mea turbata est valde; sed tu, Domine, usquequo?",
    "Convertere, Domine, et eripe animam meam; salvum me fac propter misericordiam tuam.",
    "Quoniam non est in morte qui memor sit tui; in inferno autem quis confitebitur tibi?",
    "Laboravi in gemitu meo, lavabo per singulas noctes lectum meum; lacrimis meis stratum meum rigabo.",
    "Turbatus est a furore oculus meus; inveteravi inter omnes inimicos meos.",
    "Discedite a me, omnes qui operamini iniquitatem, quoniam exaudivit Dominus vocem fletus mei.",
    "Exaudivit Dominus deprecationem meam; Dominus orationem meam suscepit.",
    "Erubescant et conturbentur vehementer omnes inimici mei; convertantur et erubescant valde velociter.",
  ]

  private let englishText = [
    "O Lord, rebuke me not in thy indignation, nor chastise me in thy wrath.",
    "Have mercy on me, O Lord, for I am weak; heal me, O Lord, for my bones are troubled.",
    "And my soul is troubled exceedingly; but thou, O Lord, how long?",
    "Turn to me, O Lord, and deliver my soul; O save me for thy mercy's sake.",
    "For there is no one in death that is mindful of thee: and who shall confess to thee in hell?",
    "I have laboured in my groanings, every night I will wash my bed: I will water my couch with my tears.",
    "My eye is troubled through indignation: I have grown old amongst all my enemies.",
    "Depart from me, all ye workers of iniquity: for the Lord hath heard the voice of my weeping.",
    "The Lord hath heard my supplication: the Lord hath received my prayer.",
    "Let all my enemies be ashamed, and be very much troubled: let them be turned back, and be ashamed very speedily.",
  ]

  private let expectedVerseCount = 10

  private let lineKeyLemmas = [
    (1, ["dominus", "furor", "arguo", "ira", "corripio"]),
    (2, ["misereor", "dominus", "infirmus", "sum", "sano", "conturbo", "os"]),
    (3, ["anima", "turbo", "dominus", "usquequo"]),
    (4, ["converto", "dominus", "eripio", "anima", "salvus", "facio", "misericordia"]),
    (5, ["mors", "memor", "infernus", "confiteor"]),
    (6, ["laboro", "gemitus", "lavo", "nox", "lectus", "lacrima", "stratum", "rigo"]),
    (7, ["turbo", "furor", "oculus", "invetero", "inimicus"]),
    (8, ["discedo", "operor", "iniquitas", "exaudio", "dominus", "vox", "fletus"]),
    (9, ["exaudio", "dominus", "deprecatio", "oratio", "suscipio"]),
    (10, ["erubesco", "conturbo", "inimicus", "converto", "velox"]),
  ]

  private let structuralThemes = [
    (
      "Wrath → Mercy",
      "From divine anger to a plea for healing compassion",
      ["furor", "arguo", "corripio", "infirmus"],
      1,
      2,
      "The psalmist appeals to God not as a just judge but as a merciful physician. Weakness, both bodily and spiritual, is openly confessed.",
      "Augustine interprets the chastisement ('arguas… corripias') not as condemnation but as medicinal correction, so that frailty may be healed by divine mercy (Enarr. Ps. 6.1–2)."
    ),
    (
      "Agitation → Rescue",
      "From inner turmoil to divine salvation",
      ["turbo", "converto", "eripio", "misericordia"],
      3,
      4,
      "The psalmist cries out from deep turmoil, pleading for rescue grounded not in merit but in mercy.",
      "For Augustine, the soul's turbulence is stilled only by God turning toward it; salvation rests entirely on the mercy of the Lord (Enarr. Ps. 6.3–4)."
    ),
    (
      "Mortality → Tears",
      "From the silence of death to sorrowful intercession",
      ["mors", "infernus", "confiteor", "lacrima"],
      5,
      6,
      "Death is a place of silence where no one confesses God; the psalmist therefore pours out tears in prayer while still alive.",
      "Augustine sees these tears as compunction, watering the soul like a field, preparing it for renewal by God (Enarr. Ps. 6.5–6)."
    ),
    (
      "Weariness → Hearing",
      "From exhaustion under oppression to God hearing the cry",
      ["inimicus", "invetero", "fletus", "exaudio"],
      7,
      8,
      "Weary and worn down among enemies, the psalmist clings to hope because the Lord hears his weeping.",
      "Augustine emphasizes that God's hearing ('exaudivit') shows His closeness to the contrite heart, even amid human hostility (Enarr. Ps. 6.7–8)."
    ),
    (
      "Prayer → Reversal",
      "From received prayer to the shame and retreat of enemies",
      ["oratio", "suscipio", "erubesco", "inimicus"],
      9,
      10,
      "The psalmist's prayer is not only heard but embraced; enemies are overturned in shame and confusion.",
      "Augustine highlights the reversal: the psalmist is lifted up ('suscepit'), while enemies are cast down in sudden shame ('erubescant valde velociter')—a figure of the final judgment (Enarr. Ps. 6.9–10)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Mercy",
      "God's compassionate response to human weakness and suffering",
      ["misereor", "misericordia", "sano", "salvus", "eripio"],
      ThemeCategory.divine,
      1 ... 10
    ),
    (
      "Penitential Suffering",
      "Physical and spiritual affliction leading to repentance",
      ["infirmus", "conturbo", "turbo", "laboro", "lacrima", "fletus", "gemitus"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Divine Hearing",
      "God's attentive response to prayer and supplication",
      ["exaudio", "suscipio", "deprecatio", "oratio", "vox"],
      ThemeCategory.divine,
      8 ... 10
    ),
    (
      "Enemy Opposition",
      "Hostile forces and workers of iniquity",
      ["inimicus", "iniquitas", "operor", "erubesco", "discedo"],
      ThemeCategory.opposition,
      7 ... 10
    ),
    (
      "Mortality and Death",
      "The reality of death and the silence of the grave",
      ["mors", "infernus", "memor", "confiteor"],
      ThemeCategory.virtue,
      5 ... 5
    ),
    (
      "Divine Wrath and Chastisement",
      "God's righteous anger and corrective discipline",
      ["furor", "ira", "arguo", "corripio"],
      ThemeCategory.divine,
      1 ... 2
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      psalm6.count, expectedVerseCount, "Psalm 6 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 6 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm6.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm6,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas() {
    let utilities = PsalmTestUtilities.self
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm6,
      lineKeyLemmas: lineKeyLemmas,
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
      psalmText: psalm6,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSavePsalm6Themes() {
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
      filename: "output_psalm6_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm6,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm6_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
