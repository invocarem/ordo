import XCTest

@testable import LatinService

class Psalm43Tests: XCTestCase {
  private let verbose = true

  // MARK: - Test Data
  let id = PsalmIdentity(number: 43, category: "")
  private let expectedVerseCount = 28

  private let text = [
    /* 1 */
    "Deus, auribus nostris audivimus, patres nostri annuntiaverunt nobis, ", 
    /* 2 */
    "opus quod operatus es in diebus eorum, et in diebus antiquis.",
    /* 3 */
    "Manus tua gentes disperdidit, et plantasti eos; afflixisti populos, et expulisti eos.",
    /* 4 */
    "Nec enim in gladio suo possederunt terram, et brachium eorum non salvavit eos;", 
    /* 5 */
    "Sed dextera tua et brachium tuum, et illuminatio vultus tui, quoniam complacuisti in eis.",
    /* 6 */
    "Tu es ipse Rex meus et Deus meus; qui mandas salutes Jacob.",
    /* 7 */
    "In te inimicos nostros ventilabimus cornu, et in nomine tuo spernemus insurgentes in nos.",
    /* 8 */
    "Non enim in arcu meo sperabo, et gladius meus non salvabit me.",
    /* 9 */
    "Salvasti enim nos de affligentibus nos, et odientes nos confudisti.",
    /* 10 */
    "In Deo laudabimur tota die, et in nomine tuo confitebimur in saeculum.",
    /* 11 */
    "Nunc autem repulisti et confudisti nos, et non egredieris, Deus, in virtutibus nostris.",
    /* 12 */
    "Avertisti nos retrorsum post inimicos nostros, et qui oderunt nos, diripiebant sibi.",
    /* 13 */
    "Dedisti nos tamquam oves escarum, et in gentibus dispersisti nos.",
    /* 14 */
    "Vendidisti populum tuum sine pretio, et non fuit multitudo in commutationibus eorum.",
    /* 15 */
    "Posuisti nos opprobrium vicinis nostris, subsannationem et derisum his qui in circuitu nostro sunt.",
    /* 16 */
    "Posuisti nos in similitudinem gentibus, commotionem capitis in populis.",
    /* 17 */
    "Tota die verecundia mea contra me est, et confusio vultus mei cooperuit me,",
    /* 18 */
    "A voce exprobrantis et obloquentis; a facie inimici et persequentis.",
    /* 19 */
    "Haec omnia venerunt super nos, nec obliti sumus te, et inique non egimus in testamento tuo.",
    /* 20 */
    "Et non recessit retro cor nostrum, et declinasti semitas nostras a via tua:",
    /* 21 */
    "Quoniam humiliasti nos in loco afflictionis, et cooperuit nos umbra mortis.",
    /* 22 */
    "Si obliti sumus nomen Dei nostri, et si expandimus manus nostras ad deum alienum:",
    /* 23 */
    "Nonne Deus requiret ista? ipse enim novit abscondita cordis.",
    /* 24 */
    "Quoniam propter te mortificamur tota die; aestimati sumus sicut oves occisionis.",
    /* 25 */
    "Exsurge, quare obdormis, Domine? exsurge, et ne repellas in finem.",
    /* 26 */
    "Quare faciem tuam avertis, oblivisceris inopiae nostrae et tribulationis nostrae?",
    /* 27 */
    "Quoniam humiliata est in pulvere anima nostra; conglutinatus est in terra venter noster.",
    /* 28 */
    "Exsurge, Domine, adiuva nos, et redime nos propter nomen tuum."
  ]

