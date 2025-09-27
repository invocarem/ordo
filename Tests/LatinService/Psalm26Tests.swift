@testable import LatinService
import XCTest

class Psalm26Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 26, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 19
  private let text = [
    "Dominus illuminatio mea et salus mea, quem timebo? ",
    "Dominus protector vitae meae, a quo trepidabo?",
    "Dum appropiant super me nocentes ut edant carnes meas: ",
    "Qui tribulant me inimici mei, ipsi infirmati sunt et ceciderunt.",
    "Si consistant adversum me castra, non timebit cor meum; ",  /* 5*/
    "Si exsurgat adversum me praelium, in hoc ego sperabo.",
    "Unam petii a Domino, hanc requiram, ut inhabitem in domo Domini omnibus diebus vitae meae;",
    "Ut videam voluptatem Domini, et visitem templum eius.",
    "Quoniam abscondit me in tabernaculo suo: in die malorum protexit me in abscondito tabernaculi sui.",
    "In petra exaltavit me, et nunc exaltavit caput meum super inimicos meos.",  /* 10*/
    "Circuivi et immolavi in tabernaculo eius hostiam vociferationis: cantabo et psalmum dicam Domino.",
    "Exaudi, Domine, vocem meam qua clamavi: miserere mei, et exaudi me.",
    "Tibi dixit cor meum, exquisivit te facies mea: faciem tuam, Domine, requiram.",
    "Ne avertas faciem tuam a me, ne declines in ira a servo tuo.",
    "adiutor meus esto, ne derelinquas me, neque despicias me, Deus salutaris meus.", /* 15 */
    "Quoniam pater meus et mater mea dereliquerunt me: Dominus autem assumpsit me.", /* 16 */
    "Legem pone mihi, Domine, in via tua, et dirige me in semitam rectam propter inimicos meos.", /* 17 */
    "Ne tradideris me in animas tribulantium me: quoniam insurrexerunt in me testes iniqui, et mentita est iniquitas sibi.",
    "Credo videre bona Domini in terra viventium. Exspecta Dominum, viriliter age: et confortetur cor tuum, et sustine Dominum.",
  ]

  private let englishText = [
    "The Lord is my light and my salvation, whom shall I fear? ",
    "The Lord is the protector of my life, of whom shall I be afraid?",
    "Whilst the wicked draw near against me, to eat my flesh: ",
    "My enemies that trouble me, they have been weakened and have fallen.",
    "If armies in camp should stand against me, my heart shall not fear; ",
    "If a battle should rise up against me, in this will I hope.",
    "One thing I have asked of the Lord, this will I seek after: that I may dwell in the house of the Lord all the days of my life;",
    "That I may see the delight of the Lord, and may visit his temple.",
    "For he hath hidden me in his tabernacle: in the day of evils, he hath protected me in the secret place of his tabernacle.",
    "He hath exalted me upon a rock, and now he hath lifted up my head above my enemies.",
    "I have gone round, and have offered up in his tabernacle a sacrifice of jubilation: I will sing, and recite a psalm to the Lord.",
    "Hear, O Lord, my voice, with which I have cried: have mercy on me, and hear me.",
    "My heart hath said to thee, my face hath sought thee: thy face, O Lord, will I seek.",
    "Turn not away thy face from me; decline not in thy wrath from thy servant.",
    "Be thou my helper, forsake me not, nor despise me, O God my Saviour.",
    "For my father and my mother have forsaken me: but the Lord hath taken me up.",
    "Set me a law, O Lord, in thy way, and guide me in the right path because of my enemies.",
    "Deliver me not over to the will of them that trouble me: for unjust witnesses have risen up against me, and iniquity hath lied to itself.",
    "I believe to see the good things of the Lord in the land of the living. Expect the Lord, do manfully: and let thy heart take courage, and wait thou for the Lord.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "illuminatio", "salus", "timeo"]),
    (2, ["dominus", "protector", "vita", "trepido"]),
    (3, ["appropio", "noceo", "edo", "caro"]),
    (4, ["tribulo", "inimicus", "infirmo", "cado"]),
    (5, ["consisto", "adversus", "castrum", "timeo", "cor"]),
    (6, ["exsurgo", "praelium", "spero"]),
    (7, ["unus", "peto", "dominus", "requiro", "inhabito", "domus", "dies", "vita"]),
    (8, ["video", "voluptas", "visito", "templum"]),
    (9, ["abscondo", "tabernaculum", "malus", "protego", "absconditum"]),
    (10, ["petra", "exalto", "caput", "inimicus"]),
    (11, ["circumeo", "immolo", "tabernaculum", "hostia", "vociferatio", "canto", "psalmus", "dico", "dominus"]),
    (12, ["exaudio", "dominus", "vox", "clamo", "misereor", "exaudio"]),
    (13, ["dico", "cor", "exquiro", "facies", "facies", "dominus", "requiro"]),
    (14, ["averto", "facies", "declino", "ira", "servus"]),
    (15, ["adiutor", "derelinquo", "despicio", "deus", "salutaris"]),
    (16, ["pater", "mater", "derelinquo", "dominus", "assumo"]),
    (17, ["lex", "pono", "dominus", "via", "dirigo", "semita", "rectus", "inimicus"]),
    (18, ["trado", "anima", "tribulo", "insurgo", "testis", "iniquus", "mentior", "iniquitas"]),
    (19, ["credo", "video", "bonus", "dominus", "terra", "vivo", "exspecto", "dominus", "viriliter", "conforto", "cor", "sustineo", "dominus"]),
  ]

  private let structuralThemes = [
    (
      "Divine Protection → Fearlessness",
      "The psalmist's declaration of trust in God's protection leading to fearlessness",
      ["dominus", "illuminatio", "salus", "timeo", "protector", "trepido"],
      1,
      2,
      "The psalmist declares that the Lord is his light and salvation, asking whom he should fear, and that the Lord is the protector of his life, asking of whom he should be afraid.",
      "Augustine sees this as the soul's fundamental trust in divine providence. When God is our light, we see clearly; when He is our salvation, we are secure; when He is our protector, we have nothing to fear from any temporal power."
    ),
    (
      "Enemy Approach → Enemy Defeat",
      "The psalmist's description of enemies drawing near and their subsequent defeat",
      ["appropio", "nocens", "edo", "caro", "tribulo", "inimicus", "infirmo", "cado"],
      3,
      4,
      "The psalmist describes how the wicked draw near against him to eat his flesh, and how his enemies that trouble him have been weakened and have fallen.",
      "For Augustine, this represents the soul's confidence that evil powers cannot ultimately prevail. The enemies of the soul may approach with malicious intent, but they are already defeated by Christ's victory."
    ),
    (
      "Battle Confidence → Hope in the Lord",
      "The psalmist's confidence in battle and his hope in the Lord",
      ["consisto", "adversus", "castrum", "timeo", "cor", "exsurgo", "praelium", "spero"],
      5,
      6,
      "The psalmist declares that if armies stand against him, his heart will not fear, and if battle rises against him, he will hope in the Lord.",
      "Augustine sees this as the soul's unwavering trust in divine protection. Even in the face of overwhelming opposition, the faithful heart remains steadfast through hope in God."
    ),
    (
      "Desire for God's House → Temple Visitation",
      "The psalmist's desire to dwell in God's house and visit His temple",
      ["unus", "peto", "dominus", "requiro", "inhabito", "domus", "dies", "vita", "video", "voluptas", "visito", "templum"],
      7,
      8,
      "The psalmist seeks one thing from the Lord: to dwell in the house of the Lord all his days, and to see the delight of the Lord and visit His temple.",
      "Augustine sees this as the soul's single-minded pursuit of divine communion. The house of the Lord represents the Church, and the temple represents the presence of God where the soul finds its true home."
    ),
    (
      "Divine Shelter → Exaltation Above Enemies",
      "God's protection in His tabernacle leading to exaltation above enemies",
      ["abscondo", "tabernaculum", "malus", "protego", "absconditus", "petra", "exalto", "caput", "inimicus"],
      9,
      10,
      "The psalmist describes how God has hidden him in His tabernacle and protected him in the secret place, then exalted him upon a rock and lifted up his head above his enemies.",
      "For Augustine, this represents the soul's journey from divine shelter to spiritual exaltation. God's protection leads to victory over all earthly adversaries."
    ),
    (
      "Worship and Sacrifice → Prayer for Mercy",
      "The psalmist's worship and sacrifice leading to earnest prayer for God's mercy",
      ["circumeo", "immolo", "tabernaculum", "hostia", "vociferatio", "canto", "psalmus", "dico", "dominus", "exaudio", "vox", "clamo", "misereor"],
      11,
      12,
      "The psalmist offers sacrifice in God's tabernacle and sings psalms, then cries out for God to hear his voice and have mercy.",
      "Augustine sees this as the soul's progression from external worship to intimate prayer. True worship leads to deeper supplication and the soul's cry for divine mercy."
    ),
    (
      "Heart's Search → Face-to-Face Encounter",
      "The psalmist's heart seeking God leading to desire for face-to-face encounter",
      ["dico", "cor", "exquiro", "facies", "dominus", "requiro", "averto", "declino", "ira", "servus"],
      13,
      14,
      "The psalmist's heart has spoken and his face has sought God, declaring that he will seek God's face, and asking that God not turn away His face in anger.",
      "For Augustine, this represents the soul's deepest longing for divine intimacy. The heart's search for God culminates in the desire for direct, face-to-face communion with the divine."
    ),
    (
      "Plea for Help → Divine Adoption",
      "The psalmist's plea for God's help and recognition of divine adoption",
      ["adiutor", "derelinquo", "despicio", "deus", "salutaris", "pater", "mater", "assumo"],
      15,
      16,
      "The psalmist asks God to be his helper and not forsake him, then declares that though his father and mother have forsaken him, the Lord has taken him up.",
      "Augustine sees this as the soul's recognition that earthly relationships may fail, but God's adoption is eternal. The Lord becomes both father and mother to those who trust in Him."
    ),
    (
      "Divine Guidance → Protection from Enemies",
      "The psalmist's request for divine guidance and protection from his enemies",
      ["lex", "pono", "dominus", "via", "dirigo", "semita", "rectus", "inimicus", "trado", "anima", "tribulo", "insurgo", "testis", "iniquus", "mentior", "iniquitas"],
      17,
      18,
      "The psalmist asks God to set a law for him and guide him in the right path, then pleads not to be delivered to his enemies who have risen up with false witnesses.",
      "For Augustine, this represents the soul's need for divine guidance and protection. God's law provides direction, and His protection preserves the soul from the schemes of the wicked."
    ),
    (
      "Hope in Eternal Life",
      "The psalmist's belief in seeing God's goodness in the land of the living",
      ["credo", "video", "bonus", "dominus", "terra", "vivo", "exspecto", "dominus", "viriliter", "conforto", "cor", "sustineo"],
      19,
      19,
      "The psalmist declares his belief that he will see the good things of the Lord in the land of the living, encouraging others to wait for the Lord with courage.",
      "Augustine sees this as the soul's ultimate hope in eternal life. The vision of God's goodness in the heavenly homeland is the reward for those who wait faithfully for the Lord."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Attributes",
      "References to God's nature and characteristics",
      ["dominus", "illuminatio", "salus", "protector", "deus", "salutaris"],
      ThemeCategory.divine,
      1 ... 19
    ),
    (
      "Human Body Parts",
      "References to physical body parts in spiritual context",
      ["vita", "caro", "cor", "facies", "caput", "vox"],
      ThemeCategory.virtue,
      1 ... 19
    ),
    (
      "Fear and Courage",
      "The psalmist's movement from fear to courage through trust in God",
      ["timeo", "trepido", "timeo", "spero", "viriliter", "conforto"],
      ThemeCategory.virtue,
      1 ... 19
    ),
    (
      "Enemies and Opposition",
      "References to enemies and those who oppose the psalmist",
      ["nocens", "inimicus", "tribulo", "adversus", "castrum", "praelium"],
      ThemeCategory.sin,
      3 ... 19
    ),
    (
      "Worship and Sacrifice",
      "The psalmist's worship, sacrifice, and prayer to God",
      ["domus", "templum", "tabernaculum", "immolo", "hostia", "canto", "psalmus", "clamo"],
      ThemeCategory.worship,
      7 ... 13
    ),
    (
      "Divine Guidance",
      "God's direction and teaching for the psalmist's life",
      ["lex", "via", "dirigo", "semita", "rectus", "exspecto", "sustineo"],
      ThemeCategory.divine,
      17 ... 19
    ),
    (
      "Family and Relationships",
      "References to family relationships and divine adoption",
      ["pater", "mater", "derelinquo", "assumo", "servus"],
      ThemeCategory.virtue,
      14 ... 16
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 26 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 26 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm26_texts.json"
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
      filename: "output_psalm26_themes.json"
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
