import XCTest

@testable import LatinService

class Psalm49Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 49, category: nil)
  private let expectedVerseCount = 23

  private let text = [
    /* 1 */
    "Deus deorum, Dominus, locutus est, et vocavit terram ",
    "A solis ortu usque ad occasum. Ex Sion species decoris eius.",
    "Deus manifeste veniet. Deus noster, et non silebit; ",
    /* 3 */
    "ignis in conspectu eius exardescet, et in circuitu eius tempestas valida.",
    /* 4 */ "Advocabit caelum desursum, et terram, ut discernat populum suum.",
    /* 5 */ "Congregate illi sanctos eius, qui ordinant testamentum eius super sacrificia.",
    /* 6 */ "Et annuntiabunt caeli iustitiam eius, quoniam Deus iudex est.",
    /* 7 */
    "Audi, populus meus, et loquar; Israel, et testificabor tibi: Deus, Deus tuus ego sum.",
    /* 8 */ "Non in sacrificiis tuis arguam te; holocausta autem tua in conspectu meo sunt semper.",
    /* 9 */ "Non accipiam de domo tua vitulos, neque de gregibus tuis hircos.",
    /* 10 */ "Quoniam meae sunt omnes ferae silvarum, iumenta in montibus et boves.",
    /* 11 */ "Cognovi omnia volatilia caeli, et pulchritudo agri mecum est.",
    /* 12 */ "Si esuriero, non dicam tibi: meus est enim orbis terrae et plenitudo eius.",
    /* 13 */ "Numquid manducabo carnes taurorum? aut sanguinem hircorum potabo?",
    /* 14 */ "Immola Deo sacrificium laudis, et redde Altissimo vota tua.",
    /* 15 */ "Et invoca me in die tribulationis: eripiam te, et honorificabis me.",
    /* 16 */
    "Peccatori autem dixit Deus: Quare tu enarras iustitias meas, et assumis testamentum meum per os tuum?",
    /* 17 */ "Tu vero odisti disciplinam, et proiecisti sermones meos retrorsum.",
    /* 18 */ "Si videbas furem, currebas cum eo, et cum adulteris portionem tuam ponebas.",
    /* 19 */ "Os tuum abundavit malitia, et lingua tua concinnabat dolos.",
    /* 20 */ "Sedens adversus fratrem tuum loquebaris, et adversus filium matris tuae ponebas scandalum. Haec fecisti, et tacui;",
    /* 21 */
    "Existimasti inique quod ero tui similis: arguam te, et statuam contra faciem tuam.",
    /* 22 */ "Intelligite haec, qui obliviscimini Deum; nequando rapiat, et non sit qui eripiat.",
    /* 23 */
    "Sacrificium laudis honorificabit me; et illic iter, quo ostendam illi salutare Dei.",
  ]

  private let englishText = [
    /* 1 */
    "A Psalm of Asaph. The God of gods, the Lord has spoken, and he has called the earth from the rising of the sun to its setting.",
    /* 2 */ "Out of Zion, the perfection of beauty, God shines forth.",
    /* 3 */
    "Our God comes, and he will not be silent; a fire devours before him, and around him a mighty tempest rages.",
    /* 4 */ "He calls to the heavens above and to the earth, that he may judge his people.",
    /* 5 */ "Gather to him his faithful ones, who made a covenant with him by sacrifice.",
    /* 6 */ "The heavens declare his righteousness, for God himself is judge.",
    /* 7 */
    "Hear, O my people, and I will speak; O Israel, I will testify against you: I am God, your God.",
    /* 8 */
    "Not for your sacrifices do I rebuke you; your burnt offerings are continually before me.",
    /* 9 */ "I will not accept a bull from your house or goats from your folds.",
    /* 10 */ "For every beast of the forest is mine, the cattle on a thousand hills.",
    /* 11 */ "I know all the birds of the air, and all that moves in the field is mine.",
    /* 12 */ "If I were hungry, I would not tell you, for the world and all that is in it is mine.",
    /* 13 */ "Do I eat the flesh of bulls or drink the blood of goats?",
    /* 14 */ "Offer to God a sacrifice of thanksgiving, and pay your vows to the Most High.",
    /* 15 */ "Call upon me in the day of trouble; I will deliver you, and you shall glorify me.",
    /* 16 */
    "But to the wicked God says: What right have you to recite my statutes or take my covenant on your lips?",
    /* 17 */ "For you hate discipline, and you cast my words behind you.",
    /* 18 */ "If you see a thief, you are pleased with him, and you keep company with adulterers.",
    /* 19 */ "You give your mouth free rein for evil, and your tongue frames deceit.",
    /* 20 */ "You sit and speak against your brother; you slander your own mother's son.",
    /* 21 */
    "These things you have done, and I have been silent; you thought that I was one like yourself. But now I rebuke you and lay the charge before you.",
    /* 22 */
    "Mark this, then, you who forget God, lest I tear you apart, and there be none to deliver!",
    /* 23 */
    "He who brings thanksgiving as his sacrifice honors me; to him who orders his way aright I will show the salvation of God.",
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["deus", "dominus", "loquor", "voco", "terra", "sol", "ortus", "occasus"]),
    (2, ["sion", "species", "decor", "deus", "manifeste", "venio"]),
    (3, ["deus", "sileo", "ignis", "conspectus", "exardesco", "circuitus", "tempestas", "validus"]),
    (4, ["advoco", "caelum", "desursum", "terra", "discerno", "populus"]),
    (5, ["congrego", "sanctus", "ordino", "testamentum", "sacrificium"]),
    (6, ["annuntio", "caelum", "iustitia", "deus", "iudex"]),
    (7, ["audio", "populus", "loquor", "israel", "testificor", "deus"]),
    (8, ["sacrificium", "arguo", "holocaustum", "conspectus", "semper"]),
    (9, ["accipio", "domus", "vitulus", "grex", "hircus"]),
    (10, ["fera", "silva", "iumentum", "mons", "bos"]),
    (11, ["cognosco", "volatilis", "caelum", "pulchritudo", "ager"]),
    (12, ["esurio", "dico", "orbis", "terra", "plenitudo"]),
    (13, ["manduco", "caro", "taurus", "sanguis", "hircus", "poto"]),
    (14, ["immolo", "deus", "sacrificium", "laus", "reddo", "altissimus", "votum"]),
    (15, ["invoco", "dies", "tribulatio", "eripio", "honorifico"]),
    (16, ["peccator", "dico", "deus", "enarro", "iustitia", "assumo", "testamentum", "os"]),
    (17, ["odi", "disciplina", "proicio", "sermo", "retrorsum"]),
    (18, ["video", "fur", "curro", "adulter", "portio", "pono"]),
    (19, ["os", "abundo", "malitia", "lingua", "concinno", "dolus"]),
    (20, ["sedeo", "adversus", "frater", "loquor", "filius", "mater", "pono", "scandalum"]),
    (21, ["facio", "taceo", "existimo", "iniquus", "similis", "arguo", "statuo", "contra", "facies"]),
    (22, ["intellego", "obliviscor", "deus", "rapio", "eripio"]),
    (23, ["sacrificium", "laus", "honorifico", "iter", "ostendo", "salutaris", "deus"]),
  ]

  private let structuralThemes = [
    (
      "Divine Voice → Divine Glory",
      "God's universal summons from Zion's beauty",
      ["deus", "dominus", "loquor", "voco", "terra", "sol", "ortus", "occasus", "sion", "species", "decor", "manifeste", "venio"],
      1,
      2,
      "The God of gods speaks and summons the entire earth from sunrise to sunset, manifesting His glory from Zion's perfect beauty.",
      "Augustine sees this as God's universal revelation through Christ and the Church. Zion represents the City of God, from which divine truth radiates to all creation. God's voice calls all humanity to judgment, demonstrating His sovereignty over time and space."
    ),
    (
      "Fire → Judgment",
      "God's manifest coming with consuming fire and tempest",
      ["deus", "sileo", "ignis", "conspectus", "exardesco", "circuitus", "tempestas", "validus", "advoco", "caelum", "terra", "discerno", "populus"],
      3,
      4,
      "God comes visibly with devouring fire and mighty storm, calling heaven and earth as witnesses to judge His people.",
      "Augustine interprets the fire as divine judgment that purifies the righteous and consumes the wicked. God's silence ends at the final judgment when heaven and earth testify. The tempest represents the overwhelming power of divine justice that no human defense can withstand."
    ),
    (
      "Gathering → Declaration",
      "Saints assembled and righteousness proclaimed",
      ["congrego", "sanctus", "ordino", "testamentum", "sacrificium", "annuntio", "caelum", "iustitia", "deus", "iudex"],
      5,
      6,
      "The faithful who made covenant through sacrifice are gathered, while the heavens announce God's righteousness as the supreme Judge.",
      "Augustine sees the gathering of saints as the Church's assembly for final judgment. The covenant through sacrifice points to Christ's sacrifice that establishes the New Covenant. Heaven's proclamation of divine justice confirms that God's judgments are perfect and public."
    ),
    (
      "Divine Address → Sacrifice Rejection",
      "God speaks to Israel, not rebuking their sacrifices but seeking more",
      ["audio", "populus", "loquor", "israel", "testificor", "deus", "sacrificium", "arguo", "holocaustum", "conspectus", "semper"],
      7,
      8,
      "God commands His people to hear, testifying 'I am God, your God,' not rebuking their continual sacrifices but requiring something deeper.",
      "Augustine explains that God doesn't condemn external worship but demands internal transformation. The sacrifices are before God always, yet they're insufficient without true devotion. God seeks not the ritual but the heart—external religion without love is meaningless."
    ),
    (
      "Rejection → Divine Ownership",
      "God refuses animal offerings because all creation is His",
      ["accipio", "domus", "vitulus", "grex", "hircus", "fera", "silva", "iumentum", "mons", "bos"],
      9,
      10,
      "God will not accept bulls or goats from human households, for every wild beast and all cattle on the mountains belong to Him.",
      "Augustine teaches that God needs nothing from humans—all creatures are already His possession. Material offerings cannot obligate or benefit God. This reveals the futility of thinking sacrifices earn divine favor through transfer of property. True worship acknowledges God's absolute ownership."
    ),
    (
      "Omniscience → Self-Sufficiency",
      "God knows all creatures and lacks nothing",
      ["cognosco", "volatilis", "caelum", "pulchritudo", "ager", "esurio", "dico", "orbis", "terra", "plenitudo"],
      11,
      12,
      "God knows every bird of the air and all field's beauty is with Him; if hungry, He wouldn't tell us, for the world and its fullness are His.",
      "Augustine emphasizes divine self-sufficiency—God's knowledge is complete and His needs nonexistent. The rhetorical 'if I were hungry' reveals the absurdity of thinking God depends on human offerings. Creation exists for God's glory, not to supply His needs."
    ),
    (
      "Rhetorical Question → True Sacrifice",
      "From rejecting animal sacrifice to demanding thanksgiving",
      ["manduco", "caro", "taurus", "sanguis", "hircus", "poto", "immolo", "deus", "sacrificium", "laus", "reddo", "altissimus", "votum"],
      13,
      14,
      "Does God eat bull flesh or drink goat blood? No—He demands the sacrifice of praise and fulfillment of vows to the Most High.",
      "Augustine sees the transition from material to spiritual sacrifice. God doesn't consume physical offerings but desires the 'sacrifice of praise'—grateful worship from the heart. True sacrifice is thanksgiving and covenant faithfulness, foreshadowing Christ's perfect sacrifice of love."
    ),
    (
      "Invocation → Honor",
      "Call on God in trouble to experience deliverance and glorify Him",
      ["invoco", "dies", "tribulatio", "eripio", "honorifico", "peccator", "dico", "deus", "enarro", "iustitia", "assumo", "testamentum", "os"],
      15,
      16,
      "Call on God in distress and He will rescue you to His glory. But God challenges the wicked: Why do you recite My laws and claim My covenant?",
      "Augustine contrasts the righteous who cry to God in need with hypocrites who speak God's words without living them. True invocation brings deliverance and honor to God. False profession—reciting Scripture while rejecting its demands—is spiritual fraud that God exposes."
    ),
    (
      "Hatred → Complicity",
      "Rejecting discipline and joining with evil",
      ["odi", "disciplina", "proicio", "sermo", "retrorsum", "video", "fur", "curro", "adulter", "portio", "pono"],
      17,
      18,
      "You hate correction and cast My words behind you; when you see a thief, you run with him, and you join with adulterers.",
      "Augustine condemns the hypocrisy of professing faith while rejecting moral discipline. Throwing God's words 'behind' shows deliberate rejection. Running with thieves and keeping company with adulterers reveals that actions contradict words—communion with evil exposes false profession."
    ),
    (
      "Evil Speech → Slander",
      "Mouth overflowing with wickedness against family",
      ["os", "abundo", "malitia", "lingua", "concinno", "dolus", "sedeo", "adversus", "frater", "loquor", "filius", "mater", "pono", "scandalum"],
      19,
      20,
      "Your mouth overflows with evil and your tongue weaves deceit; you sit speaking against your brother and slandering your mother's son.",
      "Augustine sees the progression of sin in speech—from internal malice to crafted deception to attacking family. The tongue becomes an instrument of destruction. Speaking against blood relatives reveals complete moral corruption—the bonds of nature and kinship cannot restrain wicked speech."
    ),
    (
      "Divine Silence → Divine Rebuke",
      "God's patience misinterpreted as approval, now ending in judgment",
      ["facio", "taceo", "existimo", "iniquus", "similis", "arguo", "statuo", "contra", "facies", "intellego", "obliviscor", "deus", "rapio", "eripio"],
      21,
      22,
      "You did these things and I was silent; you wickedly thought I was like you. But I will rebuke and arraign you. Understand this, you who forget God, lest I tear you apart with none to rescue.",
      "Augustine explains God's patience is not indifference. Divine silence during sin doesn't indicate approval—God is not like humans who overlook evil. The final reckoning comes when God 'sets charges before your face.' Those who forget God face destruction without deliverance, as no human can rescue from divine judgment."
    ),
    (
      "Sacrifice of Praise",
      "True worship that honors God and reveals salvation",
      ["sacrificium", "laus", "honorifico", "iter", "ostendo", "salutaris", "deus"],
      23,
      23,
      "The sacrifice of thanksgiving honors God; to those who order their way rightly, God will show His salvation.",
      "Augustine concludes with the psalm's resolution: true sacrifice is praise from a reformed life. Honoring God requires not ritual but thanksgiving. Those who 'order their way'—live according to God's commands—will see divine salvation. The path to salvation is worship in spirit and truth."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Theophany",
      "God's manifest appearance with cosmic witnesses",
      ["deus", "dominus", "loquor", "voco", "venio", "ignis", "tempestas"],
      ThemeCategory.divine,
      1 ... 4
    ),
    (
      "True vs. False Sacrifice",
      "God's rejection of meaningless ritual in favor of thanksgiving",
      ["sacrificium", "holocaustum", "vitulus", "hircus", "immolo", "laus", "reddo", "votum"],
      ThemeCategory.worship,
      7 ... 15
    ),
    (
      "Divine Self-Sufficiency",
      "God owns all creation and needs nothing from humanity",
      ["fera", "silva", "iumentum", "bos", "volatilis", "caelum", "orbis", "terra", "plenitudo"],
      ThemeCategory.divine,
      9 ... 12
    ),
    (
      "Hypocritical Religion",
      "Professing God's covenant while rejecting His discipline",
      ["peccator", "enarro", "iustitia", "testamentum", "odi", "disciplina", "proicio", "sermo"],
      ThemeCategory.vice,
      16 ... 17
    ),
    (
      "Complicity with Evil",
      "Association with thieves, adulterers, and deceit",
      ["fur", "curro", "adulter", "malitia", "lingua", "dolus"],
      ThemeCategory.vice,
      18 ... 19
    ),
    (
      "Divine Judgment",
      "God's silence ends in rebuke and charges",
      ["taceo", "existimo", "similis", "arguo", "statuo", "facies", "rapio"],
      ThemeCategory.divine,
      21 ... 22
    ),
    (
      "Path to Salvation",
      "Thanksgiving and righteous living lead to seeing God's salvation",
      ["sacrificium", "laus", "honorifico", "iter", "ostendo", "salutaris"],
      ThemeCategory.worship,
      23 ... 23
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 49 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 49 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm49_texts.json"
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

  func testTheophanicImagery() {
    let theophanicTerms = [
      ("deus", ["Deus", "Deus", "Deus"], "God"),
      ("dominus", ["Dominus"], "Lord"),
      ("loquor", ["locutus"], "speak"),
      ("voco", ["vocavit"], "call"),
      ("venio", ["veniet"], "come"),
      ("ignis", ["ignis"], "fire"),
      ("exardesco", ["exardescet"], "kindle"),
      ("tempestas", ["tempestas"], "tempest"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: theophanicTerms,
      verbose: verbose
    )
  }

  func testSacrificeImagery() {
    let sacrificeTerms = [
      ("sacrificium", ["sacrificiis", "sacrificia", "sacrificium", "Sacrificium"], "sacrifice"),
      ("holocaustum", ["holocausta"], "burnt offering"),
      ("vitulus", ["vitulos"], "calf"),
      ("hircus", ["hircos", "hircorum"], "goat"),
      ("taurus", ["taurorum"], "bull"),
      ("immolo", ["Immola"], "sacrifice"),
      ("laus", ["laudis", "laudis"], "praise"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: sacrificeTerms,
      verbose: verbose
    )
  }

  func testDivineOwnershipImagery() {
    let ownershipTerms = [
      ("fera", ["ferae"], "wild beast"),
      ("silva", ["silvarum"], "forest"),
      ("iumentum", ["jumenta"], "cattle"),
      ("bos", ["boves"], "ox"),
      ("volatilis", ["volatilia"], "bird"),
      ("orbis", ["orbis"], "world"),
      ("plenitudo", ["plenitudo"], "fullness"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: ownershipTerms,
      verbose: verbose
    )
  }

  func testWickedSpeechImagery() {
    let speechTerms = [
      ("os", ["os", "Os"], "mouth"),
      ("lingua", ["lingua"], "tongue"),
      ("loquor", ["loquar", "loquebaris"], "speak"),
      ("malitia", ["malitia"], "evil"),
      ("dolus", ["dolos"], "deceit"),
      ("concinno", ["concinnabat"], "weave"),
      ("scandalum", ["scandalum"], "slander"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: speechTerms,
      verbose: verbose
    )
  }

  func testDivineJudgmentImagery() {
    let judgmentTerms = [
      ("iudex", ["judex"], "judge"),
      ("discerno", ["discernat"], "judge"),
      ("arguo", ["arguam", "arguam"], "rebuke"),
      ("statuo", ["statuam"], "set"),
      ("taceo", ["tacui"], "be silent"),
      ("rapio", ["rapiat"], "tear apart"),
      ("eripio", ["eripiam", "eripiat"], "deliver"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: judgmentTerms,
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
      filename: "output_psalm49_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
