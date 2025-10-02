@testable import LatinService
import XCTest

class Psalm16Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  let verbose = true

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Data

  let id = PsalmIdentity(number: 16, category: "")
  private let expectedVerseCount = 17

let text = [
/*  1 */ "Exaudi, Domine, iustitiam meam; intende deprecationem meam.",
/*  2 */ "Auribus percipe orationem meam, non in labiis dolosis.",
/*  3 */ "De vultu tuo iudicium meum prodeat; oculi tui videant aequitatem.",
/*  4 */ "Probasti cor meum, et visitasti nocte; igne me examinasti, et non est inventa in me iniquitas.",
/*  5 */ "Ut non loquatur os meum opera hominum; propter verba labiorum tuorum ego custodivi vias duras.",
/*  6 */ "Perfice gressus meos in semitis tuis, ut non moveantur vestigia mea.",
/*  7 */ "Ego clamavi, quoniam exaudisti me, Deus; inclina aurem tuam mihi, et exaudi verba mea.",
/*  8 */ "Mirifica misericordias tuas, qui salvos facis sperantes in te.",
/*  9 */ "A resistentibus dexterae tuae custodi me, ut pupillam oculi.",
/* 10 */ "Sub umbra alarum tuarum protege me, a facie impiorum qui me afflixerunt.",
/* 11 */ "Inimici mei animam meam circumdederunt; adipem suum concluserunt, os eorum locutum est superbiam.",
/* 12 */ "Proicientes me nunc circumdederunt me; oculos suos statuerunt declinare in terram.",
/* 13 */ "Susceperunt me sicut leo paratus ad praedam, et sicut catulus leonis habitans in abditis.",
/* 14 */ "Exsurge, Domine, praeveni eos, et supplanta eos. Eripe animam meam ab impio, frameam tuam ab inimicis manus tuae.",
/* 15 */ "Domine, a paucis de terra divide eos in vita eorum; de absconditis tuis adimpletus est venter eorum.",
/* 16 */ "Saturati sunt filiis, et dimiserunt reliquias suas parvulis suis.",
/* 17 */ "Ego autem in iustitia apparebo conspectui tuo; satiabor cum apparuerit gloria tua.",
]


 private let englishText = [ /* 1 */ "Hear, O Lord, my justice: attend to my supplication.",
                           /* 2 */ "Give ear unto my prayer, which proceedeth not from deceitful lips.",
                           /* 3 */ "Let my judgment come forth from thy countenance: let thy eyes behold the things that are equitable.",
                           /* 4 */ "Thou hast proved my heart, and visited it by night, thou hast tried me by fire: and iniquity hath not been found in me.",
                           /* 5 */ "That my mouth may not speak the works of men: for the sake of the words of thy lips, I have kept hard ways.",
                           /* 6 */ "Perfect thou my goings in thy paths: that my footsteps be not moved.",
                           /* 7 */ "I have cried to thee, for thou, O God, hast heard me: O incline thy ear unto me, and hear my words.",
                           /* 8 */ "Shew forth thy wonderful mercies; thou who savest them that trust in thee.",
                           /* 9 */ "From them that resist thy right hand keep me, as the apple of thy eye.",
                           /* 10 */ "Protect me under the shadow of thy wings, from the face of the wicked who have afflicted me.",
                           /* 11 */ "My enemies have surrounded my soul: they have shut up their fat: their mouth hath spoken proudly.",
                           /* 12 */ "They have cast me forth and now they have surrounded me: they have set their eyes to cast me down to the earth.",
                           /* 13 */ "They have taken me, as a lion prepared for the prey; and as a young lion dwelling in secret places.",
                           /* 14 */ "Arise, O Lord, disappoint them and supplant them; deliver my soul from the wicked one; thy sword from the enemies of thy hand.",
                           /* 15 */ "O Lord, divide them in their number: and scatter them in their vanity.",
                           /* 16 */ "Let their belly be filled with thy hidden things: and let their children be satisfied, and leave the rest to their little ones.",
                           /* 17 */ "But as for me, I will appear before thy sight in justice: I shall be satisfied when thy glory shall appear."]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["exaudio", "dominus", "iustitia", "intendo", "deprecatio"]),
    (2, ["auris", "percipio", "oratio", "labium", "dolosus"]),
    (3, ["vultus", "iudicium", "prodeo", "oculus", "video", "aequitas"]),
    (4, ["probo", "cor", "visito", "nox", "ignis", "examino", "iniquitas"]),
    (5, ["loquor", "os", "opus", "homo", "verbum", "custodio", "via", "durus"]),
    (6, ["perficio", "gressus", "semita", "moveo", "vestigium"]),
    (7, ["clamo", "exaudio", "deus", "inclino", "auris", "verbum"]),
    (8, ["mirifico", "misericordia", "salvus", "facio", "spero"]),
    (9, ["resisto", "dexter", "custodio", "pupilla", "oculus"]),
    (10, ["umbra", "ala", "protego", "facies", "impius", "affligo"]),
    (11, ["inimicus", "anima", "circumdo", "adeps", "concludo", "superbia"]),
    (12, ["proicio", "circumdo", "oculus", "statuo", "declino", "terra"]),
    (13, ["suscipio", "leo", "paro", "praeda", "catulus", "habito", "abditus"]),
    (14, ["exsurgo", "dominus", "praevenio", "supplanto", "eripio", "anima", "impius", "framea", "inimicus", "manus"]),
    (15, ["dominus", "paucus", "terra", "divido", "vita", "absconditum", "adimpleo", "venter"]),
    (16, ["saturo", "filius", "dimitto", "reliquiae", "parvulus"]),
    (17, ["ego", "iustitia", "appareo", "conspectus", "satio", "appareo", "gloria"]),
  ]

  private let structuralThemes = [
    (
      "Hearing → Sincerity",
      "Divine attention to prayer leads to authentic worship without deceit",
      ["exaudio", "intendo", "auris", "oratio", "dolosus"],
      1,
      2,
      "The psalmist calls for God to hear his prayer and attend to his supplication, emphasizing that his prayer comes from sincere lips without deceit.",
      "Augustine sees this as the foundation of true prayer - God's attentive hearing matched by the petitioner's sincere heart, free from hypocrisy and deceit (Enarr. Ps. 16.1-2)."
    ),
    (
      "Judgment → Righteousness",
      "Divine scrutiny reveals the psalmist's proven innocence and uprightness",
      ["vultus", "iudicium", "prodeo", "probo", "iniquitas"],
      3,
      4,
      "The psalmist requests that judgment come from God's countenance and eyes behold equity, confident that God's testing has proven his righteousness and found no iniquity.",
      "Augustine interprets this as the believer's confidence in divine vindication - God's penetrating gaze revealing true righteousness through testing (Enarr. Ps. 16.3-4)."
    ),
    (
      "Speech → Obedience",
      "Controlled speech and obedience to God's words lead to guided paths",
      ["loquor", "os", "custodio", "perficio", "gressus"],
      5,
      6,
      "The psalmist vows that his mouth will not speak human works, having kept hard paths for God's words' sake, and asks for perfected steps in God's paths.",
      "Augustine sees this as the transformation from human wisdom to divine guidance - obedience to God's word perfecting the believer's walk (Enarr. Ps. 16.5-6)."
    ),
    (
      "Cry → Mercy",
      "The psalmist's cry for help leads to recognition of God's saving mercy",
      ["clamo", "exaudio", "mirifico", "misericordia", "salvus"],
      7,
      8,
      "Having cried and been heard, the psalmist asks for continued hearing and praises God's wonderful mercies in saving those who hope in Him.",
      "Augustine views this as the pattern of answered prayer leading to greater trust in God's merciful character (Enarr. Ps. 16.7-8)."
    ),
    (
      "Protection → Shelter",
      "Divine protection extends from individual care to comprehensive shelter",
      ["custodio", "pupilla", "umbra", "ala", "protego"],
      9,
      10,
      "God's protection is likened to the precious care of the eye's pupil, then expanded to shelter under His wings from the wicked who afflict.",
      "Augustine sees this as the progression from intimate care to comprehensive protection - God's tender watchfulness extending to full shelter (Enarr. Ps. 16.9-10)."
    ),
    (
      "Surrounding → Pride",
      "Enemy encirclement and arrogant speech contrast with divine protection",
      ["inimicus", "circumdo", "superbia", "proicio", "declino"],
      11,
      12,
      "Enemies surround the soul, speak pride, and seek to cast down, but the psalmist trusts in God's protective care.",
      "Augustine contrasts the enemy's pride and destructive intent with the believer's humble trust in divine protection (Enarr. Ps. 16.11-12)."
    ),
    (
      "Prey → Deliverance",
      "Lion-like enemies seeking prey are met with divine intervention and deliverance",
      ["leo", "praeda", "suscipio", "exsurgo", "eripio"],
      13,
      14,
      "Enemies like lions ready for prey have taken the psalmist, but God is called to arise, prevent them, and deliver from the wicked.",
      "Augustine interprets this as Christ's victory over the roaring lion (devil) and His deliverance of His people from spiritual predators (Enarr. Ps. 16.13-14)."
    ),
    (
      "Division → Satisfaction",
      "Divine judgment dividing enemies leads to the satisfaction of the righteous",
      ["divido", "absconditum", "saturo", "reliquiae"],
      15,
      16,
      "God divides enemies in their life while filling their bellies with hidden things, and the psalmist will be satisfied when God's glory appears.",
      "Augustine sees this as the eschatological separation where the wicked receive temporal satisfaction while the righteous await eternal glory (Enarr. Ps. 16.15-16)."
    ),
    (
      "Appearance → Glory",
      "The psalmist's appearance in righteousness culminates in the vision of divine glory",
      ["appareo", "iustitia", "gloria", "satio"],
      17,
      17,
      "The psalmist will appear in God's sight in righteousness and be satisfied when God's glory appears.",
      "Augustine views this as the beatific vision - the ultimate satisfaction of seeing God's glory face to face in eternal righteousness (Enarr. Ps. 16.17)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Hearing",
      "God's attentive listening to prayer and supplication",
      ["exaudio", "intendo", "auris", "deprecatio", "oratio"],
      ThemeCategory.divine,
      1 ... 8
    ),
    (
      "Righteousness and Justice",
      "Divine judgment, equity, and the psalmist's proven innocence",
      ["iustitia", "iudicium", "aequitas", "probo", "iniquitas"],
      ThemeCategory.divine,
      1 ... 17
    ),
    (
      "Divine Protection",
      "God as guardian, protector, and shelter from enemies",
      ["custodio", "protego", "pupilla", "umbra", "ala", "framea"],
      ThemeCategory.divine,
      6 ... 17
    ),
    (
      "Enemy Opposition",
      "Adversaries, wickedness, and spiritual warfare",
      ["inimicus", "impius", "circumdo", "superbia", "affligo"],
      ThemeCategory.conflict,
      9 ... 17
    ),
    (
      "Body and Physical Imagery",
      "Physical body parts representing spiritual and emotional states",
      ["cor", "oculus", "auris", "os", "labium", "manus", "venter"],
      ThemeCategory.virtue,
      1 ... 17
    ),
    (
      "Path and Journey Imagery",
      "Walking, paths, steps, and divine guidance",
      ["via", "gressus", "semita", "vestigium", "moveo", "perficio"],
      ThemeCategory.virtue,
      5 ... 6
    ),
    (
      "Animal and Predator Imagery",
      "Lions, prey, and predatory metaphors for enemies",
      ["leo", "praeda", "catulus", "abditus", "suscipio"],
      ThemeCategory.conflict,
      13 ... 14
    ),
    (
      "Divine Mercy and Salvation",
      "God's merciful character and saving work",
      ["misericordia", "salvus", "mirifico", "spero", "eripio"],
      ThemeCategory.divine,
      7 ... 17
    ),
    (
      "Eschatological Hope",
      "Future glory, satisfaction, and divine appearance",
      ["gloria", "appareo", "satio", "conspectus", "absconditum"],
      ThemeCategory.divine,
      15 ... 17
    ),
    (
      "Speech and Communication",
      "Speaking, words, and verbal expression",
      ["loquor", "verbum", "labium", "oratio", "deprecatio"],
      ThemeCategory.virtue,
      1 ... 8
    ),
  ]

  // MARK: - Test Methods

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 16 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 16 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm16_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
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

  func testSavePsalm16Themes() {
    guard let themesJSON = utilities.generateCompleteThemesJSONString(
      psalmNumber: 16,
      conceptualThemes: conceptualThemes,
      structuralThemes: structuralThemes
    ) else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: themesJSON,
      filename: "output_psalm16_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(themesJSON)
    }
  }

  // MARK: - Test Cases

  func testJudicialPetition() {
    let legalTerms = [
      ("iustitia", ["iustitiam"], "justice"),
      ("iudicium", ["iudicium"], "judgment"),
      ("aequitas", ["aequitatem"], "equity"),
      ("probo", ["probasti"], "test"),
      ("iniquitas", ["iniquitas"], "injustice"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: legalTerms,
      verbose: verbose
    )
  }

  func testDivineProtection() {
    let protectionTerms = [
      ("pupilla", ["pupillam"], "orphan girl"),
      ("ala", ["alarum"], "wing"),
      ("framea", ["frameam"], "sword"),
      ("custodio", ["custodivi", "custodi"], "guard"),
      ("protego", ["protege"], "protect"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: protectionTerms,
      verbose: verbose
    )
  }

  func testLionImagery() {
    let lionTerms = [
      ("leo", ["leo", "leonis"], "lion"),
      ("catulus", ["catulus"], "cub"),
      ("praeda", ["praedam"], "prey"),
      ("abditus", ["abditis"], "hidden"),
      ("supplanto", ["supplanta"], "trip up"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: lionTerms,
      verbose: verbose
    )
  }

  func testBodyMetaphors() {
    let bodyTerms = [
      ("adeps", ["adipem"], "fat"), // Symbolizing prosperity
      ("venter", ["venter"], "belly"),
      ("oculus", ["oculi", "oculos"], "eye"),
      ("auris", ["auribus", "aurem"], "ear"),
      ("labium", ["labiis", "labiorum"], "lip"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: bodyTerms,
      verbose: verbose
    )
  }

  func testEschatologicalHope() {
    let hopeTerms = [
      ("gloria", ["gloria"], "glory"),
      ("satio", ["satiabor"], "satisfy"),
      ("appareo", ["apparebo", "apparuerit"], "appear"),
      ("absconditum", ["absconditis"], "hiding"),
      ("reliquiae", ["reliquias"], "remnants"),
    ]

    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: hopeTerms,
      verbose: verbose
    )
  }
}
