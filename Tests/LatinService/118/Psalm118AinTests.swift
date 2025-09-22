@testable import LatinService
import XCTest

class Psalm118AinTests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  private let minimumLemmasPerTheme = 3
  let id = PsalmIdentity(number: 118, category: "Ain")

  // MARK: - Test Data Properties

  private let psalm118Ain = [
    "Feci iudicium et iustitiam; non tradas me calumniantibus me.",
    "Suscipe servum tuum in bonum; non calumnientur me superbi.",
    "Oculi mei defecerunt in salutare tuum, et in eloquium iustitiae tuae.",
    "Fac cum servo tuo secundum misericordiam tuam, et iustificationes tuas doce me.",
    "Servus tuus sum ego; da mihi intellectum, ut sciam testimonia tua.",
    "Tempus faciendi, Domine; dissipaverunt legem tuam.",
    "Ideo dilexi mandata tua super aurum et topazion.",
    "Propterea ad omnia mandata tua dirigebar; omnem viam iniquam odio habui.",
  ]

  private let englishText = [
    "I have done judgment and justice; give me not up to them that slander me.",
    "Uphold thy servant unto good; let not the proud calumniate me.",
    "My eyes have fainted after thy salvation, and for the word of thy justice.",
    "Deal with thy servant according to thy mercy, and teach me thy justifications.",
    "I am thy servant; give me understanding, that I may know thy testimonies.",
    "It is time, O Lord, to do; they have dissipated thy law.",
    "Therefore have I loved thy commandments above gold and the topaz.",
    "Therefore was I directed to all thy commandments; I have hated all wicked ways.",
  ]

  private let lineKeyLemmas = [
    (1, ["facio", "iudicium", "iustitia", "trado", "calumnior"]),
    (2, ["suscipio", "servus", "bonus", "calumnior", "superbus"]),
    (3, ["oculus", "deficio", "salutare", "eloquium", "iustitia"]),
    (4, ["facio", "servus", "secundum", "misericordia", "iustificatio", "doceo"]),
    (5, ["servus", "sum", "do", "intellectus", "scio", "testimonium"]),
    (6, ["tempus", "facio", "dominus", "dissipo", "lex"]),
    (7, ["diligo", "mandatum", "super", "aurum", "topazion"]),
    (8, ["propterea", "mandatum", "dirigo", "omnis", "via", "iniquus", "odium", "habeo"]),
  ]

  private let structuralThemes = [
    (
      "Justice → Protection",
      "The psalmist's practice of justice and righteousness seeking divine protection",
      ["facio", "iudicium", "iustitia", "trado", "calumnior", "suscipio", "superbus"],
      1,
      2,
      "The psalmist declares he has done judgment and justice, asking not to be given up to slanderers, then asks God to uphold His servant for good and not let the proud calumniate him.",
      "Augustine sees this as the soul's recognition of the connection between righteous living and divine protection. The 'feci iudicium et iustitiam' shows the psalmist's commitment to justice, while the request for protection reveals his understanding that righteousness alone is not enough without divine aid."
    ),
    (
      "Longing → Teaching",
      "The psalmist's longing for salvation and his request for divine instruction",
      ["oculus", "deficio", "salutare", "eloquium", "iustitia", "facio", "servus", "misericordia", "doceo"],
      3,
      4,
      "The psalmist's eyes have fainted after God's salvation and the word of His justice, then asks God to deal with His servant according to mercy and teach him His justifications.",
      "For Augustine, this represents the soul's spiritual hunger. The 'oculi mei defecerunt' shows the intensity of the psalmist's desire for divine truth, while the request for teaching reveals his recognition that understanding comes only through divine instruction."
    ),
    (
      "Servanthood → Understanding",
      "The psalmist's identity as God's servant and his quest for understanding",
      ["servus", "sum", "do", "intellectus", "scio", "testimonium", "tempus", "facio", "dominus", "dissipo", "lex"],
      5,
      6,
      "The psalmist declares himself God's servant and asks for understanding to know His testimonies, then notes that it is time for God to act because they have dissipated His law.",
      "Augustine interprets this as the soul's recognition of its proper relationship to God. The 'servus tuus sum ego' shows complete submission, while the observation about the law being 'dissipaverunt' reveals the psalmist's awareness of the world's rejection of divine order."
    ),
    (
      "Love → Direction",
      "The psalmist's love for God's commandments and his commitment to follow them",
      ["diligo", "mandatum", "super", "aurum", "topazion", "propterea", "dirigo", "omnis", "via", "iniquus", "odium", "habeo"],
      7,
      8,
      "The psalmist declares his love for God's commandments above gold and topaz, and therefore was directed to all God's commandments, hating all wicked ways.",
      "For Augustine, this represents the soul's complete reorientation toward divine will. The comparison with 'aurum et topazion' shows the psalmist's recognition of the surpassing value of divine law, while the 'dirigebar' reveals his willing submission to God's guidance in all things."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Justice",
      "Focus on God's justice, righteousness, and justifications",
      ["iudicium", "iustitia", "iustificatio", "salutare", "eloquium"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Divine Protection",
      "Seeking God's protection from enemies and slanderers",
      ["trado", "calumnior", "suscipio", "superbus"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Servanthood",
      "Identity as God's servant and seeking divine guidance",
      ["servus", "facio", "doceo", "intellectus", "scio", "sum", "do"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Love for God's Word",
      "Affection for commandments, testimonies, and divine law",
      ["diligo", "mandatum", "testimonium", "lex", "super", "aurum", "topazion"],
      ThemeCategory.virtue,
      1 ... 8
    ),
    (
      "Rejection of Evil",
      "Hatred for wicked paths and injustice",
      ["iniquus", "odium", "habeo", "via", "dissipo"],
      ThemeCategory.virtue,
      1 ... 8
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm118Ain.count, 8, "Psalm 118 Ain should have 8 verses"
    )
    XCTAssertEqual(
      englishText.count, 8,
      "Psalm 118 Ain English text should have 8 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm118Ain.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm118Ain,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm118Ain,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm118Ain_texts.json"
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
      filename: "output_psalm118Ain_themes.json"
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
      psalmText: psalm118Ain,
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
      psalmText: psalm118Ain,
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
      psalmText: psalm118Ain,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
