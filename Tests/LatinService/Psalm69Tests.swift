@testable import LatinService
import XCTest

class Psalm69Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 69, category: "")

  // MARK: - Test Data Properties

  private let psalm69 = [
    "Deus, in adiutorium meum intende; Domine, ad adiuvandum me festina.",
    "Confundantur et revereantur, qui quaerunt animam meam.",
    "Avertantur retrorsum et erubescant, qui volunt mihi mala.",
    "Avertantur statim erubescentes, qui dicunt mihi: Euge, euge.",
    "Exsultent et laetentur in te omnes qui quaerunt te; et dicant semper: Magnificetur Deus, qui diligunt salutare tuum.",
    "Ego vero egenus et pauper sum; Deus, adiuva me. Adiutor meus et liberator meus es tu; Domine, ne moreris.",
  ]

  private let englishText = [
    "O God, come to my assistance; O Lord, make haste to help me.",
    "Let them be confounded and ashamed who seek my soul.",
    "Let them be turned backward and blush, who desire evils to me.",
    "Let them be presently turned away blushing, who say to me: 'Well done, well done.'",
    "Let all who seek you rejoice and be glad in you; and let those who love your salvation say always: 'Let God be magnified.'",
    "But I am needy and poor; O God, help me. You are my helper and my deliverer; O Lord, do not delay.",
  ]

  private let lineKeyLemmas = [
    (1, ["deus", "adiutorium", "intendo", "dominus", "adiuvo", "festino"]),
    (2, ["confundo", "revereor", "quaero", "anima"]),
    (3, ["averto", "retrorsum", "erubesco", "volo", "malus"]),
    (4, ["averto", "statim", "erubesco", "dico", "euge"]),
    (5, ["exsulto", "laetor", "quaero", "dico", "semper", "magnifico", "deus", "diligo", "salutare"]),
    (6, ["egenus", "pauper", "deus", "adiuvo", "adiutor", "liberator", "dominus", "mora"]),
  ]

  private let structuralThemes = [
    (
      "Urgent Plea for Help → Divine Assistance",
      "The psalmist's immediate call for God's help and assistance",
      ["deus", "adiutorium", "intendo", "dominus", "adiuvo", "festino"],
      1,
      1,
      "The psalmist urgently calls upon God to come to his assistance and for the Lord to make haste to help him.",
      "Augustine sees this as the soul's immediate recognition of its need for divine help and the urgency of turning to God in times of distress."
    ),
    (
      "Confusion of Enemies → Shame and Reversal",
      "The psalmist's desire for enemies to be confounded and turned back",
      ["confundo", "revereor", "quaero", "anima", "averto", "retrorsum", "erubesco"],
      2,
      3,
      "The psalmist prays that those who seek his soul be confounded and ashamed, and that those who desire evil be turned backward and blush.",
      "For Augustine, this represents the soul's prayer that evil intentions be frustrated and that those who oppose God's people be brought to shame and repentance."
    ),
    (
      "Mockery Reversed → Joy in Seeking God",
      "The reversal of mockers contrasted with the joy of those who seek God",
      ["euge", "averto", "erubesco", "exsulto", "laetor", "quaero", "magnifico"],
      4,
      5,
      "Those who mock with 'Euge, euge' are turned away blushing, while all who seek God rejoice and say 'Let God be magnified.'",
      "Augustine sees this as the contrast between the temporary shame of mockers and the eternal joy of those who truly seek and love God."
    ),
    (
      "Personal Poverty → Divine Help",
      "The psalmist's acknowledgment of his neediness leading to trust in divine help",
      ["egenus", "pauper", "deus", "adiuvo", "adiutor", "liberator", "mora"],
      6,
      6,
      "The psalmist acknowledges his poverty and neediness, then declares his trust in God as his helper and deliverer, asking Him not to delay.",
      "For Augustine, this represents the soul's humble recognition of its dependence on God and confident trust in His timely assistance and deliverance."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Assistance",
      "Calls for God's help and assistance in times of need",
      ["deus", "adiutorium", "intendo", "dominus", "adiuvo", "festino", "adiutor", "liberator"],
      ThemeCategory.divine,
      1 ... 6
    ),
    (
      "Enemy Confusion",
      "Prayers for enemies to be confounded, ashamed, and turned back",
      ["confundo", "revereor", "averto", "retrorsum", "erubesco"],
      ThemeCategory.justice,
      2 ... 4
    ),
    (
      "Seeking and Rejoicing",
      "The joy and gladness of those who seek God",
      ["quaero", "exsulto", "laetor", "magnifico", "diligo", "salutare"],
      ThemeCategory.worship,
      5 ... 5
    ),
    (
      "Personal Humility",
      "Acknowledgment of personal poverty and neediness",
      ["egenus", "pauper", "anima"],
      ThemeCategory.virtue,
      2 ... 6
    ),
    (
      "Divine Timing",
      "Trust in God's timely response and deliverance",
      ["festino", "statim", "mora"],
      ThemeCategory.divine,
      1 ... 6
    ),
    (
      "Mockery and Reversal",
      "The shame and reversal of those who mock the righteous",
      ["euge", "dico", "averto", "erubesco"],
      ThemeCategory.sin,
      4 ... 4
    ),
    (
      "Eternal Praise",
      "The perpetual magnification and praise of God",
      ["semper", "magnifico", "deus", "diligo", "salutare"],
      ThemeCategory.worship,
      5 ... 5
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      psalm69.count, 6, "Psalm 70 should have 6 verses"
    )
    XCTAssertEqual(
      englishText.count, 6,
      "Psalm 70 English text should have 6 verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm69.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm69,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm69,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm69_texts.json"
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
      filename: "output_psalm69_themes.json"
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
      psalmText: psalm69,
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
      psalmText: psalm69,
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
      psalmText: psalm69,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
