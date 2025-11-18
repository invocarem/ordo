@testable import LatinService
import XCTest

class Psalm54Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 54, category: nil)
  private let expectedVerseCount = 27

  // MARK: - Test Data

  private let text = [
    "Exaudi, Deus, orationem meam, et ne despexeris deprecationem meam; intende mihi, et exaudi me.",
    "Contristatus sum in exercitatione mea, et conturbatus sum a voce inimici, et a tribulatione peccatoris.",
    "Quoniam declinaverunt in me iniquitates, et in ira molesti erant mihi.",
    "Cor meum conturbatum est in me, et formido mortis cecidit super me.",
    "Timor et tremor venerunt super me, et contexerunt me tenebrae.",
    "Et dixi: Quis dabit mihi pennas sicut columbae, et volabo, et requiescam?",
    "Ecce elongavi fugiens, et mansi in solitudine.",
    "Expectabam eum qui me salvum faceret a pusillanimitate spiritus et tempestate.",
    "Praecipita, Domine, divide linguas eorum; quoniam vidi iniquitatem et contradictionem in civitate.",
    "Die ac nocte circumdabit eam super muros eius iniquitas; et labor in medio eius, et iniustitia.",
    "Et non defecit de plateis eius usura et dolus.",
    "Quoniam si inimicus meus maledixisset mihi, sustinuissem utique;",
    "Et si is qui oderat me super me magna locutus fuisset, abscondissem me forsitan ab eo;",
    "Tu vero, homo unanimis, dux meus, et notus meus;",
    "qui simul mecum dulces capiebas cibos; in domo Dei ambulavimus cum consensu.",
    "Veniat mors super illos, et descendant in infernum viventes;",
    "Quoniam nequitiae in habitaculis eorum, in medio eorum.",
    "Ego autem ad Deum clamavi; et Dominus salvabit me.",
    "Vespere, et mane, et meridie, narrabo et annuntiabo; et exaudiet vocem meam.",
    "Redimet in pace animam meam ab his qui appropinquant mihi; quoniam inter multos erant mecum.",
    "Exaudiet Deus, et humiliabit illos, qui est ante saecula;",
    "Non enim est illis commutatio, et non timuerunt Deum.",
    "Extendit manum suam in retribuendo; contaminaverunt testamentum eius;",
    "Molliti sunt sermones eius super oleum, et ipsi sunt iacula.",
    "Iacta super Dominum curam tuam, et ipse te enutriet; non dabit in aeternum fluctuationem iusto.",
    "Tu vero, Deus, deduces eos in puteum interitus;",
    "viri sanguinum et dolosi non dimidiabunt dies suos; ego autem sperabo in te, Domine."
  ]

  private let englishText = [
    "Hear, O God, my prayer, and despise not my supplication; be attentive to me, and hear me.",
    "I am grieved in my exercise, and am troubled at the voice of the enemy, and at the tribulation of the sinner.",
    "For they have cast iniquities upon me, and in wrath they were troublesome to me.",
    "My heart is troubled within me, and the fear of death is fallen upon me.",
    "Fear and trembling are come upon me, and darkness hath covered me.",
    "And I said: Who will give me wings like a dove, and I will fly and be at rest?",
    "Lo, I have gone far off flying away, and I abode in the wilderness.",
    "I waited for him that hath saved me from faintness of spirit, and from the storm.",
    "Cast down, O Lord, and divide their tongues; for I have seen iniquity and contradiction in the city.",
    "Day and night shall iniquity surround it upon its walls: and in the midst thereof are labour,",
    "And injustice. And usury and deceit have not departed from its streets.",
    "For if my enemy had reviled me, I would verily have borne with it.",
    "And if he that hated me had spoken great things against me, I would perhaps have hidden myself from him.",
    "But thou a man of one mind, my guide, and my familiar,",
    "Who didst take sweetmeats together with me: in the house of God we walked with consent.",
    "Let death come upon them, and let them go down alive into hell.",
    "For there is wickedness in their dwellings: in the midst of them.",
    "But I have cried to God: and the Lord will save me.",
    "Evening and morning, and at noon I will speak and declare: and he shall hear my voice.",
    "He shall redeem my soul in peace from them that draw near to me: for among many they were with me.",
    "God shall hear, and the Eternal shall humble them.",
    "For there is no change with them, and they have not feared God:",
    "He hath stretched forth his hand to repay. They have defiled his covenant;",
    "His words are smoother than oil, and the same are darts.",
    "Cast thy care upon the Lord, and he shall sustain thee: he shall not suffer the just to waver for ever.",
    "But thou, O God, shalt bring them down into the pit of destruction.",
    "Bloody and deceitful men shall not live out half their days; but I will trust in thee, O Lord."
  ]

  private let lineKeyLemmas = [
    (1, ["exaudio", "deus", "oratio", "despicio", "deprecatio", "intendo"]),
    (2, ["contristo", "exercitatio", "conturbo", "vox", "inimicus", "tribulatio", "peccator"]),
    (3, ["declino", "iniquitas", "ira", "molestus"]),
    (4, ["cor", "conturbo", "formido", "mors", "cecideo", "super"]),
    (5, ["timor", "tremor", "venio", "tenebrae", "contexo"]),
    (6, ["dico", "dare", "penna", "columba", "volo", "requiesco"]),
    (7, ["elongo", "fugio", "maneo", "solitudo"]),
    (8, ["expecto", "salvo", "facio", "pusillanimitas", "spiritus", "tempestas"]),
    (9, ["praecipio", "dominus", "divido", "lingua", "iniquitas", "contradictio", "civitas"]),
    (10, ["dies", "nox", "circumdare", "murus", "iniquitas", "labor", "iniustitia"]),
    (11, ["deficio", "platea", "usura", "dolus"]),
    (12, ["inimicus", "maledico", "sustineo"]),
    (13, ["odi", "loquor", "abscondo"]),
    (14, ["homo", "unus", "dux", "notus"]),
    (15, ["simul", "dulcis", "capio", "cibus", "domus", "deus", "ambulo", "consensus"]),
    (16, ["mors", "descendo", "infernum", "vivo"]),
    (17, ["nequitia", "habitaculum", "medius"]),
    (18, ["ego", "clamo", "deus", "dominus", "salvo"]),
    (19, ["vesper", "mane", "meridies", "narro", "annuntio", "exaudio", "vox"]),
    (20, ["redimo", "pax", "anima", "appropinquo", "inter", "multus"]),
    (21, ["exaudio", "deus", "humilio", "ante", "saeculum"]),
    (22, ["commutatio", "timeo", "deus"]),
    (23, ["extendo", "manus", "retribuo", "contamino", "testamentum"]),
    (24, ["mollis", "sermo", "oleum", "iaculum"]),
    (25, ["iacio", "dominus", "cura", "enutrio", "dare", "aevum", "fluctus", "iustus"]),
    (26, ["deus", "deduco", "puteum", "interitus"]),
    (27, ["vir", "sanguis", "dolosus", "dimido", "dies", "spero", "dominus"])
  ]

  private let structuralThemes: [(String, String, [String], Int, Int, String, String)] = []

  private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = []

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 54 should have \\(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 54 English text should have \\(expectedVerseCount) verses")
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
      filename: "output_psalm54_themes.json"
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
      filename: "output_psalm54_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
