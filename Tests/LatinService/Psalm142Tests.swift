import XCTest

@testable import LatinService

class Psalm142Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  let id = PsalmIdentity(number: 142, category: nil)

  // MARK: - Test Data

  private let psalm142 =
    [
      "Domine, exaudi orationem meam: auribus percipe obsecrationem meam in veritate tua: exaudi me in tua iustitia.",
      "Et non intres in iudicium cum servo tuo: quia non iustificabitur in conspectu tuo omnis vivens.",
      "Quia persecutus est inimicus animam meam: humiliavit in terra vitam meam.",
      "Collocavit me in obscuris sicut mortuos saeculi: et anxiatus est super me spiritus meus, in me turbatum est cor meum.",
      "Memor fui dierum antiquorum, meditatus sum in omnibus operibus tuis: in factis manuum tuarum meditabar.",
      "Expandi manus meas ad te: anima mea sicut terra sine aqua tibi.",
      "Velociter exaudi me, Domine: defecit spiritus meus.",
      "Non avertas faciem tuam a me: et similis ero descendentibus in lacum.",
      "Auditam fac mihi mane misericordiam tuam: quia in te speravi.",
      "Notum fac mihi viam, in qua ambulem: quia ad te levavi animam meam.",
      "Eripe me de inimicis meis, Domine, ad te confugi: doce me facere voluntatem tuam, quia Deus meus es tu.",
      "Spiritus tuus bonus deducet me in terram rectam: propter nomen tuum, Domine, vivificabis me, in aequitate tua.",
      "Educes de tribulatione animam meam: et in misericordia tua disperdes inimicos meos.",
      "Et perdes omnes qui tribulant animam meam, quoniam ego servus tuus sum.",
    ]

  private let lineKeyLemmas = [
    (
      1, ["dominus", "exaudio", "oratio", "auris", "percipio", "obsecratio", "veritas", "iustitia"]
    ),
    (2, ["intro", "iudicium", "servus", "iustifico", "conspectus", "vivo"]),
    (3, ["persequor", "inimicus", "anima", "humilio", "terra", "vita"]),
    (4, ["colloco", "obscurus", "mortuus", "saeculum", "anxio", "spiritus", "turbo", "cor"]),
    (5, ["memor", "dies", "antiquus", "meditor", "opus", "facio", "manus"]),
    (6, ["expando", "manus", "anima", "terra", "aqua"]),
    (7, ["velox", "exaudio", "dominus", "deficio", "spiritus"]),
    (8, ["averto", "facies", "similis", "descendo", "lacus"]),
    (9, ["audio", "mane", "misericordia", "spero"]),
    (10, ["notus", "via", "ambulo", "levo", "anima"]),
    (11, ["eripio", "inimicus", "dominus", "confugio", "doceo", "facio", "voluntas", "deus"]),
    (12, ["spiritus", "bonus", "deduco", "terra", "rectus", "nomen", "vivifico", "aequitas"]),
    (13, ["educo", "tribulatio", "anima", "misericordia", "disperdo", "inimicus"]),
    (14, ["perdo", "tribulo", "anima", "servus"]),
  ]

  private let structuralThemes = [
    (
      "Petition → Justice",
      "Appeal to God's truth and justice in hearing prayer",
      ["exaudio", "oratio", "veritas", "iustitia"],
      1,
      2,
      "The psalmist begins with a plea for God to hear his prayer, acknowledging that no one is justified before God's judgment.",
      "Augustine sees this as the soul's recognition of its own unworthiness and complete dependence on God's mercy rather than human righteousness (Enarr. Ps. 142.1-2)."
    ),
    (
      "Persecution → Desolation",
      "Enemy oppression leading to spiritual darkness and distress",
      ["persequor", "inimicus", "humilio", "obscurus", "mortuus", "anxio"],
      3,
      4,
      "The psalmist describes the enemy's persecution that has brought humiliation, darkness, and spiritual anguish.",
      "Augustine interprets this as the soul's experience of spiritual death and separation from God, where the enemy (sin/devil) seeks to destroy the spiritual life (Enarr. Ps. 142.3-4)."
    ),
    (
      "Remembrance → Thirst",
      "Remembering God's works while experiencing spiritual dryness",
      ["memor", "meditor", "opus", "expando", "terra", "aqua"],
      5,
      6,
      "The psalmist recalls God's past works while expressing intense spiritual thirst like parched land.",
      "Augustine sees this as the soul's meditation on God's providence while experiencing the dryness of spiritual desert, longing for the living water of grace (Enarr. Ps. 142.5-6)."
    ),
    (
      "Urgency → Desperation",
      "Immediate need for God's presence to avoid destruction",
      ["velox", "deficio", "averto", "lacus", "descendo"],
      7,
      8,
      "The psalmist urgently pleads for help as his spirit fails, fearing abandonment that would lead to the pit.",
      "Augustine emphasizes the soul's desperate need for God's immediate help to avoid spiritual death and descent into hell (Enarr. Ps. 142.7-8)."
    ),
    (
      "Hope → Guidance",
      "Trust in God's mercy leading to prayer for direction",
      ["audio", "misericordia", "spero", "notus", "via", "ambulo"],
      9,
      10,
      "The psalmist expresses hope in God's mercy and asks for guidance in the right path.",
      "Augustine interprets this as the soul's morning prayer for enlightenment, seeking the way of truth after the night of tribulation (Enarr. Ps. 142.9-10)."
    ),
    (
      "Refuge → Spirit",
      "Taking refuge in God and the guidance of the Holy Spirit",
      ["eripio", "confugio", "doceo", "voluntas", "deus", "spiritus", "bonus", "deduco"],
      11,
      12,
      "The psalmist flees to God for deliverance, asks to be taught God's will, and trusts in the Holy Spirit's guidance.",
      "Augustine sees this as the soul's complete surrender to God's will, recognizing that true deliverance comes through obedience to divine instruction and the guidance of the Holy Spirit (Enarr. Ps. 142.11-12)."
    ),
    (
      "Deliverance → Vindication",
      "God's liberation from trouble and destruction of enemies",
      ["educo", "tribulatio", "disperdo", "perdo", "servus"],
      13,
      14,
      "The psalmist trusts God to deliver from tribulation and destroy all who trouble his soul, affirming his servant status.",
      "Augustine emphasizes God's power to revive the soul and destroy spiritual enemies through His mercy, culminating in the soul's affirmation of its servitude to God (Enarr. Ps. 142.13-14)."
    ),
  ]
