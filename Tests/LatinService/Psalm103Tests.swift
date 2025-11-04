// Tests/LatinService/Psalm103Tests.swift

import XCTest

@testable import LatinService

class Psalm103ATests: XCTestCase
{
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 103, category: "A")
  private let expectedVerseCount = 22

  private let text = [
    "Benedic, anima mea, Domino. Domine Deus meus, magnificatus es vehementer.",
    "Confessionem et decorem induisti, amictus lumine sicut vestimento.",
    "Extendens caelum sicut pellem, qui tegis aquis superiora eius.",
    "Qui ponis nubem ascensum tuum, qui ambulas super pennas ventorum.",
    "Qui facis angelos tuos spiritus, et ministros tuos ignem urentem.",
    "Qui fundasti terram super stabilitatem suam, non inclinabitur in saeculum saeculi.",
    "Abyssus sicut vestimentum amictus eius; super montes stabunt aquae.",
    "Ab increpatione tua fugient, a voce tonitrui tui formidabunt.",
    "Ascendunt montes, et descendunt campi in locum quem fundasti eis.",
    "Terminum posuisti quem non transgredientur, neque convertentur operire terram.",
    "Qui emittis fontes in convallibus; inter medium montums pertransibunt aquae.",
    "Potabunt omnes bestiae agri; expectabunt onagri in siti sua.",
    "Super ea volucres caeli habitabunt, de medio petrarum dabunt voces.",
    "Rigans montes de superioribus suis, de fructu operum tuorum satiabitur terra.",
    "Producens foenum jumentis, et herbam servituti hominum,",
    "ut educas panem de terra, et vinum laetificet cor hominis.",
    "Ut exhilaret faciem in oleo, et panis cor hominis confirmet.",
    "Saturabuntur ligna campi, et cedri Libani quas plantavit.",
    "Illic passeres nidificabunt; herodii domus dux est eorum.",
    "Montes excelsi cervis, petra refugium herinaciis.",
    "Fecit lunam in tempora; sol cognovit occasum suum.",
    "Posuisti tenebras, et facta est nox; in ipsa pertransibunt omnes bestiae silvae.",
    "Catuli leonum rugientes ut rapiant, et quaerant a Deo escam sibi.",
    "Ortus est sol, et congregati sunt, et in cubilibus suis collocabuntur.",
    "Exibit homo ad opus suum, et ad operationem suum usque ad vesperum.",
    "Quam magnificata sunt opera tua, Domine! omnia in sapientia fecisti;",
    "impleta est terra possessione tua."
  ]

  private let englishText = [
    "Bless the Lord, O my soul: O Lord my God, thou art exceedingly great.",
    "Thou hast put on praise and beauty: and art clothed with light as with a garment.",
    "Who stretchest out the heaven like a pavilion: who coverest the higher rooms thereof with water.",
    "Who makest the clouds thy chariot: who walkest upon the wings of the winds.",
    "Who makest thy angels spirits: and thy ministers a burning fire.",
    "Who hast founded the earth upon its own bases: it shall not be moved for ever and ever.",
    "The deep like a garment is its clothing: above the mountains shall the waters stand.",
    "At thy rebuke they shall flee: at the voice of thy thunder they shall fear.",
    "The mountains ascend, and the plains descend into the place which thou hast founded for them.",
    "Thou hast set a bound which they shall not pass over; neither shall they return to cover the earth.",
    "Thou sendest forth springs in the vales: between the midst of the hills the waters shall pass.",
    "All the beasts of the field shall drink: the wild asses shall expect in their thirst.",
    "Over them the birds of the air shall dwell: from the midst of the rocks they shall give forth their voices.",
    "Thou waterest the hills from thy upper rooms: the earth shall be filled with the fruit of thy works.",
    "Bringing forth grass for cattle, and herb for the service of men,",
    "That thou mayst bring bread out of the earth: and that wine may cheer the heart of man.",
    "That he may make the face cheerful with oil: and that bread may strengthen man’s heart.",
    "The trees of the field shall be filled, and the cedars of Libanus which he hath planted:",
    "There the sparrows shall make their nests. The highest of them is the house of the heron.",
    "The high hills are a refuge for the harts, the rock for the hedgehogs.",
    "He hath made the moon for seasons: the sun knoweth his going down.",
    "Thou hast appointed darkness, and it is night: in it shall all the beasts of the woods go about:",
    "The young lions roaring after their prey, and seeking their meat from God.",
    "The sun ariseth, and they are gathered together: and they shall lie down in their dens.",
    "Man shall go forth to his work, and to his labour until the evening.",
    "How great are thy works, O Lord! thou hast made all things in wisdom:",
    "the earth is filled with thy riches."
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["benedico", "anima", "dominus"]),
    (2, ["confessio", "decor", "induo", "lumina", "vestimentum"]),
    (3, ["extendo", "caelum", "tego", "aqua"]),
    (4, ["pono", "nubes", "ascendo", "ambo", "penna", "ventus"]),
    (5, ["facio", "angelus", "spiritus", "minister", "ignis", "uro"]),
    (6, ["fundo", "terra", "stabilitas", "inclino"]),
    (7, ["abyssus", "vestimentum", "mons", "aqua", "sto"]),
    (8, ["increpatio", "fugo", "vox", "tonitrus", "formido"]),
    (9, ["ascendo", "mons", "campus", "descendo", "fundamentum"]),
    (10, ["terminus", "transgredo", "converto", "opero", "terra"]),
    (11, ["emitto", "fons", "convallis", "medium", "transeo"]),
    (12, ["poto", "bestia", "ager", "expecto", "onager", "sitis"]),
    (13, ["super", "volucris", "caelum", "habito", "petra", "do", "vox"]),
    (14, ["rigo", "mons", "superior", "fructus", "opus", "satio"]),
    (15, ["produco", "foenum", "jumentum", "herba", "servitus", "homo"]),
    (16, ["educo", "panis", "terra", "vinum", "laetifico", "cor"]),
    (17, ["exhilaro", "facies", "oleum", "confirmo"]),
    (18, ["satio", "lignum", "campus", "cedrus", "Libanus", "planto"]),
    (19, ["passer", "nido", "herodius", "domus", "dux"]),
    (20, ["excelsus", "cervus", "petra", "refugium", "herinacius"]),
    (21, ["facio", "luna", "tempus", "sol", "cognosco", "occasus"]),
    (22, ["pono", "tenebrae", "nox", "bestia", "silva", "circumeo"]),
    (23, ["catulus", "leo", "rugio", "rapio", "quaero", "escam", "Deus"]),
    (24, ["orior", "sol", "congrego", "cubiculum", "colloco"]),
    (25, ["exeo", "homo", "opus", "labor", "vesper"]),
    (26, ["magnifico", "opus", "sapientia", "facio", "terra", "impleo", "possessio"])
  ]

  private let structuralThemes = [
    (
      "Praise → Creation",
      "From personal praise to cosmic creation",
      [
        "benedico", "anima", "dominus", "extendo", "caelum", "fundo", "terra", "facio",
        "angelus", "spiritus", "minister", "ignis"
      ],
      1,
      5,
      "The psalm opens with personal praise that expands to cosmic creation",
      "The psalmist begins with personal praise and quickly expands to cosmic creation, showing how individual worship connects to the grand scale of God's creative work. The first five verses establish the pattern of personal devotion leading to cosmic wonder."
    ),
    (
      "Stability → Boundaries",
      "God's stable creation with defined boundaries",
      [
        "stabilitas", "abyssus", "mons", "aqua", "terminus", "transgredo", "converto",
        "opero", "terra"
      ],
      6,
      10,
      "God's stable creation with defined boundaries for water and land",
      "These verses emphasize the stability of God's creation and the boundaries He has set. The abyss is clothed like a garment, and the mountains stand firm. God has set boundaries that water cannot pass, showing His orderly creation and the limits He has established for natural elements."
    ),
    (
      "Provision → Nourishment",
      "God's provision of water and food for all creatures",
      [
        "emitto", "fons", "convallis", "poto", "bestia", "ager", "rigo", "mons",
        "fructus", "opus", "satio", "produco", "foenum", "jumentum", "herba",
        "servitus", "homo", "educo", "panis", "terra", "vinum", "laetifico", "cor"
      ],
      11,
      16,
      "God's provision of water and food for all creatures",
      "These verses highlight God's provision of water and food for all creatures. He sends forth springs in the valleys, waters the hills, and brings forth grass for cattle and herbs for human service. This provision leads to nourishment and joy for all living things."
    ),
    (
      "Habitation → Seasons",
      "God's provision of habitats and the cycle of day and night",
      [
        "satio", "lignum", "campus", "cedrus", "Libanus", "passer", "nido", "herodius",
        "domus", "dux", "excelsus", "cervus", "petra", "refugium", "herinacius", "facio",
        "luna", "tempus", "sol", "cognosco", "occasus", "pono", "tenebrae", "nox",
        "bestia", "silva", "circumeo", "catulus", "leo", "rugio", "rapio", "quaero",
        "escam", "Deus", "orior", "congrego", "cubiculum", "colloco", "exeo", "homo",
        "opus", "labor", "vesper"
      ],
      17,
      25,
      "God's provision of habitats and the cycle of day and night",
      "These verses describe God's provision of habitats for various creatures and the cycle of day and night. The trees of the field are filled, and the cedars of Lebanon are planted. The moon is made for seasons, and the sun knows its going down. The cycle of day and night provides a rhythm for all living things, including humans who go forth to their work."
    ),
    (
      "Magnification → Wisdom",
      "The greatness of God's works and His wisdom in creation",
      [
        "magnifico", "opus", "sapientia", "facio", "terra", "impleo", "possessio"
      ],
      26,
      26,
      "The greatness of God's works and His wisdom in creation",
      "The psalm concludes with a magnification of God's works and His wisdom in creation. All things are made in wisdom, and the earth is filled with His riches. This final verse summarizes the psalmist's awe and admiration for God's creative work and providential care."
    )
  ]

  private let conceptualThemes = [
    (
      "Divine Magnificence",
      "God's greatness and glory in creation",
      ["magnifico", "dominus", "caelum", "terra", "angelus", "spiritus", "ignis"],
      ThemeCategory.divine,
      1 ... 26
    ),
    (
      "Cosmic Order",
      "God's establishment of order in creation",
      ["extendo", "tego", "pono", "nubes", "ascendo", "ambo", "penna", "ventus", "fundo", "stabilitas", "inclino", "abyssus", "vestimentum", "mons", "aqua", "sto", "increpatio", "fugo", "vox", "tonitrus", "formido", "ascendo", "campus", "descendo", "fundamentum", "terminus", "transgredo", "converto", "opero", "terra"],
      ThemeCategory.divine,
      3 ... 10
    ),
    (
      "Divine Providence",
      "God's care and provision for all creatures",
      ["emitto", "fons", "convallis", "poto", "bestia", "ager", "rigo", "mons", "fructus", "opus", "satio", "produco", "foenum", "jumentum", "herba", "servitus", "homo", "educo", "panis", "terra", "vinum", "laetifico", "cor"],
      ThemeCategory.divine,
      11 ... 16
    ),
    (
      "Habitat and Seasonal Cycles",
      "God's provision of habitats and the cycle of day and night",
      ["satio", "lignum", "campus", "cedrus", "Libanus", "passer", "nido", "herodius", "domus", "dux", "excelsus", "cervus", "petra", "refugium", "herinacius", "facio", "luna", "tempus", "sol", "cognosco", "occasus", "pono", "tenebrae", "nox", "bestia", "silva", "circumeo", "catulus", "leo", "rugio", "rapio", "quaero", "escam", "Deus", "orior", "congrego", "cubiculum", "colloco", "exeo", "homo", "opus", "labor", "vesper"],
      ThemeCategory.divine,
      17 ... 25
    ),
    (
      "Divine Wisdom",
      "God's wisdom in creation and providence",
      ["sapientia", "facio", "terra", "impleo", "possessio"],
      ThemeCategory.divine,
      26
    ),
    (
      "Personal Praise",
      "The psalmist's personal praise and worship of God",
      ["benedico", "anima", "dominus", "confessio", "decor", "induo", "lumina", "vestimentum"],
      ThemeCategory.virtue,
      1 ... 2
    ),
    (
      "Creation's Response",
      "The response of creation to God's commands",
      ["fugo", "formido", "ascendo", "descendo", "transgredo", "converto", "potabunt", "expectabunt", "habitabunt", "dabunt", "rugientes", "quaerant", "congregati", "collocabuntur", "exibit"],
      ThemeCategory.divine,
      8 ... 25
    ),
    (
      "Human Labor",
      "Human work and labor as part of God's creation",
      ["exeo", "homo", "opus", "labor", "vesper"],
      ThemeCategory.divine,
      25
    )
  ]

  // MARK: - Test Cases

  func testTotalVerses()
  {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 103 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 103 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testLineByLineKeyLemmas()
  {
    let utilities = PsalmTestUtilities.self
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas, psalmId: id,
      verbose: verbose
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
      filename: "output_psalm103_texts.json"
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

  func testStructuralThemes()
  {
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

  func testConceptualThemes()
  {
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

  func testCreationMetaphors()
  {
    let creationTerms = [
      ("extendo", ["Extendens"], "stretch out"),
      ("caelum", ["caelum"], "heaven"),
      ("tego", ["tegis"], "cover"),
      ("aqua", ["aquis"], "water"),
      ("pono", ["ponis"], "set"),
      ("nubes", ["nubem"], "cloud"),
      ("ambo", ["ambulas"], "walk"),
      ("penna", ["pennas"], "wing"),
      ("ventus", ["ventorum"], "wind"),
      ("facio", ["fecisti"], "make"),
      ("angelus", ["angelos"], "angels"),
      ("spiritus", ["spiritus"], "spirits"),
      ("minister", ["ministros"], "ministers"),
      ("ignis", ["ignem"], "fire"),
      ("fundo", ["fundasti"], "found"),
      ("terra", ["terram"], "earth"),
      ("stabilitas", ["stabilitatem"], "stability")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: creationTerms,
      verbose: verbose
    )
  }

  func testProvisionMetaphors()
  {
    let provisionTerms = [
      ("emitto", ["emittis"], "send forth"),
      ("fons", ["fontes"], "springs"),
      ("convallis", ["convallibus"], "vales"),
      ("poto", ["potabunt"], "drink"),
      ("bestia", ["bestiae"], "beasts"),
      ("ager", ["agri"], "field"),
      ("rigo", ["rigans"], "water"),
      ("mons", ["montes"], "hills"),
      ("fructus", ["fructu"], "fruit"),
      ("opus", ["operum"], "works"),
      ("satio", ["satiabitur"], "satisfy"),
      ("produco", ["producens"], "bring forth"),
      ("foenum", ["foenum"], "grass"),
      ("jumentum", ["jumentis"], "cattle"),
      ("herba", ["herbam"], "herb"),
      ("servitus", ["servituti"], "service"),
      ("homo", ["hominum"], "men"),
      ("educo", ["educas"], "bring out"),
      ("panis", ["panem"], "bread"),
      ("vinum", ["vinum"], "wine"),
      ("laetifico", ["laetificet"], "cheer"),
      ("cor", ["cor"], "heart")
    ]

    let utilities = PsalmTestUtilities.self
    utilities.testTerms(
      psalmText: text,
      psalmId: id,
      terms: provisionTerms,
      verbose: verbose
    )
  }

  func testSaveThemes()
  {
    let utilities = PsalmTestUtilities.self
    guard
      let jsonString = utilities.generateCompleteThemesJSONString(
        psalmNumber: id.number,
        category: id.category ?? "",
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
      filename: "output_psalm103_themes.json"
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
}


