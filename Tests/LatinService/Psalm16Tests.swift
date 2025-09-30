@testable import LatinService
import XCTest

class Psalm16Tests: XCTestCase {
  private var latinService: LatinService!
  let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  // MARK: - Test Data

  let id = PsalmIdentity(number: 16, category: "")
  private let expectedVerseCount = 17

  let psalm16 = [
    "Exaudi, Domine, iustitiam meam; intende deprecationem meam.",
    "Auribus percipe orationem meam, non in labiis dolosis.",
    "De vultu tuo iudicium meum prodeat; oculi tui videant aequitatem.",
    "Probasti cor meum, et visitasti nocte; igne me examinasti, et non est inventa in me iniquitas.",
    "Ut non loquatur os meum opera hominum; propter verba labiorum tuorum ego custodivi vias duras.",

    "Perfice gressus meos in semitis tuis, ut non moveantur vestigia mea.",
    "Ego clamavi, quoniam exaudisti me, Deus; inclina aurem tuam mihi, et exaudi verba mea.",
    "Mirifica misericordias tuas, qui salvos facis sperantes in te.",
    "A resistentibus dexterae tuae custodi me, ut pupillam oculi.",
    "Sub umbra alarum tuarum protege me, a facie impiorum qui me afflixerunt.",

    "Inimici mei animam meam circumdederunt; adipem suum concluserunt, os eorum locutum est superbiam.",
    "Proicientes me nunc circumdederunt me; oculos suos statuerunt declinare in terram.",
    "Susceperunt me sicut leo paratus ad praedam, et sicut catulus leonis habitans in abditis.",
    "Exsurge, Domine, praeveni eos, et supplanta eos. Eripe animam meam ab impio, frameam tuam ab inimicis manus tuae.",
    "Domine, a paucis de terra divide eos in vita eorum; de absconditis tuis adimpletus est venter eorum.",
    "Saturati sunt filiis, et dimiserunt reliquias suas parvulis suis.",
    "Ego autem in iustitia apparebo conspectui tuo; satiabor cum apparuerit gloria tua.",
  ]

  private let englishText = [
    "Hear, O Lord, my justice: attend to my supplication.",
    "Give ear unto my prayer, which proceedeth not from deceitful lips.",
    "Let my judgment come forth from thy countenance: let thy eyes behold the things that are equitable.",
    "Thou hast proved my heart, and visited it by night, thou hast tried me by fire: and iniquity hath not been found in me.",
    "That my mouth may not speak the works of men: for the sake of the words of thy lips, I have kept hard ways.",

    "Perfect thou my goings in thy paths: that my footsteps be not moved.",
    "I have cried to thee, for thou, O God, hast heard me: O incline thy ear unto me, and hear my words.",
    "Shew forth thy wonderful mercies; thou who savest them that trust in thee.",
    "From them that resist thy right hand keep me, as the apple of thy eye.",
    "Protect me under the shadow of thy wings, from the face of the wicked who have afflicted me.",

    "My enemies have surrounded my soul: they have shut up their fat: their mouth hath spoken proudly.",
    "They have cast me forth and now they have surrounded me: they have set their eyes to cast me down to the earth.",
    "They have taken me, as a lion prepared for the prey; and as a young lion dwelling in secret places.",
    "Arise, O Lord, disappoint them and supplant them; deliver my soul from the wicked one; thy sword from the enemies of thy hand.",
    "O Lord, divide them in their number: and scatter them in their vanity.",

    "Let their belly be filled with thy hidden things: and let their children be satisfied, and leave the rest to their little ones.",
    "But as for me, I will appear before thy sight in justice: I shall be satisfied when thy glory shall appear.",
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      psalm16.count, expectedVerseCount, "Psalm 16 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 16 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm16.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm16,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm16,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm16_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  // MARK: - Test Cases

  func testJudicialPetition() {
    let analysis = latinService.analyzePsalm(text: psalm16)

    let legalTerms = [
      ("justitia", ["justitiam"], "justice"),
      ("judicium", ["judicium"], "judgment"),
      ("aequitas", ["aequitatem"], "equity"),
      ("probo", ["Probasti"], "test"),
      ("iniquitas", ["iniquitas"], "injustice"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: legalTerms)
  }

  func testDivineProtection() {
    let analysis = latinService.analyzePsalm(text: psalm16)

    let protectionTerms = [
      ("pupilla", ["pupillam"], "apple [of eye]"),
      ("ala", ["alarum"], "wing"),
      ("framea", ["frameam"], "sword"),
      ("custodio", ["custodivi", "custodi"], "guard"),
      ("protego", ["protege"], "protect"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
  }

  func testLionImagery() {
    let analysis = latinService.analyzePsalm(text: psalm16)

    let lionTerms = [
      ("leo", ["leo", "leonis"], "lion"),
      ("catulus", ["catulus"], "cub"),
      ("praeda", ["praedam"], "prey"),
      ("abditus", ["abditis"], "hidden place"),
      ("supplanto", ["supplanta"], "trip up"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: lionTerms)
  }

  func testBodyMetaphors() {
    let analysis = latinService.analyzePsalm(text: psalm16)

    let bodyTerms = [
      ("adeps", ["adipem"], "fat"), // Symbolizing prosperity
      ("venter", ["venter"], "belly"),
      ("oculus", ["oculi", "oculos"], "eye"),
      ("auris", ["Auribus", "aurem"], "ear"),
      ("labium", ["labiis", "labiorum"], "lip"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
  }

  func testEschatologicalHope() {
    let analysis = latinService.analyzePsalm(text: psalm16)

    let hopeTerms = [
      ("gloria", ["gloria"], "glory"),
      ("satiabor", ["satiabor"], "be satisfied"),
      ("appareo", ["apparebo", "apparuerit"], "appear"),
      ("absconditum", ["absconditis"], "hidden treasures"),
      ("reliquiae", ["reliquias"], "remnants"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: hopeTerms)
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
