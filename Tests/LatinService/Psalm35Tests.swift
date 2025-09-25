@testable import LatinService
import XCTest

class Psalm35Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 35, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 13
  private let text = [
    "Dixit iniustus ut delinquat in semetipso; non est timor Dei ante oculos eius.",
    "Quoniam dolose egit in conspectu eius, ut inveniatur iniquitas eius ad odium.",
    "Verba oris eius iniquitas, et dolus; noluit intelligere ut bene ageret.",
    "Iniquitatem meditatus est in cubili suo; astitit omni viae non bonae, malitiam autem non odivit.",
    "Domine, in caelo misericordia tua; et veritas tua usque ad nubes.",
    "Iustitia tua sicut montes Dei; iudicia tua abyssus multa.",
    "Homines et iumenta salvabis, Domine; quemadmodum multiplicasti misericordiam tuam, Deus.",
    "Filii autem hominum in tegmine alarum tuarum sperabunt.",
    "Inebriabuntur ab ubertate domus tuae; et torrente voluptatis tuae potabis eos.",
    "Quoniam apud te est fons vitae; et in lumine tuo videbimus lumen.",
    "Praetende misericordiam tuam scientibus te, et iustitiam tuam his qui recto sunt corde.",
    "Non veniat mihi pes superbiae; et manus peccatoris non moveat me.",
    "Ibi ceciderunt qui operantur iniquitatem; expulsi sunt, nec potuerunt stare.",
  ]

  private let englishText = [
    "The unjust hath said within himself, that he would sin; there is no fear of God before his eyes.",
    "For in his sight he hath done deceitfully, that his iniquity may be found unto hatred.",
    "The words of his mouth are iniquity and guile; he would not understand that he might do well.",
    "He hath devised iniquity on his bed; he hath set himself on every way that is not good; but evil he hath not hated.",
    "O Lord, thy mercy is in heaven; and thy truth reacheth even to the clouds.",
    "Thy justice is as the mountains of God; thy judgments are a great deep.",
    "Men and beasts thou wilt preserve, O Lord; O how hast thou multiplied thy mercy, O God!",
    "But the children of men shall put their trust under the covert of thy wings.",
    "They shall be inebriated with the plenty of thy house; and thou shalt make them drink of the torrent of thy pleasure.",
    "For with thee is the fountain of life; and in thy light we shall see light.",
    "Extend thy mercy to them that know thee, and thy justice to them that are right in heart.",
    "Let not the foot of pride come to me; and let not the hand of the sinner move me.",
    "There the workers of iniquity are fallen; they are cast out, and could not stand.",
  ]

  private let lineKeyLemmas = [
    (1, ["dico", "iniustus", "delinquo", "timor", "deus", "oculus"]),
    (2, ["dolosus", "ago", "conspectus", "invenio", "iniquitas", "odium"]),
    (3, ["verbum", "os", "iniquitas", "dolus", "intelligo", "ago"]),
    (4, ["iniquitas", "meditor", "cubile", "asto", "via", "malitia", "odi"]),
    (5, ["dominus", "caelum", "misericordia", "veritas", "nubes"]),
    (6, ["iustitia", "mons", "deus", "iudicium", "abyssus", "multus"]),
    (7, ["homo", "iumentum", "salvo", "dominus", "multiplico", "misericordia", "deus"]),
    (8, ["filius", "homo", "tegmen", "ala", "spero"]),
    (9, ["inebrio", "ubertas", "domus", "torrens", "voluptas", "poto"]),
    (10, ["fons", "vita", "lumen", "video"]),
    (11, ["praetendo", "misericordia", "scio", "iustitia", "rectus", "cor"]),
    (12, ["pes", "superbia", "manus", "peccator", "moveo"]),
    (13, ["cado", "operor", "iniquitas", "expello", "sto"]),
  ]

  private let structuralThemes = [
    (
      "Wickedness of the Unjust → Divine Absence",
      "The unjust man's deliberate sinning and lack of fear of God",
      ["iniustus", "delinquo", "timor", "deus", "oculus"],
      1,
      2,
      "The unjust man says within himself that he would sin, with no fear of God before his eyes, and acts deceitfully so that his iniquity may be found unto hatred.",
      "Augustine sees this as the soul's deliberate rejection of divine law and the absence of holy fear, where the sinner chooses evil and acts with guile to avoid detection."
    ),
    (
      "Deceit and Iniquity → Rejection of Good",
      "The wicked man's words of iniquity and refusal to understand good",
      ["iniquitas", "dolus", "intelligo", "ago"],
      3,
      4,
      "The words of his mouth are iniquity and guile; he would not understand that he might do well, and has devised iniquity on his bed, setting himself on every way that is not good.",
      "For Augustine, this represents the soul's complete corruption where speech becomes deceitful, understanding is perverted, and the sinner actively chooses evil paths while rejecting good."
    ),
    (
      "Divine Mercy and Truth → Heavenly Justice",
      "God's mercy in heaven and His truth reaching to the clouds, with justice like mountains",
      ["dominus", "caelum", "misericordia", "veritas", "nubes", "iustitia", "mons"],
      5,
      6,
      "The Lord's mercy is in heaven and His truth reaches to the clouds, while His justice is like the mountains of God and His judgments are a great deep.",
      "Augustine sees this as the contrast between human wickedness and divine perfection, where God's attributes transcend earthly limitations and provide the standard of true justice."
    ),
    (
      "Divine Preservation → Trust in God",
      "God's preservation of men and beasts, and the children of men trusting under His wings",
      ["homo", "iumentum", "salvo", "multiplico", "filius", "tegmen", "ala", "spero"],
      7,
      8,
      "Men and beasts God will preserve, and He has multiplied His mercy, while the children of men shall put their trust under the covert of His wings.",
      "Augustine sees this as God's universal care for all creation and the special relationship with humanity, where His mercy is abundant and His protection is like a mother bird's wings."
    ),
    (
      "Divine Abundance → Fountain of Life",
      "The abundance of God's house and the fountain of life with Him",
      ["inebrio", "ubertas", "domus", "torrens", "voluptas", "fons", "vita", "lumen"],
      9,
      10,
      "They shall be inebriated with the plenty of God's house and drink of the torrent of His pleasure, for with Him is the fountain of life and in His light we shall see light.",
      "For Augustine, this represents the soul's spiritual satisfaction in God's presence, where divine abundance leads to true life and enlightenment, contrasting with the emptiness of sin."
    ),
    (
      "Divine Justice → Righteous Living",
      "God's mercy to those who know Him and justice to the upright in heart",
      ["praetendo", "misericordia", "scio", "iustitia", "rectus", "cor"],
      11,
      12,
      "God extends His mercy to those who know Him and His justice to those who are right in heart, while the psalmist prays that the foot of pride not come to him nor the hand of the sinner move him.",
      "Augustine sees this as the proper response to divine grace - those who know God receive mercy, the upright receive justice, and the faithful must guard against pride and sinful influence."
    ),
    (
      "Fall of the Wicked → Divine Judgment",
      "The workers of iniquity falling and being cast out, unable to stand",
      ["cado", "operor", "iniquitas", "expello", "sto"],
      13,
      13,
      "There the workers of iniquity are fallen; they are cast out, and could not stand.",
      "Augustine sees this as the inevitable end of those who persist in wickedness - they will fall, be expelled from God's presence, and be unable to stand in judgment, contrasting with the stability of the righteous."
    ),
  ]

  private let conceptualThemes = [
    (
      "Wickedness and Sin",
      "References to injustice, iniquity, deceit, and deliberate sinning",
      ["iniustus", "delinquo", "iniquitas", "dolus", "malitia"],
      ThemeCategory.sin,
      1 ... 4
    ),
    (
      "Divine Attributes",
      "God's mercy, truth, justice, and other divine qualities",
      ["misericordia", "veritas", "iustitia", "iudicium", "salvo"],
      ThemeCategory.divine,
      5 ... 11
    ),
    (
      "Heavenly and Natural Imagery",
      "References to heaven, clouds, mountains, and natural elements",
      ["caelum", "nubes", "mons", "abyssus", "fons", "lumen"],
      ThemeCategory.divine,
      5 ... 10
    ),
    (
      "Human Nature and Response",
      "References to humanity, understanding, and human responses to God",
      ["homo", "filius", "intelligo", "scio", "spero", "rectus"],
      ThemeCategory.virtue,
      1 ... 12
    ),
    (
      "Divine Protection and Care",
      "God's preservation, protection, and care for His people",
      ["salvo", "tegmen", "ala", "domus", "ubertas"],
      ThemeCategory.divine,
      7 ... 9
    ),
    (
      "Pride and Humility",
      "References to pride, humility, and the contrast between the proud and humble",
      ["superbia", "pes", "manus", "peccator", "rectus", "cor"],
      ThemeCategory.sin,
      11 ... 13
    ),
    (
      "Divine Judgment",
      "God's judgment, expulsion, and the fate of the wicked",
      ["iudicium", "cado", "expello", "operor", "iniquitas"],
      ThemeCategory.divine,
      6 ... 13
    ),
    (
      "Spiritual Satisfaction",
      "References to abundance, pleasure, and spiritual fulfillment in God",
      ["inebrio", "ubertas", "voluptas", "poto", "fons", "vita"],
      ThemeCategory.worship,
      9 ... 10
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 35 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 35 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm35_texts.json"
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
      filename: "output_psalm35_themes.json"
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
