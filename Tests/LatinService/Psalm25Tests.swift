@testable import LatinService
import XCTest

class Psalm25Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 25, category: "")

  // MARK: - Test Data Properties

  private let psalm25 = [
    "Iudica me, Domine, quoniam ego in innocentia mea ingressus sum, et in Domino sperans non infirmabor.",
    "Proba me, Domine, et tenta me; ure renes meos et cor meum.",
    "Quoniam misericordia tua ante oculos meos est, et complacui in veritate tua.",
    "Non sedi cum concilio vanitatis, et cum iniqua gerentibus non introibo.",
    "Odivi ecclesiam malignantium, et cum impiis non sedebo.",

    "Lavabo inter innocentes manus meas, et circumdabo altare tuum, Domine.",
    "Ut audiam vocem laudis tuae, et enarrem universa mirabilia tua.",
    "Domine, dilexi decorem domus tuae, et locum habitationis gloriae tuae.",
    "Ne perdas cum impiis, Deus, animam meam, et cum viris sanguinum vitam meam.",
    "In quorum manibus iniquitates sunt; dextera eorum repleta est muneribus.",

    "Ego autem in innocentia mea ingressus sum: redime me, et miserere mei.",
    "Pes meus stetit in directo: in ecclesiis benedicam te, Domine.",
  ]

  private let englishText = [
    "Judge me, O Lord, for I have walked in my innocence, and trusting in the Lord, I shall not be weakened.",
    "Prove me, O Lord, and try me; burn my reins and my heart.",
    "For thy mercy is before my eyes, and I have been pleased with thy truth.",
    "I have not sat with the council of vanity, nor will I go in with those who do iniquity.",
    "I have hated the assembly of the malignant, and with the wicked I will not sit.",
    "I will wash my hands among the innocent, and I will encompass thy altar, O Lord.",
    "That I may hear the voice of thy praise, and declare all thy wonders.",
    "O Lord, I have loved the beauty of thy house, and the place where thy glory dwells.",
    "Destroy not my soul with the wicked, O God, nor my life with men of blood.",
    "In whose hands are iniquities; their right hand is filled with gifts.",
    "But as for me, I have walked in my innocence: redeem me, and have mercy on me.",
    "My foot hath stood in the right way: in the churches I will bless thee, O Lord.",
  ]

  private let lineKeyLemmas = [
    (1, ["iudico", "dominus", "innocentia", "ingredior", "spero", "infirmo"]),
    (2, ["probo", "dominus", "tento", "uro", "ren", "cor"]),
    (3, ["misericordia", "oculus", "complaceo", "veritas"]),
    (4, ["sedeo", "concilium", "vanitas", "iniquus", "gero", "introeo"]),
    (5, ["odi", "ecclesia", "malignor", "impius", "sedeo"]),
    (6, ["lavo", "innocens", "manus", "circumdo", "altare", "dominus"]),
    (7, ["audio", "vox", "laus", "enarro", "universus", "mirabilis"]),
    (8, ["dominus", "diligo", "decor", "domus", "locus", "habitatio", "gloria"]),
    (9, ["perdo", "impius", "deus", "anima", "vir", "sanguis", "vita"]),
    (10, ["manus", "iniquitas", "dexter", "repleo", "munus"]),
    (11, ["innocentia", "ingredior", "redimo", "misereor"]),
    (12, ["pes", "sto", "dirigo", "ecclesia", "benedico", "dominus"]),
  ]

  private let structuralThemes = [
    (
      "Plea for Judgment → Divine Testing",
      "The psalmist's appeal for divine judgment and request for God to test his heart",
      ["iudico", "innocentia", "probo", "tento", "uro"],
      1,
      2,
      "The psalmist asks God to judge him, declaring his innocence and trust, then invites God to prove and test his innermost being by divine fire.",
      "Augustine sees this as the soul's confident appeal to divine justice combined with willingness to undergo purification. Those who walk in Christ's righteousness can stand before God's judgment while submitting to His refining process."
    ),
    (
      "Divine Mercy → Separation from Evil",
      "God's mercy leading to deliberate avoidance of evil counsel and wicked company",
      ["misericordia", "veritas", "sedeo", "concilium", "vanitas"],
      3,
      4,
      "The psalmist declares God's mercy is before his eyes and he delights in truth, then states he has not sat with the council of vanity nor entered with evildoers, and has hated the assembly of the wicked.",
      "For Augustine, constant awareness of divine mercy leads to genuine love for truth and decisive separation from worldly wisdom and evil company, choosing instead the fellowship of the righteous."
    ),
    (
      "Hating Evil Assembly → Ritual Purity",
      "Hating the assembly of the wicked and washing hands in innocence to approach God's altar",
      ["odi", "ecclesia", "malignor", "lavo", "innocens", "altare"],
      5,
      6,
      "The psalmist has hated the assembly of the malignant and will wash his hands among the innocent and encompass God's altar, approaching in purity.",
      "Augustine sees this as the soul's rejection of evil company leading to ritual purity and spiritual cleansing. The altar represents Christ, whom the pure in heart can approach with confidence."
    ),
    (
      "Hearing God's Praise → Love for God's House",
      "Hearing the voice of God's praise leading to love for His dwelling place",
      ["audio", "laus", "enarro", "diligo", "domus", "gloria"],
      7,
      8,
      "The psalmist desires to hear the voice of God's praise and declare His wonders, then expresses his love for the beauty of God's house and the place where His glory dwells.",
      "Augustine sees this as the soul's response to divine encounter - hearing God's praise leads to proclamation of His deeds, and this encounter deepens the soul's love for God's dwelling place where His glory resides."
    ),
    (
      "Plea for Preservation → Wicked Corruption",
      "Request not to be destroyed with the wicked, then describing their corrupt hands",
      ["perdo", "impius", "anima", "manus", "iniquitas", "munus"],
      9,
      10,
      "The psalmist pleads that God not destroy his soul with the wicked, then describes how the wicked have iniquities in their hands and their right hand is full of bribes.",
      "Augustine sees this as the soul's recognition that association with evil leads to destruction, and only divine preservation can separate the righteous from the fate of the wicked, whose hands are filled with corruption."
    ),
    (
      "Innocent Walking → Steadfast Standing",
      "Walking in innocence and asking for redemption, leading to steadfast standing and blessing in the assembly",
      ["innocentia", "ingredior", "redimo", "pes", "sto", "dirigo" ],
      11,
      12,
      "The psalmist has walked in his innocence and asks for redemption and mercy, then declares that his foot has stood in the right way and he will bless the Lord in the churches.",
      "For Augustine, this represents the soul's journey from walking in integrity and seeking divine mercy to achieving stability in righteousness and public declaration of God's goodness in the community of believers."
    ),
  ]

  private let conceptualThemes = [
    (
      "Human Body Parts",
      "References to physical body parts in spiritual context",
      ["ren", "cor", "oculus", "manus", "pes", "vox"],
      ThemeCategory.virtue,
      2 ... 12
    ),
    (
      "Action Verbs",
      "Verbs describing movement and physical actions",
      ["ingredior", "sedeo", "sto", "uro", "lavo", "audio", "enarro", "circumdo"],
      ThemeCategory.virtue,
      1 ... 12
    ),
    (
      "Innocence and Integrity",
      "The psalmist's claim to moral purity and righteous living",
      ["innocentia", "probo", "innocens", "dirigo"],
      ThemeCategory.virtue,
      1 ... 12
    ),
    (
      "Divine Testing",
      "God's examination and purification of the faithful",
      ["iudico", "probo", "tento", "uro"],
      ThemeCategory.divine,
      1 ... 3
    ),
    (
      "Separation from Evil",
      "Deliberate avoidance of the wicked and their counsel",
      ["vanitas", "iniquus", "malignor", "impius", "sanguis", "iniquitas"],
      ThemeCategory.sin,
      4 ... 10
    ),
    (
      "Worship and Devotion",
      "Love for God's house and participation in worship",
      ["altare", "laus", "mirabilis", "decor", "domus", "gloria", "ecclesia", "benedico"],
      ThemeCategory.worship,
      6 ... 12
    ),
    (
      "Divine Mercy",
      "God's compassion and faithfulness to the righteous",
      ["misericordia", "veritas", "redimo", "misereor"],
      ThemeCategory.divine,
      3 ... 11
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm25.count, 12, "Psalm 25 should have 12 verses"
    )
    XCTAssertEqual(
      englishText.count, 12,
      "Psalm 25 English text should have 12 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm25.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm25,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm25,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm25_texts.json"
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
      filename: "output_psalm25_themes.json"
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
      psalmText: psalm25,
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
      psalmText: psalm25,
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
      psalmText: psalm25,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
