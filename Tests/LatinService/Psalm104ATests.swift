@testable import LatinService
import XCTest

class Psalm104ATests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test Data (Psalm 104A)

  let id = PsalmIdentity(number: 104, category: "A")
  let psalm104A = [
    "Confitemini Domino, et invocate nomen eius; annuntiate inter gentes opera eius.",
    "Cantate ei, et psallite ei; narrate omnia mirabilia eius.",
    "Laudamini in nomine sancto eius; laetetur cor quaerentium Dominum.",
    "Quaerite Dominum, et confirmamini; quaerite faciem eius semper.",
    "Mementote mirabilium eius quae fecit, prodigia eius, et iudicia oris eius,",
    
    "semen Abraham servi eius, filii Iacob electi eius.",
    "Ipse Dominus Deus noster; in universa terra iudicia eius.",
    "Memor fuit in saeculum testamenti sui, verbi quod mandavit in mille generationes,",
    "quod disposuit ad Abraham, et iuramenti sui ad Isaac.",
    "Et statuit illud Iacob in praeceptum, et Israel in testamentum aeternum,",
    
    
    "dicens: Tibi dabo terram Chanaan, funiculum hereditatis vestrae.",
    "Cum essent numero brevi, paucissimi et incolae eius,",
    "et pertransierunt de gente in gentem, et de regno ad populum alterum.",
    "Non reliquit hominem nocere eis, et corripuit pro eis reges.",
    "Nolite tangere christos meos, et in prophetis meis nolite malignari.",
   
    "Et vocavit famem super terram, et omne firmamentum panis contrivit.",
    "Misit ante eos virum; in servum venundatus est Ioseph.",
    "Humiliaverunt in compedibus pedes eius, ferrum pertransiit animam eius, donec veniret verbum eius. ",
    "Eloquium Domini inflammavit eum. Misit rex, et solvit eum; princeps populorum, et dimisit eum.",
    "Constituit eum dominum domus suae, et principem omnis possessionis suae,",
   
    "ut erudiret principes eius sicut semetipsum, et senes eius prudentiam doceret."
  ]

  private let englishText = [
    "Give glory to the Lord, and call upon his name: declare his deeds among the Gentiles.",
    "Sing to him, yea sing praises to him: relate all his wondrous works.",
    "Glory ye in his holy name: let the heart of them rejoice that seek the Lord.",
    "Seek ye the Lord, and be strengthened: seek his face evermore.",
    "Remember his marvellous works which he hath done; his wonders, and the judgments of his mouth,",
    "O ye seed of Abraham his servant, ye sons of Jacob his chosen.",
    "He is the Lord our God: his judgments are in all the earth.",
    "He hath remembered his covenant for ever: the word which he commanded to a thousand generations,",
    "Which he made to Abraham; and his oath to Isaac:",
    "And he appointed the same to Jacob for a law, and to Israel for an everlasting testament,",
    "Saying: To thee will I give the land of Chanaan, the lot of your inheritance.",
    "When they were but a small number: yea very few, and sojourners therein,",
    "And they passed from nation to nation, and from one kingdom to another people.",
    "He suffered no man to hurt them: and he reproved kings for their sakes.",
    "Touch ye not my anointed: and do no evil to my prophets.",
    "And he called a famine upon the land: and he broke in pieces all the support of bread.",
    "He sent a man before them: Joseph, who was sold for a slave.",
    "They humbled his feet in fetters: the iron pierced his soul, until his word came. ",
    "The word of the Lord inflamed him. The king sent, and he released him: the ruler of the people, and he set him at liberty.",
    "He made him master of his house, and ruler of all his possession,",
    "That he might instruct his princes as himself, and teach his ancients wisdom."
  ]

  
  private let lineKeyLemmas = [
    (1, ["confiteor", "dominus", "invoco", "nomen", "annuntio", "gens", "opera"]),
    (2, ["canto", "psallo", "narro", "mirabilis", "omnis"]),
    (3, ["laudo", "nomen", "sanctus", "laetor", "cor", "quaero", "dominus"]),
    (4, ["quaero", "dominus", "confirmo", "facies", "semper"]),
    (5, ["memini", "mirabilis", "facio", "prodigium", "iudicium", "os"]),
    (6, ["semen", "abraham", "servus", "filius", "iacob", "eligo"]),
    (7, ["ipse", "dominus", "deus", "noster", "universus", "terra", "iudicium"]),
    (8, ["memor", "saeculum", "testamentum", "verbum", "mando", "mille", "generatio"]),
    (9, ["dispono", "abraham", "iuramentum", "isaac"]),
    (10, ["statuo", "iacob", "praeceptum", "israel", "testamentum", "aeternus"]),
    (11, ["dico", "tu", "do", "terra", "chanaan", "funiculus", "hereditas"]),
    (12, ["cum", "numero", "brevis", "paucissimus", "incola"]),
    (13, ["pertransio", "gens", "regnum", "populus", "alter"]),
    (14, ["relinquo", "homo", "nocere", "corripio", "rex"]),
    (15, ["nolo", "tango", "christus", "propheta", "malignor"]),
    (16, ["voco", "fames", "terra", "firmamentum", "panis", "contero"]),
    (17, ["mitto", "vir", "servus", "venundo", "ioseph"]),
    (18, ["humilio", "compes", "pes", "ferrum", "pertransio", "anima", "donec", "venio", "verbum"]),
    (19, ["eloquium", "dominus", "inflammo", "mitto", "rex", "solvo", "princeps", "populus", "dimitto"]),
    (20, ["constituo", "dominus", "domus", "princeps", "possessio"]),
    (21, ["erudio", "princeps", "semetipsum", "senex", "prudentia", "doceo"]),
  ]
  private let structuralThemes = [
    (
      "Praise → Proclamation",
      "Call to praise God leads to proclamation of His deeds among nations",
      ["confiteor", "invoco", "annuntio", "canto", "psallo", "narratio"],
      1,
      2,
      "The psalm opens with a call to give glory to the Lord, invoke His name, and declare His works among the nations, followed by singing and recounting His wondrous deeds.",
      "Augustine sees this as the Church's duty to proclaim God's works to all peoples (Enarr. Ps. 104.1-2)."
    ),
    (
      "Seeking → Joy",
      "Seeking the Lord brings joy to the heart of those who pursue Him",
      ["laudatio", "nomen", "sanctus", "laetor", "cor", "quaero", "dominus"],
      3,
      4,
      "The call to glory in God's holy name leads to rejoicing of the heart, and the command to seek the Lord and His face continually.",
      "Augustine interprets this as the soul's journey from external praise to internal joy through seeking God's presence (Enarr. Ps. 104.3-4)."
    ),
    (
      "Remembrance → Covenant",
      "Remembering God's works leads to reflection on His covenant with Israel",
      ["memento", "mirabilis", "facio", "prodigium", "iudicium", "os", "semen", "abraham", "servus", "filius", "iacob", "eligo"],
      5,
      6,
      "The psalmist calls to remember God's marvels, wonders, and judgments, then identifies the recipients as the seed of Abraham and chosen sons of Jacob.",
      "Augustine links this to God's faithfulness in preserving His covenant people through history (Enarr. Ps. 104.5-6)."
    ),
    (
      "Divine Sovereignty → Universal Judgment",
      "God's identity as Lord and God of Israel leads to affirmation of His universal judgment",
      ["ipse", "dominus", "deus", "noster", "universus", "terra", "iudicium"],
      7,
      8,
      "The declaration 'He is the Lord our God' is immediately followed by the affirmation that His covenant is remembered for eternity and commanded to a thousand generations.",
      "Augustine emphasizes that God's covenantal relationship with Israel reflects His universal sovereignty (Enarr. Ps. 104.7-8)."
    ),
    (
      "Covenant → Eternal Promise",
      "God's covenant is remembered for eternity, established through generations",
      ["memor", "saeculum", "testamentum", "verbum", "mando", "mille", "generatio", "dispono", "abraham", "iuramentum", "isaac"],
      9,
      10,
      "God's covenant is remembered for all ages, the word He commanded to a thousand generations, established with Abraham and His oath to Isaac, and appointed as law for Jacob and testament for Israel.",
      "Augustine sees this as the unbreakable promise of God's faithfulness across generations (Enarr. Ps. 104.9-10)."
    ),
    (
      "Covenant → Law and Testament",
      "The covenant is established as law for Jacob and eternal testament for Israel",
      ["statuo", "iacob", "praeceptum", "israel", "testamentum", "aeternus", "dico", "tu", "do", "terra", "chanaan", "funiculus", "hereditas"],
      11,
      12,
      "God establishes His covenant as a law for Jacob and an eternal testament for Israel, promising the land of Canaan as their inheritance, even when they were few and sojourners.",
      "Augustine interprets this as the divine foundation of Israel's identity and destiny (Enarr. Ps. 104.11-12)."
    ),
    (
      "Exile → Divine Protection",
      "Israel's small numbers and exile are met with divine protection from enemies",
      ["cum", "numero", "brevi", "paucissimus", "incola", "pertransio", "gens", "regnum", "populus", "alter", "relinquo", "homo", "nocere", "corripio", "rex"],
      13,
      14,
      "Though Israel was few and sojourners, passing from nation to nation, God did not allow any man to harm them and rebuked kings on their behalf.",
      "Augustine sees this as God's providential care for His people even in their weakest state (Enarr. Ps. 104.13-14)."
    ),
    (
      "Divine Command → Prophetic Boundaries",
      "God's command not to touch His anointed and prophets establishes sacred boundaries",
      ["nolite", "tango", "christus", "propheta", "maligno"],
      15,
      16,
      "God commands: 'Touch not my anointed, and do no evil to my prophets.' He calls a famine upon the land and breaks all support of bread as discipline.",
      "Augustine interprets this as the inviolability of God's chosen servants and the seriousness of opposing divine authority (Enarr. Ps. 104.15-16)."
    ),
    (
      "Joseph → Divine Preparation",
      "God sends Joseph as a servant, humiliated and bound, to prepare for Israel's deliverance",
      ["mitto", "vir", "servus", "venundatio", "ioseph", "humilio", "compes", "pes", "ferrum", "pertransio", "anima", "donec", "venio", "verbum"],
      17,
      18,
      "God sends Joseph before them, sold as a slave, his feet bound in fetters, his soul pierced by iron, until the word of the Lord came.",
      "Augustine interprets Joseph's suffering as the necessary path to divine exaltation and the fulfillment of God's plan (Enarr. Ps. 104.17-18)."
    ),
    (
      "Divine Word → Deliverance",
      "The word of the Lord inflames Joseph, leading to his release and exaltation",
      ["elocutio", "dominus", "inflammo", "mitto", "rex", "solvio", "princeps", "populus", "dimittio"],
      19,
      20,
      "The word of the Lord inflames Joseph; the king sends and releases him, the ruler of the people sets him free. He makes him master of his house and ruler of all his possessions.",
      "Augustine sees this as the pivotal moment when divine timing fulfills Joseph's destiny (Enarr. Ps. 104.19-20)."
    ),
    (
      "Exaltation → Instruction",
      "Joseph is exalted to rule and entrusted with instructing the princes and elders",
      ["constituo", "dominus", "domus", "princeps", "possessio", "erudio", "princeps", "semetipsum", "senex", "prudentia", "doceo"],
      21,
      21,
      "He instructs his princes as himself and teaches his elders wisdom.",
      "Augustine interprets this as the fulfillment of God's promise: the humble are exalted, and the suffering become instruments of divine wisdom (Enarr. Ps. 104.21)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Authority Imagery",
      "Throne, judgment, and royal authority metaphors",
      ["dominus", "deus", "iudicium", "testamentum", "praeceptum", "statuo", "constituo", "regnum"],
      ThemeCategory.divine,
      1 ... 21
    ),
    (
      "Covenant and Promise Imagery",
      "Covenant, oath, inheritance, and eternal word metaphors",
      ["testamentum", "iuramentum", "hereditas", "verbum", "mando", "memor", "saeculum", "mille", "generatio", "dispono"],
      ThemeCategory.divine,
      8 ... 11
    ),
    (
      "Exile and Journey Imagery",
      "Migration, sojourning, and movement metaphors",
      ["pertransio", "gens", "regnum", "populus", "alter", "incola", "numero", "brevi", "paucissimus"],
      ThemeCategory.opposition,
      12 ... 13
    ),
    (
      "Suffering and Bondage Imagery",
      "Fetters, iron, slavery, and humiliation metaphors",
      ["compes", "pes", "ferrum", "pertransio", "anima", "servus", "venundatio", "humilio"],
      ThemeCategory.opposition,
      17 ... 19
    ),
    (
      "Deliverance and Exaltation Imagery",
      "Release, kingship, mastery, and instruction metaphors",
      ["solvio", "dimittio", "princeps", "dominus", "domus", "possessio", "erudio", "doceo", "prudentia"],
      ThemeCategory.divine,
      20 ... 21
    ),
    (
      "Famine and Provision Imagery",
      "Famine, bread, and sustenance metaphors",
      ["fames", "terra", "firmamentum", "panis", "contrideo"],
      ThemeCategory.opposition,
      16 ... 16
    ),
    (
      "Prophetic and Anointed Imagery",
      "Anointed, prophets, and sacred boundaries metaphors",
      ["christus", "propheta", "tango", "maligno"],
      ThemeCategory.divine,
      15 ... 15
    )
  ]

  func testTotalVerses() {
    let expectedVerseCount = 21
    XCTAssertEqual(psalm104A.count, expectedVerseCount, "Psalm 104A should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 104A English text should have \(expectedVerseCount) verses")
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm104A.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm104A,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm104A,
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
      psalmText: psalm104A,
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
    psalmText: psalm104A,
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
    text: psalm104A,
    englishText: englishText
  )

  let success = utilities.saveToFile(
    content: jsonString,
    filename: "output_psalm104a_texts.json"
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
    filename: "output_psalm104a_themes.json"
  )

  if success {
    print("✅ Complete themes JSON created successfully")
  } else {
    print("⚠️ Could not save complete themes file:")
    print(jsonString)
  }
}

}

