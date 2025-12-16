@testable import LatinService
import XCTest

class Psalm103BTests: XCTestCase
{
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp()
  {
    super.setUp()
  }

  let id = PsalmIdentity(number: 103, category: "b")
  private let expectedVerseCount = 11

  // MARK: - Test Data

  private let text = [
    "Hoc mare magnum et spatiosum manibus; illic reptilia quorum non est numerus,",
    "animalia pusilla cum magnis. Illic naves pertransibunt, ",
    "draco iste quem formasti ad illudendum ei. Omnia a te exspectant ut des illis escam in tempore.",
    "Dante te illis colligent; aperiente te manum tuam omnia implebuntur bonitate.",
    "Avertente te faciem tuam turbabuntur; auferes spiritum eorum, et deficient, et in pulverem suum revertentur.",

    "Emittes spiritum tuum, et creabuntur, et renovabis faciem terrae.",
    "Sit gloria Domini in saeculum; laetabitur Dominus in operibus suis.",
    "Qui respicit terram, et facit eam tremere; qui tangit montes, et fumigant.",
    "Cantabo Domino in vita mea; psallam Deo meo quamdiu sum.",
    "Iucundum sit ei eloquium meum; ego vero delectabor in Domino.",

    "Deficiat peccator de terra, et iniquus ita ut non sit. Benedic, anima mea, Domino."
  ]

  private let englishText = [
    "So is this great sea, which stretcheth wide its arms: there are creeping things without number,",
    "Creatures little and great. There the ships shall go. ",
    "This sea dragon which thou hast formed to play therein. All expect of thee that thou give them food in season.",
    "What thou givest to them they shall gather up: when thou openest thy hand, they shall all be filled with good.",
    "But if thou turnest away thy face, they shall be troubled: thou shalt take away their breath, and they shall fail, and shall return to their dust.",

    "Thou shalt send forth thy spirit, and they shall be created: and thou shalt renew the face of the earth.",
    "May the glory of the Lord endure for ever: the Lord shall rejoice in his works.",
    "He looketh upon the earth, and maketh it tremble: he toucheth the mountains, and they smoke.",
    "I will sing to the Lord as long as I live: I will sing praise to my God while I have my being.",
    "Let my speech be acceptable to him: but I will take delight in the Lord.",

    "Let sinners be consumed out of the earth, and the unjust, so that they be no more. Bless thou the Lord, O my soul."
  ]

  private let lineKeyLemmas = [
    (1, ["mare", "magnus", "spatiosus", "manus", "reptile", "numerus"]),
    (2, ["animal", "pusillus", "magnus", "navis", "pertranseo"]),
    (3, ["draco", "formo", "illudo", "omnis", "exspecto", "do", "esca", "tempus"]),
    (4, ["do", "colligo", "aperio", "manus", "impleo", "bonitas"]),
    (5, ["averto", "facies", "turbo", "aufero", "spiritus", "deficio", "pulvis", "reverto"]),
    (6, ["emitto", "spiritus", "creo", "renovo", "facies", "terra"]),
    (7, ["gloria", "dominus", "saeculum", "laetor", "opus"]),
    (8, ["respicio", "terra", "facio", "tremo", "tango", "mons", "fumigo"]),
    (9, ["canto", "dominus", "vita", "psallo", "deus"]),
    (10, ["iucundus", "eloquium", "delecto", "dominus"]),
    (11, ["deficio", "peccator", "terra", "iniquus", "benedico", "anima", "dominus"])
  ]

