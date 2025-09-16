import XCTest

@testable import LatinService

class Psalm2Tests: XCTestCase {
  // private var latinService: LatinService!
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
//        latinService = LatinService.shared
  }

  let id = PsalmIdentity(number: 2, category: nil)
  private let expectedVerseCount = 13

  // MARK: - Test Data

  private let text = [
    "Quare fremuerunt gentes, et populi meditati sunt inania?",
    "Astiterunt reges terrae, et principes convenerunt in unum adversus Dominum, et adversus christum eius.",
    "Dirumpamus vincula eorum, et proiciamus a nobis iugum ipsorum.",
    "Qui habitat in caelis irridebit eos, et Dominus subsannabit eos.",
    "Tunc loquetur ad eos in ira sua, et in furore suo conturbabit eos.",
    "Ego autem constitutus sum rex ab eo super Sion montem sanctum eius, praedicans praeceptum eius.",
    "Dominus dixit ad me: Filius meus es tu, ego hodie genui te.",
    "Postula a me, et dabo tibi gentes hereditatem tuam, et possessionem tuam terminos terrae.",
    "Reges eos in virga ferrea, et tamquam vas figuli confringes eos.",
    "Et nunc, reges, intelligite; erudimini, qui iudicatis terram.",
    "Servite Domino in timore, et exsultate ei cum tremore.",
    "Apprehendite disciplinam, nequando irascatur Dominus, et pereatis de via iusta.",
    "Cum exarserit in brevi ira eius, beati omnes qui confidunt in eo.",
  ]

  private let englishText = [
    "Why have the Gentiles raged, and the people devised vain things?",
    "The kings of the earth stood up, and the princes met together, against the Lord, and against his Christ.",
    "Let us break their bonds asunder: and let us cast away their yoke from us.",
    "He that dwelleth in heaven shall laugh at them: and the Lord shall deride them.",
    "Then shall he speak to them in his anger, and trouble them in his rage.",
    "But I am appointed king by him over Sion his holy mountain, preaching his commandment.",
    "The Lord hath said to me: Thou art my son, this day have I begotten thee.",
    "Ask of me, and I will give thee the Gentiles for thy inheritance, and the utmost parts of the earth for thy possession.",
    "Thou shalt rule them with a rod of iron, and shalt break them in pieces like a potter's vessel.",
    "And now, O ye kings, understand: receive instruction, you that judge the earth.",
    "Serve ye the Lord with fear: and rejoice unto him with trembling.",
    "Embrace discipline, lest at any time the Lord be angry, and you perish from the just way.",
    "When his wrath shall be kindled in a short time, blessed are all they that trust in him.",
  ]

  private let lineKeyLemmas = [
    (1, ["fremo", "gens", "populus", "meditor", "inanis"]),
    (2, ["asto", "rex", "terra", "princeps", "convenio", "adversus", "dominus", "christus"]),
    (3, ["dirumpo", "vinculum", "proicio", "iugum"]),
    (4, ["habito", "caelum", "irrideo", "dominus", "subsanno"]),
    (5, ["loquor", "ira", "furor", "conturbo"]),
    (6, ["constituo", "rex", "sion", "mons", "sanctus", "praedico", "praeceptum"]),
    (7, ["dominus", "dico", "filius", "hodie", "gigno"]),
    (8, ["postulo", "do", "gens", "hereditas", "possessio", "terminus", "terra"]),
    (9, ["rego", "virga", "ferreus", "vas", "figulus", "confringo"]),
    (10, ["intelligo", "erudio", "iudico", "terra"]),
    (11, ["servio", "dominus", "timor", "exsulto", "tremor"]),
    (12, ["apprehendo", "disciplina", "irascor", "dominus", "pereo", "via", "iustus"]),
    (13, ["beatus", "omnis", "confido"]),
  ]

  private let structuralThemes = [
    (
      "Rage → Opposition",
      "From the turmoil of nations to defiance against the Lord and His Christ",
      ["fremo", "inanis", "christus"],
      1,
      2,
      "Nations rage in vanity, rulers set themselves against the Lord and His Anointed, revealing the futility of human power against divine kingship.",
      "Augustine interprets this as the nations plotting against Christ and His Church, yet all human counsels are 'inania'—empty—before the eternal decree of God (Enarr. Ps. 2.1–2)."
    ),
    (
      "Chains → Laughter",
      "From rebellion against divine bonds to God's derision from heaven",
      ["vinculum", "iugum", "irrideo"],
      3,
      4,
      "The peoples reject the Lord's yoke as bondage, but God responds not with fear but with laughter, revealing their revolt as powerless.",
      "Augustine notes that what the proud see as 'chains' are in fact bonds of love and discipline; God mocks their rebellion as vain pretension (Enarr. Ps. 2.3–4)."
    ),
    (
      "Wrath → Installation",
      "From divine anger to the establishment of the true King on Zion",
      ["ira", "furor", "rex", "sion"],
      5,
      6,
      "God answers with wrath, establishing His chosen king upon Zion, His holy mountain.",
      "Augustine reads Zion as the Church, the place where Christ reigns despite worldly rage; God's anger here manifests as His unshakable justice (Enarr. Ps. 2.5–6)."
    ),
    (
      "Sonship → Inheritance",
      "From divine begetting to the universal rule of the Son",
      ["filius", "gigno", "hereditas"],
      7,
      8,
      "The Lord declares the King to be His begotten Son and grants Him all nations as inheritance and possession.",
      "For Augustine, 'hodie genui te' refers to the eternal generation of the Son and also to the Resurrection; the inheritance is the Church drawn from all nations (Enarr. Ps. 2.7–8)."
    ),
    (
      "Rod → Shattering",
      "From rule with iron to the breaking of resistance",
      ["virga", "ferreus", "confringo"],
      9,
      10,
      "The Messiah rules with a rod of iron, shattering nations like fragile pottery, yet kings are called to wisdom and instruction.",
      "Augustine notes the dual sense: the iron rod is both severe judgment and the firm, unbreakable discipline of Christ, which smashes pride but also reforms the humble (Enarr. Ps. 2.9–10)."
    ),
    (
      "Service → Trust",
      "From trembling service to blessed confidence in the Lord",
      ["servio", "timor", "disciplina", "confido"],
      11,
      13,
      "The psalm ends by exhorting rulers to serve with fear, rejoice with trembling, embrace discipline, and find blessing in trust.",
      "Augustine interprets this as the movement from fear to love: discipline leads to true freedom, and blessedness belongs to all who cling to Christ in humble trust (Enarr. Ps. 2.11–12)."
    ),
  ]

  private let conceptualThemes = [
    (
      "The Futile Rebellion",
      "The nations and kings conspire vainly against the Lord's authority.",
      ["fremo", "gens", "populus", "meditor", "inanis", "convenio", "adversus", "vinculum", "iugum", "dirumpo", "proicio"],
      ThemeCategory.opposition,
      1 ... 3 as ClosedRange<Int>?
    ),
    (
      "Divine Derision & Warning",
      "God's initial response is not fear but mockery of the rebellion, followed by a terrifying warning.",
      ["irrideo", "subsanno", "ira", "loquor", "furor", "conturbo"],
      .justice,
      4 ... 5
    ),
    (
      "The Decree of Sonship",
      "The core revelation: the King on Zion is declared the Son, given absolute authority over the nations.",
      ["constituo", "rex", "filius", "gigno", "hereditas", "possessio", "terminus"],
      .divine,
      6 ... 8
    ),
    (
      "The Iron Rule of the Messiah",
      "The Son's rule will be absolute and shattering to those who resist.",
      ["rego", "virga", "ferreus", "confringo", "vas", "figulus"],
      .justice,
      9 ... 9
    ),
    (
      "The Admonition to the Rebels",
      "A direct call to the rebellious kings to act wisely and submit before it's too late.",
      ["intelligo", "erudio", "iudico", "apprehendo", "disciplina", "irascor", "pereo", "via", "iustus"],
      .justice,
      10 ... 12
    ),
    ( // Changed from ConceptualTheme to tuple
      "Paradoxical Worship",
      "The proper response to God's majesty: rejoicing with trembling, combining joy and holy fear.",
      ["servio", "timor", "exsulto", "tremor"],
      .worship,
      11 ... 11
    ),
    (
      "The Blessed Refuge",
      "The final promise of blessing for those who take refuge in the Lord alone.",
      ["beatus", "confido"],
      .virtue,
      13 ... 13
    ),
    (
      "The Sovereignty of God",
      "The ultimate theme of the psalm: God's supreme rule over human authorities.",
      ["dominus", "rex", "constituo", "rego", "iudico", "servio"],
      .divine,
      nil as ClosedRange<Int>?
    ),
  ]

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 2 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 2 English text should have \(expectedVerseCount) verses")
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
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
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
      filename: "output_psalm2_themes.json"
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
      filename: "output_psalm2_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
