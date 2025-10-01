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
    "Exaudi, Domine, iustitiam meam; intende deprecationem meam.",
    "Auribus percipe orationem meam, non in labiis dolosis.",
    "De vultu tuo iudicium meum prodeat; oculi tui videant aequitatem.",
    "Probasti cor meum, et visitasti nocte; igne me examinasti, et non est inventa in me iniquitas.",
    "Ut non loquatur os meum opera hominum; propter verba labiorum tuorum ego custodivi vias duras.",

    "Perfice gressus meos in semitis tuis, ut non moveantur vestigia mea.",
    "Ego clamavi, quoniam exaudisti me, Deus; inclina aurem tuam mihi, et exaudi verba mea.",
    "Mirifica misericordias tuas, qui salvos facis sperantes in te.",
    "A resistentibus dexterae tuae custodi me, ut pupillam oculi.",
    "Sub umbra alarum tuarum protege me, a facie impiorum qui me afflixerunt.",

    "Inimici mei animam meam circumdederunt; adipem suum concluserunt, os eorum locutum est superbiam.",
    "Proicientes me nunc circumdederunt me; oculos suos statuerunt declinare in terram.",
    "Susceperunt me sicut leo paratus ad praedam, et sicut catulus leonis habitans in abditis.",
    "Exsurge, Domine, praeveni eos, et supplanta eos. Eripe animam meam ab impio, frameam tuam ab inimicis manus tuae.",
    "Domine, a paucis de terra divide eos in vita eorum; de absconditis tuis adimpletus est venter eorum.",
    "Saturati sunt filiis, et dimiserunt reliquias suas parvulis suis.",
    "Ego autem in iustitia apparebo conspectui tuo; satiabor cum apparuerit gloria tua.",
  ]

  private let englishText = [
    "Hear, O Lord, my justice: attend to my supplication.",
    "Give ear unto my prayer, which proceedeth not from deceitful lips.",
    "Let my judgment come forth from thy countenance: let thy eyes behold the things that are equitable.",
    "Thou hast proved my heart, and visited it by night, thou hast tried me by fire: and iniquity hath not been found in me.",
    "That my mouth may not speak the works of men: for the sake of the words of thy lips, I have kept hard ways.",

    "Perfect thou my goings in thy paths: that my footsteps be not moved.",
    "I have cried to thee, for thou, O God, hast heard me: O incline thy ear unto me, and hear my words.",
    "Shew forth thy wonderful mercies; thou who savest them that trust in thee.",
    "From them that resist thy right hand keep me, as the apple of thy eye.",
    "Protect me under the shadow of thy wings, from the face of the wicked who have afflicted me.",

    "My enemies have surrounded my soul: they have shut up their fat: their mouth hath spoken proudly.",
    "They have cast me forth and now they have surrounded me: they have set their eyes to cast me down to the earth.",
    "They have taken me, as a lion prepared for the prey; and as a young lion dwelling in secret places.",
    "Arise, O Lord, disappoint them and supplant them; deliver my soul from the wicked one; thy sword from the enemies of thy hand.",
    "O Lord, divide them in their number: and scatter them in their vanity.",

    "Let their belly be filled with thy hidden things: and let their children be satisfied, and leave the rest to their little ones.",
    "But as for me, I will appear before thy sight in justice: I shall be satisfied when thy glory shall appear.",
  ]

private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["exaudio", "iustitia", "intendo", "deprecatio"]),
    (2, ["auris", "percipio", "oratio", "labium", "dolosus"]),
    (3, ["vultus", "iudicium", "prodeo", "oculus", "video", "aequitas"]),
    (4, ["probo", "cor", "visito", "nox", "ignis", "examino", "iniquitas"]),
    (5, ["loquor", "os", "opus", "homo", "verbum", "custodio", "via", "durus"]),
    (6, ["perficio", "gressus", "semita", "moveo", "vestigium"]),
    (7, ["clamo", "exaudio", "deus", "inclino", "auris", "verbum"]),
    (8, ["mirifico", "misericordia", "salvus", "facio", "spero"]),
    (9, ["resisto", "dextera", "custodio", "pupilla", "oculus"]),
    (10, ["umbra", "ala", "protego", "facies", "impius", "affligo"]),
    (11, ["inimicus", "anima", "circumdo", "adeps", "concludo", "os", "superbia"]),
    (12, ["proicio", "circumdo", "oculus", "statuo", "declino", "terra"]),
    (13, ["suscipio", "leo", "paro", "praeda", "catulus", "habito", "abditus"]),
    (14, ["exsurgo", "praevenio", "supplanto", "eripio", "anima", "impius", "framea"]),
    (15, ["paucus", "terra", "divido", "vita", "absconditum", "venter", "adimpleo"]),
    (16, ["saturo", "filius", "dimitto", "reliquiae", "parvulus"]),
    (17, ["iustitia", "appareo", "conspectus", "satio", "appareo", "gloria"])
]

