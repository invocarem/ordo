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
        "Peccavimus cum patribus nostris, iniuste egimus, iniquitatem fecimus.",
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
        "Et reputatum est ei ad iustitiam in generationem et generationem usque in sempiternum."
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
    (5, ["video", "bonitas", "electus", "laetor", "laetitia", "gens", "laudo", "haereditas"]),
    (6, ["pecco",  "pater","iniquitas", "facio", "ago",  "iniustus"]),
    (7, ["pater", "Aegyptus", "mirabile", "memoro", "multitudo", "misericordia"]),
    (8, ["irrito", "ascendo", "mare", "Rubrum", "salvo", "nomen"]),
    (9, ["facio", "nota", "potentia", "increpo", "mare", "Rubrum", "exsicco"]),
    (10, ["deduco", "abyssus", "desertum", "salvo", "manus", "odi"]),
    (11, ["redimo", "manus", "inimicus", "operio", "aqua", "tribulo"]),
    (12, ["unus", "remaneo", "credo", "verbum", "laudo"]),
    (13, ["cito", "facio", "obliviscor", "opus", "sustineo", "consilium"]),
    (14, ["concupio", "concupiscentia", "desertum", "tento", "inaquosus"]),
    (15, ["do", "petitio", "mitto", "saturitas", "anima"]),
    (16, ["irrito", "Moses", "castra", "Aaron", "sanctus", "dominus"]),
    (17, ["aperio", "terra", "deglutio", "Dathan", "operio", "congregatio", "Abiron"]),
    (18, ["ignis", "accendo", "synagoga", "flamma", "comburo", "peccator"]),
    (19, ["facio", "vitulus", "Horeb", "adoro", "sculptile"]),
    (20, ["mutuo", "gloria", "similitudo", "vitulus", "comedō", "foenum"]),
    (21, ["obliviscor", "Deus", "salvo", "facere", "magnus", "Aegyptus"]),
    (22, ["miraculum", "terra", "Cham", "terribilis", "mare", "Rubrum"]),
    (23, ["dico", "disperdo", "Moses", "electus", "stare", "fractio", "conspectus"]),
    (24, ["averto", "ira", "is", "dispero", "nihil", "habeo", "terra", "desiderabilis"]),
    (25, ["non", "credere", "verbum", "murmurō", "tabernaculum"]),
    (26, ["non", "exaudio", "vox", "dominus", "elevo", "manus", "desertum"]),
    (27, ["deicio", "semen", "natio", "dispergo", "terra"]),
    (28, ["initio", "Beelphegor", "edo", "sacrificium", "mortuus"]),
    (29, ["irrito", "adinventio", "multiplico", "ruina"]),
    (30, ["sto", "Phinees", "placo", "cesso", "quassatio"]),
    (31, ["reputo", "iustitia", "generatio", "sempiternus"])
]
    // ------------------------------------------------------------------------
    // Structural themes – none defined (empty array)
    // ------------------------------------------------------------------------
    private let structuralThemes = [
        (
            "Praise → Power",
            "From giving thanks for the Lord’s goodness to declaring His mighty deeds",
            ["confiteor", "dominus", "bonus", "potentia", "laus"],
            1,
            2,
            "Verse 1‑2 celebrate gratitude for God’s perpetual goodness and mercy, then move to proclaiming His sovereign power over creation.",
            "Augustine reads this as an affirmation of God’s immutable goodness (De Deum) and the psalmist’s proper worship—praise that arises from recognizing the unchanging nature of divine mercy."
        ),
        (
            "Justice → Remembrance",
            "Keeping judgment and remembering God’s favor in the people’s salvation",
            ["beatus", "custodio", "iudicium", "iustitia", "memini", "visito", "salus"],
            3,
            4,
            "Verses 3‑4 link the blessed state of those who uphold justice with a communal prayer that God remembers and saves His people.",
            "In Augustine’s exposition, justice reflects the love‑of‑neighbor rooted in divine law, while the plea for remembrance underscores the grace‑filled relationship between God and the covenant community."
        ),

        // --- New structural themes (5‑32) ---
        // 5‑6: Chosen Goodness → Confession
        (
            "Chosen Goodness → Confession",
            "Seeing the goodness of God’s elect and rejoicing, then confessing sin with the fathers",
            ["video", "bonitas", "electus", "laetor", "laetitia", "gens",
            "laudo", "haereditas", "pecco", "pater", "iniquus", "iniquitas"],
            5,
            6,
            "Verses 5‑6 contrast the blessed sight of God’s chosen people with the confession of ancestral sin, setting the stage for divine rescue.",
            "Augustine reads this as a movement from the vision of divine grace to the humility required for redemption."
        ),
        // 7‑8: Egyptian Blindness → Red Sea Salvation
        (
            "Egyptian Blindness → Red Sea Salvation",
            "Fathers in Egypt ignore miracles; they provoke the Red Sea, which God saves for His name",
            ["pater", "Aegyptus", "miraculum", "memoro", "multitudo", "misericordia",
            "irritor", "ascendo", "mare", "Rubrum", "salvo", "nomen"],
            7,
            8,
            "Verses 7‑8 depict the patriarchs’ failure to recall God’s wonders, leading to provocation of the Red Sea and divine rescue for His own sake.",
            "Augustine sees the Red Sea as a symbol of chaotic nature tamed by divine providence."
        ),
        // 9‑10: Power Manifest → Deliverance
        (
            "Power Manifest → Deliverance",
            "God makes His power known, dries the Red Sea, leads through the abyss, saves from enemies",
            ["facio", "nota", "potentia", "increpo", "mare", "Rubrum", "exsicco",
            "deduco", "abyssus", "desertum", "salvo", "manus", "odii"],
            9,
            10,
            "Verses 9‑10 show God’s demonstration of power (drying the sea) and guiding the people through perilous depths to safety.",
            "Augustine interprets the abyss as a trial that reveals reliance on divine guidance."
        ),
        // 11‑12: Redemption → Faith & Praise
        (
            "Redemption → Faith & Praise",
            "God redeems from enemies, water covers oppressors; one remains, they believe and sing praise",
            ["redemo", "manus", "inimicus", "operio", "aqua", "tribulo",
            "unus", "remanere", "credo", "verbum", "laudo"],
            11,
            12,
            "Verses 11‑12 transition from physical deliverance to spiritual belief, culminating in communal praise.",
            "Augustine links belief after deliverance to the proper response of worship."
        ),
        // 13‑14: Forgetfulness → Testing
        (
            "Forgetfulness → Testing",
            "They act hastily, forget works, do not wait for counsel; they covet in the desert, test God without water",
            ["cito", "facio", "obliviscor", "opus", "sustinere", "consilium",
            "concupio", "desertum", "tempto", "Deus", "inaquosus"],
            13,
            14,
            "Verses 13‑14 highlight human impatience and the temptation to test God in barren places.",
            "Augustine warns that testing God reflects a lack of trust in divine providence."
        ),
        // 15‑16: Provision → Provocation
        (
            "Provision → Provocation",
            "God grants requests, fills souls; they provoke Moses and Aaron in the camp",
            ["do", "petitio", "mittō", "saturitas", "anima",
            "irritor", "Moses", "castra", "Aaron", "sanctus", "dominus"],
            15,
            16,
            "Verses 15‑16 contrast divine provision with the people's provocation of Moses, foreshadowing judgment.",
            "Augustine reads this as a reminder that gratitude must accompany obedience."
        ),
        // 17‑18: Earth & Fire Judgments
        (
            "Earth & Fire Judgments",
            "The earth swallows Dathan, covers Abiron; fire in the synagogue burns sinners",
            ["aperio", "terra", "deglutio", "Dathan", "operio", "congregatio", "Abiron",
            "ignis", "accendo", "synagoga", "flamma", "comburo", "peccator"],
            17,
            18,
            "Verses 17‑18 depict natural and supernatural judgments against the rebels.",
            "Augustine sees the earth and fire as instruments of divine reproof."
        ),
        // 19‑20: Idolatry → Corrupted Glory
        (
            "Idolatry → Corrupted Glory",
            "They make a calf at Horeb, worship the graven image; they change glory to a calf eating grass",
            ["facio", "vitulus", "Horeb", "adoro", "sculptile",
            "mutuo", "gloria", "similitudo", "vitulus", "comedō", "foenum"],
            19,
            20,
            "Verses 19‑20 show the shift from worship of God to a false idol, degrading divine glory.",
            "Augustine interprets the calf as a symbol of misplaced devotion."
        ),
        // 21‑22: Forgetfulness → Marvels Abroad
        (
            "Forgetfulness → Marvels Abroad",
            "They forget God who saved them in Egypt; marvels in Cham, terrors in the Red Sea",
            ["obliviscor", "Deus", "salvo", "facere", "magnus", "Aegyptus",
            "miraculum", "terra", "Cham", "terribilis", "mare", "Rubrum"],
            21,
            22,
            "Verses 21‑22 contrast the Israelites’ ingratitude with recollection of God’s deeds in distant lands.",
            "Augustine stresses remembrance of past miracles as a safeguard against apostasy."
        ),
        // 23‑24: Moses’ Intercession → Rejected Land
        (
            "Moses’ Intercession → Rejected Land",
            "God says He will disperse them unless Moses stands; He averts wrath, they consider the land worthless",
            ["dico", "disperdo", "Moses", "electus", "stare", "fractio", "conspectus",
            "averto", "ira", "is", "dispero", "nihil", "habeo", "terra", "desiderabilis"],
            23,
            24,
            "Verses 23‑24 emphasize Moses’ role as intercessor and the people’s dismissal of the promised land.",
            "Augustine reads Moses as the archetype of faithful advocacy."
        ),
        // 25‑26: Murmur & Divine Judgment
        (
            "Murmur & Divine Judgment",
            "They do not believe, murmur in tents, ignore the Lord’s voice; He lifts His hand to overthrow them",
            ["non", "credere", "verbum", "murmurō", "tabernaculum",
            "non", "exaudio", "vox", "dominus", "elevo", "manus", "desertum"],
            25,
            26,
            "Verses 25‑26 portray the people’s rebellion and God’s readiness to act against them.",
            "Augustine sees the raised hand as a warning of impending divine correction."
        ),
        // 27‑28: Scattering → Beelphegor Initiation
        (
            "Scattering → Beelphegor Initiation",
            "He casts down seed among nations, disperses them; they are initiated to Beelphegor, eat dead sacrifices",
            ["deicio", "semen", "natio", "dispergo", "Beelphegor", "edo", "sacrificium"],
            27,
            28,
            "Verses 27‑28 describe the scattering of the seed and the disturbing cult of Beelphegor.",
            "Augustine reads Beelphegor as a figure of false worship after divine judgment."
        ),
        // 29‑30: Invention‑Provoked Ruin → Phinees Pacifies
        (
            "Invention‑Provoked Ruin → Phinees Pacifies",
            "They provoke Him with inventions; ruin multiplies. Phinees stands, pacifies, slaughter ceases.",
            ["irrito", "adinventio", "multiplico", "ruina", "Phinees", "placo", "cesso", "quassatio"],
            29,
            30,
            "Verses 29‑30 move from chaos caused by human invention to the calming presence of Phinees.",
            "Augustine affirms that divine peace follows after turmoil."
        ),
        // 31‑32: Eternal Justice
        (
            "Eternal Justice",
            "Justice is counted to him forever.",
            ["reputo", "iustitia", "generatio", "sempiternus"],
            31,
            31,
            "Verses 31‑32 close the psalm with the promise of perpetual justice.",
            "Augustine affirms that divine justice endures beyond generations."
        )
    ];

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