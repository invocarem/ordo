@testable import LatinService
import XCTest

class Psalm27Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 27, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 12

  // verse 9: dominus fortitudeo mea (in other place: dominus adiutor meus)
  private let text = [
    "Ad te, Domine, clamabo, Deus meus, ne sileas a me: ne quando taceas a me, et assimilabor descendentibus in lacum.",
    "Exaudi vocem deprecationis meae dum oro ad te, dum extollo manus meas ad templum sanctum tuum.",
    "Ne simul trahas me cum peccatoribus, et cum operantibus iniquitatem ne perdas me.",
    "Qui loquuntur pacem cum proximo suo, mala autem in cordibus eorum.",
    "Da illis secundum opera eorum, et secundum nequitiam adinventionum ipsorum.",

    "Secundum opera manuum eorum tribue illis, redde retributionem eorum ipsis.",
    "Quoniam non intellexerunt opera Domini, et in opera manuum eius destrues illos, et non aedificabis eos.",
    "Benedictus Dominus, quoniam exaudivit vocem deprecationis meae.",
    "Dominus fortitudo mea, et protector meus: in ipso speravit cor meum, et adiutus sum.",
    "Et refloruit caro mea: et ex voluntate mea confitebor ei.",

    "Dominus fortitudo plebis suae, et protector salvationum christi sui est.",
    "Salvum fac populum tuum, Domine, et benedic haereditati tuae, et rege eos, et extolle illos usque in aeternum.",
  ]

  private let englishText = [
    "To thee, O Lord, will I cry: O my God, be not thou silent to me: lest if thou be silent to me, I become like them that go down into the pit.",
    "Hear the voice of my supplication when I pray to thee, when I lift up my hands to thy holy temple.",
    "Draw me not away together with sinners, and with the workers of iniquity destroy me not.",
    "Who speak peace with their neighbour, but evils are in their hearts.",
    "Give them according to their works, and according to the wickedness of their devices.",
    "According to the works of their hands give thou to them, render to them their reward.",
    "Because they have not understood the works of the Lord, and the operations of his hands: thou shalt destroy them, and shalt not build them up.",
    "Blessed be the Lord, for he hath heard the voice of my supplication.",
    "The Lord is my strength and my shield: in him hath my heart trusted, and I have been helped.",
    "And my flesh hath flourished again: and with my will I will give praise to him.",
    "The Lord is the strength of his people, and the protector of the salvation of his anointed.",
    "Save thy people, O Lord, and bless thy inheritance: and rule them, and exalt them for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["clamo", "dominus", "deus", "sileo", "taceo", "assimilo", "descendo", "lacus"]),
    (2, ["exaudio", "vox", "deprecatio", "oro", "extollo", "manus", "templum", "sanctus"]),
    (3, ["traho", "peccator", "opero", "iniquitas", "perdo"]),
    (4, ["loquor", "pax", "proximus", "malus", "cor"]),
    (5, ["do", "secundum", "opus", "nequitia", "adinventio"]),
    (6, ["secundum", "opus", "manus", "tribuo", "reddo", "retributio"]),
    (7, ["quoniam", "intellego", "opus", "dominus", "manus", "destruo", "aedifico"]),
    (8, ["benedictus", "dominus", "exaudio", "vox", "deprecatio"]),
    (9, ["dominus", "fortitudo", "protector", "spero", "cor", "adiuvo"]),
    (10, ["refloreo", "caro", "voluntas", "confiteor"]),
    (11, ["dominus", "fortitudo", "plebs", "protector", "salvatio", "christus"]),
    (12, ["salvus", "facio", "populus", "dominus", "benedico", "haereditas", "rego", "extollo", "aeternus"]),
  ]

  private let structuralThemes = [
    (
      "Cry for Help → Supplication in Temple",
      "The psalmist's cry to God not to be silent, followed by supplication with hands lifted to the holy temple",
      ["clamo", "sileo", "taceo", "assimilo", "exaudio", "deprecatio", "extollo", "templum"],
      1,
      2,
      "The psalmist cries to the Lord not to be silent lest he become like those going down to the pit, then asks God to hear his supplication when he prays and lifts his hands to the holy temple.",
      "Augustine sees this as the soul's urgent plea for divine attention, where the psalmist's fear of divine silence drives him to earnest prayer and ritual supplication in the sacred space."
    ),
    (
      "Separation from Sinners → Hypocrisy Exposed",
      "Prayer not to be drawn away with sinners, then exposing the hypocrisy of those who speak peace but have evil hearts",
      ["traho", "peccator", "opero", "iniquitas", "perdo", "loquor", "pax", "proximus", "malus", "cor"],
      3,
      4,
      "The psalmist asks not to be drawn away with sinners or destroyed with workers of iniquity, then describes those who speak peace with their neighbors but have evil in their hearts.",
      "For Augustine, this represents the soul's recognition of the need for divine protection from evil company and the exposure of hypocritical behavior that masks inner corruption."
    ),
    (
      "Divine Retribution → Works and Hands",
      "Prayer for divine retribution according to works, then describing how God will destroy those who don't understand His works",
      ["do", "secundum", "opus", "nequitia", "tribuo", "reddo", "retributio", "intellego", "manus", "destruo", "aedifico"],
      5,
      6,
      "The psalmist asks God to give sinners according to their works and the wickedness of their devices, then describes how God will destroy those who don't understand His works and not build them up.",
      "Augustine sees this as the soul's understanding of divine justice, where God's retribution is proportional to human actions and those who reject divine wisdom face destruction rather than building up."
    ),
    (
      "Destruction of Ununderstanding → Blessed Response",
      "God destroying those who don't understand His works, then the psalmist blessing the Lord for hearing his supplication",
      ["quoniam", "intellego", "opus", "manus", "destruo", "aedifico", "benedictus", "exaudio", "deprecatio"],
      7,
      8,
      "The psalmist explains that because they didn't understand the Lord's works, God will destroy them and not build them up, then blesses the Lord for hearing his supplication.",
      "For Augustine, this represents the soul's understanding of divine judgment against those who reject God's wisdom, leading to grateful recognition of God's responsiveness to prayer."
    ),
    (
      "Personal Strength → Flesh Flourishing",
      "The psalmist declaring the Lord as his personal strength and protector, then describing how his flesh has flourished and he will confess praise",
      ["fortitudo", "protector", "spero", "cor", "adiuvo", "refloreo", "caro", "voluntas", "confiteor"],
      9,
      10,
      "The psalmist declares that the Lord is his strength and protector, in whom his heart trusts and by whom he has been helped, then describes how his flesh has flourished again and he will confess praise with his will.",
      "For Augustine, this represents the soul's recognition of divine strength and protection leading to physical renewal and voluntary praise."
    ),
    (
      "Lord's Strength for People → Salvation Prayer",
      "The Lord as strength of His people and protector of His anointed, leading to prayer for salvation and eternal blessing",
      ["fortitudo", "plebs", "protector", "salvatio", "christus", "salvus", "facio", "populus", "benedico", "haereditas", "rego", "extollo", "aeternus"],
      11,
      12,
      "The psalmist declares that the Lord is the strength of His people and protector of the salvation of His anointed, then prays for God to save His people and bless His inheritance, ruling and exalting them forever.",
      "For Augustine, this represents the soul's recognition of God's role as protector of His chosen people, leading to prayer for communal salvation and eternal blessing."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Communication and Response",
      "References to crying, hearing, supplication, and divine response to prayer",
      ["clamabo", "sileo", "taceo", "exaudio", "deprecatio", "oro", "extollo"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Divine Protection and Strength",
      "References to God as protector, strength, shield, and source of help",
      ["protector", "fortitudo", "adiuvo", "salvus", "facio"],
      ThemeCategory.divine,
      8 ... 12
    ),
    (
      "Sin and Iniquity",
      "References to sinners, workers of iniquity, wickedness, and evil hearts",
      ["peccator", "opero", "iniquitas", "nequitia", "malus"],
      ThemeCategory.sin,
      3 ... 6
    ),
    (
      "Divine Justice and Retribution",
      "References to works, retribution, destruction, and divine judgment",
      ["opus", "secundum", "tribuo", "reddo", "retributio", "destruo", "aedifico"],
      ThemeCategory.divine,
      5 ... 7
    ),
    (
      "Praise and Confession",
      "References to blessing, confession, praise, and thanksgiving",
      ["benedictus", "confiteor", "benedico", "extollo"],
      ThemeCategory.worship,
      8 ... 12
    ),
    (
      "Physical and Spiritual Renewal",
      "References to flesh, flourishing, heart, and physical/spiritual restoration",
      ["refloreo", "caro", "voluntas", "cor", "spero"],
      ThemeCategory.virtue,
      9 ... 10
    ),
    (
      "People and Inheritance",
      "References to people, inheritance, rule, and communal blessing",
      ["populus", "haereditas", "rego", "plebs", "christus"],
      ThemeCategory.divine,
      11 ... 12
    ),
    (
      "Eternal Duration",
      "References to eternal rule, exaltation, and perpetual blessing",
      ["aeternus", "extollo", "rego"],
      ThemeCategory.divine,
      12 ... 12
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 27 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 27 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm27_texts.json"
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
      filename: "output_psalm27_themes.json"
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
