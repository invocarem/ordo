@testable import LatinService
import XCTest

class Psalm87Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 87, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 19
  private let text = [
    "Domine Deus salutis meae, in die clamavi, et nocte coram te.",
    "Intret in conspectu tuo oratio mea; inclina aurem tuam ad precem meam.",
    "Quoniam repleta est malis anima mea, et vita mea inferno appropinquavit.",
    "Aestimatus sum cum descendentibus in lacum; factus sum sicut homo sine adiutorio, inter mortuos liber.",
    "Sicut vulnerati dormientes in sepulchris, quorum non es memor amplius; et ipsi de manu tua repulsi sunt.",
    "Posuerunt me in lacu inferiori, in tenebrosis, et in umbra mortis.",
    "Super me confirmatus est furor tuus, et omnes fluctus tuos induxisti super me.",
    "Longe fecisti notos meos a me; posuerunt me abominationem sibi.",
    "Traditus sum, et non egrediebar; oculi mei languerunt prae inopia.",
    "Clamavi ad te, Domine, tota die; expandi ad te manus meas.",
    "Numquid mortuis facies mirabilia? aut medici suscitabunt, et confitebuntur tibi?",
    "Numquid narrabit aliquis in sepulchro misericordiam tuam, et veritatem tuam in perditione?",
    "Numquid cognoscentur in tenebris mirabilia tua, et iustitia tua in terra oblivionis?",
    "Et ego ad te, Domine, clamavi, et mane oratio mea praeveniet te.",
    "Ut quid, Domine, repellis orationem meam, avertis faciem tuam a me?",
    "Pauper sum ego, et in laboribus a iuventute mea; exaltatus autem, humiliatus sum et conturbatus.",
    "In me transierunt irae tuae, et terrores tui conturbaverunt me.",
    "Circumdederunt me sicut aqua tota die; circumdederunt me simul.",
    "Elongasti a me amicum et proximum; et notos meos a miseria.",
  ]

  private let englishText = [
    "O Lord, the God of my salvation, I have cried in the day, and in the night before thee.",
    "Let my prayer come in before thee; incline thy ear to my petition.",
    "For my soul is filled with evils, and my life hath drawn nigh to hell.",
    "I am counted among them that go down to the pit; I am become as a man without help, free among the dead.",
    "Like the slain sleeping in the sepulchres, whom thou rememberest no more; and they are cast off from thy hand.",
    "They have laid me in the lower pit, in the dark places, and in the shadow of death.",
    "Thy wrath is strong over me, and all thy waves thou hast brought in upon me.",
    "Thou hast put away my acquaintance far from me; they have set me an abomination to themselves.",
    "I was delivered up, and came not forth; my eyes languished through poverty.",
    "I cried to thee, O Lord, all the day; I stretched out my hands to thee.",
    "Wilt thou shew wonders to the dead? or shall physicians raise to life, and give praise to thee?",
    "Shall any one in the sepulchre declare thy mercy, and thy truth in destruction?",
    "Shall thy wonders be known in the dark, and thy justice in the land of forgetfulness?",
    "But I, O Lord, have cried to thee, and in the morning my prayer shall prevent thee.",
    "Lord, why castest thou off my prayer, why turnest thou away thy face from me?",
    "I am poor, and in labours from my youth; and being exalted, have been humbled and troubled.",
    "Thy wrath hath come upon me, and thy terrors have troubled me.",
    "They have come round about me like water all the day; they have compassed me about together.",
    "Friend and neighbour thou hast put far from me; and my acquaintance, because of misery.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "deus", "salus", "dies", "clamo", "nox"]),
    (2, ["intro", "conspectus", "oratio", "inclino", "auris", "prex"]),
    (3, ["repleo", "malum", "anima", "vita", "infernus", "appropinquo"]),
    (4, ["aestimo", "descendo", "lacus", "facio", "homo", "adiutorium", "mortuus", "liber"]),
    (5, ["vulnero", "dormio", "sepulchrum", "memor", "manus", "repello"]),
    (6, ["pono", "lacus", "inferus", "tenebrosus", "umbra", "mors"]),
    (7, ["confirmo", "furor", "fluctus", "induco"]),
    (8, ["longe", "facio", "notus", "pono", "abominatio"]),
    (9, ["trado", "egredior", "oculus", "languo", "inops"]),
    (10, ["clamo", "dominus", "totus", "dies", "expando", "manus"]),
    (11, ["numquid", "mortuus", "facio", "mirabilis", "medicus", "suscito", "confiteor"]),
    (12, ["numquid", "narro", "sepulchrum", "misericordia", "veritas", "perditio"]),
    (13, ["numquid", "cognosco", "tenebrae", "mirabilis", "iustitia", "terra", "oblivio"]),
    (14, ["clamo", "dominus", "mane", "oratio", "praevenio"]),
    (15, ["repello", "dominus", "oratio", "averto", "facies"]),
    (16, ["pauper", "labor", "iuventus", "exalto", "humilio", "conturbo"]),
    (17, ["ira", "terror", "conturbo"]),
    (18, ["circumdo", "aqua", "totus", "dies", "simul"]),
    (19, ["elongo", "amicus", "proximus", "notus", "miseria"]),
  ]

  private let structuralThemes = [
    (
      "Cry for Help → Divine Attention",
      "The psalmist's cry for help and request for God to incline His ear to his prayer",
      ["clamo", "dominus", "oratio", "inclino", "auris", "deus", "salus", "dies", "nox", "intro", "conspectus", "prex"],
      1,
      2,
      "The psalmist cries out to the Lord both day and night, asking that his prayer come before God and that God incline His ear to hear his petition.",
      "Augustine sees this as the soul's persistent cry for divine attention, recognizing that only God can provide true salvation and that prayer must be constant and earnest."
    ),
    (
      "Descent into Hell → Divine Abandonment",
      "The psalmist's description of being counted among the dead and cast off from God's hand",
      ["repleo", "malum", "anima", "vita", "infernus", "appropinquo", "aestimo", "descendo", "lacus", "facio", "homo", "adiutorium", "mortuus", "liber"],
      3,
      4,
      "The psalmist describes his soul as filled with evils and his life drawing near to hell, being counted among those who go down to the pit, like the slain sleeping in sepulchres whom God remembers no more.",
      "For Augustine, this represents the soul's experience of spiritual death and separation from God, where the sinner feels abandoned and cut off from divine mercy and remembrance."
    ),
    (
      "Death Imagery → Divine Rejection",
      "The psalmist's description of being placed in the lowest pit and shadow of death",
      ["vulnero", "dormio", "sepulchrum", "memor", "manus", "repello", "pono", "lacus", "inferus", "tenebrosus", "umbra", "mors"],
      5,
      6,
      "The psalmist is like the slain sleeping in sepulchres whom God remembers no more, cast off from His hand, and placed in the lower pit, in dark places, and in the shadow of death.",
      "Augustine sees this as the soul's complete spiritual death and divine rejection, where the sinner is cut off from divine remembrance and placed in the depths of spiritual darkness."
    ),
    (
      "Divine Wrath → Social Isolation",
      "God's wrath and waves upon the psalmist, leading to social rejection and abomination",
      ["confirmo", "furor", "fluctus", "induco", "longe", "facio", "notus", "pono", "abominatio"],
      7,
      8,
      "The psalmist experiences God's strong wrath and all His waves brought upon him, while his acquaintances are put far from him and he becomes an abomination to them.",
      "Augustine sees this as the soul's experience of divine judgment combined with social ostracism, where the sinner feels both God's anger and human rejection."
    ),
    (
      "Physical Affliction → Persistent Prayer",
      "The psalmist's physical suffering and continued crying out to God with outstretched hands",
      ["trado", "egredior", "oculus", "languo", "inops", "clamo", "dominus", "totus", "dies", "expando", "manus"],
      9,
      10,
      "The psalmist is delivered up and cannot go forth, with his eyes languishing through poverty, yet he continues to cry to the Lord all day and stretch out his hands to Him.",
      "Augustine sees this as the soul's physical and spiritual affliction leading to even more earnest prayer, where suffering drives the sinner to greater dependence on God."
    ),
    (
      "Rhetorical Questions → Divine Attributes",
      "Questions about God's wonders to the dead and His mercy and truth in destruction",
      ["numquid", "mortuus", "facio", "mirabilis", "medicus", "suscito", "confiteor", "narro", "sepulchrum", "misericordia", "veritas", "perditio"],
      11,
      12,
      "The psalmist asks whether God will show wonders to the dead or if physicians can raise them to life, and whether anyone in the sepulchre can declare God's mercy and truth in destruction.",
      "Augustine sees these as the soul's recognition that death limits the proclamation of God's wonders and attributes, yet the psalmist continues to seek God's intervention."
    ),
    (
      "Divine Justice → Continued Questions",
      "Questions about God's wonders and justice being known in darkness and the land of forgetfulness",
      ["numquid", "cognosco", "tenebrae", "mirabilis", "iustitia", "terra", "oblivio", "clamo", "dominus", "mane", "oratio", "praevenio"],
      13,
      14,
      "The psalmist asks whether God's wonders will be known in the dark and His justice in the land of forgetfulness, then continues to cry to the Lord with his morning prayer preventing God.",
      "For Augustine, this represents the soul's questioning of divine justice in the face of death and darkness, yet maintaining hope through persistent prayer."
    ),
    (
      "Divine Rejection → Questioning God",
      "The psalmist's questioning why God casts off his prayer and turns away His face",
      ["repello", "dominus", "oratio", "averto", "facies", "pauper", "labor", "iuventus", "exalto", "humilio", "conturbo"],
      15,
      16,
      "The psalmist questions why God casts off his prayer and turns away His face, then describes himself as poor and in labours from his youth, being exalted but then humbled and troubled.",
      "Augustine sees this as the soul's struggle with divine silence and rejection, questioning God's ways while recognizing the paradox of human exaltation followed by divine humbling."
    ),
    (
      "Divine Terror → Life's Struggles",
      "The psalmist's experience of God's wrath and terrors, and his life of poverty and labor",
      ["ira", "terror", "conturbo", "circumdo", "aqua", "totus", "dies", "simul"],
      17,
      18,
      "God's wrath and terrors have troubled the psalmist, and he is surrounded like water all day, compassed about together, while describing his life of poverty and labor from youth.",
      "Augustine sees this as the soul's experience of divine judgment and the reality of life's struggles, where divine terror combines with human poverty and labor."
    ),
    (
      "Complete Isolation -> Misery",
      "The psalmist's complete isolation as friends and neighbors are put far from him",
      ["elongo", "amicus", "proximus", "notus", "miseria"],
      19,
      19,
      "Friends and neighbors are put far from the psalmist because of misery, completing his isolation.",
      "Augustine sees this as the soul's experience of complete isolation and abandonment, where both divine and human comfort are withdrawn, leaving the sinner in utter desolation."
    ),
  ]

  private let conceptualThemes = [
    (
      "Prayer and Supplication",
      "References to prayer, crying out, and supplication to God",
      ["clamo", "oratio", "prex", "expando", "manus", "praevenio"],
      ThemeCategory.worship,
      1 ... 15
    ),
    (
      "Death and the Underworld",
      "Imagery of death, hell, sepulchres, and the realm of the dead",
      ["infernus", "mortuus", "sepulchrum", "lacus", "tenebrosus", "umbra", "mors"],
      ThemeCategory.sin,
      3 ... 13
    ),
    (
      "Divine Attributes",
      "References to God's mercy, truth, justice, and other divine qualities",
      ["misericordia", "veritas", "iustitia", "mirabilis", "salus"],
      ThemeCategory.divine,
      1 ... 13
    ),
    (
      "Physical Affliction",
      "Descriptions of physical suffering, weakness, and bodily distress",
      ["languo", "inops", "pauper", "labor", "oculus", "vulnero"],
      ThemeCategory.sin,
      5 ... 16
    ),
    (
      "Social Isolation",
      "References to being abandoned, rejected, or separated from others",
      ["longe", "abominatio", "elongo", "amicus", "proximus", "notus"],
      ThemeCategory.sin,
      8 ... 19
    ),
    (
      "Divine Wrath and Judgment",
      "Descriptions of God's anger, wrath, and judgment upon the sinner",
      ["furor", "ira", "terror", "confirmo", "induco", "conturbo"],
      ThemeCategory.divine,
      7 ... 17
    ),
    (
      "Water Imagery",
      "References to water, waves, and surrounding liquid elements",
      ["fluctus", "aqua", "circumdo", "simul"],
      ThemeCategory.sin,
      7 ... 18
    ),
    (
      "Temporal References",
      "Time-related words indicating day, night, morning, and duration",
      ["dies", "nox", "mane", "totus", "iuventus"],
      ThemeCategory.virtue,
      1 ... 16
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 87 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 87 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm87_texts.json"
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
      filename: "output_psalm87_themes.json"
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