  private let structuralThemes = [
    (
      "Sea and Creatures → Divine Provision",
      "Creation teems with life, all dependent on God's daily sustenance",
      ["mare", "spatiosus", "reptile", "animal", "pusillus", "magnus", "navis", "pertranseo", "escam", "do", "colligo", "impleo", "bonitas"],
      1,
      2,
      "The vast sea teeming with life is sustained by God's daily provision",
      "Augustine sees the sea as a symbol of the world's complexity, yet all its creatures depend on God's hand for daily bread — a sign of His providential care (Enarr. Ps. 103.5)."
    ),
    (
      "Divine Withdrawal → Death and Return",
      "When God hides His face, all flesh returns to dust in mortal decay",
      ["averto", "facies", "turbo", "aufero", "spiritus", "deficio", "pulvis", "reverto"],
      3,
      4,
      "God's withdrawal brings dissolution; His absence leads to death and return to dust",
      "Augustine interprets this as the natural consequence of sin: without God's sustaining spirit, all flesh returns to its original dust — a reminder of mortality (Enarr. Ps. 103.7)."
    ),
    (
      "Divine Renewal → Cosmic Praise",
      "God's breath renews all life, awakening creation to sing His glory",
      ["emitto", "spiritus", "creo", "renovo", "facies", "terra", "gloria", "dominus", "laetor", "opus"],
      5,
      6,
      "God's spirit renews creation, prompting universal praise and awe",
      "Augustine sees this as the triumph of grace: God's spirit does not merely restore, but renews the face of the earth — a foreshadowing of resurrection (Enarr. Ps. 103.8)."
    ),
    (
      "Divine Power → Human Worship",
      "The psalmist responds to God's sovereign power with awe-filled praise",
      ["respicio", "terra", "tremo", "tango", "mons", "fumigo", "canto", "dominus", "vita", "psallo", "deus"],
      7,
      8,
      "God's power over nature inspires the psalmist's personal worship",
      "Augustine notes that the psalmist's song is not merely poetic but existential — his entire life becomes a hymn to the God who commands nature (Enarr. Ps. 103.11)."
    ),
    (
      "Joyful Speech → Final Judgment",
      "The righteous delight in God’s presence, while the wicked face eternal ruin",
      ["iucundus", "eloquium", "delecto", "dominus", "deficio", "peccator", "iniquus", "benedicere", "anima"],
      9,
      11,
      "The psalmist's delight in God contrasts with the fate of the wicked",
      "Augustine reads this as the soul's longing: to be pleasing to God, while desiring the eradication of evil — not out of malice, but for the restoration of divine order (Enarr. Ps. 103.14)."
    )
  ]
  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "God’s absolute authority over creation and life",
      ["dominus", "dare", "aufero", "emitto", "creo", "renovare", "respicio", "tango"],
      ThemeCategory.divine,
      1 ... 11
    ),
    (
      "Providence",
      "God’s daily care for all creatures",
      ["exspecto", "escam", "colligo", "implere", "bonitas", "tempus"],
      .divine,
      4 ... 5
    ),
    (
      "Mortality and Return",
      "All flesh returns to dust without God’s sustaining breath",
      ["spiritus", "deficio", "pulvis", "revertor"],
      .sin,
      6 ... 7
    ),
    (
      "Renewal and Restoration",
      "God’s spirit renews the face of the earth",
      ["spiritus", "creo", "renovare", "facies", "terra"],
      .virtue,
      8 ... 8
    ),
    (
      "Cosmic Praise",
      "Creation and psalmist alike glorify God",
      ["gloria", "laetitia", "opus", "cantabo", "psallere"],
      .worship,
      9 ... 11
    ),
    (
      "Righteous Speech",
      "The psalmist seeks his words to be pleasing to God",
      ["jucundus", "eloquium", "delectatio"],
      .virtue,
      12 ... 12
    ),
    (
      "Judgment and Purification",
      "The removal of sinners from the earth",
      ["deficere", "peccator", "iniquus"],
      .justice,
      13 ... 13
    ),
    (
      "Blessing and Devotion",
      "The soul’s final act is to bless the Lord",
      ["benedicere", "anima", "dominus"],
      .worship,
      14 ... 14
    )
  ]

  func testTotalVerses()
  {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 103B should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 103B English text should have \(expectedVerseCount) verses")
    // Validate orthography
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas()
  {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes()
  {
    // Verify structural theme lemmas are in lineKeyLemmas
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Run standard structural themes test
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes()
  {
    // Verify conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false
    )

    // Run standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveThemes()
  {
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else
    {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm103b_themes.json"
    )

    if success
    {
      print("✅ Complete themes JSON created successfully")
    }
    else
    {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testSaveTexts()
  {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm103b_texts.json"
    )

    if success
    {
      print("✅ Complete texts JSON created successfully")
    }
    else
    {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