  private let englishText = [
    /* 1 */
    "We have heard, O God, with our ears; our fathers have declared to us",
    /* 2 */
    "the work thou didst in their days, and in the days of old.",
    /* 3 */
    "Thy hand destroyed the nations, and thou plantedst them; thou didst afflict the people, and cast them out.",
    /* 4 */
    "For they got not the possession of the land by their own sword, neither did their own arm save them;",
    /* 5 */
    "but thy right hand, and thy arm, and the light of thy countenance, because thou wast pleased with them.",
    /* 6 */
    "Thou art thyself my King and my God, who commandest the saving of Jacob.",
    /* 7 */
    "Through thee we will push down our enemies with the horn; and through thy name we will despise them that rise up against us.",
    /* 8 */
    "For I will not trust in my bow, nor shall my sword save me.",
    /* 9 */
    "For thou hast saved us from them that afflict us, and hast put them to shame that hate us.",
    /* 10 */
    "In God we shall be praised all the day long, and in thy name we will give praise for ever.",
    /* 11 */
    "But now thou hast cast us off, and put us to shame; and thou, O God, wilt not go out with our armies.",
    /* 12 */
    "Thou hast made us turn our back to our enemies, and they that hated us plundered for themselves.",
    /* 13 */
    "Thou hast given us up like sheep to be eaten, and hast scattered us among the nations.",
    /* 14 */
    "Thou hast sold thy people for nothing, and there was no reckoning in their price.",
    /* 15 */
    "Thou hast made us a reproach to our neighbors, a scoff and a derision to them that are round about us.",
    /* 16 */
    "Thou hast made us a byword among the nations, a shaking of the head among the peoples.",
    /* 17 */
    "All the day long my shame is before me, and the confusion of my face hath covered me,",
    /* 18 */
    "At the voice of him that reproacheth and revileth me; at the face of the enemy and persecutor.",
    /* 19 */
    "All these things have come upon us, yet we have not forgotten thee, nor have we dealt wickedly in thy covenant.",
    /* 20 */
    "And our heart hath not turned back, neither hast thou turned aside our steps from thy way:",
    /* 21 */
    "For thou hast humbled us in the place of affliction, and the shadow of death hath covered us.",
    /* 22 */
    "If we have forgotten the name of our God, and if we have spread forth our hands to a strange god:",
    /* 23 */
    "Shall not God search out these things? for he knoweth the secrets of the heart.",
    /* 24 */
    "For thy sake we are killed all the day long; we are counted as sheep for the slaughter.",
    /* 25 */
    "Arise, why sleepest thou, O Lord? arise, and cast us not off to the end.",
    /* 26 */
    "Why turnest thou thy face away, and forgettest our want and our trouble?",
    /* 27 */
    "For our soul is humbled down to the dust; our belly cleaveth to the earth.",
    /* 28 */
    "Arise, O Lord, help us, and redeem us for thy name's sake."
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["deus", "auris", "audio", "pater", "annuntio"]),
    (2, ["opus", "operor", "dies", "antiquus"]),
    (3, ["manus", "gens", "disperdo", "planto", "affligo", "populus", "expello"]),
    (4, ["gladius", "possideo", "terra", "brachium", "salvo"]),
    (5, ["dextera", "brachium", "illuminatio", "vultus", "complaceo"]),
    (6, ["rex", "deus", "mando", "salus", "jacob"]),
    (7, ["inimicus", "ventilo", "cornu", "nomen", "sperno", "insurgo"]),
    (8, ["arcus", "spero", "gladius", "salvo"]),
    (9, ["salvo", "affligo", "odi", "confundo"]),
    (10, ["deus", "laudo", "totus", "dies", "nomen", "confiteor", "saeculum"]),
    (11, ["repello", "confundo", "egredior", "deus", "virtus"]),
    (12, ["averto", "retrorsum", "inimicus", "odi", "diripio"]),
    (13, ["do", "ovis", "esca", "gens", "dispergo"]),
    (14, ["vendo", "populus", "pretium", "multitudo", "commutatio"]),
    (15, ["pono", "opprobrium", "vicinus", "subsannatio", "derisus", "circuitus"]),
    (16, ["pono", "similitudo", "gens", "commotio", "caput", "populus"]),
    (17, ["totus", "dies", "verecundia", "confusio", "vultus", "cooperio"]),
    (18, ["vox", "exprobro", "obloquor", "facies", "inimicus", "persequor"]),
    (19, ["omnis", "venio", "super", "obliviscor", "iniquus", "ago", "testamentum"]),
    (20, ["recedo", "retro", "cor", "declino", "semita", "via"]),
    (21, ["humilio", "locus", "afflictio", "cooperio", "umbra", "mors"]),
    (22, ["obliviscor", "nomen", "deus", "expando", "manus", "deus", "alienus"]),
    (23, ["deus", "requiro", "nosco", "absconditum", "cor"]),
    (24, ["propter", "mortifico", "totus", "dies", "aestimo", "ovis", "occisio"]),
    (25, ["exsurgo", "obdormio", "dominus", "repello", "finis"]),
    (26, ["facies", "averto", "obliviscor", "inopia", "tribulatio"]),
    (27, ["humilio", "pulvis", "anima", "conglutino", "terra", "venter"]),
    (28, ["exsurgo", "dominus", "adiuvo", "redimo", "nomen"])
  ]

  private let structuralThemes = [
    (
      "Memory → Divine Action",
      "Remembering God's past works through the fathers' testimony of divine intervention",
      [
        "deus", "auris", "audio", "pater", "annuntio", "opus", "operor", "dies", "antiquus", "manus", "gens", "disperdo", "planto", "affligo", "populus", "expello", "gladius", "possideo", "terra", "brachium", "salvo", "dextera", "illuminatio", "vultus", "complaceo"
      ],
      1,
      5,
      "The people remember hearing from their fathers about God's works in ancient days - how God's hand destroyed nations, planted them, and gave them the land not by their own sword but by His right hand and the light of His countenance",
      "Augustine sees this as the Church's remembrance of God's mighty acts in salvation history. The fathers represent the apostles and prophets who declared God's works to the faithful. The destruction of nations symbolizes the defeat of spiritual enemies, while the planting represents the establishment of God's people. The emphasis that victory came not by their own sword but by God's right hand teaches that salvation is by grace, not human effort. The illumination of God's countenance represents the favor and presence of God that brings true victory."
    ),
    (
      "Trust → Victory",
      "Confidence in God as King leading to victory over enemies through His name and power",
      [
        "rex", "deus", "mando", "salus", "jacob", "inimicus", "ventilo", "cornu", "nomen", "sperno", "insurgo", "arcus", "spero", "gladius", "salvo", "affligo", "odi", "confundo", "laudo", "totus", "dies", "confiteor", "saeculum"
      ],
      6,
      10,
      "God is acknowledged as King who commands salvation for Jacob - through Him enemies are pushed down with the horn, not through trust in bow or sword - God saves from affliction and puts enemies to shame, leading to continual praise in God's name forever",
      "Augustine interprets God as King as Christ's kingship over the Church. The salvation of Jacob represents the spiritual Israel, the Church of the faithful. The horn symbolizes strength and power that comes from God alone, not from human weapons (bow and sword). The rejection of trust in weapons represents the renunciation of worldly power and reliance on divine grace. The continual praise ('tota die') and eternal confession ('in saeculum') represent the Church's perpetual worship and thanksgiving for God's deliverance from spiritual enemies - sin, death, and the devil."
    ),
    (
      "Rejection → Shame",
      "Divine rejection leading to defeat, scattering, and reproach among the nations",
      [
        "repello", "confundo", "egredior", "deus", "virtus", "averto", "retrorsum", "inimicus", "odi", "diripio", "do", "ovis", "esca", "gens", "dispergo", "vendo", "populus", "pretium", "multitudo", "commutatio", "pono", "opprobrium", "vicinus", "subsannatio", "derisus", "circuitus", "similitudo", "commotio", "caput"
      ],
      11,
      16,
      "God has now cast off and shamed His people, not going out with their armies - turned back before enemies who plunder them, given up like sheep to be eaten, scattered among nations, sold for nothing, made a reproach to neighbors, a mockery and derision, a byword among nations",
      "Augustine sees this as the Church's experience of persecution and apparent divine abandonment. The rejection represents God's testing of the faithful through suffering. Being given as sheep for eating symbolizes martyrdom, while scattering among nations represents the Church's mission to all peoples despite opposition. The reproach and derision from neighbors parallels Christ's own suffering and the Church's sharing in His passion. The selling for no price emphasizes the worthlessness in worldly eyes of those who follow God, yet this very humiliation becomes the means of redemption."
    ),
    (
      "Shame → Innocence",
      "Enduring shame and humiliation while maintaining innocence and faithfulness to God's covenant",
      [
        "totus", "dies", "verecundia", "confusio", "vultus", "cooperio", "vox", "exprobro", "obloquor", "facies", "inimicus", "persequor", "omnis", "venio", "super", "obliviscor", "iniquus", "ago", "testamentum", "recedo", "retro", "cor", "declino", "semita", "via", "humilio", "locus", "afflictio", "umbra", "mors", "nomen", "deus", "expando", "manus", "alienus", "requiro", "nosco", "absconditum"
      ],
      17,
      23,
      "All day shame covers the face at the voice of the enemy's reproach and persecution - yet despite all this, the people have not forgotten God nor dealt wickedly in His covenant, their heart has not turned back, they have not worshiped strange gods - God who knows the secrets of the heart will search these things out",
      "Augustine interprets this as the paradox of faithful suffering - the righteous endure shame and persecution precisely because of their faithfulness to God. The covering of the face with confusion represents the outward humiliation that contrasts with inner innocence. The protestation of innocence ('nec obliti sumus te') shows the soul's confidence before God despite worldly accusation. The reference to not spreading hands to a strange god represents resistance to idolatry and compromise. Augustine sees this as the Church's bold claim of righteousness through Christ, not based on human merit but on God's grace that keeps the faithful from apostasy even under persecution."
    ),
    (
      "Martyrdom → Awakening",
      "Being killed as sheep for slaughter, calling for God to arise from apparent sleep and redeem His people",
      [
        "propter", "mortifico", "totus", "dies", "aestimo", "ovis", "occisio", "exsurgo", "obdormio", "dominus", "repello", "finis", "facies", "averto", "obliviscor", "inopia", "tribulatio", "humilio", "pulvis", "anima", "conglutino", "terra", "venter", "adiuvo", "redimo", "nomen"
      ],
      24,
      28,
      "For God's sake they are killed all day long, counted as sheep for slaughter - the soul cries out for God to arise from His apparent sleep, asking why He turns away His face and forgets their affliction, as the soul is humbled to the dust and the belly cleaves to the earth - the final plea is for God to arise, help, and redeem for His name's sake",
      "Augustine sees this as the supreme expression of Christian martyrdom and the Church's bold prayer in persecution. Being killed 'propter te' (for Your sake) shows that suffering is not punishment but witness. The sheep for slaughter imagery prefigures Christ the Lamb and all who follow Him in suffering. The cry 'Exsurge' (Arise) is not accusation but the confident prayer of faith that calls God to act. The question 'quare obdormis' (why do You sleep) recalls Christ sleeping in the boat during the storm - apparent divine inactivity that tests faith. The soul humbled to the dust represents complete abasement yet maintains hope. The final petition for redemption 'propter nomen tuum' (for Your name's sake) shows that salvation is ultimately about God's glory, not human merit - the Church's confidence rests in God's faithfulness to His own name and character."
    )
  ]

  private let conceptualThemes = [
    (
      "Ancestral Memory Imagery",
      "Hearing with ears and fathers declaring God's ancient works",
      ["deus", "auris", "audio", "pater", "annuntio", "opus", "operor", "dies", "antiquus"],
      ThemeCategory.divine,
      1...2
    ),
    (
      "Divine Hand and Arm Imagery",
      "God's hand destroying nations and arm giving victory, not human sword or arm",
      ["manus", "gens", "disperdo", "planto", "brachium", "dextera", "gladius", "salvo"],
      ThemeCategory.divine,
      3...5
    ),
    (
      "Light of Countenance Imagery",
      "The illumination of God's face bringing divine favor and victory",
      ["illuminatio", "vultus", "complaceo", "facies"],
      ThemeCategory.divine,
      5...5
    ),
    (
      "King and Kingdom Imagery",
      "God as King commanding salvation for Jacob and His people",
      ["rex", "deus", "mando", "salus", "jacob", "nomen"],
      ThemeCategory.divine,
      6...6
    ),
    (
      "Horn and Weapon Imagery",
      "Pushing down enemies with the horn while renouncing trust in bow and sword",
      ["inimicus", "ventilo", "cornu", "arcus", "spero", "gladius"],
      ThemeCategory.virtue,
      7...8
    ),
    (
      "Sheep for Eating Imagery",
      "Given up as sheep to be eaten and scattered among nations",
      ["do", "ovis", "esca", "gens", "dispergo", "occisio"],
      ThemeCategory.virtue,
      13...13
    ),
    (
      "Selling and Price Imagery",
      "God selling His people for nothing, with no value in their exchange",
      ["vendo", "populus", "pretium", "multitudo", "commutatio"],
      ThemeCategory.virtue,
      14...14
    ),
    (
      "Reproach and Mockery Imagery",
      "Made a reproach to neighbors, mockery, derision, and byword among nations",
      ["opprobrium", "vicinus", "subsannatio", "derisus", "circuitus", "similitudo", "commotio", "caput"],
      ThemeCategory.virtue,
      15...16
    ),
    (
      "Shame and Confusion Imagery",
      "Face covered with shame and confusion all day long",
      ["verecundia", "confusio", "vultus", "cooperio", "totus", "dies"],
      ThemeCategory.virtue,
      17...17
    ),
    (
      "Voice and Face of Enemy Imagery",
      "The voice of reproach and the face of the persecuting enemy",
      ["vox", "exprobro", "obloquor", "facies", "inimicus", "persequor"],
      ThemeCategory.virtue,
      18...18
    ),
    (
      "Covenant Faithfulness Imagery",
      "Not forgetting God nor dealing wickedly in His covenant despite affliction",
      ["obliviscor", "iniquus", "ago", "testamentum", "cor", "recedo", "semita", "via"],
      ThemeCategory.virtue,
      19...20
    ),
    (
      "Shadow of Death Imagery",
      "Humbled in the place of affliction with shadow of death covering",
      ["humilio", "locus", "afflictio", "cooperio", "umbra", "mors"],
      ThemeCategory.virtue,
      21...21
    ),
    (
      "Strange God Imagery",
      "Protesting innocence of spreading hands to a strange or alien god",
      ["nomen", "deus", "expando", "manus", "alienus"],
      ThemeCategory.virtue,
      22...22
    ),
    (
      "Hidden Heart Imagery",
      "God searching out and knowing the hidden secrets of the heart",
      ["deus", "requiro", "nosco", "absconditum", "cor"],
      ThemeCategory.divine,
      23...23
    ),
    (
      "Martyrdom and Slaughter Imagery",
      "Killed all day for God's sake, counted as sheep for slaughter",
      ["propter", "mortifico", "totus", "dies", "aestimo", "ovis", "occisio"],
      ThemeCategory.virtue,
      24...24
    ),
    (
      "Divine Sleep Imagery",
      "Calling God to arise from apparent sleep and not reject forever",
      ["exsurgo", "obdormio", "dominus", "repello", "finis"],
      ThemeCategory.divine,
      25...25
    ),
    (
      "Turned Face Imagery",
      "Questioning why God turns His face away and forgets affliction",
      ["facies", "averto", "obliviscor", "inopia", "tribulatio"],
      ThemeCategory.virtue,
      26...26
    ),
    (
      "Dust and Earth Imagery",
      "Soul humbled to dust and belly clinging to the earth in extreme abasement",
      ["humilio", "pulvis", "anima", "conglutino", "terra", "venter"],
      ThemeCategory.virtue,
      27...27
    ),
    (
      "Redemption for Name's Sake Imagery",
      "Final plea for God to arise, help, and redeem for His own name's sake",
      ["exsurgo", "dominus", "adiuvo", "redimo", "nomen"],
      ThemeCategory.divine,
      28...28
    ),
    (
      "Eternal Praise Imagery",
      "Praising God all day and confessing His name forever",
      ["deus", "laudo", "totus", "dies", "nomen", "confiteor", "saeculum"],
      ThemeCategory.worship,
      10...10
    )
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 43 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 43 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm43_texts.json"
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

  func testAncestralMemoryImagery() {
    let memoryTerms = [
      ("deus", ["Deus"], "God"),
      ("auris", ["auribus"], "ears"),
      ("audio", ["audivimus"], "hear"),
      ("pater", ["patres"], "fathers"),
      ("annuntio", ["annuntiaverunt"], "declare"),
      ("opus", ["opus"], "work"),
      ("operor", ["operatus"], "work"),
      ("dies", ["diebus"], "days"),
      ("antiquus", ["antiquis"], "ancient")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: memoryTerms,
      verbose: verbose
    )
  }

  func testDivineHandAndArmImagery() {
    let handTerms = [
      ("manus", ["Manus"], "hand"),
      ("gens", ["gentes"], "nations"),
      ("disperdo", ["disperdidit"], "destroy"),
      ("planto", ["plantasti"], "plant"),
      ("brachium", ["brachium"], "arm"),
      ("dextera", ["dextera"], "right hand"),
      ("gladius", ["gladio"], "sword"),
      ("salvo", ["salvavit"], "save")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: handTerms,
      verbose: verbose
    )
  }

  func testSheepForEatingImagery() {
    let sheepTerms = [
      ("do", ["Dedisti"], "give"),
      ("ovis", ["oves"], "sheep"),
      ("esca", ["escarum"], "food"),
      ("gens", ["gentibus"], "nations"),
      ("dispergo", ["dispersisti"], "scatter")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: sheepTerms,
      verbose: verbose
    )
  }

  func testReproachAndMockeryImagery() {
    let reproachTerms = [
      ("opprobrium", ["opprobrium"], "reproach"),
      ("vicinus", ["vicinis"], "neighbors"),
      ("subsannatio", ["subsannationem"], "mockery"),
      ("derisus", ["derisum"], "derision"),
      ("circuitus", ["circuitu"], "around"),
      ("similitudo", ["similitudinem"], "byword"),
      ("commotio", ["commotionem"], "shaking"),
      ("caput", ["capitis"], "head")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: reproachTerms,
      verbose: verbose
    )
  }

  func testShameAndConfusionImagery() {
    let shameTerms = [
      ("verecundia", ["verecundia"], "shame"),
      ("confusio", ["confusio"], "confusion"),
      ("vultus", ["vultus"], "countenance"),
      ("cooperio", ["cooperuit"], "cover"),
      ("totus", ["Tota"], "all"),
      ("dies", ["die"], "day")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: shameTerms,
      verbose: verbose
    )
  }

  func testShadowOfDeathImagery() {
    let deathTerms = [
      ("humilio", ["humiliasti"], "humble"),
      ("locus", ["loco"], "place"),
      ("afflictio", ["afflictionis"], "affliction"),
      ("cooperio", ["cooperuit"], "cover"),
      ("umbra", ["umbra"], "shadow"),
      ("mors", ["mortis"], "death")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: deathTerms,
      verbose: verbose
    )
  }

  func testMartyrdomAndSlaughterImagery() {
    let martyrdomTerms = [
      ("propter", ["propter"], "for the sake of"),
      ("mortifico", ["mortificamur"], "kill"),
      ("totus", ["tota"], "all"),
      ("dies", ["die"], "day"),
      ("aestimo", ["aestimati"], "count"),
      ("ovis", ["oves"], "sheep"),
      ("occisio", ["occisionis"], "slaughter")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: martyrdomTerms,
      verbose: verbose
    )
  }

  func testDivineSleepImagery() {
    let sleepTerms = [
      ("exsurgo", ["Exsurge"], "arise"),
      ("obdormio", ["obdormis"], "sleep"),
      ("dominus", ["Domine"], "Lord"),
      ("repello", ["repellas"], "reject"),
      ("finis", ["finem"], "end")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: sleepTerms,
      verbose: verbose
    )
  }

  func testDustAndEarthImagery() {
    let dustTerms = [
      ("humilio", ["humiliata"], "humble"),
      ("pulvis", ["pulvere"], "dust"),
      ("anima", ["anima"], "soul"),
      ("conglutino", ["conglutinatus"], "cling"),
      ("terra", ["terra"], "earth"),
      ("venter", ["venter"], "belly")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: dustTerms,
      verbose: verbose
    )
  }

  func testRedemptionForNamesSakeImagery() {
    let redemptionTerms = [
      ("exsurgo", ["Exsurge"], "arise"),
      ("dominus", ["Domine"], "Lord"),
      ("adiuvo", ["adiuva"], "help"),
      ("redimo", ["redime"], "redeem"),
      ("nomen", ["nomen"], "name")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: redemptionTerms,
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
      filename: "output_psalm43_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
