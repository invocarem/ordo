import XCTest

@testable import LatinService

class Psalm148Tests: XCTestCase {
  private var latinService: LatinService!
  private let utilities = PsalmTestUtilities.self

  let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  // MARK: - Test Data

  let psalm148 = [
   "Laudate Dominum de caelis: laudate eum in excelsis.",
    "Laudate eum, omnes angeli eius: laudate eum, omnes virtutes eius.",
    "Laudate eum, sol et luna: laudate eum, omnes stellae et lumen.",
    "Laudate eum, caeli caelorum: et aquae omnes, quae super caelos sunt, laudent nomen Domini.",
    "Quia ipse dixit, et facta sunt: ipse mandavit, et creata sunt.",
    "Statuit ea in aeternum, et in saeculum saeculi: praeceptum posuit, et non praeteribit.",
    "Laudate Dominum de terra, dracones, et omnia abyssorum:",
    "Ignis, grando, nix, glacies, spiritus procellarum: quae faciunt verbum eius:",
    "Montes, et omnes colles: ligna fructifera, et omnes cedri:",
    "Bestiae, et universa pecora: serpentes, et volucres pennatae:",
    "Reges terrae, et omnes populi: principes, et omnes iudices terrae:",
    "Iuvenes, et virgines: senes cum iunioribus laudent nomen Domini: quia exaltatum est nomen eius solius.",
    "Confessio eius super caelum et terram: et exaltabit cornu populi sui.",
    "Hymnus omnibus sanctis eius, filiis Israel, populo appropinquanti sibi."

  ]
  let id = PsalmIdentity(number: 148, category: nil)

