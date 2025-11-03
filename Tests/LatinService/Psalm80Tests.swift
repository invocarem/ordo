@testable import LatinService
import XCTest

class Psalm80Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 80, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 15
  private let text = [
    "Exsultate Deo, adiutori nostro; iubilate Deo Iacob.",
    "Sumite psalmum, et date tympanum; psalterium iucundum cum cithara.",
    "Buccinate in neomenia tuba, in insigni die solemnitatis vestrae;",
    "quia praeceptum in Israel est, et iudicium Deo Iacob.",
    "Testimonium in Ioseph posuit illud, cum exiret de terra Aegypti; linguam quam non noverat audivit.",
  
    "Divertit ab oneribus dorsum eius; manus eius in cophino servierunt.",
    "In tribulatione invocasti me, et liberavi te; exaudivi te in abscondito tempestatis; probavi te apud aquam contradictionis.",
    "Audi, populus meus, et contestabor te; Israel, si audieris me, non erit in te deus recens, neque adorabis deum alienum.",
    "Ego enim sum Dominus Deus tuus, qui eduxi te de terra Aegypti; dilata os tuum, et implebo illud.",
    "Et non audivit populus meus vocem meam, et Israel non intendit mihi.",
    
    "Et dimisi eos secundum desideria cordis eorum; ibunt in adinventionibus suis.",
    "Si populus meus audisset me, Israel si in viis meis ambulasset,",
    "pro nihilo forsitan inimicos eorum humiliassem, et super tribulantes eos misissem manum meam.",
    "Inimici Domini mentiti sunt ei, et erit tempus eorum in saecula.",
    "Et cibavit eos ex adipe frumenti, et de petra melle saturavit eos."
  ]

  private let englishText = [
    "Rejoice to God our helper; sing aloud to the God of Jacob.",
    "Take a psalm, and bring hither the timbrel; the pleasant psaltery with the harp.",
    "Blow up the trumpet on the new moon, on the noted day of your solemnity;",
    "for it is a commandment in Israel, and a judgment to the God of Jacob.",
    "He ordained it for a testimony in Joseph, when he came out of the land of Egypt; he heard a tongue which he knew not.",

    "He removed his back from the burdens; his hands had served in baskets.",
    "Thou calledst upon me in affliction, and I delivered thee; I heard thee in the secret place of tempest; I proved thee at the waters of contradiction.",
    "Hear, O my people, and I will testify to thee; O Israel, if thou wilt hearken to me, there shall be no new god in thee, neither shalt thou adore a strange god.",
    "For I am the Lord thy God, who brought thee out of the land of Egypt; open thy mouth wide, and I will fill it.",
    "But my people heard not my voice, and Israel hearkened not to me.",
    
    "So I let them go according to the desires of their heart; they shall walk in their own inventions.",
    "If my people had heard me, if Israel had walked in my ways,",
    "I should soon have humbled their enemies, and laid my hand on them that troubled them.",
    "The enemies of the Lord have lied to him, and their time shall be for ever.",
    "And he fed them with the fat of wheat, and filled them with honey out of the rock."
  ]

  private let lineKeyLemmas = [
    (1, ["exsulto", "deus", "adiutor", "iubilo", "Iacob"]),
    (2, ["sumo", "psalmus", "do", "tympanum", "psalterium", "iucundus", "cithara"]),
    (3, ["buccino", "neomenia", "tuba", "insignis", "dies", "solemnitas"]),
    (4, ["praeceptum", "Israel", "iudicium", "deus", "Iacob"]),
    (5, ["testimonium", "Iosephus", "pono", "exeo", "terra", "Aegyptus", "lingua", "nosco", "audio"]),
    (6, ["diverto", "onus", "dorsum", "manus", "cophinus", "servio"]),
    (7, ["tribulatio", "invoco", "libero", "exaudio", "absconditus", "tempestas", "probo", "aqua", "contradictio"]),
    (8, ["audio", "populus", "contestror", "Israel", "deus", "recens", "adoro", "deus", "alienus"]),
    (9, ["dominus", "deus", "educo", "terra", "Aegyptus", "dilato", "os", "impleo"]),
    (10, ["audio", "populus", "vox", "Israel", "intendo"]),
    (11, ["dimitto", "desiderium", "cor", "eo", "adinventio"]),
    (12, ["populus", "audio", "Israel", "via", "ambulo"]),
    (13, ["nihil", "inimicus", "humilio", "super", "tribulo", "mitto", "manus"]),
    (14, ["inimicus", "dominus", "mentior", "tempus", "saeculum"]),
    (15, ["cibo", "adeps", "frumentum", "petra", "mel", "saturo"])
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 80 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 80 English text should have \(expectedVerseCount) verses"
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
      filename: "output_psalm80_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
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
}