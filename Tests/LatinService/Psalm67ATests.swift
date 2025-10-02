import XCTest

@testable import LatinService

class Psalm67ATests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 67, category: "A")
  private let expectedVerseCount = 20

  private let text = [
    /* 1 */ "Exsurgat Deus, et dissipentur inimici eius; et fugiant qui oderunt eum a facie eius.",
    /* 2 */ "Sicut deficit fumus, deficiant; sicut fluit cera a facie ignis, sic pereant peccatores a facie Dei.",
    /* 3 */ "Et iusti laetentur, exsultent coram Deo, et delectentur in laetitia.",
    /* 4 */ "Cantate Deo, psalmum dicite nomini eius; iter facite ei qui ascendit super occasum; Dominus nomen illi.",
    /* 5 */ "Exsultate in conspectu eius; turbabuntur a facie eius, patris orphanorum et iudicis viduarum;",
    /* 6 */ "Deus in loco sancto suo. Deus qui inhabitare facit unius moris in domo; ",
    "Qui educit vinctos in fortitudine, similiter eos qui exasperant, qui habitant in sepulchris.",
    /* 7 */ "Deus, cum egredereris in conspectu populi tui, cum pertransires in deserto,",
    /* 8 */ "Terra mota est, etiam caeli distillaverunt a facie Dei Sinai, a facie Dei Israel.",
    /* 9 */ "Pluviam voluntariam segregasti, Deus, haereditati tuae; et infirmata est, tu vero perfecisti eam.",
    /* 10 */ "Animalia tua habitaverunt in ea; parasti in dulcedine tua pauperi, Deus.",
    /* 11 */ "Dominus dabit verbum evangelizantibus, virtute multa.",
    /* 12 */ "Rex virtutum dilecti dilecti; et speciei domus dividere spolia.",
    /* 13 */ "Si dormiatis inter medios cleros, pennae columbae deargentatae, et posteriora dorsi eius in pallore auri.",
    /* 14 */ "Dum discernit caelestis reges super eam, nive dealbabuntur in Salmon.",
    /* 15 */ "Mons Dei, mons pinguis; mons coagulatus, mons pinguis.",
    /* 16 */ "Ut quid suspicamini montes coagulatos? Mons in quo beneplacitum est Deo habitare in eo; etenim Dominus habitabit in finem.",
    /* 17 */ "Currus Dei decem millibus multiplex, millia laetantium; Dominus in eis in Sina, in sancto.",
    /* 18 */ "Ascendisti in altum, cepisti captivitatem; accepisti dona in hominibus; ",
    "etenim non credentes inhabitare Dominum Deum.",
  ]

  private let englishText = [
    /* 1 */ "Let God arise, and let his enemies be scattered; and let them that hate him flee from before his face.",
    /* 2 */ "As smoke vanisheth, so let them vanish away; as wax melteth before the fire, so let the wicked perish at the presence of God.",
    /* 3 */ "And let the just rejoice, let them be glad before God, and let them rejoice with gladness.",
    /* 4 */ "Sing ye to God, sing a psalm to his name; make a way for him who ascendeth upon the west; the Lord is his name.",
    /* 5 */ "Rejoice ye before him; they shall be troubled at his presence, who is the father of orphans and the judge of widows; God in his holy place.",
    /* 6 */ "God who maketh men of one mind to dwell in a house;",
    /* 7 */ "who bringeth out them that were bound in strength, in like manner them that provoke, that dwell in sepulchres.",
    /* 8 */ "O God, when thou didst go forth in the sight of thy people, when thou didst pass through the desert,",
    /* 9 */ "The earth was moved, and the heavens dropped at the presence of the God of Sinai, at the presence of the God of Israel.",
    /* 10 */ "Thou hast given a free rain, O God, to thy inheritance; and it was weakened, but thou hast made it perfect.",
    /* 11 */ "Thy animals dwelt therein; thou hast prepared it in thy sweetness for the poor, O God.",
    /* 12 */ "The Lord shall give the word to them that preach good tidings with great power.",
    /* 13 */ "The king of powers is of the beloved, of the beloved; and the beauty of the house shall divide spoils.",
    /* 14 */ "If you sleep among the midst of lots, the wings of a dove are covered with silver, and the hinder parts of her back with the paleness of gold.",
    /* 15 */ "When he that is in heaven appointeth kings over her, they shall be whited with snow in Salmon.",
    /* 16 */ "The mountain of God is a fat mountain; a curdled mountain, a fat mountain.",
    /* 17 */ "Why suspect ye curdled mountains? A mountain in which God is well pleased to dwell; for there the Lord shall dwell unto the end.",
    /* 18 */ "The chariot of God is attended by ten thousands, thousands of them that rejoice; the Lord is among them in Sinai, in the holy place.",
    /* 19 */ "Thou hast ascended on high, thou hast led captivity captive; thou hast received gifts in men;",
    /* 20 */ "yea, even for those who believed not, that the Lord God might dwell there.",
  ]

