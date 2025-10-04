@testable import LatinService
import XCTest

class Psalm45Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 45, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 11
  private let text = [
    "Deus noster refugium et virtus; adiutor in tribulationibus, quae invenerunt nos nimis.",
    "Propterea non timebimus dum turbabitur terra, et transferentur montes in cor maris.",
    "Sonuerunt et turbatae sunt aquae eorum; conturbati sunt montes in fortitudine eius.",
    "Fluminis impetus laetificat civitatem Dei; sanctificavit tabernaculum suum Altissimus.",
    "Deus in medio eius, non commovebitur; adiuvabit eam Deus mane diluculo.",
    "Conturbatae sunt gentes, et inclinata sunt regna; dedit vocem suam, mota est terra.",
    "Dominus virtutum nobiscum; susceptor noster Deus Iacob.",
    "Venite, et videte opera Domini, quae posuit prodigia super terram.",
    "Auferens bella usque ad finem terrae, arcum conteret, et confringet arma, et scuta comburet igni.",
    "Vacate, et videte quoniam ego sum Deus; exaltabor in gentibus, exaltabor in terra.",
    "Dominus virtutum nobiscum; susceptor noster Deus Iacob."
  ]

  private let englishText = [
    "God is our refuge and strength; a very present help in trouble.",
    "Therefore we will not fear, though the earth should change, and though the mountains be moved into the heart of the sea.",
    "Its waters roar and are troubled; the mountains shake with its swelling.",
    "There is a river whose streams make glad the city of God, the holy habitation of the Most High.",
    "God is in the midst of her; she shall not be moved: God will help her at the break of dawn.",
    "The nations raged, the kingdoms were moved; he uttered his voice, the earth melted.",
    "The Lord of hosts is with us; the God of Jacob is our refuge.",
    "Come, behold the works of the Lord, what desolations he has made in the earth.",
    "He makes wars to cease to the end of the earth; he breaks the bow, and cuts the spear in two; he burns the chariots with fire.",
    "Be still, and know that I am God: I will be exalted among the nations, I will be exalted in the earth.",
    "The Lord of hosts is with us; the God of Jacob is our refuge."
  ]

  private let lineKeyLemmas = [
    (1, ["deus", "refugium", "virtus", "adiutor", "tribulatio"]),
    (2, ["timeo", "turbo", "terra", "transfero", "mons", "cor", "mare"]),
    (3, ["sono", "turbo", "aqua", "conturbo", "mons", "fortitudo"]),
    (4, ["flumen", "impetus", "laetifico", "civitas", "deus", "sanctifico", "tabernaculum", "altissimus"]),
    (5, ["deus", "medius", "commoveo", "adiuvo", "mane", "diluculum"]),
    (6, ["conturbo", "gens", "inclino", "regnum", "vox", "moveo", "terra"]),
    (7, ["dominus", "virtus", "susceptor", "deus", "iacob"]),
    (8, ["venio", "video", "opus", "dominus", "prodigium", "terra"]),
    (9, ["aufero", "bellum", "finis", "terra", "arcus", "contero", "confringo", "arma", "scutum", "comburo", "ignis"]),
    (10, ["vacate", "video", "deus", "exalto", "gens", "terra"]),
    (11, ["dominus", "virtus", "susceptor", "deus", "iacob"]),
  ]

  private let structuralThemes = [
    (
      "Divine Refuge → Fearless Trust",
      "God as refuge and strength leading to fearless trust despite earthly turmoil",
      ["deus", "refugium", "virtus", "timeo", "turbo", "terra"],
      1,
      2,
      "The psalmist declares God as refuge and strength, then expresses fearless trust even when the earth changes and mountains move into the sea.",
      "Augustine sees this as the soul's recognition that God is the only true refuge from all earthly troubles. When the soul abides in God, no earthly catastrophe can shake its foundation, for God's strength surpasses all natural forces."
    ),
    (
      "Waters Roaring → Divine City",
      "Troubled waters and mountains shaking contrasted with the gladdening river of God's city",
      ["sono", "aqua", "conturbo", "flumen", "laetifico", "civitas"],
      3,
      4,
      "The psalm describes how waters roar and mountains shake with divine power, but then presents the river that makes glad the city of God, where the Most High has sanctified His tabernacle.",
      "Augustine interprets this as the contrast between worldly chaos and divine peace. The roaring waters represent earthly troubles, while the gladdening river represents the grace of God flowing through His Church, bringing joy and sanctification."
    ),
    (
      "Divine Presence → Nations Disturbed",
      "God's presence providing stability while nations rage and kingdoms fall",
      ["deus", "medius", "commoveo", "adiuvo", "gens", "inclino", "regnum"],
      5,
      6,
      "God is in the midst of the city and it shall not be moved, for God helps at dawn, while the nations rage and kingdoms are moved when God utters His voice and the earth melts.",
      "For Augustine, this represents God's protection of His Church. While the world around may be in turmoil and kingdoms may fall, those who dwell in God's presence remain secure, for His voice has power over all earthly powers."
    ),
    (
      "Lord of Hosts → Divine Works",
      "Recognition of God as Lord of hosts leading to invitation to behold His mighty works",
      ["dominus", "virtus", "susceptor", "venio", "video", "opus", "prodigium"],
      7,
      8,
      "The Lord of hosts is with us as our refuge, then the psalmist invites all to come and see the works of the Lord and the prodigies He has set upon the earth.",
      "Augustine sees this as the soul's confident proclamation of God's presence and power, followed by the call to witness God's mighty acts. The Lord of hosts represents God's omnipotence over all creation and His protection of His people."
    ),
    (
      "Ending Wars → Divine Exaltation",
      "God ending wars and breaking weapons leading to His exaltation among nations",
      ["aufero", "bellum", "arcus", "contero", "confringo", "arma", "exalto", "gens"],
      9,
      10,
      "God makes wars cease to the end of the earth, breaking bows and weapons, then declares Himself as God who will be exalted among the nations and in the earth.",
      "Augustine interprets this as God's ultimate victory over all conflict and His establishment of eternal peace. The breaking of weapons symbolizes the end of all hostility, while God's exaltation represents His universal sovereignty and the final triumph of His kingdom."
    ),
    (
      "Divine Refuge (Final)",
      "Final affirmation of God as Lord of hosts and refuge for His people",
      ["dominus", "virtus", "susceptor", "deus", "iacob"],
      11,
      11,
      "The psalm concludes by repeating that the Lord of hosts is with us and is our refuge, the God of Jacob.",
      "Augustine sees this repetition as the soul's final affirmation and confidence in God's protection. The reference to Jacob reminds us that God is the God of the patriarchs and maintains His covenant faithfulness to His chosen people throughout all generations."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Protection",
      "God as refuge, strength, and help in times of trouble",
      ["deus", "refugium", "virtus", "adiutor", "susceptor"],
      ThemeCategory.divine,
      1 ... 11
    ),
    (
      "Earthly Turmoil",
      "Natural disasters and earthly chaos contrasted with divine stability",
      ["turbo", "terra", "mons", "mare", "aqua", "sono", "conturbo"],
      ThemeCategory.conflict,
      1 ... 6
    ),
    (
      "Divine City",
      "The city of God as a place of joy, sanctification, and divine presence",
      ["civitas", "deus", "laetifico", "sanctifico", "tabernaculum", "altissimus"],
      ThemeCategory.worship,
      4 ... 5
    ),
    (
      "Nations and Kingdoms",
      "Earthly powers that rage against God but ultimately fall",
      ["gens", "regnum", "inclino", "vox", "moveo"],
      ThemeCategory.opposition,
      6 ... 10
    ),
    (
      "Divine Works",
      "God's mighty acts and prodigies that demonstrate His power",
      ["opus", "dominus", "prodigium", "terra", "aufero", "bellum"],
      ThemeCategory.divine,
      7 ... 9
    ),
    (
      "Weapons and Warfare",
      "Military imagery representing conflict and God's victory over it",
      ["arcus", "contero", "confringo", "arma", "scutum", "comburo", "ignis"],
      ThemeCategory.conflict,
      9 ... 9
    ),
    (
      "Divine Exaltation",
      "God's sovereignty and elevation above all nations and earth",
      ["exalto", "gens", "terra", "deus"],
      ThemeCategory.divine,
      10 ... 11
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 45 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 45 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm45_texts.json"
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
      filename: "output_psalm45_themes.json"
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
