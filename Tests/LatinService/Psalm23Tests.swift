import XCTest

@testable import LatinService

class Psalm23Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 23, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 10
  private let text = [
    "Domini est terra et plenitudo eius, orbis terrarum et universi qui habitant in eo.",
    "Quia ipse super maria fundavit eum, et super flumina praeparavit eum.",
    "Quis ascendet in montem Domini? aut quis stabit in loco sancto eius?",
    "Innocens manibus et mundo corde, qui non accepit in vano animam suam, nec iuravit in dolo proximo suo.",
    "Hic accipiet benedictionem a Domino, et misericordiam a Deo salutari suo.",
    "Haec est generatio quaerentium eum, quaerentium faciem Dei Iacob.",
    "Attollite portas, principes, vestras, et elevamini, portae aeternales, et introibit rex gloriae.",
    "Quis est iste rex gloriae? Dominus fortis et potens, Dominus potens in praelio.",
    "Attollite portas, principes, vestras, et elevamini, portae aeternales, et introibit rex gloriae.",
    "Quis est iste rex gloriae? Dominus virtutum ipse est rex gloriae.",
  ]

  private let englishText = [
    "The earth is the Lord's and the fullness thereof, the world and all who dwell in it.",
    "For he has founded it upon the seas, and established it upon the rivers.",
    "Who shall ascend the mountain of the Lord? Or who shall stand in his holy place?",
    "He who has clean hands and a pure heart, who does not lift up his soul to vanity, nor swear deceitfully to his neighbor.",
    "He shall receive a blessing from the Lord, and mercy from God his Savior.",
    "Such is the generation of those who seek him, who seek the face of the God of Jacob.",
    "Lift up your gates, O princes, and be lifted up, O eternal doors, that the King of Glory may enter in.",
    "Who is this King of Glory? The Lord, strong and mighty, the Lord mighty in battle.",
    "Lift up your gates, O princes, and be lifted up, O eternal doors, that the King of Glory may enter in.",
    "Who is this King of Glory? The Lord of hosts, he is the King of Glory.",
  ]

  private let lineKeyLemmas = [
    (1, ["dominus", "terra", "plenitudo", "orbis", "universus", "habito"]),
    (2, ["mare", "fundo", "flumen", "praeparo"]),
    (3, ["ascendo", "mons", "dominus", "sto", "locus", "sanctus"]),
    (
      4,
      [
        "innocens", "manus", "mundus", "cor", "accipio", "vanus", "anima", "iuro", "dolus",
        "proximus",
      ]
    ),
    (5, ["accipio", "benedictio", "dominus", "misericordia", "deus", "salutaris"]),
    (6, ["generatio", "quaero", "facies", "deus", "iacob"]),
    (7, ["attollo", "porta", "princeps", "elevo", "aeternalis", "introeo", "rex", "gloria"]),
    (8, ["rex", "gloria", "dominus", "fortis", "potens", "praelium"]),
    (9, ["attollo", "porta", "princeps", "elevo", "aeternalis", "introeo", "rex", "gloria"]),
    (10, ["rex", "gloria", "dominus", "virtus", "gloria"]),
  ]

  private let structuralThemes = [
    (
      "Divine Ownership → Creation Foundation",
      "The Lord's ownership of the earth and His establishment of it upon waters",
      ["dominus", "terra", "plenitudo", "mare", "fundo", "flumen"],
      1,
      2,
      "The psalm declares that the earth and its fullness belong to the Lord, and that He founded it upon the seas and established it upon the rivers.",
      "Augustine sees this as the fundamental truth of divine sovereignty - all creation belongs to God and is established by His power, with the waters representing both the chaos He subdued and the baptismal waters of salvation."
    ),
    (
      "Question of Access → Requirements for Holiness",
      "The question of who may approach God's holy mountain and the requirements for such access",
      [
        "ascendo", "mons", "dominus", "sto", "locus", "sanctus", "innocens", "manus", "mundus",
        "cor",
      ],
      3,
      4,
      "The psalm asks who may ascend the Lord's mountain or stand in His holy place, then answers with the requirement of clean hands, pure heart, and integrity.",
      "For Augustine, this represents the soul's inquiry into divine access and the answer that only those purified by grace and walking in righteousness can approach God's presence."
    ),
    (
      "Blessing and Mercy → Generation of Seekers",
      "The blessing received from God leading to the identification of those who seek Him",
      [
        "benedictio", "dominus", "misericordia", "deus", "salutaris", "generatio", "quaero",
        "facies",
      ],
      5,
      6,
      "The one who meets God's requirements receives blessing and mercy from the Lord, and this describes the generation of those who seek Him and seek the face of the God of Jacob.",
      "Augustine sees this as the blessed state of those who have received divine grace, making them part of the generation that actively seeks God's face and presence."
    ),
    (
      "Gates Opening → King of Glory's Entry",
      "The command to lift up gates for the King of Glory to enter, followed by His identification",
      [
        "attollo", "porta", "princeps", "elevo", "aeternalis", "introeo", "rex", "gloria", "fortis",
        "potens",
      ],
      7,
      8,
      "The gates are commanded to be lifted up for the King of Glory to enter, then the King is identified as the Lord, strong and mighty, mighty in battle.",
      "Augustine sees this as the soul's preparation for Christ's entry - the gates of the heart must be opened to receive the King of Glory, who is revealed as the victorious Lord."
    ),
    (
      "Repeated Invitation → Final Revelation",
      "The repeated command to open gates and the final revelation of the King of Glory's identity",
      [
        "attollo", "porta", "princeps", "elevo", "aeternalis", "introeo", "rex", "gloria", "virtus",
      ],
      9,
      10,
      "The gates are again commanded to be lifted up for the King of Glory, and finally the King is revealed as the Lord of hosts, the King of Glory.",
      "For Augustine, this repetition emphasizes the urgency of opening the heart to Christ, and the final revelation shows that the King of Glory is none other than the Lord of all heavenly hosts."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "The Lord's ownership and control over all creation",
      ["dominus", "terra", "plenitudo", "orbis", "universus", "mare", "fundo", "flumen"],
      ThemeCategory.divine,
      1...2
    ),
    (
      "Access to God",
      "Requirements and questions about approaching God's presence",
      [
        "ascendo", "mons", "dominus", "sto", "locus", "sanctus", "innocens", "manus", "mundus",
        "cor",
      ],
      ThemeCategory.worship,
      3...4
    ),
    (
      "Moral Purity",
      "The qualities required for divine access and blessing",
      ["innocens", "manus", "mundus", "cor", "vanus", "anima", "dolus", "proximus"],
      ThemeCategory.virtue,
      4...5
    ),
    (
      "Divine Blessing",
      "The blessings and mercy received from God",
      ["benedictio", "dominus", "misericordia", "deus", "salutaris"],
      ThemeCategory.divine,
      5...6
    ),
    (
      "Seeking God",
      "The generation that actively seeks the Lord's presence",
      ["generatio", "quaero", "facies", "deus", "iacob"],
      ThemeCategory.worship,
      6...6
    ),
    (
      "Gates and Entry",
      "The opening of gates for the King of Glory to enter",
      ["attollo", "porta", "princeps", "elevo", "aeternalis", "introeo"],
      ThemeCategory.worship,
      7...10
    ),
    (
      "King of Glory",
      "The identity and attributes of the King of Glory",
      ["rex", "gloria", "dominus", "fortis", "potens", "praelium", "virtus"],
      ThemeCategory.divine,
      7...10
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 23 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 23 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm23_texts.json"
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
      filename: "output_psalm23_themes.json"
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
