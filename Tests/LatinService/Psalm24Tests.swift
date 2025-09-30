import XCTest

@testable import LatinService

class Psalm24Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 24, category: "")
  private let expectedVerseCount = 23

  private let text = [
    /* 1 */
    "Ad te, Domine, levavi animam meam: Deus meus, in te confido, non erubescam.",
    /* 2 */ "Neque irrideant me inimici mei: etenim universi qui te exspectant non confundentur.",
    /* 3 */ "Confundantur omnes iniqua agentes supervacue: ",
    /* 4 */ "vias tuas, Domine, demonstra mihi, et semitas tuas edoce me.",
    /* 5 */ "Dirige me in veritate tua, et doce me, quia tu es Deus salvator meus, et te sustinui tota die.",
    /* 6 */ "Reminiscere miserationum tuarum, Domine, et misericordiarum tuarum, quae a saeculo sunt.",
    /* 7 */ "Delicta iuventutis meae et ignorantias meas ne memineris: ",
    /* 8 */ "Secundum misericordiam tuam memento mei tu, propter bonitatem tuam, Domine.",
    /* 9 */ "Dulcis et rectus Dominus: propter hoc legem dabit delinquentibus in via.",
    /* 10 */ "Diriget mansuetos in iudicio, docebit mites vias suas.",
    /* 11 */ "Universae viae Domini misericordia et veritas, requirentibus testamentum eius et testimonia eius.",
    /* 12 */ "Propter nomen tuum, Domine, propitiaberis peccato meo: multum est enim.",
    /* 13 */ "Quis est homo qui timet Dominum? legem statuit ei in via quam elegit.",
    /* 14 */ "Anima eius in bonis demorabitur, et semen eius haereditabit terram.",
    /* 15 */ "Firmamentum est Dominus timentibus eum, et testamentum ipsius ut manifestetur illis.",
    /* 16 */ "Oculi mei semper ad Dominum, quoniam ipse evellet de laqueo pedes meos.",
    /* 17 */ "Respice in me, et miserere mei, quia unicus et pauper sum ego.",
    /* 18 */ "Tribulationes cordis mei multiplicatae sunt: de necessitatibus meis erue me.",
    /* 19 */ "Vide humilitatem meam et laborem meum, et dimitte omnia peccata mea.",
    /* 20 */ "Respice inimicos meos quoniam multiplicati sunt, et odio iniquo oderunt me.",
    /* 21 */ "Custodi animam meam, et erue me: non erubescam quoniam speravi in te.",
    /* 22 */ "Innocentes et recti adhaeserunt mihi, quia sustinui te.",
    /* 23 */ "Libera, Deus, Israel ex omnibus tribulationibus suis.",
  ]

  private let englishText = [
    /* 1 */
    "To you, O Lord, I lift up my soul; my God, in you I trust, let me not be put to shame.",
    /* 2 */ "Nor let my enemies laugh at me; for none who wait for you shall be confounded.",
    /* 3 */ "Let all be put to shame who act unjustly vainly; ",
    /* 4 */ "show me your ways, O Lord, and teach me your paths.",
    /* 5 */ "Guide me in your truth and teach me, for you are God my savior, and for you I wait all the day.",
    /* 6 */ "Remember your compassion, O Lord, and your mercies, which are from of old.",
    /* 7 */ "Remember not the sins of my youth nor my transgressions; ",
    /* 8 */ "according to your mercy remember me, for your goodness' sake, O Lord.",
    /* 9 */ "Good and upright is the Lord; therefore he instructs sinners in the way.",
    /* 10 */ "He guides the humble in justice, he teaches the meek his ways.",
    /* 11 */ "All the paths of the Lord are mercy and truth, for those who seek his covenant and his testimonies.",
    /* 12 */ "For your name's sake, O Lord, pardon my guilt, for it is great.",
    /* 13 */ "Who is the man who fears the Lord? He will instruct him in the way he should choose.",
    /* 14 */ "His soul shall abide in prosperity, and his descendants shall inherit the land.",
    /* 15 */ "The Lord is the strength of those who fear him, and his covenant will be made known to them.",
    /* 16 */ "My eyes are ever toward the Lord, for he will pluck my feet out of the net.",
    /* 17 */ "Turn to me and have mercy on me, for I am alone and afflicted.",
    /* 18 */ "The troubles of my heart are multiplied; deliver me from my distress.",
    /* 19 */ "See my affliction and my toil, and forgive all my sins.",
    /* 20 */ "Consider my enemies, for they are many, and they hate me with cruel hatred.",
    /* 21 */ "Guard my soul and deliver me; let me not be put to shame, for I take refuge in you.",
    /* 22 */ "Let integrity and uprightness preserve me, for I wait for you.",
    /* 23 */ "Redeem Israel, O God, out of all his troubles.",
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["ad", "dominus", "levo", "anima", "deus", "confido", "erubesco"]),
    (2, ["neque", "irrideo", "inimicus", "universus", "exspecto", "confundo"]),
    (3, ["confundo", "omnis", "iniquus", "ago", "supervacue"]),
    (4, ["via", "dominus", "demonstro", "semita", "edoceo"]),
    (5, ["dirigo", "veritas", "doceo", "deus", "salvator", "sustineo", "totus", "dies"]),
    (6, ["reminiscor", "miseratio", "dominus", "misericordia", "saeculum"]),
    (7, ["delictum", "iuventus", "ignorantia", "memini"]),
    (8, ["secundum", "misericordia", "bonitas", "dominus"]),
    (9, ["dulcis", "rectus", "dominus", "propter", "lex", "do", "delinquo", "via"]),
    (10, ["dirigo", "mansuetus", "iudicium", "doceo", "mitis", "via"]),
    (11, ["universus", "via", "dominus", "misericordia", "veritas", "requiro", "testamentum", "testimonium"]),
    (12, ["propter", "nomen", "dominus", "propitio", "peccatum", "multus"]),
    (13, ["quis", "homo", "timeo", "dominus", "lex", "statuo", "via", "eligo"]),
    (14, ["anima", "bonus", "demoror", "semen", "haeredito", "terra"]),
    (15, ["firmamentum", "dominus", "timeo", "testamentum", "manifesto"]),
    (16, ["oculus", "semper", "dominus", "evello", "laqueus", "pes"]),
    (17, ["respicio", "misereor", "unicus", "pauper", "sum", "ego"]),
    (18, ["tribulatio", "cor", "multiplico", "necessitas", "eruo"]),
    (19, ["video", "humilitas", "labor", "dimitto", "omnis", "peccatum"]),
    (20, ["respicio", "inimicus", "multiplico", "odium", "iniquus", "odi"]),
    (21, ["custodio", "anima", "eruo", "erubesco", "spero"]),
    (22, ["innocens", "rectus", "adhaereo", "sustineo"]),
    (23, ["libero", "deus", "israel", "omnis", "tribulatio"]),
  ]

  private let structuralThemes = [
    (
      "Trust → Confidence",
      "Personal trust in God leading to confidence against enemies",
      [
        "ad", "dominus", "levo", "anima", "deus", "confido", "erubesco", "neque", "irrideo", "inimicus", "universus", "exspecto", "confundo",
      ],
      1,
      2,
      "The psalmist lifts his soul to God in trust, confident that those who wait for the Lord will not be confounded",
      "The opening establishes the psalmist's intimate relationship with God through the personal address 'Ad te, Domine' and the lifting of the soul. The trust expressed ('in te confido') is immediately contrasted with the confidence that enemies will not triumph over those who wait for God."
    ),
    (
      "Shame → Guidance",
      "Shame for the wicked contrasted with divine guidance for the righteous",
      [
        "confundo", "omnis", "iniquus", "ago", "supervacue", "via", "dominus", "demonstro", "semita", "edoceo",
      ],
      3,
      4,
      "The wicked will be put to shame while the psalmist seeks divine guidance and teaching",
      "The psalmist contrasts the shame that will come upon those who act unjustly with his own desire for divine guidance. The repetition of teaching verbs ('demonstra', 'edoce') emphasizes the psalmist's dependence on God's instruction."
    ),
    (
      "Guidance → Mercy",
      "Divine guidance and teaching contrasted with divine mercy and remembrance",
      [
        "dirigo", "veritas", "doceo", "deus", "salvator", "sustineo", "totus", "dies", "reminiscor", "miseratio", "dominus", "misericordia", "saeculum",
      ],
      5,
      6,
      "The psalmist seeks divine guidance and teaching, then asks God to remember His mercies from of old",
      "The psalmist asks for divine guidance in truth and teaching, recognizing God as his savior. This leads to a request for God to remember His eternal mercies and compassion from of old."
    ),
    (
      "Memory → Mercy",
      "Divine remembrance of mercy contrasted with forgetting of sins",
      [
        "delictum", "iuventus", "ignorantia", "memini", "secundum", "misericordia", "bonitas", "dominus",
      ],
      7,
      8,
      "The psalmist asks God to remember His mercies from of old while forgetting the sins of youth",
      "The psalmist appeals to God's eternal mercy and compassion, asking Him to remember His goodness while forgetting the transgressions of youth. This creates a beautiful contrast between divine memory of mercy and divine forgetfulness of sin."
    ),
    (
      "Instruction → Guidance",
      "Divine instruction for sinners and guidance for the humble",
      [
        "dulcis", "rectus", "dominus", "propter", "lex", "do", "delinquo", "via", "dirigo", "mansuetus", "iudicium", "doceo", "mitis",
      ],
      9,
      10,
      "The Lord's goodness leads to instruction for sinners and guidance for the humble",
      "The psalmist describes God's character as both sweet and upright, which motivates His instruction of sinners. The humble and meek receive special guidance and teaching, showing God's care for those who are teachable and gentle."
    ),
    (
      "Paths → Pardon",
      "All God's paths are mercy and truth, leading to pardon for sin",
      [
        "universus", "via", "dominus", "misericordia", "veritas", "requiro", "testamentum", "testimonium", "propter", "nomen", "propitio", "peccatum", "multus",
      ],
      11,
      12,
      "All God's ways are characterized by mercy and truth, and He pardons sin for His name's sake",
      "The psalmist declares that all of God's paths are marked by mercy and truth, especially for those who seek His covenant. The pardon of sin is granted not because of human merit but for the sake of God's own name and reputation."
    ),
    (
      "Fear → Inheritance",
      "Fear of the Lord leads to divine instruction and earthly inheritance",
      [
        "quis", "homo", "timeo", "dominus", "lex", "statuo", "via", "eligo", "anima", "bonus", "demoror", "semen", "haeredito", "terra",
      ],
      13,
      14,
      "Those who fear the Lord receive instruction and their descendants inherit the land",
      "The psalmist poses a rhetorical question about who fears the Lord, then describes the benefits: divine instruction in the chosen way, prosperity for the soul, and inheritance of the land for descendants. This shows the generational blessing of fearing God."
    ),
    (
      "Covenant → Watchfulness",
      "God's covenant with those who fear Him leads to constant watchfulness",
      [
        "firmamentum", "dominus", "timeo", "testamentum", "manifesto", "oculus", "semper", "evello", "laqueus", "pes",
      ],
      15,
      16,
      "The Lord is strength to those who fear Him, and the psalmist keeps his eyes on the Lord for deliverance",
      "The psalmist describes God as a firmament (foundation) for those who fear Him, with His covenant being made known to them. This leads to constant watchfulness, with eyes always on the Lord who will deliver from snares."
    ),
    (
      "Mercy → Deliverance",
      "Divine mercy toward the afflicted leads to deliverance from distress",
      [
        "respicio", "misereor", "unicus", "pauper", "sum", "ego", "tribulatio", "cor", "multiplico", "necessitas", "eruo",
      ],
      17,
      18,
      "The psalmist asks for mercy as one alone and afflicted, and for deliverance from multiplied troubles",
      "The psalmist describes himself as alone and poor, asking for God's mercy and deliverance from the multiplied troubles of his heart. This shows the psalmist's complete dependence on God in times of personal distress."
    ),
    (
      "Forgiveness → Protection",
      "Divine forgiveness of sins leads to protection from enemies",
      [
        "video", "humilitas", "labor", "dimitto", "omnis", "peccatum", "respicio", "inimicus", "multiplico", "odium", "iniquus", "odi",
      ],
      19,
      20,
      "The psalmist asks for forgiveness of sins and protection from multiplied enemies who hate him",
      "The psalmist asks God to see his humility and labor, forgiving all his sins. This is contrasted with the many enemies who hate him with cruel hatred, showing the psalmist's need for both forgiveness and protection."
    ),
    (
      "Refuge → Integrity",
      "Taking refuge in God leads to preservation through integrity and uprightness",
      [
        "custodio", "anima", "eruo", "erubesco", "spero", "innocens", "rectus", "adhaereo", "sustineo",
      ],
      21,
      22,
      "The psalmist takes refuge in God and is preserved by integrity and uprightness",
      "The psalmist asks God to guard his soul and deliver him, confident that he will not be put to shame because he has taken refuge in God. This leads to preservation through integrity and uprightness, showing the connection between divine refuge and moral character."
    ),
    (
      "Redemption → National Deliverance",
      "Personal redemption leads to national deliverance for Israel",
      [
        "libero", "deus", "israel", "omnis", "tribulatio",
      ],
      23,
      23,
      "The psalm concludes with a prayer for Israel's deliverance from all troubles",
      "The psalmist concludes with a prayer for Israel's national deliverance, showing that personal relationship with God ultimately serves the broader community. This final verse expands the individual psalmist's concerns to include the entire people of God."
    ),
  ]

  private let conceptualThemes = [
    (
      "Soul Lifting and Trust",
      "The intimate gesture of lifting the soul to God as an act of trust and devotion",
      ["levo", "anima", "confido"],
      ThemeCategory.virtue,
      1 ... 1
    ),
    (
      "Divine Teaching and Instruction",
      "God as teacher who shows paths, teaches truth, and instructs the humble",
      ["demonstro", "edoceo", "doceo", "dirigo", "veritas", "via", "semita", "lex", "statuo"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Mercy and Compassion",
      "God's eternal mercy, compassion, and goodness contrasted with human sin",
      ["miseratio", "misericordia", "misereor", "bonitas", "saeculum", "reminiscor"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Shame and Confusion",
      "The shame that comes upon the wicked versus the confidence of the righteous",
      ["confundo", "erubesco", "iniquus", "supervacue"],
      ThemeCategory.virtue,
      1 ... 23
    ),
    (
      "Divine Character",
      "God's nature as sweet, upright, and characterized by mercy and truth",
      ["dulcis", "rectus", "misericordia", "veritas", "bonitas"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Fear of the Lord",
      "The benefits and blessings that come from fearing God",
      ["timeo", "firmamentum", "testamentum", "manifesto"],
      ThemeCategory.virtue,
      1 ... 23
    ),
    (
      "Divine Protection and Deliverance",
      "God as protector, deliverer, and source of refuge from enemies and snares",
      ["salvator", "eruo", "evello", "custodio", "libero"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Personal Affliction and Humility",
      "The psalmist's experience of being alone, afflicted, and in need of mercy",
      ["unicus", "pauper", "tribulatio", "necessitas", "humilitas", "labor", "laqueus"],
      ThemeCategory.virtue,
      16 ... 19
    ),
    (
      "Enemy Opposition",
      "The presence of enemies who hate, mock, and oppose the psalmist",
      ["inimicus", "irrideo", "odi", "odium", "iniquus", "multiplico"],
      ThemeCategory.virtue,
      2 ... 20
    ),
    (
      "Divine Waiting and Patience",
      "The psalmist's patient waiting for God and expectation of His response",
      ["exspecto", "sustineo", "spero", "adhaereo"],
      ThemeCategory.virtue,
      1 ... 23
    ),
    (
      "Covenant and Testament",
      "God's covenant relationship with His people and His testimonies",
      ["testamentum", "testimonium", "requiro", "manifesto"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Sin and Forgiveness",
      "Human sinfulness contrasted with divine forgiveness and pardon",
      ["peccatum", "delictum", "dimitto", "propitio", "iuventus", "ignorantia"],
      ThemeCategory.virtue,
      1 ... 23
    ),
    (
      "National and Personal Scope",
      "The movement from personal relationship with God to national deliverance",
      ["israel", "omnis", "universus", "ego"],
      ThemeCategory.divine,
      1 ... 23
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 24 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 24 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
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
      filename: "output_psalm24_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
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

  func testTrustAndConfidence() {
    let trustTerms = [
      ("levo", ["levavi"], "lift"),
      ("anima", ["animam"], "soul"),
      ("confido", ["confido"], "trust"),
      ("erubesco", ["erubescam"], "be ashamed"),
      ("exspecto", ["exspectant"], "wait"),
      ("confundo", ["confundentur"], "be confounded"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: trustTerms,
      verbose: verbose
    )
  }

  func testDivineGuidance() {
    let guidanceTerms = [
      ("via", ["vias", "semitas", "via"], "way"),
      ("dominus", ["Domine", "Domine"], "Lord"),
      ("demonstro", ["demonstra"], "show"),
      ("edoceo", ["edoce"], "teach"),
      ("dirigo", ["Dirige", "Diriget"], "guide"),
      ("veritas", ["veritate", "veritas"], "truth"),
      ("doceo", ["doce", "docebit"], "teach"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: guidanceTerms,
      verbose: verbose
    )
  }

  func testDivineMercy() {
    let mercyTerms = [
      ("miseratio", ["miserationum"], "compassion"),
      ("misericordia", ["misericordiarum", "misericordiam"], "mercy"),
      ("saeculum", ["saeculo"], "age"),
      ("delictum", ["Delicta"], "transgression"),
      ("bonitas", ["bonitatem"], "goodness"),
      ("memini", ["memineris", "memento"], "remember"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: mercyTerms,
      verbose: verbose
    )
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
      filename: "output_psalm24_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
