@testable import LatinService
import XCTest

class Psalm131Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 131, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 19
  private let text = [
    "Memento, Domine, David, et omnis mansuetudinis eius.",
    "Sicut iuravit Domino, votum vovit Deo Iacob:",
    "Si introiero in tabernaculum domus meae, si ascendero in lectum strati mei:",
    "Si dedero somnum oculis meis, et palpebris meis dormitationem:",
    "Et requiem temporibus meis: donec inveniam locum Domino, tabernaculum Deo Iacob.",

    "Ecce audivimus eam in Ephrata: invenimus eam in campis silvae.",
    "Introibimus in tabernaculum eius: adorabimus in loco ubi steterunt pedes eius.",
    "Surge, Domine, in requiem tuam, tu et arca sanctificationis tuae.",
    "Sacerdotes tui induantur iustitiam: et sancti tui exsultent.",
    "Propter David servum tuum, non avertas faciem Christi tui.",

    "Iuravit Dominus David veritatem, et non frustrabitur eam: De fructu ventris tui ponam super sedem tuam.",
    "Si custodierint filii tui testamentum meum, et testimonia mea haec, quae docebo eos:",
    "Et filii eorum usque in saeculum, sedebunt super sedem tuam.",
    "Quoniam elegit Dominus Sion: elegit eam in habitationem sibi.",
    "Haec requies mea in saeculum saeculi: hic habitabo, quoniam elegi eam.",

    "Viduam eius benedicens benedicam: pauperes eius saturabo panibus.",
    "Sacerdotes eius induam salutari: et sancti eius exsultatione exsultabunt.",
    "Illuc producam cornu David: paravi lucernam Christo meo.",
    "Inimicos eius induam confusione: super ipsum autem efflorebit sanctificatio mea.",
  ]

  private let englishText = [
    "Remember, O Lord, David, and all his meekness.",
    "How he swore to the Lord, he vowed a vow to the God of Jacob:",
    "If I shall enter into the tabernacle of my house: if I shall go up into the bed wherein I lie:",
    "If I shall give sleep to mine eyes, or slumber to mine eyelids,",
    "Or rest to my temples: until I find out a place for the Lord, a tabernacle for the God of Jacob.",
    "Behold we have heard of it in Ephrata: we have found it in the fields of the wood.",
    "We will go into his tabernacle: we will adore in the place where his feet stood.",
    "Arise, O Lord, into thy resting place: thou and the ark of thy sanctification.",
    "Let thy priests be clothed with justice: and let thy saints rejoice.",
    "For thy servant David's sake, turn not away the face of thy anointed.",
    "The Lord hath sworn truth to David, and he will not make it void: Of the fruit of thy womb I will set upon thy throne.",
    "If thy children will keep my covenant, and these my testimonies which I shall teach them:",
    "Their children also for evermore shall sit upon thy throne.",
    "For the Lord hath chosen Sion: he hath chosen it for his dwelling.",
    "This is my rest for ever and ever: here will I dwell, for I have chosen it.",
    "Blessing I will bless her widow: I will satisfy her poor with bread.",
    "I will clothe her priests with salvation: and her saints shall rejoice with exceeding joy.",
    "There will I bring forth a horn to David: I have prepared a lamp for my anointed.",
    "His enemies I will clothe with confusion: but upon him shall my sanctification flourish.",
  ]

  private let lineKeyLemmas = [
    (1, ["memini", "dominus", "david", "mansuetudo"]),
    (2, ["sicut", "iuro", "votum", "voveo", "iacob"]),
    (3, ["si", "introeo", "tabernaculum", "domus", "ascendo", "lectus", "stratum"]),
    (4, ["si", "do", "somnus", "oculus", "palpebra", "dormitatio"]),
    (5, ["requies", "tempus", "donec", "invenio", "locus", "tabernaculum", "iacob"]),
    (6, ["ecce", "audio", "ephrata", "invenio", "campus", "silva"]),
    (7, ["introeo", "tabernaculum", "adoro", "locus", "sto", "pes"]),
    (8, ["surgo", "requies", "arca", "sanctificatio"]),
    (9, ["sacerdos", "induo", "iustitia", "sanctus", "exsulto"]),
    (10, ["propter", "david", "servus", "averto", "facies", "christus"]),
    (11, ["iuro", "veritas", "frustror", "fructus", "venter", "pono", "sedes"]),
    (12, ["si", "custodio", "filius", "testamentum", "testimonium", "doceo"]),
    (13, ["filius", "usque", "saeculum", "sedeo", "sedes"]),
    (14, ["quoniam", "eligo", "sion", "habitatio"]),
    (15, ["requies", "saeculum", "hic", "habito", "eligo"]),
    (16, ["vidua", "benedico", "pauper", "saturo", "panis"]),
    (17, ["sacerdos", "induo", "salutare", "sanctus", "exsultatio"]),
    (18, ["illuc", "produco", "cornu", "david", "paro", "lucerna", "christus"]),
    (19, ["inimicus", "induo", "confusio", "effloreo", "sanctificatio"]),
  ]

  private let structuralThemes = [
    (
      "Davidic Covenant Remembrance → Sacred Oaths",
      "Opening plea to remember David's meekness and his sacred vows to God",
      ["memini", "dominus", "david", "mansuetudo", "iuro", "votum", "voveo", "iacob"],
      1,
      2,
      "The psalm opens with a plea to remember David and his meekness, then recounts how he swore sacred vows to the Lord and vowed to the God of Jacob.",
      "Augustine sees this as establishing the foundation of the Davidic covenant - David's humility and faithfulness become the basis for divine promises that extend through generations."
    ),
    (
      "Personal Sacrifice → Divine Dwelling Quest",
      "David's personal sacrifice and commitment to finding a place for God's dwelling",
      ["si", "introeo", "tabernaculum", "domus", "ascendo", "lectus", "somnus", "requies", "donec", "invenio", "locus"],
      3,
      5,
      "David makes a series of conditional statements about personal comforts he will forego until he finds a place for the Lord's tabernacle, showing his complete dedication to God's dwelling.",
      "Augustine interprets this as the soul's willingness to sacrifice all earthly comforts and pleasures in pursuit of establishing God's presence, reflecting the ultimate priority of divine worship."
    ),
    (
      "Geographic Discovery → Temple Worship",
      "Discovery of the temple location and communal worship declaration",
      ["ecce", "audio", "ephrata", "invenio", "campus", "silva", "introeo", "tabernaculum", "adoro", "locus", "sto", "pes"],
      6,
      7,
      "The psalm recounts hearing about the temple in Ephrata and finding it in the fields of the wood, then declares communal intention to enter and worship in the sacred space where God's feet stood.",
      "Augustine sees this as the community's response to divine revelation - once God's dwelling place is revealed, the faithful commit to corporate worship and adoration in that sacred space."
    ),
    (
      "Ark Petition → Priestly Blessing",
      "Call for God to arise with the ark and blessing for priests",
      ["surgo", "requies", "arca", "sanctificatio", "sacerdos", "induo", "iustitia", "sanctus", "exsulto"],
      8,
      9,
      "The psalm calls for God to arise into His resting place with the ark of sanctification, then requests that priests be clothed with justice and saints rejoice.",
      "Augustine interprets this as the soul's prayer for divine presence and proper worship - God's ark represents His covenant presence, and the priests' righteousness enables true worship."
    ),
    (
      "Davidic Intercession → Unbreakable Covenant",
      "Appeal based on David's service leading to divine covenant promises",
      ["propter", "david", "servus", "averto", "facies", "christus", "iuro", "veritas", "frustror", "fructus", "venter", "pono", "sedes"],
      10,
      11,
      "The psalm appeals for God not to turn away from His anointed for David's sake, then declares God's unbreakable oath to David regarding his offspring on the throne.",
      "Augustine sees this as the foundation of messianic hope - David's faithful service becomes the basis for eternal covenant promises that ultimately point to Christ's eternal reign."
    ),
    (
      "Conditional Covenant → Eternal Dynasty",
      "Conditional aspects of the covenant leading to eternal dynastic promises",
      ["si", "custodio", "filius", "testamentum", "testimonium", "doceo", "filius", "usque", "saeculum", "sedeo", "sedes"],
      12,
      13,
      "The psalm establishes conditional aspects of the covenant (if children keep testimonies) and promises eternal dynasty for those who remain faithful.",
      "Augustine interprets this as showing the bilateral nature of God's covenant - divine promises are sure, but require human faithfulness, leading to eternal blessings for the faithful."
    ),
    (
      "Zion Election → Eternal Rest",
      "God's choice of Zion as His dwelling leading to eternal rest",
      ["eligo", "sion", "habitatio", "requies", "saeculum", "hic", "habito", "eligo"],
      14,
      15,
      "The psalm declares God's election of Zion as His dwelling place and establishes it as His eternal rest where He will dwell forever because He has chosen it.",
      "Augustine sees this as the culmination of God's dwelling quest - Zion becomes the permanent place of divine presence and eternal rest, chosen by God's sovereign will."
    ),
    (
      "Social Justice → Priestly Blessing",
      "Care for the vulnerable leading to priestly and saintly blessing",
      ["vidua", "benedico", "pauper", "saturo", "panis", "sacerdos", "induo", "salutare", "sanctus", "exsultatio"],
      16,
      17,
      "The psalm promises blessing for widows and satisfaction for the poor with bread, then declares that priests will be clothed with salvation and saints will rejoice exceedingly.",
      "Augustine interprets this as the social dimension of God's kingdom - divine blessing extends to the most vulnerable, and this care enables proper worship and priestly ministry."
    ),
    (
      "Messianic Promise → Divine Victory",
      "Davidic messianic promises leading to divine victory over enemies",
      ["produco", "cornu", "david", "paro", "lucerna", "christus", "inimicus", "induo", "confusio", "effloreo", "sanctificatio"],
      18,
      19,
      "The psalm promises to bring forth David's horn and prepare a lamp for His anointed, then declares that enemies will be clothed with confusion while His sanctification flourishes.",
      "Augustine sees this as the ultimate fulfillment of the Davidic covenant - the Messiah will be raised up, and through Him God will achieve complete victory over all enemies while establishing His holy kingdom."
    ),
  ]

  private let conceptualThemes = [
    (
      "Davidic Covenant",
      "References to David and the eternal covenant with his house",
      ["david", "iuro", "votum", "voveo", "testamentum", "fructus", "venter", "sedes", "cornu", "christus"],
      ThemeCategory.divine,
      1 ... 19
    ),
    (
      "Divine Dwelling",
      "References to God's dwelling place, tabernacle, and temple",
      ["tabernaculum", "domus", "locus", "habitatio", "requies", "habito", "sion", "eligo"],
      ThemeCategory.worship,
      1 ... 19
    ),
    (
      "Personal Sacrifice",
      "David's commitment to sacrifice personal comforts for God's service",
      ["si", "introeo", "ascendo", "lectus", "somnus", "dormitatio", "requies", "donec"],
      ThemeCategory.virtue,
      3 ... 5
    ),
    (
      "Priestly Ministry",
      "References to priests, their garments, and their blessing",
      ["sacerdos", "induo", "iustitia", "salutare", "sanctus", "exsulto", "exsultatio"],
      ThemeCategory.worship,
      8 ... 17
    ),
    (
      "Social Justice",
      "Care for the vulnerable and marginalized in society",
      ["vidua", "pauper", "saturo", "panis", "benedico"],
      ThemeCategory.virtue,
      16 ... 16
    ),
    (
      "Temporal and Eternal",
      "References to time, eternity, and perpetual duration",
      ["saeculum", "usque", "in", "aeternum", "hic", "requies"],
      ThemeCategory.divine,
      5 ... 19
    ),
    (
      "Geographic and Sacred Space",
      "References to specific places and sacred locations",
      ["ephrata", "campus", "silva", "sion", "locus", "pes", "arca"],
      ThemeCategory.worship,
      6 ... 15
    ),
    (
      "Divine Victory",
      "God's triumph over enemies and establishment of His kingdom",
      ["inimicus", "confusio", "effloreo", "sanctificatio", "surgo", "produco"],
      ThemeCategory.divine,
      8 ... 19
    ),
    (
      "Family and Lineage",
      "References to children, offspring, and generational continuity",
      ["filius", "venter", "fructus", "testamentum", "testimonium", "doceo"],
      ThemeCategory.divine,
      11 ... 13
    ),
    (
      "Divine Attributes",
      "References to God's character and qualities",
      ["dominus", "veritas", "iustitia", "sanctificatio", "salutare", "mansuetudo"],
      ThemeCategory.divine,
      1 ... 19
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 131 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 131 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm131_texts.json"
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
      filename: "output_psalm131_themes.json"
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
