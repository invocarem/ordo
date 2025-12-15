@testable import LatinService
import XCTest

class Psalm104BTests: XCTestCase
{
  private let utilities = PsalmTestUtilities.self
  private let verbose = true

  override func setUp()
  {
    super.setUp()
  }

  let id = PsalmIdentity(number: 104, category: "b")
  private let expectedVerseCount = 23

  // MARK: - Test Data

  private let text = [
    "Et intravit Israel in Aegyptum, et Jacob accola fuit in terra Cham.",
    "Et auxit populum suum vehementer, et firmavit eum super inimicos eius.",
    "Convertit cor eorum ut odirent populum eius, et dolum facerent in servos eius.",
    "Misit Moysen servum suum, Aaron quem elegit ipsum.",
    "Posuit in eis verba signorum suorum, et prodigiorum in terra Cham.",

    "Misit tenebras, et obscuravit; et non exacerbavit sermones suos.",
    "Convertit aquas eorum in sanguinem, et occidit pisces eorum.",
    "Edidit terra eorum ranas in penetralibus regum ipsorum.",
    "Dixit, et venit coenomyia, et ciniphes in omnibus finibus eorum.",
    "Posuit pluvias eorum grandinem, ignem comburentem in terra ipsorum.",

    "Et percussit vineas eorum, et ficulneas eorum, et contrivit lignum finium eorum.",
    "Dixit, et venit locusta, et bruchus, cujus non erat numerus,",
    "et comedit omne foenum in terra eorum, et comedit omnem fructum terrae eorum.",
    "Et percussit omne primogenitum in terra eorum, primitias omnis laboris eorum.",
    "Et eduxit eos cum argento et auro, et non erat in tribubus eorum infirmus.",

    "Laetata est Aegyptus in profectione eorum, quia incubuit timor eorum super eos.",
    "Expandit nubem in protectionem eorum, et ignem ut luceret eis per noctem.",
    "Petierunt, et venit coturnix, et pane caeli saturavit eos.",
    "Dirupit petram, et fluxerunt aquae; abierunt torrentes in sicco.",
    "Quia memor fuit verbi sancti sui, quod habuit ad Abraham puerum suum.",

    "Et eduxit populum suum in exsultatione, et electos suos in laetitia.",
    "Et dedit illis regiones gentium, et labores populorum possederunt,",
    "ut custodiant iustificationes eius, et legem eius requirant."
  ]

  private let englishText = [
    "And Israel went into Egypt: and Jacob was a sojourner in the land of Cham.",
    "And he increased his people exceedingly, and strengthened them over their enemies.",
    "He turned their heart to hate his people: and to deal deceitfully with his servants.",
    "He sent Moses his servant: Aaron the man whom he had chosen.",
    "He gave them power to shew forth his signs, and his wonders in the land of Cham.",

    "He sent darkness, and made it obscure: and grieved not his words.",
    "He turned their waters into blood, and destroyed their fish.",
    "Their land brought forth frogs, in the inner chambers of their kings.",
    "He spoke, and there came divers sorts of flies, and sciniphs in all their coasts.",
    "He gave them hail for rain, a burning fire in their land.",

    "And he destroyed their vineyards, and their fig trees: and he broke in pieces the trees of their coasts.",
    "He spoke, and the locust came, and the bruchus, of which there was no number,",
    "And they devoured all the grass in their land, and consumed all the fruit of their ground.",
    "And he slew all the firstborn in their land: the firstfruits of all their labour.",
    "And he brought them out with silver and gold: and there was not among their tribes one that was feeble.",

    "Egypt was glad when they departed: for the fear of them lay upon them.",
    "He spread a cloud for their protection, and fire to give them light in the night.",
    "They asked, and the quail came: and he filled them with the bread of heaven.",
    "He opened the rock, and waters flowed: rivers ran down in the dry land.",
    "Because he remembered his holy word, which he had spoken to his servant Abraham.",

    "And he brought forth his people with joy, and his chosen with gladness.",
    "And he gave them the lands of the Gentiles: and they possessed the labours of the people,",
    "That they might observe his justifications, and seek after his law."
  ]
  private let lineKeyLemmas = [
    (1, ["intro", "israel", "aegyptus", "Iacob", "accola", "terra", "Cham"]),
    (2, ["augeo", "populus", "vehementer", "firmo", "inimicus"]),
    (3, ["converto", "cor", "odeo", "populus", "dolus", "facio", "servus"]),
    (4, ["mitto", "moyses", "servus", "aaron", "eligo", "ipse"]),
    (5, ["pono", "verbum", "signum", "prodigium", "terra", "Cham"]),
    (6, ["mitto", "tenebrae", "obscuro", "exacerbo", "sermo"]),
    (7, ["converto", "aqua", "sanguis", "occido", "piscis"]),
    (8, ["edo", "terra", "rana", "penetrale", "rex"]),
    (9, ["dico", "venio", "coenomyia", "ciniphs", "finis"]),
    (10, ["pono", "pluvia", "grando", "ignis", "comburo", "terra"]),
    (11, ["percutio", "vinea", "ficulneus", "contero", "lignum", "finis"]),
    (12, ["dico", "venio", "locusta", "bruchus", "numerus"]),
    (13, ["comedo", "foenum", "terra", "fructus", "terra"]),
    (14, ["percutio", "primogenitus", "terra", "primitia", "labor"]),
    (15, ["educo", "argentum", "aurum", "infirmus", "tribus"]),
    (16, ["laetor", "aegyptus", "profectio", "incubo", "timor"]),
    (17, ["expando", "nubes", "protectio", "ignis", "luceo", "nox"]),
    (18, ["peto", "coturnix", "panis", "caelum", "saturo"]),
    (19, ["dirumpo", "petra", "fluo", "aqua", "abeo", "torrens", "sicco"]),
    (20, ["memor", "verbum", "sanctus", "Abraham", "puer"]),
    (21, ["educo", "populus", "exsultatio", "eligo", "laetitia"]),
    (22, ["do", "regio", "gens", "labor", "populus", "possideo"]),
    (23, ["custodio", "iustificatio", "lex", "requiro"])
  ]

