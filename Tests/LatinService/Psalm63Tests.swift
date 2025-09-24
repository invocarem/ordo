@testable import LatinService
import XCTest

class Psalm63Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 63, category: "")

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }
    
  // MARK: - Test Data Properties

  private let expectedVerseCount = 11
  private let text = [
    "Exaudi, Deus, orationem meam cum deprecor; a timore inimici eripe animam meam.",
    "Protexisti me a conventu malignantium, a multitudine operantium iniquitatem.",
    "Quia exacuerunt ut gladium linguas suas; intenderunt arcum rem amaram, Ut sagittent in occultis immaculatum.",
    "Subito sagittabunt eum, et non timebunt; firmaverunt sibi sermonem nequam.",
    "Narrabunt ut abscondant laqueos; dixerunt: Quis videbit eos?",
    
    "Scrutati sunt iniquitates; defecerunt scrutantes scrutinio.",
    "Accedet homo ad cor altum, et exaltabitur Deus.",
    "Sagittae parvulorum factae sunt plagae eorum, et infirmatae sunt contra eos linguae eorum.",
    "Conturbati sunt omnes qui videbant eos; Et timuit omnis homo. ", 
    "Et annuntiaverunt opera Dei, et facta ejus intellexerunt.",
    
    "Laetabitur justus in Domino, et sperabit in eo; et laudabuntur omnes recti corde."
  ]

  private let englishText = [
    "Hear my prayer, O God, when I make supplication to thee; from fear of the enemy deliver my soul.",
    "Thou hast protected me from the assembly of the malignant; from the multitude of the workers of iniquity.",
    "For they have whetted their tongues like a sword; they have bent their bow a bitter thing, That they may shoot in secret at the upright of heart.",
    "They will shoot at him on a sudden, and will not fear: they are resolute in wickedness.",
    "They have talked of hiding snares; they have said: Who shall see them?",
    "They have searched after iniquities: they have failed in their search.",
    "Man shall come to a deep heart: and God shall be exalted.",
    "The arrows of children are their wounds, and their tongues are weakened against thee.",
    "All that saw them have been troubled; And every man was afraid.",
    "And they declared the works of God, and understood his doings.",
    "The just shall rejoice in the Lord, and shall hope in him; and all the upright of heart shall be praised."
  ]

  private let lineKeyLemmas = [
    (1, ["exaudio", "deus", "oratio", "deprecor", "timor", "inimicus", "eripio", "anima"]),
    (2, ["protego", "conventus", "malignor", "multitudo", "operor", "iniquitas"]),
    (3, ["exacuo", "gladius", "lingua", "intendo", "arcus", "amarus", "sagitto", "occultus", "immaculatus"]),
    (4, ["subito", "sagitto", "timeo", "firmo", "sermo", "nequam"]),
    (5, ["narro", "abscondo", "laqueus", "dico", "video"]),
    (6, ["scrutor", "iniquitas", "deficio", "scrutinium"]),
    (7, ["accedo", "homo", "cor", "altus", "exalto", "deus"]),
    (8, ["sagitta", "parvulus", "plaga", "infirmo", "lingua"]),
    (9, ["conturbo", "video", "timeo"]),
    (10, ["annuntio", "opus", "deus", "factum", "intellego"]),
    (11, ["laetor", "justus", "dominus", "spero", "laudo", "rectus", "cor"])
  ]

  private let structuralThemes = [
    (
      "Prayer for Protection → Divine Shield",
      "The psalmist's prayer for deliverance and God's protection from enemies",
      ["exaudio", "deprecor", "protego", "eripio"],
      1,
      2,
      "The psalmist begins with a prayer for God to hear his supplication and deliver his soul from fear of the enemy, then acknowledges God's protection from the assembly of the malignant.",
      "Augustine sees this as the soul's confident appeal to divine protection. Those who pray earnestly can trust in God's shield against both external enemies and internal fears."
    ),
    (
      "Enemy Weapons → Secret Attacks",
      "The enemies' preparation of weapons and their secret plotting",
      ["exacuo", "gladius", "lingua", "intendo", "arcus", "amarus", "sagitto", "occultus", "immaculatus", "subito", "timeo", "firmo", "sermo", "nequam"],
      3,
      4,
      "The enemies sharpen their tongues like swords and bend their bows to shoot in secret at the upright, then suddenly shoot at them without fear, strengthening their wicked words.",
      "For Augustine, the enemies' weapons represent the spiritual attacks of the wicked, and their secret plotting reveals their cowardly and deceitful nature."
    ),
    (
      "Failed Schemes → Failed Investigation",
      "The enemies' failed plotting and their failed search for iniquities",
      ["narro", "abscondo", "laqueus", "dico", "video", "scrutor", "iniquitas", "deficio", "scrutinium"],
      5,
      6,
      "The enemies talk of hiding snares and ask who shall see them, but they search after iniquities and fail in their search.",
      "Augustine sees this as the soul's recognition that the wicked operate in darkness and secrecy, but their schemes ultimately fail because God sees all and their investigations come to nothing."
    ),
    (
      "Divine Exaltation → Children's Arrows",
      "God's exaltation contrasted with the weakened arrows of children",
      ["accedo", "homo", "cor", "altus", "exalto", "deus", "sagitta", "parvulus", "plaga", "infirmo", "lingua"],
      7,
      8,
      "Man comes to a deep heart and God shall be exalted, while the arrows of children are their wounds and their tongues are weakened.",
      "For Augustine, this represents the contrast between divine exaltation and the feeble attacks of the wicked, showing God's ultimate victory over all opposition."
    ),
    (
      "Human Disturbance → Divine Revelation",
      "The disturbance of those who see contrasted with divine works being declared and understood",
      ["conturbo", "video", "timeo", "annuntio", "opus", "deus", "factum", "intellego"],
      9,
      10,
      "All that saw the enemies have been troubled and every man was afraid, but they declared the works of God and understood His doings.",
      "Augustine sees this as the contrast between human fear and divine revelation. Those who witness God's works can understand His truth despite the initial disturbance."
    ),
    (
      "Just Rejoicing",
      "The just rejoicing and hope in the Lord",
      ["laetor", "justus", "dominus", "spero", "laudo", "rectus", "cor"],
      11,
      11,
      "The just shall rejoice in the Lord, and shall hope in him; and all the upright of heart shall be praised.",
      "For Augustine, this represents the ultimate victory of the righteous who trust in God's protection and find joy in His presence, being praised for their upright hearts."
    )
  ]

  private let conceptualThemes = [
    (
      "Divine Protection",
      "God's shielding and deliverance of the righteous",
      ["protego", "eripio", "exaudio", "deprecor"],
      ThemeCategory.divine,
      1...2
    ),
    (
      "Enemy Warfare",
      "The weapons and tactics used by enemies against the righteous",
      ["gladius", "arcus", "sagitto", "lingua", "sermo", "laqueus"],
      ThemeCategory.sin,
      3...6
    ),
    (
      "Secret and Deceit",
      "The hidden and deceptive nature of evil attacks",
      ["occultus", "subito", "nequam", "abscondo", "scrutor"],
      ThemeCategory.sin,
      4...7
    ),
    (
      "Divine Exaltation",
      "God's ultimate victory and exaltation over enemies",
      ["exalto", "deus", "accedo", "altus", "intellego"],
      ThemeCategory.divine,
      8...10
    ),
    (
      "Righteous Response",
      "The just rejoicing and hope in the Lord",
      ["justus", "laetor", "spero", "laudo", "rectus"],
      ThemeCategory.virtue,
      11...11
    ),
    (
      "Human Vulnerability",
      "References to human weakness and divine strength",
      ["parvulus", "infirmo", "conturbo", "timeo", "anima"],
      ThemeCategory.virtue,
      8...10
    )
  ]

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 63 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 63 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm63_texts.json"
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
      filename: "output_psalm63_themes.json"
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