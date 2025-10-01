@testable import LatinService
import XCTest

class Psalm9ATests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private var latinService: LatinService!
  private let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  override func tearDown() {
    latinService = nil
    super.tearDown()
  }

  // MARK: - Test Data (Psalm 9A)

  let id = PsalmIdentity(number: 9, category: "A")
  let psalm9A = [
    "Confitebor tibi, Domine, in toto corde meo; narrabo omnia mirabilia tua.",
    "Laetabor et exsultabo in te; psallam nomini tuo, Altissime.",
    "In convertendo inimicum meum retrorsum, infirmabuntur, et peribunt a facie tua.",
    "Quoniam fecisti iudicium meum et causam meam; sedisti super thronum, qui iudicas iustitiam.",
    "Increpasti gentes, et periit impius; nomen eorum delesti in aeternum, et in saeculum saeculi.",

    "Inimici defecerunt frameae in finem: et civitates destruxisti;",
    "Periit memoria eorum cum sonitu. Et Dominus in aeternum permanet; ",
    "Paravit in iudicio thronum suum. Et ipse iudicabit orbem terrae in aequitate; iudicabit populos in iustitia.",
    "Et factus est Dominus refugium pauperi; adiutor in opportunitatibus, in tribulatione.",
    "Et sperent in te qui noverunt nomen tuum; quoniam non dereliquisti quaerentes te, Domine.",

    "Psallite Domino, qui habitat in Sion; annuntiate inter gentes studia eius:",
    "Quoniam requirens sanguinem eorum recordatus est; non est oblitus clamorem pauperum.",
    "Miserere mei, Domine; vide humilitatem meam de inimicis meis,",
    "Qui exaltas me de portis mortis, ut annuntiem omnes laudationes tuas in portis filiae Sion.",
    "Exsultabo in salutari tuo; infixae sunt gentes in interitu quem fecerunt;",
    "In laqueo isto quem absconderunt comprehensus est pes eorum.",
    "Cognoscitur Dominus iudicia faciens; in operibus manuum suarum comprehensus est peccator.",
    "Convertantur peccatores in infernum, omnes gentes quae obliviscuntur Deum.",
    "Quoniam non in finem oblivio erit pauperis; patientia pauperum non peribit in finem.",
  ]

  private let englishText = [
    "I will praise thee, O Lord, with my whole heart; I will shew forth all thy marvellous works.",
    "I will be glad and rejoice in thee: I will sing praise to thy name, O thou most High.",
    "When mine enemies are turned back, they shall fall and perish at thy presence.",
    "For thou hast maintained my right and my cause; thou satest in the throne judging right.",
    "Thou hast rebuked the heathen, thou hast destroyed the wicked, thou hast put out their name for ever and ever.",
    "O thou enemy, destructions are come to a perpetual end: and thou hast destroyed cities;",
    "Their memory hath perished with a noise: But the Lord remaineth for ever.",
    "He hath prepared his throne in judgment: And he shall judge the world in equity, he shall judge the people in justice.",
    "And the Lord is become a refuge for the poor: a helper in due time in tribulation.",
    "And they that know thy name will put their trust in thee: for thou, Lord, hast not forsaken them that seek thee.",
    "Sing praises to the Lord, which dwelleth in Zion: declare among the people his doings.",
    "When he maketh inquisition for blood, he remembereth them: he forgetteth not the cry of the humble.",
    "Have mercy upon me, O Lord; consider my trouble which I suffer of them that hate me,",
    "Thou that liftest me up from the gates of death: that I may shew forth all thy praise in the gates of the daughter of Zion.",
    "I will rejoice in thy salvation: the heathen are sunk down in the pit that they made.",
    "In the net which they hid is their own foot taken.",
    "The Lord is known by the judgment which he executeth: the wicked is snared in the work of his own hands.",
    "The wicked shall be turned into hell, and all the nations that forget God.",
    "For the needy shall not alway be forgotten: the expectation of the poor shall not perish for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["confiteor", "dominus", "cor", "narro", "mirabilis", "totus", "omnis"]),
    (2, ["laetor", "exsulto", "psallo", "nomen", "altissimus"]),
    (3, ["converto", "inimicus", "retrorsum", "infirmo", "pereo", "facies"]),
    (4, ["facio", "iudicium", "causa", "sedeo", "thronus", "iudico", "iustitia"]),
    (5, ["increpo", "gens", "pereo", "impius", "nomen", "deleo", "aeternus", "saeculum"]),
    (6, ["inimicus", "deficio", "framea", "finis", "civitas", "destruo"]),
    (7, ["dominus", "aeternus", "permaneo", "memoria", "sonitus", "pereo"]),
    (8, ["paro", "iudicium", "thronus", "iudico", "orbis", "terra", "aequitas", "populus", "iustitia"]),
    (9, ["facio", "dominus", "refugium", "pauper", "adiutor", "opportunitas", "tribulatio"]),
    (10, ["spero", "nosco", "nomen", "derelinquo", "quaero", "dominus"]),
    (11, ["psallo", "dominus", "habito", "sion", "annuntio", "gens", "studium"]),
    (12, ["requiro", "sanguis", "recordor", "obliviscor", "clamor", "pauper"]),
    (13, ["misereor", "dominus", "video", "humilitas", "inimicus"]),
    (14, ["exalto", "porta", "mors", "annuntio", "laudatio", "filia", "sion", "omnis"]),
    (15, ["exsulto", "salus", "infigo", "gens", "interitus", "facio"]),
    (16, ["laqueus", "abscondo", "comprehendo", "pes"]),
    (17, ["cognosco", "dominus", "iudicium", "facio", "opus", "manus", "comprehendo", "peccator"]),
    (18, ["converto", "peccator", "infernus", "gens", "obliviscor", "deus", "omnis"]),
    (19, ["finis", "oblivio", "pauper", "patientia", "pereo"]),
  ]

  private let structuralThemes = [
    (
      "Thanksgiving → Praise",
      "Wholehearted thanksgiving leads to joyful praise of God's marvelous works",
      ["confiteor", "mirabilis", "exsulto", "psallo"],
      1,
      2,
      "The psalmist begins with wholehearted thanksgiving, vowing to declare all God's wonders and rejoicing in song to His name.",
      "Augustine sees here the perfect confession of the Church, where thanksgiving for Christ's marvels leads to eternal praise (Enarr. Ps. 9.1-2)."
    ),
    (
      "Enemy → Justice",
      "The turning back of enemies leads to God's righteous judgment from His throne",
      ["inimicus", "retrorsum", "iudicium", "thronus"],
      3,
      4,
      "God turns back the enemy, causing them to weaken and perish, while He sits enthroned judging righteously and vindicating the cause of the faithful.",
      "Augustine interprets this as Christ's victory over spiritual enemies and His eternal reign as righteous judge (Enarr. Ps. 9.3-4)."
    ),
    (
      "Rebuke → Destruction",
      "Divine rebuke of nations leads to the complete destruction of the wicked",
      ["increpo", "impius", "nomen", "framea"],
      5,
      6,
      "God rebukes the nations, the wicked perish, their names are blotted out forever, their weapons fail, and their cities are destroyed.",
      "For Augustine, this signifies the ultimate fate of all earthly powers opposed to God's kingdom (Enarr. Ps. 9.5-6)."
    ),
    (
      "Memory → Eternity",
      "The noisy perishing of human memory contrasts with God's eternal reign",
      ["memoria", "sonitus", "aeternus", "permaneo"],
      7,
      8,
      "The memory of enemies perishes with noise, but the Lord endures forever, establishing His throne for righteous judgment of the world.",
      "Augustine contrasts the temporary noise of earthly destruction with God's eternal, quiet sovereignty (Enarr. Ps. 9.7-8)."
    ),
    (
      "Refuge → Hope",
      "God's refuge for the poor inspires hope in those who know His name",
      ["refugium", "pauper", "nomen", "spero"],
      9,
      10,
      "The Lord becomes a refuge for the poor and a helper in trouble, inspiring hope in those who know His name, for He does not forsake seekers.",
      "Augustine teaches that Christ is the true refuge, and knowledge of His name brings sure hope (Enarr. Ps. 9.9-10)."
    ),
    (
      "Proclamation → Remembrance",
      "Songs in Zion proclaim God's deeds and His remembrance of the oppressed",
      ["psallo", "Sion", "sanguis", "recordor"],
      11,
      12,
      "The call to sing in Zion and declare God's deeds among nations emphasizes His remembrance of the blood of the oppressed and the cry of the poor.",
      "Augustine links this to the martyrs' blood and God's faithful remembrance of His suffering people (Enarr. Ps. 9.11-12)."
    ),
    (
      "Mercy → Deliverance",
      "Cry for mercy in affliction leads to deliverance from death's gates",
      ["misereor", "humilitas", "porta", "laudatio"],
      13,
      14,
      "The psalmist cries for mercy in his affliction, asking to be lifted from death's gates to proclaim God's praises in Zion's gates.",
      "Augustine sees this as the soul's cry from spiritual death to resurrection life in Christ (Enarr. Ps. 9.13-14)."
    ),
    (
      "Salvation → Entrapment",
      "Joy in salvation contrasts with nations trapped in their own destruction",
      ["exsulto", "salus", "laqueus", "comprehendo"],
      15,
      16,
      "The psalmist rejoices in God's salvation while nations are trapped in the destruction they prepared, caught in their own hidden snares.",
      "Augustine interprets this as the ironic justice where sinners are caught by their own devices (Enarr. Ps. 9.15-16)."
    ),
    (
      "Judgment → Remembrance",
      "Divine judgment of sinners contrasts with God's eternal remembrance of the poor",
      ["cognosco", "iudicium", "oblivio", "patientia"],
      17,
      19,
      "The Lord is known through His judgments; sinners return to hell and nations forgetting God perish, but the poor are not forgotten and their endurance does not perish.",
      "Augustine emphasizes God's faithful remembrance of the humble despite the judgment of the wicked (Enarr. Ps. 9.17-19)."
    ),
  ]

  private let conceptualThemes = [
    // IMAGERY THEMES
    (
      "Body Parts Imagery",
      "Physical body parts representing spiritual and moral states",
      ["cor", "facies", "nomen", "manus", "pes", "porta"],
      ThemeCategory.virtue,
      1 ... 19
    ),
    (
      "Divine Authority Imagery",
      "Throne, judgment, and royal authority metaphors",
      ["thronus", "iudicium", "iudico", "iustitia", "dominus"],
      ThemeCategory.divine,
      1 ... 19
    ),
    (
      "Destruction and Victory Imagery",
      "Military and destructive metaphors for divine judgment",
      ["pereo", "destruo", "increpo", "deleo", "framea", "civitas"],
      ThemeCategory.conflict,
      1 ... 19
    ),
    (
      "Refuge and Protection Imagery",
      "Safety, refuge, and divine protection metaphors",
      ["refugium", "adiutor", "spero", "misereor", "exalto", "salus"],
      ThemeCategory.divine,
      1 ... 19
    ),
    (
      "Memory and Remembrance Imagery",
      "Forgetting, remembering, and eternal memory metaphors",
      ["obliviscor", "recordor", "memoria", "nosco", "cognosco"],
      ThemeCategory.divine,
      1 ... 19
    ),
    (
      "Praise and Worship Imagery",
      "Singing, praising, and worship metaphors",
      ["confiteor", "laetor", "exsulto", "psallo", "annuntio", "laudatio"],
      ThemeCategory.virtue,
      1 ... 19
    ),
    (
      "Poverty and Oppression Imagery",
      "Poor, needy, and oppressed imagery",
      ["pauper", "humilitas", "clamor", "patientia"],
      ThemeCategory.opposition,
      1 ... 19
    ),
    (
      "Eternal and Temporal Imagery",
      "Time, eternity, and permanence metaphors",
      ["aeternus", "saeculum", "permaneo", "finis"],
      ThemeCategory.divine,
      1 ... 19
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    let expectedVerseCount = 19
    XCTAssertEqual(psalm9A.count, expectedVerseCount, "Psalm 9A should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 9A English text should have \(expectedVerseCount) verses")
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm9A.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm9A,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm9A,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
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
      psalmText: psalm9A,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    // First, verify that conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false // Conceptual themes may have additional imagery lemmas
    )

    // Then run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: psalm9A,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Save JSON Functions

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm9A,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm9a_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testSaveThemes() {
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm9a_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  // MARK: - Helper Methods

  private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
    let caseInsensitiveDict = Dictionary(uniqueKeysWithValues:
      analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
    )

    for (lemma, forms, translation) in confirmedWords {
      guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
        print("\n❌ MISSING LEMMA IN DICTIONARY: \(lemma)")
        XCTFail("Missing lemma: \(lemma)")
        continue
      }

      // Verify semantic domain
      XCTAssertTrue(
        entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
        "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
      )

      // Verify morphological coverage (case-insensitive)
      let entryFormsLowercased = Dictionary(uniqueKeysWithValues:
        entry.forms.map { ($0.key.lowercased(), $0.value) }
      )

      let missingForms = forms.filter { entryFormsLowercased[$0.lowercased()] == nil }
      if !missingForms.isEmpty {
        XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
      }

      if verbose {
        print("\n\(lemma.uppercased())")
        print("  Translation: \(entry.translation ?? "?")")
        for form in forms {
          let count = entryFormsLowercased[form.lowercased()] ?? 0
          print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
        }
      }
    }
  }
}

