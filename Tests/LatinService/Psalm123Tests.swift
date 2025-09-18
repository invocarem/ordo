@testable import LatinService
import XCTest

class Psalm123Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private var latinService: LatinService!
  let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  let id = PsalmIdentity(number: 123, category: nil)
  private let expectedVerseCount = 8

  let psalm123 = [
    "Nisi quia Dominus erat in nobis, dicat nunc Israel; nisi quia Dominus erat in nobis",
    "Cum exsurgerent homines in nos, forsitan vivos deglutissent nos.",
    "Cum irasceretur furor eorum in nos, forsitan aqua absorbuisset nos.",
    "Torrentem pertransivit anima nostra; forsitan pertransisset anima nostra aquam intolerabilem.",

    "Benedictus Dominus, qui non dedit nos in captionem dentibus eorum.",
    "Anima nostra sicut passer erepta est de laqueo venantium;",
    "Laqueus contritus est, et nos liberati sumus.",
    "Adiutorium nostrum in nomine Domini, qui fecit caelum et terram.",
  ]

  private let englishText = [
    "If the Lord had not been on our side, let Israel now say; if the Lord had not been on our side,",
    "when men rose up against us, they would have swallowed us alive.",
    "When their fury was enkindled against us, the waters would have overwhelmed us.",
    "Our soul has passed through the torrent; our soul would have passed through the overwhelming water.",

    "Blessed be the Lord, who has not given us as prey to their teeth.",
    "Our soul has been delivered like a sparrow out of the fowler's snare;",
    "the snare is broken, and we are delivered.",
    "Our help is in the name of the Lord, who made heaven and earth.",
  ]

  private let lineKeyLemmas = [
    (1, ["nisi", "quia", "dominus", "sum", "in", "nos", "dico", "nunc", "israel"]),
    (2, ["cum", "exsurgo", "homo", "in", "nos", "forsitan", "vivus", "deglutio"]),
    (3, ["cum", "irascor", "furor", "is", "in", "nos", "forsitan", "aqua", "absorbeo"]),
    (4, ["torrens", "pertransio", "anima", "noster", "forsitan", "pertransio", "anima", "noster", "aqua", "intolerabilis"]),
    (5, ["benedictus", "dominus", "qui", "non", "do", "nos", "in", "captio", "dens", "is"]),
    (6, ["anima", "noster", "sicut", "passer", "ereptus", "de", "laqueus", "venator"]),
    (7, ["laqueus", "contritus", "et", "nos", "libero"]),
    (8, ["adiutorium", "noster", "in", "nomen", "dominus", "qui", "facio", "caelum", "et", "terra"]),
  ]

  private let structuralThemes = [
    (
      "Divine Presence → Human Threat",
      "The Lord's presence with Israel contrasted with the threat of being swallowed by enemies",
      ["nisi", "dominus", "sum", "israel", "exsurgo", "homo", "deglutio", "vivus"],
      1,
      2,
      "The psalm opens with a conditional statement about the Lord's presence, immediately followed by the threat of being devoured alive by rising enemies.",
      "Augustine sees this as the fundamental contrast between divine protection and human vulnerability. The 'nisi quia Dominus' establishes the conditional nature of salvation, while the image of being swallowed alive represents the complete destruction that would occur without God's intervention (Enarr. Ps. 123.1-2)."
    ),
    (
      "Wrath → Flood",
      "The fury of enemies manifested as overwhelming waters",
      ["irascor", "furor", "is", "aqua", "absorbeo", "torrens", "pertransio", "intolerabilis"],
      3,
      4,
      "The enemies' anger becomes a flood that would have overwhelmed the soul, but the torrent is passed through safely.",
      "For Augustine, the flood represents both external persecution and internal spiritual trials. The 'intolerable water' symbolizes the overwhelming nature of temptation and suffering, while passing through it demonstrates divine grace enabling endurance (Enarr. Ps. 123.3-4)."
    ),
    (
      "Blessing → Deliverance",
      "Divine blessing prevents becoming prey, leading to liberation from the snare",
      ["benedictus", "dominus", "do", "captio", "dens", "passer", "ereptus", "laqueus"],
      5,
      6,
      "The Lord is blessed for not giving Israel as prey to their teeth, and the soul is delivered like a sparrow from the fowler's snare.",
      "Augustine interprets the sparrow as the soul caught in the snares of temptation and sin. The broken snare represents Christ's victory over the devil's traps, while the blessing acknowledges God's protective mercy (Enarr. Ps. 123.5-6)."
    ),
    (
      "Liberation → Divine Help",
      "Freedom from the broken snare leads to recognition of divine assistance",
      ["laqueus", "contritus", "libero", "adiutorium", "nomen", "dominus", "facio", "caelum", "terra"],
      7,
      8,
      "The snare is broken and Israel is freed, leading to the declaration that their help is in the name of the Lord who made heaven and earth.",
      "Augustine sees this final movement as the soul's recognition of complete dependence on God. The broken snare represents the definitive victory over sin and death, while the cosmic scope of 'heaven and earth' emphasizes God's universal power and care (Enarr. Ps. 123.7-8)."
    ),
  ]

  private let conceptualThemes = [
    // IMAGERY THEMES
    (
      "Water Imagery",
      "Flood and torrent metaphors for overwhelming trials and divine protection",
      ["aqua", "torrens", "absorbeo", "pertransio", "intolerabilis"],
      ThemeCategory.opposition,
      3 ... 4
    ),
    (
      "Hunting Imagery",
      "Snare and fowler metaphors for temptation and deliverance",
      ["laqueus", "venator", "passer", "ereptus", "contritus"],
      ThemeCategory.sin,
      6 ... 7
    ),
    (
      "Divine Protection",
      "God's shielding presence and deliverance from enemies",
      ["dominus", "nisi", "benedictus", "adiutorium", "nomen"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Human Vulnerability",
      "Human weakness and dependence on divine intervention",
      ["homo", "anima", "noster", "nos", "vivus"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Threat and Violence",
      "Enemy aggression and destructive forces",
      ["exsurgo", "deglutio", "irascor", "furor", "captio", "dens"],
      ThemeCategory.conflict,
      2 ... 5
    ),
    (
      "Liberation and Freedom",
      "Deliverance from bondage and restoration of liberty",
      ["libero", "ereptus", "contritus", "adiutorium"],
      ThemeCategory.virtue,
      6 ... 8
    ),
    (
      "Cosmic Scope",
      "Universal and eternal dimensions of divine power",
      ["caelum", "terra", "facio", "dominus"],
      ThemeCategory.divine,
      8 ... 8
    ),
  ]

  // MARK: - Enhanced Tests

  func testTotalVerses() {
    XCTAssertEqual(
      psalm123.count, expectedVerseCount, "Psalm 123 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 123 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm123.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm123,
      "Normalized Latin text should match expected classical forms"
    )
  }

  // MARK: - Line by Line Key Lemmas Test

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm123,
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
      psalmText: psalm123,
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
      psalmText: psalm123,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Test Cases

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm123,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm123_texts.json"
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
      filename: "output_psalm123_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
