@testable import LatinService
import XCTest

class Psalm38Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 38, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 18
  private let text = [
    "Dixi: Custodiam vias meas, ut non delinquam in lingua mea;",
    "Posui ori meo custodiam, cum staret peccator adversum me.",
    "Obmutui, et humiliatus sum, et silui a bonis; et dolor meus renovatus est.",
    "Concaluit cor meum intra me; et in meditatione mea exardescet ignis.",
    "Locutus sum in lingua mea: Notum fac mihi, Domine, finem meum,", /* 5 */
    "Et numerum dierum meorum quis est, ut sciam quid desit mihi.",
    "Ecce mensurabiles posuisti dies meos, et substantia mea tamquam nihilum ante te; ", /* 7 */
    "verumtamen universa vanitas, omnis homo vivens.",
    "Verumtamen in imagine pertransit homo; sed et frustra conturbatur:", /* 9 */
    "Thesaurizat, et ignorat cui congregabit ea.", /* 10 */
    "Et nunc quid est exspectatio mea? Nonne Dominus? Et substantia mea apud te est.",
    "Ab omnibus iniquitatibus meis erue me; opprobrium insipienti dedisti me.",
    "Obmutui, et non aperui os meum, quoniam tu fecisti; amove a me plagas tuas.",
    "A fortitudine manus tuae ego consumptus sum in increpationibus; propter iniquitatem castigasti hominem, ", /* 14 */
    "Et tabescere fecisti sicut araneam animam eius; verumtamen vane conturbatur omnis homo.", /* 15 */
    "Exaudi orationem meam, Domine, et deprecationem meam; auribus percipe lacrimas meas. ", /* 16 */
    "Ne sileas, quoniam advena ego sum apud te, et peregrinus, sicut omnes patres mei.",
    "Remitte mihi, ut refrigerer priusquam abeam, et amplius non ero.",
  ]

  private let englishText = [
    "I said: I will take heed to my ways: that I sin not with my tongue.",
    "I have set a guard to my mouth, when the sinner stood against me.",
    "I was dumb, and was humbled, and kept silence from good things: and my sorrow was renewed.",
    "My heart grew hot within me: and in my meditation a fire shall flame out.",
    "I spoke with my tongue: O Lord, make me know my end,",
    "And what is the number of my days: that I may know what is wanting to me.",
    "Behold thou hast made my days measurable: and my substance is as nothing before thee.",
    "And indeed all things are vanity: every man living.",
    "Surely man passeth as an image: yea, and he is troubled in vain.",
    "He storeth up: and he knoweth not for whom he shall gather these things.",
    "And now what is my hope? Is it not the Lord? And my substance is with thee.",
    "Deliver thou me from all my iniquities: thou hast made me a reproach to the fool.",
    "I was dumb, and I opened not my mouth, because thou hast done it: remove thy scourges from me.",
    "By the strength of thy hand I fainted in rebukes: for iniquity thou hast chastised man,",
    "And thou hast made his soul to waste away like a spider: surely in vain is any man disquieted.",
    "Hear my prayer, O Lord, and my supplication: give ear to my tears.",
    "Be not silent: for I am a stranger with thee, and a sojourner as all my fathers were.",
    "O forgive me, that I may be refreshed, before I go hence, and be no more.",
  ]

  private let lineKeyLemmas = [
    (1, ["dico", "custodio", "via", "delinquo", "lingua"]),
    (2, ["pono", "os", "custodia", "sto", "peccator", "adversus"]),
    (3, ["obmutuesco", "humilio", "sileo", "bonus", "dolor", "renovo"]),
    (4, ["concalesco", "cor", "intra", "meditatio", "exardesco", "ignis"]),
    (5, ["loquor", "lingua", "notus", "facio", "dominus", "finis"]),
    (6, ["numerus", "dies", "scio", "desum"]),
    (7, ["ecce", "mensurabilis", "pono", "dies", "substantia", "nihilum"]),
    (8, ["verumtamen", "universus", "vanitas", "homo", "vivo"]),
    (9, ["verumtamen", "imago", "pertranseo", "homo", "frustra", "conturbo"]),
    (10, ["thesaurizo", "ignoro", "congrego"]),
    (11, ["nunc", "exspectatio", "dominus", "substantia", "apud"]),
    (12, ["iniquitas", "eruo", "opprobrium", "insipiens", "do"]),
    (13, ["obmutuesco", "aperio", "os", "quoniam", "facio", "amoveo", "plaga"]),
    (14, ["fortitudo", "manus", "consumo", "increpatio", "iniquitas", "castigo", "homo"]),
    (15, ["tabesco", "facio", "aranea", "anima", "vane", "conturbo"]),
    (16, ["exaudio", "oratio", "dominus", "deprecatio", "auris", "percipio", "lacrima"]),
    (17, ["sileo", "advena", "peregrinus", "pater"]),
    (18, ["remitto", "refrigero", "priusquam", "abeo", "amplius"]),
  ]

  private let structuralThemes = [
    (
      "Vow of Silence → Guarded Speech",
      "The psalmist's resolution to guard his ways and tongue, setting a guard against sinners",
      ["dico", "custodio", "via", "delinquo", "lingua", "pono", "os", "custodia", "sto", "peccator", "adversus"],
      1,
      2,
      "The psalmist vows to guard his ways and tongue, setting a guard on his mouth when sinners stand against him.",
      "Augustine sees this as the soul's initial resolution for purity and protection against external temptations and opposition."
    ),
    (
      "Silent Suffering → Inner Fire",
      "Humbled silence and renewed sorrow leading to burning heart and meditation",
      ["obmutuesco", "humilio", "sileo", "bonus", "dolor", "renovo", "concalesco", "cor", "intra", "meditatio", "exardesco", "ignis"],
      3,
      4,
      "The psalmist becomes dumb and humbled, keeping silence from good things while his sorrow is renewed, and his heart burns within him in meditation.",
      "For Augustine, this represents the soul's internal struggle where external silence reveals inner turmoil and divine fire that purifies through suffering."
    ),
    (
      "Quest for Understanding → Divine Knowledge",
      "Seeking knowledge of life's end and limitations from God",
      ["loquor", "lingua", "notus", "facio", "dominus", "finis", "numerus", "dies", "scio", "desum"],
      5,
      6,
      "The psalmist speaks with his tongue, asking God to make known his end and the number of his days, that he may know what is wanting to him.",
      "This represents the soul's earnest desire for divine wisdom and understanding of its temporal limitations and eternal destiny."
    ),
    (
      "Human Vanity → Fleeting Existence",
      "Recognition of life's brevity and the vanity of earthly pursuits",
      ["ecce", "mensurabilis", "pono", "dies", "substantia", "nihilum", "verumtamen", "universus", "vanitas", "homo", "vivo"],
      7,
      8,
      "The psalmist acknowledges that his days are measured and his substance is nothing before God, recognizing all things as vanity and every living man as transient.",
      "Augustine interprets this as the soul's awakening to spiritual reality - seeing earthly life as transient and human efforts as ultimately futile without God."
    ),
    (
      "Fleeting Life → Divine Hope",
      "Man passes as an image but finds hope and substance in the Lord",
      ["verumtamen", "imago", "pertranseo", "homo", "frustra", "conturbo", "thesaurizo", "ignoro", "congrego", "nunc", "exspectatio", "dominus", "substantia", "apud"],
      9,
      10,
      "Man passes as an image and is troubled in vain, storing up treasures without knowing for whom, but the psalmist's hope and substance is in the Lord.",
      "This represents the soul's recognition of earthly futility contrasted with divine hope and true substance found only in God."
    ),
    (
      "Divine Deliverance → Acceptance of Discipline",
      "Pleading for deliverance from iniquities and accepting God's discipline",
      ["iniquitas", "eruo", "opprobrium", "insipiens", "do", "obmutuesco", "aperio", "os", "quoniam", "facio", "amoveo", "plaga"],
      11,
      12,
      "The psalmist pleads for deliverance from all his iniquities and the reproach he suffers, then accepts his suffering as from God's hand and asks for the removal of his scourges.",
      "Augustine sees this as the soul's progression from seeking deliverance to accepting God's purifying discipline as necessary for spiritual growth."
    ),
    (
      "Divine Discipline → Human Frailty",
      "God's chastisement reveals human fragility like a spider's web",
      ["fortitudo", "manus", "consumo", "increpatio", "iniquitas", "castigo", "homo", "tabesco", "facio", "aranea", "anima", "vane", "conturbo"],
      13,
      14,
      "By the strength of God's hand the psalmist is consumed in rebukes, for iniquity God chastises man and makes his soul waste away like a spider's web.",
      "This represents the soul's recognition of its complete dependence on divine mercy and the fragility of human strength under God's purifying discipline."
    ),
    (
      "Human Frailty → Earnest Supplication",
      "Recognition of human weakness leading to earnest prayer for God's attention",
      ["tabesco", "facio", "aranea", "anima", "vane", "conturbo", "exaudio", "oratio", "dominus", "deprecatio", "auris", "percipio", "lacrima"],
      15,
      16,
      "The soul wastes away like a spider's web and all men are troubled in vain, leading the psalmist to cry out for God to hear his prayer and tears.",
      "Augustine sees this as the soul's complete recognition of its fragility leading to desperate supplication for divine attention and mercy."
    ),
    (
      "Pilgrim Identity → Final Plea",
      "Acknowledging transient nature as a stranger and pleading for refreshment before life's end",
      ["sileo", "advena", "peregrinus", "pater", "remitto", "refrigero", "priusquam", "abeo", "amplius"],
      17,
      18,
      "The psalmist asks God not to be silent, acknowledging his transient nature as a stranger and sojourner like all his fathers, and pleads for forgiveness and refreshment before departing this life.",
      "For Augustine, this final appeal represents the soul's ultimate recognition of its pilgrim status and desperate need for divine grace before the journey's end."
    ),
  ]

  private let conceptualThemes = [
    (
      "Human Transience",
      "Themes of life's brevity, vanity, and fleeting nature",
      ["dies", "substantia", "nihilum", "vanitas", "imago", "pertranseo", "abeo", "amplius"],
      ThemeCategory.virtue,
      7 ... 18
    ),
    (
      "Divine Discipline",
      "God's chastisement, rebuke, and purifying suffering",
      ["dolor", "castigo", "plaga", "increpatio", "tabesco", "conturbo"],
      ThemeCategory.divine,
      3 ... 15
    ),
    (
      "Prayer and Supplication",
      "Earnest appeals, tears, and cries to God",
      ["oratio", "deprecatio", "lacrima", "exaudio", "remitto", "refrigero"],
      ThemeCategory.worship,
      11 ... 18
    ),
    (
      "Silence and Restraint",
      "Self-imposed silence, guarded speech, and humility",
      ["custodio", "lingua", "obmutuesco", "sileo", "humilio", "aperio", "os"],
      ThemeCategory.virtue,
      1 ... 13
    ),
    (
      "Inner Turmoil",
      "Emotional struggle, burning heart, and spiritual conflict",
      ["dolor", "concalesco", "cor", "ignis", "conturbo", "consumo"],
      ThemeCategory.sin,
      3 ... 15
    ),
    (
      "Pilgrim Identity",
      "Recognition of earthly life as temporary sojourning",
      ["advena", "peregrinus", "pater", "abeo", "amplius"],
      ThemeCategory.virtue,
      17 ... 18
    ),
    (
      "Divine Knowledge and Understanding",
      "Seeking knowledge from God and divine wisdom",
      ["notus", "facio", "dominus", "finis", "numerus", "dies", "scio", "desum"],
      ThemeCategory.divine,
      5 ... 6
    ),
    (
      "Divine Hope and Substance",
      "Finding hope and true substance in the Lord",
      ["exspectatio", "dominus", "substantia", "apud", "nunc"],
      ThemeCategory.divine,
      9 ... 11
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 38 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 38 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm38_texts.json"
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
      filename: "output_psalm38_themes.json"
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
