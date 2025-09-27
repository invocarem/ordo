@testable import LatinService
import XCTest

class Psalm144ATests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 144, category: "A")

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  private let expectedVerseCount = 9

  private let text = [
    "Exaltabo te, Deus meus, rex meus: et benedicam nomini tuo in saeculum, et in saeculum saeculi.",
    "Per singulos dies benedicam tibi: et laudabo nomen tuum in saeculum, et in saeculum saeculi.",
    "Magnus Dominus, et laudabilis nimis: et magnitudinis eius non est finis.",
    "Generatio et generatio laudabit opera tua: et potentiam tuam pronuntiabunt.",
    "Magnificentiam gloriae sanctitatis tuae loquentur: et mirabilia tua narrabunt.",
    "Et virtutem terribilium tuorum dicent: et magnitudinem tuam narrabunt.",
    "Memoriam abundantiae suavitatis tuae eructabunt: et iustitia tua exsultabunt.",
    "Miserator, et misericors Dominus: patiens, et multum misericors.",
    "Suavis Dominus universis: et miserationes eius super omnia opera eius.",
  ]

  private let englishText = [
    "I will extol thee, O God my king: and I will bless thy name for ever; yea, for ever and ever.",
    "Every day will I bless thee: and I will praise thy name for ever; yea, for ever and ever.",
    "Great is the Lord, and greatly to be praised: and of his greatness there is no end.",
    "Generation and generation shall praise thy works: and they shall declare thy power.",
    "They shall speak of the magnificence of the glory of thy holiness: and shall tell thy wondrous works.",
    "And they shall speak of the might of thy terrible acts: and shall declare thy greatness.",
    "They shall publish the memory of the abundance of thy sweetness: and shall rejoice in thy justice.",
    "The Lord is gracious and merciful: patient and plenteous in mercy.",
    "The Lord is sweet to all: and his tender mercies are over all his works.",
  ]

  private let lineKeyLemmas = [
    (1, ["exalto", "deus", "rex", "benedico", "nomen", "saeculum"]),
    (2, ["singulus", "dies", "benedico", "laudo", "nomen", "saeculum"]),
    (3, ["magnus", "dominus", "laudabilis", "magnitudo", "finis"]),
    (4, ["generatio", "laudo", "opus", "potentia", "pronuntio"]),
    (5, ["magnificentia", "gloria", "sanctitas", "loquor", "mirabilis", "narro"]),
    (6, ["virtus", "terribilis", "dico", "magnitudo", "narro"]),
    (7, ["memoria", "abundantia", "suavitas", "eructo", "iustitia", "exsulto"]),
    (8, ["miserator", "misericors", "dominus", "patiens"]),
    (9, ["suavis", "dominus", "universus", "miseratio", "super", "omnis", "opus"]),
  ]

  private let structuralThemes = [
    (
      "Personal Exaltation → Daily Blessing",
      "The psalmist's personal exaltation of God and commitment to daily blessing",
      ["exalto", "deus", "rex", "benedico", "nomen", "saeculum"],
      1,
      2,
      "The psalmist declares he will exalt God as his king and bless His name forever, then commits to blessing God every day and praising His name forever.",
      "Augustine sees this as the soul's personal commitment to divine worship, where individual exaltation leads to daily devotion and eternal praise of God's name."
    ),
    (
      "Divine Greatness → Intergenerational Praise",
      "God's infinite greatness leading to praise across all generations",
      ["magnus", "dominus", "laudabilis", "magnitudo", "generatio", "laudo"],
      3,
      4,
      "The psalmist declares the Lord is great and greatly to be praised with no end to His greatness, then describes how generation after generation will praise His works and declare His power.",
      "For Augustine, God's infinite greatness transcends human comprehension and inspires perpetual worship across all generations, creating an unbroken chain of praise."
    ),
    (
      "Divine Splendor → Awesome Power",
      "The magnificence of God's holiness and the awesome power of His terrible acts",
      ["magnificentia", "gloria", "sanctitas", "virtus", "terribilis", "magnitudo"],
      5,
      6,
      "The psalmist describes how people will speak of the magnificence of God's holy glory and tell of His wondrous works, then speak of the might of His terrible acts and declare His greatness.",
      "Augustine sees this as the soul's recognition of both God's beautiful holiness and His awesome power, where divine splendor and terrifying majesty work together to inspire worship."
    ),
    (
      "Abundant Goodness → Divine Compassion",
      "The memory of God's abundant sweetness and His compassionate, patient nature",
      ["memoria", "abundantia", "suavitas", "iustitia", "miserator", "misericors", "patiens"],
      7,
      8,
      "The psalmist describes how people will publish the memory of God's abundant sweetness and rejoice in His justice, then declares the Lord is gracious, merciful, patient, and plenteous in mercy.",
      "For Augustine, this represents the soul's experience of God's dual nature - both His sweet goodness that brings joy and His patient compassion that provides comfort and forgiveness."
    ),
    (
      "Universal Kindness → All Creation",
      "God's sweetness to all creation and His tender mercies over all His works",
      ["suavis", "dominus", "universus", "miseratio", "super", "omnis", "opus"],
      9,
      9,
      "The psalmist declares the Lord is sweet to all and His tender mercies are over all His works, encompassing all creation in divine kindness.",
      "Augustine sees this as the culmination of divine love, where God's universal kindness extends to all creation, demonstrating His comprehensive care for everything He has made."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Titles and Attributes",
      "References to God's names and divine characteristics",
      ["deus", "dominus", "rex", "miserator", "misericors"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Praise and Worship",
      "Expressions of praise, blessing, and worship",
      ["exalto", "benedico", "laudo", "magnificentia", "gloria"],
      ThemeCategory.worship,
      1 ... 9
    ),
    (
      "Eternal Duration",
      "References to everlasting time and eternity",
      ["saeculum", "singulus", "dies", "generatio"],
      ThemeCategory.divine,
      1 ... 4
    ),
    (
      "Divine Power and Greatness",
      "God's power, greatness, and mighty works",
      ["magnus", "magnitudo", "potentia", "virtus", "terribilis"],
      ThemeCategory.divine,
      3 ... 6
    ),
    (
      "Divine Works",
      "References to God's works and deeds",
      ["opus", "mirabilis", "narro", "loquor"],
      ThemeCategory.divine,
      4 ... 6
    ),
    (
      "Divine Holiness",
      "God's holiness and sanctity",
      ["sanctitas", "iustitia", "magnificentia"],
      ThemeCategory.divine,
      5 ... 7
    ),
    (
      "Divine Mercy and Compassion",
      "God's mercy, compassion, and kindness",
      ["miserator", "misericors", "patiens", "suavis", "miseratio"],
      ThemeCategory.divine,
      7 ... 9
    ),
    (
      "Universal Scope",
      "References to all creation and universal scope",
      ["universus", "omnis", "super"],
      ThemeCategory.divine,
      9 ... 9
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 144A should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 144A English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm144a_texts.json"
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
      filename: "output_psalm144a_themes.json"
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

// MARK: - Psalm 144B Tests

class Psalm144BTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 144, category: "B")

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  private let expectedVerseCount = 13

  private let text = [
    "Confiteantur tibi, Domine, omnia opera tua: et sancti tui benedicant tibi.",
    "Gloriam regni tui dicent: et potentiam tuam loquentur:",
    "Ut notam faciant filiis hominum potentiam tuam: et gloriam magnificentiae regni tui.",
    "Regnum tuum regnum omnium saeculorum: et dominatio tua in omni generatione et generatione.",
    "Fidelis Dominus in omnibus verbis suis: et sanctus in omnibus operibus suis.",
    "Allevat Dominus omnes qui corruunt: et erigit omnes elisos.",
    "Oculi omnium in te sperant, Domine: et tu das escam illorum in tempore opportuno.",
    "Aperis tu manum tuam: et imples omne animal benedictione.",
    "Iustus Dominus in omnibus viis suis: et sanctus in omnibus operibus suis.",
    "Prope est Dominus omnibus invocantibus eum: omnibus qui invocant eum in veritate.",
    "Voluntatem timentium se faciet: et deprecationem eorum exaudiet, et salvos faciet eos.",
    "Custodit Dominus omnes diligentes se: et omnes peccatores disperdet.",
    "Laudationem Domini loquetur os meum: et benedicat omnis caro nomini sancto eius in saeculum, et in saeculum saeculi.",
  ]

  private let englishText = [
    "Let all thy works, O Lord, praise thee: and let thy saints bless thee.",
    "They shall speak of the glory of thy kingdom: and shall tell of thy power:",
    "To make thy might known to the sons of men: and the glory of the magnificence of thy kingdom.",
    "Thy kingdom is a kingdom of all ages: and thy dominion endureth throughout all generations.",
    "The Lord is faithful in all his words: and holy in all his works.",
    "The Lord lifteth up all that fall: and setteth up all that are cast down.",
    "The eyes of all hope in thee, O Lord: and thou givest them meat in due season.",
    "Thou openest thy hand: and fillest every living creature with thy blessing.",
    "The Lord is just in all his ways: and holy in all his works.",
    "The Lord is nigh unto all that call upon him: to all that call upon him in truth.",
    "He will do the will of them that fear him: and he will hear their cry, and will save them.",
    "The Lord keepeth all them that love him: but all the wicked he will destroy.",
    "My mouth shall speak the praise of the Lord: and let all flesh bless his holy name for ever and ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["confiteor", "dominus", "omnis", "opus", "sanctus", "benedico"]),
    (2, ["gloria", "regnum", "dico", "potentia", "loquor"]),
    (3, ["notus", "facio", "filius", "homo", "potentia", "gloria", "magnificentia", "regnum"]),
    (4, ["regnum", "omnis", "saeculum", "dominatio", "generatio"]),
    (5, ["fidelis", "dominus", "omnis", "verbum", "sanctus", "opus"]),
    (6, ["allevo", "dominus", "omnis", "corruo", "erigo", "omnis", "elido"]),
    (7, ["oculus", "omnis", "spero", "dominus", "do", "esca", "tempus", "opportunus"]),
    (8, ["aperio", "manus", "impleo", "omnis", "animal", "benedictio"]),
    (9, ["iustus", "dominus", "omnis", "via", "sanctus", "opus"]),
    (10, ["prope", "dominus", "omnis", "invoco", "omnis", "invoco", "veritas"]),
    (11, ["voluntas", "timeo", "facio", "deprecatio", "exaudio", "salvus", "facio"]),
    (12, ["custodio", "dominus", "omnis", "diligo", "omnis", "peccator", "disperdo"]),
    (13, ["laudatio", "dominus", "loquor", "os", "benedico", "omnis", "caro", "nomen", "sanctus", "saeculum"]),
  ]

  private let structuralThemes = [
    (
      "Universal Praise → Kingdom Glory",
      "All creation praising God and speaking of His kingdom's glory and power",
      ["confiteor", "omnis", "opus", "sanctus", "gloria", "regnum", "potentia"],
      1,
      2,
      "All God's works are called to praise Him and His saints to bless Him, then they speak of the glory of His kingdom and tell of His power.",
      "Augustine sees this as the universal call to worship, where all creation joins in praising God and proclaiming the glory of His eternal kingdom."
    ),
    (
      "Kingdom Revelation → Eternal Dominion",
      "Making God's power known to humanity and declaring His eternal kingdom and dominion",
      ["notus", "facio", "filius", "homo", "potentia", "regnum", "saeculum", "dominatio", "generatio"],
      3,
      4,
      "The purpose is to make God's might known to the sons of men and the glory of His magnificent kingdom, then declaring His kingdom is of all ages and His dominion endures through all generations.",
      "For Augustine, this represents the revelation of God's eternal sovereignty, where His kingdom transcends time and His dominion extends through all generations of humanity."
    ),
    (
      "Divine Faithfulness → Divine Care",
      "God's faithfulness in words and works leading to His care for the fallen and provision for all",
      ["fidelis", "dominus", "verbum", "sanctus", "opus", "allevo", "corruo", "erigo", "elido"],
      5,
      6,
      "The Lord is faithful in all His words and holy in all His works, then He lifts up all who fall and sets up all who are cast down.",
      "Augustine sees this as the connection between God's faithful character and His compassionate care, where His holiness and faithfulness lead to His tender mercy toward the fallen."
    ),
    (
      "Divine Provision → Divine Justice",
      "God's provision for all creation leading to His justice and holiness in all His ways",
      ["oculus", "spero", "esca", "tempus", "aperio", "manus", "impleo", "animal", "benedictio", "iustus", "via", "sanctus"],
      7,
      9,
      "All eyes hope in the Lord who gives them food in due season, He opens His hand and fills every living creature with blessing, and He is just in all His ways and holy in all His works.",
      "For Augustine, God's universal provision demonstrates His justice and holiness, where His care for all creation reflects His perfect character and righteous ways."
    ),
    (
      "Divine Nearness → Divine Response",
      "God's nearness to those who call on Him leading to His response to their needs and protection of the faithful",
      ["prope", "invoco", "veritas", "voluntas", "timeo", "deprecatio", "exaudio", "salvus", "custodio", "diligo"],
      10,
      12,
      "The Lord is near to all who call on Him in truth, He does the will of those who fear Him and hears their cry to save them, and He keeps all who love Him but destroys the wicked.",
      "Augustine sees this as the intimate relationship between divine nearness and divine response, where God's proximity to the faithful leads to His protection and salvation while His justice deals with the wicked."
    ),
    (
      "Eternal Praise → Universal Blessing",
      "The psalmist's commitment to praise leading to universal blessing of God's holy name",
      ["laudatio", "dominus", "loquor", "os", "benedico", "omnis", "caro", "nomen", "sanctus", "saeculum"],
      13,
      13,
      "The psalmist's mouth will speak the praise of the Lord and all flesh will bless His holy name forever and ever.",
      "For Augustine, this represents the culmination of worship where individual praise leads to universal blessing, and the eternal nature of God's name calls for perpetual adoration from all creation."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Titles and Attributes",
      "References to God's names and divine characteristics",
      ["dominus", "sanctus", "fidelis", "iustus"],
      ThemeCategory.divine,
      1 ... 13
    ),
    (
      "Universal Scope",
      "References to all creation and universal scope",
      ["omnis", "omnia", "universus", "caro"],
      ThemeCategory.divine,
      1 ... 13
    ),
    (
      "Praise and Worship",
      "Expressions of praise, blessing, and worship",
      ["confiteor", "benedico", "laudatio", "gloria"],
      ThemeCategory.worship,
      1 ... 13
    ),
    (
      "Divine Kingdom",
      "References to God's kingdom and dominion",
      ["regnum", "dominatio", "saeculum", "generatio"],
      ThemeCategory.divine,
      2 ... 4
    ),
    (
      "Divine Power and Works",
      "God's power, works, and mighty deeds",
      ["potentia", "opus", "magnificentia", "verbum"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Divine Care and Provision",
      "God's care, provision, and protection",
      ["allevo", "erigo", "esca", "aperio", "impleo", "benedictio", "custodio"],
      ThemeCategory.divine,
      6 ... 12
    ),
    (
      "Human Response",
      "Human calling, fearing, and loving God",
      ["invoco", "veritas", "timeo", "diligo", "deprecatio"],
      ThemeCategory.virtue,
      10 ... 12
    ),
    (
      "Eternal Duration",
      "References to everlasting time and eternity",
      ["saeculum", "generatio"],
      ThemeCategory.divine,
      4 ... 13
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 144B should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 144B English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm144b_texts.json"
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
      filename: "output_psalm144b_themes.json"
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
