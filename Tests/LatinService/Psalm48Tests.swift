import XCTest

@testable import LatinService

class Psalm48Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 48, category: nil)
  private let expectedVerseCount = 21

  private let text = [
    /* 1 */
    "Audite haec, omnes gentes; auribus percipite, omnes qui habitatis orbem:",
    /* 2 */ "Quique terrigenae et filii hominum, simul in unum dives et pauper.",
    /* 3 */ "Os meum loquetur sapientiam, et meditatio cordis mei prudentiam.",
    /* 4 */ "Inclinabo ad parabolam aurem meam; aperiam in psalterio enigma meum.",
    /* 5 */ "Quare timebo in die mala? iniquitas calcanei mei circumdabit me.",
    /* 6 */ "Qui confidunt in virtute sua, et in multitudine divitiarum suarum gloriantur.",
    /* 7 */ "Frater non redimit, redimet homo; non dabit Deo placationem suam,",
    /* 8 */ "Et pretium redemptionis animae suae, et laborabit in aeternum, Et vivet adhuc in finem.",
    /* 9 */ "Non videbit interitum, cum viderit sapientes morientes;",
    /* 10 */
    "Simul insipiens et stultus peribunt, et relinquent alienis divitias suas.",
    /* 11 */
    "Et sepulchra eorum domus illorum in aeternum; tabernacula eorum in progenie et progenie:  vocaverunt nomina sua in terris suis.",
    /* 12 */
    "Et homo, cum in honore esset, non intellexit; comparatus est iumentis insipientibus, et similis factus est illis.",
    /* 13 */ "Haec via illorum scandalum ipsis; et postea in ore suo complacebunt.",
    /* 14 */ "Sicut oves in inferno positi sunt; mors depascet eos.",
    /* 15 */
    "Et dominabuntur eorum iusti in matutino; et auxilium eorum veterascet in inferno a gloria eorum.",
    /* 16 */ "Verumtamen Deus redimet animam meam de manu inferi, cum acceperit me.",
    /* 17 */
    "Ne timueris cum dives factus fuerit homo, et cum multiplicata fuerit gloria domus eius;",
    /* 18 */ "Quoniam cum interierit, non sumet omnia, neque descendet cum eo gloria eius.",
    /* 19 */
    "Quia anima eius in vita ipsius benedicetur; confitebitur tibi cum benefeceris ei.",
    /* 20 */
    "Introibit usque in progenies patrum suorum; usque in aeternum non videbit lumen.",
    /* 21 */
    "Homo, cum in honore esset, non intellexit; comparatus est iumentis insipientibus, et similis factus est illis.",
  ]

  private let englishText = [
    /* 1 */
    "Hear this, all you nations; give ear, all you inhabitants of the world:",
    /* 2 */ "Both low and high, rich and poor together.",
    /* 3 */ "My mouth shall speak wisdom, and the meditation of my heart shall bring understanding.",
    /* 4 */ "I will incline my ear to a proverb; I will disclose my riddle upon the harp.",
    /* 5 */ "Why should I fear in the days of evil, when the iniquity at my heels surrounds me?",
    /* 6 */ "Those who trust in their wealth and boast of the abundance of their riches—",
    /* 7 */ "Truly no man can ransom another, or give to God the price of his life,",
    /* 8 */ "For the ransom of their life is costly and can never suffice, That he should live on forever and never see the pit.",
    /* 9 */ "For he sees that even the wise die; the fool and the senseless alike perish,",
    /* 10 */ "And leave their wealth to others.",
    /* 11 */
    "Their graves are their homes forever, their dwelling places to all generations, Though they called lands by their own names.",
    /* 12 */ "Man in his pomp yet without understanding is like the beasts that perish.",
    /* 13 */
    "This is the path of those who have foolish confidence; yet after them people approve of their boasts.",
    /* 14 */ "Like sheep they are appointed for Sheol; death shall be their shepherd.",
    /* 15 */
    "The upright shall rule over them in the morning, and their form shall be consumed in Sheol, far from their lofty home.",
    /* 16 */ "But God will ransom my soul from the power of Sheol, for he will receive me.",
    /* 17 */ "Be not afraid when a man becomes rich, when the glory of his house increases;",
    /* 18 */ "For when he dies he will carry nothing away; his glory will not descend after him.",
    /* 19 */
    "Though while he lives he counts himself blessed—and though you get praise when you do well for yourself—",
    /* 20 */
    "His soul shall go to the generation of his fathers, who will never again see light.",
    /* 21 */ "Man in his pomp yet without understanding is like the beasts that perish.",
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["audio", "gens", "auris", "percipio", "habito", "orbis"]),
    (2, ["terrigena", "filius", "homo", "simul", "dives", "pauper"]),
    (3, ["os", "loquor", "sapientia", "meditatio", "cor", "prudentia"]),
    (4, ["inclino", "parabola", "auris", "aperio", "psalterium", "enigma"]),
    (5, ["timeo", "dies", "malus", "iniquitas", "calcaneum", "circumdo"]),
    (6, ["confido", "virtus", "multitudo", "divitiae", "glorior"]),
    (7, ["frater", "redimo", "homo", "do", "deus", "placatio"]),
    (8, ["pretium", "redemptio", "anima", "laboro", "aeternus", "vivo", "adhuc", "finis"]),
    (9, ["video", "interitus", "sapiens", "morior"]),
    (10, ["insipiens", "stultus", "pereo", "relinquo", "alienus", "divitiae"]),
    (11, ["sepulchrum", "domus", "aeternus", "tabernaculum", "progenies", "voco", "nomen", "terra"]),
    (12, ["homo", "honor", "intellego", "comparo", "iumentum", "insipiens", "similis"]),
    (13, ["via", "scandalum", "postea", "os", "complaceo"]),
    (14, ["ovis", "infernus", "pono", "mors", "depasco"]),
    (15, ["dominor", "iustus", "matutinus", "auxilium", "veterasco", "infernus", "gloria"]),
    (16, ["deus", "redimo", "anima", "manus", "inferus", "accipio"]),
    (17, ["timeo", "dives", "facio", "homo", "multiplico", "gloria", "domus"]),
    (18, ["intereo", "sumo", "omnis", "descendo", "gloria"]),
    (19, ["anima", "vita", "benedico", "confiteor", "benefacio"]),
    (20, ["introeo", "progenies", "pater", "aeternus", "video", "lumen"]),
    (21, ["homo", "honor", "intellego", "comparo", "iumentum", "insipiens", "similis"]),
  ]

  private let structuralThemes = [
    (
      "Universal Summons",
      "A call to all nations and peoples, transcending social status",
      ["audio", "gens", "auris", "percipio", "habito", "orbis", "terrigena", "filius", "homo", "dives", "pauper"],
      1,
      2,
      "The psalmist summons all peoples of the earth—both high and low, rich and poor—to hear a message that applies universally to humanity.",
      "Augustine sees this as the Church's universal call to salvation. The inclusion of both rich and poor demonstrates that divine wisdom transcends earthly distinctions, addressing the fundamental human condition shared by all."
    ),
    (
      "Wisdom's Promise",
      "The speaker commits to revealing wisdom and solving mysteries",
      ["os", "loquor", "sapientia", "meditatio", "cor", "prudentia", "inclino", "parabola", "auris", "aperio", "psalterium", "enigma"],
      3,
      4,
      "The psalmist promises to speak wisdom from meditation and to open up parables and riddles, disclosing hidden mysteries through song.",
      "Augustine interprets this as prophetic speech—the psalmist mediates divine wisdom, unlocking the mysteries of God's providence. The parable points to Christ, who speaks in parables and reveals what was hidden from the foundation of the world."
    ),
    (
      "Fear vs. False Trust",
      "The contrast between righteous fear and trust in riches",
      ["timeo", "dies", "malus", "iniquitas", "calcaneum", "circumdo", "confido", "virtus", "multitudo", "divitiae", "glorior"],
      5,
      6,
      "Why fear evil days when iniquity surrounds? Those who trust in wealth and boast in riches demonstrate misplaced confidence.",
      "Augustine sees the heel of iniquity as reference to original sin and temporal temptation. Those who trust in material strength reveal their spiritual blindness—true security comes from God alone, not from accumulated wealth."
    ),
    (
      "Redemption's Impossibility",
      "No human can ransom another; the price is infinite",
      ["frater", "redimo", "homo", "do", "deus", "placatio", "pretium", "redemptio", "anima", "laboro", "aeternus", "vivo", "adhuc", "finis"],
      7,
      8,
      "No brother can redeem another or give God an appeasement; the price of redeeming a soul is too costly and can never suffice.",
      "Augustine sees here the insufficiency of human merit for salvation. Only Christ, the God-man, can pay the infinite price required to redeem souls. Human efforts and wealth are powerless before the demands of divine justice—eternal life cannot be purchased with temporal goods."
    ),
    (
      "Universal Mortality",
      "The wise and foolish alike face death and leave wealth behind",
      ["video", "interitus", "sapiens", "morior", "insipiens", "stultus", "pereo", "relinquo", "alienus", "divitiae"],
      9,
      10,
      "Even the wise die; the fool and senseless perish together, leaving their riches to others.",
      "Augustine emphasizes death as the great equalizer—worldly wisdom cannot prevent mortality. Both learned and ignorant face the same end, and accumulated wealth benefits only those left behind. True wisdom lies in preparing for eternity, not accumulating temporary possessions."
    ),
    (
      "Futile Permanence",
      "The illusion of earthly immortality through monuments and estates",
      ["sepulchrum", "domus", "aeternus", "tabernaculum", "progenies", "voco", "nomen", "terra", "homo", "honor", "intellego", "comparo", "iumentum", "insipiens", "similis"],
      11,
      12,
      "Graves become eternal dwellings, and men name lands after themselves, but man in honor without understanding is like the beasts that perish.",
      "Augustine sees the tragic irony of seeking earthly permanence. Men build tombs and name estates hoping to achieve immortality through memory, yet die like animals. True honor comes from understanding and living according to divine wisdom, not from monuments or property."
    ),
    (
      "The Fool's Path",
      "The way of folly leads to death and Sheol",
      ["via", "scandalum", "postea", "os", "complaceo", "ovis", "infernus", "pono", "mors", "depasco"],
      13,
      14,
      "This is the path of fools who trust themselves; they are laid in Sheol like sheep, with death as their shepherd.",
      "Augustine interprets this as the spiritual death of the proud. Those who follow foolish confidence become stumbling blocks (scandal) to themselves. Like sheep without a true shepherd, they are led by death itself to eternal separation from God—the false shepherd devours what the True Shepherd would save."
    ),
    (
      "Reversal and Redemption",
      "The righteous will rule; God alone ransoms from death",
      ["dominor", "iustus", "matutinus", "auxilium", "veterasco", "infernus", "gloria", "deus", "redimo", "anima", "manus", "inferus", "accipio"],
      15,
      16,
      "The upright will rule over them in the morning, while their form decays in Sheol. But God will ransom my soul from the power of death, for He will receive me.",
      "Augustine sees the 'morning' as the resurrection—the righteous will triumph in the final judgment. While human redemption is impossible (verses 7-8), divine redemption is certain. God accomplishes what humans cannot: He ransoms souls from death's dominion and receives them into eternal life."
    ),
    (
      "Warning Against Envy",
      "Do not fear the prosperity of the wicked; wealth is temporary",
      ["timeo", "dives", "facio", "homo", "multiplico", "gloria", "domus", "intereo", "sumo", "omnis", "descendo", "gloria"],
      17,
      18,
      "Do not fear when a man grows rich and his house increases in glory, for at death he takes nothing; his glory does not descend with him.",
      "Augustine warns against envying temporal prosperity. The wealth and glory of the wicked are illusions—death strips away all earthly accumulation. The faithful should not be troubled by apparent inequality in this life, for eternal realities reverse temporal fortunes."
    ),
    (
      "False Blessing",
      "Self-congratulation in life followed by darkness in death",
      ["anima", "vita", "benedico", "confiteor", "benefacio", "introeo", "progenies", "pater", "aeternus", "video", "lumen"],
      19,
      20,
      "Though he counts himself blessed in life and receives praise for doing well, his soul will join his fathers' generation and never see light.",
      "Augustine sees the irony of earthly self-congratulation. Those who bless themselves and receive human praise live in self-deception. Without divine blessing, they enter the darkness of their fathers—eternal separation from the Light who is Christ. Temporal praise cannot illuminate eternal darkness."
    ),
    (
      "Final Refrain",
      "Man without understanding is like the beasts",
      ["homo", "honor", "intellego", "comparo", "iumentum", "insipiens", "similis"],
      21,
      21,
      "The psalm's solemn conclusion: man in honor without understanding is compared to the senseless beasts that perish.",
      "Augustine interprets this refrain as the psalm's theological verdict. Human dignity (honor) divorced from divine understanding (intellego) reduces humanity to the level of beasts. True human flourishing requires wisdom that comes from God—without it, even the honored and wealthy live and die as mere animals, missing their divine calling."
    ),
  ]

  private let conceptualThemes = [
    // TODO: Add conceptual themes based on analysis
    (
      "Universal Teaching",
      "The psalmist's call to all humanity to hear wisdom",
      ["audio", "gens", "percipio", "habito", "orbis"],
      ThemeCategory.divine,
      1 ... 2
    ),
    (
      "Wisdom Teaching",
      "Speaking wisdom and understanding from meditation",
      ["os", "loquor", "sapientia", "meditatio", "prudentia"],
      ThemeCategory.virtue,
      3 ... 4
    ),
    (
      "Mortality and Riches",
      "The futility of wealth in the face of death",
      ["dives", "divitiae", "mors", "pereo", "interitus"],
      ThemeCategory.virtue,
      5 ... 18
    ),
    (
      "Divine Redemption",
      "God's power to ransom the soul from death",
      ["deus", "redimo", "anima", "inferus", "accipio"],
      ThemeCategory.divine,
      16 ... 16
    ),
    (
      "Man and Beast",
      "The comparison of man without understanding to beasts",
      ["homo", "honor", "intellego", "iumentum", "insipiens", "similis"],
      ThemeCategory.virtue,
      12 ... 21
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 48 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 48 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm48_texts.json"
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

  func testWealthAndMortalityImagery() {
    let wealthTerms = [
      ("dives", ["dives"], "rich"),
      ("pauper", ["pauper"], "poor"),
      ("divitiae", ["divitiarum", "divitias"], "riches"),
      ("virtus", ["virtute"], "strength"),
      ("multitudo", ["multitudine"], "abundance"),
      ("glorior", ["gloriantur"], "boast"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: wealthTerms,
      verbose: verbose
    )
  }

  func testRedemptionImagery() {
    let redemptionTerms = [
      ("redimo", ["redimit", "redimet", "redimet"], "ransom"),
      ("placatio", ["placationem"], "appeasement"),
      ("pretium", ["pretium"], "price"),
      ("redemptio", ["redemptionis"], "redemption"),
      ("anima", ["animae", "anima"], "soul"),
      ("laboro", ["laborabit"], "labor"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: redemptionTerms,
      verbose: verbose
    )
  }

  func testDeathAndSheolImagery() {
    let deathTerms = [
      ("mors", ["mors"], "death"),
      ("infernus", ["inferno", "inferno", "inferi"], "hell"),
      ("interitus", ["interitum"], "destruction"),
      ("morior", ["morientes"], "die"),
      ("pereo", ["peribunt"], "perish"),
      ("depasco", ["depascet"], "pasture"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: deathTerms,
      verbose: verbose
    )
  }

  func testManAndBeastComparison() {
    let comparisonTerms = [
      ("homo", ["homo", "homo"], "man"),
      ("honor", ["honore", "honore"], "honor"),
      ("intellego", ["intellexit", "intellexit"], "understand"),
      ("comparo", ["comparatus", "comparatus"], "compare"),
      ("iumentum", ["iumentis", "iumentis"], "beast"),
      ("insipiens", ["insipientibus", "insipiens", "insipientibus"], "fool"),
      ("similis", ["similis"], "similar"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: comparisonTerms,
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
      filename: "output_psalm48_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