class Psalm9BTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private var latinService: LatinService!
  private let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  override func tearDown() {
    latinService = nil
    super.tearDown()
  }

  // MARK: - Test Data (Psalm 9B)

  let id = PsalmIdentity(number: 9, category: "B")
  let psalm9B = [
    "Exsurge, Domine, non praevaleat homo; iudicentur gentes in conspectu tuo.",
    "Constitue, Domine, legislatorem super eos, ut sciant gentes quoniam homines sunt.",
    "Ut quid, Domine, recessisti longe, despicis in opportunitatibus, in tribulatione?",
    "Dum superbit impius, incenditur pauper; comprehenduntur in consiliis quibus cogitant.",
    "Quoniam laudatur peccator in desideriis animae suae, et iniquus benedicitur.",

    "Exacerbavit Dominum peccator, secundum multitudinem irae suae non quaeret:",
    "Non est Deus in conspectu eius; inquinatae sunt viae illius in omni tempore.",
    "Auferuntur iudicia tua a facie eius; omnium inimicorum suorum dominabitur.",
    "Dixit enim in corde suo: Non movebor a generatione in generationem sine malo.",
    "Cuius maledictione os plenum est, et amaritudine, et dolo; sub lingua eius labor et dolor.",

    "Sedet in insidiis cum divitibus in occultis, ut interficiat innocentem;",
    "Oculi eius in pauperem respiciunt; insidiatur in abscondito, quasi leo in spelunca sua.",
    "Insidiatur ut rapiat pauperem; rapere pauperem dum attrahit eum.",
    "In laqueo suo humiliabit eum; inclinabit se, et cadet cum dominatus fuerit pauperum.",
    "Dixit enim in corde suo: Oblitus est Deus, avertit faciem suam ne videat in finem.",

    "Exsurge, Domine Deus, exaltetur manus tua; ne obliviscaris pauperum.",
    "Propter quid irritavit impius Deum? dixit enim in corde suo: Non requiret.",
    "Vides quoniam tu laborem et dolorem consideras, ut tradas eos in manus tuas.",
    "Tibi derelictus est pauper; orphano tu eris adiutor.",
    "Contere brachium peccatoris et maligni; quaeretur peccatum illius, et non invenietur.",

    "Dominus regnabit in aeternum, et in saeculum saeculi; peribitis, gentes, de terra illius.",
    "Desiderium pauperum exaudivit Dominus; praeparationem cordis eorum audivit auris tua,",
    "Iudicare pupillo et humili, ut non apponat ultra magnificare se homo super terram.",
  ]

  private let englishText = [
    "Arise, O Lord, let not man prevail; let the nations be judged before you.",
    "Put them in fear, O Lord; let the nations know themselves to be but men.",
    "Why, O Lord, do you stand afar off? Why do you hide yourself in times of trouble?",
    "While the wicked man is proud, the poor is set on fire; they are caught in the devices that they have imagined.",
    "For the sinner is praised in the desires of his soul, and the unjust man is blessed.",
    "The sinner has provoked the Lord; according to the multitude of his wrath he will not seek him.",
    "God is not before his eyes; his ways are filthy at all times.",
    "Your judgments are far above out of his sight; he rules over all his enemies.",
    "For he has said in his heart: I shall not be moved; from generation to generation I shall be without evil.",
    "His mouth is full of cursing, deceit, and fraud; under his tongue is mischief and vanity.",
    "He sits in ambush with the rich in secret places, that he may kill the innocent.",
    "His eyes are set against the poor; he lies in wait secretly like a lion in his den.",
    "He lies in wait to catch the poor; he catches the poor when he draws him into his net.",
    "He crouches and humbles himself, that the poor may fall by his strength.",
    "He has said in his heart: God has forgotten; he hides his face; he will never see it.",
    "Arise, O Lord God, lift up your hand; forget not the poor.",
    "Why has the wicked provoked God? For he has said in his heart: He will not require it.",
    "You have seen it; for you behold trouble and grief, to repay it with your hand.",
    "The poor commits himself to you; you are the helper of the fatherless.",
    "Break the arm of the wicked and the evil man; seek out his wickedness until you find none.",
    "The Lord shall reign forever, even your God, O Zion, unto all generations.",
    "The Lord has heard the desire of the poor; your ear has heard the preparation of their heart,",
    "To judge the fatherless and the oppressed, that man may no more presume to magnify himself upon earth.",
  ]

  private let lineKeyLemmas = [
    (1, ["exsurgo", "dominus", "praevaleo", "homo", "iudico", "gens", "conspectus"]),
    (2, ["constituo", "dominus", "legislator", "scio", "gens", "homo"]),
    (3, ["recedo", "dominus", "longus", "despicio", "opportunitas", "tribulatio"]),
    (4, ["superbio", "impius", "incendo", "pauper", "comprehendo", "consilium", "cogito"]),
    (5, ["laudo", "peccator", "desiderium", "anima", "iniquus", "benedico"]),
    (6, ["exacerbo", "dominus", "peccator", "multitudo", "ira", "quaero"]),
    (7, ["deus", "conspectus", "inquinatus", "via", "tempus"]),
    (8, ["aufero", "iudicium", "facies", "inimicus", "dominor"]),
    (9, ["dico", "cor", "moveo", "generatio", "malus"]),
    (10, ["maledictio", "os", "plenus", "amaritudo", "dolus", "lingua", "labor", "dolor"]),
    (11, ["sedeo", "insidiae", "dives", "occultus", "interficio", "innocens"]),
    (12, ["oculus", "pauper", "respicio", "insidior", "leo", "spelunca"]),
    (13, ["insidior", "rapio", "pauper", "attraho"]),
    (14, ["laqueus", "humilio", "inclino", "cado", "dominor", "pauper"]),
    (15, ["dico", "cor", "obliviscor", "deus", "averto", "facies", "video", "finis"]),
    (16, ["exsurgo", "dominus", "deus", "exalto", "manus", "obliviscor", "pauper"]),
    (17, ["irrito", "impius", "deus", "dico", "cor", "requiro"]),
    (18, ["video", "labor", "dolor", "considero", "trado", "manus"]),
    (19, ["derelinquo", "pauper", "orphanus", "adiutor"]),
    (20, ["contero", "brachium", "peccator", "malignus", "quaero", "peccatum", "invenio"]),
    (21, ["dominus", "regno", "aeternus", "saeculum", "pereo", "gens", "terra"]),
    (22, ["desiderium", "pauper", "exaudio", "dominus", "praeparatio", "cor", "auris"]),
    (23, ["iudico", "pupillus", "humilis", "appono", "ultra", "magnifico", "homo", "terra"]),
  ]

  private let structuralThemes = [
    (
      "Rising → Judgment",
      "A call for God to rise leads to judgment that reveals human limits.",
      ["exsurgo", "praevaleo", "constituo", "scio"],
      1,
      2,
      "The psalmist calls for God to rise so humans don't prevail, asking Him to appoint a lawgiver so nations know they are mortal.",
      "Augustine sees this as God humbling human pride through divine judgment (Enarr. Ps. 9.1-2B)."
    ),
    (
      "Distance → Oppression",
      "God's apparent distance enables the wicked to oppress the poor.",
      ["recedo", "superbio", "incendo", "comprehendo"],
      3,
      4,
      "The psalm questions why God stands afar during trouble while the proud inflame and ensnare the poor in their schemes.",
      "Augustine interprets this as the test of faith when God seems distant during persecution (Enarr. Ps. 9.3-4B)."
    ),
    (
      "Praise → Provocation",
      "Praise of sinners for their desires provokes God's anger.",
      ["laudo", "exacerbo", "iniquus", "benedico"],
      5,
      6,
      "The sinner is praised for his desires, and the wicked is blessed, which exacerbates the Lord's anger.",
      "Augustine contrasts this self-glorification with divine requirements (Enarr. Ps. 9.5-6B)."
    ),
    (
      "Denial → Dominance",
      "The denial of God's presence leads to corrupt ways and the removal of His judgment, resulting in worldly dominance.",
      ["inquinatus", "aufero", "iudicium", "dominor"],
      7,
      8,
      "The wicked lives as if there is no God, which corrupts all his ways. God's judgments are removed from his sight, and he dominates all his enemies.",
      "Augustine explains that when a man acts without regard for divine judgment, he becomes utterly corrupt and is left to his own sinful dominion (Enarr. Ps. 9.7-8B)."
    ),
    (
      "Boasting → Corruption",
      "The boast of unshaken stability masks a heart and mouth full of evil, bitterness, and deceit.",
      ["moveo", "maledictio", "amaritudo", "dolus"],
      9,
      10,
      "The wicked boasts in his heart that he will never be moved, yet his mouth is full of curses, bitterness, and deception.",
      "Augustine notes how corrupt speech reveals inner corruption (Enarr. Ps. 9.9-10B)."
    ),
    (
      "Ambush → Observation",
      "Lurking in ambush leads to predatory observation of the poor.",
      ["insidiae", "dives", "oculus", "spelunca"],
      11,
      12,
      "The wicked sits in ambush with the rich, his eyes fixed on the poor, hiding like a lion in its den.",
      "Augustine interprets this as the devil and his agents setting spiritual traps for the righteous from hidden places of wealth and power (Enarr. Ps. 9.11-12B)."
    ),
    (
      "Seizure → Humiliation",
      "The act of seizing the poor leads to their humiliation and downfall.",
      ["rapio", "laqueus", "humilio", "cado"],
      13,
      14,
      "The wicked lies in wait to seize and humble the poor with his snare, bringing them down in their downfall.",
      "Augustine describes this as the successful but temporary victory of the persecutor over the righteous (Enarr. Ps. 9.13-14B)."
    ),
    (
      "Denial → Invocation",
      "The wicked's denial of God's attention provokes a direct invocation for God to rise and remember.",
      ["obliviscor", "averto", "exsurgo", "obliviscor"],
      15,
      16,
      "The wicked's success leads him to think, 'God has forgotten; He has turned His face away.' The psalmist immediately answers this by calling on God to rise and not forget the poor.",
      "Augustine sees this as the faithful response to the taunts of the wicked: turning to God in prayer, not despair (Enarr. Ps. 9.15-16B)."
    ),
    (
      "Provocation → Attention",
      "The wicked's provocation of God, believing He will not inquire, is contrasted with God's careful attention to suffering.",
      ["irrito", "requiro", "video", "labor"],
      17,
      18,
      "The verse asks why the wicked provokes God by saying in his heart that God will not hold him accountable. This is immediately answered by affirming that God does see toil and grief, and He does act to deliver.",
      "Augustine contrasts the fool's belief in God's indifference with the reality of His omniscience and justice, which guarantees judgment (Enarr. Ps. 9.17-18B)."
    ),
    (
      "Destruction → Seeking",
      "The call for destruction of the wicked leads to the seeking out of their sin.",
      ["contero", "quaero", "invenio"],
      19,
      20,
      "The psalmist calls for God to break the arm of the sinner, and that his sin will be sought but not found.",
      "Augustine interprets this as the complete eradication of sin and the ultimate victory of God's justice (Enarr. Ps. 9.19-20B)."
    ),
    (
      "Reign → Justice",
      "God's eternal reign brings justice for the poor and humble.",
      ["regno", "aeternus", "exaudio", "iudico"],
      21,
      23,
      "The Lord reigns forever; He hears the desire of the poor and judges for the orphan and humble, so that man may no longer exalt himself on earth.",
      "Augustine sees this as God's eternal justice prevailing over earthly powers and His special care for the most vulnerable (Enarr. Ps. 9.21-23B)."
    ),
  ]

  private let conceptualThemes = [
    // IMAGERY THEMES
    (
      "Predatory Animal Imagery",
      "Lion, den, and hunting metaphors for wicked behavior",
      ["leo", "spelunca", "insidiae", "insidior", "rapio", "laqueus"],
      ThemeCategory.sin,
      11 ... 14
    ),
    (
      "Body Parts Imagery",
      "Physical body parts representing spiritual and moral states",
      ["oculus", "os", "lingua", "cor", "manus", "brachium", "auris"],
      ThemeCategory.virtue,
      1 ... 23
    ),
    (
      "Weapon and Military Imagery",
      "Military metaphors for divine judgment and human power",
      ["laqueus", "brachium", "manus", "contero", "exalto"],
      ThemeCategory.conflict,
      14 ... 20
    ),
    (
      "Geographical and Spatial Imagery",
      "Earth, land, and spatial references for divine scope",
      ["terra", "gens", "generatio", "aeternus", "saeculum"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Light and Vision Imagery",
      "Sight, face, and visibility metaphors for divine attention",
      ["conspectus", "facies", "video", "averto", "oculus"],
      ThemeCategory.divine,
      1 ... 18
    ),
    (
      "Container and Fullness Imagery",
      "Mouth, heart, and fullness metaphors for internal states",
      ["os", "plenus", "cor", "amaritudo", "dolor", "labor"],
      ThemeCategory.sin,
      9 ... 10
    ),
    (
      "Oppression and Class Imagery",
      "Rich vs poor, powerful vs vulnerable imagery",
      ["dives", "pauper", "pupillus", "humilis", "orphanus"],
      ThemeCategory.opposition,
      11 ... 23
    ),
    (
      "Divine Power Imagery",
      "God's strength, reign, and eternal authority",
      ["dominus", "regno", "aeternus", "exalto", "manus"],
      ThemeCategory.divine,
      16 ... 23
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    let expectedVerseCount = 23
    XCTAssertEqual(psalm9B.count, expectedVerseCount, "Psalm 9B should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 9B English text should have \(expectedVerseCount) verses")
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm9B.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm9B,
      "Normalized Latin text should match expected classical forms"
    )
  }

  // MARK: - Grouped Line Tests for Psalm 9B

  func testDivineIntervention() {
    let interventionTerms = [
      ("exsurgo", ["exsurge", "exsurge"], "arise"), // v.1, v.16
      ("iudico", ["iudicentur"], "judge"), // v.1
      ("constituo", ["constitue"], "appoint"), // v.2
      ("contero", ["contere"], "crush"), // v.20
    ]

    utilities.testTerms(
      psalmText: psalm9B,
      psalmId: id,
      terms: interventionTerms,
      verbose: verbose
    )
  }

  func testWickedCharacteristics() {
    let wickedTerms = [
      ("impius", ["impius", "impius"], "wicked"), // v.4, v.17
      ("peccator", ["peccator", "peccatoris"], "sinner"), // v.5, v.20
      ("iniquus", ["iniquus"], "unjust"), // v.5
      ("dolus", ["dolo"], "deceit"), // v.10
      ("insidia", ["insidiis"], "ambush"), // v.11, v.12, v.13
      ("insidior", ["insidiatur", "insidiatur"], "ambush"), // v.12, v.13
    ]

    utilities.testTerms(
      psalmText: psalm9B,
      psalmId: id,
      terms: wickedTerms,
      verbose: verbose
    )
  }

  func testPoorAndOppressed() {
    let poorTerms = [
      ("pauper", ["pauper", "pauperem", "pauperum", "pauperum"], "poor"), // v.4, v.12, v.14, v.16
      ("innocens", ["innocentem"], "innocent"), // v.11
      ("pupillus", ["pupillo"], "orphan"), // v.23
      ("humilis", ["humili"], "humble"), // v.23
    ]

    utilities.testTerms(
      psalmText: psalm9B,
      psalmId: id,
      terms: poorTerms,
      verbose: verbose
    )
  }

  func testDivineAttributes() {
    let attributeTerms = [
      ("legislator", ["legislatorem"], "lawgiver"), // v.2
      ("regno", ["regnabit"], "reign"), // v.21
      ("iudico", ["iudicare"], "judge"), // v.23
      ("obliviscor", ["obliviscaris"], "forget"), // v.16 (negative)
    ]

    utilities.testTerms(
      psalmText: psalm9B,
      psalmId: id,
      terms: attributeTerms,
      verbose: verbose
    )
  }

  func testEschatologicalHope() {
    let hopeTerms = [
      ("aeternus", ["aeternum"], "forever"), // v.21
      ("saeculum", ["saeculum"], "age"), // v.21
      ("pereo", ["peribitis"], "perish"), // v.21
      ("exaudio", ["exaudivit"], "hear"), // v.22
    ]

    utilities.testTerms(
      psalmText: psalm9B,
      psalmId: id,
      terms: hopeTerms,
      verbose: verbose
    )
  }

  // MARK: - Line Key Lemmas Tests

  func testLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm9B,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Structural Themes Tests

  func testStructuralThemes() {
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
      psalmText: psalm9B,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    // First, verify that conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false // Conceptual themes may have additional imagery lemmas
    )

    // Then run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: psalm9B,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Save JSON Functions

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm9B,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm9b_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testSaveThemes() {
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm9b_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