private let structuralThemes = [
    (
        "Hearing → Purity",
        "Prayer for attentive divine hearing and truthful speech",
        ["exaudio", "iustitia", "intendo", "deprecatio", "auris", "percipio", "oratio", "labium", "dolosus"],
        1,
        2,
        "The psalm opens with multiple appeals for God's attention to righteous prayer",
        "Augustine sees this as the foundation of prayer - seeking God's attentive ear while maintaining integrity of speech, representing the pure heart necessary for divine communion."
    ),
    (
        "Judgment → Testing",
        "Divine scrutiny leading to proven innocence through trial",
        ["vultus", "iudicium", "prodeo", "oculus", "aequitas", "probo", "cor", "visito", "nox", "ignis", "examino", "iniquitas"],
        3,
        4,
        "Request for God's judgment and affirmation of tested innocence",
        "Augustine interprets the night visitation and fiery testing as God's purifying trials that reveal the soul's true state, prefiguring Christ's sinless perfection."
    ),
    (
        "Speech → Obedience",
        "Guarded speech and commitment to difficult paths of obedience",
        ["loquor", "os", "opus", "homo", "verbum", "custodio", "via", "durus", "perficio", "gressus", "semita", "moveo", "vestigium"],
        5,
        6,
        "Control of speech and prayer for steadfast walking in God's paths",
        "Augustine sees the 'hard ways' as the narrow path of righteousness, with guarded speech representing the discipline required for spiritual progress."
    ),
    (
        "Cry → Mercy",
        "Confident prayer based on past experience of divine help",
        ["clamo", "exaudio", "deus", "inclino", "auris", "verbum", "mirifico", "misericordia", "salvus", "facio", "spero"],
        7,
        8,
        "Prayer grounded in previous experience of God's saving help",
        "Augustine views this as the pattern of Christian prayer - crying out with confidence based on God's proven faithfulness in salvation."
    ),
    (
        "Protection → Refuge",
        "Divine protection using intimate metaphors of care",
        ["resisto", "dextera", "custodio", "pupilla", "oculus", "umbra", "ala", "protego", "facies", "impius", "affligo"],
        9,
        10,
        "Appeals for protection using the apple of the eye and wings imagery",
        "Augustine sees the apple of the eye as representing the Church, Christ's beloved, protected under the shadow of God's wings from spiritual enemies."
    ),
    (
        "Surrounding → Pride",
        "Enemy encirclement characterized by arrogance and prosperity",
        ["inimicus", "anima", "circumdo", "adeps", "concludo", "os", "superbia", "proicio", "circumdo", "oculus", "declino", "terra"],
        11,
        12,
        "Description of enemy siege with focus on their pride and hostile gaze",
        "Augustine interprets the enemies as spiritual forces and worldly powers arrayed against the soul, their fat symbolizing worldly prosperity and pride."
    ),
    (
        "Predation → Ambush",
        "Lion imagery depicting predatory enemy tactics",
        ["suscipio", "leo", "paro", "praeda", "catulus", "habito", "abditus", "exsurgo", "praevenio", "supplanto", "eripio", "anima", "impius", "framea"],
        13,
        14,
        "Enemies depicted as lions lying in ambush, requiring divine intervention",
        "Augustine sees the lion as Satan seeking to devour souls, with Christ's rising and sword representing divine victory over spiritual predators."
    ),
    (
        "Division → Satisfaction",
        "Divine judgment on enemies and their satisfaction with worldly things",
        ["paucus", "terra", "divido", "vita", "absconditum", "venter", "adimpleo", "saturo", "filius", "dimitto", "reliquiae", "parvulus"],
        15,
        16,
        "Prayer for enemy scattering and description of their worldly contentment",
        "Augustine interprets the hidden things filling their belly as earthly treasures that cannot satisfy, while the righteous await true satisfaction in God."
    ),
    (
        "Justice → Glory",
        "Righteous vindication and ultimate satisfaction in divine glory",
        ["iustitia", "appareo", "conspectus", "satio", "appareo", "gloria"],
        17,
        17,
        "Confident hope of appearing before God in righteousness and being satisfied with His glory",
        "Augustine sees this as the eschatological hope - the beatific vision where the righteous are satisfied by the appearance of God's glory rather than worldly things."
    )
]
  private let conceptualThemes = [
    (
        "Divine Justice",
        "God's righteous judgment and equitable scrutiny",
        ["iustitia", "iudicium", "aequitas", "probo", "examino"],
        ThemeCategory.divine,
        1...4
    ),
    (
        "Prayerful Dependence",
        "Multiple forms of prayer and reliance on God's attention",
        ["exaudio", "deprecatio", "oratio", "clamo", "inclino", "auris"],
        ThemeCategory.virtue,
        1...8
    ),
    (
        "Enemy Opposition",
        "Various forms of persecution and spiritual warfare",
        ["inimicus", "circumdo", "superbia", "proicio", "leo", "praeda"],
        ThemeCategory.virtue,
        11...14
    ),
    (
        "Divine Protection",
        "God as guardian using intimate protective metaphors",
        ["custodio", "pupilla", "umbra", "ala", "protego", "framea"],
        ThemeCategory.divine,
        9...14
    ),
    (
        "Moral Integrity",
        "Truthful speech, tested innocence, and righteous living",
        ["labium", "dolosus", "iniquitas", "custodio", "via", "iustitia"],
        ThemeCategory.virtue,
        1...17
    ),
    (
        "Eschatological Hope",
        "Future vindication and satisfaction in God's glory",
        ["appareo", "conspectus", "satio", "gloria", "iustitia"],
        ThemeCategory.virtue,
        15...17
    ),
    (
        "Spiritual Warfare",
        "Conflict with spiritual enemies and divine deliverance",
        ["resisto", "impius", "supplanto", "eripio", "anima", "framea"],
        ThemeCategory.divine,
        9...14
    ),
    (
        "Worldly Contrast",
        "Difference between enemy satisfaction and righteous hope",
        ["adeps", "venter", "saturo", "filius", "gloria", "satio"],
        ThemeCategory.virtue,
        11...17
    )
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
            filename: "output_psalm17A_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
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
