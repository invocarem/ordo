@testable import LatinService
import XCTest

class Psalm118CophTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 118, category: "coph")

  // MARK: - Test Data Properties

  private let psalm118Coph = [
    "Clamavi in toto corde meo, exaudi me, Domine; iustificationes tuas requiram.",
    "Clamavi ad te, salvum me fac, ut custodiam mandata tua.",
    "Praeveni in maturitate, et clamavi, quia in verba tua supersperavi.",
    "Praevenerunt oculi mei ad te diluculo, ut meditarer eloquia tua.",
    "Vocem meam audi secundum misericordiam tuam, Domine, et secundum iudicium tuum vivifica me.",
    "Appropinquaverunt persequentes me iniquitatem, a lege autem tua longe facti sunt.",
    "Prope es tu, Domine, et omnes viae tuae veritas.",
    "Initio cognovi de testimoniis tuis, quia in aeternum fundasti ea.",
  ]

  private let englishText = [
    "I cried with my whole heart, hear me, O Lord; I will seek thy justifications.",
    "I cried unto thee, save me, that I may keep thy commandments.",
    "I prevented the dawning of the day, and cried, because in thy words I have hoped.",
    "My eyes to thee have prevented the morning, that I might meditate on thy words.",
    "Hear thou my voice according to thy mercy, O Lord, and according to thy judgment quicken me.",
    "They that persecute me have drawn nigh to iniquity, but they are gone far off from thy law.",
    "Thou art near, O Lord, and all thy ways are truth.",
    "I have known from the beginning concerning thy testimonies, that thou hast founded them for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["clamo", "totus", "cor", "exaudio", "dominus", "iustificatio", "requiro"]),
    (2, ["clamo", "salvus", "facio", "custodio", "mandatum"]),
    (3, ["praevenio", "maturitas", "clamo", "verbum", "superspero"]),
    (4, ["praevenio", "oculus", "diluculum", "meditor", "eloquium"]),
    (5, ["vox", "audio", "secundum", "misericordia", "dominus", "iudicium", "vivifico"]),
    (6, ["appropinquo", "persequor", "iniquitas", "lex", "longe", "facio"]),
    (7, ["prope", "dominus", "omnis", "via", "veritas"]),
    (8, ["initium", "cognosco", "testimonium", "aeternum", "fundo"]),
  ]

  private let structuralThemes = [
    (
      "Cry → Response",
      "The psalmist's urgent cries to God and his seeking of divine justifications",
      ["clamo", "totus", "cor", "exaudio", "dominus", "iustificatio", "requiro", "salvus", "facio", "custodio", "mandatum"],
      1,
      2,
      "The psalmist cries with his whole heart to God, asking to be heard and seeking His justifications, then cries again asking to be saved so he may keep God's commandments.",
      "Augustine sees this as the soul's desperate need for divine intervention. The 'clamavi in toto corde meo' shows the intensity of the psalmist's prayer, while the request for salvation reveals his understanding that keeping God's law requires divine aid."
    ),
    (
      "Anticipation → Hope",
      "The psalmist's early morning anticipation and his hope in God's words",
      ["praevenio", "maturitas", "clamo", "verbum", "superspero", "oculus", "diluculum", "meditor", "eloquium"],
      3,
      4,
      "The psalmist prevents the dawning of the day and cries because he has hoped in God's words, and his eyes have prevented the morning so he might meditate on God's words.",
      "For Augustine, this represents the soul's eagerness for divine truth. The 'praeveni in maturitate' shows the psalmist's anticipation of God's presence, while the meditation on God's words reveals his deep engagement with divine revelation."
    ),
    (
      "Mercy → Life",
      "The psalmist's request for God to hear him according to mercy and judgment",
      ["vox", "audio", "misericordia", "iudicium", "vivifico", "appropinquo", "persequor", "iniquitas", "lex", "longe"],
      5,
      6,
      "The psalmist asks God to hear his voice according to mercy and judgment to give him life, while noting that those who persecute him have drawn near to iniquity but are far from God's law.",
      "Augustine interprets this as the soul's recognition of divine justice and mercy. The request for 'vivifica me' shows the psalmist's dependence on divine life, while the contrast between persecutors and God's law reveals the fundamental choice between good and evil."
    ),
    (
      "Proximity → Foundation",
      "God's nearness and truth contrasted with the eternal foundation of His testimonies",
      ["prope", "dominus", "via", "veritas", "initium", "cognosco", "testimonium", "aeternum", "fundo"],
      7,
      8,
      "The psalmist declares that God is near and all His ways are truth, and he has known from the beginning concerning God's testimonies that He has founded them forever.",
      "For Augustine, this represents the soul's recognition of divine constancy. The 'prope es tu, Domine' shows the psalmist's confidence in God's presence, while the knowledge of eternal foundations reveals his faith in the permanence of divine truth."
    ),
  ]

  private let conceptualThemes = [
    (
      "Urgent Prayer",
      "Focus on crying out to God and seeking divine response",
      ["clamo", "exaudio", "audio", "vox", "totus", "cor"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Divine Law",
      "God's justifications, commandments, and testimonies",
      ["iustificatio", "mandatum", "testimonium", "lex", "eloquium", "verbum"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Temporal Anticipation",
      "Early morning seeking and meditation on God's word",
      ["praevenio", "maturitas", "diluculum", "meditor", "superspero"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Divine Proximity",
      "God's nearness, truth, and eternal foundation",
      ["prope", "veritas", "aeternum", "fundo", "initium", "cognosco"],
      ThemeCategory.divine,
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
      psalm118Coph.count, 8, "Psalm 118 Coph should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Coph English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Coph.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Coph,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Coph,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Coph_texts.json"
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
      filename: "output_psalm118Coph_themes.json"
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
      psalmText: psalm118Coph,
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
      psalmText: psalm118Coph,
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
      psalmText: psalm118Coph,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
