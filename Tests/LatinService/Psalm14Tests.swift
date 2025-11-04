@testable import LatinService
import XCTest

class Psalm14Tests: XCTestCase {
  // private var latinService: LatinService!
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let psalm14 = [
    "Domine, quis habitabit in tabernaculo tuo? aut quis requiescet in monte sancto tuo?",
    "Qui ingreditur sine macula, et operatur iustitiam;",
    "Qui loquitur veritatem in corde suo, qui non egit dolum in lingua sua;",
    "Nec fecit proximo suo malum, et opprobrium non sustinuit adversus proximos suos;",
    "Ad nihilum deductus est in conspectu eius malignus, timentes autem Dominum glorificat;",
    "Qui iurat proximo suo, et non decipit; Qui pecuniam suam non dedit ad usuram, et munera super innocentem non accepit.",
    "Qui facit haec, non movebitur in aeternum.",
  ]

  private let englishText = [
    "Lord, who shall dwell in thy tabernacle? or who shall rest in thy holy hill?",
    "He that walketh without blemish, and worketh justice;",
    "He that speaketh truth in his heart, who hath not used deceit in his tongue;",
    "Nor hath done evil to his neighbor, nor taken up a reproach against his neighbors;",
    "In his sight the malignant is brought to nothing: but he glorifieth them that fear the Lord.",
    "He that sweareth to his neighbor, and deceiveth not; He that hath not put out his money to usury, nor taken bribes against the innocent.",
    "He that doth these things shall not be moved for ever."
  ]

  // MARK: - Line-by-line key lemmas (Psalm 14)

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["dominus", "habito", "tabernaculum", "requiesco", "mons", "sanctus"]),
    (2, ["ingredior", "sine", "macula", "operor", "iustitia"]),
    (3, ["loquor", "veritas", "cor", "ago", "dolus", "lingua"]),
    (4, ["facio", "proximus", "malum", "opprobrium", "sustineo", "adversus"]),
    (5, ["nihilum", "deduco", "conspectus", "malignus", "timeo", "dominus", "glorifico"]),
    (6, ["iuro", "proximus", "decipio", "pecunia", "do", "usura", "munus", "innocens", "accipio"]),
    (7, ["facio", "moveo", "aeternum"]),
  ]

  // MARK: - Structural themes (Psalm 14) — from themes.json

  private let structuralThemes: [(String, String, [String], Int, Int, String, String)] = [
    (
      "Dwelling → Holiness",
      "From the question of who may dwell with God to the requirement of purity and justice",
      ["habito", "tabernaculum", "requiesco", "mons", "sanctus", "macula", "iustitia"],
      1,
      2,
      "The psalm begins by asking who is worthy to dwell with God. The answer: one who walks blamelessly and acts with justice.",
      "Augustine reads the 'tabernacle' and 'holy mountain' as Christ and His Church. To inhabit them is to live in holiness, with actions aligned to God's justice (Enarr. Ps. 14.1–2)."
    ),
    (
      "Truth → Integrity",
      "From inward truth to outward integrity in speech and conduct",
      ["veritas", "cor", "dolus", "lingua", "malum", "proximus"],
      3,
      4,
      "The true worshipper speaks truth from the heart, avoids deceit, and does no harm to a neighbor.",
      "Augustine emphasizes that it is not enough to avoid lying with the tongue; the heart itself must be purified, since God sees within (Enarr. Ps. 14.3–4)."
    ),
    (
      "Reverence → Faithfulness",
      "From despising the wicked to honoring the God-fearing, from swearing oaths to financial integrity",
      ["malignus", "conspectus", "timeo", "glorifico", "iuro", "decipio", "pecunia", "usura", "munus", "innocens"],
      5,
      6,
      "The righteous person despises evil, honors those who fear the Lord, keeps his word, and maintains financial integrity by refusing usury and bribes.",
      "Augustine sees in this a picture of the Church: despising sin, honoring holiness, standing firm in truth without deception, and avoiding financial exploitation (Enarr. Ps. 14.5–6)."
    ),
    (
      "Action → Stability",
      "From doing what is right to the promise of eternal security",
      ["facio", "moveo", "aeternum"],
      7,
      7,
      "Those who do these things—who live according to God's standards—are promised immovable stability forever.",
      "Augustine concludes that the one who embodies all these virtues, grounded in Christ, 'shall not be moved forever'—a promise of eternal security for the faithful (Enarr. Ps. 14.7)."
    ),
  ]

  // MARK: - Conceptual themes (Psalm 14)

  private let conceptualThemes = [
    (
      "Divine Holiness",
      "God's sacred dwelling and holy requirements",
      ["tabernaculum", "mons", "sanctus", "dominus"],
      ThemeCategory.divine,
      1 ... 1
    ),
    (
      "Divine Judgment",
      "God's righteous evaluation and justice",
      ["conspectus", "malignus", "glorifico", "timeo"],
      ThemeCategory.justice,
      5 ... 5
    ),
    (
      "Righteous Worship",
      "Worthy approach to God's presence",
      ["habito", "requiesco", "ingredior", "operor"],
      ThemeCategory.worship,
      1 ... 2
    ),
    (
      "Moral Virtue",
      "Blameless character and truthful heart",
      ["macula", "iustitia", "veritas", "cor"],
      ThemeCategory.virtue,
      2 ... 3
    ),
    (
      "Social Virtue",
      "Right relationships and neighborly love",
      ["proximus", "malum", "opprobrium", "iuro"],
      ThemeCategory.virtue,
      3 ... 6
    ),
    (
      "Deceitful Speech",
      "Tongue that practices deception",
      ["dolus", "lingua", "decipio"],
      ThemeCategory.sin,
      3 ... 6
    ),
    (
      "Financial Corruption",
      "Exploitative financial practices",
      ["usura", "munus", "innocens"],
      ThemeCategory.conflict,
      6 ... 6
    ),
    (
      "Wicked Opposition", "Those rejected from God's presence", ["malignus", "nihilum"],
      ThemeCategory.opposition, 5 ... 5
    ),

    (
      "Eternal Stability",
      "Divine reward for the righteous",
      ["moveo", "aeternum", "facio"],
      ThemeCategory.virtue,
      7 ... 7
    ),
  ]

    let id =  PsalmIdentity(number: 14, category: nil)

  // MARK: - Test Cases

  func testTotalVerses() {
    let expectedVerseCount = 7
    XCTAssertEqual(
      psalm14.count, expectedVerseCount, "Psalm 14 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 14 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = psalm14.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      psalm14,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: psalm14,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm14_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testPsalm14LineByLineKeyLemmas() {
    utilities.testLineByLineKeyLemmas(
      psalmText: psalm14,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm14StructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: psalm14,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testPsalm14ConceptualThemes() {
    utilities.testConceptualThemes(
      psalmText: psalm14,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSavePsalm14Themes() {
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
      filename: "output_psalm14_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }
}
