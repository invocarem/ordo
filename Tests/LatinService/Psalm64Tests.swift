@testable import LatinService
import XCTest

class Psalm64Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 64, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 14

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  private let text = [
    "Te decet hymnus, Deus, in Sion; et tibi reddetur votum in Ierusalem.",
    "Exaudi orationem meam; ad te omnis caro veniet.",
    "Verba iniquorum praevaluerunt super nos; et impietatibus nostris tu propitiaberis.",
    "Beatus quem elegisti et assumpsisti; inhabitabit in atriis tuis.",
    "Replebimur in bonis domus tuae; sanctum est templum tuum, mirabile in aequitate.",

    "Exaudi nos, Deus, salutaris noster; spes omnium finium terrae et in mari longe.",
    "Praeparans montes in virtute tua, accinctus potentia; Qui conturbas profundum maris, sonum fluctuum eius.",
    "Turbabuntur gentes, et timebunt qui habitant terminos a signis tuis; exitus matutini et vespere delectabis.",
    "Visitasti terram, et inebriasti eam; multiplicasti locupletare eam.",
    "Flumen Dei repletum est aquis; parasti cibum illorum, quoniam ita est praeparatio eius.",

    "Rivos eius inebria, multiplica genimina eius; in stillicidiis eius laetabitur germinans.",
    "Benedices coronae anni benignitatis tuae; et campi tui replebuntur ubertate.",
    "Pinguescent speciosa deserti; et exsultatione colles accingentur.",
    "Induti sunt arietes ovium, et valles abundabunt frumento; clamabunt, etenim hymnum dicent.",
  ]

  private let englishText = [
    "A hymn, O God, becometh thee in Sion; and a vow shall be paid to thee in Jerusalem.",
    "O hear my prayer; all flesh shall come to thee.",
    "The words of the wicked have prevailed over us; and thou wilt pardon our transgressions.",
    "Blessed is he whom thou hast chosen and taken to thee; he shall dwell in thy courts.",
    "We shall be filled with the good things of thy house; holy is thy temple, wonderful in equity.",
    "Hear us, O God our saviour, who art the hope of all the ends of the earth, and in the sea afar off.",
    "Thou who preparest the mountains by thy strength, being girded with power: Who troublest the depth of the sea, the noise of its waves.",
    "The Gentiles shall be troubled, and they that dwell in the uttermost parts shall be afraid at thy signs: thou shalt make the outgoings of the morning and of the evening to be joyful.",
    "Thou hast visited the earth, and hast made it drunk: thou hast multiplied its riches.",
    "The river of God is filled with water, thou hast prepared their food: for so is its preparation.",
    "Fill up plentifully the streams thereof, multiply its fruits; it shall spring up and rejoice in its showers.",
    "Thou shalt bless the crown of the year of thy goodness: and thy fields shall be filled with plenty.",
    "The beautiful places of the wilderness shall grow fat: and the hills shall be girded about with joy,",
    "The rams of the flock are clothed, and the vales shall abound with corn: they shall shout, yea they shall sing a hymn.",
  ]

  private let lineKeyLemmas = [
    (1, ["decet", "hymnus", "deus", "sion", "reddo", "votum", "ierusalem"]),
    (2, ["exaudio", "oratio", "caro", "venio"]),
    (3, ["verbum", "iniquus", "praevaleo", "impietas", "propitior"]),
    (4, ["beatus", "eligo", "assumo", "inhabito", "atrium"]),
    (5, ["repleo", "bonus", "domus", "sanctus", "templum", "mirabilis", "aequitas"]),
    (6, ["exaudio", "deus", "salutaris", "spes", "finis", "terra", "mare"]),
    (7, ["praeparo", "mons", "virtus", "accingo", "potentia", "conturbo", "profundus", "mare", "sonus", "fluctus"]),
    (8, ["turbo", "timeo", "habito", "terminus", "signum", "exitus", "matutinus", "vesper", "delecto"]),
    (9, ["visito", "terra", "inebrio", "multiplico", "locupleto"]),
    (10, ["flumen", "deus", "repleo", "aqua", "paro", "cibus", "praeparatio"]),
    (11, ["rivus", "inebrio", "multiplico", "genimen", "stillicidium", "laetor", "germino"]),
    (12, ["benedico", "corona", "annus", "benignitas", "campus", "repleo", "uber"]),
    (13, ["pinguesco", "speciosus", "desertum", "exsultatio", "collis", "accingo"]),
    (14, ["induo", "aries", "ovis", "vallis", "abundo", "frumentum", "clamo", "hymnus", "dico"]),
  ]

  private let structuralThemes = [
    (
      "Divine Worship → Prayer Response",
      "The psalmist's call to worship and God's response to prayer",
      ["hymnus", "votum", "exaudio", "oratio", "sanctus", "templum"],
      1,
      6,
      "The psalmist declares that hymns and vows are fitting for God in Zion and Jerusalem, then calls for God to hear his prayer as all flesh comes to Him, and describes the blessed dwelling in God's holy temple.",
      "Augustine sees this as the soul's recognition that true worship requires both external praise and internal prayer, leading to blessed communion with God in His holy dwelling."
    ),
    (
      "Divine Power → Natural Disturbance",
      "God's power over mountains and seas causing natural phenomena and fear among nations",
      ["praeparo", "mons", "virtus", "potentia", "conturbo", "profundus", "mare", "turbo"],
      7,
      8,
      "God prepares mountains with His strength and power, troubles the depths of the sea and its waves, causing the nations to be disturbed and those dwelling in remote places to fear His signs.",
      "For Augustine, this represents God's sovereign power over creation, where His divine activity causes both natural phenomena and spiritual awakening among all peoples."
    ),
    (
      "Earthly Visitation → Agricultural Abundance",
      "God's visitation of the earth leading to agricultural fertility and abundance",
      ["visito", "terra", "inebrio", "flumen", "aqua", "genimen", "germino", "frumentum"],
      9,
      14,
      "God has visited and made the earth drunk, filling the river of God with water and preparing food, causing streams to multiply and produce to spring up, leading to abundant grain and joyful celebration.",
      "Augustine sees this as God's providential care for His creation, where divine visitation results in natural abundance that sustains life and leads to grateful celebration."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Worship",
      "Praise, hymns, and sacred offerings to God",
      ["hymnus", "votum", "sanctus", "templum", "benedico", "clamo"],
      ThemeCategory.worship,
      1 ... 14
    ),
    (
      "Divine Power",
      "God's strength and authority over creation",
      ["virtus", "potentia", "praeparo", "conturbo", "turbo"],
      ThemeCategory.divine,
      7 ... 8
    ),
    (
      "Natural Abundance",
      "Agricultural fertility and natural prosperity",
      ["repleo", "genimen", "uber", "frumentum", "germino", "abundo"],
      ThemeCategory.virtue,
      9 ... 14
    ),
    (
      "Prayer and Response",
      "Human supplication and divine hearing",
      ["exaudio", "oratio", "propitior", "visito"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Blessedness and Election",
      "Divine choice and blessed dwelling",
      ["beatus", "eligo", "assumo", "inhabito", "atrium"],
      ThemeCategory.virtue,
      4 ... 5
    ),
    (
      "Natural Phenomena",
      "Mountains, seas, and natural elements",
      ["mons", "mare", "profundus", "flumen", "aqua", "rivus"],
      ThemeCategory.divine,
      7 ... 11
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 64 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 64 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm64_texts.json"
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
      filename: "output_psalm64_themes.json"
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

  // MARK: - Verb Tests

  func testVerbRepleo() {
    let latinService = LatinService.shared
    latinService.configureDebugging(target: "repleo")
    let analysis = latinService.analyzePsalm(id, text: text)

    let repleoEntry = analysis.dictionary["repleo"]
    XCTAssertNotNil(repleoEntry, "Lemma 'repleo' should exist")

    let translation = repleoEntry?.translation?.lowercased() ?? ""
    XCTAssertTrue(
      translation.contains("fill") || translation.contains("replenish"),
      "Expected 'repleo' to mean 'to fill', got: \(translation)"
    )

    let formsToCheck = [
      ("Replebimur", "we shall be [fill]", "future passive"), // v.5
      ("repletum", "[fill]", "perfect passive participle"), // v.11
      ("replebuntur", "they shall be [fill]", "future passive"), // v.13
    ]

    for (form, expectedMeaning, expectedGrammar) in formsToCheck {
      let formCount = repleoEntry?.forms[form.lowercased()] ?? 0
      XCTAssertGreaterThan(formCount, 0, "Form '\(form)' should exist")

      if let entity = repleoEntry?.entity {
        let result = entity.analyzeFormWithMeaning(form)
        XCTAssertTrue(
          result.contains(expectedMeaning) || result.contains(expectedGrammar),
          "For '\(form)': expected \(expectedMeaning)/\(expectedGrammar), got \(result)"
        )
      }
    }
  }
}
