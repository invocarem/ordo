@testable import LatinService
import XCTest

class Psalm118SadeTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 118, category: "sade")

  // MARK: - Test Data Properties

  private let psalm118Sade = [
    "Iustus es, Domine, et rectum iudicium tuum.",
    "Mandasti iustitiam testimonia tua, et veritatem tuam nimis.",
    "Tabescere me fecit zelus meus, quia obliti sunt verba tua inimici mei.",
    "Igne examinatum eloquium tuum vehementer, et servus tuus dilexit illud.",
    "Adolescentulus sum ego et contemptus; iustificationes tuas non sum oblitus.",
    "Iustitia tua iustitia in aeternum, et lex tua veritas.",
    "Tribulatio et angustia invenerunt me; mandata tua meditatio mea est.",
    "Aeternum iustum testimonium tuum; intellectum da mihi, et vivam.",
  ]

  private let englishText = [
    "Thou art just, O Lord, and thy judgment is right.",
    "Thou hast commanded justice thy testimonies, and thy truth exceedingly.",
    "My zeal hath made me waste away, because my enemies forgot thy words.",
    "Thy word is exceedingly refined, and thy servant hath loved it.",
    "I am young and despised; yet I have not forgotten thy justifications.",
    "Thy justice is justice for ever, and thy law is the truth.",
    "Trouble and anguish have found me; thy commandments are my meditation.",
    "Thy testimonies are justice for ever; give me understanding, and I shall live.",
  ]

  private let lineKeyLemmas = [
    (1, ["iustus", "dominus", "rectus", "iudicium"]),
    (2, ["mando", "iustitia", "testimonium", "veritas", "nimis"]),
    (3, ["tabesco", "zelus", "obliviscor", "verbum", "inimicus"]),
    (4, ["ignis", "examino", "eloquium", "vehementer", "servus", "diligo"]),
    (5, ["adolescentulus", "sum", "contemptus", "iustificatio", "obliviscor"]),
    (6, ["iustitia", "aeternum", "lex", "veritas"]),
    (7, ["tribulatio", "angustia", "invenio", "mandatum", "meditatio"]),
    (8, ["aeternum", "iustus", "testimonium", "intellectus", "do", "vivo"]),
  ]

  private let structuralThemes = [
    (
      "Divine Justice → Command",
      "God's righteousness and His command for justice and truth",
      ["iustus", "dominus", "iudicium", "mando", "iustitia", "testimonium", "veritas"],
      1,
      2,
      "The psalmist declares God's righteousness and right judgment, then notes that God has commanded justice through His testimonies and His truth exceedingly.",
      "Augustine sees this as the foundation of divine law. The 'iustus es, Domine' establishes God's character as the source of all justice, while the 'mandasti justitiam' shows how divine righteousness is communicated through His testimonies."
    ),
    (
      "Zeal → Refinement",
      "The psalmist's zeal causing him to waste away, contrasted with God's refined word",
      ["zelus", "tabesco", "obliviscor", "verbum", "inimicus", "ignis", "examino", "eloquium", "diligo"],
      3,
      4,
      "The psalmist's zeal has made him waste away because his enemies forgot God's words, but God's word is exceedingly refined and His servant loves it.",
      "For Augustine, this represents the soul's response to divine truth. The 'zelus meus' shows the psalmist's passionate commitment to God's law, while the 'igne examinatum eloquium' reveals the purifying effect of divine truth on the soul."
    ),
    (
      "Youth → Perseverance",
      "The psalmist's youth and despised state, yet his faithfulness to God's justifications",
      ["adolescentulus", "contemptus", "iustificatio", "obliviscor", "iustitia", "aeternum", "lex", "veritas"],
      5,
      6,
      "The psalmist acknowledges his youth and despised state but has not forgotten God's justifications, declaring that God's justice is eternal and His law is truth.",
      "Augustine interprets this as the soul's recognition of its humble state before divine truth. The 'adolescentulus sum ego et contemptus' shows human frailty, while the declaration of eternal justice reveals the psalmist's faith in divine constancy."
    ),
    (
      "Trouble → Life",
      "The psalmist's experience of trouble and anguish, leading to his plea for understanding and life",
      ["tribulatio", "angustia", "invenio", "mandatum", "meditatio", "aeternum", "testimonium", "intellectus", "do", "vivo"],
      7,
      8,
      "Trouble and anguish have found the psalmist, but God's commandments are his meditation, and he asks for understanding of God's eternal testimonies so he may live.",
      "For Augustine, this represents the soul's journey through suffering to wisdom. The 'tribulatio et angustia' shows the reality of human experience, while the request for 'intellectum da mihi, et vivam' reveals the soul's recognition that true life comes through understanding divine truth."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Justice",
      "Focus on God's righteousness, judgment, and eternal justice",
      ["iustus", "iudicium", "iustitia", "aeternum", "veritas"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Divine Word",
      "God's testimonies, words, and law as sources of truth",
      ["testimonium", "verbum", "eloquium", "lex", "mandatum"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Human Response",
      "The soul's zeal, meditation, and love for divine truth",
      ["zelus", "tabesco", "diligo", "meditatio", "intellectus"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Suffering and Hope",
      "Trouble, anguish, and the hope for understanding and life",
      ["tribulatio", "angustia", "adolescentulus", "contemptus", "vivo"],
      ThemeCategory.virtue,
      1 ... 8
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm118Sade.count, 8, "Psalm 118 Sade should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Sade English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Sade.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Sade,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Sade,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Sade_texts.json"
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
      filename: "output_psalm118Sade_themes.json"
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
      psalmText: psalm118Sade,
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
      psalmText: psalm118Sade,
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
      psalmText: psalm118Sade,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
