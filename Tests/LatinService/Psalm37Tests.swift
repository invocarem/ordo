@testable import LatinService
import XCTest

class Psalm37Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 37, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 23
  private let text = [
    "Domine, ne in furore tuo arguas me, neque in ira tua corripias me.",
    "Quoniam sagittae tuae infixae sunt mihi, et confirmasti super me manum tuam.",
    "Non est sanitas in carne mea a facie irae tuae; non est pax ossibus meis a facie peccatorum meorum.",
    "Quoniam iniquitates meae supergressae sunt caput meum; et sicut onus grave gravatae sunt super me.",
    "Putruerunt et corruptae sunt cicatrices meae, a facie insipientiae meae.",
    "Miser factus sum, et curvatus sum usque in finem; tota die contristatus ingrediebar.",
    "Quoniam lumbi mei impleti sunt illusionibus; et non est sanitas in carne mea.",
    "Afflictus sum, et humiliatus sum nimis; rugiebam a gemitu cordis mei.",
    "Domine, ante te omne desiderium meum; et gemitus meus a te non est absconditus.",
    "Cor meum conturbatum est, dereliquit me virtus mea; et lumen oculorum meorum, et ipsum non est mecum.",
    "Amici mei, et proximi mei adversum me appropinquaverunt, et steterunt;",
    "Et qui iuxta me erant, de longe steterunt. et vim faciebant qui quaerebant animam meam; ",
    "Et qui inquirebant mala mihi, locuti sunt vanitates, et dolos tota die meditabantur.",
    "Ego autem tamquam surdus non audiebam; et sicut mutus non aperiens os suum.",
    "Et factus sum sicut homo non audiens, et non habens in ore suo redargutiones.",
    "Quoniam in te, Domine, speravi; tu exaudies me, Domine Deus meus.",
    "Quia dixi: Nequando supergaudeant mihi inimici mei; et dum commoventur pedes mei, super me magna locuti sunt.",
    "Quoniam ego in flagella paratus sum, et dolor meus in conspectu meo semper.",
    "Quoniam iniquitatem meam annuntiabo, et cogitabo pro peccato meo.",
    "Inimici autem mei vivunt, et confirmati sunt super me; et multiplicati sunt qui oderunt me inique.",
    "Qui retribuunt mala pro bonis, detrahebant mihi, quoniam sequebar bonitatem.",
    "Ne derelinquas me, Domine Deus meus; ne discesseris a me.",
    "Intende in adiutorium meum, Domine, Deus salutis meae.",
  ]

  private let englishText = [
    "O Lord, rebuke me not in thy indignation, nor chastise me in thy wrath.",
    "For thy arrows are fastened in me; and thy hand hath been strong upon me.",
    "There is no health in my flesh, because of thy wrath; there is no peace for my bones, because of my sins.",
    "For my iniquities are gone over my head; and as a heavy burden are become heavy upon me.",
    "My sores are putrified and corrupted, because of my foolishness.",
    "I am become miserable, and am bowed down even to the end; I walked sorrowful all the day long.",
    "For my loins are filled with illusions; and there is no health in my flesh.",
    "I am afflicted and humbled exceedingly; I roared with the groaning of my heart.",
    "Lord, all my desire is before thee; and my groaning is not hidden from thee.",
    "My heart is troubled, my strength hath left me; and the light of my eyes itself is not with me.",
    "My friends and my neighbours have drawn near, and stood against me;",
    "And they that were near me stood afar off. And they that sought my soul used violence;",
    "And they that sought evils to me spoke vain things, and studied deceits all the day long.",
    "But I, as a deaf man, heard not; and as a dumb man not opening his mouth.",
    "And I became as a man that heareth not; and that hath no reproofs in his mouth.",
    "For in thee, O Lord, have I hoped; thou wilt hear me, O Lord my God.",
    "For I said: Lest at any time my enemies rejoice over me; and whilst my feet are moved, they speak great things against me.",
    "For I am ready for scourges; and my sorrow is continually before me.",
    "For I will declare my iniquity; and I will think for my sin.",
    "But my enemies live, and are stronger than I; and they that hate me wrongfully are multiplied.",
    "They that render evil for good, have detracted me, because I followed goodness.",
    "Forsake me not, O Lord my God; do not thou depart from me.",
    "Attend unto my help, O Lord, the God of my salvation.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "furor", "arguo", "ira", "corripio"]),
    (2, ["sagitta", "infigo", "confirmo", "manus"]),
    (3, ["sanitas", "caro", "facies", "ira", "pax", "os", "peccatum"]),
    (4, ["iniquitas", "supergredior", "caput", "onus", "gravis", "gravo"]),
    (5, ["putreo", "corrumpo", "cicatrix", "facies", "insipientia"]),
    (6, ["miser", "facio", "curvo", "finis", "totus", "dies", "contristo", "ingredior"]),
    (7, ["lumbus", "impleo", "illusio", "sanitas", "caro"]),
    (8, ["affligo", "humilio", "nimis", "rugio", "gemitus", "cor"]),
    (9, ["dominus", "ante", "desiderium", "gemitus", "abscondo"]),
    (10, ["cor", "conturbo", "derelinquo", "virtus", "lumen", "oculus"]),
    (11, ["amicus", "proximus", "adversus", "appropinquo", "sto"]),
    (12, ["iuxta", "longe", "vis", "facio", "quaero", "anima"]),
    (13, ["inquiro", "malum", "loquor", "vanitas", "dolus", "dies", "meditor"]),
    (14, ["surdus", "audio", "mutus", "aperio", "os"]),
    (15, ["facio", "homo", "audio", "habeo", "os", "redargutio"]),
    (16, ["dominus", "spero", "exaudio", "deus"]),
    (17, ["dico", "supergaudeo", "inimicus", "commoveo", "pes", "magnus", "loquor"]),
    (18, ["flagellum", "paro", "dolor", "conspectus", "semper"]),
    (19, ["iniquitas", "annuntio", "cogito", "peccatum"]),
    (20, ["inimicus", "vivo", "confirmo", "multiplico", "odi", "inique"]),
    (21, ["retribuo", "malum", "bonus", "detraho", "sequor", "bonitas"]),
    (22, ["derelinquo", "dominus", "deus", "discedo"]),
    (23, ["intendo", "adiutorium", "dominus", "deus", "salus"]),
  ]

  private let structuralThemes = [
    (
      "Divine Wrath → Physical Affliction",
      "The psalmist's plea not to be rebuked in God's wrath and description of divine arrows",
      ["furor", "arguo", "ira", "sagitta", "infigo"],
      1,
      2,
      "The psalmist pleads with the Lord not to rebuke him in His indignation or chastise him in His wrath, for God's arrows are fastened in him and His hand has been strong upon him.",
      "Augustine sees this as the soul's recognition of divine discipline and the physical manifestation of spiritual affliction, where God's correction is felt as both spiritual and bodily suffering."
    ),
    (
      "Sin and Sickness → Complete Corruption",
      "The psalmist's description of his iniquities and physical corruption from sin",
      ["sanitas", "caro", "iniquitas", "onus", "putreo", "corrumpo"],
      3,
      4,
      "There is no health in the psalmist's flesh because of God's wrath, and his iniquities have gone over his head like a heavy burden.",
      "For Augustine, this represents the complete corruption that sin brings to both body and soul, where spiritual iniquity manifests as physical decay and the burden of guilt becomes overwhelming."
    ),
    (
      "Physical Corruption → Complete Misery",
      "The psalmist's sores putrified and his complete physical and spiritual misery",
      ["putreo", "corrumpo", "cicatrix", "miser", "curvo", "contristo"],
      5,
      6,
      "The psalmist's sores are putrified and corrupted because of his foolishness, and he has become miserable and bowed down, walking sorrowful all day.",
      "Augustine sees this as the soul's complete desolation where physical suffering reflects spiritual brokenness, and the sinner is brought to the depths of misery and humiliation."
    ),
    (
      "Spiritual Affliction → Divine Awareness",
      "The psalmist's loins filled with illusions and his recognition that God knows his desire",
      ["lumbus", "illusio", "affligo", "humilio", "desiderium"],
      7,
      8,
      "The psalmist's loins are filled with illusions and he is afflicted and humbled exceedingly, while the Lord knows all his desire and his groaning is not hidden from Him.",
      "Augustine sees this as the soul's recognition of divine omniscience even in the midst of spiritual affliction, where God is fully aware of the sinner's plight."
    ),
    (
      "Divine Omniscience → Human Abandonment",
      "The psalmist's recognition that God knows his groaning while friends abandon him",
      ["gemitus", "abscondo", "cor", "conturbo", "amicus", "proximus"],
      9,
      10,
      "The psalmist's groaning is not hidden from the Lord, and his heart is troubled while his friends and neighbors have drawn near and stood against him.",
      "Augustine sees this as the paradox of divine omniscience and human abandonment, where God is fully aware of the sinner's plight while human companions turn away."
    ),
    (
      "Human Abandonment → Enemy Violence",
      "The psalmist's friends standing against him and enemies seeking his soul with violence",
      ["adversus", "appropinquo", "sto", "iuxta", "longe", "vis"],
      11,
      12,
      "The psalmist's friends and neighbors have drawn near and stood against him, and those who were near him stood afar off, while those who sought his soul used violence.",
      "For Augustine, this represents the soul's experience of complete human abandonment and the violence of enemies, where both friends and foes turn against the sinner."
    ),
    (
      "Enemy Deceit → Silent Suffering",
      "The psalmist's enemies speaking vain things while he remains silent like a deaf and dumb man",
      ["quaero", "anima", "inquiro", "malum", "loquor", "vanitas", "dolus", "surdus", "mutus"],
      13,
      14,
      "Those who sought evils to the psalmist spoke vain things and studied deceits all day, while he remained as a deaf man who heard not and as a dumb man not opening his mouth.",
      "Augustine sees this as the soul's response to persecution - maintaining silence in the face of violence and deceit, trusting in God rather than responding to human malice."
    ),
    (
      "Silent Endurance → Divine Hope",
      "The psalmist's silent endurance and his hope in God's hearing",
      ["facio", "homo", "audio", "habeo", "os", "redargutio", "spero"],
      15,
      16,
      "The psalmist became as a man that heareth not and hath no reproofs in his mouth, but he has hoped in the Lord and trusts He will hear him.",
      "For Augustine, this represents the soul's transition from silent suffering to divine hope, where the sinner's trust in God overcomes the silence of persecution."
    ),
    (
      "Divine Hope → Enemy Triumph",
      "The psalmist's hope in God contrasted with his enemies' rejoicing over his affliction",
      ["dico", "supergaudeo", "inimicus", "commoveo", "pes", "magnus", "loquor", "flagellum", "paro", "dolor", "conspectus", "semper"],
      17,
      18,
      "The psalmist has hoped in the Lord and trusts He will hear him, but fears lest his enemies rejoice over him and speak great things against him while his feet are moved.",
      "Augustine sees this as the tension between divine hope and human opposition, where the soul's trust in God is tested by the apparent triumph of enemies and the fear of their mockery."
    ),
    (
      "Ready for Scourges → Confession of Sin",
      "The psalmist's readiness for divine punishment and his confession of iniquity",
      ["iniquitas", "annuntio", "cogito", "peccatum", "inimicus", "vivo", "confirmo", "multiplico", "odi", "inique"],
      19,
      20,
      "The psalmist is ready for scourges with his sorrow continually before him, and he will declare his iniquity and think for his sin.",
      "Augustine sees this as the soul's acceptance of divine discipline and the beginning of repentance, where the sinner acknowledges his guilt and prepares for the necessary correction."
    ),
    (
      "Enemy Multiplication → Divine Abandonment",
      "The psalmist's enemies multiplying and becoming stronger while he feels abandoned by God",
      ["retribuo", "malum", "bonus", "detraho", "sequor", "bonitas", "derelinquo", "deus", "discedo"],
      21,
      22,
      "The psalmist's enemies live and are stronger than he, and those who hate him wrongfully are multiplied, while those who render evil for good have detracted him because he followed goodness.",
      "For Augustine, this represents the apparent triumph of evil over good, where the wicked prosper and multiply while the righteous suffer, testing the soul's faith in divine justice."
    ),
    (
      "Final Plea",
      "The psalmist's final plea not to be forsaken and his request for divine help",
      ["intendo", "adiutorium", "deus", "salus"],
      23,
      23,
      "The psalmist pleads that the Lord not forsake him or depart from him, and asks Him to attend to his help as the God of his salvation.",
      "Augustine sees this as the soul's ultimate cry for divine mercy and help, recognizing that only God can provide true salvation and deliverance from both sin and its consequences."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Wrath and Discipline",
      "References to God's anger, rebuke, and divine correction",
      ["furor", "arguo", "ira", "corripio", "sagitta", "infigo"],
      ThemeCategory.divine,
      1 ... 3
    ),
    (
      "Physical Affliction and Sickness",
      "References to bodily suffering, health, and physical corruption",
      ["sanitas", "caro", "os", "putreo", "corrumpo", "cicatrix", "lumbus"],
      ThemeCategory.sin,
      3 ... 7
    ),
    (
      "Sin and Iniquity",
      "References to sin, iniquity, and the burden of guilt",
      ["iniquitas", "peccatum", "onus", "gravis", "insipientia"],
      ThemeCategory.sin,
      3 ... 5
    ),
    (
      "Misery and Desolation",
      "References to misery, affliction, and complete desolation",
      ["miser", "curvo", "contristo", "affligo", "humilio", "rugio"],
      ThemeCategory.sin,
      6 ... 8
    ),
    (
      "Divine Omniscience",
      "References to God's knowledge of human desire and groaning",
      ["dominus", "desiderium", "gemitus", "abscondo", "conspectus"],
      ThemeCategory.divine,
      8 ... 10
    ),
    (
      "Human Abandonment",
      "References to friends, neighbors, and human relationships turning against the psalmist",
      ["amicus", "proximus", "adversus", "longe", "vis", "quaero"],
      ThemeCategory.sin,
      10 ... 13
    ),
    (
      "Silent Suffering",
      "References to deafness, muteness, and silent endurance",
      ["surdus", "audio", "mutus", "aperio", "os", "redargutio"],
      ThemeCategory.virtue,
      13 ... 15
    ),
    (
      "Divine Hope and Trust",
      "References to hope, trust, and confidence in God",
      ["spero", "exaudio", "deus", "dominus"],
      ThemeCategory.virtue,
      15 ... 17
    ),
    (
      "Enemy Opposition",
      "References to enemies, triumph, and opposition to the righteous",
      ["inimicus", "supergaudeo", "magnus", "flagellum", "vivo", "confirmo"],
      ThemeCategory.sin,
      16 ... 21
    ),
    (
      "Divine Salvation",
      "References to salvation, help, and divine deliverance",
      ["adiutorium", "salus", "deus", "dominus"],
      ThemeCategory.divine,
      22 ... 23
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 37 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 37 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm37_texts.json"
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
      filename: "output_psalm37_themes.json"
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
