@testable import LatinService
import XCTest

class Psalm41Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 41, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 16
  private let text = [
    "Quemadmodum desiderat cervus ad fontes aquarum, ita desiderat anima mea ad te, Deus.",
    "Sitivit anima mea ad Deum fortem vivum; quando veniam et apparebo ante faciem Dei?",
    "Fuerunt mihi lacrimae meae panes die ac nocte, dum dicitur mihi quotidie: Ubi est Deus tuus?",
    "Haec recordatus sum, et effudi in me animam meam; quoniam transiero in locum tabernaculi admirabilis, usque ad domum Dei.",
    "In voce exsultationis et confessionis, sonus epulantis.", /* 5 */
    "Quare tristis es, anima mea? et quare conturbas me?",
    "Spera in Deo, quoniam adhuc confitebor illi; salutare vultus mei, et Deus meus.",
    "Ad meipsum anima mea conturbata est; propterea memor ero tui de terra Iordanis, et Hermoniim a monte modico.",
    "Abyssus abyssum invocat, in voce cataractarum tuarum;",
    "Omnia excelsa tua, et fluctus tui super me transierunt.", /* 10 */
    "In die mandavit Dominus misericordiam suam, et nocte canticum eius;",
    "Apud me oratio Deo vitae meae. Dicam Deo: Susceptor meus es;",
    "Quare oblitus es mei? et quare tristis incedo, dum affligit me inimicus?",
    "Dum confringuntur ossa mea, exprobraverunt mihi qui tribulant me inimici mei, ",
    "Dum dicunt mihi per singulos dies: Ubi est Deus tuus? Quare tristis es, anima mea? et quare conturbas me?", /* 15 */
    "Spera in Deo, quoniam adhuc confitebor illi; salutare vultus mei, et Deus meus.",
  ]

  private let englishText = [
    "As the hart panteth after the fountains of water, so my soul panteth after thee, O God.",
    "My soul hath thirsted after the strong living God; when shall I come and appear before the face of God?",
    "My tears have been my bread day and night, whilst it is said to me daily: Where is thy God?",
    "These things I remembered, and poured out my soul in me; for I shall go over into the place of the wonderful tabernacle, even to the house of God.",
    "With the voice of joy and praise, the noise of one feasting.",
    "Why art thou sad, O my soul? and why dost thou trouble me?",
    "Hope in God, for I will still give praise to him; the salvation of my countenance, and my God.",
    "My soul is troubled within myself; therefore will I remember thee from the land of Jordan, and Hermoniim from the little hill.",
    "Deep calleth on deep, at the noise of thy floodgates;",
    "All thy heights and thy billows have passed over me.",
    "In the daytime the Lord hath commanded his mercy, and a canticle to him in the night;",
    "With me is prayer to the God of my life. I will say to God: Thou art my support;",
    "Why hast thou forgotten me? and why go I mourning, whilst my enemy afflicteth me?",
    "Whilst my bones are broken, my enemies who trouble me have reproached me,",
    "Whilst they say to me day by day: Where is thy God? Why art thou cast down, O my soul? and why dost thou disquiet me?",
    "Hope thou in God, for I will still give praise to him; the salvation of my countenance, and my God.",
  ]

  private let lineKeyLemmas = [
    (1, ["desidero", "cervus", "fons", "aqua", "anima", "deus"]),
    (2, ["sitio", "anima", "deus", "fortis", "vivus", "venio", "appareo", "facies", "deus"]),
    (3, ["lacrima", "panis", "dies", "nox", "dico", "quotidie", "deus"]),
    (4, ["recordor", "effundo", "anima", "transeo", "locus", "tabernaculum", "admirabilis", "domus", "deus"]),
    (5, ["vox", "exsultatio", "confessio", "sonus", "epulor"]),
    (6, ["tristis", "anima", "conturbo"]),
    (7, ["spero", "deus", "confiteor", "salutare", "vultus", "deus"]),
    (8, ["anima", "conturbo", "memor", "terra", "iordanes", "hermon", "mons", "modicus"]),
    (9, ["abyssus", "invoco", "vox", "cataracta"]),
    (10, ["excelsus", "fluctus", "transeo"]),
    (11, ["dies", "mando", "dominus", "misericordia", "nox", "canticum"]),
    (12, ["apud", "oratio", "deus", "vita", "dico", "deus", "susceptor"]),
    (13, ["obliviscor", "tristis", "incedo", "affligo", "inimicus"]),
    (14, ["confringo", "os", "exprobro", "tribulo", "inimicus"]),
    (15, ["dico", "singulus", "dies", "deus", "tristis", "anima", "conturbo"]),
    (16, ["spero", "deus", "confiteor", "salutare", "vultus", "deus"]),
  ]

  private let structuralThemes = [
    (
      "Soul's Thirst → Divine Encounter",
      "The soul's deep thirst for God leading to the desire for divine encounter",
      ["desidero", "cervus", "fons", "aqua", "anima", "sitis", "deus", "fortis", "vivus", "venio", "appareo", "facies"],
      1,
      2,
      "As the hart panteth after fountains of water, so the soul panteth after God, thirsting for the strong living God and desiring to appear before His face.",
      "Augustine sees this as the soul's natural longing for God - like a deer seeking water, the soul seeks the living God, expressing the fundamental human desire for divine encounter and communion."
    ),
    (
      "Tears and Mockery → Sacred Memory",
      "Tears as bread during mockery leading to sacred memory and journey to God's house",
      ["lacrima", "panis", "dies", "nox", "dico", "quotidie", "deus", "recordor", "effundo", "anima", "transeo", "locus", "tabernaculum", "admirabilis", "domus"],
      3,
      4,
      "Tears have been bread day and night while mocked daily about God's absence, but these things are remembered and the soul is poured out in preparation for journeying to the wonderful tabernacle of God's house.",
      "For Augustine, this represents the soul's response to persecution - tears become spiritual nourishment, and mockery leads to deeper memory and determination to reach God's dwelling place."
    ),
    (
      "Joyful Praise → Soul's Self-Questioning",
      "Voice of joy and praise contrasted with the soul questioning its own sadness",
      ["vox", "exsultatio", "confessio", "sonus", "epulor", "tristis", "anima", "conturbo"],
      5,
      6,
      "With voice of joy and praise comes the sound of feasting, but then the soul questions itself: why are you sad, O my soul, and why do you trouble me?",
      "Augustine sees this as the tension between external celebration and internal turmoil - the soul experiences both joy in God and internal questioning about its own state."
    ),
    (
      "Hope and Confession → Sacred Geography",
      "Hope in God and confession leading to remembrance from sacred places",
      ["spero", "deus", "confiteor", "salutare", "vultus", "anima", "conturbo", "memor", "terra", "iordanes", "hermon", "mons"],
      7,
      8,
      "Hope in God and confession of praise lead to the troubled soul remembering God from the land of Jordan and Hermon from the little hill.",
      "For Augustine, hope and confession lead to sacred memory - the soul recalls God's presence from specific holy places, finding comfort in geographical markers of divine encounter."
    ),
    (
      "Deep Calling Deep → Heights and Billows",
      "The depths calling to depths with heights and billows passing over",
      ["abyssus", "invoco", "vox", "cataracta", "excelsus", "fluctus", "transeo"],
      9,
      10,
      "Deep calls to deep at the noise of floodgates, with all heights and billows passing over.",
      "Augustine sees this as the soul's experience of divine depths - overwhelming waters represent the soul's deepest struggles and God's response."
    ),
    (
      "Divine Mercy → Prayer and Support",
      "Divine mercy and canticle leading to prayer and recognition of God as support",
      ["dies", "mando", "dominus", "misericordia", "nox", "canticum", "apud", "oratio", "deus", "vita", "dico", "susceptor"],
      11,
      12,
      "In daytime the Lord commands His mercy and at night His canticle, with prayer to the God of life, and the soul says to God that He is its support.",
      "For Augustine, divine mercy leads to prayer and recognition of God as the soul's ultimate support and sustainer."
    ),
    (
      "Divine Support → Enemy Reproach",
      "Recognition of God as support contrasted with enemy reproach and broken bones",
      ["obliviscor", "tristis", "incedo", "affligo", "inimicus", "confringo", "os", "exprobro", "tribulo"],
      13,
      14,
      "The soul asks why God has forgotten and why it goes mourning while enemies afflict, and while bones are broken, enemies reproach and trouble.",
      "For Augustine, this represents the soul's honest questioning of God's apparent absence while experiencing both divine support and enemy persecution - a tension between faith and experience."
    ),
    (
      "Enemy Mockery → Final Self-Questioning",
      "Enemy mockery and questioning leading to the soul's final self-questioning",
      ["dico", "singulus", "dies", "deus", "tristis", "anima", "conturbo"],
      15,
      15,
      "Enemies say daily 'Where is thy God?' and the soul questions itself about sadness and trouble.",
      "Augustine sees this as the culmination of persecution - enemy mockery leads to the soul's deepest self-questioning about its state and God's presence."
    ),
    (
      "Final Self-Questioning → Renewed Hope",
      "Final questioning of the soul leading to renewed hope and confession",
      ["spero", "deus", "confiteor", "salutare", "vultus"],
      16,
      16,
      "The soul renews its hope in God and confession of praise as the salvation of its countenance.",
      "Augustine sees this as the psalm's resolution - through honest self-questioning, the soul returns to hope and confession, finding in God the ultimate answer to its deepest longings."
    ),
  ]

  private let conceptualThemes = [
    (
      "Soul and Self",
      "References to the soul and self throughout the psalm",
      ["anima", "meus", "mea", "meum", "meipsum"],
      ThemeCategory.virtue,
      1 ... 16
    ),
    (
      "Divine Names and Titles",
      "Various names and titles for God throughout the psalm",
      ["deus", "dominus", "fortis", "vivus", "susceptor"],
      ThemeCategory.divine,
      1 ... 16
    ),
    (
      "Water and Thirst",
      "Imagery of water, thirst, and deep waters",
      ["cervus", "fons", "aqua", "sitis", "abyssus", "cataracta", "fluctus"],
      ThemeCategory.divine,
      1 ... 9
    ),
    (
      "Tears and Sorrow",
      "References to tears, sadness, and emotional distress",
      ["lacrima", "panis", "tristis", "conturbo", "tribulo", "affligo"],
      ThemeCategory.sin,
      3 ... 16
    ),
    (
      "Sacred Geography",
      "References to specific places and geographical features",
      ["locus", "tabernaculum", "domus", "terra", "iordanes", "hermon", "mons"],
      ThemeCategory.unknown,
      4 ... 8
    ),
    (
      "Voice and Sound",
      "References to voice, sound, and auditory elements",
      ["vox", "exsultatio", "confessio", "sonus", "epulor", "canticum", "oratio", "dico"],
      ThemeCategory.worship,
      5 ... 12
    ),
    (
      "Hope and Confession",
      "The soul's hope in God and confession of praise",
      ["spero", "confiteor", "salutare", "vultus"],
      ThemeCategory.virtue,
      6 ... 16
    ),
    (
      "Enemy and Persecution",
      "References to enemies, persecution, and opposition",
      ["inimicus", "tribulo", "affligo", "exprobro", "confringo", "os"],
      ThemeCategory.sin,
      13 ... 15
    ),
    (
      "Time and Cycles",
      "References to day, night, and temporal cycles",
      ["dies", "nox", "quotidie", "singulus"],
      ThemeCategory.divine,
      3 ... 15
    ),
    (
      "Memory and Remembrance",
      "The soul's memory and remembrance of God",
      ["recordor", "memor", "obliviscor"],
      ThemeCategory.virtue,
      4 ... 13
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 41 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 41 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm41_texts.json"
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
      filename: "output_psalm41_themes.json"
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
