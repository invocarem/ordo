// Tests/LatinService/Psalm103Tests.swift

import XCTest

@testable import LatinService

class Psalm103ATests: XCTestCase
{
  private let verbose = true

  // MARK: - Test Data

  let id = PsalmIdentity(number: 103, category: "A")
  private let expectedVerseCount = 25

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

    "Qui emittis fontes in convallibus; inter medium montium pertransibunt aquae.",
    "Potabunt omnes bestiae agri; expectabunt onagri in siti sua.",
    "Super ea volucres caeli habitabunt, de medio petrarum dabunt voces.",
    "Rigans montes de superioribus suis, de fructu operum tuorum satiabitur terra.",
    "Producens foenum iumentis, et herbam servituti hominum,",

    "ut educas panem de terra, et vinum laetificet cor hominis.",
    "Ut exhilaret faciem in oleo, et panis cor hominis confirmet.",
    "Saturabuntur ligna campi, et cedri Libani quas plantavit. Illic passeres nidificabunt; ",
    "herodii domus dux est eorum. Montes excelsi cervis, petra refugium herinaciis.",
    "Fecit lunam in tempora; sol cognovit occasum suum.",

    "Posuisti tenebras, et facta est nox; in ipsa pertransibunt omnes bestiae silvae.",
    "Catuli leonum rugientes ut rapiant, et quaerant a Deo escam sibi.",
    "Ortus est sol, et congregati sunt, et in cubilibus suis collocabuntur.",
    "Exibit homo ad opus suum, et ad operationem suum usque ad vesperum.",
    "Quam magnificata sunt opera tua, Domine! omnia in sapientia fecisti; impleta est terra possessione tua."
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
    "The trees of the field shall be filled, and the cedars of Libanus which he hath planted: There the sparrows shall make their nests. ",
    "The highest of them is the house of the heron. The high hills are a refuge for the harts, the rock for the hedgehogs.",
    "He hath made the moon for seasons: the sun knoweth his going down.",

