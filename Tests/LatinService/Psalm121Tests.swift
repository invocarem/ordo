import XCTest

@testable import LatinService

class Psalm121Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private var latinService: LatinService!
  let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  let id = PsalmIdentity(number: 121, category: nil)

  // MARK: - Test Data

  let psalm121 = [
    "Laetatus sum in his quae dicta sunt mihi: In domum Domini ibimus.",
    "Stantes erant pedes nostri in atriis tuis, Ierusalem.",
    "Ierusalem, quae aedificatur ut civitas, cuius participatio eius in idipsum.",
    "Illuc enim ascenderunt tribus, tribus Domini, testimonium Israel, ad confitendum nomini Domini.",
    "Quia illic sederunt sedes in iudicio, sedes super domum David.",
    "Rogate quae ad pacem sunt Ierusalem, et abundantia diligentibus te.",
    "Fiat pax in virtute tua, et abundantia in turribus tuis.",
    "Propter fratres meos et proximos meos, loquebar pacem de te.",
    "Propter domum Domini Dei nostri, quaesivi bona tibi.",
  ]

  private let englishText = [
    "I rejoiced at the things that were said to me: We shall go into the house of the Lord.",
    "Our feet were standing in thy courts, O Jerusalem.",
    "Jerusalem, which is built as a city, which is compact together.",
    "For thither did the tribes go up, the tribes of the Lord: the testimony of Israel, to praise the name of the Lord.",
    "Because their seats have sat in judgment, seats upon the house of David.",
    "Pray ye for the things that are for the peace of Jerusalem: and abundance for them that love thee.",
    "Let peace be in thy strength: and abundance in thy towers.",
    "For the sake of my brethren, and of my neighbours, I spoke peace of thee.",
    "Because of the house of the Lord our God, I have sought good things for thee.",
  ]

  private let lineKeyLemmas = [
    (1, ["laetor", "sum", "hic", "dico", "domus", "dominus", "eo"]),
    (2, ["sto", "sum", "pes", "atrium", "tuus", "ierusalem"]),
    (
      3,
      [
        "ierusalem", "qui", "aedifico", "ut", "civitas", "participatio", "is",
        "idipsum",
      ]
    ),
    (
      4,
      [
        "illuc", "enim", "ascendo", "tribus", "dominus", "testimonium", "israel", "ad",
        "confiteor", "nomen",
      ]
    ),
    (5, ["quia", "illic", "sedeo", "sedes", "iudicium", "super", "domus", "david"]),
    (
      6,
      ["rogo", "qui", "ad", "pax", "sum", "ierusalem", "et", "abundantia", "diligo", "tu"]
    ),
    (7, ["fio", "pax", "in", "virtus", "et", "abundantia", "in", "turris", "tuus"]),
    (
      8,
      ["propter", "frater", "meus", "et", "proximus", "meus", "loquor", "pax", "de", "tu"]
    ),
    (9, ["propter", "domus", "dominus", "deus", "noster", "quaero", "bonus", "tu"]),
  ]

  private let structuralThemes = [
    (
      "Standing → Rejoicing",
      "Established presence in God's house gives rise to spiritual joy",
      ["sto", "pes", "atrium", "laetor", "domus"],
      1,
      2,
      "Augustine reads this joy ('laetatus sum') as the natural overflow of standing firm in the courts of the Lord. Though the verse order suggests joy comes first, the theological order is reversed: the soul rejoices because it finds itself in God's house. The feet that once journeyed are now planted, and from this rootedness comes gladness (Enarr. Ps. 121.1–2).",
      "The feet that once journeyed are now planted, and from this rootedness comes gladness."
    ),
    (
      "Gather → Communion",
      "The tribes' upward journey culminates in unified participation and shared confession",
      [
        "aedifico", "civitas", "participatio", "idipsum", "ascendo", "tribus", "confiteor",
        "nomen",
      ],
      3,
      4,
      "Augustine sees Jerusalem not just as a place, but a mystery: a city 'built' by God, whose unity is not geographic but spiritual. The tribes ascend not merely in space, but into a deeper communion — united in the confession of the Lord's name. The Church is the fulfillment of this image: many ascending into one body through praise (Enarr. Ps. 121.3–4).",
      "Mass: tribes ascend = faithful gathering, city compact = church unified in Christ, confession of the name= liturgy of Word; participation in idipsum: mystical communion"
    ),
    (
      "Worship → Intercession",
      "Encounter with divine order leads to prayer for peace and abundance",
      ["sedeo", "sedes", "iudicium", "rogo", "pax", "abundantia", "ierusalem"],
      5,
      6,
      "Augustine sees the 'thrones of judgment' not as earthly courts, but Christ's spiritual governance within the Church. From this seat, justice flows. But worship does not end in vision — it turns to prayer: for peace, for the flourishing of the Church. As in the Catholic Mass, after hearing God's Word and seeing His order, we pray for the city of God on earth (Enarr. Ps. 121.5–6).",
      "As in the Catholic Mass, after hearing God's Word and seeing His order, we pray for the city of God on earth."
    ),
    (
      "Peace → Charity → Action",
      "Worship concludes with love that overflows into peace-speaking and pursuit of the city's good",
      [
        "pax", "virtus", "turris", "frater", "proximus", "loquor", "quaero", "bonus",
        "domus",
      ],
      7,
      9,
      "Augustine sees this as the final fruit of true worship. Peace, rooted in divine strength and abundance, becomes a spoken gift — 'I spoke peace for the sake of my brothers.' It does not end in sentiment: it seeks good for Jerusalem. The soul leaves God's house not empty, but missioned — to speak, to seek, to build the good of the Church (Enarr. Ps. 121.7–9).",
      "Mass: after communion (abundantia in turribus); offer peace to others;dismissed (see the good of the City of God)"
    ),
  ]

  private let conceptualThemes = [
    (
      "Pilgrimage Imagery",
      "References to journeying and movement toward sacred spaces",
      ["laetor", "eo", "sto", "ascendo", "atrium"],
      ThemeCategory.virtue,
      1 ... 4
    ),
    (
      "Jerusalem Imagery",
      "The holy city as center of worship and divine presence",
      ["ierusalem", "civitas", "aedifico", "participatio", "turris"],
      ThemeCategory.divine,
      2 ... 7
    ),
    (
      "Community and Unity",
      "Terms describing the gathered people and their shared purpose",
      ["tribus", "israel", "testimonium", "confiteor", "frater", "proximus"],
      ThemeCategory.virtue,
      4 ... 8
    ),
    (
      "Divine Authority",
      "References to God's rule, judgment, and house",
      ["dominus", "domus", "sedes", "iudicium", "david", "deus"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Peace and Abundance",
      "Themes of shalom and spiritual prosperity",
      ["pax", "abundantia", "virtus", "bonus", "quaero"],
      ThemeCategory.virtue,
      6 ... 9
    ),
    (
      "Worship and Praise",
      "Expressions of devotion and acknowledgment of God",
      ["nomen", "confiteor", "rogo", "loquor"],
      ThemeCategory.divine,
      4 ... 8
    ),
  ]

  // MARK: - Basic Tests

  func testTotalVerses() {
    let expectedVerseCount = 9
    XCTAssertEqual(
      psalm121.count, expectedVerseCount, "Psalm 121 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 121 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm121.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm121,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm121,
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
      psalmText: psalm121,
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
      psalmText: psalm121,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Save JSON Methods

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm121,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm121_texts.json"
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
      filename: "output_psalm121_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
