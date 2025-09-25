@testable import LatinService
import XCTest

class Psalm72Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 72, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 28
  private let text = [
    "Quam bonus Israel Deus, his qui recto sunt corde!",
    "Mei autem pene moti sunt pedes, pene effusi sunt gressus mei.",
    "Quia zelavi super iniquos, pacem peccatorum videns.",
    "Quia non est respectus morti eorum, et firmamentum in plaga eorum.",
    "In labore hominum non sunt, et cum hominibus non flagellabuntur.",
    "Ideo tenuit eos superbia, operti sunt iniquitate et impietate sua.",
    "Prodiit quasi ex adipe iniquitas eorum, transierunt in affectum cordis.",
    "Cogitaverunt et locuti sunt nequitiam, iniquitatem in excelso locuti sunt.",
    "Posuerunt in caelum os suum, et lingua eorum transivit in terra.",
    "Ideo convertetur populus meus hic, et dies pleni invenientur in eis.",
    "Et dixerunt: Quomodo scit Deus, et si est scientia in Excelso?",
    "Ecce ipsi peccatores, et abundantes in saeculo, obtinuerunt divitias.",
    "Et dixi: Ergo sine causa iustificavi cor meum, et lavi inter innocentes manus meas.",
    "Et fui flagellatus tota die, et castigatio mea in matutinis.",
    "Si dicebam: Narrabo sic; ecce nationem filiorum tuorum reprobavi.",
    "Putabam ut cognoscerem hoc, labor est ante me.",
    "Donec intrem in sanctuarium Dei, et intelligam in novissimis eorum.",
    "Verumtamen propter dolos posuisti eis, dejecisti eos dum allevarentur.",
    "Quomodo facti sunt in desolationem? subito defecerunt, perierunt propter iniquitatem suam.",
    "Velut somnium surgentium, Domine, in civitate tua imaginem eorum ad nihilum rediges.",
    "Quia inflammatum est cor meum, et renes mei commutati sunt.",
    "Et ego ad nihilum redactus sum, et nescivi.",
    "Sicut iumentum factus sum apud te, et ego semper tecum.",
    "Tenuisti manum dexteram meam, et in voluntate tua deduxisti me, et cum gloria suscepisti me.",
    "Quid enim mihi est in caelo? et a te quid volui super terram?",
    "Defecit caro mea et cor meum; Deus cordis mei, et pars mea Deus in aeternum.",
    "Quia ecce qui elongant se a te peribunt; perdidisti omnes qui fornicantur abs te.",
    "Mihi autem adhaerere Deo bonum est, ponere in Domino Deo spem meam, ut annuntiem omnes praedicationes tuas in portis filiae Sion.",
  ]

  private let englishText = [
    "How good is God to Israel, to them that are of a right heart!",
    "But my feet were almost moved, my steps had well nigh slipped.",
    "Because I had a zeal on occasion of the wicked, seeing the prosperity of sinners.",
    "For there is no regard to their death, nor is there strength in their stripes.",
    "They are not in the labour of men, neither shall they be scourged like other men.",
    "Therefore pride hath held them fast, they are covered with their iniquity and their wickedness.",
    "Their iniquity hath come forth as it were from fatness, they have passed into the affection of the heart.",
    "They have thought and spoken wickedness, they have spoken iniquity on high.",
    "They have set their mouth against heaven, and their tongue hath passed through the earth.",
    "Therefore will my people return here, and full days shall be found in them.",
    "And they said: How doth God know? and is there knowledge in the most High?",
    "Behold these are sinners, and yet abounding in the world they have obtained riches.",
    "And I said: Then have I in vain justified my heart, and washed my hands among the innocent.",
    "And I have been scourged all the day, and my chastisement hath been in the mornings.",
    "If I said: I will speak thus; behold I should condemn the generation of thy children.",
    "I studied that I might know this thing, it is a labour in my sight.",
    "Until I go into the sanctuary of God, and understand concerning their last ends.",
    "But indeed for deceits thou hast put it to them, when they were lifted up thou hast cast them down.",
    "How are they brought to desolation? they have suddenly ceased to be, they have perished by reason of their iniquity.",
    "As the dream of them that awake, O Lord, so in thy city thou shalt bring their image to nothing.",
    "For my heart hath been inflamed, and my reins have been changed.",
    "And I am brought to nothing, and I knew not.",
    "I am become as a beast before thee, and I am always with thee.",
    "Thou hast held me by my right hand, and by thy will thou hast conducted me, and with thy glory thou hast received me.",
    "For what have I in heaven? and besides thee what do I desire upon earth?",
    "For thee my flesh and my heart hath fainted away; thou art the God of my heart, and the God that is my portion for ever.",
    "For behold they that go far from thee shall perish; thou hast destroyed all them that are disloyal to thee.",
    "But it is good for me to adhere to my God, to put my hope in the Lord God, that I may declare all thy praises in the gates of the daughter of Sion.",
  ]

  private let lineKeyLemmas = [
    (1, ["bonus", "israel", "deus", "rectus", "cor"]),
    (2, ["meus", "pene", "moveo", "pes", "effundo", "gressus"]),
    (3, ["zelor", "iniquus", "pax", "peccator", "video"]),
    (4, ["respectus", "mors", "firmamentum", "plaga"]),
    (5, ["labor", "homo", "flagello"]),
    (6, ["superbia", "operio", "iniquitas", "impietas"]),
    (7, ["prodeo", "adeps", "iniquitas", "transeo", "affectus", "cor"]),
    (8, ["cogito", "loquor", "nequitia", "iniquitas", "excelsus", "loquor"]),
    (9, ["pono", "caelum", "os", "lingua", "transeo", "terra"]),
    (10, ["converto", "populus", "dies", "plenus", "invenio"]),
    (11, ["dico", "quomodo", "scio", "deus", "scientia", "excelsus"]),
    (12, ["ecce", "peccator", "abundo", "saeculum", "obtineo", "divitiae"]),
    (13, ["dico", "sine", "causa", "iustifico", "cor", "lavo", "innocens", "manus"]),
    (14, ["flagello", "totus", "dies", "castigatio", "matutinus"]),
    (15, ["dico", "narro", "ecce", "natio", "filius", "reprobo"]),
    (16, ["puto", "cognosco", "labor", "ante", "meus"]),
    (17, ["donec", "intro", "sanctuarium", "deus", "intelligo", "novissimus"]),
    (18, ["verumtamen", "dolus", "pono", "deicio", "allevo"]),
    (19, ["quomodo", "fio", "desolatio", "subito", "deficio", "pereo", "iniquitas"]),
    (20, ["velut", "somnium", "surgo", "dominus", "civitas", "imago", "nihilum", "redigo"]),
    (21, ["inflammo", "cor", "ren", "commuto"]),
    (22, ["ego", "nihilum", "redigo", "nescio"]),
    (23, ["sicut", "iumentum", "fio", "apud", "semper", "tecum"]),
    (24, ["teneo", "manus", "dexter", "voluntas", "deduco", "gloria", "suscipio"]),
    (25, ["caelum", "volo", "terra"]),
    (26, ["deficio", "caro", "cor", "deus", "pars", "aeternus"]),
    (27, ["elongo", "pereo", "perdo", "fornicor", "abs"]),
    (28, ["adhaereo", "deus", "bonus", "pono", "dominus", "deus", "spes", "annuntio", "praedicatio", "porta", "filia", "sion"]),
  ]

  private let structuralThemes = [
    (
      "Divine Goodness → Human Doubt",
      "Recognition of God's goodness to the righteous contrasted with the psalmist's near fall",
      ["bonus", "israel", "deus", "rectus", "cor", "meus", "pene", "moveo", "pes", "effundo", "gressus"],
      1,
      2,
      "The psalmist declares how good God is to Israel and those with upright hearts, but confesses that his feet were almost moved and his steps nearly slipped.",
      "Augustine sees this as the soul's recognition of divine goodness combined with honest acknowledgment of human weakness and the near occasion of falling away from faith."
    ),
    (
      "Zeal for Justice → Wicked Prosperity",
      "The psalmist's zeal against the wicked contrasted with their apparent prosperity and peace",
      ["zelor", "iniquus", "pax", "peccator", "video", "respectus", "mors", "firmamentum", "plaga"],
      3,
      4,
      "The psalmist explains his zeal against the wicked, seeing the peace of sinners, and notes there is no regard for their death or strength in their stripes.",
      "For Augustine, this represents the soul's struggle with divine justice when the wicked appear to prosper while the righteous suffer, testing the believer's understanding of God's providence."
    ),
    (
      "Wicked Immunity → Pride and Corruption",
      "The wicked's immunity from human labor and scourging leading to pride and moral corruption",
      ["labor", "homo", "flagello", "superbia", "operio", "iniquitas", "impietas"],
      5,
      6,
      "The psalmist describes how the wicked are not in the labor of men nor scourged like others, so pride holds them fast and they are covered with iniquity and impiety.",
      "Augustine sees this as the soul's recognition that prosperity without divine discipline leads to pride and moral decay, where the wicked become immune to correction and grow in wickedness."
    ),
    (
      "Moral Corruption → Blasphemous Speech",
      "The wicked's iniquity flowing from fatness leading to blasphemous thoughts and speech",
      ["prodeo", "adeps", "iniquitas", "transeo", "affectus", "cor", "cogito", "loquor", "nequitia", "excelsus"],
      7,
      8,
      "The psalmist describes how the wicked's iniquity comes forth like fatness and passes into the affection of the heart, then how they think and speak wickedness and iniquity on high.",
      "For Augustine, this represents the soul's understanding that moral corruption leads to blasphemous thoughts and speech, where the wicked's prosperity breeds contempt for divine authority."
    ),
    (
      "Blasphemous Speech → Divine Response",
      "The wicked's blasphemy against heaven leading to divine response and people's return",
      ["pono", "caelum", "os", "lingua", "transeo", "terra", "converto", "populus", "dies", "plenus", "invenio"],
      9,
      10,
      "The psalmist describes how the wicked set their mouth against heaven and their tongue passes through the earth, then how God's people will return and full days will be found in them.",
      "Augustine sees this as the soul's recognition that blasphemy against divine authority provokes God's response, leading to the restoration of His people and the fulfillment of His promises."
    ),
    (
      "Divine Knowledge Questioned → Wicked Riches",
      "Questions about God's knowledge contrasted with the wicked's worldly abundance and riches",
      ["dico", "quomodo", "scio", "deus", "scientia", "excelsus", "ecce", "peccator", "abundo", "saeculum", "obtineo", "divitiae"],
      11,
      12,
      "The wicked question how God knows and if there is knowledge in the Most High, while they are sinners yet abounding in the world and obtaining riches.",
      "For Augustine, this represents the soul's struggle with the apparent contradiction between divine omniscience and the wicked's worldly success, testing faith in God's ultimate justice."
    ),
    (
      "Personal Righteousness Questioned → Divine Chastisement",
      "The psalmist's questioning of his own righteousness contrasted with divine chastisement",
      ["dico", "sine", "causa", "iustifico", "cor", "lavo", "innocens", "manus", "flagello", "totus", "dies", "castigatio", "matutinus"],
      13,
      14,
      "The psalmist questions if he has justified his heart in vain and washed his hands among the innocent, then describes being scourged all day with chastisement in the mornings.",
      "For Augustine, this represents the soul's crisis of faith where personal righteousness seems futile in the face of divine discipline, leading to deeper spiritual questioning."
    ),
    (
      "Generational Condemnation → Labor of Understanding",
      "The psalmist's struggle with condemning God's children leading to laborious seeking of understanding",
      ["dico", "narro", "ecce", "natio", "filius", "reprobo", "puto", "cognosco", "labor", "ante", "meus"],
      15,
      16,
      "The psalmist considers speaking against the generation of God's children but recognizes this would be wrong, then describes his labor to understand this matter.",
      "For Augustine, this represents the soul's struggle with theodicy and the labor required to understand divine providence, where hasty judgment must be avoided in favor of deeper spiritual insight."
    ),
    (
      "Sanctuary Understanding → Divine Deception",
      "The psalmist's journey to the sanctuary leading to understanding of divine deception of the wicked",
      ["donec", "intro", "sanctuarium", "deus", "intelligo", "novissimus", "verumtamen", "dolus", "pono", "deicio", "allevo"],
      17,
      18,
      "The psalmist resolves to go into God's sanctuary to understand the end of the wicked, then recognizes that God has set them up for deception and cast them down when they were lifted up.",
      "For Augustine, this represents the soul's journey into divine wisdom where the apparent prosperity of the wicked is revealed as divine deception, preparing them for ultimate judgment."
    ),
    (
      "Sudden Destruction → Dream-like Vanity",
      "The wicked's sudden destruction and perishing contrasted with their dream-like vanity",
      ["quomodo", "fio", "desolatio", "subito", "deficio", "pereo", "iniquitas", "velut", "somnium", "surgo", "dominus", "civitas", "imago", "nihilum", "redigo"],
      19,
      20,
      "The psalmist describes how the wicked are brought to desolation, suddenly ceasing to be and perishing by their iniquity, then compares them to a dream that God will bring to nothing in His city.",
      "For Augustine, this represents the soul's recognition that the wicked's prosperity is ultimately vain and temporary, like a dream that vanishes when divine reality is revealed."
    ),
    (
      "Heart Inflamed → Beast-like Humility",
      "The psalmist's inflamed heart leading to beast-like humility and constant divine presence",
      ["inflammo", "cor", "ren", "commuto", "ego", "nihilum", "redigo", "nescio", "sicut", "iumentum", "fio", "apud", "semper", "tecum"],
      21,
      22,
      "The psalmist's heart is inflamed and his reins changed, then he is brought to nothing and becomes like a beast before God, always with Him.",
      "For Augustine, this represents the soul's transformation through divine encounter, where human pride is burned away and replaced with humble, beast-like dependence on God."
    ),
    (
      "Divine Guidance → Heavenly Desire",
      "God's guidance and glory leading to the psalmist's desire for nothing but God",
      ["teneo", "manus", "dexter", "voluntas", "deduco", "gloria", "suscipio", "quid", "caelum", "volo", "terra"],
      23,
      24,
      "God holds the psalmist's right hand and guides him by His will, receiving him with glory, then the psalmist questions what he has in heaven or desires on earth besides God.",
      "For Augustine, this represents the soul's complete satisfaction in divine relationship, where God's guidance and glory make all earthly and heavenly desires secondary to union with Him."
    ),
    (
      "Flesh Fainting → Eternal Portion",
      "The psalmist's flesh and heart fainting leading to recognition of God as his eternal portion",
      ["deficio", "caro", "cor", "deus", "pars", "aeternus", "elongo", "pereo", "perdo", "fornicor", "abs"],
      25,
      26,
      "The psalmist's flesh and heart faint for God, who is the God of his heart and his eternal portion, then he recognizes that those who go far from God will perish.",
      "For Augustine, this represents the soul's complete surrender to divine love, where all human strength fails in favor of God as the only lasting portion and those who reject Him face destruction."
    ),
    (
      "Final Adherence → Proclamation",
      "The psalmist's final adherence to God leading to proclamation of His praises",
      ["adhaeo", "deus", "bonus", "pono", "dominus", "deus", "spes", "annuntio", "praedicatio", "porta", "filia", "sion"],
      27,
      28,
      "The psalmist declares it good to adhere to God and put his hope in the Lord, that he may declare all God's praises in the gates of the daughter of Sion.",
      "For Augustine, this represents the soul's ultimate resolution to cling to God alone, finding in Him the source of all hope and the motivation to proclaim His praises to the world."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Justice and Providence",
      "References to God's justice, knowledge, and providential care",
      ["deus", "bonus", "scio", "scientia", "excelsus", "iustifico", "castigatio", "sanctuarium", "intelligo", "dolus", "perdo", "adhaeo", "spes"],
      ThemeCategory.divine,
      1 ... 28
    ),
    (
      "Human Heart and Emotions",
      "References to the heart, emotions, and inner spiritual state",
      ["cor", "zelor", "affectus", "inflammo", "commuto", "deficio", "caro"],
      ThemeCategory.virtue,
      1 ... 26
    ),
    (
      "Wicked Prosperity and Pride",
      "References to the wicked's success, pride, and moral corruption",
      ["iniquus", "peccator", "pax", "superbia", "iniquitas", "impietas", "adeps", "nequitia", "excelsus", "abundo", "saeculum", "divitiae"],
      ThemeCategory.sin,
      3 ... 12
    ),
    (
      "Physical Body and Movement",
      "References to body parts, movement, and physical actions",
      ["pes", "gressus", "moveo", "effundo", "manus", "os", "lingua", "ren", "dexter", "caro"],
      ThemeCategory.virtue,
      2 ... 26
    ),
    (
      "Divine Guidance and Presence",
      "References to God's guidance, presence, and relationship with the psalmist",
      ["teneo", "manus", "voluntas", "deduco", "gloria", "suscipio", "semper", "tecum", "adhaeo"],
      ThemeCategory.divine,
      23 ... 28
    ),
    (
      "Destruction and Vanity",
      "References to destruction, perishing, and the vanity of worldly things",
      ["desolatio", "subito", "deficio", "pereo", "somnium", "nihilum", "redigo", "elongo", "fornicor"],
      ThemeCategory.sin,
      19 ... 27
    ),
    (
      "Sanctuary and Worship",
      "References to the sanctuary, worship, and proclamation of God's praises",
      ["sanctuarium", "annuntio", "praedicatio", "porta", "filia", "sion"],
      ThemeCategory.worship,
      17 ... 28
    ),
    (
      "Time and Eternity",
      "References to time, days, and eternal things",
      ["dies", "matutinus", "totus", "aeternus", "semper"],
      ThemeCategory.divine,
      10 ... 28
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 72 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 72 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm72_texts.json"
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
      filename: "output_psalm72_themes.json"
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
