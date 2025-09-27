@testable import LatinService
import XCTest

class Psalm91Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 91, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 15
  private let text = [
    "Bonum est confiteri Domino, et psallere nomini tuo, Altissime.",
    "Ad annuntiandum mane misericordiam tuam, et veritatem tuam per noctem,",
    "In decachordo, psalterio, cum cantico in cithara.",
    "Quia delectasti me, Domine, in factura tua; et in operibus manuum tuarum exsultabo.",
    "Quam magnificata sunt opera tua, Domine! Nimis profundae factae sunt cogitationes tuae.",
    "Vir insipiens non cognoscet, et stultus non intelliget haec.",
    "Cum exorti fuerint peccatores sicut fenum, et apparuerint omnes qui operantur iniquitatem; ut intereant in saeculum saeculi.",
    "Tu autem Altissimus in aeternum, Domine.",
    "Quoniam ecce inimici tui, Domine, quoniam ecce inimici tui peribunt; et dispergentur omnes qui operantur iniquitatem.",
    "Et exaltabitur sicut unicornis cornu meum, et senectus mea in misericordia uberi.",
    "Et despexit oculus meus inimicos meos, et in insurgentibus in me malignantibus audiet auris mea.",
    "Iustus ut palma florebit; sicut cedrus Libani multiplicabitur.",
    "Plantati in domo Domini, in atriis Dei nostri florebunt.",
    "Adhuc multiplicabuntur in senecta uberi, et bene patientes erunt:",
    "Ut annuntient quoniam rectus Dominus Deus noster, et non est iniquitas in eo.",
  ]

  private let englishText = [
    "It is good to give praise to the Lord; and to sing to thy name, O most High.",
    "To shew forth thy mercy in the morning, and thy truth in the night,",
    "Upon an instrument of ten strings, upon the psaltery, with a canticle upon the harp.",
    "For thou hast given me, O Lord, a delight in thy doings; and in the works of thy hands I shall rejoice.",
    "O Lord, how great are thy works! thy thoughts are exceeding deep.",
    "The senseless man shall not know, nor will the fool understand these things.",
    "When the wicked shall spring up as grass, and all the workers of iniquity shall appear; that they may perish for ever and ever.",
    "But thou, O Lord, art most high for evermore.",
    "For behold thy enemies, O Lord, for behold thy enemies shall perish; and all the workers of iniquity shall be scattered.",
    "But my horn shall be exalted like that of the unicorn; and my old age in plentiful mercy.",
    "My eye also hath looked down upon my enemies; and my ear shall hear of the downfall of the malignant that rise up against me.",
    "The just shall flourish like the palm tree; he shall grow up like the cedar of Libanus.",
    "They that are planted in the house of the Lord shall flourish in the courts of the house of our God.",
    "They shall still increase in a fruitful old age; and shall be well treated,",
    "That they may shew that the Lord our God is righteous, and there is no iniquity in him.",
  ]

  private let lineKeyLemmas = [
    (1, ["bonus", "confiteor", "dominus", "psallo", "nomen", "altissimus"]),
    (2, ["annuntio", "mane", "misericordia", "veritas", "nox"]),
    (3, ["decachordum", "psalterium", "canticum", "cithara"]),
    (4, ["delecto", "dominus", "factura", "opus", "manus", "exsulto"]),
    (5, ["magnifico", "opus", "dominus", "profundus", "cogitatio"]),
    (6, ["vir", "insipiens", "cognosco", "stultus", "intelligo"]),
    (7, ["exorior", "peccator", "fenum", "appareo", "iniquitas", "intereo", "saeculum"]),
    (8, ["altissimus", "aeternum", "dominus"]),
    (9, ["inimicus", "dominus", "pereo", "dispergo", "iniquitas"]),
    (10, ["exalto", "unicornis", "cornu", "senectus", "misericordia", "uber"]),
    (11, ["despicio", "oculus", "inimicus", "insurgo", "malignus", "auris"]),
    (12, ["iustus", "palma", "floreo", "cedrus", "Libanus", "multiplico"]),
    (13, ["planto", "domus", "dominus", "atrium", "deus", "floreo"]),
    (14, ["multiplico", "senectus", "uber", "patiens"]),
    (15, ["annuntio", "rectus", "dominus", "deus", "iniquitas"]),
  ]

  private let structuralThemes = [
    (
      "Praise and Worship → Musical Instruments",
      "The psalmist's declaration of praise leading to specific musical worship",
      ["confiteor", "psallo", "decachordum", "psalterium", "canticum", "cithara"],
      1,
      3,
      "The psalmist declares it is good to praise the Lord and sing to His name, then specifies the musical instruments for worship: ten-stringed instrument, psaltery, and harp.",
      "Augustine sees this as the soul's natural progression from inner praise to outward expression through various forms of musical worship, each instrument representing different aspects of divine praise."
    ),
    (
      "Divine Delight → Deep Thoughts",
      "God's delight in His works leading to reflection on the depth of divine thoughts",
      ["delecto", "factura", "opus", "magnifico", "profundus", "cogitatio"],
      4,
      5,
      "The psalmist rejoices in God's works and marvels at how great they are, then reflects on the exceeding depth of God's thoughts.",
      "For Augustine, delight in God's creation leads to deeper contemplation of divine wisdom, recognizing that God's works reveal the unfathomable depth of His mind."
    ),
    (
      "Foolish Ignorance → Wicked Destruction",
      "The foolish not understanding leading to the wicked perishing forever",
      ["insipiens", "stultus", "cognosco", "intelligo", "peccator", "fenum", "intereo"],
      6,
      7,
      "The foolish man does not know and the fool does not understand, then the wicked spring up like grass and all workers of iniquity appear only to perish forever.",
      "Augustine sees this as the contrast between those who lack spiritual understanding and those who actively work evil, both destined for destruction without divine intervention."
    ),
    (
      "Eternal God → Enemy Destruction",
      "God's eternal nature contrasted with the destruction of His enemies",
      ["altissimus", "aeternum", "inimicus", "pereo", "dispergo"],
      8,
      9,
      "God is most high forever, then His enemies perish and all workers of iniquity are scattered.",
      "Augustine sees this as the eternal stability of God contrasted with the temporal fate of those who oppose Him, demonstrating divine sovereignty over all opposition."
    ),
    (
      "Personal Exaltation → Righteous Flourishing",
      "Personal horn exaltation leading to the flourishing of the righteous",
      ["exalto", "unicornis", "cornu", "iustus", "palma", "floreo", "cedrus"],
      10,
      12,
      "The psalmist's horn is exalted like a unicorn, then the righteous flourish like a palm tree and grow like the cedar of Lebanon.",
      "Augustine sees this as the individual's spiritual strength leading to the broader flourishing of all the righteous, with natural imagery representing spiritual vitality and growth."
    ),
    (
      "Temple Planting → Righteous Proclamation",
      "Being planted in God's house leading to proclamation of His righteousness",
      ["planto", "domus", "atrium", "floreo", "multiplico", "annuntio", "rectus"],
      13,
      15,
      "The righteous are planted in the house of the Lord and flourish in His courts, then multiply in fruitful old age and proclaim that the Lord is righteous.",
      "For Augustine, being rooted in God's house leads to continued growth and the ultimate purpose of proclaiming God's righteousness to the world."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Praise",
      "Expressions of praise and worship to God",
      ["confiteor", "psallo", "exsulto", "magnifico", "delecto"],
      ThemeCategory.worship,
      1 ... 5
    ),
    (
      "Musical Worship",
      "References to musical instruments and song",
      ["decachordum", "psalterium", "canticum", "cithara"],
      ThemeCategory.worship,
      3 ... 3
    ),
    (
      "Divine Protection",
      "God's protection and exaltation of the faithful",
      ["altissimus", "unicornis", "despicio", "insurgo"],
      ThemeCategory.divine,
      8 ... 11
    ),
    (
      "Righteous Flourishing",
      "The growth and prosperity of the righteous",
      ["iustus", "palma", "cedrus", "floreo", "multiplico"],
      ThemeCategory.virtue,
      10 ... 14
    ),
    (
      "Divine Justice",
      "God's judgment and destruction of the wicked",
      ["iniquitas", "pereo", "dispergo", "intereo"],
      ThemeCategory.divine,
      7 ... 9
    ),
    (
      "Wisdom Contrast",
      "The contrast between wisdom and foolishness",
      ["insipiens", "stultus", "cognosco", "intelligo"],
      ThemeCategory.virtue,
      6 ... 6
    ),
    (
      "Eternal Nature of God",
      "References to God's eternal and transcendent nature",
      ["aeternum", "saeculum", "profundus", "cogitatio"],
      ThemeCategory.divine,
      5 ... 8
    ),
    (
      "Temple Imagery",
      "References to God's house and sacred spaces",
      ["domus", "atrium", "planto", "senectus"],
      ThemeCategory.worship,
      13 ... 14
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 91 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 91 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm91_texts.json"
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
      filename: "output_psalm91_themes.json"
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
