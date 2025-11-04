@testable import LatinService
import XCTest

class Psalm80Tests: XCTestCase
{
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

  private let structuralThemes = [
    (
      "Call to Rejoice → Instruments of Praise",
      "Summons to exult in God followed by taking up worship instruments",
      ["exsulto", "deus", "adiutor", "iubilo", "sumo", "psalmus", "tympanum", "psalterium", "cithara"],
      1,
      2,
      "The psalm opens with a call to exult in God as helper and sing to the God of Jacob, then to take up psalms, timbrels, pleasant psalteries, and harps for worship.",
      "Augustine sees this as the soul's joyful response to divine assistance, using all available means - voice and instruments - to express praise, representing the full engagement of human faculties in worship of the true Helper."
    ),
    (
      "Trumpet Blasts → Divine Ordinances",
      "Call to blow trumpets for feasts grounded in God's commands and judgments",
      ["buccino", "neomenia", "tuba", "solemnitas", "praeceptum", "iudicium", "deus", "Iacob"],
      3,
      4,
      "The call to blow trumpets at the new moon and solemn feast days is grounded in God's established commandment and judgment for Israel, connecting worship to divine authority.",
      "For Augustine, the sacred times and trumpet blasts represent God's orderly establishment of worship, where external ceremonies point to internal spiritual realities of divine encounter."
    ),
    (
      "Exodus Testimony → Liberation from Burdens",
      "The testimony established in Joseph followed by physical liberation from servitude",
      ["testimonium", "Iosephus", "pono", "exeo", "terra", "Aegyptus", "diverto", "onus", "dorsum"],
      5,
      6,
      "God established this testimony in Joseph when Israel came out of Egypt, and removed the burden from their back, freeing them from servitude.",
      "Augustine interprets this as the foundational testimony of God's saving power, where the Exodus represents both historical deliverance and spiritual liberation from sin's burden."
    ),
    (
      "Cry in Tribulation → Divine Testing",
      "Israel's call for help in trouble followed by God's testing at the waters",
      ["tribulatio", "invoco", "libero", "exaudio", "absconditus", "tempestas", "probo", "aqua", "contradictio"],
      7,
      8,
      "God delivered Israel when they called in tribulation, hearing them in the secret place of tempest, but tested them at the waters of contradiction.",
      "Augustine sees this as God's pattern of both delivering His people and testing their faith, with the waters of contradiction representing moments of spiritual testing that reveal the heart's true condition."
    ),
    (
      "Divine Appeal → Promise of Provision",
      "God's plea for exclusive worship followed by promise to fill their needs",
      ["audio", "populus", "contestror", "deus", "recens", "alienus", "dominus", "educo", "dilato", "os", "impleo"],
      9,
      10,
      "God calls Israel to hear Him, warning against new or foreign gods while reminding them of Exodus deliverance and offering to fill their needs if they open wide their mouths.",
      "Augustine interprets this as God's gracious invitation to trust in His provision alone, contrasting the emptiness of idolatry with the fullness found in faithful dependence on the true God."
    ),
    (
      "Human Rejection → Divine Withdrawal",
      "Israel's refusal to listen followed by God letting them follow their desires",
      ["audio", "vox", "intendo", "dimitto", "desiderium", "cor", "adinventio", "eo"],
      11,
      12,
      "Despite God's appeals, Israel did not listen, so He let them go according to the desires of their heart to walk in their own inventions.",
      "For Augustine, this shows the sobering reality that God sometimes allows His people to experience the natural consequences of rejecting His ways, as a form of disciplinary love."
    ),
    (
      "Hypothetical Obedience → Enemy's Judgment",
      "What could have been if Israel obeyed contrasted with enemies' fate",
      ["populus", "audio", "via", "ambulo", "nihil", "inimicus", "humilio", "tribulo", "mitto", "manus"],
      13,
      14,
      "God laments that if Israel had obeyed, He would have quickly humbled their enemies, but instead the enemies of the Lord face judgment for their deception.",
      "Augustine sees this as the contrast between the protection obedience brings and the judgment that awaits those who actively oppose God's truth and deceive His people."
    ),
    (
      "Divine Feeding → Supernatural Sustenance",
      "God's provision of finest wheat followed by honey from the rock",
      ["cibo", "adeps", "frumentum", "petra", "mel", "saturo"],
      15,
      15,
      "Despite Israel's disobedience, God still fed them with the fat of wheat and satisfied them with honey from the rock, showing His persistent grace and provision.",
      "Augustine interprets this as God's merciful provision that continues despite human failure, with honey from the rock representing Christ's sweet grace flowing from the stony tomb, the ultimate supernatural sustenance."
    )
  ]

  private let conceptualThemes = [
    (
      "Worship Instruments",
      "Musical instruments used in divine worship",
      ["tympanum", "psalterium", "cithara", "tuba"],
      ThemeCategory.worship,
      1 ... 4
    ),
    (
      "Divine Commands",
      "God's statutes, judgments, and testimonies",
      ["praeceptum", "iudicium", "testimonium"],
      ThemeCategory.divine,
      4 ... 5
    ),
    (
      "Exodus Remembrance",
      "References to the deliverance from Egypt",
      ["Aegyptus", "educo", "terra"],
      ThemeCategory.divine,
      5 ... 9
    ),
    (
      "Human Body Parts",
      "Physical references in spiritual context",
      ["dorsum", "manus", "os", "cor"],
      ThemeCategory.virtue,
      6 ... 11
    ),
    (
      "Divine-Human Dialogue",
      "Communication between God and His people",
      ["audio", "vox", "intendo", "contestror"],
      ThemeCategory.divine,
      7 ... 12
    ),
    (
      "Disobedience Consequences",
      "Results of not heeding God's voice",
      ["dimitto", "desiderium", "adinventio", "nihil"],
      ThemeCategory.sin,
      10 ... 13
    ),
    (
      "Enemies and Judgment",
      "Opposition to God and divine judgment",
      ["inimicus", "humilio", "tribulo", "mentior", "tempus", "saeculum"],
      ThemeCategory.justice,
      13 ... 14
    ),
    (
      "Divine Provision",
      "God's abundant care and feeding",
      ["cibo", "adeps", "frumentum", "mel", "petra", "saturo"],
      ThemeCategory.divine,
      15 ... 15
    )
  ]

  // MARK: - Setup

  override func setUp()
  {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses()
  {
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

  func testSaveTexts()
  {
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

    if success
    {
      print("✅ Complete texts JSON created successfully")
    }
    else
    {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }

  func testLineByLineKeyLemmas()
  {
    let utilities = PsalmTestUtilities.self
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }
}
