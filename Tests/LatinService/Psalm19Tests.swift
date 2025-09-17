@testable import LatinService
import XCTest

class Psalm19Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 19, category: nil)
  private let expectedVerseCount = 10

  // MARK: - Test Data

  private let text = [
    "Exaudiat te Dominus in die tribulationis; protegat te nomen Dei Iacob.",
    "Mittat tibi auxilium de sancto, et de Sion tueatur te.",
    "Memor sit omnis sacrificii tui, et holocaustum tuum pingue fiat.",
    "Tribuat tibi secundum cor tuum, et omne consilium tuum confirmet.",
    "Laetabimur in salutari tuo; et in nomine Dei nostri magnificabimur.",
    "Impleat Dominus omnes petitiones tuas; nunc cognovi quoniam salvum fecit Dominus christum suum.",
    "Exaudiet illum de caelo sancto suo; in potentatibus salus dexterae eius.",
    "Hi in curribus, et hi in equis; nos autem in nomine Domini Dei nostri invocabimus.",
    "Ipsi obligati sunt, et ceciderunt; nos autem surreximus et erecti sumus.",
    "Domine, salvum fac regem, et exaudi nos in die qua invocaverimus te.",
  ]

  private let englishText = [
    "May the Lord hear thee in the day of tribulation: may the name of the God of Jacob protect thee.",
    "May he send thee help from the sanctuary: and defend thee out of Sion.",
    "May he be mindful of all thy sacrifices: and may thy whole burnt offering be made fat.",
    "May he give thee according to thy own heart; and confirm all thy counsels.",
    "We will rejoice in thy salvation; and in the name of our God we shall be exalted.",
    "The Lord fulfill all thy petitions: now have I known that the Lord hath saved his anointed.",
    "He will hear him from his holy heaven: the salvation of his right hand is in powers.",
    "Some trust in chariots, and some in horses: but we will call upon the name of the Lord our God.",
    "They are bound, and have fallen; but we are risen, and are set upright.",
    "O Lord, save the king: and hear us in the day that we shall call upon thee.",
  ]

  private let lineKeyLemmas = [
    (1, ["exaudio", "dominus", "dies", "tribulatio", "protego", "nomen", "deus", "iacob"]),
    (2, ["mitto", "auxilium", "sanctus", "sion", "tueor"]),
    (3, ["memor", "sacrificium", "holocaustum", "pinguis", "fio"]),
    (4, ["tribuo", "cor", "consilium", "confirmo"]),
    (5, ["laetor", "salus", "nomen", "deus", "magnifico"]),
    (6, ["impleo", "dominus", "petitio", "cognosco", "salvus", "facio", "christus"]),
    (7, ["exaudio", "caelum", "sanctus", "potentatus", "salus", "dextera"]),
    (8, ["currus", "equus", "nos", "nomen", "dominus", "deus", "invoco"]),
    (9, ["obligo", "cado", "nos", "surgo", "erigo"]),
    (10, ["dominus", "salvus", "facio", "rex", "exaudio", "nos", "dies", "invoco"]),
  ]

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 19 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 19 English text should have \(expectedVerseCount) verses")
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Test Cases

  func testAnalysisSummary() {
    let analysis = utilities.latinService.analyzePsalm(text: text)
    if verbose {
      print("\n=== Full Analysis ===")
      print("Total words:", analysis.totalWords)
      print("Unique lemmas:", analysis.uniqueLemmas)
      print("'salvum' forms:", analysis.dictionary["salvus"]?.forms ?? [:])
    }

    XCTAssertGreaterThan(analysis.totalWords, 80)
    XCTAssertGreaterThan(analysis.uniqueLemmas, 40)
  }

  func testDivineIntervention() {
    utilities.latinService.configureDebugging(target: "tueor")
    let analysis = utilities.latinService.analyzePsalm(id, text: text, startingLineNumber: 1)

    let interventionTerms = [
      ("exaudio", ["Exaudiat", "Exaudiet", "exaudi"], "hear"),
      ("protego", ["protegat"], "protect"),
      ("mitto", ["Mittat"], "send"),
      ("tueor", ["tueatur"], "guard"),
      ("impleo", ["Impleat"], "fulfill"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: interventionTerms)
  }

  func testRoyalMessianicLanguage() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let royalTerms = [
      ("christus", ["christum"], "anointed"),
      ("rex", ["regem"], "king"),
      ("potentia", ["potentatibus"], "power"),
      ("dextera", ["dexterae"], "right hand"),
      ("confirmo", ["confirmet"], "strengthen"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: royalTerms)
  }

  func testSacrificialLanguage() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let sacrificialTerms = [
      ("sacrificium", ["sacrificii"], "sacrifice"),
      ("holocaustum", ["holocaustum"], "burnt offering"),
      ("pinguis", ["pingue"], "rich/fat"),
      ("memor", ["Memor"], "mindful"),
      ("invoco", ["invocaverimus"], "call upon"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: sacrificialTerms)
  }

  func testVictoryImagery() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let victoryTerms = [
      ("currus", ["curribus"], "chariot"),
      ("equus", ["equis"], "horse"),
      ("cado", ["ceciderunt"], "fall"),
      ("surgo", ["surreximus"], "rise"),
      ("erigo", ["erecti"], "stand erect"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: victoryTerms)
  }

  func testCommunalResponse() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let communalTerms = [
      ("laetor", ["Laetabimur"], "rejoice"),
      ("magnifico", ["magnificabimur"], "magnify"),
      ("nos", ["nos", "nobis"], "we/us"),
      ("nomen", ["nomine", "nomen"], "name"),
      ("salus", ["salutari", "salus"], "salvation"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: communalTerms)
  }

  func testDivineAttributes() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let divineTerms = [
      ("dominus", ["dominus", "domini"], "lord"),
      ("deus", ["dei"], "god"),
      ("sanctus", ["sancto", "sancto"], "holy"),
      ("sion", ["sion"], "zion"),
      ("jacob", ["jacob"], "Jacob"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
  }

  func testHumanPetition() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let petitionTerms = [
      ("cor", ["cor"], "heart"),
      ("consilium", ["consilium"], "plan"),
      ("petitio", ["petitiones"], "petition"),
      ("dies", ["die"], "day"),
      ("tribulatio", ["tribulationis"], "trouble"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: petitionTerms)
  }

  // MARK: - Helper

  private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
    for (lemma, forms, translation) in confirmedWords {
      guard let entry = analysis.dictionary[lemma] else {
        XCTFail("Missing lemma: \(lemma)")
        continue
      }

      // Verify semantic domain
      XCTAssertTrue(
        entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
        "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
      )

      // Verify morphological coverage
      let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
      if !missingForms.isEmpty {
        XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
      }

      if verbose {
        print("\n\(lemma.uppercased())")
        print("  Translation: \(entry.translation ?? "?")")
        for form in forms {
          let count = entry.forms[form.lowercased()] ?? 0
          print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
        }
      }
    }
  }
}
