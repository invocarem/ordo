import XCTest

@testable import LatinService

class Psalm119Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 119, category: nil)
  private let expectedVerseCount = 6

  // MARK: - Test Data Properties

  private let psalm119 = [
    "Ad Dominum cum tribularer clamavi, et exaudivit me.",
    "Domine, libera anima mea a labiis iniquis, et a lingua dolosa.",
    "Quid detur tibi, aut quid apponatur tibi ad linguam dolosam?",
    "Sagittae potentis acutae, cum carbonibus desolatoriis.",
    "Heu mihi, quia incolatus meus prolongatus est: habitavi cum habitantibus Cedar: multum incola fuit anima mea.",
    "Cum his, qui oderunt pacem, ego pacem quaerebam: et cum loquerer illis, impugnabant me gratis.",
  ]

  private let englishText = [
    "To the Lord, when I was in tribulation, I cried out: and he heard me.",
    "O Lord, deliver my soul from wicked lips, and a deceitful tongue.",
    "What shall be given to thee, or what shall be added to thee, against a deceitful tongue?",
    "The sharp arrows of the mighty, with coals that lay waste.",
    "Woe is me, that my sojourning is prolonged: I have dwelt with the inhabitants of Cedar, long hath my soul been a sojourner.",
    "With them that hate peace, I sought peace: and when I spoke thereof to them, they fought against me without cause.",
  ]

  private let lineKeyLemmas = [
    (1, ["ad", "dominus", "tribulor", "clamo", "exaudio"]),
    (2, ["dominus", "libero", "anima", "labium", "iniquus", "lingua", "dolosus"]),
    (3, ["quis", "do", "appono", "lingua", "dolosus"]),
    (4, ["sagitta", "potens", "acutus", "carbo", "desolatorius"]),
    (
      5,
      [
        "heu", "incolatus", "prolongo", "habito", "cedar", "multus", "incola",
        "anima",
      ]
    ),
    (6, ["cum", "odi", "pax", "quaero", "loquor", "impugno", "gratis"]),
  ]

  private let structuralThemes = [
    (
      "Distress → Deliverance",
      "From inner affliction to divine liberation from deceit",
      ["tribulor", "clamo", "exaudio", "libero", "labium", "iniquus", "lingua", "dolosus"],
      1,
      2,
      "The psalmist begins with a cry to the Lord in time of trouble and receives assurance of being heard, followed by a specific plea for deliverance from deceitful lips and a lying tongue.",
      "Augustine sees this as the cry of the soul caught in inner tribulation, not just external hardship. The deceitful tongue symbolizes confusion and heresy. God hears, not to shield physically, but to deliver the soul through truth. The movement from anguish to 'libera animam meam' marks grace's work in pulling the soul out of lies and into light (Enarr. Ps. 119.1–2)."
    ),
    (
      "Deception → Purifying Judgment",
      "The harm of lies is answered by divine fire and piercing correction",
      ["do", "appono", "lingua", "sagitta", "potens", "acutus", "carbo", "desolatorius"],
      3,
      4,
      "The psalmist asks what punishment fits a deceitful tongue, answering with the metaphor of a warrior's sharp arrows and the desolating coals of juniper.",
      "Augustine reads these verses as the divine response to false speech. The tongue, which wounds through deceit, will receive 'sharp arrows' and 'desolating coals.' But these are not simply for destruction: they are purifying instruments. The 'coals' represent the burning power of charity, which scorches away sin and heals the deceived (Enarr. Ps. 119.3–5)."
    ),
    (
      "Exile → Conflict",
      "Dwelling long among the ungodly deepens the soul's sorrow",
      ["heu", "incolatus", "prolongo", "cedar", "incola", "impugno", "gratis"],
      5,
      6,
      "'Heu mihi' is Augustine's sigh of the pilgrim soul exiled from its true home. To live in Kedar — a symbol of those who live in the flesh — is to be surrounded by hostility toward peace. The soul has dwelt too long here, not because of years, but because it feels the pain of separation from the City of God.",
      "Augustine interprets this verse as the voice of Christ and His Church: always seeking peace, yet constantly met with opposition. The psalmist speaks kindly, yet is attacked 'gratis' — without cause. This unjust suffering anticipates the passion of Christ, who was hated for no reason."
    ),
  ]

  private let conceptualThemes = [
    // IMAGERY THEMES
    (
      "Weapon Imagery",
      "Military metaphors for divine correction and judgment",
      ["sagitta", "carbo", "potens", "acutus", "desolatorius"],
      ThemeCategory.conflict,
      4 ... 4
    ),
    (
      "Geographical Exile",
      "Physical and spiritual displacement from home",
      ["cedar", "incolatus", "prolongo", "habito", "incola"],
      ThemeCategory.opposition,
      5 ... 5
    ),
    (
      "Linguistic Imagery",
      "Speech and communication metaphors for deceit",
      ["labium", "lingua", "loquor", "dolosus"],
      ThemeCategory.sin,
      2 ... 6
    ),
    (
      "Persecution Terms",
      "Vocabulary of affliction and unjust attack",
      ["tribulor", "iniquus", "impugno", "desolatorius"],
      ThemeCategory.sin,
      1 ... 6
    ),
    (
      "Peaceful Image",
      "Terms representing peace and liberation",
      ["libero", "pax", "quaero"],
      ThemeCategory.virtue,
      1 ... 6
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      psalm119.count, expectedVerseCount, "Psalm 119 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 119 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm119.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm119,
      "Normalized Latin text should match expected classical forms"
    )
  }

  // MARK: - Line by Line Key Lemmas Test

  func testLineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm119,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: psalm119,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: psalm119,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  // MARK: - Test Cases


  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm119,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm119_texts.json"
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
      filename: "output_psalm119_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  // MARK: - Helper

  private func verifyWordsInAnalysis(
    _ analysis: PsalmAnalysisResult,
    confirmedWords: [(
      lemma: String,
      forms: [String],
      translation: String
    )]
  ) {
    for (lemma, forms, translation) in confirmedWords {
      guard let entry = analysis.dictionary[lemma] else {
        XCTFail("Missing lemma: \(lemma)")
        continue
      }

      // Verify semantic domain through translation
      XCTAssertTrue(
        entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
        "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
      )

      // Verify morphological coverage
      let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
      if !missingForms.isEmpty {
        XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
      }

      // NEW: Verify each form's grammatical analysis
      for form in forms {
        if let entity = entry.entity {
          let result = entity.analyzeFormWithMeaning(form)

          // Check if analysis contains either:
          // 1. The exact translation we expect
          // 2. Or appropriate grammatical markers
          XCTAssertTrue(
            result.lowercased().contains(translation.lowercased())
              || result.lowercased().contains("verb")
              || result.lowercased().contains("participle")
              || result.lowercased().contains("noun"),
            """
            For form '\(form)' of lemma '\(lemma)':
            Expected analysis to contain '\(translation)' or grammatical info,
            but got: \(result)
            """
          )

          if verbose {
            print("  Analysis of '\(form)': \(result)")
          }
        } else {
          XCTFail("Entity for lemma '\(lemma)' not found")
        }
      }

      if verbose {
        print("\n\(lemma.uppercased())")
        print("  Translation: \(entry.translation ?? "?")")
        print(
          "  Forms found: \(entry.forms.keys.filter { forms.map { $0.lowercased() }.contains($0) }.count)/\(forms.count)"
        )
        for form in forms {
          let count = entry.forms[form.lowercased()] ?? 0
          print(
            "  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")"
          )
        }
      }
    }
  }
}