private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["exsurgo", "deus", "dissipo", "inimicus", "fugio", "odi", "facies"]),
    (2, ["deficio", "fumus", "fluo", "cera", "ignis", "pereo", "peccator", "deus", "facies"]),
    (3, ["iustus", "laetor", "exsulto", "coram", "deus", "delector", "laetitia"]),
    (4, ["canto", "deus", "psalmus", "dico", "nomen", "iter", "facio", "ascendo", "occasus", "dominus", "nomen"]),
    (5, ["exsulto", "conspectus", "turbo", "facies", "pater", "orphanus", "iudex", "vidua"]),
    (6, ["deus","locus", "sanctus", "inhabito", "facio", "unus", "mos", "domus"]),
    (7, ["educo", "vinctus", "fortitudo", "exaspero", "habito", "sepulchrum"]),
    (8, ["deus", "egredior", "conspectus", "populus", "pertranseo", "desertum"]),
    (9, ["terra", "moveo", "caelum", "distillo", "facies", "deus", "Sinai", "deus", "Israel"]),
    (10, ["pluvia", "voluntarius", "segrego", "deus", "haereditas", "infirmo", "perficio"]),
    (11, ["animal", "habito", "paro", "dulcedo", "pauper", "deus"]),
    (12, ["dominus", "do", "verbum", "evangelizo", "virtus", "multus"]),
    (13, ["rex", "virtus", "dilectus", "species", "domus", "divido", "spolium"]),
    (14, ["dormio", "medius", "clerus", "penna", "columba", "deargentatus", "posterior", "dorsum", "pallor", "aurum"]),
    (15, ["dum", "discerno", "caelestis", "rex", "super", "nix", "dealbatus", "Salmon"]),
    (16, ["mons", "deus", "mons", "pinguis", "mons", "coagulo", "mons", "pinguis"]),
    (17, ["suspicor", "mons", "coagulo", "mons", "beneplacitum", "deus", "inhabito", "dominus", "habito", "finis"]),
    (18, ["currus", "deus", "decem", "mille", "multiplex", "mille", "laetor", "dominus", "Sina", "sanctus"]),
    (19, ["ascendo", "altum", "capio", "captivitas", "accipio", "donum", "homo"]),
    (20, ["credo", "inhabito", "dominus", "deus"]),
]


