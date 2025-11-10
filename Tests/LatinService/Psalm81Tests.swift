@testable import LatinService
import XCTest

class Psalm81Tests: XCTestCase {
  // MARK: - Helpers

  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  // MARK: - Psalm Identification

  private let id = PsalmIdentity(number: 81, category: nil)
  private let expectedVerseCount = 8

  // MARK: - Test Data

  private let text = [
    "Deus stetit in synagoga deorum; in medio autem deos diiudicat.",
    "Usquequo iudicatis iniquitatem, et facies peccatorum sumitis?",
    "iudicate egeno et pupillo; humilem et pauperem iustificate.",
    "Eripite pauperem, et egenum de manu peccatoris liberate.",
    "Nescierunt, neque intellexerunt; in tenebris ambulant; movebunt omnia fundamenta terrae.",
    "Ego dixi: Dii estis, et filii Excelsi omnes.",
    "Vos autem sicut homines moriemini, et sicut unus de principibus cadetis.",
    "Exsurge, Deus, iudica terram; quoniam tu haereditabis in omnibus gentibus."
  ]

  private let englishText = [
    "God hath stood in the congregation of gods; and being in the midst of them he judgeth gods.",
    "How long will you judge unjustly, and accept the persons of the wicked?",
    "Judge for the needy and fatherless; do justice to the humble and the poor.",
    "Deliver the poor, and rescue the needy out of the hand of the sinner.",
    "They have not known nor understood; they walk on in darkness; all the foundations of the earth shall be moved.",
    "I have said: You are gods, and all of you the sons of the most High.",
    "But you like men shall die, and shall fall like one of the princes.",
    "Arise, O God, judge thou the earth; for thou shalt inherit among all the nations."
  ]

  // No specific lemmas have been supplied for Psalm 81 – an empty list is acceptable
  // for the purpose of the generic tests.  The utility functions handle empty data
  // gracefully, allowing the test suite to compile and run.
  private let lineKeyLemmas = [
  (1, [
    "deus",          // Deus
    "sto",           // stetit
    "synagoga",      // synagoga
    "deus",          // deorum (gen. pl. of deus)
    "medius",        // medio
    "autem",         // autem
    "iudico",        // diiudicat
    "deo"            // deos (acc. pl. of deus)
  ]),
  (2, [
    "usque",         // usquequo
    "iudico",        // iudicatis
    "iniquitas",     // iniquitatem
    "facies",        // facies
    "peccator",      // peccatorum
    "sumo"           // sumitis
  ]),
  (3, [
    "iudico",        // iudicate
    "egenus",        // egeno
    "pupillus",      // pupillo
    "humilis",       // humilem
    "pauper",        // pauperem
    "iustifico"      // iustificate
  ]),
  (4, [
    "eripio",        // eripite
    "pauper",        // pauperem
    "egenus",        // egenum
    "manus",         // manu
    "peccator",      // peccatoris
    "libero"         // liberate
  ]),
  (5, [
    "nescio",        // nescierunt
    "intellego",     // intellexerunt
    "tenebrae",      // tenebris
    "ambulo",        // ambulant
    "moveo",         // movebunt
    "omnis",         // omnia
    "fundamentum",   // fundamenta
    "terra"          // terrae
  ]),
  (6, [
    "ego",           // Ego
    "dico",          // dixi
    "deus",          // dii (pl. of deus)
    "sum",           // estis
    "filius",        // filii
    "excelsus",      // excelsi
    "omnis"          // omnes
  ]),
  (7, [
    "vos",           // Vos
    "autem",         // autem
    "homo",          // homines
    "morior",        // moriemini
    "unus",          // unus
    "princeps",      // principibus
    "cado"           // cadetis
  ]),
  (8, [
    "exsurgo",       // Exsurge
    "deus",          // Deus
    "iudico",        // iudica
    "terra",         // terram
    "quoniam",       // quoniam
    "haeredito",     // haereditabis
    "omnis",         // omnibus
    "gens"           // gentibus
  ])
]


  // MARK: - Structural Themes

  // One structural theme per two verses, named “a→b”.
  private let structuralThemes = [
    (
      "1→2",
      "From divine judgment to the inquiry about injustice",
      [] as [String],
      1,
      2,
      "God stands among the divine council and judges; the psalmist then asks how long the unjust will be judged.",
      "The first pair sets up the divine courtroom scene and immediately questions the persistence of injustice."
    ),
    (
      "3→4",
      "From pleading for the poor to delivering them",
      [] as [String],
      3,
      4,
      "A call to judge the needy and a command to rescue them from sinners.",
      "These verses move from moral exhortation to concrete action on behalf of the vulnerable."
    ),
    (
      "5→6",
      "From darkness and ignorance to divine self‑identification",
      [] as [String],
      5,
      6,
      "The wicked walk in darkness; the speaker declares that the divine are called “gods”.",
      "The contrast highlights the spiritual blindness of the wicked against the self‑revelation of the divine."
    ),
    (
      "7→8",
      "From mortal destiny to divine judgment over the earth",
      [] as [String],
      7,
      8,
      "Men shall die like princes; God is urged to arise and judge the earth, inheriting the nations.",
      "The final pair moves from human frailty to the ultimate divine judgment and inheritance."
    )
  ]

  // No conceptual themes are required for this test suite; an empty array is used.
  private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = []

  // MARK: - Tests

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount,
                   "Psalm 81 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount,
                   "Psalm 81 English text should have \(expectedVerseCount) verses")

    // Validate orthography – the utility normalises the Latin text.
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(normalized, text,
                   "Normalized Latin text should match expected classical forms")
  }

  func testLineByLineKeyLemmas() {
    // With an empty `lineKeyLemmas` the utility simply verifies that the counts match.
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
    // Verify that all structural theme lemmas are present in the line‑key lemmas.
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Run the standard structural‑theme test.
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    // Verify that conceptual theme lemmas (if any) exist in the line‑key lemmas.
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false // Conceptual themes may contain extra imagery lemmas.
    )

    // Run the standard conceptual‑theme test (will be a no‑op with an empty array).
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Persistence Tests

  func testSaveThemes() {
    guard let jsonString = utilities.generateCompleteThemesJSONString(
      psalmNumber: id.number,
      conceptualThemes: conceptualThemes,
      structuralThemes: structuralThemes
    ) else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm81_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm81_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
