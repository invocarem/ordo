@testable import LatinService
import XCTest

class Psalm15Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 15, category: "")

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  private let expectedVerseCount = 11

  private let text = [
    "Conserva me, Domine, quoniam in te speravi; Dixi Domino: Deus meus es tu, quoniam bonorum meorum non eges.",
    "Sanctis qui sunt in terra eius, mirificavit omnes voluntates meas in eis.",
    "Multiplicatae sunt infirmitates eorum; postea acceleraverunt.",
    "Non congregabo conventicula eorum de sanguinibus, nec memor ero nominum eorum per labia mea.",
    "Dominus pars hereditatis meae, et calicis mei: tu es qui restitues hereditatem meam mihi.",

    "Funes ceciderunt mihi in praeclaris; etenim hereditas mea praeclara est mihi.",
    "Benedicam Dominum qui tribuit mihi intellectum; insuper et usque ad noctem increpuerunt me renes mei.",
    "Providebam Dominum in conspectu meo semper: quoniam a dextris est mihi, ne commovear.",
    "Propter hoc laetatum est cor meum, et exsultavit lingua mea: insuper et caro mea requiescet in spe.",
    "Quoniam non derelinques animam meam in inferno, nec dabis sanctum tuum videre corruptionem.",

    "Notas mihi fecisti vias vitae; adimplebis me laetitia cum vultu tuo: delectationes in dextera tua usque in finem.",
  ]

  private let englishText = [
    "Preserve me, O Lord, for in thee have I put my trust; I said unto the Lord, Thou art my God, for thou hast no need of my goods.",
    "To the saints that are in his land, he hath made wonderful all my desires in them.",
    "Their infirmities were multiplied: afterwards they made haste.",
    "I will not gather their assemblies of blood, nor will I be mindful of their names by my lips.",
    "The Lord is the portion of my inheritance and of my cup: it is thou that wilt restore my inheritance to me.",
    "The lines are fallen unto me in goodly places: for my inheritance is goodly to me.",
    "I will bless the Lord, who hath given me understanding: moreover, my reins also have corrected me even till night.",
    "I set the Lord always in my sight: for he is at my right hand, that I be not moved.",
    "Therefore my heart hath been glad, and my tongue hath rejoiced: moreover, my flesh also shall rest in hope.",
    "Because thou wilt not leave my soul in hell; nor wilt thou give thy holy one to see corruption.",
    "Thou hast made known to me the ways of life, thou shalt fill me with joy with thy countenance: at thy right hand are delights even to the end.",
  ]

  private let lineKeyLemmas = [
    (1, ["conservo", "dominus", "spero", "dico", "deus", "bonus", "egeo"]),
    (2, ["sanctus", "terra", "mirifico", "voluntas"]),
    (3, ["multiplico", "infirmitas", "postea", "accelero"]),
    (4, ["congrego", "conventiculum", "sanguis", "memor", "nomen", "labium"]),
    (5, ["dominus", "pars", "hereditas", "calix", "restituo"]),
    (6, ["funis", "cado", "praeclarus", "hereditas"]),
    (7, ["benedico", "dominus", "tribuo", "intellectus", "increpo", "ren"]),
    (8, ["provideo", "dominus", "conspectus", "dexter", "commoveo"]),
    (9, ["laetor", "cor", "exsulto", "lingua", "caro", "requiesco", "spes"]),
    (10, ["derelinquo", "anima", "infernus", "sanctus", "corruptio"]),
    (11, ["notus", "via", "vita", "adimpleo", "laetitia", "vultus", "delectatio", "finis"]),
  ]

  private let structuralThemes = [
    (
      "Prayer for Preservation → Divine Fulfillment",
      "The psalmist's prayer for preservation and trust in God, followed by God's wonderful fulfillment of desires",
      ["conservo", "spero", "deus", "sanctus", "mirifico", "voluntas"],
      1,
      2,
      "The psalmist asks God to preserve him because he has trusted in Him, declaring God as his Lord who needs no human goods, then describes how God has made wonderful all his desires among the saints in His land.",
      "Augustine sees this as the soul's confident trust in divine providence, where the psalmist's declaration of God's self-sufficiency leads to recognition of how God wonderfully fulfills the desires of His people."
    ),
    (
      "Suffering Multiplication → Rejection of Pagan Rites",
      "The multiplication of sufferings contrasted with rejection of pagan blood sacrifices and false gods",
      ["multiplico", "infirmitas", "congrego", "sanguis", "memor", "nomen"],
      3,
      4,
      "The psalmist describes how sufferings were multiplied and then accelerated, then declares he will not gather their assemblies of blood nor remember their names with his lips.",
      "For Augustine, this represents the soul's recognition of temporal suffering contrasted with the rejection of pagan practices and false worship, choosing instead the true God over blood sacrifices."
    ),
    (
      "Divine Inheritance → Land Allotment",
      "God as the portion of inheritance and the falling of boundary lines in pleasant places",
      ["dominus", "pars", "hereditas", "calix", "funis", "cado", "praeclarus"],
      5,
      6,
      "The psalmist declares the Lord as his portion of inheritance and cup, who will restore his inheritance, then describes how boundary lines have fallen to him in pleasant places because his inheritance is pleasant to him.",
      "Augustine sees this as the soul's recognition of divine inheritance through covenant relationship, where God's portion includes both spiritual blessings and the promise of a pleasant inheritance in the land of the living."
    ),
    (
      "Divine Instruction → Constant Presence",
      "God's gift of understanding and nightly instruction leading to constant awareness of divine presence",
      ["benedico", "tribuo", "intellectus", "increpo", "provideo", "dexter", "commoveo"],
      7,
      8,
      "The psalmist will bless the Lord who gave him understanding, with his conscience instructing him even at night, then describes how he has set the Lord always before him at his right hand so he won't be moved.",
      "For Augustine, divine instruction through understanding and conscience leads to constant awareness of God's presence, providing stability and preventing the soul from being shaken by trials."
    ),
    (
      "Joyful Response → Resurrection Hope",
      "The heart's joy and tongue's exultation leading to hope in resurrection and freedom from corruption",
      ["laetor", "cor", "exsulto", "lingua", "caro", "requiesco", "spes", "derelinquo", "anima", "infernus", "corruptio"],
      9,
      10,
      "The psalmist's heart has been glad and his tongue has rejoiced, with his flesh resting in hope, then declares that God will not abandon his soul to hell nor let His holy one see corruption.",
      "Augustine sees this as the soul's joyful response to divine presence leading to eschatological hope, where the resurrection of Christ ensures that the faithful will not be abandoned to death or corruption."
    ),
    (
      "Paths of Life → Eternal Delights",
      "Knowledge of life's paths leading to fullness of joy and eternal pleasures in God's presence",
      ["notus", "via", "vita", "adimpleo", "laetitia", "vultus", "delectatio", "finis"],
      11,
      11,
      "The psalmist declares that God has made known to him the paths of life and will fill him with joy in His presence, with pleasures at God's right hand forever.",
      "For Augustine, this represents the culmination of the spiritual journey where knowledge of divine paths leads to complete joy and eternal delight in God's presence, the ultimate goal of the faithful soul."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Titles and Attributes",
      "References to God's names and divine characteristics",
      ["dominus", "deus", "sanctus", "vultus", "dexter"],
      ThemeCategory.divine,
      1 ... 11
    ),
    (
      "Human Body Parts",
      "References to physical body parts in spiritual context",
      ["cor", "lingua", "caro", "ren", "labium", "anima"],
      ThemeCategory.virtue,
      1 ... 11
    ),
    (
      "Inheritance and Covenant",
      "Themes of divine inheritance and covenantal relationship",
      ["hereditas", "pars", "calix", "funis", "restituo"],
      ThemeCategory.divine,
      5 ... 6
    ),
    (
      "Suffering and Hope",
      "The experience of suffering contrasted with divine hope",
      ["infirmitas", "multiplico", "spes", "requiesco", "laetitia"],
      ThemeCategory.virtue,
      3 ... 11
    ),
    (
      "Worship and Devotion",
      "Expressions of worship and devotion to God",
      ["benedico", "provideo", "conspectus", "exsulto", "delectatio"],
      ThemeCategory.worship,
      7 ... 11
    ),
    (
      "Divine Instruction",
      "God's teaching and guidance of the faithful",
      ["intellectus", "increpo", "notus", "via", "vita"],
      ThemeCategory.divine,
      7 ... 11
    ),
    (
      "Rejection of Evil",
      "Deliberate avoidance of pagan practices and false worship",
      ["sanguis", "conventiculum", "nomen", "congrego"],
      ThemeCategory.sin,
      4 ... 4
    ),
    (
      "Eschatological Hope",
      "Hope in resurrection and eternal life",
      ["infernus", "corruptio", "derelinquo", "finis"],
      ThemeCategory.divine,
      10 ... 11
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 15 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 15 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm15_texts.json"
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
      filename: "output_psalm15_themes.json"
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
