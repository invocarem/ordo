import XCTest

@testable import LatinService

class Psalm21Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 21, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 34
  private let text = [
    "Deus, Deus meus, respice in me: quare me dereliquisti? longe a salute mea verba delictorum meorum.",
    "Deus meus, clamabo per diem, et non exaudies; et nocte, et non ad insipientiam mihi.",
    "Tu autem in sancto habitas, laus Israel.",
    "In te speraverunt patres nostri; speraverunt, et liberasti eos.",
    "Ad te clamaverunt, et salvi facti sunt; in te speraverunt, et non sunt confusi.", /* 5 */
    "Ego autem sum vermis et non homo; opprobrium hominum et abiectio plebis.",
    "Omnes videntes me deriserunt me; locuti sunt labiis, et moverunt caput.",
    "Speravit in Domino, eripiat eum; salvum faciat eum, quoniam vult eum.",
    "Quoniam tu es qui extraxisti me de ventre, spes mea ab uberibus matris meae.",
    "In te proiectus sum ex utero; de ventre matris meae Deus meus es tu. Ne discesseris a me, ", /* 10 */
    "quoniam tribulatio proxima est, quoniam non est qui adiuvet.", /* 11 */
    "Circumdederunt me vituli multi; tauri pingues obsederunt me.", /* 12 */
    "Aperuerunt super me os suum, sicut leo rapiens et rugiens.", /* 13*/
    "Sicut aqua effusus sum, et dispersa sunt omnia ossa mea; ", /* 14 */
    "Factum est cor meum tamquam cera liquescens in medio ventris mei.", /* 15 */
    "Aruit tamquam testa virtus mea, et lingua mea adhaesit faucibus meis; et in pulverem mortis deduxisti me.",
    "Quoniam circumdederunt me canes multi; concilium malignantium obsedit me.",
    "Foderunt manus meas et pedes meos; dinumeraverunt omnia ossa mea.", /* 18 */
    "Ipsi vero consideraverunt et conspexerunt me; diviserunt sibi vestimenta mea, et super vestem meam miserunt sortem.",
    "Tu autem, Domine, ne elongaveris auxilium tuum a me; ad defensionem meam conspice.", /* 20 */
    "Erue a framea animam meam, et de manu canis unicam meam.",
    "Salva me ex ore leonis, et a cornibus unicornium humilitatem meam.",
    "Narrabo nomen tuum fratribus meis; in medio ecclesiae laudabo te.",
    "Qui timetis Dominum, laudate eum; universum semen Iacob, glorificate eum.",
    "Timeat eum omne semen Israel, quoniam non sprevit neque despexit deprecationem pauperis;", /* 25 */
    "Nec avertit faciem suam a me, et cum clamarem ad eum, exaudivit me.",
    "Apud te laus mea in ecclesia magna; vota mea reddam in conspectu timentium eum.",
    "Edent pauperes, et saturabuntur; et laudabunt Dominum qui requirunt eum: vivent corda eorum in saeculum saeculi.",
    "Reminiscentur et convertentur ad Dominum universi fines terrae; ",
    "Et adorabunt in conspectu eius universae familiae gentium.", /* 30 */
    "Quoniam Domini est regnum; et ipse dominabitur gentium.",
    "Manducaverunt et adoraverunt omnes pingues terrae; in conspectu eius cadent omnes qui descendunt in terram.",
    "Et anima mea illi vivet; et semen meum serviet ipsi.",
    "Annuntiabitur Domino generatio ventura; et annuntiabunt iustitiam eius populo qui nascetur, quem fecit Dominus.",
  ]

  private let englishText = [
    "My God, my God, look upon me: why hast thou forsaken me? Far from my salvation are the words of my sins.",
    "O my God, I shall cry by day, and thou wilt not hear: and by night, and it shall not be reputed as folly in me.",
    "But thou dwellest in the holy place, the praise of Israel.",
    "In thee have our fathers hoped: they have hoped, and thou hast delivered them.",
    "They cried to thee, and they were saved: they trusted in thee, and were not confounded.",
    "But I am a worm, and no man: the reproach of men, and the outcast of the people.",
    "All they that saw me have laughed me to scorn: they have spoken with the lips, and wagged the head.",
    "He hoped in the Lord, let him deliver him: let him save him, seeing he delighteth in him.",
    "For thou art he that hast drawn me out of the womb: my hope from the breasts of my mother.",
    "I was cast upon thee from the womb. From my mother's womb thou art my God. Depart not from me,",
    "for tribulation is very near: for there is none to help me.",
    "Many calves have surrounded me: fat bulls have besieged me.",
    "They have opened their mouths against me, as a lion ravening and roaring.",
    "I am poured out like water; and all my bones are scattered.",
    "My heart is become like wax melting in the midst of my bowels.",
    "My strength is dried up like a potsherd, and my tongue hath cleaved to my jaws: and thou hast brought me down into the dust of death.",
    "For many dogs have encompassed me: the council of the malignant hath besieged me.",
    "They have dug my hands and feet: they have numbered all my bones.",
    "And they have looked and stared upon me: they parted my garments amongst them; and upon my vesture they cast lots.",
    "But thou, O Lord, remove not thy help to a distance from me: look towards my defence.",
    "Deliver my soul from the sword: my only one from the hand of the dog.",
    "Save me from the lion's mouth; and my lowness from the horns of the unicorns.",
    "I will declare thy name to my brethren: in the midst of the church will I praise thee.",
    "Ye that fear the Lord, praise him: all ye the seed of Jacob, glorify him.",
    "Let all the seed of Israel fear him: because he hath not slighted nor despised the supplication of the poor man.",
    "Neither hath he turned away his face from me: and when I cried to him he heard me.",
    "With thee is my praise in a great church: I will pay my vows in the sight of them that fear him.",
    "The poor shall eat and shall be filled: and they shall praise the Lord that seek him: their hearts shall live for ever and ever.",
    "All the ends of the earth shall remember, and shall be converted to the Lord:",
    "And all the kindreds of the Gentiles shall adore in his sight.",
    "For the kingdom is the Lord's; and he shall have dominion over the nations.",
    "All the fat ones of the earth have eaten and have adored: all they that go down to the earth shall fall before him.",
    "And to him my soul shall live: and my seed shall serve him.",
    "There shall be declared to the Lord a generation to come: and the heavens shall show forth his justice to a people that shall be born, which the Lord hath made.",
  ]

  private let lineKeyLemmas = [
    (1, ["deus", "respicio", "derelinquo", "salus", "delictum"]),
    (2, ["deus", "clamo", "dies", "exaudio", "nox", "insipientia"]),
    (3, ["sanctus", "habito", "laus", "israel"]),
    (4, ["spero", "pater", "libero"]),
    (5, ["clamo", "salvus", "spero", "confundo"]),
    (6, ["vermis", "homo", "opprobrium", "abiectio", "plebs"]),
    (7, ["video", "derideo", "labium", "moveo", "caput"]),
    (8, ["spero", "dominus", "eripio", "salvus", "volo"]),
    (9, ["extraho", "venter", "spes", "uber", "mater"]),
    (10, ["proicio", "uterus", "venter", "mater", "deus", "discedo"]),
    (11, ["quoniam", "tribulatio", "proximus", "adiuvo"]),
    (12, ["circumdo", "vitulus", "taurus", "pinguis", "obsideo"]),
    (13, ["aperio", "os", "leo", "rapio", "rugio"]),
    (14, ["aqua", "effundo", "dispergo", "os"]),
    (15, ["facio", "cor", "cera", "liquesco", "medius", "venter"]),
    (16, ["aresco", "testa", "virtus", "lingua", "adhaereo", "faux", "pulvis", "mors", "deduco"]),
    (17, ["circumdo", "canis", "concilium", "malignor", "obsideo"]),
    (18, ["fodio", "manus", "pes", "dinumero", "os"]),
    (19, ["considero", "conspicio", "divido", "vestimentum", "vestis", "mitto", "sors"]),
    (20, ["dominus", "elongo", "auxilium", "defensio", "conspicio"]),
    (21, ["eruo", "framea", "anima", "manus", "canis", "unicus"]),
    (22, ["salvo", "os", "leo", "cornu", "unicornis", "humilitas"]),
    (23, ["narro", "nomen", "frater", "ecclesia", "laudo"]),
    (24, ["timeo", "dominus", "laudo", "universus", "semen", "iacob", "glorifico"]),
    (25, ["timeo", "semen", "israel", "sperno", "despicio", "deprecatio", "pauper"]),
    (26, ["averto", "facies", "clamo", "exaudio"]),
    (27, ["laus", "ecclesia", "votum", "reddo", "conspectus", "timeo"]),
    (28, ["edo", "pauper", "satur", "laudo", "dominus", "requiro", "vivo", "cor", "saeculum"]),
    (29, ["reminiscor", "converto", "dominus", "universus", "finis", "terra"]),
    (30, ["adoro", "conspectus", "universus", "familia", "gens"]),
    (31, ["quoniam", "dominus", "regnum", "ipse", "dominor", "gens"]),
    (32, ["manduco", "adoro", "pinguis", "terra", "conspectus", "cado", "descendo", "terra"]),
    (33, ["anima", "vivo", "semen", "servio"]),
    (
      34,
      ["annuntio", "dominus", "generatio", "venio", "iustitia", "populus", "nascor", "facio"]
    ),
  ]

  private let structuralThemes = [
    (
      "Cry of Abandonment → Unanswered Prayer",
      "The psalmist's cry of abandonment and his experience of unanswered prayer",
      ["deus", "respicio", "derelinquo", "clamo", "exaudio", "nox"],
      1,
      2,
      "The psalmist cries out to God asking why he has been forsaken, and describes how he cries by day and night but is not heard.",
      "Augustine sees this as Christ's cry from the cross, expressing the depth of human suffering and the apparent absence of God in the darkest moments of the Passion."
    ),
    (
      "Divine Dwelling → Historical Trust",
      "God's dwelling in holiness contrasted with the historical trust of the fathers",
      ["sanctus", "habito", "laus", "israel", "spero", "pater", "libero"],
      3,
      4,
      "The psalmist acknowledges that God dwells in the holy place and is the praise of Israel, and recalls how the fathers trusted in God and were delivered.",
      "For Augustine, this represents the contrast between God's eternal holiness and the historical pattern of divine deliverance, showing that God's faithfulness endures even in present suffering."
    ),
    (
      "Historical Salvation → Present Desolation",
      "The fathers' salvation contrasted with the psalmist's present state of desolation",
      ["clamo", "salvus", "spero", "confundo", "vermis", "homo", "opprobrium"],
      5,
      6,
      "The psalmist recalls how the fathers cried to God and were saved, but contrasts this with his own state as a worm, not a man, and the reproach of men.",
      "Augustine sees this as the contrast between the historical pattern of salvation and Christ's present suffering, where the Savior takes on the lowest form to redeem humanity."
    ),
    (
      "Mockery and Scorn → Hope in Deliverance",
      "The mockery of enemies contrasted with hope in divine deliverance",
      ["video", "derideo", "labium", "moveo", "caput", "spero", "dominus", "eripio", "salvus"],
      7,
      8,
      "The psalmist describes how all who see him mock him and wag their heads, but then expresses hope that the Lord will deliver and save him.",
      "For Augustine, this represents the mockery Christ endured on the cross, while maintaining hope in the Father's ultimate deliverance through resurrection."
    ),
    (
      "Divine Origin → Maternal Trust",
      "The psalmist's origin from God and trust from his mother's womb",
      ["extraho", "venter", "spes", "uber", "mater", "proicio", "uterus", "deus"],
      9,
      10,
      "The psalmist recalls that God drew him from the womb and was his hope from his mother's breasts, and that he was cast upon God from the womb.",
      "Augustine sees this as Christ's eternal relationship with the Father, showing that even in suffering, the divine nature and trust in God remain unbroken."
    ),
    (
      "Present Tribulation → Animal Enemies",
      "The psalmist's present tribulation and the animal imagery of his enemies",
      [
        "discedo", "tribulatio", "proximus", "adiuvo", "circumdo", "vitulus", "taurus", "pinguis",
        "obsideo",
      ],
      11,
      12,
      "The psalmist pleads that God not depart from him in tribulation, then describes how many calves and fat bulls have surrounded and besieged him.",
      "For Augustine, this represents the intensity of Christ's suffering and the ferocity of his enemies, portrayed as wild animals encircling their prey."
    ),
    (
      "Lion's Mouth → Physical Dissolution",
      "The lion's mouth threatening the psalmist and his physical dissolution",
      [
        "aperio", "os", "leo", "rapio", "rugio", "aqua", "effundo", "dispergo", "os", "cor", "cera",
        "liquesco",
      ],
      13,
      14,
      "The psalmist describes how his enemies opened their mouths like a ravening lion, and how he is poured out like water with his bones scattered and heart melted like wax.",
      "Augustine sees this as the physical effects of Christ's suffering, where the body is broken and the heart is melted in the intensity of the Passion."
    ),
    (
      "Physical Weakness → Death's Approach",
      "The psalmist's physical weakness and the approach of death",
      [
        "aresco", "testa", "virtus", "lingua", "adhaereo", "faux", "pulvis", "mors", "circumdo",
        "canis", "malignor",
      ],
      15,
      16,
      "The psalmist describes his strength dried like pottery and tongue cleaving to jaws, brought down to dust of death, while many dogs surround him.",
      "For Augustine, this represents the complete physical exhaustion of Christ in his Passion, where even the tongue fails and death approaches, surrounded by enemies."
    ),
    (
      "Crucifixion Details → Garment Division",
      "The specific details of crucifixion and the division of garments",
      [
        "fodio", "manus", "pes", "dinumero", "os", "considero", "conspicio", "divido",
        "vestimentum", "sors",
      ],
      17,
      18,
      "The psalmist describes how they pierced his hands and feet, numbered all his bones, and divided his garments among them, casting lots for his vesture.",
      "Augustine sees this as the precise fulfillment of Christ's crucifixion, where the hands and feet are pierced, and the soldiers divide his garments as foretold."
    ),
    (
      "Plea for Help → Deliverance from Enemies",
      "The psalmist's plea for divine help and deliverance from various enemies",
      [
        "dominus", "elongo", "auxilium", "defensio", "conspicio", "eruo", "framea", "anima",
        "canis", "unicus",
      ],
      19,
      20,
      "The psalmist pleads that God not remove his help far from him, and asks to be delivered from the sword and from the hand of the dog.",
      "For Augustine, this represents Christ's prayer for deliverance in Gethsemane and the ultimate rescue from the power of death and the devil."
    ),
    (
      "Lion and Unicorn → Declaration of Praise",
      "Deliverance from lion and unicorn leading to declaration of God's name",
      [
        "salvo", "os", "leo", "cornu", "unicornis", "humilitas", "narro", "nomen", "frater",
        "ecclesia", "laudo",
      ],
      21,
      22,
      "The psalmist asks to be saved from the lion's mouth and unicorn's horns, then declares he will proclaim God's name to his brethren and praise him in the assembly.",
      "For Augustine, this represents Christ's resurrection and his commissioning of the apostles to proclaim the Gospel and praise God in the Church."
    ),
    (
      "Call to Praise → Divine Response",
      "The call for all to praise God and the assurance of divine response",
      [
        "timeo", "dominus", "laudo", "semen", "iacob", "glorifico", "israel", "sperno", "despicio",
        "deprecatio", "pauper", "exaudio",
      ],
      23,
      24,
      "The psalmist calls all who fear the Lord to praise him, and assures that all the seed of Israel will fear him because he has not despised the poor man's supplication.",
      "For Augustine, this represents the universal call to worship that follows Christ's resurrection, and the assurance that God hears the prayers of the humble."
    ),
    (
      "Vow Fulfillment → Poor Satisfaction",
      "The fulfillment of vows in the assembly and the satisfaction of the poor",
      [
        "laus", "ecclesia", "votum", "reddo", "conspectus", "timeo", "edo", "pauper", "satur",
        "laudo", "requiro", "vivo", "cor",
      ],
      25,
      26,
      "The psalmist will pay his vows in the sight of those who fear God, and the poor will eat and be satisfied, praising the Lord and living forever.",
      "For Augustine, this represents the fulfillment of Christ's promises in the Church, where the poor in spirit are satisfied and the faithful live eternally."
    ),
    (
      "Universal Conversion → Divine Kingdom",
      "The conversion of all nations and the establishment of God's kingdom",
      [
        "reminiscor", "converto", "dominus", "universus", "finis", "terra", "adoro", "familia",
        "gens", "regnum", "dominor",
      ],
      27,
      28,
      "All the ends of the earth will remember and turn to the Lord, and all families will worship him, for the kingdom belongs to the Lord who rules over the nations.",
      "For Augustine, this represents the universal scope of Christ's redemption, where all nations are converted and God's eternal kingdom is established."
    ),
    (
      "Universal Worship → Eternal Service",
      "The universal worship of all people and the eternal service of the psalmist's descendants",
      [
        "manduco", "adoro", "pinguis", "terra", "cado", "descendo", "anima", "vivo", "semen",
        "servio", "annuntio", "generatio", "iustitia",
      ],
      29,
      30,
      "All the fat ones of the earth will eat and worship, falling before God, and the psalmist's soul will live and his descendants will serve God forever.",
      "For Augustine, this represents the final consummation where all creation worships God, and the eternal life and service that flows from Christ's victory."
    ),
    (
      "Future Generation → Divine Justice",
      "The proclamation to future generations and the revelation of divine justice",
      ["annuntio", "dominus", "generatio", "venio", "iustitia", "populus", "nascor", "facio"],
      31,
      32,
      "A generation to come will be declared to the Lord, and they will proclaim his justice to a people yet to be born, whom the Lord has made.",
      "For Augustine, this represents the eternal proclamation of Christ's victory and justice, extending to all future generations until the end of time."
    ),
    (
      "Eternal Proclamation → Divine Creation",
      "The eternal proclamation of God's justice and the creation of a new people",
      ["annuntio", "dominus", "generatio", "venio", "iustitia", "populus", "nascor", "facio"],
      33,
      34,
      "The Lord's generation will be proclaimed forever, and they will declare his justice to a people that will be born, whom the Lord has made.",
      "For Augustine, this represents the eternal nature of the Gospel proclamation and the creation of the Church as God's new people through Christ's redemptive work."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Abandonment",
      "The experience of being forsaken by God in suffering",
      ["derelinquo", "respicio", "clamo", "exaudio", "discedo", "auxilium"],
      ThemeCategory.divine,
      1...20
    ),
    (
      "Physical Suffering",
      "The intense physical pain and bodily dissolution of the psalmist",
      [
        "vermis", "opprobrium", "os", "cera", "testa", "fodio", "manus", "pes", "os", "aqua",
        "effundo", "liquesco",
      ],
      ThemeCategory.sin,
      6...18
    ),
    (
      "Animal Enemies",
      "Enemies portrayed as wild animals threatening the psalmist",
      ["vitulus", "taurus", "leo", "canis", "unicornis", "rapio", "rugio", "obsideo"],
      ThemeCategory.sin,
      12...21
    ),
    (
      "Historical Trust",
      "The pattern of divine deliverance in Israel's history",
      ["pater", "spero", "libero", "clamo", "salvus", "confundo"],
      ThemeCategory.divine,
      4...5
    ),
    (
      "Maternal Origin",
      "The psalmist's origin and trust from his mother's womb",
      ["venter", "spes", "uber", "mater", "proicio", "uterus"],
      ThemeCategory.virtue,
      9...10
    ),
    (
      "Mockery and Scorn",
      "The derision and mockery suffered by the psalmist",
      ["video", "derideo", "labium", "moveo", "caput", "considero", "conspicio"],
      ThemeCategory.sin,
      7...18
    ),
    (
      "Divine Deliverance",
      "God's rescue and salvation of the psalmist",
      ["eripio", "salvus", "eruo", "salvo", "auxilium", "defensio"],
      ThemeCategory.divine,
      8...21
    ),
    (
      "Universal Praise",
      "The call for all creation to praise and worship God",
      ["laudo", "ecclesia", "glorifico", "adoro", "timeo", "dominus"],
      ThemeCategory.worship,
      22...34
    ),
    (
      "Eternal Life",
      "The promise of eternal life and service to God",
      ["vivo", "cor", "saeculum", "anima", "semen", "servio"],
      ThemeCategory.divine,
      26...34
    ),
    (
      "Divine Kingdom",
      "The establishment and rule of God's eternal kingdom",
      ["regnum", "dominor", "gens", "universus", "finis", "terra"],
      ThemeCategory.divine,
      27...34
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 21 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 21 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm21_texts.json"
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
      filename: "output_psalm21_themes.json"
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
