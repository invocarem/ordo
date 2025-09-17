@testable import LatinService
import XCTest

class Psalm10Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 10, category: nil)
  private let expectedVerseCount = 8

  // MARK: - Test Data

  private let text = [
    "In Domino confido; quomodo dicitis animae meae: Transvola in montem sicut passer?",
    "Quoniam ecce peccatores intenderunt arcum, paraverunt sagittas suas in pharetra, ut sagittent in obscuro rectos corde.",
    "Quoniam quae perfecisti, destruxerunt: iustus autem quid fecit?",
    "Dominus in templo sancto suo; Dominus in caelo sedes eius.",
    "Oculi eius in pauperem respiciunt; palpebrae eius interrogant filios hominum.",
    "Dominus interrogat iustum et impium; qui autem diligit iniquitatem, odit animam suam.",
    "Pluet super peccatores laqueos; ignis, et sulphur, et spiritus procellarum pars calicis eorum.",
    "Quoniam iustus Dominus, et iustitias dilexit; aequitatem vidit vultus eius.",
  ]

  private let englishText = [
    "In the Lord I put my trust: how say you to my soul: Flee as a bird to your mountain?",
    "For behold the wicked bend their bow; they prepare their arrows in the quiver, to shoot in darkness at the upright in heart.",
    "For they have destroyed what you have perfected: but what has the just man done?",
    "The Lord is in his holy temple, the Lord's throne is in heaven.",
    "His eyes behold the poor man; his eyelids examine the sons of men.",
    "The Lord tests the just and the wicked: but he that loves iniquity hates his own soul.",
    "He shall rain snares upon sinners: fire and brimstone and storms of winds shall be the portion of their cup.",
    "For the Lord is just, and has loved justice: his countenance has beheld righteousness.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "confido", "dico", "anima", "transvolo", "mons", "passer"]),
    (2, ["peccator", "intendo", "arcus", "paro", "sagitta", "pharetra", "sagitto", "obscurus", "rectus", "cor"]),
    (3, ["perficio", "destruo", "iustus", "facio"]),
    (4, ["dominus", "templum", "sanctus", "caelum", "sedes"]),
    (5, ["oculus", "pauper", "respicio", "palpebra", "interrogo", "filius", "homo"]),
    (6, ["dominus", "interrogo", "iustus", "impius", "diligo", "iniquitas", "odi", "anima"]),
    (7, ["pluo", "peccator", "laqueus", "ignis", "sulphur", "spiritus", "procella", "pars", "calix"]),
    (8, ["iustus", "dominus", "iustitia", "diligo", "aequitas", "video", "vultus"]),
  ]

  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "God's authority and dwelling place",
      ["dominus", "templum", "caelum", "sedes"],
      ThemeCategory.divine,
      nil as ClosedRange<Int>?
    ),
    (
      "Divine Justice",
      "God's righteous judgment and testing",
      ["iustus", "iustitia", "aequitas", "interrogo", "video"],
      .justice,
      4 ... 8
    ),
    (
      "Violence and Warfare",
      "Imagery of conflict and weapons",
      ["arcus", "sagitta", "sagitto", "pharetra", "laqueus", "sulphur", "ignis"],
      .conflict,
      2 ... 7
    ),
    (
      "Divine Examination",
      "God's scrutiny and testing of humanity",
      ["oculus", "respicio", "palpebra", "interrogo", "pauper", "homo"],
      .divine,
      4 ... 6
    ),
    (
      "Human Trust and Vulnerability",
      "Human dependence on God",
      ["confido", "anima", "pauper", "transvolo", "passer"],
      .virtue,
      1 ... 5
    ),
    (
      "Sin and Iniquity",
      "Human wickedness and moral failure",
      ["peccator", "iniquitas", "odi", "impius"],
      .sin,
      2 ... 6
    ),
    (
      "Divine Judgment",
      "God's punishment and retribution",
      ["pluo", "laqueus", "ignis", "sulphur", "spiritus", "procella", "calix"],
      .justice,
      7 ... 7
    ),
  ]

  private let structuralThemes = [
    (
      "Trust → Violence",
      "The psalmist's confident trust in God meets the violent schemes of the wicked",
      ["confido", "dominus", "anima", "peccator", "arcus", "sagitta", "obscurus"],
      1,
      2,
      "The psalmist begins with confident trust in the Lord, but immediately confronts the reality of wicked men who prepare weapons to attack the upright in darkness.",
      "Augustine sees this as the contrast between the soul's flight to God (like a bird to the mountain) and the wicked who 'bend their bow' in the darkness of their hearts. The just soul seeks refuge in the Lord while the wicked plot violence (Enarr. Ps. 10.1–2)."
    ),
    (
      "Destruction → Sovereignty",
      "Human wickedness destroys divine works while God remains enthroned in heaven",
      ["perficio", "destruo", "iustus", "dominus", "templum", "caelum", "sedes"],
      3,
      4,
      "The wicked have destroyed what God has perfected, but the just man's response is to acknowledge God's sovereignty in his holy temple and heavenly throne.",
      "Augustine interprets this as the contrast between human wickedness that destroys God's good works and the eternal stability of God's dwelling. The just man recognizes that while men may destroy, God remains enthroned in heaven (Enarr. Ps. 10.3–4)."
    ),
    (
      "Examination → Testing",
      "God's compassionate observation of the poor leads to comprehensive testing of all humanity",
      ["oculus", "pauper", "respicio", "palpebra", "interrogo", "iustus", "impius", "diligo", "iniquitas"],
      5,
      6,
      "God's eyes behold the poor man with compassion, while his eyelids examine all humanity, testing both the just and the wicked, revealing who loves iniquity.",
      "Augustine emphasizes the anthropomorphic imagery of God's eyes and eyelids as symbols of divine omniscience. God 'examines' (interrogat) not with ignorance but with perfect knowledge, distinguishing those who love righteousness from those who love iniquity (Enarr. Ps. 10.5–6)."
    ),
    (
      "Judgment → Justice",
      "Divine punishment rains down on sinners while God's perfect justice is established",
      ["pluo", "laqueus", "ignis", "sulphur", "spiritus", "procella", "iustus", "iustitia", "aequitas", "video"],
      7,
      8,
      "God will rain snares, fire, and brimstone upon sinners, but the Lord is just and loves justice, his countenance beholding righteousness.",
      "Augustine sees this as the final contrast between divine judgment and divine justice. The 'cup' of the wicked contains the portion of their punishment, while the Lord's countenance reflects perfect justice and righteousness (Enarr. Ps. 10.7–8)."
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 10 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 10 English text should have \(expectedVerseCount) verses")
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

  func testConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Test Cases

  func testDivineAttributes() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let divineTerms = [
      ("dominus", ["domino", "dominus"], "lord"),
      ("templum", ["templo"], "temple"),
      ("caelum", ["caelo"], "heaven"),
      ("oculus", ["Oculi"], "eye"),
      ("vultus", ["vultus"], "face"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
  }

  func testHumanConditions() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let humanTerms = [
      ("pauper", ["pauperem"], "poor"),
      ("animus", ["animae", "animam"], "soul"),
      ("homo", ["hominum"], "man"),
      ("cor", ["corde"], "heart"),
      ("peccator", ["peccatores"], "sinner"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: humanTerms)
  }

  func testKeyVerbs() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let keyVerbs = [
      ("confido", ["confido"], "trust"),
      ("interrogo", ["interrogant", "interrogat"], "examine"),
      ("diligo", ["dilexit", "diligit"], "love"),
      ("perficio", ["perfecisti"], "complete"),
      ("destruo", ["destruxerunt"], "destroy"),
      ("pluo", ["Pluet"], "rain"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
  }

  // MARK: - Test Cases

  func testDistinctiveImagery() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let imageTerms = [
      ("passer", ["passer"], "sparrow"),
      ("transvolo", ["Transvola"], "fly"),
      ("obscurus", ["obscuro"], "dark"),
      ("procella", ["procellarum"], "tempest"),
      ("calix", ["calicis"], "cup"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: imageTerms)
  }

  func testDivineJusticeVocabulary() {
    let analysis = utilities.latinService.analyzePsalm(text: text)

    let justiceTerms = [
      ("iustitia", ["iustitias"], "justice"),
      ("aequitas", ["aequitatem"], "equity"),
      ("iniquitas", ["iniquitatem"], "iniquity"),
      ("odi", ["odit"], "hate"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
  }

  func testViolenceImagery() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let violenceTerms = [
      ("arcus", ["arcum"], "bow"),
      ("sagitta", ["sagittas"], "arrow"),
      ("sagitto", ["sagittent"], "arrow"),
      ("pharetra", ["pharetra"], "quiver"),
      ("laqueus", ["laqueos"], "snare"),
      ("sulphur", ["sulphur"], "brimstone"),
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: violenceTerms)
  }

  func testDivineExamination() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let examinationTerms = [
      ("respicio", ["respiciunt"], "look"),
      ("interrogo", ["interrogant", "interrogat"], "examine"),
      ("video", ["vidit"], "see"),
      ("palpebra", ["palpebrae"], "eyelid"), // Significant anthropomorphism
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: examinationTerms)
  }

  func testKeyThematicVerbs() {
    let analysis = utilities.latinService.analyzePsalm(id, text: text)

    let keyVerbs = [
      ("confido", ["confido"], "trust"), // Opening declaration
      ("perficio", ["perfecisti"], "complete"),
      ("destruo", ["destruxerunt"], "destroy"),
      ("diligo", ["dilexit"], "love"), // "justitias dilexit"
      ("pluo", ["Pluet"], "rain"), // Judgment imagery
    ]

    verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
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
      filename: "output_psalm10_themes.json"
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
      filename: "output_psalm10_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
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