    "Thou hast appointed darkness, and it is night: in it shall all the beasts of the woods go about:",
    "The young lions roaring after their prey, and seeking their meat from God.",
    "The sun ariseth, and they are gathered together: and they shall lie down in their dens.",
    "Man shall go forth to his work, and to his labour until the evening.",
    "How great are thy works, O Lord! thou hast made all things in wisdom: the earth is filled with thy riches."
  ]

  private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["benedico", "anima", "dominus", "magnifico", "vehementer"]),
    (2, ["confessio", "decor", "induo", "lumen", "vestimentum"]),
    (3, ["extendo", "caelum", "pellis", "tego", "aqua", "superus"]),
    (4, ["pono", "nubes", "ascendo", "ambulo", "penna", "ventus"]),
    (5, ["facio", "angelus", "spiritus", "minister", "ignis", "uro"]),
    (6, ["fundo", "terra", "stabilitas", "inclino"]),
    (7, ["abyssus", "vestimentum", "mons", "aqua", "sto"]),
    (8, ["increpatio", "fugio", "vox", "tonitrus", "formido"]),
    (9, ["ascendo", "mons", "campus", "descendo", "fundo"]),
    (10, ["terminus", "pono", "transgredior", "converto", "operio", "terra"]),
    (11, ["emitto", "fons", "convallis", "medium", "mons", "pertranseo", "aqua"]),
    (12, ["poto", "bestia", "ager", "expecto", "onager", "sitio"]),
    (13, ["volucris", "caelum", "habito", "petra", "do", "vox"]),
    (14, ["rigo", "mons", "superus", "fructus", "opus", "satio", "terra"]),
    (15, ["produco", "foenum", "iumentum", "herba", "servitus", "homo"]),
    (16, ["educo", "panis", "terra", "vinum", "laetifico", "cor"]),
    (17, ["exhilaro", "facies", "oleum", "confirmo"]),
    (18, ["saturo", "lignum", "campus", "cedrus", "Libanus", "planto", "passer", "nidifico"]),
    (19, ["herodius", "domus", "dux", "mons", "excelsus", "cervus", "petra", "refugium", "herinacius"]),
    (20, ["facio", "luna", "tempus", "sol", "cognosco", "occasus"]),
    (21, ["pono", "tenebrae", "nox", "pertranseo", "bestia", "silva"]),
    (22, ["catulus", "leo", "rugio", "rapio", "quaero", "esca", "Deus"]),
    (23, ["orior", "sol", "congrego", "cubile", "colloco"]),
    (24, ["exeo", "homo", "opus", "operatio", "vesper"]),
    (25, ["magnifico", "opus", "dominus", "omnis", "sapientia", "facio", "impleo", "terra", "possessio"])
  ]

  private let structuralThemes = [
    (
      "Praise → Transformation",
      "Personal praise leading to divine transformation",
      ["benedico", "anima", "dominus", "confessio", "decor", "induo", "lumen"],
      1,
      2,
      "The psalmist begins with personal blessing and is transformed by being clothed in divine light.",
      "Augustine explains that the soul's praise (benedico) is the first step toward being clothed in divine light (induo lumen), reflecting the transformation of the believer."
    ),
    (
      "Heavenly Extension → Cloudy Journey",
      "Stretching heavens and walking on clouds as divine movement",
      ["extendo", "caelum", "tego", "aqua", "pono", "nubes", "ambulo"],
      3,
      4,
      "God stretches out the heavens like a pavilion and walks upon the wings of the winds.",
      "Augustine interprets the stretching of the heavens (extendo caelum) as God's orderly governance, with clouds (nubes) serving as His chariot."
    ),
    (
      "Angelic Spirit → Earthly Foundation",
      "Angels as spirits and earth founded on stability",
      ["facio", "angelus", "spiritus", "minister", "ignis", "fundo", "terra"],
      5,
      6,
      "God makes angels into spirits and ministers of fire, while founding the earth upon its own bases.",
      "Augustine notes that angels (angelus) are spirits (spiritus) ministering with fire, while the earth (terra) is founded on divine stability."
    ),
    (
      "Abyss Garment → Thunder Fear",
      "Deep as clothing and thunder causing fear",
      ["abyssus", "vestimentum", "mons", "aqua", "increpatio", "fugio", "tonitrus"],
      7,
      8,
      "The abyss is like a garment covering the earth, while creatures flee at God's rebuke and thunder.",
      "Augustine explains that the deep (abyssus) covered like a garment signifies God's concealment, while the thunder (tonitrus) rebukes the wicked."
    ),
    (
      "Mountain Ascent → Plain Descent",
      "Mountains ascending and plains descending to their place",
      ["ascendo", "mons", "campus", "descendo", "fundo", "terminus"],
      9,
      10,
      "The mountains ascend and the plains descend into the place God has founded for them.",
      "Augustine comments that the mountains (mons) and plains (campus) are ordered, with boundaries set by God restricting the waters."
    ),
    (
      "Spring Emission → Beast Drinking",
      "Springs sent forth in valleys and beasts drinking water",
      ["emitto", "fons", "convallis", "poto", "bestia", "aqua"],
      11,
      12,
      "God sends forth springs in the vales, and all beasts of the field drink from them.",
      "Augustine remarks that the springs (fons) sent forth to valleys satisfy the thirst of beasts, illustrating God's care."
    ),
    (
      "Bird Habitation → Hill Watering",
      "Birds dwelling in heavens and hills watered by God",
      ["volucris", "caelum", "habito", "rigo", "mons", "fructus"],
      13,
      14,
      "The birds of the air dwell over creation, while God waters the hills to bring forth fruit.",
      "Augustine notes that the birds (volucris) dwell in the heavens, while the hills (mons) are watered to bring forth fruit."
    ),
    (
      "Grass Production → Human Nourishment",
      "Grass for cattle and bread/wine for human sustenance",
      ["produco", "foenum", "iumentum", "educo", "panis", "vinum"],
      15,
      16,
      "God brings forth grass for cattle and provides bread and wine to nourish humanity.",
      "Augustine explains that the production (produco) of grass and bread nourishes both body and spirit, while wine cheers the heart."
    ),
    (
      "Tree Saturation → Bird Nesting",
      "Trees filled with fruit and birds making their nests",
      ["saturo", "lignum", "cedrus", "passer", "nidifico"],
      17,
      18,
      "The trees of the field are filled, and sparrows make their nests among them.",
      "Augustine views the flourishing trees (lignum) and cedars as providing shelter for souls, just as birds find nests."
    ),
    (
      "High Mountain → Rock Refuge",
      "High mountains and rocks as refuges for creatures",
      ["mons", "excelsus", "cervus", "petra", "refugium"],
      19,
      20,
      "The high hills are a refuge for deer, while rocks shelter hedgehogs.",
      "Augustine notes that the mountains provide refuge (refugium) for deer, while the rock shelters hedgehogs."
    ),
    (
      "Celestial Cycles",
      "Moon, sun, and darkness governing time",
      ["facio", "luna", "tempus", "sol", "cognosco", "occasus"],
      19,
      20,
      "God made the moon for seasons and the sun knows its going down.",
      "Augustine reflects on the moon (luna) and sun (sol) as markers of divine order, with darkness allowing beasts to move."
    ),
    (
      "Lion Roaring → God Seeking",
      "Young lions roaring and seeking meat from God",
      ["catulus", "leo", "rugio", "rapio", "quaero", "Deus"],
      21,
      22,
      "The young lions roar after prey, seeking their food from God.",
      "Augustine sees the roaring lions (rugio) as a trial, yet the faithful find safety through God's providence."
    ),
    (
      "Sun Rising → Human Labor",
      "Sun arising and humans going forth to work",
      ["orior", "sol", "exeo", "homo", "opus", "vesper"],
      23,
      25,
      "The sun rises, and man goes forth to his work until evening.",
      "Augustine concludes that human labor under God's wisdom culminates in the magnification of divine works."
    )
  ]

  private let conceptualThemes = [
    (
      "Cosmic Order",
      "God's establishment of order in creation",
      ["extendo", "caelum", "tego", "aqua", "pono", "nubes", "ascendo", "penna", "ventus", "fundo", "stabilitas", "terminus"],
      ThemeCategory.divine,
      3 ... 10
    ),
    (
      "Divine Providence",
      "God's care and provision for all creatures",
      ["emitto", "fons", "convallis", "poto", "bestia", "ager", "rigo", "mons", "fructus", "produco", "foenum", "iumentum"],
      ThemeCategory.divine,
      11 ... 16
    ),
    (
      "Habitat and Seasonal Cycles",
      "God's provision of habitats and the cycle of day and night",
      ["saturo", "lignum", "cedrus", "passer", "nidifico", "herodius", "domus", "excelsus", "cervus", "petra", "refugium", "herinacius", "luna", "tempus", "sol", "occasus"],
      ThemeCategory.divine,
      17 ... 25
    ),
    (
      "Divine Wisdom",
      "God's wisdom in creation and providence",
      ["sapientia", "facio", "terra", "impleo", "possessio"],
      ThemeCategory.divine,
      25 ... 25
    ),
    (
      "Personal Praise",
      "The psalmist's personal praise and worship of God",
      ["benedico", "anima", "dominus", "confessio", "decor", "induo", "lumen"],
      ThemeCategory.virtue,
      1 ... 2
    ),
    (
      "Creation's Response",
      "The response of creation to God's commands",
      ["fugio", "formido", "ascendo", "descendo", "poto", "expecto", "habito", "do", "rugio", "quaero", "congrego", "colloco"],
      ThemeCategory.divine,
      8 ... 25
    ),
    (
      "Human Labor",
      "Human work and labor as part of God's creation",
      ["exeo", "homo", "opus", "operatio", "vesper"],
      ThemeCategory.divine,
      23 ... 24
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
      ("extendo", ["extendens"], "stretch"),
      ("caelum", ["caelum"], "heaven"),
      ("tego", ["tegis"], "cover"),
      ("aqua", ["aquis"], "water"),
      ("pono", ["ponis"], "set"),
      ("nubes", ["nubem"], "cloud"),
      ("ambulo", ["ambulas"], "walk"),
      ("penna", ["pennas"], "wing"),
      ("ventus", ["ventorum"], "wind"),
      ("facio", ["fecisti"], "make"),
      ("angelus", ["angelos"], "angel"),
      ("spiritus", ["spiritus"], "spirit"),
      ("minister", ["ministros"], "servant"),
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
      ("emitto", ["emittis"], "send"),
      ("fons", ["fontes"], "spring"),
      ("convallis", ["convallibus"], "valley"),
      ("poto", ["potabunt"], "drink"),
      ("bestia", ["bestiae"], "beast"),
      ("ager", ["agri"], "field"),
      ("rigo", ["rigans"], "water"),
      ("mons", ["montes"], "hill"),
      ("fructus", ["fructu"], "fruit"),
      ("opus", ["operum"], "work"),
      ("satio", ["satiabitur"], "satisfy"),
      ("produco", ["producens"], "produce"),
      ("foenum", ["foenum"], "grass"),
      ("iumentum", ["iumentis"], "beast"),
      ("herba", ["herbam"], "herb"),
      ("servitus", ["servituti"], "slavery"),
      ("homo", ["hominum"], "man"),
      ("educo", ["educas"], "lead"),
      ("panis", ["panem"], "bread"),
      ("vinum", ["vinum"], "wine"),
      ("laetifico", ["laetificet"], "joy"),
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
