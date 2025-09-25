@testable import LatinService
import XCTest

class Psalm30Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 30, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 31
  private let text = [
    "In te, Domine, speravi, non confundar in aeternum: in iustitia tua libera me.",
    "Inclina ad me aurem tuam, accelera ut eripias me.",
    "Esto mihi in Deum protectorem, et in domum refugii, ut salvum me facias.",
    "Quoniam fortitudo mea et refugium meum es tu: et propter nomen tuum deduces me, et enutries me.",
    "Educes me de laqueo hoc quem absconderunt mihi: quoniam tu es protector meus.", // 5
    /* 6 */ "In manus tuas commendo spiritum meum: redemisti me, Domine, Deus veritatis.",
    "Odivi observantes vanitates supervacue: ",
    "Ego autem in Domino speravi. Exsultabo et laetabor in misericordia tua.",
    "Quoniam respexisti humilitatem meam, salvasti de necessitatibus animam meam.",
    "Nec conclusisti me in manibus inimici: statuisti in loco spatioso pedes meos.", // 10
    /* 11 */ "Miserere mei, Domine, quoniam tribulor: conturbatus est in ira oculus meus, anima mea et venter meus.",
    "Quoniam defecit in dolore vita mea: et anni mei in gemitibus.",
    "Infirmata est in paupertate virtus mea: et ossa mea conturbata sunt.",
    "Super omnes inimicos meos factus sum opprobrium, et vicinis meis valde, et timor notis meis.",
    "Qui videbant me foras fugerunt a me: oblivioni datus sum, tamquam mortuus a corde.",
    /* 16 */ "Factus sum tamquam vas perditum: quoniam audivi vituperationem multorum commorantium in circuitu.",
    "In eo dum convenirent simul adversum me, accipere animam meam consiliati sunt.",
    "Ego autem in te speravi, Domine: dixi: Deus meus es tu. In manibus tuas sortes meae: ",
    "Eripe me de manu inimicorum meorum, et a persequentibus me.",
    /* 20 */ "Illustra faciem tuam super servum tuum: salvum me fac in misericordia tua. Domine, non confundar, quoniam invocavi te: ",
    /* 21 */ "Erubescant impii, et deducantur in infernum. Muta fiant labia dolosa, ",
    "Quae loquuntur adversus iustum iniquitatem, in superbia et in abusione.", // 22
    "Quam magna multitudo dulcedinis tuae, Domine, quam abscondisti timentibus te!",
    "Perfecisti eis qui sperant in te, in conspectu filiorum hominum.", // 24
    "Abscondes eos in abscondito faciei tuae a conturbatione hominum: ", // 25
    /* 26 */ "Proteges eos in tabernaculo tuo a contradictione linguarum.",
    /* 27 */ "Benedictus Dominus: quoniam mirificavit misericordiam suam mihi in civitate munita.",
    /* 28 */ "Ego autem dixi in excessu mentis meae: Proiectus sum a facie oculorum tuorum: ",
    /* 29 */ "Ideo exaudisti vocem orationis meae, dum clamarem ad te.",
    /* 30 */ "Diligite Dominum omnes sancti eius: quoniam veritatem requiret Dominus, et retribuet abundanter facientibus superbiam.",
    "Viriliter agite, et confortetur cor vestrum, omnes qui speratis in Domino.", // 31
  ]

  private let englishText = [
    "In thee, O Lord, have I hoped, let me never be confounded; deliver me in thy justice.",
    "Bow down thy ear to me; make haste to deliver me.",
    "Be thou unto me a God, a protector, and a house of refuge, to save me.",
    "For thou art my strength and my refuge; and for thy name's sake thou wilt lead me, and nourish me.",
    "Thou wilt bring me out of this snare, which they have hidden for me; for thou art my protector.",
    "Into thy hands I commend my spirit; thou hast redeemed me, O Lord, the God of truth.",
    "I have hated them that regard vain things; and I have hoped in the Lord.",
    "I will be glad and rejoice in thy mercy; for thou hast regarded my humility, thou hast saved my soul out of distresses.",
    "And thou hast not shut me up in the hands of the enemy; thou hast set my feet in a spacious place.",
    "Have mercy on me, O Lord, for I am afflicted; my eye is troubled with wrath, my soul, and my belly.",
    "For my life is wasted with grief; and my years in sighs.",
    "My strength is weakened through poverty; and my bones are disturbed.",
    "I am become a reproach among all my enemies, and very much to my neighbours; and a fear to my acquaintance.",
    "They that saw me without fled from me; I am forgotten as one dead from the heart.",
    "I am become as a vessel that is destroyed; for I have heard the blame of many that dwell round about.",
    "While they assembled together against me, they consulted to take away my life.",
    "But I have put my trust in thee, O Lord; I said: Thou art my God.",
    "My lots are in thy hands; deliver me out of the hands of my enemies, and from them that persecute me.",
    "Make thy face to shine upon thy servant; save me in thy mercy.",
    "Let me not be confounded, O Lord, for I have called upon thee; let the wicked be ashamed, and be brought down to hell.",
    "Let deceitful lips be made dumb, which speak iniquity against the just, with pride and abuse.",
    "O how great is the multitude of thy sweetness, O Lord, which thou hast hidden for them that fear thee!",
    "Which thou hast wrought for them that hope in thee, in the sight of the sons of men.",
    "Thou shalt hide them in the secret of thy face, from the disturbance of men; thou shalt protect them in thy tabernacle from the contradiction of tongues.",
    "Blessed be the Lord; for he hath shewn his wonderful mercy to me in a fortified city.",
    "But I said in the excess of my mind: I am cast away from before thy eyes; therefore thou hast heard the voice of my prayer, when I cried to thee.",
    "O love the Lord, all ye his saints; for the Lord will require truth, and will repay them abundantly that act proudly.",
    "Do ye manfully, and let your heart be strengthened, all ye that hope in the Lord.",
    "Be strong and take courage, all you who hope in the Lord.",
    "Let all who trust in the Lord be strengthened and take heart.",
    "Be courageous and let your hearts be strong, all you who hope in the Lord.",
  ]

  private let lineKeyLemmas = [
    (1, ["spero", "dominus", "confundor", "aeternum", "iustitia", "libero"]),
    (2, ["inclino", "auris", "accelero", "eripio"]),
    (3, ["deus", "protector", "domus", "refugium", "salvus", "facio"]),
    (4, ["fortitudo", "refugium", "nomen", "deduco", "enutrio"]),
    (5, ["educo", "laqueus", "abscondo", "protector"]),
    (6, ["manus", "commendo", "spiritus", "redimo", "dominus", "deus", "veritas"]),
    (7, ["odi", "observo", "vanitas", "supervacue"]),
    (8, ["dominus", "spero", "exsulto", "laetor", "misericordia"]),
    (9, ["respicio", "humilitas", "salvo", "necessitas", "anima"]),
    (10, ["concludo", "manus", "inimicus", "statuo", "locus", "spatiosus", "pes"]),
    (11, ["misereor", "dominus", "tribulor", "conturbo", "ira", "oculus", "anima", "venter"]),
    (12, ["deficio", "dolor", "vita", "annus", "gemitus"]),
    (13, ["infirmo", "paupertas", "virtus", "os", "conturbo"]),
    (14, ["inimicus", "opprobrium", "vicinus", "timor", "notus"]),
    (15, ["video", "foras", "fugio", "oblivio", "mortuus", "cor"]),
    (16, ["vas", "perditus", "audio", "vituperatio", "multus", "commoror", "circuitus"]),
    (17, ["convenio", "adversus", "accipio", "anima", "consilior"]),
    (18, ["spero", "dominus", "dico", "deus", "manus", "sors"]),
    (19, ["manus", "eripio", "inimicus", "persequor"]),
    (20, ["illustro", "facies", "servus", "salvus", "misericordia", "confundor", "invoco"]),
    (21, ["erubesco", "impius", "deduco", "infernus", "mutus", "labium", "dolosus"]),
    (22, ["loquor", "adversus", "iustus", "iniquitas", "superbia", "abusio"]),
    (23, ["magnus", "multitudo", "dulcedo", "dominus", "abscondo", "timeo"]),
    (24, ["perficio", "spero", "conspectus", "filius", "homo"]),
    (25, ["abscondo", "absconditum", "facies", "conturbatio", "homo"]),
    (26, ["protego", "tabernaculum", "contradictio", "lingua"]),
    (27, ["benedico", "dominus", "mirifico", "misericordia", "civitas", "munio"]),
    (28, ["dico", "excessus", "mens", "proicio", "facies", "oculus"]),
    (29, ["exaudio", "vox", "oratio", "dum", "clamo"]),
    (30, ["diligo", "dominus", "omnis", "sanctus", "veritas", "requiro", "retribuo", "superbia"]),
    (31, ["virilis", "ago", "conforto", "cor", "omnis", "spero", "dominus"]),
  ]

  private let structuralThemes = [
    (
      "Initial Trust → Urgent Plea",
      "The psalmist's foundational trust in God leading to an urgent cry for deliverance",
      ["spero", "confundor", "iustitia", "libero", "inclino", "accelero", "eripio"],
      1,
      2,
      "The psalm begins with declaration of trust in God and plea not to be confounded, immediately followed by urgent requests for God to incline His ear and hasten to deliver.",
      "Augustine sees this as the soul's proper starting point: placing hope in divine justice rather than self-righteousness, while recognizing the urgency of spiritual deliverance."
    ),
    (
      "Divine Protection → Redemptive Trust",
      "Appealing to God as protector and refuge, trusting in His strength and guidance",
      ["deus", "protector", "refugium", "salvus", "facio", "fortitudo", "nomen", "deduco", "enutrio"],
      3,
      4,
      "The psalmist asks God to be his protector and refuge, trusting in divine guidance and nourishment, recognizing God as his strength.",
      "For Augustine, this progression shows the soul moving from seeking external protection to complete spiritual surrender, recognizing God as the ultimate redeemer."
    ),
    (
      "Deliverance from Snare → Spirit Committed",
      "From divine rescue from hidden traps to entrusting one's spirit to God",
      ["educo", "laqueus", "abscondo", "protector", "manus", "commendo", "spiritus", "redimo", "veritas"],
      5,
      6,
      "The psalmist trusts God to bring him out of the hidden snare and commits his spirit into God's hands, recognizing Him as the God of truth who has redeemed him.",
      "Augustine sees this as the movement from external deliverance to internal surrender, showing complete trust in God's redemptive power and truth."
    ),
    (
      "Rejection of Vanity → Joy in Mercy",
      "Hating vain idols and choosing hope in God, resulting in joy and deliverance",
      ["odi", "vanitas", "supervacue", "spero", "exsulto", "laetor", "misericordia"],
      7,
      8,
      "The psalmist rejects those who follow vain things and places hope in the Lord, leading to exultation and joy in God's mercy that has regarded his humility.",
      "Augustine interprets this as the necessary rejection of worldly attachments before experiencing the full joy of divine mercy and salvation."
    ),
    (
      "Divine Regard → Spacious Deliverance",
      "From God's attention to humility to being set in a spacious place",
      ["respicio", "humilitas", "salvo", "necessitas", "anima", "concludo", "inimicus", "statuo", "spatiosus", "pes"],
      9,
      10,
      "The psalmist recalls how God regarded his humility and saved his soul from distress, not shutting him up in the enemy's hands but setting his feet in a spacious place.",
      "Augustine sees this as the contrast between constriction by enemies and the freedom God provides when the soul humbles itself before Him."
    ),
    (
      "Present Affliction → Life in Grief",
      "Current suffering and the wasting away of life in sorrow",
      ["misereor", "tribulor", "conturbo", "ira", "oculus", "anima", "venter", "deficio", "dolor", "vita", "annus", "gemitus"],
      11,
      12,
      "The psalmist describes his current affliction with troubled eyes, soul, and belly, and how his life is wasted with grief and his years in sighs.",
      "For Augustine, this represents the honest acknowledgment of present suffering, which is necessary before experiencing divine comfort and restoration."
    ),
    (
      "Physical Weakness → Social Reproach",
      "From bodily infirmity to becoming a reproach among enemies and neighbors",
      ["infirmo", "paupertas", "virtus", "os", "conturbo", "inimicus", "opprobrium", "vicinus", "timor", "notus"],
      13,
      14,
      "The psalmist's strength is weakened through poverty and his bones disturbed, while he has become a reproach among all his enemies and a fear to his acquaintances.",
      "Augustine sees this as the complete picture of human vulnerability - both physical weakness and social isolation that can drive the soul to complete dependence on God."
    ),
    (
      "Forgotten Like Dead → Broken Vessel",
      "From feeling forgotten as the dead to being like a destroyed vessel",
      ["video", "foras", "fugio", "oblivio", "mortuus", "cor", "vas", "perditus", "audio", "vituperatio", "multus", "commoror", "circuitus"],
      15,
      16,
      "Those who saw him fled from him, and he feels forgotten like one dead from the heart, like a broken vessel, hearing the blame of many dwelling round about.",
      "Augustine interprets this as the depths of human abandonment and brokenness that can only be healed by divine intervention and restoration."
    ),
    (
      "Enemy Conspiracy → Trust in God",
      "From enemies conspiring to take life to reaffirming trust in God",
      ["convenio", "adversus", "accipio", "anima", "consilior", "spero", "dominus", "dico", "deus", "manus", "sors"],
      17,
      18,
      "While enemies assembled together against him and consulted to take away his life, the psalmist reaffirms his trust in God and places his lot in God's hands.",
      "For Augustine, this shows the soul's ability to maintain faith even when facing the most dire threats, trusting in God's ultimate protection and guidance."
    ),
    (
      "Prayer for Deliverance → Divine Illumination",
      "From asking for rescue from enemies to seeking God's face to shine",
      ["manus", "eripio", "inimicus", "persequor", "illustro", "facies", "servus", "salvus", "misericordia", "confundor", "invoco"],
      19,
      20,
      "The psalmist asks to be delivered from the hands of enemies and persecutors, and for God's face to shine upon His servant for salvation in mercy.",
      "Augustine sees this as the proper progression from seeking external deliverance to desiring the inner illumination of God's countenance."
    ),
    (
      "Shame for Wicked → Silence Deceitful Lips",
      "From praying for wicked to be ashamed to asking for deceitful lips to be made dumb",
      ["erubesco", "impius", "deduco", "infernus", "mutus", "labium", "dolosus", "loquor", "adversus", "iustus", "iniquitas", "superbia", "abusio"],
      21,
      22,
      "The psalmist prays for the wicked to be ashamed and brought down to hell, and for deceitful lips that speak iniquity against the just to be made dumb.",
      "Augustine interprets this as the prayer for divine justice against those who speak evil against the righteous, trusting in God's vindication."
    ),
    (
      "Divine Sweetness → Perfection for Hopers",
      "From marveling at God's hidden sweetness to His perfecting work for those who hope",
      ["magnus", "multitudo", "dulcedo", "dominus", "abscondo", "timeo", "perficio", "spero", "conspectus", "filius", "homo"],
      23,
      24,
      "The psalmist marvels at the greatness of God's sweetness hidden for those who fear Him, and how He perfects it for those who hope in Him in the sight of men.",
      "For Augustine, this reveals God's hidden goodness reserved for the faithful and His public vindication of those who trust in Him."
    ),
    (
      "Hidden Protection → Tabernacle Shelter",
      "From God hiding His people from disturbance to protecting them in His tabernacle",
      ["abscondo", "absconditum", "facies", "conturbatio", "homo", "protego", "tabernaculum", "contradictio", "lingua"],
      25,
      26,
      "God hides His people in the secret of His face from the disturbance of men, and protects them in His tabernacle from the contradiction of tongues.",
      "Augustine sees this as the double protection God provides - both from external disturbance and from the contradiction of false tongues."
    ),
    (
      "Blessed Mercy → Cast Away in Mind",
      "From blessing God's wonderful mercy to feeling cast away from God's sight",
      ["benedico", "dominus", "mirifico", "misericordia", "civitas", "munio", "dico", "excessus", "mens", "proicio", "facies", "oculus"],
      27,
      28,
      "The psalmist blesses the Lord for showing wonderful mercy in a fortified city, but then says he was cast away from God's sight in the excess of his mind.",
      "Augustine interprets this as the oscillation between gratitude for past mercies and the present feeling of abandonment, showing the human struggle with faith."
    ),
    (
      "Prayer Heard → Love and Truth",
      "From God hearing prayer to exhortation to love the Lord and seek truth",
      ["exaudio", "vox", "oratio", "dum", "clamo", "diligo", "dominus", "omnis", "sanctus", "veritas", "requiro", "retribuo", "superbia"],
      29,
      30,
      "God heard the voice of prayer when the psalmist cried to Him, and now he exhorts all saints to love the Lord who requires truth and repays those who act proudly.",
      "Augustine sees this as the transition from personal petition to communal exhortation, sharing the discovered truth about God's character with all believers."
    ),
    (
      "Final Exhortation",
      "The concluding call to be strong and take courage in the Lord",
      ["virilis", "ago", "conforto", "cor", "omnis", "spero", "dominus"],
      31,
      31,
      "The psalm concludes with an exhortation to act manfully and let hearts be strengthened, all who hope in the Lord.",
      "Augustine interprets this final verse as the ultimate encouragement to persevere in faith and courage, recognizing that strength comes from hope in the Lord."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Protection Imagery",
      "Metaphors of God as protector, refuge, and stronghold",
      ["protector", "refugium", "fortitudo", "domus", "civitas", "munio", "tabernaculum"],
      ThemeCategory.divine,
      3 ... 25
    ),
    (
      "Human Suffering Experience",
      "Descriptions of physical, emotional, and social suffering",
      ["tribulor", "dolor", "gemitus", "paupertas", "opprobrium", "timor", "oblivio", "vituperatio"],
      ThemeCategory.sin,
      10 ... 16
    ),
    (
      "Trust and Hope Verbs",
      "Actions expressing reliance on God",
      ["spero", "commendo", "confido", "invoco", "clamo", "exspecto"],
      ThemeCategory.virtue,
      1 ... 31
    ),
    (
      "Body and Soul References",
      "Mentions of physical and spiritual dimensions of human experience",
      ["spiritus", "anima", "oculus", "venter", "vita", "os", "cor", "pes", "labium"],
      ThemeCategory.sin,
      6 ... 21
    ),
    (
      "Enemy and Persecution Language",
      "Descriptions of adversaries and their actions",
      ["inimicus", "persequor", "adversum", "consilior", "dolosus", "impius", "superbia"],
      ThemeCategory.sin,
      5 ... 21
    ),
    (
      "Divine Justice and Mercy",
      "God's righteous judgment and compassionate deliverance",
      ["iustitia", "misericordia", "veritas", "redimo", "eripio", "salvo", "retribuo"],
      ThemeCategory.divine,
      1 ... 31
    ),
    (
      "Communal Exhortation",
      "Calls to collective worship and strengthened faith",
      ["diligo", "sanctus", "viriliter", "conforto", "spero", "benedictus"],
      ThemeCategory.worship,
      27 ... 31
    ),
    (
      "Spatial Metaphors",
      "References to places, positions, and movements",
      ["locus", "spatiosus", "foras", "circuitus", "facies", "absconditus", "infernum"],
      ThemeCategory.virtue,
      9 ... 31
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 30 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 30 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm30_texts.json"
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
      filename: "output_psalm30_themes.json"
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
