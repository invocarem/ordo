@testable import LatinService
import XCTest

class Psalm5Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 5, category: "")

  // MARK: - Test Data Properties

  private let psalm5 = [
    "Verba mea auribus percipe, Domine, intellige clamorem meum.",
    "Intende voci orationis meae, Rex meus et Deus meus.",
    "Quoniam ad te orabo, Domine; mane exaudies vocem meam.",
    "Mane astabo tibi et videbo, quoniam non Deus volens iniquitatem tu es.",
    "Neque habitabit iuxta te malignus, neque permanebunt iniusti ante oculos tuos.",
    "Odisti omnes qui operantur iniquitatem; perdes omnes qui loquuntur mendacium.",
    "Virum sanguinum et dolosum abominabitur Dominus. Ego autem in multitudine misericordiae tuae.",
    "Introibo in domum tuam; adorabo ad templum sanctum tuum in timore tuo.",
    "Domine, deduc me in iustitia tua; propter inimicos meos dirige in conspectu tuo viam meam.",
    "Quoniam non est in ore eorum veritas; cor eorum vanum est.",
    "Sepulchrum patens est guttur eorum; linguis suis dolose agebant, iudica illos, Deus.",
    "Decidant a cogitationibus suis; secundum multitudinem impietatum eorum expelle eos, quoniam irritaverunt te, Domine.",
    "Et laetentur omnes qui sperant in te, in aeternum exsultabunt; et habitabis in eis.",
    "Et gloriabuntur in te omnes qui diligunt nomen tuum, quoniam tu benedices iusto.",
    "Domine, ut scuto bonae voluntatis tuae coronasti nos.",
  ]

  private let englishText = [
    "Give ear to my words, O Lord, understand my cry.",
    "Hearken to the voice of my prayer, O my King and my God.",
    "For to thee will I pray: O Lord, in the morning thou shalt hear my voice.",
    "In the morning I will stand before thee, and will see: because thou art not a God that willest iniquity.",
    "Neither shall the wicked dwell near thee: nor shall the unjust abide before thy eyes.",
    "Thou hatest all the workers of iniquity: thou wilt destroy all that speak a lie.",
    "The bloody and the deceitful man the Lord will abhor. But as for me in the multitude of thy mercy.",
    "I will come into thy house; I will worship towards thy holy temple in thy fear.",
    "Lead me, O Lord, in thy justice: because of my enemies, direct my way in thy sight.",
    "For there is no truth in their mouth: their heart is vain.",
    "Their throat is an open sepulchre: they dealt deceitfully with their tongues: judge them, O God.",
    "Let them fall from their devices: according to the multitude of their wickedness cast them out: for they have provoked thee, O Lord.",
    "And let all them be glad that hope in thee: they shall rejoice for ever, and thou shalt dwell in them.",
    "And all they that love thy name shall glory in thee: for thou wilt bless the just.",
    "O Lord, thou hast crowned us, as with a shield of thy good will.",
  ]

  private let lineKeyLemmas = [
    (1, ["verbum", "auris", "percipio", "dominus", "intelligo", "clamor"]),
    (2, ["intendo", "vox", "oratio", "rex", "deus"]),
    (3, ["oro", "dominus", "mane", "exaudio", "vox"]),
    (4, ["mane", "asto", "video", "deus", "volo", "iniquitas"]),
    (5, ["habito", "malignus", "permaneo", "iniustus", "oculus"]),
    (6, ["odi", "operor", "iniquitas", "perdo", "loquor", "mendacium"]),
    (7, ["vir", "sanguis", "dolus", "abominor", "dominus", "misericordia"]),
    (8, ["introeo", "domus", "adoro", "templum", "sanctus", "timor"]),
    (9, ["dominus", "deduco", "iustitia", "inimicus", "dirigo", "conspectus", "via"]),
    (10, ["veritas", "os", "cor", "vanus"]),
    (11, ["sepulchrum", "pateo", "guttur", "lingua", "dolus", "iudico", "deus"]),
    (12, ["decido", "cogitatio", "multitudo", "impietas", "expello", "irrito", "dominus"]),
    (13, ["laetor", "spero", "aeternum", "exsulto", "habito"]),
    (14, ["glorior", "diligo", "nomen", "benedico", "iustus"]),
    (15, ["dominus", "scutum", "voluntas", "corono"]),
  ]

  private let structuralThemes = [
    (
      "Prayerful Appeal → Divine Attention",
      "The psalmist's earnest plea for God to hear and understand his cry",
      ["verbum", "auris", "percipio", "dominus", "intelligo", "clamor", "intendo", "vox", "oratio", "rex", "deus"],
      1,
      2,
      "The psalmist begins with a heartfelt plea for God to give ear to his words and understand his cry, addressing Him as King and God.",
      "Augustine sees this as the soul's fundamental posture before God. The 'verba mea auribus percipe' shows the psalmist's confidence that God hears, while 'Rex meus et Deus meus' reveals his recognition of divine authority."
    ),
    (
      "Morning Prayer → Divine Response",
      "The psalmist's commitment to morning prayer and expectation of divine hearing",
      ["oro", "dominus", "mane", "exaudio", "vox", "asto", "video", "deus", "volo", "iniquitas"],
      3,
      4,
      "The psalmist declares his intention to pray to God in the morning, confident that God will hear his voice, and he will stand before God and see because God does not will iniquity.",
      "For Augustine, this represents the soul's daily renewal in prayer. The 'mane' (morning) symbolizes the dawn of grace, while the psalmist's confidence in divine response shows his faith in God's righteous character."
    ),
    (
      "Separation from Evil → Divine Judgment",
      "The distinction between the wicked and the righteous, and God's judgment on evildoers",
      ["habito", "malignus", "permaneo", "iniustus", "oculus", "odi", "operor", "iniquitas", "perdo", "loquor", "mendacium"],
      5,
      6,
      "The psalmist declares that the wicked will not dwell near God or remain before His eyes, and that God hates all workers of iniquity and will destroy those who speak lies.",
      "Augustine interprets this as the fundamental spiritual division. The psalmist recognizes that God's holiness cannot coexist with wickedness, and that divine judgment is inevitable for those who persist in evil."
    ),
    (
      "Wicked Condemnation → Righteous Worship",
      "God's abhorrence of the bloody and deceitful contrasted with the psalmist's worship",
      ["vir", "sanguis", "dolus", "abominor", "dominus", "misericordia", "introeo", "domus", "adoro", "templum", "sanctus", "timor"],
      7,
      8,
      "God will abhor the bloody and deceitful man, but the psalmist, trusting in God's mercy, will enter God's house and worship at His holy temple in fear.",
      "For Augustine, this represents the soul's choice between two paths. The wicked are abhorred by their deeds, while the righteous find refuge in God's mercy and approach His sanctuary with reverent fear."
    ),
    (
      "Divine Guidance → Enemy Character",
      "The psalmist's request for divine guidance contrasted with the character of his enemies",
      ["dominus", "deduco", "iustitia", "inimicus", "dirigo", "conspectus", "via", "veritas", "os", "cor", "vanus"],
      9,
      10,
      "The psalmist asks God to lead him in justice and direct his way before his enemies, declaring that there is no truth in their mouth and their heart is vain.",
      "Augustine sees this as the soul's dependence on divine guidance. The psalmist recognizes his need for God's direction while exposing the emptiness of those who oppose him, showing the contrast between divine truth and human deception."
    ),
    (
      "Wicked Speech → Divine Judgment",
      "The destructive speech of the wicked contrasted with God's judgment",
      ["sepulchrum", "pateo", "guttur", "lingua", "dolus", "iudico", "deus", "decido", "cogitatio", "multitudo", "impietas", "expello", "irrito", "dominus"],
      11,
      12,
      "The psalmist describes the wicked's throat as an open sepulchre and their tongues as dealing deceitfully, asking God to judge them and let them fall from their devices.",
      "For Augustine, this represents the corrupting power of evil speech. The 'sepulchrum patens' shows how wicked words lead to death, while the psalmist's prayer for judgment reveals his faith in divine justice."
    ),
    (
      "Joyful Trust → Divine Favor",
      "The joy of those who trust in God contrasted with divine blessing on the righteous",
      ["laetor", "spero", "aeternum", "exsulto", "habito", "glorior", "diligo", "nomen", "benedico", "iustus"],
      13,
      14,
      "The psalmist declares that all who hope in God will rejoice forever and God will dwell in them, and all who love God's name will glory in Him because He will bless the righteous.",
      "Augustine interprets this as the soul's ultimate hope. The joy of the faithful is eternal because God Himself dwells within them, and their glory comes from His blessing, not their own merit."
    ),
    (
      "Divine Protection",
      "God's shield and crown of favor upon His people",
      ["dominus", "scutum", "voluntas", "corono"],
      15,
      15,
      "The psalmist concludes by declaring that God has crowned them with a shield of His good will.",
      "For Augustine, this represents the final blessing of divine protection. The 'scuto bonae voluntatis' shows God's complete care for His people, crowning them with His favor as both shield and crown."
    ),
  ]

  private let conceptualThemes = [
    (
      "Prayer and Petition",
      "The psalmist's earnest prayers and requests to God",
      ["oro", "oratio", "percipio", "intendo", "clamor"],
      ThemeCategory.worship,
      1 ... 15
    ),
    (
      "Divine Justice",
      "God's righteous judgment and separation from wickedness",
      ["iustitia", "iudico", "iniquitas", "malignus", "iniustus"],
      ThemeCategory.justice,
      1 ... 15
    ),
    (
      "Morning Devotion",
      "The theme of morning prayer and standing before God",
      ["mane", "asto", "video", "exaudio"],
      ThemeCategory.virtue,
      1 ... 15
    ),
    (
      "Divine Protection",
      "God's shield, mercy, and care for His people",
      ["scutum", "misericordia", "corono", "voluntas"],
      ThemeCategory.divine,
      1 ... 15
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm5.count, 15, "Psalm 5 should have 15 verses"
    )
    XCTAssertEqual(
      englishText.count, 15,
      "Psalm 5 English text should have 15 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm5.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm5,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm5,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm5_texts.json"
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
      filename: "output_psalm5_themes.json"
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
      psalmText: psalm5,
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
      psalmText: psalm5,
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
      psalmText: psalm5,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
