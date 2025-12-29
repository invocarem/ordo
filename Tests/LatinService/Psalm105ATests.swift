@testable import LatinService
import XCTest

class Psalm105ATests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    // ------------------------------------------------------------------------
    // Psalm identity (Psalm 105, section A)
    // ------------------------------------------------------------------------
    private let id = PsalmIdentity(number: 105, category: "A")
    private let expectedVerseCount = 32   // number of verses in the supplied text

    // ------------------------------------------------------------------------
    // Latin text (Vulgate) – 32 verses
    // ------------------------------------------------------------------------
    private let text = [
        "Confitemini Domino quoniam bonus, quoniam in saeculum misericordia eius.",
        "Quis loquetur potentias Domini, auditas faciet omnes laudes eius?",
        "Beati qui custodiunt iudicium, et faciunt iustitiam in omni tempore.",
        "Memento nostri, Domine, in beneplacito populi tui; visita nos in salutari tuo,",
        /* 5 */ "ad videndum in bonitate electorum tuorum, ad laetandum in laetitia gentis tuae, ut lauderis cum haereditate tua.",
        "Peccavimus cum patribus nostris, injuste egimus, iniquitatem fecimus.",
        "Patres nostri in Aegypto non intellexerunt mirabilia tua; non fuerunt memores multitudinis misericordiae tuae.",
        "Et irritaverunt ascendentes in mare, mare Rubrum; et salvavit eos propter nomen suum,",
        "ut notam faceret potentiam suam. Et increpuit mare Rubrum, et exsiccatum est;",
        /* 10 */ "et deduxit eos in abyssis sicut in deserto. Et salvavit eos de manu odientium,",
        "et redemit eos de manu inimici. Et operuit aqua tribulantes eos;",
        "unus ex eis non remansit. Et crediderunt verbis eius, et laudaverunt laudem eius.",
        "Cito fecerunt, obliti sunt operum eius; non sustinuerunt consilium eius.",
        "Et concupierunt concupiscentiam in deserto, et tentaverunt Deum in inaquoso.",
        /* 15 */ "Et dedit eis petitionem ipsorum, et misit saturitatem in animas eorum.",
        "Et irritaverunt Moysen in castris, Aaron sanctum Domini.",
        "Aperta est terra, et deglutivit Dathan, et operuit super congregationem Abiron.",
        "Et ignis accensus est in synagoga eorum; flamma combussit peccatores.",
        "Et fecerunt vitulum in Horeb, et adoraverunt sculptile.",
        /* 20 */ "Et mutaverunt gloriam suam in similitudinem vituli comedentis foenum.",
        "Obliti sunt Deum qui salvavit eos, qui fecit magnalia in Aegypto,",
        "mirabilia in terra Cham, terribilia in mari Rubro.",
        "Et dixit ut disperderet eos, si non Moyses electus eius stetisset in confractione in conspectu eius,",
        "ut averteret iram eius ne disperderet eos. Et pro nihilo habuerunt terram desiderabilem,",
        /* 25 */ "non crediderunt verbo eius. Et murmuraverunt in tabernaculis suis,",
        "non exaudierunt vocem Domini. Et elevavit manum suam super eos ut prosterneret eos in deserto,",
        "et ut dejiceret semen eorum in nationibus, et dispergeret eos in terris.",
        "Et initiati sunt Beelphegor, et comederunt sacrificia mortuorum.",
        "Et irritaverunt eum in adinventionibus suis, et multiplicata est in eis ruina.",
        /* 30 */ "Et stetit Phinees, et placavit, et cessavit quassatio.",
        "Et reputatum est ei ad iustitiam in generationem et generationem usque in aeternum."
    ]



    // ------------------------------------------------------------------------
    // English translation – 32 verses
    // ------------------------------------------------------------------------
    
    private let englishText = [
        "Give glory to the Lord, for he is good: for his mercy endureth for ever.",
        "Who shall declare the powers of the Lord? who shall set forth all his praises?",
        "Blessed are they that keep judgment, and do justice at all times.",
        "Remember us, O Lord, in the favour of thy people: visit us with thy salvation,",
        /* 5 */ "That we may see the good of thy chosen, that we may rejoice in the joy of thy nation: that thou mayst be praised with thy inheritance.",
        "We have sinned with our fathers: we have acted unjustly, we have wrought iniquity.",
        "Our fathers understood not thy wonders in Egypt: they remembered not the multitude of thy mercies:",
        "And they provoked to wrath going up to the sea, the Red Sea; and he saved them for his own name’s sake,",
        "That he might make his power known: and he threatened the Red Sea and it was dried up:",
        /* 10 */ "And he led them through the depths, as in a wilderness. And he saved them from the hand of them that hated them,",
        "And he redeemed them from the hand of the enemy. And the water covered them that afflicted them:",
        "There was not one of them left. And they believed his words: and they sang his praises.",
        "They had quickly done, they forgot his works: and they waited not for his counsel.",
        "And they coveted their desire in the desert: and they tempted God in the place without water.",
        /* 15 */ "And he gave them their request: and sent fulness into their souls.",
        "And they provoked Moses in the camp: Aaron the holy one of the Lord.",
        "The earth opened and swallowed up Dathan: and covered the congregation of Abiron.",
        "And a fire was kindled in their congregation: the flame burned the wicked.",
        "They made also a calf in Horeb: and they adored the graven thing.",
        /* 20 */ "And they changed their glory into the likeness of a calf that eateth grass.",
        "They forgot God, who saved them, who had done great things in Egypt,",
        "Wondrous works in the land of Cham: terrible things in the Red Sea.",
        "And he said that he would destroy them: had not Moses his chosen stood before him in the breach,",
        "To turn away his wrath, lest he should destroy them. And they set at nought the desirable land,",
        /* 25 */ "They believed not his word, and they murmured in their tents:",
        "They hearkened not to the voice of the Lord. And he lifted up his hand over them to overthrow them in the desert,",
        "And to cast down their seed among the nations, and to scatter them in the countries.",
        "They also were initiated to Beelphegor: and ate the sacrifices of the dead.",
        "And they provoked him with their inventions: and destruction was multiplied among them.",
        /* 30 */ "Then Phinees stood up, and pacified him: and the slaughter ceased.",
        "And it was reputed to him unto justice, to generation and generation for evermore."
    ]
    
    // ------------------------------------------------------------------------
    // Lemmas – empty (no per‑verse lemma validation required for this file)
    // ------------------------------------------------------------------------
    private let lineKeyLemmas: [(Int, [String])] = [
    (1, ["confiteor", "dominus", "bonus", "misericordia", "saeculum"]),
    (2, ["quis", "loquor", "potentia", "dominus", "laus"]),
    (3, ["beatus", "custodio", "iudicium", "iustitia", "tempus"]),
    (4, ["memini", "dominus", "beneplacitum", "populus", "visito", "salus"]),
    (5, ["video", "bonitas", "electus", "laetor", "laetitia", "gentes", "laudo", "haereditas"]),
    (6, ["pecco", "pater", "iniquus", "iniquitas"]),
    (7, ["pater", "Aegyptus", "miraculum", "memoro", "multitudo", "misericordia"]),
    (8, ["irritor", "ascendo", "mare", "Rubrum", "salvo", "nomen"]),
    (9, ["facio", "nota", "potentia", "increpo", "mare", "Rubrum", "exsicco"]),
    (10, ["deduco", "abyssus", "desertum", "salvo", "manus", "odii"]),
    (11, ["redemo", "manus", "inimicus", "operio", "aqua", "tribulo"]),
    (12, ["unus", "remanere", "credo", "verbum", "laudo"]),
    (13, ["cito", "facio", "obliviscor", "opus", "sustinere", "consilium"]),
    (14, ["concupio", "desertum", "tempto", "Deus", "inaquosus"]),
    (15, ["do", "petitio", "mittō", "saturitas", "anima"]),
    (16, ["irritor", "Moses", "castra", "Aaron", "sanctus", "dominus"]),
    (17, ["aperio", "terra", "deglutio", "Dathan", "operio", "congregatio", "Abiron"]),
    (18, ["ignis", "accendo", "synagoga", "flamma", "comburo", "peccator"]),
    (19, ["facio", "vitulus", "Horeb", "adoro", "sculptile"]),
    (20, ["mutuo", "gloria", "similitudo", "vitulus", "comedō", "foenum"]),
    (21, ["obliviscor", "Deus", "salvo", "facere", "magnus", "Aegyptus"]),
    (22, ["miraculum", "terra", "Cham", "terribilis", "mare", "Rubrum"]),
    (23, ["dico", "disperdo", "Moses", "electus", "stare", "fractio", "conspectus"]),
    (24, ["averto", "ira", "disperdo"]),
    (25, ["non", "credere", "verbum", "murmurō", "tabernaculum"]),
    (26, ["non", "exaudio", "vox", "dominus", "elevo", "manus", "desertum"]),
    (27, ["deicio", "semen", "natio", "dispergo", "terra"]),
    (28, ["initio", "Beelphegor", "edo", "sacrificium", "mortuus"]),
    (29, ["irritor", "invention", "multiplico", "ruina"]),
    (30, ["sto", "Phinees", "placo", "cesso", "quassatio"]),
    (31, ["reputo", "iustitia", "generatio", "aeternum"])
]
    // ------------------------------------------------------------------------
    // Structural themes – none defined (empty array)
    // ------------------------------------------------------------------------
    private let structuralThemes = [
    (
      "Separation → Delight",
      "From avoidance of the wicked to joy in God's law",
      ["sto", "abeo", "sedeo", "lex", "meditor"],
      1,
      2,
      "",
      ""
    )
    ]
    // ------------------------------------------------------------------------
    // Conceptual themes – none defined (empty array)
    // ------------------------------------------------------------------------
    private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = []

    // ------------------------------------------------------------------------
    // MARK: - Tests
    // ------------------------------------------------------------------------
    func testTotalVerses() {
        XCTAssertEqual(text.count, expectedVerseCount,
                       "Psalm 105 A should have \(expectedVerseCount) verses")
        XCTAssertEqual(englishText.count, expectedVerseCount,
                       "Psalm 105 A English text should have \(expectedVerseCount) verses")

        // Verify orthography of the Latin text (classical spelling)
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(normalized, text,
                       "Normalized Latin text should match expected classical forms")
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
        // No structural themes – just ensure the utilities handle an empty list gracefully
        utilities.testStructuralThemes(
            psalmText: text,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        // No conceptual themes – just ensure the utilities handle an empty list gracefully
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
            filename: "output_psalm105a_themes.json"
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
            filename: "output_psalm105a_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}