  private let structuralThemes = [
    (
      "Oppression → Deliverance",
      "From Egyptian hostility to divine intervention through Moses and Aaron",
      ["odirent", "dolum", "facerent", "misit", "moyses", "aaron", "elegit"],
      1,
      2,
      "The psalm traces Israel's descent into Egyptian servitude and God's response by sending Moses and Aaron as His instruments of deliverance.",
      "Augustine sees this as God's hidden providence: though the Egyptians hated Israel, God used their oppression to prepare the way for His chosen leaders (Enarr. Ps. 104.1–2)."
    ),
    (
      "Divine Authority → Human Response",
      "God's command over Egypt's natural order and the Egyptians' inability to resist",
      ["convertit", "cor", "misit", "moyses", "servum", "aaron", "elegit", "ipse"],
      3,
      4,
      "God turns hearts and sends His servants, demonstrating sovereign control over both human will and divine mission.",
      "Augustine notes that God’s choice of Moses and Aaron is not arbitrary but a fulfillment of covenantal purpose, even amid hardened hearts (Enarr. Ps. 104.3)."
    ),
    (
      "Signs → Wonders",
      "The manifestation of God’s power through visible signs and miraculous acts in Egypt",
      ["posuit", "verba", "signum", "prodigium", "terra", "cham"],
      5,
      6,
      "God’s signs and wonders are both revealed and restrained — darkness is sent, but His word is not exacerbated.",
      "Augustine observes that God’s signs are not chaotic but ordered: darkness is a sign, His word a command — both serve His purpose (Enarr. Ps. 104.4)."
    ),
    (
      "Water → Blood",
      "The first plague as a reversal of life-giving elements into instruments of judgment",
      ["convertit", "aqua", "sanguinem", "occidit", "pisces"],
      7,
      8,
      "The Nile, source of life, becomes blood — a symbol of death and divine judgment on Egypt’s idolatry.",
      "Augustine interprets the turning of water to blood as a judgment on Egypt’s worship of the Nile as a god (Enarr. Ps. 104.5)."
    ),
    (
      "Frogs → Infestation",
      "The proliferation of life as a curse, invading the most sacred spaces",
      ["edidit", "terra", "rana", "penetralis", "rex"],
      9,
      10,
      "Frogs emerge from the land and invade royal chambers — God’s judgment reaches the heart of Egyptian power.",
      "Augustine sees the frogs as a mockery of Egyptian deities, whose sacred spaces are defiled by unclean creatures (Enarr. Ps. 104.6)."
    ),
    (
      "Flies → Pestilence",
      "Swarms of insects spreading corruption across the land",
      ["dixit", "venit", "coenomyia", "ciniphes", "omnibus", "finis"],
      11,
      12,
      "Diverse flies and lice invade every boundary, symbolizing the spread of divine judgment without restraint.",
      "Augustine notes that these pests, though small, represent the inescapable presence of God’s justice (Enarr. Ps. 104.7)."
    ),
    (
      "Hail → Fire",
      "The fusion of opposing elements as instruments of divine wrath",
      ["posuit", "pluvias", "grandinem", "ignis", "comburo", "terra"],
      13,
      14,
      "Hail and fire — normally separate — are united in judgment, consuming the land’s produce.",
      "Augustine teaches that God’s wrath is not limited to one element but combines nature’s forces to demonstrate His supremacy (Enarr. Ps. 104.8)."
    ),
    (
      "Vineyards → Destruction",
      "The ruin of agricultural abundance as a sign of covenantal judgment",
      ["percussit", "vinea", "ficulnea", "contrivit", "lignum", "finis"],
      15,
      16,
      "The fruit-bearing trees of Egypt are struck down, symbolizing the collapse of its economic and spiritual foundations.",
      "Augustine links the destruction of vines and fig trees to the fall of false security — what men trust in, God breaks (Enarr. Ps. 104.9)."
    ),
    (
      "Locusts → Devouring",
      "The unstoppable swarm that consumes all vegetation",
      ["dixit", "venit", "locusta", "bruchus", "numerus", "comedit", "foenum", "fructus", "terra"],
      17,
      18,
      "Locusts and bruchus, without number, devour every green thing — a complete annihilation of sustenance.",
      "Augustine sees the locust as a symbol of the multitude of sins that consume the soul if left unchecked (Enarr. Ps. 104.10)."
    ),
    (
      "Firstborn → Death",
      "The ultimate judgment on Egypt’s pride and power",
      ["percussit", "primogenitum", "terra", "primitia", "labor"],
      19,
      20,
      "The death of the firstborn strikes at the core of Egyptian lineage and labor — the very foundation of their society.",
      "Augustine calls this the final and most terrible sign: God strikes the heart of Egypt’s future, fulfilling His promise to Abraham (Enarr. Ps. 104.11)."
    ),
    (
      "Exodus → Wealth",
      "Israel’s departure marked not by poverty but by divine enrichment",
      ["eduxit", "argento", "auro", "infirma", "tribus"],
      21,
      22,
      "Israel leaves Egypt laden with silver and gold — God’s justice turns the oppressor’s wealth into the redeemed’s inheritance.",
      "Augustine sees this as a foreshadowing of the Church taking the riches of the world for God’s service (Enarr. Ps. 104.12)."
    ),
    (
      "Egypt’s Joy → Fear",
      "The paradox of Egypt rejoicing at Israel’s departure, yet trembling in terror",
      ["laetata", "aegyptus", "profectio", "incubuit", "timor"],
      23,
      23,
      "Egypt is glad to be rid of Israel, yet overwhelmed by fear — their relief is tainted by dread of divine power.",
      "Augustine notes this fear is the last echo of God’s presence: even in departure, His name is feared (Enarr. Ps. 104.13)."
    )
  ]

  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "God's absolute authority over nations and nature",
      ["misit", "posuit", "convertit", "dixit", "percussit", "expandit", "dirupit", "memor", "dedit"],
      ThemeCategory.divine,
      1 ... 23
    ),
    (
      "Divine Justice",
      "God's righteous judgment on oppression and idolatry",
      ["odirent", "dolum", "facerent", "occidit", "exacerbavit", "primogenitum", "inimicos"],
      ThemeCategory.justice,
      1 ... 14
    ),
    (
      "Covenant Faithfulness",
      "God's unwavering commitment to His promises to Abraham",
      ["memor", "verbum", "sanctus", "abraham", "puer", "eduxit", "exsultatione", "laetitia"],
      ThemeCategory.divine,
      20 ... 21
    ),
    (
      "Provision and Sustenance",
      "God's care for His people in wilderness and exile",
      ["auxit", "firmavit", "argento", "auro", "nubes", "ignis", "coturnix", "panis", "caelum", "petra", "aqua", "torrentes"],
      ThemeCategory.divine,
      2 ... 19
    ),
    (
      "Israel's Election",
      "The chosen status of Jacob's descendants",
      ["israel", "jacobs", "populus", "servus", "electos", "tribus", "infirmus"],
      ThemeCategory.divine,
      1 ... 15
    ),
    (
      "Egypt's Judgment",
      "The downfall of the oppressor nation",
      ["aegyptum", "cham", "inimicos", "tenebras", "sanguinem", "rana", "coenomyia", "grandinem", "ignis", "locusta", "bruchus", "primogenitum", "laetata", "timor"],
      ThemeCategory.opposition,
      1 ... 16
    ),
    (
      "Worship and Obedience",
      "The purpose of deliverance: to keep God's law",
      ["custodiant", "iustificationes", "lex", "requirant"],
      ThemeCategory.worship,
      23 ... 23
    ),
    (
      "Creation Reversal",
      "God's power to undo and remake natural order",
      ["convertit", "aqua", "sanguinem", "tenebras", "obscuravit", "pluvias", "grandinem", "ignem", "dirupit", "fluxerunt", "abierunt", "torrentes", "sicco"],
      ThemeCategory.divine,
      6 ... 19
    )
  ]

  func testTotalVerses()
  {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 104B should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 104B English text should have \(expectedVerseCount) verses")
    // Validate orthography
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas()
  {
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes()
  {
    // Verify all structural theme lemmas are in lineKeyLemmas
    let structuralLemmas = structuralThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: structuralLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "structural themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Run standard structural themes test
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes()
  {
    // Verify all conceptual theme lemmas are in lineKeyLemmas
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

    // Run standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testSaveThemes()
  {
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        conceptualThemes: conceptualThemes,
        structuralThemes: structuralThemes
      )
    else
    {
      XCTFail("Failed to generate complete themes JSON")
      return
    }

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm104b_themes.json"
    )

    if success
    {
      print("✅ Complete themes JSON created successfully")
    }
    else
    {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testSaveTexts()
  {
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm104b_texts.json"
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
}
