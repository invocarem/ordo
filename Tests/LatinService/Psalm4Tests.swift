import XCTest

@testable import LatinService

class Psalm4Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 4, category: nil)
  private let expectedVerseCount = 10

  // MARK: - Test Data Properties

  private let text = [
    "Cum invocarem exaudivit me Deus iustitiae meae; in tribulatione dilatasti mihi.",
    "Miserere mei, et exaudi orationem meam.",
    "Filii hominum, usquequo gravi corde? ut quid diligitis vanitatem, et quaeritis mendacium?",
    "Et scitote quoniam mirificavit Dominus sanctum suum; Dominus exaudiet me cum clamavero ad eum.",
    "Irascimini, et nolite peccare; quae dicitis in cordibus vestris, in cubilibus vestris compungimini.",
    "Sacrificate sacrificium iustitiae, et sperate in Domino; multi dicunt: Quis ostendit nobis bona?",
    "Signatum est super nos lumen vultus tui, Domine; dedisti laetitiam in corde meo.",
    "A fructu frumenti, vini et olei sui multiplicati sunt.",
    "In pace in idipsum dormiam et requiescam;",
    "Quoniam tu, Domine, singulariter in spe constituisti me.",
  ]

  private let englishText = [
    "When I called upon him, the God of my justice heard me: when I was in distress, thou hast enlarged me.",
    "Have mercy on me: and hear my prayer.",
    "O ye sons of men, how long will ye be dull of heart? why do ye love vanity, and seek after lying?",
    "Know ye also that the Lord hath made his holy one wonderful: the Lord will hear me when I shall cry unto him.",
    "Be ye angry, and sin not: the things ye say in your hearts, be sorry for them upon your beds.",
    "Offer up the sacrifice of justice, and trust in the Lord; many say: Who sheweth us good things?",
    "The light of thy countenance, O Lord, is signed upon us; thou hast given gladness in my heart.",
    "By the fruit of their corn, their wine, and oil, they are multiplied.",
    "In peace in the selfsame I will sleep, and I will rest;",
    "For thou, O Lord, singularly hast settled me in hope.",
  ]

  private let lineKeyLemmas = [
    (1, ["invoco", "exaudio", "deus", "iustitia", "tribulatio", "dilato"]),
    (2, ["misereor", "exaudio", "oratio"]),
    (
      3,
      [
        "filius", "homo", "usquequo", "gravis", "cor", "diligo", "vanitas", "quaero",
        "mendacium",
      ]
    ),
    (4, ["scio", "quoniam", "mirifico", "dominus", "sanctus", "exaudio", "clamo"]),
    (5, ["irascor", "pecco", "dico", "cor", "cubile", "compungo"]),
    (
      6,
      [
        "sacrifico", "sacrificium", "iustitia", "spero", "dominus", "multus", "dico",
        "ostendo", "bonus",
      ]
    ),
    (7, ["signo", "lumen", "vultus", "dominus", "do", "laetitia", "cor"]),
    (8, ["fructus", "frumentum", "vinum", "oleum", "multiplico"]),
    (9, ["pax", "idipsum", "dormio", "requiesco"]),
    (10, ["quoniam", "dominus", "singularis", "spes", "constituo"]),
  ]

  private let structuralThemes = [
    (
      "Invocation → Expansion",
      "God's faithful response to prayer bringing deliverance in distress",
      ["invoco", "exaudio", "iustitia", "tribulatio", "dilato"],
      1,
      2,
      "When called upon, the God of justice hears and answers; in times of trouble He brings enlargement and relief, prompting the psalmist to plead for mercy.",
      "Augustine sees this as the soul's cry to God who justifies. The 'dilatasti' represents God expanding the heart constrained by tribulation, making room for grace and peace."
    ),
    (
      "Admonition → Recognition",
      "Exhortation to turn from vanity to acknowledge God's wondrous works",
      ["gravis", "vanitas", "mendacium", "mirifico", "sanctus"],
      3,
      4,
      "The psalmist questions how long people will remain heavy-hearted, loving emptiness and seeking lies, urging them to know that God has shown wondrous favor to His faithful one.",
      "For Augustine, the 'gravi corde' signifies souls weighed down by sin rather than lifted by God. The 'sanctum suum' prefigures Christ, the Holy One through whom God works marvels."
    ),
    (
      "Examination → Sacrifice",
      "Inner reflection leading to righteous offering and trust in God",
      ["irascor", "compungo", "sacrificium", "iustitia", "spero"],
      5,
      6,
      "Holy anger directed at one's own sin leads to compunction, the sacrifice of the old life, and the fundamental question: where is true good to be found?",
      "Augustine interprets this as righteous anger against sin, leading to compunction and conversion. The 'sacrificium iustitiae' is the offering of a contrite heart, which replaces mere ritual sacrifice."
    ),
    (
      "Favor → Gladness",
      "The light of God's countenance bringing joy and abundance to the heart",
      ["signo", "lumen", "vultus", "fructus", "multiplico"],
      7,
      8,
      "The light of God's face is signed upon us, giving gladness of heart greater than any material abundance from grain, wine, and oil.",
      "Augustine sees the 'lumen vultus tui' as the light of God's countenance in Christ. The joy He gives is spiritual and interior, surpassing all earthly increase and temporal blessings."
    ),
    (
      "Provision → Peace",
      "Divine provision yielding multiplication and resulting in perfect peace and rest",
      ["pax", "idipsum", "dormio", "requiesco", "constituo"],
      9,
      10,
      "From God's provision comes multiplication; in perfect peace and unity I will lie down and sleep, for the Lord alone establishes me in hope.",
      "Augustine interprets 'in pace in idipsum' as the peace and unity found in the Body of Christ. The sleep is one of trust, and the hope is singularly placed in God, who alone establishes the soul in safety."
    ),
  ]

  private let conceptualThemes = [
    (
      "Prayer and Response",
      "God hearing and answering prayers",
      ["invoco", "exaudio", "oratio", "misereor"],
      ThemeCategory.worship,
      1 ... 2
    ),
    (
      "Trust and Hope",
      "Trusting in God and finding hope",
      ["spero", "spes", "constituo", "requiesco", "pax", "dormio"],
      .virtue,
      6 ... 10
    ),
    (
      "Divine Provision",
      "God's material blessings and provision",
      ["dilato", "fructus", "frumentum", "vinum", "oleum", "multiplico"],
      .divine,
      1 ... 8
    ),
    (
      "Divine Favor",
      "God's grace, light, and joyful presence",
      ["signo", "lumen", "vultus", "laetitia"],
      .divine,
      7 ... 7
    ),
    (
      "Christological Fulfillment",
      "References to Christ as the ultimate Good and resurrection",
      ["bonus", "sanctus", "mirifico"],
      .divine,
      4 ... 6
    ),
    (
      "Heart Examination",
      "Examination of inner thoughts and repentance",
      ["compungo", "cubile", "dico", "irascor", "pecco"],
      .virtue,
      3 ... 6
    ),
    (
      "Human Folly",
      "Human tendency toward vanity, falsehood, and spiritual heaviness",
      ["vanitas", "mendacium", "gravis", "diligo", "quaero"],
      .sin,
      3 ... 3
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 4 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 4 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  // MARK: - Line by Line Key Lemmas Test

  func testPsalm4LineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm4StructuralThemes() {
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

  func testPsalm4ConceptualThemes() {
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
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
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
      filename: "output_psalm4_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testSavePsalm4Themes() {
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
      filename: "output_psalm4_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
