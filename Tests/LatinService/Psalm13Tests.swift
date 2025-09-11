@testable import LatinService
import XCTest

class Psalm13Tests: XCTestCase {
  private var latinService: LatinService!
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
    latinService = LatinService.shared
  }

  let id = PsalmIdentity(number: 13, category: nil)

  private let psalm13 = [
    "Dixit insipiens in corde suo: Non est Deus.",
    "Corrupti sunt, et abominabiles facti sunt in studiis suis; non est qui faciat bonum, non est usque ad unum.",
    "Dominus de caelo prospexit super filios hominum, ut videat si est intelligens, aut requirens Deum.",
    "Omnes declinaverunt, simul inutiles facti sunt; non est qui faciat bonum, non est usque ad unum.",
    "Sepulcrum patens est guttur eorum; linguis suis dolose agebant, venenum aspidum sub labiis eorum.",
    "Quorum os maledictione et amaritudine plenum est, veloces pedes eorum ad effundendum sanguinem.",
    "Contritio et infelicitas in viis eorum, et viam pacis non cognoverunt; non est timor Dei ante oculos eorum.",
    "Nonne scient omnes qui operantur iniquitatem, qui devorant plebem meam ut cibum panis?",
    "Dominum non invocaverunt; illic trepidaverunt timore, ubi non erat timor.",
    "Quoniam Dominus in generatione iusta est, consilium inopis confudistis, quoniam Dominus spes eius est.",
    "Quis dabit ex Sion salutare Israel? cum averterit Dominus captivitatem plebis suae, exsultabit Iacob, et laetabitur Israel.",
  ]

  // MARK: - Line-by-line key lemmas (Psalm 13)

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["dico", "insipiens", "cor", "deus"]), // dixit, insipiens, corde, deus
    (2, ["corrumpo", "abominabilis", "facio", "studium", "bonus", "unus"]), // corrupti, abominabiles, facti, studiis, bonum, unum
    (3, ["dominus", "caelum", "prospicio", "filius", "homo", "video", "intelligo", "requiro"]), // dominus, caelo, prospexit, filios, hominum, videat, intelligens, requirens
    (4, ["omnis", "declino", "simul", "inutilis", "facio", "bonus"]), // omnes, declinaverunt, simul, inutiles, facti, bonum
    (5, ["sepulcrum", "pateo", "guttur", "lingua", "dolosus", "ago", "venenum", "aspis", "labium"]), // sepulcrum, patens, guttur, linguis, dolose, agebant, venenum, aspidum, labiis
    (6, ["os", "maledictio", "amaritudo", "plenus", "velox", "pes", "effundo", "sanguis"]), // os, maledictione, amaritudine, plenum, veloces, pedes, effundendum, sanguinem
    (7, ["contritio", "infelicitas", "via", "pax", "cognosco", "timor", "deus", "oculus"]), // contritio, infelicitas, viis, viam, pacis, cognoverunt, timor, dei, oculos
    (8, ["scio", "operor", "iniquitas", "devoro", "plebs", "cibus", "panis"]), // scient, operantur, iniquitatem, devorant, plebem, cibum, panis
    (9, ["dominus", "invoco", "ille", "trepido", "timor"]), // dominum, invocaverunt, illic, trepidaverunt, timore
    (10, ["dominus", "generatio", "iustus", "consilium", "inops", "confundo", "spes"]), // dominus, generatione, iusta, consilium, inopis, confudistis, spes
    (11, ["do", "sion", "salus", "israel", "averto", "captivitas", "plebs", "exsulto", "iacob", "laetor"]), // dabit, sion, salutare, israel, averterit, captivitatem, plebis, exsultabit, iacob, laetabitur
  ]

  // MARK: - Structural themes (Psalm 13) — from themes.json

  private let structuralThemes: [(String, String, [String], Int, Int, String, String)] = [
    (
      "Folly → Corruption",
      "The fool's denial of God leads to universal moral corruption and absence of good.",
      ["insipiens", "corrumpo", "abominabilis", "bonus"],
      1,
      2,
      "The psalm begins with the fool's declaration that there is no God, which results in complete corruption and abominable deeds, with none doing good.",
      "Augustine sees this as describing the root of sin: practical atheism that leads to moral decay. The denial of God corrupts human nature itself (Enarr. Ps. 13.1-2)."
    ),
    (
      "Search → Turning Away",
      "God's search for understanding among humanity reveals universal turning away from Him.",
      ["prospicio", "intelligo", "requiro", "declino"],
      3,
      4,
      "The Lord looks down from heaven to see if any understand or seek God, but finds that all have turned aside and become corrupt.",
      "Augustine interprets this as God's gracious condescension to seek out those who might respond to Him, yet finding universal sinfulness that requires divine grace (Enarr. Ps. 13.3-4)."
    ),
    (
      "Speech → Violent Action",
      "Internal moral decay manifests as deceitful speech and culminates in eager physical violence.",
      ["sepulcrum", "guttur", "venenum", "aspis", "pes", "sanguis"],
      5,
      6,
      "The psalmist describes a progression of evil: it begins with inner decay (a throat like an open grave), expresses itself through deceitful and poisonous speech, and inevitably culminates in eager physical violence ('swift feet to shed blood').",
      "Augustine sees this as a necessary chain of sin: a heart that denies God (v.1) cannot help but produce corruption that moves from harmful words to violent deeds. The 'feet' complete the action the 'tongue' began (Enarr. Ps. 13.5-6)."
    ),
    (
      "Ways → Ignorance",
      "Destructive ways and ignorance of peace reveal the absence of God's fear before their eyes, leading them to oppress others as casually as eating bread.",
      ["contritio", "infelicitas", "devoro", "panis"],
      7,
      8,
      "Ruin and misery mark their ways; they know nothing of peace's path and lack the fear of God before their eyes, devouring God's people like bread.",
      "For Augustine, this describes the inevitable consequences of godlessness: destruction, unhappiness, and oppression of the righteous (Enarr. Ps. 13.7-8)."
    ),
    (
      "False Fear → Restoration",
      "The wrongful terror of the wicked, who refuse to call on the Lord, is contrasted with His defense of the poor and the future restoration of His people.",
      ["invoco", "trepido", "inops", "confundo", "Sion", "captivitas"],
      9,
      11,
      "The wicked do not call upon the Lord but instead tremble with a groundless, misplaced fear. In contrast, the Lord is with the righteous generation. The counsel of the poor is confounded because the Lord is their hope. The psalm culminates in a hope for salvation from Zion, when God will restore the fortunes of His people, bringing joy and gladness.",
      "Augustine contrasts the vain, chaotic fears of the godless with the well-placed hope of the righteous. The 'turning of the captivity' is interpreted spiritually as liberation from the bondage of sin, a restoration accomplished by Christ, the true 'salvation from Zion' (Enarr. Ps. 13.9-11)."
    ),
  ]

  // MARK: - Conceptual themes (Psalm 13)

  // MARK: - Conceptual themes (Psalm 13) - CORRECTED

  private let conceptualThemes = [
    (
      "Divine Observation",
      "God's search for understanding among humanity",
      ["prospicio", "intelligo", "requiro", "caelum"],
      ThemeCategory.divine,
      3 ... 4
    ),
    (
      "Moral Corruption",
      "Universal moral decay and absence of good",
      ["corrumpo", "abominabilis", "declino", "inutilis"],
      ThemeCategory.sin,
      1 ... 4
    ),
    (
      "Foolish Atheism",
      "The fool's denial of God and its consequences",
      ["insipiens", "deus", "bonus"],
      ThemeCategory.sin,
      1 ... 2
    ),
    (
      "Deceitful Speech",
      "Tongue that practices deception and violence",
      ["sepulcrum", "guttur", "venenum", "aspis", "dolosus"],
      ThemeCategory.sin,
      5 ... 6
    ),
    (
      "Violent Action",
      "Physical violence and bloodshed",
      ["pes", "sanguis", "velox", "effundo"],
      ThemeCategory.conflict,
      6 ... 6
    ),
    (
      "Destructive Ways",
      "Paths of ruin and ignorance of peace",
      ["contritio", "infelicitas", "via", "pax", "cognosco", "iniquitas"],
      ThemeCategory.sin,
      7 ... 8
    ),
    (
      "Oppression of the Righteous",
      "Devouring God's people like bread",
      ["devoro", "plebs", "cibus", "panis"],
      ThemeCategory.opposition,
      8 ... 8
    ),
    (
      "False Fear",
      "Wrongful terror and misplaced anxiety",
      ["trepido", "timor", "invoco"],
      ThemeCategory.sin,
      9 ... 9
    ),
    (
      "Divine Hope",
      "The Lord as the hope of the righteous",
      ["inops", "confundo", "spes", "dominus"],
      ThemeCategory.virtue,
      10 ... 10
    ),
    (
      "Salvation from Zion",
      "Future restoration and deliverance",
      ["sion", "salus", "captivitas", "averto", "exsulto", "laetor"],
      ThemeCategory.virtue,
      11 ... 11
    ),
  ]

  // MARK: - Test Cases

  func testPsalm13Verses() {
    XCTAssertEqual(psalm13.count, 11, "Psalm 13 should have 11 verses in the Benedictine Office")
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm13.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm13,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testPsalm13LineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm13,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm13StructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: psalm13,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm13ConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: psalm13,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSavePsalm13Themes() {
    guard let jsonString = utilities.generateCompleteThemesJSONString(
      psalmNumber: id.number,
      conceptualThemes: conceptualThemes,
      structuralThemes: structuralThemes
    ) else {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm13_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
