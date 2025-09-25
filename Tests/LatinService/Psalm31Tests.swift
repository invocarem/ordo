import XCTest

@testable import LatinService

class Psalm31Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 31, category: nil)
  private let expectedVerseCount = 14

  // MARK: - Test Data

  private let text = [
    "Beati quorum remissae sunt iniquitates, et quorum tecta sunt peccata.",
    "Beatus vir, cui non imputavit Dominus peccatum, nec est in spiritu eius dolus.",
    "Quoniam tacui, inveteraverunt ossa mea, dum clamarem tota die.",
    "Quoniam die ac nocte gravata est super me manus tua; conversus sum in aerumna mea, dum configitur spina.",
    "Delictum meum cognitum tibi feci, et iniustitiam meam non abscondi.",
    "Dixi: Confitebor adversum me iniustitiam meam Domino; et tu remisisti impietatem peccati mei.",
    "Pro hac orabit ad te omnis sanctus in tempore opportuno.",
    "Verumtamen in diluvio aquarum multarum, ad eum non approximabunt.",
    "Tu es refugium meum a tribulatione, quae circumdedit me; exsultatio mea, erue me a circumdantibus me.",
    "Intellectum tibi dabo, et instruam te in via hac, qua gradieris; firmabo super te oculos meos.",
    "Nolite fieri sicut equus et mulus, quibus non est intellectus; in camo et freno maxillas eorum constringe, qui non approximant ad te.",
    "In camo et freno maxillas eorum constringe, qui non adproximant ad te.",
    "Multa flagella peccatoris; sperantem autem in Domino misericordia circumdabit.",
    "Laetamini in Domino et exsultate, iusti; et gloriamini, omnes recti corde.",
  ]

  private let englishText = [
    "Blessed are they whose iniquities are forgiven, and whose sins are covered.",
    "Blessed is the man to whom the Lord hath not imputed sin, and in whose spirit there is no guile.",
    "Because I was silent, my bones grew old; whilst I cried out all the day long.",
    "For day and night thy hand was heavy upon me: I am turned in my anguish, whilst the thorn is fastened.",
    "I have acknowledged my sin to thee, and my injustice I have not concealed.",
    "I said I will confess against myself my injustice to the Lord: and thou hast forgiven the wickedness of my sin.",
    "For this shall every one that is holy pray to thee in a seasonable time.",
    "Yet in a flood of many waters, they shall not come nigh unto him.",
    "Thou art my refuge from the trouble which hath encompassed me: my joy, deliver me from them that surround me.",
    "I will give thee understanding, and I will instruct thee in this way, in which thou shalt go: I will fix my eyes upon thee.",
    "Do not become like the horse and the mule, who have no understanding: with bit and bridle bind fast their jaws, who come not near unto thee.",
    "With bit and bridle bind fast their jaws, who come not near unto thee.",
    "Many are the scourges of the sinner, but mercy shall encompass him that hopeth in the Lord.",
    "Be glad in the Lord, and rejoice, ye just, and glory, all ye right of heart.",
  ]

  private let lineKeyLemmas = [
    (1, ["beatus", "remitto", "iniquitas", "tego", "peccatum"]),
    (2, ["beatus", "vir", "imputo", "dominus", "peccatum", "spiritus", "dolus"]),
    (3, ["taceo", "invetero", "os", "clamo", "dies"]),
    (4, ["dies", "nox", "gravo", "manus", "converto", "aerumna", "configo", "spina"]),
    (5, ["delictum", "cognosco", "iniustitia", "abscondo"]),
    (
      6,
      ["dico", "confiteor", "adversus", "iniustitia", "dominus", "remitto", "impietas", "peccatum"]
    ),
    (7, ["oro", "sanctus", "tempus", "opportunus"]),
    (8, ["diluvium", "aqua", "multus", "approximo"]),
    (9, ["refugium", "tribulatio", "circumdo", "exsultatio", "eruo"]),
    (10, ["intellectus", "instruo", "via", "gradior", "firmo", "oculus"]),
    (
      11,
      ["equus", "mulus", "intellectus", "camus", "frenum", "maxilla", "constringo", "approximo"]
    ),
    (12, ["camus", "frenum", "maxilla", "constringo", "approximo"]),
    (13, ["multus", "flagellum", "peccator", "spero", "dominus", "misericordia", "circumdo"]),
    (14, ["laetor", "dominus", "exsulto", "iustus", "glorior", "rectus", "cor"]),
  ]

  private let structuralThemes = [
    (
      "Blessedness → Blessedness",
      "From the blessedness of forgiveness to the blessedness of the innocent",
      ["beatus", "remitto", "iniquitas", "peccatum", "imputo", "spiritus", "dolus"],
      1,
      2,
      "The psalm opens with the blessedness of those whose sins are forgiven and covered, then describes the blessedness of the man to whom the Lord has not imputed sin.",
      "Augustine sees this as the foundation of Christian blessedness: forgiveness of sins through divine grace. The blessed one is marked by both forgiveness and innocence of spirit (Enarr. Ps. 31.1-2)."
    ),
    (
      "Silence → Confession",
      "From the torment of unconfessed sin to the relief of confession and forgiveness",
      ["taceo", "invetero", "os", "clamo", "gravo", "manus", "aerumna", "confiteor", "remitto"],
      3,
      6,
      "The psalmist describes the physical and spiritual torment of keeping silent about sin, then moves to the confession of sins and the experience of divine forgiveness.",
      "Augustine emphasizes that unconfessed sin causes spiritual and physical decay. True confession brings immediate relief and divine pardon (Enarr. Ps. 31.3-6)."
    ),
    (
      "Instruction → Wisdom",
      "From divine teaching to practical wisdom for life",
      [
        "oro", "sanctus", "refugium", "tribulatio", "intellectus", "instruo", "via", "equus",
        "mulus", "camus", "frenum",
      ],
      7,
      12,
      "The psalm continues with God's promise to instruct and guide, and warns against becoming like unthinking animals that need to be restrained.",
      "Augustine sees this as God's promise to teach the way of righteousness. These verses warn against spiritual stubbornness and call for willing submission to divine guidance (Enarr. Ps. 31.7-12)."
    ),
    (
      "Mercy → Joy",
      "From divine mercy to joyful praise",
      [
        "flagellum", "peccator", "spero", "misericordia", "circumdo", "laetor", "exsulto", "iustus",
        "glorior",
      ],
      13,
      14,
      "The psalm concludes with a contrast between the sinner's punishment and the mercy that surrounds those who hope in the Lord, culminating in joyful praise.",
      "Augustine emphasizes that while sinners face many scourges, those who trust in the Lord are surrounded by mercy and called to rejoice (Enarr. Ps. 31.13-14)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Forgiveness",
      "God's pardon and mercy",
      ["remitto", "iniquitas", "peccatum", "imputo", "confiteor", "remitto", "impietas"],
      ThemeCategory.divine,
      nil as ClosedRange<Int>?
    ),
    (
      "Blessedness",
      "The state of being blessed",
      ["beatus", "vir", "spiritus", "dolus"],
      .virtue,
      1...2
    ),
    (
      "Confession and Repentance",
      "Acknowledgment of sin and turning to God",
      ["taceo", "confiteor", "adversus", "iniustitia", "cognosco", "abscondo"],
      .sin,
      3...6
    ),
    (
      "Divine Instruction",
      "God's teaching and guidance",
      ["intellectus", "instruo", "via", "gradior", "firmo", "oculus", "camus", "frenum"],
      .divine,
      7...12
    ),
    (
      "Human Suffering",
      "Physical and spiritual distress",
      ["invetero", "os", "gravo", "manus", "aerumna", "configo", "spina"],
      .sin,
      3...4
    ),
    (
      "Prayer and Worship",
      "Communication with God",
      ["oro", "sanctus", "tempus", "opportunus"],
      .worship,
      7...7
    ),
    (
      "Divine Protection",
      "God as refuge in trouble",
      ["refugium", "tribulatio", "circumdo", "exsultatio", "eruo"],
      .divine,
      8...9
    ),
    (
      "Spiritual Stubbornness",
      "Resistance to divine guidance",
      ["equus", "mulus", "intellectus", "camus", "frenum", "constringo"],
      .sin,
      11...12
    ),
    (
      "Divine Mercy and Joy",
      "God's mercy and the joy of the righteous",
      [
        "flagellum", "peccator", "spero", "misericordia", "circumdo", "laetor", "exsulto", "iustus",
        "glorior",
      ],
      .divine,
      13...14
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 31 should have \(expectedVerseCount) verses")
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 31 English text should have \(expectedVerseCount) verses")
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
      psalmText: text,
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
      failOnMissing: false  // Conceptual themes may have additional imagery lemmas
    )

    // Then run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
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
      filename: "output_psalm31_themes.json"
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
      filename: "output_psalm31_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
