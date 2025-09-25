@testable import LatinService
import XCTest

class Psalm29Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 29, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 14
  private let text = [
    "Exaltabo te, Domine, quoniam suscepisti me, nec delectasti inimicos meos super me.",
    "Domine Deus meus, clamavi ad te, et sanasti me.",
    "Domine, eduxisti ab inferno animam meam; salvasti me a descendentibus in lacum.",
    "Psallite Domino, sancti eius; et confitemini memoriae sanctitatis eius.",
    "Quoniam ira in indignatione eius, et vita in voluntate eius; ",

    "Ad vesperum demorabitur fletus, et ad matutinum laetitia.",
    "Ego autem dixi in abundantia mea: Non movebor in aeternum.",
    "Domine, in voluntate tua, praestitisti decori meo virtutem;",
    "Avertisti faciem tuam a me, et factus sum conturbatus.",
    "Ad te, Domine, clamabo, et ad Deum meum deprecabor.",

    "Quae utilitas in sanguine meo, dum descendo in corruptionem? Numquid confitebitur tibi pulvis, aut annuntiabit veritatem tuam?",
    "Audivit Dominus, et misertus est mei; Dominus factus est adiutor meus.",
    "Convertisti planctum meum in gaudium mihi; conscidisti saccum meum, et circumdedisti me laetitia.",
    "Ut cantet tibi gloria mea, et non compungar; Domine Deus meus, in aeternum confitebor tibi.",
  ]

  private let englishText = [
    "I will extol thee, O Lord, for thou hast upheld me; and hast not made my enemies to rejoice over me.",
    "O Lord my God, I have cried to thee, and thou hast healed me.",
    "Thou hast brought forth, O Lord, my soul from hell; thou hast saved me from them that go down into the pit.",
    "Sing to the Lord, O ye his saints; and give praise to the memory of his holiness.",
    "For wrath is in his indignation; and life in his good will.",
    "In the evening weeping shall have place, and in the morning gladness.",
    "And in my abundance I said: I shall never be moved.",
    "O Lord, in thy favour, thou gavest strength to my beauty.",
    "Thou turnedst away thy face from me, and I became troubled.",
    "To thee, O Lord, will I cry; and I will make supplication to my God.",
    "What profit is there in my blood, whilst I go down to corruption? Shall dust confess to thee, or declare thy truth?",
    "The Lord hath heard, and hath had mercy on me; the Lord became my helper.",
    "Thou hast turned for me my mourning into joy; thou hast cut my sackcloth, and hast compassed me with gladness.",
    "To the end that my glory may sing to thee, and I may not regret; O Lord my God, I will give praise to thee for ever.",
  ]

  private let lineKeyLemmas = [
    (1, ["exalto", "dominus", "quoniam", "suscipio", "delecto", "inimicus", "super"]),
    (2, ["dominus", "deus", "clamo", "sano"]),
    (3, ["dominus", "educo", "infernus", "anima", "salvo", "descendo", "lacus"]),
    (4, ["psallo", "dominus", "sanctus", "confiteor", "memoria", "sanctitas"]),
    (5, ["quoniam", "ira", "indignatio", "vita", "voluntas"]),
    (6, ["vesper", "demoror", "fletus", "matutinus", "laetitia"]),
    (7, ["ego", "dico", "abundantia", "moveo", "aeternus"]),
    (8, ["dominus", "voluntas", "praesto", "decor", "virtus"]),
    (9, ["averto", "facies", "conturbo"]),
    (10, ["clamo", "deus", "deprecor"]),
    (11, ["utilitas", "sanguis", "descendo", "corruptio", "confiteor", "pulvis", "annuntio", "veritas"]),
    (12, ["audio", "dominus", "misereor", "dominus", "adiutor"]),
    (13, ["converto", "plango", "gaudium", "conscindo", "saccus", "circumdo", "laetitia"]),
    (14, ["canto", "gloria", "compungo", "dominus", "deus", "aeternus", "confiteor"]),
  ]

  private let structuralThemes = [
    (
      "Praise for Deliverance → Healing Response",
      "The psalmist's praise for being upheld and not allowing enemies to rejoice, followed by crying to God and being healed",
      ["exalto", "suscipio", "delecto", "inimicus", "clamo", "sano"],
      1,
      2,
      "The psalmist begins by exalting the Lord for upholding him and not allowing his enemies to rejoice over him, then recounts how he cried to the Lord and was healed.",
      "Augustine sees this as the soul's recognition of divine protection and healing, where God's deliverance from enemies and physical healing are both manifestations of His loving care for the faithful."
    ),
    (
      "Soul from Hell → Call to Praise",
      "The psalmist's soul being brought from hell and saved from the pit, leading to a call for the saints to praise God",
      ["educo", "infernus", "salvo", "lacus", "psallo", "sanctus"],
      3,
      4,
      "The psalmist describes how the Lord brought his soul from hell and saved him from those going down to the pit, then calls on the saints to sing to the Lord and give praise to the memory of His holiness.",
      "For Augustine, this represents the soul's deliverance from spiritual death and the call to communal worship, where individual salvation leads to corporate praise and remembrance of God's holy character."
    ),
    (
      "Divine Wrath and Life → Evening Weeping to Morning Joy",
      "God's wrath and life in His will, leading from evening weeping to morning gladness",
      ["ira", "indignatio", "vesper", "fletus", "matutinus", "laetitia"],
      5,
      6,
      "The psalmist explains that wrath is in God's indignation and life in His will, with weeping in the evening and gladness in the morning, then declares in his abundance that he will never be moved.",
      "Augustine sees this as the soul's understanding of divine justice and mercy, where God's wrath against sin is balanced by His life-giving will, and the faithful experience the cycle from sorrow to joy."
    ),
    (
      "Abundance and Confidence → Divine Favor",
      "The psalmist's confidence in abundance and God's favor in giving strength to his beauty",
      ["abundantia", "moveo", "aeternus", "praesto", "decor", "virtus"],
      7,
      8,
      "The psalmist declares in his abundance that he will never be moved, then describes how the Lord in His will gave strength to his beauty.",
      "For Augustine, this represents the soul's confidence in divine blessing and the recognition that true strength comes from God's favor, where abundance leads to eternal stability through divine empowerment."
    ),
    (
      "Face Averted → Cry for Help",
      "God turning away His face and causing trouble, leading the psalmist to cry for help",
      ["averto", "facies", "conturbo", "clamo", "deprecor"],
      9,
      10,
      "The psalmist describes how God turned away His face from him and he became troubled, leading him to cry to the Lord and make supplication to his God.",
      "For Augustine, this represents the soul's experience of divine testing, where God's temporary withdrawal teaches dependence and drives the soul to earnest prayer and supplication."
    ),
    (
      "Question of Blood's Profit → Dust's Confession",
      "Questioning the profit of blood in corruption and whether dust can confess or declare truth",
      ["utilitas", "sanguis", "corruptio", "pulvis", "annuntio", "veritas"],
      11,
      12,
      "The psalmist questions what profit there is in his blood while going down to corruption, asking if dust will confess to God or declare His truth, then recounts how the Lord heard and had mercy on him, becoming his helper.",
      "For Augustine, this represents the soul's existential questioning about mortality and the value of life, where the psalmist's honest doubt leads to divine mercy and the recognition that God alone can give meaning to human existence."
    ),
    (
      "Mourning to Joy → Eternal Praise",
      "God turning mourning into joy and cutting sackcloth, leading to eternal praise and glory",
      ["converto", "plango", "gaudium", "conscindo", "saccus", "canto"],
      13,
      14,
      "The psalmist describes how God turned his mourning into joy, cut his sackcloth, and surrounded him with gladness, so that his glory may sing to God and he may not regret, declaring he will praise the Lord forever.",
      "For Augustine, this represents the soul's complete transformation from mourning to joy, where God's intervention leads to eternal praise and the soul's glory singing to God without regret, fulfilling the ultimate purpose of human existence."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Deliverance and Salvation",
      "References to God's saving actions and deliverance from death and enemies",
      ["suscipio", "salvo", "educo", "infernus", "lacus", "adiutor"],
      ThemeCategory.divine,
      1 ... 14
    ),
    (
      "Praise and Worship",
      "References to exalting, singing, confessing, and praising God",
      ["exalto", "psallo", "confiteor", "canto", "gloria"],
      ThemeCategory.worship,
      1 ... 14
    ),
    (
      "Emotional States and Transformation",
      "References to mourning, joy, weeping, gladness, and emotional change",
      ["plango", "gaudium", "fletus", "laetitia", "conturbo", "converto"],
      ThemeCategory.virtue,
      5 ... 14
    ),
    (
      "Divine Attributes and Will",
      "References to God's wrath, mercy, will, and holy character",
      ["ira", "indignatio", "misereor", "voluntas", "sanctitas", "veritas"],
      ThemeCategory.divine,
      4 ... 12
    ),
    (
      "Human Mortality and Corruption",
      "References to blood, dust, corruption, and human frailty",
      ["sanguis", "pulvis", "corruptio", "descendo", "utilitas"],
      ThemeCategory.sin,
      11 ... 11
    ),
    (
      "Time and Eternity",
      "References to evening, morning, eternal duration, and temporal cycles",
      ["vesper", "matutinus", "aeternus", "demoror"],
      ThemeCategory.divine,
      5 ... 14
    ),
    (
      "Divine Favor and Testing",
      "References to God's face, favor, strength, and testing through withdrawal",
      ["facies", "averto", "praesto", "virtus", "decor"],
      ThemeCategory.divine,
      8 ... 10
    ),
    (
      "Communal Worship and Saints",
      "References to saints, memory, holiness, and corporate worship",
      ["sanctus", "memoria", "sanctitas", "psallo"],
      ThemeCategory.worship,
      4 ... 4
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 29 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 29 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm29_texts.json"
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
      filename: "output_psalm29_themes.json"
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
