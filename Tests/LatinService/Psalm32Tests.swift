import XCTest

@testable import LatinService

class Psalm32Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 32, category: nil)
  private let expectedVerseCount = 22

  // MARK: - Test Data

  private let text = [
    "Exsultate, iusti, in Domino; rectos decet collaudatio.",
    "Confitemini Domino in cithara; in psalterio decem chordarum psallite illi.",
    "Cantate ei canticum novum; bene psallite ei in vociferatione.",
    "Quia rectum est verbum Domini, et omnia opera eius in fide.",
    "Diligit misericordiam et iudicium; misericordia Domini plena est terra.",
    "Verbo Domini caeli firmati sunt; et spiritu oris eius omnis virtus eorum.",
    "Congregans sicut in utre aquas maris; ponens in thesauris abyssos.",
    "Timeat Dominum omnis terra; ab eo autem commoveantur omnes inhabitantes orbem.",
    "Quoniam ipse dixit, et facta sunt; ipse mandavit, et creata sunt.",
    "Dominus dissipat consilia gentium; reprobat autem cogitationes populorum, et reprobat consilia principum.",
    "Consilium autem Domini in aeternum manet; cogitationes cordis eius in generatione et generationem.",
    "Beata gens, cuius est Dominus Deus eius; populus, quem elegit in hereditatem sibi.",
    "De caelo respexit Dominus; vidit omnes filios hominum.",
    "De praeparato habitaculo suo respexit super omnes, qui habitant terram.",
    "Qui finxit sigillatim corda eorum; qui intelligit omnia opera eorum.",
    "Non salvatur rex per multam virtutem; et gigas non salvabitur in multitudine virtutis suae.",
    "Fallax equus ad salutem; in abundantia autem virtutis suae non salvabitur.",
    "Ecce oculi Domini super metuentes eum; et in eis, qui sperant super misericordia eius.",
    "Ut eruat a morte animas eorum; et alat eos in fame.",
    "Anima nostra sustinet Dominum; quoniam adiutor et protector noster est.",
    "Quia in eo laetabitur cor nostrum; et in nomine sancto eius speravimus.",
    "Fiat misericordia tua, Domine, super nos; quemadmodum speravimus in te.",
  ]

  private let englishText = [
    "Rejoice in the Lord, O ye righteous: for praise is comely for the upright.",
    "Praise the Lord with harp: sing unto him with the psaltery and an instrument of ten strings.",
    "Sing unto him a new song; play skilfully with a loud noise.",
    "For the word of the Lord is right; and all his works are done in truth.",
    "He loveth righteousness and judgment: the earth is full of the goodness of the Lord.",
    "By the word of the Lord were the heavens made; and all the host of them by the breath of his mouth.",
    "He gathereth the waters of the sea together as an heap: he layeth up the depth in storehouses.",
    "Let all the earth fear the Lord: let all the inhabitants of the world stand in awe of him.",
    "For he spake, and it was done; he commanded, and it stood fast.",
    "The Lord bringeth the counsel of the heathen to nought: he maketh the devices of the people of none effect.",
    "The counsel of the Lord standeth for ever, the thoughts of his heart to all generations.",
    "Blessed is the nation whose God is the Lord; and the people whom he hath chosen for his own inheritance.",
    "The Lord looketh from heaven; he beholdeth all the sons of men.",
    "From the place of his habitation he looketh upon all the inhabitants of the earth.",
    "He fashioneth their hearts alike; he considereth all their works.",
    "There is no king saved by the multitude of an host: a mighty man is not delivered by much strength.",
    "An horse is a vain thing for safety: neither shall he deliver any by his great strength.",
    "Behold, the eye of the Lord is upon them that fear him, upon them that hope in his mercy;",
    "To deliver their soul from death, and to keep them alive in famine.",
    "Our soul waiteth for the Lord: he is our help and our shield.",
    "For our heart shall rejoice in him, because we have trusted in his holy name.",
    "Let thy mercy, O Lord, be upon us, according as we hope in thee.",
  ]

  private let lineKeyLemmas = [
    (1, ["exsulto", "iustus", "dominus", "rectus", "decet", "collaudatio"]),
    (2, ["confiteor", "dominus", "cithara", "psalterium", "decem", "chorda", "psallo"]),
    (3, ["canto", "canticum", "novus", "bene", "psallo", "vociferatio"]),
    (4, ["rectus", "verbum", "dominus", "omnis", "opus", "fides"]),
    (5, ["diligo", "misericordia", "iudicium", "misericordia", "dominus", "plenus", "terra"]),
    (6, ["verbum", "dominus", "caelum", "firmo", "spiritus", "os", "omnis", "virtus"]),
    (7, ["congrego", "uter", "aqua", "mare", "pono", "thesaurus", "abyssus"]),
    (8, ["timeo", "dominus", "omnis", "terra", "commoveo", "omnis", "inhabito", "orbis"]),
    (9, ["dico", "facio", "mando", "creo"]),
    (
      10,
      [
        "dominus", "dissipo", "consilium", "gens", "reprobo", "cogitatio", "populus", "consilium",
        "princeps",
      ]
    ),
    (11, ["consilium", "dominus", "aeternus", "maneo", "cogitatio", "cor", "generatio"]),
    (12, ["beatus", "gens", "dominus", "deus", "populus", "eligo", "hereditas"]),
    (13, ["caelum", "respicio", "dominus", "video", "omnis", "filius", "homo"]),
    (14, ["praeparo", "habitaculum", "respicio", "super", "omnis", "habito", "terra"]),
    (15, ["fingo", "sigillatim", "cor", "intelligo", "omnis", "opus"]),
    (16, ["salvo", "rex", "multus", "virtus", "gigas", "salvo", "multitudo", "virtus"]),
    (17, ["fallax", "equus", "salus", "abundantia", "virtus", "salvo"]),
    (18, ["oculus", "dominus", "super", "metuo", "spero", "misericordia"]),
    (19, ["eruo", "mors", "anima", "alo", "fames"]),
    (20, ["anima", "sustineo", "dominus", "adiutor", "protector"]),
    (21, ["laetor", "cor", "nomen", "sanctus", "spero"]),
    (22, ["misericordia", "dominus", "super", "spero"]),
  ]

  private let structuralThemes = [
    (
      "Call to Praise",
      "Invitation to rejoice and worship with music",
      ["exsulto", "iustus", "confiteor", "cithara", "psalterium", "canto", "canticum"],
      1,
      3,
      "The psalm opens with a call for the righteous to rejoice in the Lord and praise him with musical instruments.",
      "Augustine sees this as the fundamental duty of the righteous: to offer joyful praise to God through music and song (Enarr. Ps. 32.1-3)."
    ),
    (
      "Divine Righteousness",
      "God's word and works are just and faithful",
      ["rectus", "verbum", "opus", "fides", "diligo", "misericordia", "iudicium"],
      4,
      5,
      "The psalmist declares that the Lord's word is right and all his works are done in truth, and that he loves righteousness and judgment.",
      "Augustine emphasizes that God's righteousness is the foundation of all his works. His love for mercy and judgment reflects divine justice (Enarr. Ps. 32.4-5)."
    ),
    (
      "Creation and Sovereignty",
      "God's creative power and universal authority",
      ["verbum", "caelum", "firmo", "spiritus", "congrego", "aqua", "mare", "timeo", "commoveo"],
      6,
      9,
      "The psalm describes God's creation of the heavens and his sovereignty over all the earth, emphasizing his creative word and command.",
      "Augustine interprets this as demonstrating God's absolute sovereignty over creation. His word brings everything into being and sustains all things (Enarr. Ps. 32.6-9)."
    ),
    (
      "Divine Wisdom vs. Human Plans",
      "Contrast between God's eternal counsel and human schemes",
      ["consilium", "dissipo", "reprobo", "cogitatio", "aeternus", "maneo", "beatus", "eligo"],
      10,
      12,
      "The psalm contrasts the Lord's eternal counsel with the futile plans of nations and peoples, blessing those who have the Lord as their God.",
      "Augustine sees this as the fundamental distinction between divine wisdom and human folly. God's counsel endures forever while human plans come to nothing (Enarr. Ps. 32.10-12)."
    ),
    (
      "Divine Omniscience and Providence",
      "God's all-seeing knowledge and care for humanity",
      ["respicio", "video", "fingo", "intelligo", "opus", "oculus", "timeo", "spero"],
      13,
      18,
      "The psalm describes God's omniscient gaze upon all humanity and his providential care for those who fear him and hope in his mercy.",
      "Augustine emphasizes that God's omniscience is not merely observation but active providence. He sees and cares for those who trust in him (Enarr. Ps. 32.13-18)."
    ),
    (
      "Trust and Deliverance",
      "From human weakness to divine protection and mercy",
      [
        "salvo", "virtus", "eruo", "mors", "sustineo", "adiutor", "protector", "laetor",
        "misericordia",
      ],
      16,
      22,
      "The psalm concludes with the futility of human strength and the blessedness of trusting in the Lord's mercy and protection.",
      "Augustine sees this as the ultimate lesson: human strength is vain, but those who trust in the Lord receive his mercy and protection (Enarr. Ps. 32.16-22)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Joyful Worship",
      "Rejoicing and praising God with music",
      ["exsulto", "confiteor", "cithara", "psalterium", "canto", "canticum", "psallo"],
      ThemeCategory.worship,
      nil as ClosedRange<Int>?
    ),
    (
      "Divine Righteousness",
      "God's just character and faithful works",
      ["rectus", "verbum", "opus", "fides", "diligo", "misericordia", "iudicium"],
      .justice,
      4...5
    ),
    (
      "Creation and Sovereignty",
      "God's creative power and universal rule",
      ["verbum", "caelum", "firmo", "spiritus", "congrego", "aqua", "mare", "timeo", "commoveo"],
      .divine,
      6...9
    ),
    (
      "Divine Wisdom",
      "God's eternal counsel versus human plans",
      ["consilium", "dissipo", "reprobo", "cogitatio", "aeternus", "maneo"],
      .divine,
      10...11
    ),
    (
      "Blessedness",
      "The happiness of those chosen by God",
      ["beatus", "gens", "eligo", "hereditas"],
      .virtue,
      12...12
    ),
    (
      "Divine Omniscience",
      "God's all-seeing knowledge of humanity",
      ["respicio", "video", "fingo", "intelligo", "oculus"],
      .divine,
      13...15
    ),
    (
      "Human Weakness",
      "The futility of human strength without God",
      ["salvo", "virtus", "gigas", "fallax", "equus"],
      .sin,
      16...17
    ),
    (
      "Divine Protection",
      "God's care for those who fear and trust him",
      ["timeo", "spero", "misericordia", "eruo", "adiutor", "protector"],
      .divine,
      18...22
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 32 should have \(expectedVerseCount) verses")
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 32 English text should have \(expectedVerseCount) verses")
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
      failOnMissing: false  // Conceptual themes may have additional imagery lemmas
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
      filename: "output_psalm32_themes.json"
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
      filename: "output_psalm32_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
