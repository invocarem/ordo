@testable import LatinService
import XCTest

class Psalm34Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 34, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 32

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  private let text = [
    "Iudica, Domine, nocentes me; expugna impugnantes me.",
    "Apprehende arma et scutum, et exsurge in adiutorium mihi.",
    "Effunde frameam, et conclude adversus eos qui persequuntur me; dic animae meae: Salus tua ego sum.",
    "Confundantur et revereantur qui quaerunt animam meam; ",
    "Avertantur retrorsum et erubescant qui cogitant mihi mala.",

    "Fiant tamquam pulvis ante faciem venti; et angelus Domini coarctans eos.",
    "Fiat via illorum tenebrae et lubricum; et angelus Domini persequens eos.",
    "Quoniam gratis absconderunt mihi interitum laquei sui; supervacue exprobraverunt animam meam.",
    "Veniat illi laqueus quem ignorat; et captio quam abscondit apprehendat eum, et in laqueum cadat in ipsum.",
    "Anima autem mea exsultabit in Domino; et delectabitur super salutari suo.",

    "Omnia ossa mea dicent: Domine, quis similis tui?",
    "Eripiens inopem de manu fortiorum eius; egenum et pauperem a diripientibus eum.",
    "Surgentes testes iniqui, quae ignorabam interrogabant me.",
    "Retribuebant mihi mala pro bonis; sterilitatem animae meae.",
    "Ego autem cum mihi molesti essent, induebar cilicio; ",

    "Humiliabam in ieiunio animam meam, et oratio mea in sinu meo convertetur.",
    "Quasi proximum, et quasi fratrem nostrum, sic complacebam; quasi lugens et contristatus, sic humiliabar.",
    "Et adversum me laetati sunt, et convenerunt; congregata sunt super me flagella, et ignoravi.",
    "Dissipati sunt, nec compuncti; tentaverunt me, subsannaverunt me subsannatione, frenduerunt super me dentibus suis.",
    "Domine, quando respicies? restitue animam meam a malignitate eorum, a leonibus unicam meam.",

    "Confitebor tibi in ecclesia magna, in populo gravi laudabo te.",
    "Non supergaudeant mihi qui adversantur mihi inique; qui oderunt me gratis, et annuunt oculis.",
    "Quoniam mihi quidem pacifice loquebantur; et in iracundia terrae loquentes, dolos cogitabant.",
    "Et dilataverunt super me os suum; dixerunt: Euge, euge, viderunt oculi nostri.",
    "Vidisti, Domine, ne sileas; Domine, ne discedas a me.",

    "Exsurge, et intende iudicio meo; Deus meus, et Dominus meus, in causam meam.",
    "Iudica me secundum iustitiam tuam, Domine Deus meus; et non supergaudeant mihi.",
    "Non dicant in cordibus suis: Euge, euge, animae nostrae; nec dicant: Devoravimus eum.",
    "Erubescant et revereantur simul, qui gratulantur malis meis;",
    "Induantur pudore et confusione, qui magna loquuntur super me.",

    "Exsultent et laetentur qui volunt iustitiam meam; et dicant semper: Magnificetur Dominus, qui volunt pacem servi eius.",
    "Et lingua mea meditabitur iustitiam tuam; tota die laudem tuam.",
  ]

  private let englishText = [
    "Judge thou, O Lord, them that wrong me: overthrow them that fight against me.",
    "Take hold of arms and shield: and rise up to help me.",
    "Bring out the sword, and shut up the way against them that persecute me: say to my soul: I am thy salvation.",
    "Let them be confounded and ashamed that seek after my soul.",
    "Let them be turned back and be ashamed that devise evil against me.",
    "Let them become as dust before the wind: and let the angel of the Lord straiten them.",
    "Let their way become dark and slippery; and let the angel of the Lord pursue them.",
    "For without cause they have hidden their net for me unto destruction: without cause have they upbraided my soul.",
    "Let the snare which he knoweth not come upon him: and let the net which he hath hidden catch him: and into that very snare let them fall.",
    "But my soul shall rejoice in the Lord; and shall be delighted in his salvation.",
    "All my bones shall say: Lord, who is like to thee?",
    "Delivering the poor from the hand of the stronger: and the needy and the poor from them that strip them.",
    "Unjust witnesses rising up have asked me of things I knew not.",
    "They repaid me evil for good: to the depriving me of my soul.",
    "But as for me, when they were troublesome to me, I was clothed with haircloth.",
    "I humbled my soul with fasting; and my prayer shall be turned into my bosom.",
    "As a neighbour and as an own brother, so did I please: as one mourning and sorrowful so was I humbled.",
    "But they rejoiced against me, and came together: scourges were gathered together upon me, and I knew not.",
    "They were scattered, but they repented not: they tempted me, they scoffed at me with scorn: they gnashed upon me with their teeth.",
    "Lord, when wilt thou look upon me? rescue thou my soul from their malice: my only one from the lions.",
    "I will give thanks to thee in a great church; I will praise thee in a strong people.",
    "Let not them that are my enemies wrongfully rejoice over me: who have hated me without cause, and wink with the eyes.",
    "For they spoke indeed peaceably to me; and speaking in the anger of the earth they devised guile.",
    "And they opened their mouth wide against me; they said: Well done, well done, our eyes have seen it.",
    "Thou hast seen, O Lord, be not thou silent: O Lord, depart not from me.",
    "Arise, and be attentive to my judgment: to my cause, my God, and my Lord.",
    "Judge me, O Lord my God according to thy justice, and let them not rejoice over me.",
    "Let them not say in their hearts: It is well, it is well, to our mind: neither let them say: We have swallowed him up.",
    "Let them blush: and be ashamed together, who rejoice at my evils.",
    "Let them be clothed with shame and confusion, who speak great things against me.",
    "Let them rejoice and be glad, who are willing my justice: and may they always say: The Lord be magnified, who will the peace of his servant.",
    "And my tongue shall meditate thy justice, thy praise all the day long.",
  ]

  private let lineKeyLemmas = [
    (1, ["iudico", "dominus", "noceo", "expugno", "impugno"]),
    (2, ["apprehendo", "arma", "scutum", "exsurgo", "adiutorium"]),
    (3, ["effundo", "framea", "concludo", "persequor", "dico", "anima", "salus"]),
    (4, ["confundo", "revereor", "quaero"]),
    (5, ["averto", "erubesco", "cogito", "malus"]),
    (6, ["pulvis", "facies", "ventus", "angelus", "dominus", "coarcto"]),
    (7, ["via", "tenebrae", "lubricus", "angelus", "dominus", "persequor"]),
    (8, ["gratis", "abscondo", "interitus", "laqueus", "supervacue", "exprobro", "anima"]),
    (9, ["venio", "laqueus", "ignoro", "captio", "abscondo", "apprehendo", "cado"]),
    (10, ["anima", "exsulto", "dominus", "delector", "salutaris"]),
    (11, ["omnis", "os", "dico", "dominus", "similis"]),
    (12, ["eripio", "inops", "manus", "fortis", "egenus", "pauper", "diripio"]),
    (13, ["surgo", "testis", "iniquus", "ignoro", "interrogo"]),
    (14, ["retribuo", "malus", "bonus", "sterilitas", "anima"]),
    (15, ["molestus", "induo", "cilicium"]),
    (16, ["humilio", "ieiunio", "anima", "oratio", "sinus", "converto"]),
    (17, ["proximus", "frater", "complaceo", "lugeo", "contristo", "humilio"]),
    (18, ["adversus", "laetor", "convenio", "congrego", "flagellum", "ignoro"]),
    (19, ["dissipo", "compungo", "tento", "subsanno", "frendo", "dens"]),
    (20, ["dominus", "respicio", "restituo", "anima", "malignitas", "leo", "unicus"]),
    (21, ["confiteor", "ecclesia", "magnus", "populus", "gravis", "laudo"]),
    (22, ["supergaudeo", "adverso", "inique", "odi", "gratis", "annuo", "oculus"]),
    (23, ["pacificus", "loquor", "iracundia", "terra", "loquor", "dolus", "cogito"]),
    (24, ["dilato", "os", "dico", "euge", "video", "oculus"]),
    (25, ["video", "dominus", "sileo", "dominus", "discedo"]),
    (26, ["exsurgo", "intendo", "iudicium", "deus", "dominus", "causa"]),
    (27, ["iudico", "secundum", "iustitia", "dominus", "deus", "supergaudeo"]),
    (28, ["dico", "cor", "euge", "anima", "devoro"]),
    (29, ["erubesco", "revereor", "simul", "gratulor", "malus"]),
    (30, ["induo", "pudor", "confusio", "magnus", "loquor", "super"]),
    (31, ["exsulto", "laetor", "volo", "iustitia", "dico", "semper", "magnifico", "dominus", "volo", "pax", "servus"]),
    (32, ["lingua", "meditor", "iustitia", "totus", "dies", "laus"]),
  ]

  private let structuralThemes = [
    (
      "Divine Justice → Divine Protection",
      "Call for divine judgment and protection against enemies",
      ["iudico", "expugno", "apprehendo", "arma", "scutum", "exsurgo", "adiutorium"],
      1,
      2,
      "The psalmist calls for God to judge his enemies and fight against them, then asks God to take up weapons and shield and arise to help him.",
      "Augustine sees this as the soul's appeal to divine justice combined with trust in God's protective power, recognizing that only divine intervention can overcome spiritual enemies."
    ),
    (
      "Divine Warfare → Enemy Shame",
      "God's military intervention leading to enemy confusion and shame",
      ["effundo", "framea", "concludo", "persequor", "confundo", "revereor", "averto", "erubesco"],
      3,
      5,
      "God is asked to pour out the sword and confine those who persecute, while enemies are to be confounded, ashamed, and turned back.",
      "For Augustine, this represents God's sovereign power to both actively fight for His people and cause their enemies to be spiritually disgraced and defeated."
    ),
    (
      "Enemy Destruction → Angelic Intervention",
      "Enemies scattered like dust while angels of the Lord pursue them",
      ["pulvis", "ventus", "angelus", "dominus", "coarcto", "tenebrae", "lubricus", "persequor"],
      6,
      7,
      "Enemies become like dust before the wind, while the angel of the Lord harasses them and their way becomes dark and slippery as the angel pursues them.",
      "Augustine sees this as divine judgment where natural forces and angelic beings work together to scatter and pursue the wicked, making their path treacherous."
    ),
    (
      "Unjust Attacks → Poetic Justice",
      "Enemies' unjust snares and traps leading to their own downfall",
      ["gratis", "interitus", "laqueus", "supervacue", "exprobro", "captio", "cado"],
      8,
      9,
      "Enemies have hidden destruction and snares without cause, but their own snare and trap will catch them and they will fall into it.",
      "Augustine interprets this as divine justice where the wicked's own devices become their downfall, demonstrating that evil ultimately destroys itself."
    ),
    (
      "Joyful Trust → Bodily Praise",
      "The psalmist's rejoicing in God's salvation and bodily declaration of praise",
      ["anima", "exsulto", "dominus", "delector", "salutaris", "os", "dico", "similis"],
      10,
      11,
      "The psalmist's soul will rejoice in the Lord and delight in His salvation, while all his bones will declare that none is like the Lord.",
      "Augustine sees this as the soul's response to divine deliverance - both spiritual joy and physical declaration of God's incomparable greatness."
    ),
    (
      "Divine Rescue → False Witnesses",
      "God's deliverance of the poor contrasted with unjust witnesses",
      ["eripio", "inops", "fortis", "egenus", "pauper", "testis", "iniquus", "interrogo"],
      12,
      13,
      "God rescues the needy from the strong and delivers the poor from robbers, while unjust witnesses rise up and question the psalmist about things he doesn't know.",
      "For Augustine, this shows God's care for the oppressed while highlighting the contrast with false accusers who seek to harm the innocent."
    ),
    (
      "Repaid Evil → Penitential Response",
      "Enemies repaying evil for good while the psalmist responds with penitential practices",
      ["retribuo", "malus", "bonus", "sterilitas", "cilicium", "humilio", "ieiunio", "oratio"],
      14,
      16,
      "Enemies repaid evil for good and caused bereavement, while the psalmist wore sackcloth, humbled himself with fasting, and turned his prayer inward.",
      "Augustine sees this as the contrast between wicked retaliation and righteous penitence - the psalmist's spiritual discipline in response to unjust treatment."
    ),
    (
      "False Friendship → Betrayal",
      "Pretended friendship and brotherhood leading to betrayal and mockery",
      ["proximus", "frater", "complaceo", "lugeo", "contristo", "convenio", "flagellum", "dissipo", "subsanno", "frendo"],
      17,
      19,
      "The psalmist treated enemies as neighbors and brothers, mourning and humbling himself, but they rejoiced against him, assembled, and mocked him with scorn and gnashing teeth.",
      "Augustine interprets this as the ultimate betrayal - those who appeared as friends and brothers became the psalmist's greatest enemies, mocking his piety and seeking his destruction."
    ),
    (
      "Divine Intervention → Public Praise",
      "Call for divine help leading to public confession and praise",
      ["dominus", "respicio", "restituo", "malignitas", "confiteor", "ecclesia", "laudo"],
      20,
      21,
      "The psalmist calls for God to look upon him and rescue his soul from malice, then commits to confessing and praising God in the great assembly.",
      "Augustine sees this as the soul's progression from desperate plea to confident praise - recognizing God's deliverance leads to public declaration of His goodness."
    ),
    (
      "Enemy Mockery → Righteous Joy",
      "Enemies' hypocritical speech and mockery contrasted with righteous celebration",
      ["supergaudeo", "adverso", "odi", "pacificus", "iracundia", "dolus", "dilato", "euge", "exsulto", "laetor", "iustitia", "magnus", "loquor"],
      22,
      31,
      "Enemies hate without cause and speak peaceably while devising guile, opening their mouths wide in mockery, while the righteous rejoice and are glad, always saying 'Let the Lord be magnified.'",
      "For Augustine, this represents the fundamental contrast between hypocritical evil and genuine righteousness - false peace versus true joy, mockery versus authentic praise."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Justice",
      "God's judgment and righteous intervention against enemies",
      ["iudico", "expugno", "confundo", "revereor", "erubesco", "retribuo"],
      ThemeCategory.divine,
      1 ... 31
    ),
    (
      "Divine Protection",
      "God's military and angelic protection of His people",
      ["arma", "scutum", "exsurgo", "adiutorium", "framea", "angelus", "coarcto", "persequor"],
      ThemeCategory.divine,
      1 ... 7
    ),
    (
      "Enemy Shame",
      "Confusion, shame, and defeat of the wicked",
      ["confundo", "revereor", "erubesco", "averto", "dissipo", "pulvis", "tenebrae", "lubricus"],
      ThemeCategory.sin,
      4 ... 19
    ),
    (
      "Personal Lament",
      "The psalmist's suffering, humiliation, and penitential response",
      ["anima", "humilio", "ieiunio", "oratio", "cilicium", "lugeo", "contristo"],
      ThemeCategory.virtue,
      10 ... 17
    ),
    (
      "False Friendship",
      "Hypocritical relationships and betrayal by false friends",
      ["proximus", "frater", "complaceo", "convenio", "pacificus", "dolus", "dilato", "euge"],
      ThemeCategory.sin,
      17 ... 24
    ),
    (
      "Divine Rescue",
      "God's deliverance of the poor and needy",
      ["eripio", "inops", "fortis", "egenus", "pauper", "restituo", "malignitas"],
      ThemeCategory.divine,
      12 ... 20
    ),
    (
      "Public Praise",
      "Confession and praise in the assembly",
      ["confiteor", "ecclesia", "laudo", "magnus", "loquor", "exsulto", "laetor", "meditor", "laus"],
      ThemeCategory.worship,
      21 ... 31
    ),
    (
      "Speech and Tongue",
      "References to speech, tongue, and words as instruments of good or evil",
      ["lingua", "dico", "loquor", "euge", "meditor", "laus"],
      ThemeCategory.virtue,
      1 ... 31
    ),
    (
      "Weapons and Warfare",
      "Military imagery and divine warfare",
      ["arma", "scutum", "framea", "concludo", "persequor", "coarcto"],
      ThemeCategory.divine,
      1 ... 7
    ),
    (
      "Angelic Intervention",
      "Angels of the Lord acting on behalf of the righteous",
      ["angelus", "dominus", "coarcto", "persequor"],
      ThemeCategory.divine,
      6 ... 7
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 34 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 34 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm34_texts.json"
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
      filename: "output_psalm34_themes.json"
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

  // MARK: - Thematic Tests

  func testDivineJusticeTheme() {
    let latinService = LatinService.shared
    let analysis = latinService.analyzePsalm(id, text: text)

    let terms = [
      ("iudico", ["Iudica"], "judge"),
      ("expugno", ["expugna"], "fight against"),
      ("confundo", ["Confundantur"], "confound"),
      ("retribuo", ["Retribuebant"], "repay"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: terms)
  }

  func testEnemyShameTheme() {
    let latinService = LatinService.shared
    let analysis = latinService.analyzePsalm(id, text: text)

    let terms = [
      ("revereor", ["revereantur"], "fear"),
      ("erubesco", ["erubescant"], "shame"),
      ("confusio", ["confusione"], "confusion"),
      ("pudor", ["pudore"], "shame"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: terms)
  }

  func testDivineProtectionTheme() {
    let latinService = LatinService.shared
    let analysis = latinService.analyzePsalm(id, text: text)

    let terms = [
      ("arma", ["arma"], "weapons"),
      ("scutum", ["scutum"], "shield"),
      ("angelus", ["angelus"], "angel"),
      ("adiutorium", ["adiutorium"], "help"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: terms)
  }

  func testPersonalLamentTheme() {
    let latinService = LatinService.shared
    let analysis = latinService.analyzePsalm(id, text: text)

    let terms = [
      ("anima", ["animae", "animam", "animae", "animam"], "soul"),
      ("humilio", ["humiliabam", "humiliabar"], "humble"),
      ("oratio", ["oratio"], "prayer"),
      ("ieiumium", ["ieiunio"], "fasting"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: terms)
  }

  // MARK: - Helper

  private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
    for (lemma, forms, translation) in confirmedWords {
      guard let entry = analysis.dictionary[lemma] else {
        XCTFail("Missing lemma: \(lemma)")
        continue
      }

      XCTAssertTrue(
        entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
        "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
      )

      let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
      if !missingForms.isEmpty {
        XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
      }

      if verbose {
        print("\n\(lemma.uppercased())")
        print("  Translation: \(entry.translation ?? "?")")
        for form in forms {
          let count = entry.forms[form.lowercased()] ?? 0
          print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
        }
      }
    }
  }
}
