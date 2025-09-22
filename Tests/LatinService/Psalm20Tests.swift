@testable import LatinService
import XCTest

class Psalm20Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 20, category: "")

  // MARK: - Test Data Properties

  private let psalm20 = [
    "Domine, in virtute tua laetabitur rex, et super salutare tuum exsultabit vehementer.",
    "Desiderium cordis eius tribuisti ei, et voluntatem labiorum eius non fraudasti eum.",
    "Quoniam praevenisti eum in benedictionibus dulcedinis; posuisti in capite eius coronam de lapide pretioso.",
    "Vitam petiit a te, et tribuisti ei longitudinem dierum in saeculum saeculi.",
    "Magna est gloria eius in salutari tuo; gloriam et magnum decorem impones super eum.",
    "Quoniam dabis eum in benedictionem in saeculum saeculi; laetificabis eum in gaudio cum vultu tuo.",
    "Quoniam rex sperat in Domino, et in misericordia Altissimi non commovebitur.",
    "Inveniatur manus tua omnibus inimicis tuis; dextera tua inveniat omnes qui te oderunt.",
    "Pones eos ut clibanum ignis in tempore vultus tui; Dominus in ira sua conturbabit eos, et devorabit eos ignis.",
    "Fructum eorum de terra perdes, et semen eorum a filiis hominum.",
    "Quoniam declinaverunt in te mala; cogitaverunt consilia quae non potuerunt stabilire.",
    "Quoniam pones eos dorsum; in reliquiis tuis praeparabis vultum eorum.",
    "Exaltare, Domine, in virtute tua; cantabimus et psallemus virtutes tuas.",
  ]

  private let englishText = [
    "May the Lord hear thee in the day of trouble: may the name of the God of Jacob protect thee.",
    "May he send thee help from the sanctuary: and defend thee out of Sion.",
    "May he be mindful of all thy sacrifices: and may thy whole burnt offering be made fat.",
    "May he give thee according to thy own heart; and confirm all thy counsels.",
    "We will rejoice in thy salvation; and in the name of our God we shall be exalted.",
    "The Lord fulfil all thy petitions: now have I known that the Lord hath saved his anointed.",
    "He will hear him from his holy heaven: the salvation of his right hand is in powers.",
    "Some trust in chariots, and some in horses: but we will call upon the name of the Lord our God.",
    "They are bound, and have fallen; but we are risen, and are set upright.",
    "O Lord, save the king: and hear us in the day that we shall call upon thee.",
    "The Lord hath granted thee according to thy heart: and hath not denied thee the request of thy lips.",
    "For the Lord hath blessed thee with his blessing: and hath crowned thee with a crown of justice.",
    "He hath given thee length of days for ever and ever: his name shall be exalted for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "virtus", "laetor", "rex", "salutare", "exsulto", "vehementer"]),
    (2, ["desiderium", "cor", "tribuo", "voluntas", "labium", "fraudo"]),
    (3, ["praevenio", "benedictio", "dulcedo", "pono", "caput", "corona", "lapis", "pretiosus"]),
    (4, ["vita", "peto", "tribuo", "longitudo", "dies", "saeculum"]),
    (5, ["magnus", "gloria", "salutare", "gloria", "decor", "impono"]),
    (6, ["do", "benedictio", "saeculum", "laetifico", "gaudium", "vultus"]),
    (7, ["rex", "spero", "dominus", "misericordia", "altissimus", "commoveo"]),
    (8, ["invenio", "manus", "omnis", "inimicus", "dexter", "odi"]),
    (9, ["pono", "clibanus", "ignis", "tempus", "vultus", "dominus", "ira", "conturbo", "devoro"]),
    (10, ["fructus", "terra", "perdo", "semen", "filius", "homo"]),
    (11, ["declino", "malum", "cogito", "consilium", "possum", "stabilio"]),
    (12, ["pono", "dorsum", "reliquiae", "praeparo", "vultus"]),
    (13, ["exalto", "dominus", "virtus", "canto", "psallo", "virtus"]),
  ]

  private let structuralThemes = [
    (
      "Divine Favor → Royal Joy",
      "The king's rejoicing in God's strength and salvation",
      ["dominus", "virtus", "laetor", "rex", "salutare", "exsulto", "vehementer"],
      1,
      1,
      "The psalm begins with the king rejoicing in the Lord's strength and exulting greatly in His salvation.",
      "Augustine sees this as the soul's joy in divine power, where the king represents Christ or the righteous soul finding strength in God rather than earthly power."
    ),
    (
      "Heart's Desire → Divine Response",
      "God granting the desires of the heart and not withholding the request of the lips",
      ["desiderium", "cor", "tribuo", "voluntas", "labium", "fraudo"],
      2,
      2,
      "God has granted the desire of the heart and has not denied the request of the lips.",
      "For Augustine, this represents God's faithfulness to those who pray with pure hearts, fulfilling both their spoken and unspoken petitions."
    ),
    (
      "Blessings → Coronation",
      "Divine blessings of sweetness leading to precious crown",
      ["praevenio", "benedictio", "dulcedo", "pono", "caput", "corona", "lapis", "pretiosus"],
      3,
      3,
      "God has met the king with blessings of sweetness and placed on his head a crown of precious stone.",
      "Augustine interprets the crown of precious stone as the eternal crown of righteousness, while the blessings of sweetness represent God's gracious favor."
    ),
    (
      "Life Request → Eternal Promise",
      "Petition for life resulting in length of days forever",
      ["vita", "peto", "tribuo", "longitudo", "dies", "saeculum"],
      4,
      4,
      "The king asked for life from God, and He gave him length of days forever and ever.",
      "Augustine sees this as the soul's prayer for eternal life being granted through Christ, who is the source of everlasting life."
    ),
    (
      "Glory → Exaltation",
      "Great glory in salvation leading to divine exaltation",
      ["magnus", "gloria", "salutare", "decor", "impono"],
      5,
      5,
      "Great is his glory in God's salvation; God will impose glory and great splendor upon him.",
      "For Augustine, this represents the glory that comes from divine salvation, where God Himself becomes the source and giver of true glory."
    ),
    (
      "Eternal Blessing → Joyful Presence",
      "Eternal blessing resulting in joy in God's presence",
      ["do", "benedictio", "saeculum", "laetifico", "gaudium", "vultus"],
      6,
      6,
      "God will give him as a blessing forever; He will gladden him with joy in His presence.",
      "Augustine interprets this as the eternal blessing of divine fellowship, where true joy is found in God's presence rather than earthly pleasures."
    ),
    (
      "Royal Trust → Divine Stability",
      "The king's trust in the Lord ensuring he will not be moved",
      ["rex", "spero", "dominus", "misericordia", "altissimus", "commoveo"],
      7,
      7,
      "The king trusts in the Lord, and in the mercy of the Most High he will not be moved.",
      "Augustine sees this as the stability that comes from placing complete trust in God's mercy, making one immovable in the face of trials."
    ),
    (
      "Divine Victory → Enemy Defeat",
      "God's hand finding all enemies and turning them back",
      ["invenio", "manus", "omnis", "inimicus", "dexter", "odi", "pono", "dorsum", "reliquiae", "praeparo"],
      8,
      12,
      "May God's hand be found by all His enemies; may His right hand find all who hate Him. God will set them as a furnace of fire and turn their backs.",
      "For Augustine, this represents God's complete victory over spiritual enemies, where His righteous judgment brings about their ultimate defeat and shame."
    ),
    (
      "Divine Wrath → Complete Destruction",
      "God's anger and fire consuming the enemies completely",
      ["clibanus", "ignis", "tempus", "vultus", "dominus", "ira", "conturbo", "devoro", "fructus", "terra", "perdo", "semen", "filius", "homo"],
      9,
      10,
      "God will set them as a furnace of fire in the time of His anger; the Lord will trouble them in His wrath, and fire will devour them. He will destroy their fruit from the earth and their seed from among the children of men.",
      "Augustine interprets this as the complete destruction of evil, where God's righteous anger consumes all that is opposed to Him, leaving no trace of wickedness."
    ),
    (
      "Failed Schemes → Divine Preparation",
      "Enemy plans that cannot be established versus God's preparation of their downfall",
      ["declino", "malum", "cogito", "consilium", "possum", "stabilio"],
      11,
      11,
      "For they have turned aside toward evil; they have devised plans that they could not establish.",
      "Augustine sees this as the futility of evil schemes against God's people, where human plans against divine will inevitably fail and collapse."
    ),
    (
      "Divine Exaltation → Praise",
      "God exalted in His strength leading to joyful praise",
      ["exalto", "dominus", "virtus", "canto", "psallo", "virtus"],
      13,
      13,
      "Be exalted, O Lord, in Your strength; we will sing and praise Your mighty deeds.",
      "For Augustine, this represents the soul's response to God's exaltation, where recognition of divine power leads naturally to joyful worship and praise."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Favor",
      "God's gracious blessing and favor upon the king",
      ["tribuo", "praevenio", "benedictio", "dulcedo", "laetifico"],
      ThemeCategory.divine,
      1 ... 7
    ),
    (
      "Royal Authority",
      "The king's position and divine appointment",
      ["rex", "corona", "gloria", "decor", "virtus"],
      ThemeCategory.virtue,
      1 ... 13
    ),
    (
      "Divine Protection",
      "God's defense and victory over enemies",
      ["invenio", "manus", "dexter", "clibanus", "ignis", "devoro"],
      ThemeCategory.divine,
      8 ... 12
    ),
    (
      "Eternal Promises",
      "Lasting blessings and eternal life",
      ["saeculum", "longitudo", "dies", "vita", "semen"],
      ThemeCategory.divine,
      4 ... 10
    ),
    (
      "Divine Justice",
      "God's righteous judgment and retribution",
      ["ira", "conturbo", "perdo", "dorsum", "reliquiae"],
      ThemeCategory.justice,
      8 ... 12
    ),
    (
      "Worship and Praise",
      "Exaltation of God and joyful worship",
      ["exalto", "canto", "psallo", "virtus", "laetor", "exsulto"],
      ThemeCategory.worship,
      1 ... 13
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm20.count, 13, "Psalm 20 should have 13 verses"
    )
    XCTAssertEqual(
      englishText.count, 13,
      "Psalm 20 English text should have 13 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm20.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm20,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm20,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm20_texts.json"
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
      filename: "output_psalm20_themes.json"
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
      psalmText: psalm20,
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
      psalmText: psalm20,
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
      psalmText: psalm20,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
