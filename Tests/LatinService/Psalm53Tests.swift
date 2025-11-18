@testable import LatinService
import XCTest

class Psalm53Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 53, category: nil)
  private let expectedVerseCount = 7

  // MARK: - Test Data

  private let text = [
    "Deus, in nomine tuo salvum me fac, et in virtute tua iudica me.",
    "Deus, exaudi orationem meam; auribus percipe verba oris mei.",
    "Quoniam alieni insurrexerunt adversum me, et fortes quaesierunt animam meam; et non proposuerunt Deum ante conspectum suum.",
    "Ecce enim Deus adiuvat me, et Dominus susceptor est animae meae.",
    "Averte mala inimicis meis; et in veritate tua disperde illos.",
    "Voluntarie sacrificabo tibi, et confitebor nomini tuo, Domine, quoniam bonum est:",
    "Quoniam ex omni tribulatione eripuisti me, et super inimicos meos despexit oculus meus."
  ]


  private let englishText = [
    "Save me, O God, by thy name, and judge me in thy strength.",
    "O God, hear my prayer; give ear to the words of my mouth.",
    "For strangers have risen up against me; and the mighty have sought after my soul; and they have not set God before their eyes.",
    "Behold, indeed God helps me, and the Lord is the protector of my soul.",
    "Turn back the evils upon my enemies; and cut them off in thy truth.",
    "I will freely sacrifice to thee, and will give praise, O God, to thy name: because it is good:",
    "For thou hast delivered me out of all trouble, and my eye hath looked down upon my enemies."
  ]

  private let lineKeyLemmas = [
    (1, ["deus","nomen","salvus","facio","virtus","iudico"]),
    (2, ["deus","exaudio","oratio","auris","percipio","verbum","os"]),
    (3, ["alienus","insurro","adversus","fortis","quaero","anima","propono","deus","conspectus"]),
    (4, ["deus","adiuvo","dominus","susceptor","anima"]),
    (5, ["averto","malus","inimicus","veritas","disperdo"]),
    (6, ["voluntarius","sacrifico","confiteor","nomen","dominus","bonus"]),
    (7, ["tribulatio","eripio","inimicus","despicio","oculus"])
  ]

  private let structuralThemes = [
    (
      "Appeal â Listening",
      "The psalmist calls on God for salvation and judgment, then asks Him to hear the prayer.",
      ["deus","nomen","salvus","facio","virtus","iudico","exaudio","oratio","auris","percipio","verbum","os"],
      1,
      2,
      "The believer first seeks divine aid and then petitions God to listen, showing trust in God's responsiveness.",
      "Augustine sees the appeal to God's name as a foundation of faith, and the act of listening as divine grace granting the soul access to truth."
    ),
    (
      "Opposition â Divine Assistance",
      "Enemies rise against the psalmist, yet God intervenes to help and protect.",
      ["alienus","insurro","adversus","fortis","quaero","anima","deus","conspectus","adiuvo","dominus","susceptor","anima"],
      3,
      4,
      "Human opposition is met with divine aid, emphasizing that God's help supersedes worldly threats.",
      "Augustine interprets the opposition as the fallen world's assault, while God's assistance reflects divine mercy that sustains the soul."
    ),
    (
      "Condemnation â Thanksgiving",
      "The psalmist rebukes the wicked and then offers a voluntary sacrifice and praise.",
      ["averto","malus","inimicus","veritas","disperdo","volenter","sacrifico","confiteor","nomen","dominus","bonus"],
      5,
      6,
      "Turning away evil leads to a posture of gratitude and worship toward God.",
      "Augustine reads this as the moral reversal where recognizing sin prompts sincere offering and thanksgiving."
    ),
    (
      "Rescue",
      "God delivers the psalmist from all tribulation and defeats the enemies.",
      ["tribulatio","eripio","inimicus","despecto","oculus"],
      7,
      7,
      "Divine deliverance culminates the psalm, highlighting God's ultimate victory over suffering.",
      "Augustine sees the final verse as the triumph of divine providence, where God's eye looks down and rescues the faithful."
    )
  ]

  private let conceptualThemes = [
    (
      "Divine Rescue",
      "God saves the psalmist from danger and delivers from tribulation.",
      ["deus","salvo","eripio","tribulatio"],
      ThemeCategory.divine,
      nil as ClosedRange<Int>?
    ),
    (
      "Prayer & Supplication",
      "The psalmist petitions God, asking for hearing and aid.",
      ["oratio","exaudio","percipio","nomen","iudico"],
      ThemeCategory.worship,
      1 ... 2 as ClosedRange<Int>?
    ),
    (
      "Divine Assistance",
      "God intervenes to help the psalmist against foes.",
      ["adiuvo","susceptor","dominus","anima"],
      ThemeCategory.divine,
      3 ... 4 as ClosedRange<Int>?
    ),
    (
      "Moral Conflict",
      "The psalmist confronts opposition and evil forces.",
      ["adversus","inimicus","malus","fortis"],
      ThemeCategory.conflict,
      3 ... 5 as ClosedRange<Int>?
    ),
    (
      "Thanksgiving & Sacrifice",
      "Offering sacrifice and praising God for His goodness.",
      ["sacrifico","confiteor","bonus","dominus"],
      ThemeCategory.worship,
      6 ... 6 as ClosedRange<Int>?
    ),
    (
      "Vision & Judgment",
      "God's eye looks down, judging and defeating enemies.",
      ["oculus","despecto","tribulatio"],
      ThemeCategory.justice,
      7 ... 7 as ClosedRange<Int>?
    )
  ]

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 53 should have \\(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 53 English text should have \\(expectedVerseCount) verses")
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
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
    // Verify that all structural theme lemmas are present in lineKeyLemmas
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Run the standard structural themes test
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
    // Verify that conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose,
      failOnMissing: false // Conceptual themes may have additional imagery lemmas
    )

    // Run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveThemes() {
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
      filename: "output_psalm53_themes.json"
    )
     
    if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
