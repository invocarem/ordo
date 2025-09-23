@testable import LatinService
import XCTest

class Psalm74Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 74, category: "")

  // MARK: - Test Data Properties

  private let psalm74 = [
    "Confitebimur tibi, Deus, confitebimur, et invocabimus nomen tuum; ",
    "narrabimus mirabilia tua. Cum accepero tempus, ego iustitias iudicabo.",
    "Liquefacta est terra, et omnes qui habitant in ea; ego confirmavi columnas eius.",
    "Dixi iniquis: Nolite inique agere; et delinquentibus: Nolite exaltare cornu.",

    "Nolite extollere in altum cornu vestrum; nolite loqui adversus Deum iniquitatem.",
    "Quia neque ab oriente, neque ab occidente, neque a desertis montibus; Quoniam Deus iudex est;",
    "Hunc humiliat, et hunc exaltat. Quia calix in manu Domini vini meri plenus misto; ",

    "Et inclinavit ex hoc in hoc; verumtamen faex eius non est exinanita; bibent omnes peccatores terrae.",
    "Ego autem annuntiabo in saeculum; cantabo Deo Iacob.",
    "Et omnia cornua peccatorum confringam; et exaltabuntur cornua iusti.",
  ]

  private let englishText = [
    "We will praise thee, O God, we will praise thee; and we will call upon thy name;",
    "we will relate thy wondrous works. When I shall take a time, I will judge justices.",
    "The earth is melted, and all that dwell therein: I have established the pillars thereof.",
    "I said to the wicked: Do not act wickedly; and to the sinners: Lift not up the horn.",
    "Lift not up your horn on high; speak not iniquity against God.",
    "For neither from the east, nor from the west, nor from the desert hills; For God is the judge;",
    "One he putteth down, and another he lifteth up. For in the hand of the Lord there is a cup of strong wine full of mixture;",
    "And he hath poured it out from this to that; but the dregs thereof are not emptied: all the sinners of the earth shall drink.",
    "But I will declare for ever; I will sing to the God of Jacob.",
    "And I will break all the horns of sinners; but the horns of the just shall be exalted.",
  ]

  private let lineKeyLemmas = [
    (1, ["confiteor", "deus", "invoco", "nomen"]),
    (2, ["narro", "mirabilis", "accipio", "tempus", "iustitia", "iudico"]),
    (3, ["liquefacio", "terra", "habito", "confirmo", "columna"]),
    (4, ["dico", "iniquus", "ago", "delinquo", "exalto", "cornu"]),
    (5, ["extollo", "altus", "cornu", "loquor", "adversus", "deus", "iniquitas"]),
    (6, ["oriens", "occidens", "desertus", "mons", "deus", "iudex"]),
    (7, ["humilio", "exalto", "calix", "manus", "dominus", "vinum", "merus", "plenus", "misto"]),
    (8, ["inclino", "faex", "exinanio", "bibo", "peccator", "terra"]),
    (9, ["annuntio", "saeculum", "canto", "deus", "iacob"]),
    (10, ["cornu", "peccator", "confringo", "exalto", "iustus"]),
  ]

  private let structuralThemes = [
    (
      "Praise and Declaration → Divine Judgment",
      "The psalmist's commitment to praise God and declare His works, leading to divine judgment",
      ["confiteor", "narro", "mirabilis", "iudico", "iustitia"],
      1,
      2,
      "The psalmist declares he will praise God and relate His wondrous works, then states that when he takes time, he will judge justices.",
      "Augustine sees this as the soul's commitment to divine praise leading to participation in God's righteous judgment, where the faithful become instruments of divine justice."
    ),
    (
      "Earth's Instability → Divine Foundation",
      "The earth's melting contrasted with God's establishment of its pillars",
      ["liquefacio", "terra", "habito", "confirmo", "columna"],
      3,
      3,
      "The earth is melted and all who dwell in it are affected, but the psalmist has established its pillars, showing divine stability in chaos.",
      "For Augustine, this represents the contrast between worldly instability and divine constancy - while creation may seem unstable, God's eternal foundations remain firm."
    ),
    (
      "Warning to the Wicked → Divine Authority",
      "Commands to the wicked not to act wickedly, leading to assertion of divine judgment",
      ["dico", "iniquus", "ago", "exalto", "cornu", "deus", "iudex"],
      4,
      6,
      "The psalmist warns the wicked not to act wickedly or exalt their horn, then declares that God is judge who humbles one and exalts another.",
      "Augustine sees this as the soul's recognition that only God has ultimate authority to judge and that human pride must yield to divine sovereignty."
    ),
    (
      "Divine Cup of Judgment → Eternal Praise",
      "The cup of God's judgment poured out on sinners, leading to eternal declaration of praise",
      ["calix", "dominus", "vinum", "peccator", "annuntio", "saeculum", "canto"],
      7,
      9,
      "God's cup of strong wine is poured out on sinners, but the psalmist will declare forever and sing to the God of Jacob.",
      "Augustine interprets this as the contrast between temporal judgment and eternal praise - while sinners drink the cup of wrath, the righteous sing eternal praises to God."
    ),
    (
      "Breaking Sinners' Horns → Exalting the Just",
      "The destruction of sinners' power contrasted with the exaltation of the righteous",
      ["confringo", "cornu", "peccator", "exalto", "iustus"],
      10,
      10,
      "The psalmist will break all the horns of sinners, but the horns of the just will be exalted.",
      "For Augustine, this represents the final vindication where the power of the wicked is destroyed while the righteous are lifted up in divine favor."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Praise and Worship",
      "Expressions of praise, confession, and worship to God",
      ["confiteor", "invoco", "narro", "mirabilis", "canto", "annuntio"],
      ThemeCategory.worship,
      1 ... 10
    ),
    (
      "Divine Judgment",
      "God's role as judge and executor of justice",
      ["iudico", "iustitia", "deus", "iudex", "humilio", "exalto"],
      ThemeCategory.divine,
      2 ... 10
    ),
    (
      "Earthly Instability",
      "References to the earth's instability and divine stability",
      ["liquefacio", "terra", "habito", "confirmo", "columna"],
      ThemeCategory.sin,
      3 ... 3
    ),
    (
      "Warning Against Pride",
      "Commands against pride and exaltation of the wicked",
      ["iniquus", "exalto", "cornu", "extollo", "altus"],
      ThemeCategory.sin,
      4 ... 6
    ),
    (
      "Divine Sovereignty",
      "God's ultimate authority over all directions and peoples",
      ["oriens", "occidens", "desertus", "mons", "deus", "iudex"],
      ThemeCategory.divine,
      6 ... 6
    ),
    (
      "Cup of Judgment",
      "The symbolic cup of God's judgment poured out on sinners",
      ["calix", "dominus", "vinum", "merus", "misto", "inclino", "faex", "bibo"],
      ThemeCategory.justice,
      7 ... 8
    ),
    (
      "Eternal Declaration",
      "The psalmist's commitment to eternal praise and proclamation",
      ["annuntio", "saeculum", "canto", "iacob"],
      ThemeCategory.worship,
      9 ... 9
    ),
    (
      "Final Vindication",
      "The ultimate destruction of sinners and exaltation of the righteous",
      ["confringo", "cornu", "peccator", "exalto", "iustus"],
      ThemeCategory.justice,
      10 ... 10
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm74.count, 10, "Psalm 74 should have 10 verses"
    )
    XCTAssertEqual(
      englishText.count, 10,
      "Psalm 74 English text should have 10 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm74.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm74,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm74,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm74_texts.json"
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
      filename: "output_psalm74_themes.json"
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
      psalmText: psalm74,
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
      psalmText: psalm74,
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
      psalmText: psalm74,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
