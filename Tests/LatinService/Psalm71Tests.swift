@testable import LatinService
import XCTest

class Psalm71Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 71, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 20
  private let text = [
    "Deus, iudicium tuum regi da, et iustitiam tuam filio regis.",
    "iudicare populum tuum in iustitia, et pauperes tuos in iudicio.",
    "Suscipiant montes pacem populo, et colles iustitiam.",
    "iudicabit pauperes populi, et salvos faciet filios pauperum, et humiliabit calumniatorem.",
    "Et permanebit cum sole, et ante lunam, in generatione et generationem.",

    "Descendet sicut pluvia in vellus, et sicut stillicidia stillantia super terram.",
    "Orietur in diebus eius iustitia, et abundantia pacis, donec auferatur luna.",
    "Et dominabitur a mari usque ad mare, et a flumine usque ad terminos orbis terrarum.",
    "Coram illo procident Aethiopes, et inimici eius terram lingent.",
    "Reges Tharsis et insulae munera offerent; reges Arabum et Saba dona adducent.",

    "Et adorabunt eum omnes reges terrae; omnes gentes servient ei.",
    "Quia liberabit pauperem a potente, et pauperem cui non erat adiutor.",
    "Parcet pauperi et inopi, et animas pauperum salvas faciet.",
    "Ex usuris et iniquitate redimet animas eorum, et honorabile nomen eorum coram illo.",
    "Et vivet, et dabitur ei de auro Arabiae; et orabunt pro eo semper, tota die benedicent ei.",

    "Erit firmamentum in terra in summis montium; superextolletur fructus eius super Libanum; et florebunt de civitate sicut fenum terrae.",
    "Sit nomen eius benedictum in saecula; ante solem permanebit nomen eius.",
    "Et benedicentur in ipso omnes tribus terrae; omnes gentes magnificabunt eum.",
    "Benedictus Dominus Deus Israel, qui facit mirabilia solus.",
    "Et benedictum nomen maiestatis eius in aeternum; et replebitur maiestate eius omnis terra. Fiat, fiat.",
  ]

  private let englishText = [
    "Give to the king thy judgment, O God, and to the king's son thy justice.",
    "To judge thy people with justice, and thy poor with judgment.",
    "Let the mountains receive peace for the people, and the hills justice.",
    "He shall judge the poor of the people, and he shall save the children of the poor, and he shall humble the oppressor.",
    "And he shall continue with the sun, and before the moon, throughout all generations.",
    "He shall come down like rain upon the fleece, and as showers falling gently upon the earth.",
    "In his days shall justice spring up, and abundance of peace, till the moon be taken away.",
    "And he shall rule from sea to sea, and from the river unto the ends of the earth.",
    "Before him the Ethiopians shall fall down, and his enemies shall lick the ground.",
    "The kings of Tharsis and the islands shall offer presents; the kings of the Arabians and of Saba shall bring gifts.",
    "And all kings of the earth shall adore him; all nations shall serve him.",
    "For he shall deliver the poor from the mighty, and the needy that had no helper.",
    "He shall spare the poor and needy, and he shall save the souls of the poor.",
    "He shall redeem their souls from usuries and iniquity, and their names shall be honourable in his sight.",
    "And he shall live, and to him shall be given of the gold of Arabia; and they shall pray for him continually, all the day shall they bless him.",
    "There shall be a firmament on the earth on the tops of mountains; the fruit thereof shall be exalted above Libanus; and they shall flourish out of the city like the grass of the earth.",
    "Blessed be his name for evermore; his name continueth before the sun.",
    "And in him shall all the tribes of the earth be blessed; all nations shall magnify him.",
    "Blessed be the Lord, the God of Israel, who alone doth wonderful things.",
    "And blessed be the name of his majesty for ever; and the whole earth shall be filled with his majesty. So be it, so be it.",
  ]

  private let lineKeyLemmas = [
    (1, ["deus", "iudicium", "rex", "do", "iustitia", "filius", "rex"]),
    (2, ["iudico", "populus", "iustitia", "pauper", "iudicium"]),
    (3, ["suscipio", "mons", "pax", "populus", "collis", "iustitia"]),
    (4, ["iudico", "pauper", "populus", "salvus", "facio", "filius", "pauper", "humilio", "calumniator"]),
    (5, ["permaneo", "sol", "ante", "luna", "generatio"]),
    (6, ["descendo", "sicut", "pluvia", "vellus", "stillicidium", "stillo", "super", "terra"]),
    (7, ["orior", "dies", "iustitia", "abundantia", "pax", "donec", "aufero", "luna"]),
    (8, ["dominor", "mare", "usque", "mare", "flumen", "usque", "terminus", "orbis", "terra"]),
    (9, ["coram", "procido", "aethiops", "inimicus", "terra", "lingo"]),
    (10, ["rex", "tharsis", "insula", "munus", "offero", "rex", "arabs", "saba", "donum", "adduco"]),
    (11, ["adoro", "omnis", "rex", "terra", "omnis", "gens", "servio"]),
    (12, ["quia", "libero", "pauper", "potens", "pauper", "adiutor"]),
    (13, ["parco", "pauper", "inops", "anima", "pauper", "salvo", "facio"]),
    (14, ["usura", "iniquitas", "redimo", "anima", "honorabilis", "nomen", "coram"]),
    (15, ["vivo", "do", "aurum", "arabia", "oro", "pro", "semper", "totus", "dies", "benedico"]),
    (16, ["firmamentum", "terra", "summus", "mons", "superextollo", "fructus", "super", "libanus", "floreo", "civitas", "sicut", "fenum", "terra"]),
    (17, ["nomen", "benedictus", "saeculum", "ante", "sol", "permaneo", "nomen"]),
    (18, ["benedico", "omnis", "tribus", "terra", "omnis", "gens", "magnifico"]),
    (19, ["benedictus", "dominus", "deus", "israel", "facio", "mirabilis", "solus"]),
    (20, ["benedictus", "nomen", "maiestas", "aeternus", "repleo", "omnis", "terra", "fio"]),
  ]

  private let structuralThemes = [
    (
      "Divine Justice for King → People's Judgment",
      "Prayer for divine justice to be given to the king and his son for judging the people",
      ["rex", "do", "iustitia", "filius", "iudico", "pauper"],
      1,
      2,
      "The psalmist prays that God give His judgment to the king and His justice to the king's son, that they may judge God's people with justice and His poor with judgment.",
      "Augustine sees this as the soul's recognition that earthly rulers need divine wisdom and justice to govern rightly, where human authority must be grounded in God's perfect justice to serve His people properly."
    ),
    (
      "Mountain Peace → Poor Justice",
      "The mountains receiving peace and the king judging the poor with justice",
      ["suscipio", "mons", "pax", "collis", "salvus", "humilio", "calumniator"],
      3,
      4,
      "The psalmist prays that mountains receive peace for the people and hills receive justice, then describes how the king will judge the poor of the people, save the children of the poor, and humble the oppressor.",
      "For Augustine, this represents the soul's vision of cosmic harmony where natural creation participates in divine peace, and earthly rulers exercise justice that protects the vulnerable and humbles the powerful."
    ),
    (
      "Eternal Duration → Gentle Descent",
      "The king's eternal duration with sun and moon, descending like gentle rain",
      ["permaneo", "generatio", "descendo", "pluvia", "vellus", "stillicidium"],
      5,
      6,
      "The psalmist describes how the king will continue with the sun and before the moon throughout all generations, then how he will descend like rain upon the fleece and as gentle showers upon the earth.",
      "Augustine sees this as the soul's recognition of the king's eternal nature and gentle rule, where divine authority endures through all time and manifests with the gentleness of life-giving rain."
    ),
    (
      "Justice Springing → Universal Dominion",
      "Justice springing up in the king's days leading to universal dominion from sea to sea",
      ["orior", "abundantia", "aufero", "dominor", "mare", "orbis"],
      7,
      8,
      "The psalmist describes how justice will spring up in the king's days with abundance of peace until the moon is taken away, then how he will rule from sea to sea and from the river to the ends of the earth.",
      "For Augustine, this represents the soul's vision of the messianic kingdom where divine justice brings universal peace and the king's dominion extends over all creation, fulfilling God's cosmic purpose."
    ),
    (
      "Enemy Submission → Kingly Gifts",
      "Enemies falling before the king and foreign kings bringing gifts and offerings",
      ["procido", "aethiops", "lingo", "tharsis", "munus", "saba"],
      9,
      10,
      "The psalmist describes how Ethiopians will fall down before the king and his enemies will lick the ground, then how kings of Tharsis and islands will offer presents, and kings of Arabia and Saba will bring gifts.",
      "Augustine sees this as the soul's recognition of the king's universal authority, where all nations acknowledge his sovereignty through submission and tribute, fulfilling the promise of universal worship."
    ),
    (
      "Universal Adoration → Poor Liberation",
      "All kings adoring the king and his liberation of the poor from the mighty",
      ["adoro", "servio", "libero", "potens", "adiutor"],
      11,
      12,
      "The psalmist describes how all kings of the earth will adore the king and all nations will serve him, then explains that he will deliver the poor from the mighty and the needy who have no helper.",
      "For Augustine, this represents the soul's understanding that true kingship serves the vulnerable, where universal authority is exercised for the liberation of the oppressed and the protection of the helpless."
    ),
    (
      "Poor Protection → Soul Redemption",
      "The king sparing the poor and needy, then redeeming their souls from usury and iniquity",
      ["parco", "inops", "usura", "redimo", "honorabilis"],
      13,
      14,
      "The psalmist describes how the king will spare the poor and needy and save the souls of the poor, then how he will redeem their souls from usury and iniquity, making their names honorable in his sight.",
      "For Augustine, this represents the soul's recognition that true justice addresses both material and spiritual needs, where the king's protection extends to the soul's redemption from economic and moral oppression."
    ),
    (
      "Eternal Life → Earthly Prosperity",
      "The king's eternal life and gold from Arabia leading to earthly prosperity and flourishing",
      ["aurum", "arabia", "firmamentum", "superextollo", "libanus", "floreo"],
      15,
      16,
      "The psalmist describes how the king will live and be given gold from Arabia, with people praying for him continually and blessing him all day, then how there will be a firmament on earth with fruit exalted above Lebanon and flourishing like grass.",
      "For Augustine, this represents the soul's vision of the king's eternal reign bringing earthly prosperity, where divine blessing manifests in both spiritual devotion and natural abundance, fulfilling creation's potential."
    ),
    (
      "Eternal Name → Universal Blessing",
      "The king's name blessed forever leading to universal blessing of all tribes and nations",
      ["benedictus", "saeculum", "permaneo", "tribus", "magnifico"],
      17,
      18,
      "The psalmist describes how the king's name will be blessed forever and continue before the sun, then how all tribes of the earth will be blessed in him and all nations will magnify him.",
      "For Augustine, this represents the soul's recognition that the king's eternal name becomes the source of universal blessing, where his enduring glory brings divine favor to all peoples and nations."
    ),
    (
      "Divine Praise → Eternal Majesty",
      "Praise for the Lord God of Israel who alone does wonderful things, leading to eternal majesty",
      ["israel", "mirabilis", "solus", "maiestas", "aeternus", "repleo"],
      19,
      20,
      "The psalmist blesses the Lord God of Israel who alone does wonderful things, then blesses the name of His majesty forever, declaring that the whole earth will be filled with His majesty, ending with 'So be it, so be it.'",
      "For Augustine, this represents the soul's ultimate doxology where all praise returns to God alone, recognizing that the king's authority flows from divine majesty that fills all creation and endures forever."
    ),
  ]

  private let conceptualThemes = [
    (
      "Kingly Authority and Rule",
      "References to kingship, royal authority, and earthly governance",
      ["rex", "filius", "rex", "dominor", "coram", "procido", "adoro", "servio"],
      ThemeCategory.divine,
      1 ... 18
    ),
    (
      "Poor and Vulnerable",
      "References to the poor, needy, and vulnerable who need protection",
      ["pauper", "inops", "anima", "pauper", "salvus", "facio", "libero", "potens", "adiutor"],
      ThemeCategory.virtue,
      2 ... 15
    ),
    (
      "Universal Dominion and Peace",
      "References to universal rule, peace, and cosmic harmony",
      ["pax", "populus", "iustitia", "abundantia", "pax", "mare", "orbis", "terra", "omnis", "gens"],
      ThemeCategory.divine,
      3 ... 18
    ),
    (
      "Natural Elements and Creation",
      "References to mountains, sun, moon, rain, and natural phenomena",
      ["mons", "collis", "sol", "luna", "pluvia", "vellus", "stillicidium", "terra", "firmamentum", "libanus", "fenum"],
      ThemeCategory.divine,
      3 ... 16
    ),
    (
      "Foreign Nations and Gifts",
      "References to foreign kings, nations, and their offerings",
      ["aethiops", "inimicus", "tharsis", "insula", "arabs", "saba", "munus", "donum", "tribus"],
      ThemeCategory.worship,
      9 ... 18
    ),
    (
      "Eternal Duration and Blessing",
      "References to eternal life, blessing, and everlasting praise",
      ["permaneo", "generatio", "benedictus", "saeculum", "aeternus", "semper", "maiestas"],
      ThemeCategory.divine,
      5 ... 20
    ),
    (
      "Redemption and Liberation",
      "References to saving, redeeming, and liberating the oppressed",
      ["salvus", "facio", "humilio", "libero", "redimo", "usura", "iniquitas", "honorabilis"],
      ThemeCategory.divine,
      4 ... 14
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 71 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 71 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm71_texts.json"
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
      filename: "output_psalm71_themes.json"
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
