---
description: Psalm Tests Rules
---

# Psalm Tests Rules 

These rules apply whenever testing a psalm from 1 to 150. All test files must follow this structure and conventions.

## 1. Psalm Identity
- **id** represents the psalm number and optional liturgical category
- Psalm number follows the Vulgate numbering system (1-150)
- Category is used for liturgical purposes (e.g., Psalm 9 has categories "a" and "b" for different Prime hours)
- Format: `PsalmIdentity(number: <number>, category: <optional category string>)`
- Example: `let id = PsalmIdentity(number: 1, category: nil)` for Psalm 1
- Example: `let id = PsalmIdentity(number: 9, category: "a")` for Psalm 9a

## 2. Latin Text
- **text** contains the Latin verses as an array of strings
- Each element corresponds to one verse in order
- Text must use classical Latin orthography (no medieval variants unless specified)
- Must match the Vulgate text exactly

## 3. English Translation
- **englishText** contains the English translation as an array of strings
- Each element must correspond line-by-line with the Latin text
- Translation must be accurate and maintain the same verse structure
- Use the Douay-Rheims translation as the standard reference

## 4. Verse Count Validation
- **expectedVerseCount** must equal the number of elements in both `text` and `englishText`
- Test: `XCTAssertEqual(text.count, expectedVerseCount, "Psalm X should have Y verses")`
- Test: `XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm X English text should have Y verses")`

## 5. Line Key Lemmas
- **lineKeyLemmas** is an array of tuples: `(verseNumber, [lemma1, lemma2, ...])`
- Include only semantically significant words (nouns, verbs, adjectives, key adverbs)
- Omit common function words: et, in, a, ad, de, non, que, sed, cum, ut, etc.
- Include all key theological, imagery, and conceptual terms
- Must cover every significant word in each verse
- Example: `(1, ["beatus", "vir", "abeo", "consilium", "impius", "via", "peccator", "sto", "cathedra", "pestilentia", "sedeo"])`

## 6. Structural Themes
- Each structural theme covers exactly two consecutive verses (1-2, 3-4, 5-6, etc.)
- For odd-numbered psalms, the final theme covers the last three verses (e.g., 5-7 for Psalm 1)
- Each theme is a tuple with 7 elements:
  1. **name**: "A → B" format describing the transformation (e.g., "Separation → Delight")
  2. **description**: theme description
  3. **lemmas**: array of key Latin lemmas from these verses
  4. **startVerse**: first verse number in the theme
  5. **endVerse**: last verse number in the theme
  6. **comment**: brief general meaning of the two verses
  7. **augustineQuote**: theological interpretation from Augustine's Expositions on the Psalms (Enarr. Ps. X.Y)
- Themes must reflect the narrative progression or theological development across the verses

## 7. Conceptual Themes
- Each conceptual theme identifies a recurring theological concept across the entire psalm
- Themes are based on imagery and conceptual patterns, not verse-by-verse structure
- Each theme is a tuple with 5 elements:
  1. **name**: conceptual theme title (e.g., "Divine Sovereignty")
  2. **comment**: brief description of the concept
  3. **lemmas**: array of key Latin lemmas that express this concept
  4. **category**: ThemeCategory (divine, justice, worship, virtue, conflict, sin, opposition)
  5. **verseRange**: optional ClosedRange<Int> specifying which verses contain this theme (nil if pervasive)
- Conceptual themes may span multiple verses and should capture the psalm's overarching ideas

## 8. Required Tests
The test class must include these test methods:

- **testTotalVerses()**: Validates verse count consistency between Latin and English texts
- **testLineByLineKeyLemmas()**: Verifies all key lemmas are correctly identified per verse
- **testStructuralThemes()**: Validates structural themes against the text and Augustine's interpretations
- **testConceptualThemes()**: Validates conceptual themes against the text and their thematic categories
- **testSaveThemes()**: Generates and saves complete themes JSON for program use
- **testSaveTexts()**: Generates and saves complete texts JSON for program use

## 9. Validation Rules
- All Latin text must be normalized using `PsalmTestUtilities.validateLatinText($0)` to ensure classical orthography
- All lemmas must be validated against Whitaker's Latin morphology analyzer
- Augustine quotes must be accurately cited from Enarrationes in Psalmos
- JSON output files must be valid and usable by the application's theme processing system

