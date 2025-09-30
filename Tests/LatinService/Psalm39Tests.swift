@testable import LatinService
import XCTest

class Psalm39Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  let verbose = true

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  let id = PsalmIdentity(number: 39, category: "")
  private let expectedVerseCount = 25

  let text = [
    /* 1 */ "Expectans expectavi Dominum, et intendit mihi.",
    /* 2 */ "Et exaudivit preces meas; et eduxit me de lacu Misericordiae, et de luto faecis.",
    /* 3 */ "Et statuit super petram pedes meos, et direxit gressus meos.",
    /* 4 */ "Et immisit in os meum canticum novum, hymnum Deo nostro.",
    /* 5 */ "Videbunt multi, et timebunt, et sperabunt in Domino.",
    /* 6 */ "Beatus vir cujus est nomen Domini spes eius, et non respexit in vanitates et insanias falsas.",
    /* 7 */ "Multa fecisti tu, Domine Deus meus, mirabilia tua; et cogitationibus tuis non est qui similis sit tibi.",
    /* 8 */ "Annuntiavi et locutus sum; multiplicati sunt super numerum.",
    /* 9 */ "Sacrificium et oblationem noluisti; aures autem perfecisti mihi.",
    /* 10 */ "Holocaustum et pro peccato non postulasti; tunc dixi: Ecce venio.",
    /* 11 */ "In capite libri scriptum est de me ut facerem voluntatem tuam.",
    /* 12 */ "Deus meus, volui, et legem tuam in medio cordis mei.",
    /* 13 */ "Annuntiavi iustitiam tuam in ecclesia magna; ecce labia mea non prohibebo, Domine, tu scisti.",
    /* 14 */ "iustitiam tuam non abscondi in corde meo; veritatem tuam et salutare tuum dixi.",
    /* 15 */ "Non abscondi misericordiam tuam et veritatem tuam a concilio multo.",
    /* 16 */ "Tu autem, Domine, ne longe facias miserationes tuas a me; misericordia tua et veritas tua semper susceperunt me.",
    /* 17 */ "Quoniam circumdederunt me mala quorum non est numerus; comprehenderunt me iniquitates meae, et non potui ut viderem.",
    /* 18 */ "Multiplicatae sunt super capillos capitis mei, et cor meum dereliquit me.",
    /* 19 */ "Complaceat tibi, Domine, ut eripias me; Domine, ad adiuvandum me respice.",
    /* 20 */ "Confundantur et revereantur simul, qui quaerunt animam meam ut auferant eam;",
    /* 21 */ "Convertantur retrorsum et revereantur, qui volunt mihi mala.",
    /* 22 */ "Ferant confestim confusionem suam, qui dicunt mihi: Euge, euge.",
    /* 23 */ "Exsultent et laetentur super te omnes quaerentes te; et dicant semper: Magnificetur Dominus, qui diligunt salutare tuum.",
    /* 24 */ "Ego autem mendicus sum et pauper; Dominus sollicitus est mei.",
    /* 25 */ "adiutor meus et protector meus tu es; Deus meus, ne tardaveris.",
  ]

  private let englishText = [
    /* 1 */ "With expectation I have waited for the Lord, and he was attentive to me.",
    /* 2 */ "And he heard my prayers, and brought me out of the pit of misery and the mire of dregs.",
    /* 3 */ "And he set my feet upon a rock, and directed my steps.",
    /* 4 */ "And he put a new canticle into my mouth, a song to our God.",
    /* 5 */ "Many shall see, and shall fear; and they shall hope in the Lord.",
    /* 6 */ "Blessed is the man whose trust is in the name of the Lord; and who hath not had regard to vanities, and lying follies.",
    /* 7 */ "Thou hast multiplied thy wonderful works, O Lord my God; and in thy thoughts there is no one like to thee.",
    /* 8 */ "I have declared and I have spoken; they are multiplied above number.",
    /* 9 */ "Sacrifice and oblation thou didst not desire; but thou hast pierced ears for me.",
    /* 10 */ "Burnt offering and sin offering thou didst not require; then said I: Behold I come.",
    /* 11 */ "In the head of the book it is written of me that I should do thy will.",
    /* 12 */ "O my God, I have desired it, and thy law in the midst of my heart.",
    /* 13 */ "I have declared thy justice in a great church; lo, I will not restrain my lips, O Lord, thou knowest it.",
    /* 14 */ "I have not hid thy justice within my heart; I have declared thy truth and thy salvation.",
    /* 15 */ "I have not concealed thy mercy and thy truth from a great council.",
    /* 16 */ "Withhold not thou, O Lord, thy tender mercies from me; thy mercy and thy truth have always upheld me.",
    /* 17 */ "For evils without number have surrounded me; my iniquities have overtaken me, and I was not able to see.",
    /* 18 */ "They are multiplied above the hairs of my head; and my heart hath forsaken me.",
    /* 19 */ "Be pleased, O Lord, to deliver me; look down, O Lord, to help me.",
    /* 20 */ "Let them be confounded and ashamed together, that seek after my soul to take it away.",
    /* 21 */ "Let them be turned backward and blush for shame that desire evils to me.",
    /* 22 */ "Let them immediately bear their confusion, that say to me: 'Tis well, 'tis well.",
    /* 23 */ "Let all that seek thee rejoice and be glad in thee; and let such as love thy salvation say always: The Lord be magnified.",
    /* 24 */ "But I am a beggar and poor; the Lord is careful for me.",
    /* 25 */ "Thou art my helper and my protector; O my God, be not slack.",
  ]

  private let structuralThemes = [
    (
      "Waiting → Hearing",
      "Patient expectation met with divine attention",
      ["expecto", "exaudio", "prex", "lacus"],
      1,
      2,
      "From waiting on the Lord to being heard and delivered from the pit",
      "Augustine sees this as the pattern of prayer - patient waiting met with God's attentive hearing and deliverance"
    ),
    (
      "Foundation → Direction",
      "Firm establishment leading to guided steps",
      ["petra", "pes", "dirigo", "gressus"],
      3,
      4,
      "God sets feet on rock and directs paths with a new song",
      "Augustine interprets the rock as Christ and the new song as the Gospel of salvation"
    ),
    (
      "Witness → Hope",
      "Public testimony inspiring fear and hope in others",
      ["video", "timeo", "spero", "beatus"],
      5,
      6,
      "Many see God's work, fear, and hope in the Lord",
      "Augustine sees this as the effect of Christ's resurrection - inspiring awe and hope in believers"
    ),
    (
      "Wonder → Proclamation",
      "God's marvelous works leading to multiplied testimony",
      ["mirabilis", "cogitatio", "annuntio", "multiplex"],
      7,
      8,
      "God's incomparable works compel abundant declaration",
      "Augustine views this as the apostolic mission spreading the wonder of salvation"
    ),
    (
      "Sacrifice → Obedience",
      "Ritual offerings replaced by willing submission",
      ["sacrificium", "oblatio", "auris", "holocaustum"],
      9,
      10,
      "God desires obedient ears over ritual sacrifice",
      "Augustine applies this to Christ's perfect obedience replacing inadequate sacrifices"
    ),
    (
      "Will → Delight",
      "Written obligation becomes heartfelt desire",
      ["liber", "voluntas", "volo", "lex"],
      11,
      12,
      "External command to do God's will becomes internal delight",
      "Augustine sees this as the transition from law to grace - duty becoming desire"
    ),
    (
      "Declaration → Revelation",
      "Public proclamation of God's justice and truth",
      ["annuntio", "iustitia", "ecclesia", "veritas"],
      13,
      14,
      "Open declaration of God's justice and salvation truth",
      "Augustine interprets this as Christ's open teaching in the great assembly"
    ),
    (
      "Mercy → Support",
      "Continuous divine mercy upholding the believer",
      ["misericordia", "veritas", "abscondo", "suscipio"],
      15,
      16,
      "Prayer for ongoing mercy while upheld by God's faithfulness",
      "Augustine sees this as the believer's dependence on God's unchanging mercy"
    ),
    (
      "Overwhelm → Despair",
      "Innumerable evils leading to heart failure",
      ["circumdo", "malum", "iniquitas", "cor"],
      17,
      18,
      "Countless troubles and sins overwhelm to the point of despair",
      "Augustine interprets this as the human condition without grace - overwhelmed by sin"
    ),
    (
      "Rescue → Shame",
      "Plea for deliverance and enemy confusion",
      ["eripio", "adiuvo", "confundor", "anima"],
      19,
      20,
      "Cry for help with prayer for enemy shame and reversal",
      "Augustine sees this as the prayer of the righteous against spiritual enemies"
    ),
    (
      "Mockery → Vindication",
      "Enemies mocking while seekers rejoice",
      ["retrorsum", "confusio", "euge", "exsulto"],
      21,
      22,
      "Prayer for enemy confusion contrasts with rejoicing of God-seekers",
      "Augustine views this as the eschatological reversal - mockers shamed, seekers joyful"
    ),
    (
      "Poverty → Care",
      "Acknowledging need while trusting divine provision",
      ["mendicus", "pauper", "sollicitus", "magnificetur"],
      23,
      24,
      "Humble poverty met by God's careful attention and praise",
      "Augustine sees this as the beatitude of spiritual poverty - need opening to God's care"
    ),
    (
      "Help → Protection",
      "Divine assistance and timely intervention",
      ["adiutor", "protector", "tardo", "deus"],
      25,
      25,
      "Final affirmation of God as helper and protector",
      "Augustine interprets this as the Church's enduring confidence in God's timely help"
    ),
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["expecto", "dominus", "intendo"]),
    (2, ["exaudio", "prex", "educo", "lacus", "lutum", "faex"]),
    (3, ["statuo", "petra", "pes", "dirigo", "gressus"]),
    (4, ["immito", "os", "canticum", "novus", "hymnus", "deus"]),
    (5, ["video", "multus", "timeo", "spero", "dominus"]),
    (6, ["beatus", "vir", "nomen", "dominus", "spes", "respicio", "vanitas", "insania", "falsus"]),
    (7, ["multus", "facio", "dominus", "deus", "mirabilis", "cogitatio", "similis"]),
    (8, ["annuntio", "loquor", "multiplico", "super", "numerus"]),
    (9, ["sacrificium", "oblatio", "nolo", "auris", "perficio"]),
    (10, ["holocaustum", "peccatum", "postulo", "dico", "ecce", "venio"]),
    (11, ["caput", "liber", "scribo", "voluntas", "facio"]),
    (12, ["deus", "volo", "lex", "medius", "cor"]),
    (13, ["annuntio", "iustitia", "ecclesia", "magnus", "labium", "prohibeo", "dominus", "scio"]),
    (14, ["iustitia", "abscondo", "cor", "veritas", "salutaris", "dico"]),
    (15, ["abscondo", "misericordia", "veritas", "concilium", "multus"]),
    (16, ["dominus", "longe", "facio", "miseratio", "misericordia", "veritas", "semper", "suscipe"]),
    (17, ["circumdo", "malum", "numerus", "comprehendo", "iniquitas", "possum", "video"]),
    (18, ["multiplico", "super", "capillus", "caput", "cor", "derelinquo"]),
    (19, ["complaceo", "dominus", "eripio", "adiuvo", "respicio"]),
    (20, ["confundo", "revereor", "simul", "quaero", "anima", "aufero"]),
    (21, ["converto", "retrorsum", "revereor", "volo", "malum"]),
    (22, ["fero", "confestim", "confusio", "dico", "euge"]),
    (23, ["exsulto", "laetor", "super", "omnis", "quaero", "dico", "semper", "magnifico", "dominus", "diligo", "salutaris"]),
    (24, ["ego", "mendicus", "pauper", "dominus", "sollicitus"]),
    (25, ["adiutor", "protector", "deus", "tardo"]),
  ]
  private let conceptualThemes = [
    (
      "Patient Expectation",
      "Waiting on God with hopeful anticipation and trust",
      ["expecto", "intendo", "spero", "exaudio", "preces"],
      ThemeCategory.virtue,
      1 ... 6
    ),
    (
      "Divine Deliverance",
      "God's rescue from despair and firm establishment",
      ["exaudio", "lacus", "lutum", "petra", "eripio", "statuo", "dirigo"],
      ThemeCategory.divine,
      1 ... 19
    ),
    (
      "New Worship",
      "Transformation from external ritual to heartfelt obedience",
      ["canticum", "novus", "hymnus", "sacrificium", "oblatio", "voluntas", "lex"],
      ThemeCategory.worship,
      4 ... 12
    ),
    (
      "Public Testimony",
      "Open declaration of God's works, justice and truth",
      ["annuntio", "loquor", "ecclesia", "iustitia", "veritas", "testimonium", "concilium"],
      ThemeCategory.virtue,
      8 ... 16
    ),
    (
      "Enemy Opposition",
      "Persecution, mockery and spiritual warfare",
      ["confundor", "revereor", "malum", "euge", "quaero", "anima", "hostis"],
      ThemeCategory.virtue,
      17 ... 22
    ),
    (
      "Divine Protection",
      "God as helper, defender and timely deliverer",
      ["adiutor", "protector", "sollicitus", "suscipe", "eripio", "refugium", "auxilium"],
      ThemeCategory.divine,
      16 ... 25
    ),
    (
      "Human Frailty",
      "Acknowledgment of poverty, sin and dependence",
      ["mendicus", "pauper", "iniquitas", "cor", "derelinquo", "humilitas", "peccatum"],
      ThemeCategory.virtue,
      17 ... 24
    ),
    (
      "Joyful Praise",
      "Exultation, magnification and celebration of God",
      ["exsulto", "laetor", "magnificetur", "hymnus", "canticum", "diligo", "salutare"],
      ThemeCategory.worship,
      4 ... 23
    ),
    (
      "Divine Marvels",
      "God's wonderful works and incomparable thoughts",
      ["mirabilis", "multus", "cogitatio", "similis", "misericordia", "veritas"],
      ThemeCategory.divine,
      7 ... 16
    ),
    (
      "Obedient Response",
      "Willing submission to God's will and law",
      ["voluntas", "facio", "venio", "volo", "lex", "obedientia", "desiderium"],
      ThemeCategory.virtue,
      10 ... 14
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 39 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 39 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm39_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testSavePsalm39Themes() {
    let utilities = PsalmTestUtilities.self

    // Generate and save themes JSON
    guard let themesJSON = utilities.generateCompleteThemesJSONString(
      psalmNumber: 39,
      conceptualThemes: conceptualThemes,
      structuralThemes: structuralThemes
    ) else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    // Save to file
    let success = utilities.saveToFile(
      content: themesJSON,
      filename: "output_psalm39_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(themesJSON)
    }
  }

  func testStructuralThemes() {
    let utilities = PsalmTestUtilities.self

    // Run the standard structural themes test
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testLineByLineKeyLemmas() {
    let utilities = PsalmTestUtilities.self

    // Run the standard line-by-line key lemmas test
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    let utilities = PsalmTestUtilities.self

    // Run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Test Cases

  func testExpectationAndWaiting() {
    let expectationTerms = [
      ("expecto", ["expectans", "expectavi"], "wait for"),
      ("intendo", ["intendit"], "attend to"),
      ("exaudio", ["exaudivit"], "hear"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: expectationTerms,
      verbose: verbose
    )
  }

  func testDeliveranceAndSalvation() {
    let deliveranceTerms = [
      ("educo", ["eduxit"], "bring out"),
      ("lacus", ["lacu"], "pit"),
      ("lutum", ["luto"], "mire"),
      ("faex", ["faecis"], "dregs"),
      ("eripio", ["eripias"], "deliver"),
      ("salutaris", ["salutare"], "salvation"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: deliveranceTerms,
      verbose: verbose
    )
  }

  func testFoundationAndGuidance() {
    let foundationTerms = [
      ("petra", ["petram"], "rock"),
      ("pes", ["pedes"], "foot"),
      ("dirigo", ["direxit"], "direct"),
      ("gressus", ["gressus"], "steps"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: foundationTerms,
      verbose: verbose
    )
  }

  func testNewSongAndPraise() {
    let praiseTerms = [
      ("canticum", ["canticum"], "song"),
      ("novus", ["novum"], "new"),
      ("hymnus", ["hymnum"], "hymn"),
      ("laetor", ["laetentur"], "rejoice"),
      ("exsulto", ["exsultent"], "exult"),
      ("magnifico", ["magnificetur"], "magnify"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: praiseTerms,
      verbose: verbose
    )
  }

  func testSacrificeAndObedience() {
    let sacrificeTerms = [
      ("sacrificium", ["sacrificium"], "sacrifice"),
      ("oblatio", ["oblationem"], "offering"),
      ("holocaustum", ["holocaustum"], "burnt offering"),
      ("peccatum", ["peccato"], "sin"),
      ("voluntas", ["voluntatem"], "will"),
      ("lex", ["legem"], "law"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: sacrificeTerms,
      verbose: verbose
    )
  }

  func testJusticeAndTruth() {
    let justiceTerms = [
      ("iustitia", ["iustitiam"], "justice"),
      ("veritas", ["veritatem", "veritas"], "truth"),
      ("misericordia", ["misericordiam", "misericordia"], "mercy"),
      ("ecclesia", ["ecclesia"], "church"),
      ("concilium", ["concilio"], "council"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: justiceTerms,
      verbose: verbose
    )
  }

  func testIniquityAndDistress() {
    let distressTerms = [
      ("malum", ["mala"], "evil"),
      ("numerus", ["numerum", "numerus"], "number"),
      ("iniquitas", ["iniquitates"], "iniquity"),
      ("capillus", ["capillos"], "hair"),
      ("derelinquo", ["dereliquit"], "forsake"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: distressTerms,
      verbose: verbose
    )
  }

  func testConfusionAndShame() {
    let confusionTerms = [
      ("confundo", ["confundantur", "confusionem"], "confound"),
      ("revereor", ["revereantur"], "be ashamed"),
      ("retrorsum", ["retrorsum"], "backward"),
      ("confestim", ["confestim"], "immediately"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: confusionTerms,
      verbose: verbose
    )
  }

  func testPovertyAndDependence() {
    let povertyTerms = [
      ("mendicus", ["mendicus"], "beggar"),
      ("pauper", ["pauper"], "poor"),
      ("sollicitus", ["sollicitus"], "careful"),
      ("adiutor", ["adiutor"], "helper"),
      ("protector", ["protector"], "protector"),
      ("tardo", ["tardaveris"], "be slow"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: povertyTerms,
      verbose: verbose
    )
  }
}
