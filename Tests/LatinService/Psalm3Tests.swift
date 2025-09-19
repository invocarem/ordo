@testable import LatinService
import XCTest

class Psalm3Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 3, category: nil)
  private let expectedVerseCount = 8

  // MARK: - Test Data

  private let text = [
    "Domine, quid multiplicati sunt qui tribulant me? multi insurgunt adversum me.",
    "Multi dicunt animae meae: Non est salus ipsi in Deo eius.",
    "Tu autem, Domine, susceptor meus es, gloria mea, et exaltans caput meum.",
    "Voce mea ad Dominum clamavi, et exaudivit me de monte sancto suo.",
    "Ego dormivi et soporatus sum; exsurrexi, quia Dominus suscepit me.",
    "Non timebo milia populi circumdantis me: exsurge, Domine; salvum me fac, Deus meus.",
    "Quoniam tu percussisti omnes adversantes mihi sine causa; dentes peccatorum contrivisti.",
    "Domini est salus; et super populum tuum benedictio tua.",
  ]

  private let englishText = [
    "O Lord, how are they multiplied that trouble me? Many rise up against me.",
    "Many say to my soul: There is no salvation for him in his God.",
    "But thou, O Lord, art my protector, my glory, and the lifter up of my head.",
    "I have cried to the Lord with my voice: and he hath heard me from his holy hill.",
    "I have slept and have taken my rest: and I have risen up, because the Lord hath sustained me.",
    "I will not fear thousands of the people surrounding me: arise, O Lord; save me, O my God.",
    "For thou hast struck all them who are my adversaries without cause: thou hast broken the teeth of sinners.",
    "Salvation is of the Lord: and thy blessing is upon thy people.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "multiplico", "tribulo", "insurgo", "adversus"]),
    (2, ["multus", "dico", "anima", "salus", "deus"]),
    (3, ["dominus", "susceptor", "gloria", "exalto", "caput"]),
    (4, ["vox", "dominus", "clamo", "exaudio", "mons", "sanctus"]),
    (5, ["dormio", "soporor", "exsurgo", "dominus", "suscipio"]),
    (6, ["timeo", "mille", "populus", "circumdo", "exsurgo", "dominus", "salvus", "facio", "deus"]),
    (7, ["percutio", "adversus", "causa", "dens", "peccator", "contero"]),
    (8, ["dominus", "salus", "populus", "benedictio"]),
  ]

  private let structuralThemes = [
    (
      "Oppression → Multiplication",
      "The overwhelming multiplication of adversaries and troublers",
      ["multiplico", "tribulo", "insurgo", "adversus", "dico", "anima"],
      1,
      2,
      "The psalmist laments the many who trouble him and rise against him, with many saying to his soul that there is no salvation in his God.",
      "Augustine sees this as representing both physical persecutors and spiritual temptations that multiply against the soul. The taunt 'no salvation' reflects the enemy's attempt to destroy faith in God's deliverance."
    ),
    (
      "Declaration → Exaltation",
      "Affirmation of God as protector, glory, and lifter of the head",
      ["susceptor", "exalto", "caput", "vox", "clamo", "exaudio"],
      3,
      4,
      "Despite the opposition, the psalmist declares the Lord as his protector, his glory, and the one who lifts his head. He cries out and is heard from God's holy mountain.",
      "For Augustine, God as 'susceptor' signifies both shield and sustainer. The exalted head represents restored dignity and hope. The holy mountain symbolizes God's heavenly throne and unchanging nature."
    ),
    (
      "Rest → Confidence",
      "Sleeping and waking in God's care, leading to fearless confidence",
      ["dormio", "soporor", "suscipio", "timeo", "circumdo"],
      5,
      6,
      "The psalmist sleeps and wakes in God's care, arising because the Lord sustains him. He fears no thousands of people surrounding him and calls on God to arise and save him.",
      "Augustine interprets this sleep as both physical rest and spiritual peace in God's protection. The fearless awakening demonstrates complete trust in divine sustenance amid overwhelming opposition."
    ),
    (
      "Deliverance → Benediction",
      "God's striking of adversaries and bestowal of salvation and blessing",
      ["percutio", "adversus", "contero", "dens", "salus", "benedictio"],
      7,
      8,
      "The Lord has struck all who oppose without cause and shattered the teeth of sinners. Salvation belongs to the Lord, and His blessing is upon His people.",
      "Augustine sees the shattered teeth as rendering malicious speech powerless. The final declaration affirms that salvation is God's sovereign work, and His blessing rests on those who belong to Him."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Protection",
      "God as shield and sustainer",
      ["susceptor", "suscipio", "exalto", "circumdo"],
      ThemeCategory.divine,
      3 ... 6
    ),
    (
      "Opposition and Enemies",
      "Adversaries and trouble from opponents",
      ["tribulo", "insurgo", "adversus", "peccator", "multiplico"],
      .opposition,
      1 ... 2
    ),
    (
      "Trust in God",
      "Lack of fear through faith in God",
      ["timeo", "confido"],
      .virtue,
      6 ... 6
    ),
    (
      "Prayer and Divine Response",
      "Crying out to God and His answer",
      ["clamo", "exaudio", "vox"],
      .worship,
      4 ... 4
    ),
    (
      "Divine Salvation",
      "God's deliverance and blessing",
      ["salus", "salvus", "benedictio"],
      .divine,
      7 ... 8
    ),
    (
      "Divine Justice",
      "God's judgment against adversaries",
      ["percutio", "contero"],
      .justice,
      7 ... 7
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 3 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 3 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  // MARK: - Line by Line Key Lemmas Test

  func testPsalm3LineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
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
      psalmText: text,
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
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
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
      filename: "output_psalm3_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testSavePsalm3Themes() {
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
      filename: "output_psalm3_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