private let conceptualThemes = [
    (
        "Divine Justice",
        "God's righteous judgment and fairness",
        ["iustitia", "iudicium", "iustifico"],
        ThemeCategory.justice,
        1...2 as ClosedRange<Int>?
    ),
    (
        "Divine Mercy", 
        "God's compassionate love and forgiveness",
        ["misericordia", "exaudio", "percipio", "audio"],
        .divine,
        1...9
    ),
    (
        "Divine Guidance",
        "God's direction and teaching through the Spirit",
        ["via", "doceo", "deduco", "spiritus", "bonus", "aequitas"],
        .divine,
        10...12
    ),
    (
        "Human Dependence",
        "Recognition of human need for God",
        ["servus", "spero", "confugio", "levo", "expando"],
        .worship,
        2...11
    ),
    (
        "Spiritual Thirst",
        "Longing for God's presence and grace",
        ["anima", "terra", "aqua", "deficio"],
        .virtue,
        6...7
    ),
    (
        "Meditative Prayer",
        "Remembering and contemplating God's works",
        ["memor", "meditor", "opus", "facio"],
        .worship,
        5...6
    ),
    (
        "Enemy Oppression",
        "Persecution by adversaries and spiritual enemies",
        ["inimicus", "persequor", "tribulo", "disperdo", "perdo"],
        .opposition,
        3...14
    ),
    (
        "Spiritual Desolation",
        "Experience of darkness, distress and abandonment",
        ["obscurus", "mortuus", "anxio", "turbo", "lacus", "averto"],
        .conflict,
        4...8
    ),
    (
        "Divine Deliverance",
        "God's rescue and liberation from trouble",
        ["eripio", "educo", "vivifico"],
        .divine,
        11...13
    ),
    (
        "Servant Identity", 
        "Recognition of one's relationship to God as servant",
        ["servus", "confugio", "spero"],
        .virtue,
        2...14
    )
]
 

  func testPsalm142HasFourteenVerses() {
    XCTAssertEqual(psalm142.count, 14, "Psalm 142 should have 14 verses")
    let normalized = psalm142.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm142,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testPsalm142LineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm142,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm142StructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: psalm142,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm142ConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: psalm142,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSavePsalm142Themes() {
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm142_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
