@testable import LatinService
import XCTest

class Psalm118SamechTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  private let minimumLemmasPerTheme = 3
  let id = PsalmIdentity(number: 118, category: "Samech")

  // MARK: - Test Data Properties

  private let psalm118Samech = [
    "Iniquos odio habui, et legem tuam dilexi.",
    "Adiutor et susceptor meus es tu, et in verbum tuum supersperavi.",
    "Declinate a me, maligni, et scrutabor mandata Dei mei.",
    "Suscita me secundum verbum tuum, et vivam, et non confundas me ab exspectatione mea.",
    "Adiuva me, et salvus ero, et meditabor in iustificationibus tuis semper.",
    "Sprevisti omnes discedentes a iudiciis tuis, quia iniqua cogitatio eorum.",
    "Praevaricantes reputavi omnes peccatores terrae, ideo dilexi testimonia tua.",
    "Confige timore tuo carnes meas, a iudiciis enim tuis timui.",
  ]

  private let englishText = [
    "I have hated the wicked, and I have loved thy law.",
    "Thou art my helper and my protector, and in thy word I have greatly hoped.",
    "Depart from me, ye malignant, and I will search the commandments of my God.",
    "Uphold me according to thy word, and I shall live, and let me not be confounded in my expectation.",
    "Help me, and I shall be saved, and I will meditate always on thy justifications.",
    "Thou hast despised all them that fall off from thy judgments, for their thought is unjust.",
    "I have accounted all the sinners of the earth prevaricators, therefore I have loved thy testimonies.",
    "Nail down my flesh with thy fear, for I am afraid of thy judgments.",
  ]

  private let lineKeyLemmas = [
    (1, ["iniquus", "odium", "lex", "diligo"]),
    (2, ["adiutor", "susceptor", "verbum", "superspero"]),
    (3, ["declino", "malignus", "scrutor", "mandatum", "deus"]),
    (4, ["suscito", "secundum", "verbum", "vivo", "confundo", "exspectatio"]),
    (5, ["adiuvo", "salvus", "meditor", "iustificatio", "semper"]),
    (6, ["sperno", "discedo", "iudicium", "iniquus", "cogitatio"]),
    (7, ["praevaricor", "reputo", "peccator", "terra", "diligo", "testimonium"]),
    (8, ["configo", "timor", "caro", "iudicium", "timeo"]),
  ]

  private let structuralThemes = [
    (
      "Love → Separation",
      "The psalmist's love for God's law contrasted with hatred for the wicked",
      ["iniquus", "odium", "lex", "diligo", "declino", "malignus"],
      1,
      2,
      "The psalmist declares his hatred for the wicked and love for God's law, then calls on God as his helper and protector, placing his hope in God's word.",
      "Augustine sees this as the soul's fundamental choice between good and evil. The 'odium' for the wicked is not personal hatred but rejection of sin, while the 'dilexi' for God's law represents the soul's proper orientation toward divine truth."
    ),
    (
      "Divine Help → Life",
      "God's assistance and protection leading to life and salvation",
      ["adiutor", "susceptor", "verbum", "superspero", "suscito", "vivo", "confundo", "exspectatio"],
      3,
      4,
      "The psalmist calls on the wicked to depart while he searches God's commandments, then asks God to uphold him according to His word so he may live without being confounded in his expectation.",
      "For Augustine, this represents the soul's dependence on divine grace. The 'adiutor et susceptor' shows God's dual role as helper and sustainer, while the request for 'suscita me' reveals the soul's need for divine intervention to truly live."
    ),
    (
      "Salvation → Meditation",
      "The psalmist's salvation through God's help and his meditation on justifications",
      ["adiuvo", "salvus", "meditor", "iustificatio", "semper", "sperno", "discedo", "iudicium"],
      5,
      6,
      "The psalmist asks for help to be saved and vows to meditate always on God's justifications, while noting that God has despised those who fall away from His judgments because their thoughts are unjust.",
      "Augustine interprets this as the soul's recognition of the connection between divine help and personal responsibility. The 'meditabor semper' shows the ongoing nature of spiritual discipline, while the contrast with those who 'discedentes' reveals the consequences of rejecting divine law."
    ),
    (
      "Judgment → Fear",
      "The psalmist's recognition of sinners and his fear of God's judgments",
      ["praevaricor", "reputo", "peccator", "terra", "diligo", "testimonium", "configo", "timor", "caro", "timeo"],
      7,
      8,
      "The psalmist has accounted all sinners as prevaricators and therefore loves God's testimonies, asking God to nail down his flesh with fear because he is afraid of God's judgments.",
      "For Augustine, this represents the soul's mature understanding of divine justice. The 'reputavi omnes peccatores' shows the psalmist's clear-eyed assessment of human sinfulness, while the 'confige timore tuo' reveals the proper response of reverential fear that leads to obedience."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Law",
      "Focus on God's law, commandments, and testimonies",
      ["lex", "mandatum", "testimonium", "iustificatio", "iudicium"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Divine Assistance",
      "God as helper, protector, and source of salvation",
      ["adiutor", "susceptor", "adiuvo", "suscito", "salvus", "superspero"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Separation from Evil",
      "Rejection of wickedness, sinners, and evil thoughts",
      ["iniquus", "odium", "declino", "malignus", "sperno", "discedo", "praevaricor", "peccator"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Fear and Reverence",
      "Reverential fear of God and His judgments",
      ["timor", "timeo", "configo", "caro"],
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
      psalm118Samech.count, 8, "Psalm 118 Samech should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Samech English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Samech.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Samech,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Samech,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Samech_texts.json"
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
      filename: "output_psalm118Samech_themes.json"
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
      psalmText: psalm118Samech,
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
      psalmText: psalm118Samech,
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
      psalmText: psalm118Samech,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