private let structuralThemes = [
    (
        "Divine Arising → Enemy Scattering",
        "God's manifestation causing the dispersion of enemies",
        ["exsurgo", "deus", "dissipo", "inimicus", "fugio", "odi", "facies", "deficio", "fumus", "fluo", "cera", "ignis", "pereo", "peccator"],
        1,
        2,
        "The opening invocation calls for God's active intervention against enemies",
        "Augustine sees this as the pattern of divine judgment: when God arises in His Church, the enemies of truth are scattered. The smoke and wax metaphors show the insubstantial nature of evil when confronted with divine presence. The fleeing from God's face represents the inevitable retreat of sin when grace appears."
    ),
    (
        "Righteous Rejoicing → Worshipful Ascent",
        "The joy of the righteous leading to liturgical worship",
        ["iustus", "laetor", "exsulto", "coram", "deus", "delector", "laetitia", "canto", "deus", "psalmus", "dico", "nomen", "iter", "facio", "ascendo", "occasus", "dominus", "nomen"],
        3,
        4,
        "Transition from enemy judgment to righteous celebration and worship",
        "Augustine interprets this as the Church's response to God's victory: the just rejoice not in worldly success but in God's presence. The ascent upon the west symbolizes Christ's resurrection (setting sun as death conquered). Making a way represents preparing hearts for Christ's ascension."
    ),
    (
        "Divine Protection → Social Justice",
        "God as defender of vulnerable with power to unify and liberate",
        ["exsulto", "conspectus", "turbo", "facies", "pater", "orphanus", "iudex", "vidua", "deus", "locus", "sanctus", "inhabito", "facio", "unus", "mos", "domus"],
        5,
        6,
        "God's dual role as protector of weak and unifier of community",
        "Augustine sees the father of orphans and judge of widows as Christ's care for the spiritually destitute. Making men of one mind in a house prefigures the unity of the Church. The holy place represents God's sanctuary where the vulnerable find protection and justice."
    ),
    (
        "Liberation from Bondage",
        "God's power to free the bound and transform the rebellious",
        ["educo", "vinctus", "fortitudo", "exaspero", "habito", "sepulchrum", "deus", "egredior", "conspectus", "populus", "pertranseo", "desertum"],
        7,
        8,
        "Deliverance from physical and spiritual captivity",
        "Augustine interprets the bound ones as those enslaved by sin, and the sepulchre-dwellers as those dead in trespasses. God's going forth in the desert represents the exodus journey, prefiguring Christ's liberation of souls from the bondage of sin and death through the wilderness of this world."
    ),
    (
        "Cosmic Theophany → Divine Provision",
        "Creation's response to God's presence and His abundant care",
        ["terra", "moveo", "caelum", "distillo", "facies", "deus", "Sinai", "deus", "Israel", "pluvia", "voluntarius", "segrego", "deus", "haereditas", "infirmo", "perficio"],
        9,
        10,
        "Earth and heaven respond to God while He provides for His inheritance",
        "Augustine sees the earth moving and heavens dropping as creation's recognition of its Creator. The voluntary rain symbolizes the grace of the Holy Spirit given freely to God's inheritance. The weakening and perfecting show how divine strength transforms human weakness into spiritual perfection."
    ),
    (
        "Providential Care → Evangelical Mission",
        "God's sustenance for creation leading to proclamation of the Word",
        ["animal", "habito", "paro", "dulcedo", "pauper", "deus", "dominus", "do", "verbum", "evangelizo", "virtus", "multus", "rex", "virtus", "dilectus", "species", "domus", "divido", "spolium"],
        11,
        12,
        "From material provision to spiritual proclamation with power",
        "Augustine interprets the animals dwelling and preparation for the poor as God's care for all creation, while the word given to preachers represents the Gospel mission. The king of powers is Christ, and the division of spoils shows the spiritual treasures won through redemption and distributed to the Church."
    ),
    (
        "Mystical Rest → Divine Kingship",
        "Peaceful trust in God's allocation with heavenly appointment",
        ["dormio", "medius", "clerus", "penna", "columba", "deargentatus", "posterior", "dorsum", "pallor", "aurum", "dum", "discerno", "caelestis", "rex", "super", "nix", "dealbatus", "Salmon"],
        13,
        14,
        "Rest amid divine lots with transfiguration and royal appointment",
        "Augustine sees the sleep among lots as the soul's rest in God's will. The silvered dove represents the soul purified for heavenly flight, while the golden back shows the enduring value of spiritual works. The snow in Salmon symbolizes baptismal purity, and the heavenly kings represent Christ's reign through His saints."
    ),
    (
        "Divine Mountain → Eternal Habitation",
        "The fertile mountain as God's chosen dwelling place",
        ["mons", "deus", "mons", "pinguis", "mons", "coagulatus", "mons", "pinguis", "suspicor", "mons", "coagulatus", "mons", "beneplacitum", "deus", "inhabito", "dominus", "habito", "finis"],
        15,
        16,
        "Mountain imagery representing God's permanent dwelling with His people",
        "Augustine interprets the fat mountain as the Church abundant with grace, and the curdled mountain as faith solidified in Christ. God's pleasure to dwell there until the end fulfills the Emmanuel promise, showing His eternal commitment to abide with the Church through all ages."
    ),
    (
        "Triumphal Procession → Sacred Presence",
        "God's glorious chariot procession at Sinai's holy mountain",
        ["currus", "deus", "decem", "mille", "multiplex", "mille", "laetor", "dominus", "Sina", "sanctus", "ascendo", "altum", "capio", "captivitas", "accipio", "donum", "homo"],
        17,
        18,
        "Victorious ascent with angelic accompaniment and gift reception",
        "Augustine sees the chariot with thousands as the angelic host accompanying Christ in His ascension. Taking captivity captive represents His victory over sin and death. The gifts received in men prefigure the spiritual gifts given to the Church, showing Christ's triumphal procession from earth to heaven."
    ),
    (
        "Universal Redemption",
        "God's dwelling extended even to those who initially disbelieve",
        ["credo", "inhabito", "dominus", "deus"],
        19,
        20,
        "The inclusive scope of God's salvific plan embracing all humanity",
        "Augustine interprets this as the mystery of God's mercy: even those who did not initially believe are included in the divine dwelling. This shows the universal reach of redemption, where God's grace transforms unbelief into faith, making room in His house for all who will ultimately come to Him."
    )
]
  private let conceptualThemes = [
    (
      "Divine Judgment",
      "God's power to scatter enemies and destroy the wicked",
      ["exsurgo", "dissipo", "inimicus", "fugio", "deficio", "fumus", "fluo", "cera", "ignis", "pereo", "peccator"],
      ThemeCategory.divine,
      1 ... 2
    ),
    (
      "Righteous Celebration",
      "The joy and worship of the just in God's presence",
      ["iustus", "laetor", "exsulto", "delector", "laetitia", "canto", "psalmus", "exsulto"],
      ThemeCategory.virtue,
      3 ... 5
    ),
    (
      "Divine Protection",
      "God as defender of orphans, widows, and the bound",
      ["pater", "orphanus", "iudex", "vidua", "educo", "vinctus", "fortitudo"],
      ThemeCategory.divine,
      5 ... 7
    ),
    (
      "Ecclesial Unity",
      "God creating unity among believers in one house",
      ["inhabito", "facio", "unus", "mos", "domus"],
      ThemeCategory.virtue,
      6 ... 6
    ),
    (
      "Exodus Typology",
      "God's historical saving acts prefiguring spiritual redemption",
      ["egredior", "populus", "pertranseo", "desertum", "terra", "moveo", "caelum", "distillo", "Sinai"],
      ThemeCategory.divine,
      8 ... 9
    ),
    (
      "Providential Care",
      "God's abundant provision for inheritance and poor",
      ["pluvia", "voluntarius", "haereditas", "infirmo", "perficio", "animal", "habito", "paro", "dulcedo", "pauper"],
      ThemeCategory.divine,
      10 ... 11
    ),
    (
      "Evangelical Mission",
      "The word given to preachers with power for spoils",
      ["verbum", "evangelizo", "virtus", "multus", "rex", "virtus", "divido", "spolium"],
      ThemeCategory.virtue,
      12 ... 13
    ),
    (
      "Mystical Transformation",
      "Supernatural beautification and purification of believers",
      ["dormio", "clerus", "penna", "columba", "deargentatus", "pallor", "aurum", "nix", "dealbatus"],
      ThemeCategory.virtue,
      14 ... 15
    ),
    (
      "Divine Dwelling",
      "God's chosen habitation in the fertile mountain",
      ["mons", "deus", "pinguis", "coagulatus", "beneplacitum", "inhabito", "habito", "finis"],
      ThemeCategory.divine,
      16 ... 17
    ),
    (
      "Triumphal Ascension",
      "Christ's victory procession and gift distribution",
      ["currus", "deus", "mille", "laetor", "ascendo", "altum", "capio", "captivitas", "accipio", "donum"],
      ThemeCategory.divine,
      18 ... 20
    ),
    (
      "Cosmic Worship",
      "Heaven and earth responding to God's presence",
      ["terra", "moveo", "caelum", "distillo", "facies", "deus"],
      ThemeCategory.worship,
      9 ... 9
    ),
    (
      "Universal Redemption",
      "God's dwelling extended even to unbelievers",
      ["credo", "inhabito", "dominus", "deus"],
      ThemeCategory.divine,
      20 ... 20
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 67A should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 67A English text should have \(expectedVerseCount) verses"
    )
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
      filename: "output_psalm67A_texts.json"
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

    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    let utilities = PsalmTestUtilities.self

    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testEnemyScatteringMetaphor() {
    let enemyTerms = [
      ("exsurgo", ["Exsurgat"], "arise"),
      ("dissipo", ["dissipentur"], "scatter"),
      ("inimicus", ["inimici"], "enemy"),
      ("fugio", ["fugiant"], "flee"),
      ("odi", ["oderunt"], "hate"),
      ("deficio", ["deficit", "deficiant"], "vanish"),
      ("fumus", ["fumus"], "smoke"),
      ("fluo", ["fluit"], "flow"),
      ("cera", ["cera"], "wax"),
      ("ignis", ["ignis"], "fire"),
      ("pereo", ["pereant"], "perish"),
      ("peccator", ["peccatores"], "sinner"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: enemyTerms,
      verbose: verbose
    )
  }

  func testMountainImagery() {
    let mountainTerms = [
      ("mons", ["Mons", "mons", "montes", "mons"], "mountain"),
      ("deus", ["Dei"], "God"),
      ("pinguis", ["pinguis", "pinguis"], "fat/rich"),
      ("coagulatus", ["coagulatus", "coagulatos"], "curdled/solid"),
      ("beneplacitum", ["beneplacitum"], "well-pleasing"),
      ("inhabito", ["habitare", "habitabit"], "dwell"),
      ("finis", ["finem"], "end"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: mountainTerms,
      verbose: verbose
    )
  }

  func testAscensionImagery() {
    let ascensionTerms = [
      ("ascendo", ["ascendit", "Ascendisti"], "ascend"),
      ("altum", ["altum"], "high"),
      ("capio", ["cepisti"], "take"),
      ("captivitas", ["captivitatem"], "captivity"),
      ("accipio", ["accepisti"], "receive"),
      ("donum", ["dona"], "gift"),
      ("currus", ["Currus"], "chariot"),
      ("mille", ["millibus", "millia"], "thousand"),
      ("laetor", ["laetantium"], "rejoicing"),
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: ascensionTerms,
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
      filename: "output_psalm67A_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
