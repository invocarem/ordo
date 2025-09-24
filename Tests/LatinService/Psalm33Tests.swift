@testable import LatinService
import XCTest

class Psalm33Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 33, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 22
  private let text = [
    "Benedicam Dominum in omni tempore; semper laus eius in ore meo.",
    "In Domino laudabitur anima mea; audiant mansueti, et laetentur.",
    "Magnificate Dominum mecum, et exaltemus nomen eius in idipsum.",
    "Exquisivi Dominum, et exaudivit me; et ex omnibus tribulationibus meis eripuit me.",
    "Accedite ad eum, et illuminamini; et facies vestrae non confundentur.",
    
    "Iste pauper clamavit, et Dominus exaudivit eum; et de omnibus tribulationibus eius salvavit eum.",
    "Immittet angelus Domini in circuitu timentium eum, et eripiet eos.",
    "Gustate et videte quoniam suavis est Dominus; beatus vir qui sperat in eo.",
    "Timete Dominum, omnes sancti eius; quoniam non est inopia timentibus eum.",
    "Divites eguerunt et esurierunt; inquirentes autem Dominum non deficient omni bono.",
    "Venite, filii, audite me; timorem Domini docebo vos.",
    "Quis est homo qui vult vitam, diligit dies videre bonos?",
    "Prohibe linguam tuam a malo, et labia tua ne loquantur dolum.",
    "Diverte a malo, et fac bonum; inquire pacem, et persequere eam.",
    "Oculi Domini super iustos, et aures eius in preces eorum.",
    "Vultus autem Domini super facientes mala, ut perdat de terra memoriam eorum.",
    "Clamaverunt iusti, et Dominus exaudivit eos; et ex omnibus tribulationibus eorum liberavit eos.",
    "Iuxta est Dominus iis qui tribulato sunt corde; et humiles spiritu salvabit.",
    "Multae tribulationes iustorum; et de omnibus his liberabit eos Dominus.",
    "Custodit Dominus omnia ossa eorum; unum ex his non conteretur.",
    "Mors peccatorum pessima; et qui oderunt iustum, delinquent.",
    "Redimet Dominus animas servorum suorum; et non delinquent omnes qui sperant in eo.",
  ]

  private let englishText = [
    "I will bless the Lord at all times; his praise shall be always in my mouth.",
    "In the Lord shall my soul be praised; let the meek hear and rejoice.",
    "O magnify the Lord with me; and let us extol his name together.",
    "I sought the Lord, and he heard me; and he delivered me from all my troubles.",
    "Come ye to him and be enlightened; and your faces shall not be confounded.",
    "This poor man cried, and the Lord heard him; and saved him out of all his troubles.",
    "The angel of the Lord shall encamp round about them that fear him; and shall deliver them.",
    "O taste, and see that the Lord is sweet; blessed is the man that hopeth in him.",
    "Fear the Lord, all ye his saints; for there is no want to them that fear him.",
    "The rich have wanted, and have suffered hunger; but they that seek the Lord shall not be deprived of any good.",
    "Come, children, hearken to me; I will teach you the fear of the Lord.",
    "Who is the man that desireth life; who loveth to see good days?",
    "Keep thy tongue from evil, and thy lips from speaking guile.",
    "Turn away from evil and do good; seek after peace and pursue it.",
    "The eyes of the Lord are upon the just; and his ears unto their prayers.",
    "But the countenance of the Lord is against them that do evil things; to cut off the remembrance of them from the earth.",
    "The just cried, and the Lord heard them; and delivered them out of all their troubles.",
    "The Lord is nigh unto them that are of a contrite heart; and he will save the humble of spirit.",
    "Many are the afflictions of the just; but out of them all will the Lord deliver them.",
    "The Lord keepeth all their bones; not one of them shall be broken.",
    "The death of the wicked is very evil; and they that hate the just shall be guilty.",
    "The Lord will redeem the souls of his servants; and none of them that trust in him shall offend.",
  ]

  private let lineKeyLemmas = [
    (1, ["benedico", "dominus", "omnis", "tempus", "semper", "laus", "os"]),
    (2, ["dominus", "laudo", "anima", "audio", "mansuetus", "laetor"]),
    (3, ["magnifico", "dominus", "exalto", "nomen", "idipsum"]),
    (4, ["exquiro", "dominus", "exaudio", "omnis", "tribulatio", "eripio"]),
    (5, ["accedo", "illumino", "facies", "confundo"]),
    (6, ["pauper", "clamo", "dominus", "exaudio", "omnis", "tribulatio", "salvo"]),
    (7, ["immitto", "angelus", "dominus", "circuitus", "timeo", "eripio"]),
    (8, ["gusto", "video", "suavis", "dominus", "beatus", "vir", "spero"]),
    (9, ["timeo", "dominus", "omnis", "sanctus", "inopia", "timeo"]),
    (10, ["dives", "egeo", "esurio", "inquiro", "dominus", "deficio", "omnis", "bonus"]),
    (11, ["venio", "filius", "audio", "timor", "dominus", "doceo"]),
    (12, ["quis", "homo", "volo", "vita", "diligo", "dies", "video", "bonus"]),
    (13, ["prohibeo", "lingua", "malus", "labium", "loquor", "dolus"]),
    (14, ["diverto", "malus", "facio", "bonus", "inquiro", "pax", "persequor"]),
    (15, ["oculus", "dominus", "super", "iustus", "auris", "prex"]),
    (16, ["vultus", "dominus", "super", "facio", "malus", "perdo", "terra", "memoria"]),
    (17, ["clamo", "iustus", "dominus", "exaudio", "omnis", "tribulatio", "libero"]),
    (18, ["iuxta", "dominus", "tribulatus", "cor", "humilis", "spiritus", "salvo"]),
    (19, ["multus", "tribulatio", "iustus", "omnis", "libero", "dominus"]),
    (20, ["custodio", "dominus", "omnis", "os", "unus", "contero"]),
    (21, ["mors", "peccator", "pessimus", "odi", "iustus", "delinquo"]),
    (22, ["redimo", "dominus", "anima", "servus", "delinquo", "omnis", "spero"]),
  ]

  private let structuralThemes = [
    (
      "Personal Praise → Communal Invitation",
      "Individual commitment to praise leading to invitation for communal worship",
      ["benedico", "laus", "magnifico", "exalto", "nomen"],
      1,
      3,
      "The psalmist begins with personal commitment to constant praise, then invites others to magnify and exalt the Lord's name together.",
      "Augustine sees this as the natural progression from personal devotion to evangelical witness - the soul filled with God's goodness cannot help but invite others to share in divine praise."
    ),
    (
      "Divine Response → Universal Call",
      "Testimony of God's deliverance followed by invitation for all to approach Him",
      ["exquiro", "exaudio", "eripio", "accedo", "illumino", "pauper", "clamo", "salvo"],
      4,
      6,
      "The psalmist testifies to being heard and delivered by God, then calls all to approach and be enlightened, citing the example of the poor man who cried and was saved.",
      "For Augustine, personal experience of God's faithfulness becomes the basis for universal evangelization, showing that God responds to both the seeker and the desperate cry of the poor."
    ),
    (
      "Divine Protection → Experiential Knowledge",
      "God's angelic protection leading to invitation to taste and see His goodness",
      ["immitto", "angelus", "eripiet", "gustate", "videte", "suavis", "sperat"],
      7,
      8,
      "The psalm describes God sending angels to protect the faithful, then invites experiential knowledge of God's sweetness through tasting and seeing.",
      "Augustine interprets this as the movement from doctrinal belief to lived experience - God's protective care leads to personal discovery of His delightful nature."
    ),
    (
      "Contrast: Fear vs Want → Teaching the Fear of God",
      "Contrast between those who fear God lacking nothing and the hungry rich, leading to instruction in holy fear",
      ["timete", "inopia", "divites", "eguerunt", "venite", "filii", "docebo", "timorem"],
      9,
      11,
      "The psalm contrasts those who fear God having no want with the hungry rich, then calls children to learn the fear of the Lord.",
      "Augustine sees this as exposing the paradox of true wealth - material poverty with spiritual abundance versus material wealth with spiritual hunger, leading to the essential lesson of holy fear."
    ),
    (
      "Moral Instruction → Divine Surveillance",
      "Practical ethical teaching followed by assurance of God's watchful care",
      ["prohibe", "lingua", "diverte", "malo", "fac", "bonum", "oculi", "domini", "aures"],
      12,
      15,
      "The psalm gives practical instruction for righteous living, then assures that God's eyes are on the just and His ears open to their prayers.",
      "For Augustine, ethical living is not autonomous but exists within the context of God's constant attention - our moral choices are made under divine gaze and with divine support."
    ),
    (
      "Divine Justice → Ultimate Redemption",
      "God's judgment on evil contrasted with His deliverance and final redemption of the faithful",
      ["vultus", "domini", "perdat", "clamaverunt", "liberavit", "redimet", "animas", "servorum"],
      16,
      22,
      "The psalm describes God's face against evildoers but His deliverance of the just from troubles, concluding with ultimate redemption of souls.",
      "Augustine sees this as the comprehensive divine economy - temporal justice and deliverance pointing toward eschatological redemption, where God preserves even the bones of the righteous as pledge of resurrection."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Praise and Worship",
      "Expressions of blessing, praise, and magnification of God",
      ["benedico", "laus", "laudo", "magnifico", "exalto"],
      ThemeCategory.worship,
      1 ... 3
    ),
    (
      "Prayer and Divine Response",
      "Crying out to God and His hearing/deliverance",
      ["exquiro", "clamo", "exaudio", "eripio", "salvo", "libero"],
      ThemeCategory.divine,
      4 ... 19
    ),
    (
      "Fear of the Lord",
      "Reverence, fear, and holy awe toward God",
      ["timeo", "timor", "timentium", "timete"],
      ThemeCategory.virtue,
      2 ... 11
    ),
    (
      "Poverty and Wealth",
      "Contrast between spiritual and material wealth",
      ["pauper", "divites", "egeo", "esurio", "inopia"],
      ThemeCategory.virtue,
      6 ... 10
    ),
    (
      "Moral Instruction",
      "Practical guidance for righteous living",
      ["prohibe", "diverte", "fac", "inquire", "persequere", "loquantur"],
      ThemeCategory.virtue,
      11 ... 14
    ),
    (
      "Divine Omniscience",
      "God's watchful care and attention to human affairs",
      ["oculi", "aures", "vultus", "custodit", "juxta"],
      ThemeCategory.divine,
      15 ... 20
    ),
    (
      "Affliction and Deliverance",
      "Troubles of the righteous and God's rescue",
      ["tribulatio", "tribulato", "multae", "liberabit", "eripiet"],
      ThemeCategory.virtue,
      4 ... 19
    ),
    (
      "Final Outcomes",
      "Contrasting destinies of righteous and wicked",
      ["mors", "peccator", "redimet", "animas", "delinquent"],
      ThemeCategory.divine,
      21 ... 22
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 33 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 33 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm33_texts.json"
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
      filename: "output_psalm33_themes.json"
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
