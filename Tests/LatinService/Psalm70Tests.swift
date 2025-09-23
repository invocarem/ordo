@testable import LatinService
import XCTest

class Psalm70Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 70, category: "")

  // MARK: - Test Data Properties

  private let psalm70 = [
    "In te, Domine, speravi, non confundar in aeternum; in iustitia tua libera me.",
    "Inclina ad me aurem tuam, accelera ut eripias me.",
    "Esto mihi in Deum protectorem, et in domum refugii, ut salvum me facias.",
    "Quoniam fortitudo mea et refugium meum es tu; et propter nomen tuum deduces me, et enutries me.",
    "Deus meus, eripe me de manu peccatoris, et de manu contra legem agentis et iniqui:",

    "Quoniam tu es patientia mea, Domine; Domine, spes mea a iuventute mea.",
    "In te confirmatus sum ex utero; de ventre matris meae tu es protector meus.",
    "In te cantatio mea semper; tamquam prodigium factus sum multis, et tu adiutor fortis.",
    "Repleatur os meum laude, ut cantem gloriam tuam; tota die magnitudinem tuam.",
    "Ne proiicias me in tempore senectutis; cum defecerit virtus mea, ne derelinquas me.",

    "Quia dixerunt inimici mei mihi; et qui custodiebant animam meam, consilium fecerunt in unum.",
    "Dicentes: Deus dereliquit eum; persequimini, et comprehendite eum, quia non est qui eripiat.",
    "Deus, ne elongeris a me; Deus meus, in auxilium meum respice.",
    "Confundantur, et deficiant detrahentes animae meae; operiantur confusione et pudore, qui quaerunt mala mihi.",
    "Ego autem semper sperabo; et adiciam super omnem laudem tuam.",
    
    "Os meum annuntiabit iustitiam tuam; tota die salutare tuum.",
    "Quoniam non cognovi litteraturam; introibo in potentias Domini.",
    "Domine, memorabor iustitiae tuae solius; Deus, docuisti me a iuventute mea.",
    "Et usque in senectam et senium; Deus, ne derelinquas me.",
    "Donec annuntiem brachium tuum; generationi omni quae ventura est.",
    
    "Potentiam tuam, et iustitiam tuam, Deus, usque in altissima; quae fecisti magnalia, Deus, quis similis tibi?",
    "Quantas ostendisti mihi tribulationes multas et malas; et conversus vivificasti me, et de abyssis terrae iterum reduxisti me.",
    "Multiplicasti magnificentiam tuam; et conversus consolatus es me.",
    "Nam et ego confitebor tibi in vasis psalmi veritatem tuam; Deus, psallam tibi in cithara, Sanctus Israel.",
    "Exsultabunt labia mea cum cantavero tibi; et anima mea quam redemisti.",
    
    "Sed et lingua mea tota die meditabitur iustitiam tuam; cum confusi et reveriti fuerint, qui quaerunt mala mihi.",
  ]

  private let englishText = [
    "In thee, O Lord, I have hoped, let me never be confounded; in thy justice deliver me.",
    "Incline thy ear unto me, and hasten to deliver me.",
    "Be thou unto me a God, a protector, and a house of refuge, to save me.",
    "For thou art my strength and my refuge; and for thy name's sake thou wilt lead me, and nourish me.",
    "O my God, deliver me from the hand of the sinner, and from the hand of the transgressor and of the unjust:",
    "For thou art my patience, O Lord; O Lord, my hope from my youth.",
    "In thee I have been confirmed from the womb; from my mother's womb thou art my protector.",
    "In thee is my singing always; as a prodigy I have been made to many, and thou art my strong helper.",
    "Let my mouth be filled with praise, that I may sing thy glory; all the day long thy magnificence.",
    "Cast me not off in the time of old age; when my strength shall fail, do not thou forsake me.",
    "For my enemies have spoken against me; and they that watched my soul have consulted together.",
    "Saying: God hath forsaken him; pursue and take him, for there is none to deliver him.",
    "O God, be not thou far from me; O my God, make haste to help me.",
    "Let them be confounded and come to nothing that detract my soul; let them be covered with confusion and shame, that seek my hurt.",
    "But I will always hope; and will add to all thy praise.",
    "My mouth shall shew forth thy justice; all the day long thy salvation.",
    "For I have not known learning; I will go in to the powers of the Lord.",
    "O Lord, I will be mindful of thy justice alone; O God, thou hast taught me from my youth.",
    "And unto old age and grey hairs; O God, forsake me not.",
    "Until I shew forth thy arm to all the generation that is to come.",
    "Thy power, and thy justice, O God, even to the highest great things thou hast done; O God, who is like to thee?",
    "How great troubles hast thou shewn me, many and grievous; and turning thou hast brought me to life, and hast brought me back again from the depths of the earth.",
    "Thou hast multiplied thy magnificence; and turning to me thou hast comforted me.",
    "For I will also confess to thee thy truth with the instruments of psaltery; O God, I will sing to thee with the harp, O Holy One of Israel.",
    "My lips shall greatly rejoice, when I shall sing to thee; and my soul which thou hast redeemed.",
    "Yea and my tongue shall meditate thy justice all the day; when they shall be confounded and put to shame, that seek evils to me.",
  ]

  private let lineKeyLemmas = [
    (1, ["spero", "dominus", "confundo", "aeternus", "iustitia", "libero"]),
    (2, ["inclino", "auris", "accelero", "eripio"]),
    (3, ["deus", "protector", "domus", "refugium", "salvus"]),
    (4, ["fortitudo", "refugium", "nomen", "deduco", "enutrio"]),
    (5, ["deus", "eripio", "manus", "peccator", "contra", "lex", "ago", "iniquus"]),
    (6, ["patientia", "dominus", "spes", "iuventus"]),
    (7, ["confirmo", "uterus", "venter", "mater", "protector"]),
    (8, ["cantatio", "semper", "prodigium", "multus", "adiutor", "fortis"]),
    (9, ["repleo", "os", "laus", "canto", "gloria", "totus", "dies", "magnitudo"]),
    (10, ["proicio", "tempus", "senectus", "deficio", "virtus", "derelinquo"]),
    (11, ["inimicus", "custodio", "anima", "consilium", "unus"]),
    (12, ["dico", "deus", "derelinquo", "persequor", "comprehendo", "eripio"]),
    (13, ["deus", "elongo", "deus", "auxilium", "respicio"]),
    (14, ["confundo", "deficio", "detraho", "anima", "operio", "confusio", "pudor", "quaero", "malus"]),
    (15, ["spero", "semper", "addo", "laus"]),
    (16, ["os", "annuntio", "iustitia", "totus", "dies", "salutare"]),
    (17, ["cognosco", "litteratura", "introeo", "potentia", "dominus"]),
    (18, ["dominus", "memor", "iustitia", "solus", "deus", "doceo", "iuventus"]),
    (19, ["senectus", "senium", "deus", "derelinquo"]),
    (20, ["annuntio", "brachium", "generatio", "omnis", "venio"]),
    (21, ["potentia", "iustitia", "deus", "altus", "magnus", "deus", "similis"]),
    (22, ["magnus", "ostendo", "tribulatio", "multus", "malus", "converto", "vivifico", "abyssus", "terra", "reduco"]),
    (23, ["multiplico", "magnificentia", "converto", "consolor"]),
    (24, ["confiteor", "vas", "psalmus", "veritas", "deus", "psallo", "cithara", "sanctus", "israel"]),
    (25, ["exsulto", "labium", "canto", "anima", "redimo"]),
    (26, ["lingua", "meditor", "iustitia", "totus", "dies", "confundo", "revereor", "quaero", "malus"]),
  ]

  private let structuralThemes = [
    (
      "Hope and Trust → Divine Deliverance",
      "The psalmist's hope in God leading to deliverance and protection",
      ["spero", "dominus", "confundo", "iustitia", "libero", "eripio", "protector"],
      1,
      5,
      "The psalmist expresses his hope in God, asking not to be confounded, and seeks deliverance through God's justice and protection from sinners.",
      "Augustine sees this as the soul's fundamental trust in divine providence, where hope in God becomes the foundation for all deliverance and protection."
    ),
    (
      "Divine Patience and Youth → Life-Long Protection",
      "God's patience and hope from youth leading to life-long divine protection",
      ["patientia", "spes", "iuventus", "confirmo", "uterus", "mater", "protector"],
      6,
      8,
      "The psalmist declares God as his patience and hope from youth, confirmed from the womb, and protected by God as his strong helper.",
      "For Augustine, this represents the soul's recognition of God's constant presence from the beginning of life, providing patience and protection throughout the journey."
    ),
    (
      "Praise and Glory → Old Age Concerns",
      "The psalmist's commitment to praise leading to concerns about old age",
      ["canto", "laus", "gloria", "magnitudo", "proicio", "senectus", "virtus", "derelinquo"],
      8,
      10,
      "The psalmist sings God's glory and magnificence, but then expresses concern about being cast off in old age when his strength fails.",
      "Augustine sees this as the soul's tension between divine praise and human frailty, where the commitment to worship must be sustained even in weakness."
    ),
    (
      "Enemy Conspiracy → Divine Help",
      "Enemies conspiring against the psalmist contrasted with divine help",
      ["inimicus", "custodio", "consilium", "derelinquo", "deus", "auxilium", "respicio"],
      11,
      13,
      "Enemies conspire against the psalmist, saying God has forsaken him, but the psalmist calls on God not to be far from him and to make haste to help.",
      "For Augustine, this represents the soul's confidence in divine help even when enemies claim God has abandoned the faithful."
    ),
    (
      "Enemy Confusion → Continuous Hope",
      "The confusion of enemies contrasted with the psalmist's continuous hope",
      ["confundo", "deficio", "detraho", "spero", "semper", "addo", "laus"],
      14,
      15,
      "The psalmist prays for enemies to be confounded and come to nothing, while he will always hope and add to all God's praise.",
      "Augustine sees this as the contrast between the temporary confusion of the wicked and the eternal hope of the righteous."
    ),
    (
      "Justice and Salvation → Learning and Teaching",
      "The psalmist's proclamation of justice leading to learning and divine teaching",
      ["annuntio", "iustitia", "salutare", "cognosco", "litteratura", "potentia", "doceo"],
      16,
      18,
      "The psalmist proclaims God's justice and salvation, then speaks of not knowing learning but going to the powers of the Lord, and being taught by God from youth.",
      "For Augustine, this represents the soul's journey from human learning to divine wisdom, where God becomes the ultimate teacher."
    ),
    (
      "Life-Long Faithfulness → Divine Power",
      "The psalmist's life-long faithfulness leading to recognition of divine power",
      ["senectus", "senium", "derelinquo", "annuntio", "brachium", "potentia", "magnus"],
      19,
      21,
      "The psalmist asks not to be forsaken in old age, promises to show forth God's arm to future generations, and marvels at God's power and incomparable greatness.",
      "For Augustine, this represents the soul's commitment to proclaiming God's power across generations, recognizing His incomparable majesty."
    ),
    (
      "Tribulation and Comfort → Praise and Confession",
      "God's response to tribulation with comfort leading to praise and confession",
      ["tribulatio", "malus", "converto", "vivifico", "consolor", "confiteor", "psallo"],
      22,
      24,
      "The psalmist describes great troubles and God's response with comfort and restoration, leading to confession of truth with instruments of psaltery.",
      "For Augustine, this represents the soul's journey from tribulation to divine comfort, culminating in joyful confession and praise."
    ),
    (
      "Joyful Praise → Meditative Justice",
      "The psalmist's joyful praise leading to meditative justice",
      ["exsulto", "labium", "canto", "anima", "redimo", "lingua", "meditor", "iustitia"],
      25,
      26,
      "The psalmist's lips rejoice in singing, his soul is redeemed, and his tongue meditates on God's justice all day long.",
      "For Augustine, this represents the soul's final state of joyful praise and continuous meditation on divine justice, the culmination of a life of faith."
    ),
  ]

  private let conceptualThemes = [
    (
      "Life Journey from Youth to Old Age",
      "The psalmist's journey from youth through old age with divine guidance",
      ["iuventus", "senectus", "senium", "virtus", "deficio", "derelinquo"],
      ThemeCategory.virtue,
      6 ... 20
    ),
    (
      "Divine Patience and Teaching",
      "God's patience and teaching throughout the psalmist's life",
      ["patientia", "doceo", "memor", "solus", "confirmo"],
      ThemeCategory.divine,
      6 ... 18
    ),
    (
      "Enemy Opposition and Conspiracy",
      "The opposition and persecution from enemies throughout life",
      ["inimicus", "custodio", "consilium", "derelinquo", "persequor", "comprehendo"],
      ThemeCategory.opposition,
      11 ... 14
    ),
    (
      "Divine Protection and Refuge",
      "God as protector, refuge, and source of strength from birth",
      ["protector", "refugium", "fortitudo", "uterus", "mater", "adiutor"],
      ThemeCategory.divine,
      3 ... 8
    ),
    (
      "Praise and Singing",
      "The psalmist's commitment to praise and sing God's glory",
      ["canto", "laus", "gloria", "magnitudo", "psallo", "cithara", "exsulto"],
      ThemeCategory.worship,
      8 ... 25
    ),
    (
      "Divine Power and Magnificence",
      "God's power, magnificence, and incomparable greatness",
      ["potentia", "magnus", "magnificentia", "similis", "altus", "brachium"],
      ThemeCategory.divine,
      17 ... 23
    ),
    (
      "Tribulation and Divine Comfort",
      "God's response to tribulation with comfort and restoration",
      ["tribulatio", "malus", "converto", "vivifico", "abyssus", "reduco", "consolor"],
      ThemeCategory.divine,
      22 ... 23
    ),
    (
      "Musical Praise and Meditation",
      "The psalmist's musical praise with instruments and meditation on justice",
      ["confiteor", "vas", "psalmus", "veritas", "psallo", "cithara", "meditor", "iustitia", "tota", "dies"],
      ThemeCategory.worship,
      24 ... 26
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm70.count, 26, "Psalm 70 should have 26 verses"
    )
    XCTAssertEqual(
      englishText.count, 26,
      "Psalm 70 English text should have 26 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm70.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm70,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm70,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm70_texts.json"
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
      filename: "output_psalm70_themes.json"
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
      psalmText: psalm70,
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
      psalmText: psalm70,
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
      psalmText: psalm70,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