Example structure:
```swift
@testable import LatinService
import XCTest

class Psalm1Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 1, category: nil)
  private let expectedVerseCount = 7

  // MARK: - Test Data

  private let text = [
    "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;",
    "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte.",
    "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:",
    "Et folium eius non defluet, et omnia quaecumque faciet, prosperabuntur.",
    "Non sic impii, non sic: sed tamquam pulvis, quem proicit ventus a facie terrae.",
    "Ideo non resurgent impii in iudicio, neque peccatores in concilio iustorum;",
    "Quoniam novit Dominus viam iustorum: et iter impiorum peribit.",
  ]

  private let englishText = [
    "Blessed is the man who hath not walked in the counsel of the ungodly, nor stood in the way of sinners, nor sat in the chair of pestilence.",
    "But his will is in the law of the Lord, and on his law he shall meditate day and night.",
    "And he shall be like a tree which is planted near the running waters, which shall bring forth its fruit in due season.",
    "And his leaf shall not fall off: and all whatsoever he shall do shall prosper.",
    "Not so the wicked, not so: but like the dust which the wind driveth from the face of the earth.",
    "Therefore the wicked shall not rise again in judgment: nor sinners in the council of the just;",
    "For the Lord knoweth the way of the just: and the way of the wicked shall perish.",
  ]

  private let lineKeyLemmas = [
    (1, ["beatus", "vir", "abeo", "consilium", "impius", "via", "peccator", "sto", "cathedra", "pestilentia", "sedeo"]),
    (2, ["lex", "dominus", "voluntas", "meditor", "dies", "nox"]),
    (3, ["lignum", "planto", "secus", "decursus", "aqua", "fructus", "do", "tempus"]),
    (4, ["folium", "defluo", "omnis", "facio", "prospero"]),
    (5, ["impius", "pulvis", "proicio", "ventus", "facies", "terra"]),
    (6, ["resurgo", "impius", "iudicium", "peccator", "concilium", "iustus"]),
    (7, ["nosco", "dominus", "via", "iustus", "iter", "impius", "pereo"]),
  ]

  private let structuralThemes = [
    (
      "Separation → Delight",
      "From avoidance of the wicked to joy in God's law",
      ["sto", "abeo", "sedeo", "lex", "meditor"],
      1,
      2,
      "The blessed one turns away from the path of the wicked and instead finds delight in the law of the Lord.",
      "Augustine interprets this as a triple renunciation (consilium → via → cathedra), culminating in the joy of meditating on the Law. For him, the righteous one is defined by inward transformation and desire for God (Enarr. Ps. 1.1–2)."
    ),
    (
      "Rootedness → Fruitfulness",
      "From spiritual planting to lasting vitality and success",
      ["lignum", "planto", "aqua", "fructus", "prospero"],
      3,
      4,
      "The just is like a tree planted by streams, yielding fruit in its season and not withering. This image emphasizes stability, growth, and enduring vitality through divine nourishment.",
      "Augustine reads the tree as one rooted in grace and Scripture, continually refreshed by Christ, the living water. Its fruit signifies good works in due season, prospering by God's help (Enarr. Ps. 1.3)."
    ),
    (
      "Chaff → Separation",
      "From unstable wickedness to final divine separation",
      ["pulvis", "iudicium", "via", "iter", "pereo", "nosco"],
      5,
      7,
      "The wicked cannot stand in judgment or in the assembly of the righteous, for the Lord knows the way of the just while the way of the impious comes to nothing.",
      "Augustine contrasts the rooted tree of the righteous with the empty lightness of the ungodly. The Lord 'knows' (novit) the way of the just with covenantal intimacy, but the way of the wicked perishes — eternal separation from God (Enarr. Ps. 1.5–6)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "God's authority and knowledge",
      ["nosco"],
      ThemeCategory.divine,
      nil as ClosedRange<Int>?
    ),
    (
      "Divine Justice",
      "God's righteous judgment",
      ["pereo", "resurgo", "proicio", "ventus", "pulvis", "terra"],
      .justice,
      5 ... 7
    ),
    (
      "Righteous Worship",
      "The blessed man's devotion",
      ["meditor", "voluntas"],
      .worship,
      2 ... 2
    ),
    (
      "Virtuous Life",
      "Qualities of the righteous person",
      ["beatus", "iustus", "prospero", "fructus", "lignum", "aqua", "folium"],
      .virtue,
      nil as ClosedRange<Int>?
    ),
    (
      "Spiritual Conflict",
      "Walking in the way of sinners",
      ["peccator", "sto"],
      .conflict,
      1 ... 1
    ),
    (
      "Sinful Nature",
      "Following counsel of wicked",
      ["impius", "abeo"],
      .sin,
      1 ... 1
    ),
    (
      "Worldly Opposition",
      "Sitting in seat of pestilence",
      ["pestilentia", "sedeo"],
      .opposition,
      1 ... 1
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 1 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 1 English text should have \(expectedVerseCount) verses")
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
    // First, verify that conceptual theme lemmas are in lineKeyLemmas
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

    // Then run the standard conceptual themes test
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
      filename: "output_psalm1_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testSaveTexts() {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm1_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
```