  // MARK: - Line-by-line key lemmas (Psalm 148) - Updated for Benedictine Office

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["laudo", "dominus", "caelum", "excelsus"]),
    (2, ["laudo", "angelus", "virtus"]),
    (3, ["laudo", "sol", "luna", "stella", "lumen"]),
    (4, ["caelum", "aqua", "laudo", "nomen", "dominus"]),
    (5, ["dico", "facio", "mando", "creo"]),
    (6, ["statuto", "aeternum", "praeceptum", "non", "praetereo"]),
    (7, ["laudo", "terra", "draco", "abyssus"]),
    (8, ["ignis", "grando", "nix", "glacies", "spiritus", "procella", "verbum"]),
    (9, ["mons", "collis", "lignum", "fructifer", "cedrus"]),
    (10, ["bestia", "pecus", "serpens", "volucris", "pennatus"]),
    (11, ["rex", "terra", "populus", "princeps", "iudex"]),
    (12, ["iuvenis", "virgo", "senex", "iunior", "laudo", "nomen", "dominus", "exalto", "solus"]),
    (13, ["confessio", "caelum", "terra", "exalto", "cornu", "populus"]),
    (14, ["hymnus", "sanctus", "israel", "populus", "appropinquo"]),
  ]

  // MARK: - Structural Themes (every 2 verses) - Updated for Benedictine Office

  private let structuralThemes = [
    (
      "Heaven → Angels",
      "From the high heavens to the angelic hosts",
      ["caelum", "excelsus", "angelus", "virtus"],
      1,
      2,
      "Praise begins from the heavens above and moves to the angelic powers, showing the heavenly order's glorification of God.",
      "Augustine sees angels as ministers of God's will; their praise joins heaven itself, so that created spirits proclaim their Maker."
    ),
    (
      "Luminaries → Waters Above",
      "From sun, moon, and stars to the heavenly waters",
      ["sol", "luna", "stella", "lumen", "aqua"],
      3,
      4,
      "Celestial lights and cosmic waters join in glorifying the Creator.",
      "For Augustine, lights of heaven signify knowledge of truth, while waters above represent the spiritual, lifted above earthly corruption."
    ),
    (
      "Word Spoken → Eternal Law",
      "From creation by command to lasting decree",
      ["dico", "facio", "mando", "creo", "statuto", "aeternum", "praeceptum"],
      5,
      6,
      "The psalm turns from creation at God's word to His eternal law, which cannot pass away.",
      "Augustine interprets the 'word' as Christ through whom all was made; the eternal statute is God's unchanging wisdom."
    ),
    (
      "Depths → Storms",
      "From sea creatures to the forces of weather",
      ["terra", "draco", "abyssus", "ignis", "procella", "verbum"],
      7,
      8,
      "From the abyss and monsters of the deep to the fire, hail, snow, and storm — all obey the Creator's word.",
      "Augustine sees these as signs of God's hidden power: even chaotic forces fulfill His will and serve His praise."
    ),
    (
      "Mountains → Beasts",
      "From the heights of earth to animals of land and sky",
      ["mons", "collis", "lignum", "cedrus", "bestia", "serpens", "volucris"],
      9,
      10,
      "The material world — mountains, trees, and animals — participates in the universal praise.",
      "Augustine notes how irrational creatures also glorify God by existing in His order, showing His providence in all creation."
    ),
    (
      "Rulers → All Humanity",
      "From kings and judges to all ages and states of humanity",
      ["rex", "princeps", "iudex", "iuvenis", "virgo", "senex", "iunior"],
      11,
      12,
      "All humanity is summoned: rulers, peoples, the young and old together, to praise the Lord's name which alone is exalted.",
      "For Augustine, this shows the unity of the Church: no distinction of age or status prevents one from praising God."
    ),
    (
      "Universal Confession → Exaltation of God's People",
      "From God's glory over all creation to the exaltation of His people",
      ["confessio", "caelum", "terra", "exalto", "cornu", "populus", "hymnus", "sanctus", "israel"],
      13,
      14,
      "The psalm concludes with God's glory confessed over all creation and His people raised up in strength and hymnody.",
      "Augustine reads this as Christ exalting His Church, whose praise unites Israel and all the saints who draw near to God."
    ),
  ]

  // MARK: - Conceptual Themes (Psalm 148) - Updated for Benedictine Office

  private let conceptualThemes = [
    (
      "Divine Creation",
      "God's creative power and authority",
      ["dico", "facio", "mando", "creo", "statuto"],
      ThemeCategory.divine,
      5 ... 6
    ),
    (
      "Divine Sovereignty",
      "God's eternal dominion and unchanging decrees",
      ["aeternum", "praeceptum", "verbum", "exalto", "nomen", "solus"],
      ThemeCategory.divine,
      6 ... 14
    ),
    (
      "Cosmic Worship",
      "All creation praising its Creator",
      ["laudo", "caelum", "terra", "nomen", "dominus"],
      ThemeCategory.worship,
      1 ... 14
    ),
    (
      "Angelic Praise",
      "Heavenly beings glorifying God",
      ["angelus", "virtus", "excelsus"],
      ThemeCategory.worship,
      1 ... 2
    ),
    (
      "Natural Order",
      "Creation obeying God's commands",
      ["sol", "luna", "stella", "aqua", "ignis", "nix", "glacies"],
      ThemeCategory.virtue,
      3 ... 8
    ),
    (
      "Living Creation",
      "All creatures fulfilling their purpose",
      ["bestia", "pecus", "serpens", "volucris", "lignum", "cedrus"],
      ThemeCategory.virtue,
      9 ... 10
    ),
    (
      "Human Unity in Praise",
      "All people united in worship regardless of age or status",
      ["rex", "populus", "princeps", "iudex", "iuvenis", "virgo", "senex", "iunior"],
      ThemeCategory.virtue,
      11 ... 12
    ),
    (
      "God's Exalted Name",
      "The unique exaltation of God's name over all creation",
      ["exalto", "nomen", "solus", "confessio", "caelum", "terra"],
      ThemeCategory.divine,
      12 ... 13
    ),
    (
      "Sanctified People",
      "God's chosen people exalted and drawing near to Him",
      ["sanctus", "israel", "appropinquo", "cornu", "hymnus", "populus"],
      ThemeCategory.virtue,
      13 ... 14
    ),
  ]

  // MARK: - Test Cases

  func testPsalm148Verses() {
    XCTAssertEqual(
      psalm148.count, 14, "Psalm 148 should have 14 verses in the Benedictine Office"
    )
    let normalized = psalm148.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized, psalm148, "Normalized Latin text should match expected classical forms"
    )
  }

  func testPsalm148LineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm148,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm148StructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: psalm148,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm148ConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: psalm148,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSavePsalm148Themes() {
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
      filename: "output_psalm148_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}