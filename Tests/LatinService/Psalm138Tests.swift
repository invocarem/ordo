import XCTest

@testable import LatinService

class Psalm138ATests: XCTestCase {
    private let verbose = true

    // MARK: - Test Data (Psalm 138A)
    let id = PsalmIdentity(number: 138, category: "A")
    private let expectedVerseCount = 9

    private let text = [
        "Domine, probasti me, et cognovisti me: tu cognovisti sessionem meam, et resurrectionem meam.",
        "Intellexisti cogitationes meas de longe: semitam meam, et funiculum meum investigasti.",
        "Et omnes vias meas praevidisti: quia non est sermo in lingua mea.",
        "Ecce, Domine, tu cognovisti omnia, novissima et antiqua: tu formasti me, et posuisti super me manum tuam.",
        "Mirabilis facta est scientia tua ex me: confortata est, et non potero ad eam.",
        "Quo ibo a spiritu tuo? et quo a facie tua fugiam?",
        "Si ascendero in caelum, tu illic es: si descendero in infernum, ades.",
        "Si sumpsero pennas meas diluculo, et habitavero in extremis maris:",
        "Etenim illic manus tua deducet me: et tenebit me dextera tua.",
    ]

    private let englishText = [
        "Lord, thou hast proved me, and known me: thou hast known my sitting down, and my rising up.",
        "Thou hast understood my thoughts afar off: my path and my line thou hast searched out.",
        "And thou hast foreseen all my ways: for there is no speech in my tongue.",
        "Behold, O Lord, thou hast known all things, the last and those of old: thou hast formed me, and hast laid thy hand upon me.",
        "Thy knowledge is become wonderful to me: it is high, and I cannot reach to it.",
        "Whither shall I go from thy spirit? or whither shall I flee from thy face?",
        "If I ascend into heaven, thou art there: if I descend into hell, thou art present.",
        "If I take my wings early in the morning, and dwell in the uttermost parts of the sea:",
        "Even there also shall thy hand lead me: and thy right hand shall hold me.",
    ]

    private let lineKeyLemmas = [
        (1, ["dominus", "probo", "cognosco", "sessio", "resurrectio"]),
        (2, ["intellego", "cogitatio", "longus", "semita", "funiculus", "investigo"]),
        (3, ["via", "praevideo", "sermo", "lingua"]),
        (
            4,
            [
                "ecce", "dominus", "cognosco", "omnis", "novissimus", "antiquus", "formo", "pono",
                "manus",
            ]
        ),
        (5, ["mirabilis", "scientia", "conforto", "possum"]),
        (6, ["eo", "spiritus", "facies", "fugio"]),
        (7, ["ascendo", "caelum", "descendo", "infernus", "adsum"]),
        (8, ["sumo", "penna", "diluculum", "habito", "extremus", "mare"]),
        (9, ["etenim", "manus", "deduco", "teneo", "dexter"]),
    ]

    private let structuralThemes = [
        (
            "Testing → Understanding",
            "God's complete knowledge of the soul through testing and intimate understanding",
            ["probo", "cognosco", "intellego", "cogitatio", "investigo"],
            1,
            2,
            "The Lord has tested and known the psalmist completely, understanding his thoughts from afar and searching out his path and line with thorough investigation.",
            "Augustine sees this as God's omniscient knowledge of the soul's every movement. The 'probasti me' represents God's testing that reveals the heart's true state, while 'cognovisti' shows His intimate knowledge of our sitting and rising, our daily life and resurrection."
        ),
        (
            "Foresight → Formation",
            "Divine foreknowledge leading to purposeful creation and divine touch",
            ["praevideo", "via", "sermo", "lingua", "formo", "pono", "manus"],
            3,
            4,
            "God has foreseen all ways before there is speech on the tongue, knowing all things from the beginning to the end, and has formed the psalmist with His own hand placed upon him.",
            "For Augustine, this reveals God's eternal knowledge that precedes all human thought and speech. The 'formasti me' points to God as the divine potter who shapes the soul, while 'posuisti super me manum tuam' signifies both creation and blessing, the divine touch that consecrates."
        ),
        (
            "Wonder → Inescapability",
            "The overwhelming nature of divine knowledge making escape impossible",
            ["mirabilis", "scientia", "conforto", "possum", "spiritus", "facies", "fugio"],
            5,
            6,
            "God's knowledge has become wonderful and strengthened beyond the psalmist's ability to comprehend, raising the question of where one might flee from His Spirit or face.",
            "Augustine interprets this as the soul's recognition of God's inescapable presence. The 'mirabilis scientia' represents the overwhelming nature of divine wisdom, while the rhetorical questions about fleeing acknowledge that God's Spirit and countenance are everywhere present."
        ),
        (
            "Omnipresence → Guidance",
            "God's presence in all places leading to divine guidance and protection",
            [
                "ascendo", "caelum", "descendo", "infernus", "adsum", "penna", "diluculum", "mare",
                "manus", "deduco", "teneo", "dexter",
            ],
            7,
            9,
            "Whether ascending to heaven or descending to hell, God is present; even with wings of dawn to the uttermost parts of the sea, His hand will lead and His right hand will hold.",
            "Augustine sees this as the ultimate expression of divine omnipresence and providence. The 'ascendero in caelum' and 'descendero in infernum' encompass all possible locations, while the 'pennae diluculo' suggests the swiftest possible movement. Yet even there, God's guiding hand and protective right hand are present, showing that no place or circumstance is beyond His care."
        ),
    ]

    private let conceptualThemes = [
        (
            "Perfect Knowledge",
            "God's complete and perfect knowledge of all things",
            ["cognosco", "intellego", "praevideo", "scientia"],
            ThemeCategory.divine,
            1...6
        ),
        (
            "Life Molding",
            "God as creator and shaper of human life",
            ["formo", "pono"],  //"possideo", "suscipio"], psalm138b verse 3
            ThemeCategory.divine,
            1...4
        ),
        (
            "Omnipresence",
            "God's presence in all places and circumstances",
            ["ascendo", "caelum", "descendo", "infernus", "adsum", "mare", "extremus"],
            ThemeCategory.divine,
            7...9
        ),
        (
            "Divine Guidance",
            "God's active leading and protection of the soul",
            ["deduco", "teneo", "dexter", "investigo"],
            ThemeCategory.divine,
            1...9
        ),
        (
            "Human Limitation",
            "Recognition of human inability to comprehend or escape God",
            ["possum", "fugio", "mirabilis", "conforto"],
            ThemeCategory.virtue,
            5...6
        ),
        (
            "Divine Testing",
            "God's examination and proving of the human heart",
            ["probo", "cognosco", "intellego", "investigo"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Eternal Knowledge",
            "God's knowledge that transcends time and space",
            ["novissimus", "antiquus", "omnis", "praevideo"],
            ThemeCategory.divine,
            3...4
        ),
        (
            "Spiritual Journey",
            "The soul's movement through different states and locations",
            ["ascendo", "descendo", "eo", "habito", "diluculum"],
            ThemeCategory.virtue,
            6...8
        ),
    ]

    // MARK: - Test Methods

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 138A should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 138A English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            text,
            "Normalized Latin text should match expected classical forms"
        )
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
            filename: "output_psalm138A_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }

    func testSavePsalm138AThemes() {
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
            filename: "output_psalm138A_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }

}

class Psalm138BTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    // MARK: - Test Data (Psalm 138B)
    let id = PsalmIdentity(number: 138, category: "B")
    let psalm138B = [
        "Et dixi: Forsitan tenebrae conculcabunt me: et nox illuminatio mea in deliciis meis.",
        "Quia tenebrae non obscurabuntur a te, et nox sicut dies illuminabitur: sicut tenebrae ejus, ita et lumen ejus.",
        "Quia tu possedisti renes meos: suscepisti me de utero matris meae.",
        "Confitebor tibi, quia terribiliter magnificatus es: mirabilia opera tua, et anima mea cognoscit nimis.",
        "Non est occultatum os meum a te, quod fecisti in occulto: et substantia mea in inferioribus terrae.",
        "Imperfectum meum viderunt oculi tui, et in libro tuo omnia scribentur: dies formabuntur, et nemo in eis.",
        "Mihi autem nimis honorati sunt amici tui, Deus: nimis confortatus est principatus eorum.",
        "Dinumerabo eos, et super arenam multiplicabuntur: exsurrexi, et adhuc sum tecum.",
        "Si occideris, Deus, peccatores: viri sanguinum, declinate a me.",
        "Quia dicitis in cogitatione: Accipient in vanitate civitates tuas.",
        "Nonne qui oderunt te, Domine, oderam? et super inimicos tuos tabescebam?",
        "Perfecto odio oderam illos: inimici facti sunt mihi.",
        "Proba me, Deus, et scito cor meum: interroga me, et cognosce semitas meas.",
        "Et vide si via iniquitatis in me est: et deduc me in via aeterna.",
    ]

    // MARK: - Grouped Line Tests

    func testPsalm138BLines1and2() {
        let line1 = psalm138B[0]  // "Et dixi: Forsitan tenebrae conculcabunt me: et nox illuminatio mea in deliciis meis."
        let line2 = psalm138B[1]  // "Quia tenebrae non obscurabuntur a te, et nox sicut dies illuminabitur: sicut tenebrae ejus, ita et lumen ejus."
        let combinedText = line1 + " " + line2
        latinService.configureDebugging(target: "illuminatio")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)

        latinService.configureDebugging(target: "")
        // Lemma verification
        let testLemmas = [
            ("dico", ["dixi"], "say"),
            ("forsitan", ["forsitan"], "perhaps"),
            ("tenebrae", ["tenebrae", "tenebrae"], "darkness"),
            ("conculco", ["conculcabunt"], "trample"),
            ("nox", ["nox", "nox"], "night"),
            ("illuminatio", ["illuminatio"], "light"),
            ("illumino", ["illuminabitur"], "light"),
            ("obscuro", ["obscurabuntur"], "darken"),
            ("dies", ["dies"], "day"),
            ("lumen", ["lumen"], "light"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Divine Illumination": [
                ("illuminatio", "Transforming light"),
                ("illumino", "Transforming light"),
                ("lumen", "Divine radiance"),
            ],
            "Darkness Transformed": [
                ("tenebrae", "Darkness overcome"),
                ("nox", "Night as day"),
            ],
            "Divine Protection": [
                ("conculco", "Negation of harm"),
                ("obscuro", "Light preserved"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    func testPsalm138BLines3and4() {
        let line3 = psalm138B[2]  // "Quia tu possedisti renes meos: suscepisti me de utero matris meae."
        let line4 = psalm138B[3]  // "Confitebor tibi, quia terribiliter magnificatus es: mirabilia opera tua, et anima mea cognoscit nimis."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)

        // Lemma verification
        let testLemmas = [
            ("possideo", ["possedisti"], "possess"),
            ("ren", ["renes"], "kidney"),
            ("suscipio", ["suscepisti"], "receive"),
            ("uterus", ["utero"], "womb"),
            ("mater", ["matris"], "mother"),
            ("confiteor", ["confitebor"], "praise"),
            ("terribilis", ["terribiliter"], "awesome"),
            ("magnifico", ["magnificatus"], "magnify"),
            ("mirabilis", ["mirabilia"], "wonderful"),
            ("opus", ["opera"], "work"),
            ("anima", ["anima"], "soul"),
            ("cognosco", ["cognoscit"], "know"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Divine Formation": [
                ("possideo", "Ownership of being"),
                ("suscipio", "Receiving at birth"),
            ],
            "Awe and Wonder": [
                ("terribilis", "Awesome power"),
                ("mirabilis", "Wonderful works"),
            ],
            "Personal Response": [
                ("confiteor", "Praise response"),
                ("cognosco", "Personal knowledge"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    func testPsalm138BLines5and6() {
        let line5 = psalm138B[4]  // "Non est occultatum os meum a te, quod fecisti in occulto: et substantia mea in inferioribus terrae."
        let line6 = psalm138B[5]  // "Imperfectum meum viderunt oculi tui, et in libro tuo omnia scribentur: dies formabuntur, et nemo in eis."
        let combinedText = line5 + " " + line6
        latinService.configureDebugging(target: "liber")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)

        latinService.configureDebugging(target: "")
        // Lemma verification
        let testLemmas = [
            ("occulto", ["occultatum", "occulto"], "hide"),
            ("os", ["os"], "mouth"),
            ("facio", ["fecisti"], "make"),
            ("substantia", ["substantia"], "substance"),
            ("inferior", ["inferioribus"], "lower"),
            ("terra", ["terrae"], "earth"),
            ("imperfectus", ["imperfectum"], "unfinished"),
            ("oculus", ["oculi"], "eye"),
            ("liber", ["libro"], "book"),
            ("scribo", ["scribentur"], "write"),
            ("dies", ["dies"], "day"),
            ("formo", ["formabuntur"], "form"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Divine Knowledge": [
                ("occulto", "Hidden things revealed"),
                ("oculus", "Divine sight"),
            ],
            "Creative Sovereignty": [
                ("formo", "Formation of days"),
                ("imperfectus", "Unformed state"),
            ],
            "Divine Record": [
                ("liber", "Book of life"),
                ("scribo", "Recording actions"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    func testPsalm138BLines7and8() {
        let line7 = psalm138B[6]  // "Mihi autem nimis honorati sunt amici tui, Deus: nimis confortatus est principatus eorum."
        let line8 = psalm138B[7]  // "Dinumerabo eos, et super arenam multiplicabuntur: exsurrexi, et adhuc sum tecum."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)

        // Lemma verification
        let testLemmas = [
            ("honoro", ["honorati"], "honor"),
            ("amicus", ["amici"], "friend"),
            ("deus", ["deus"], "God"),
            ("conforto", ["confortatus"], "strengthen"),
            ("principatus", ["principatus"], "rule"),
            ("dinumero", ["dinumerabo"], "count"),
            ("arena", ["arenam"], "sand"),
            ("multiplico", ["multiplicabuntur"], "multiply"),
            ("exsurgo", ["exsurrexi"], "rise"),
            ("adhuc", ["adhuc"], "still"),
            ("sum", ["sum"], "be"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Divine Friendship": [
                ("amicus", "God's friends"),
                ("honoro", "Honored status"),
            ],
            "Abundant Blessing": [
                ("multiplico", "Multiplication"),
                ("arena", "Sand as measure"),
            ],
            "Constant Presence": [
                ("exsurgo", "Resurrection imagery"),
                ("adhuc", "Continuing presence"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    func testPsalm138BLines9and10() {
        let line9 = psalm138B[8]  // "Si occideris, Deus, peccatores: viri sanguinum, declinate a me."
        let line10 = psalm138B[9]  // "Quia dicitis in cogitatione: Accipient in vanitate civitates tuas."
        let combinedText = line9 + " " + line10
        latinService.configureDebugging(target: "accipio")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)

        latinService.configureDebugging(target: nil)
        // Lemma verification
        let testLemmas = [
            ("occido", ["occideris"], "kill"),
            ("peccator", ["peccatores"], "sinner"),
            ("vir", ["viri"], "man"),
            ("sanguis", ["sanguinum"], "blood"),
            ("declino", ["declinate"], "turn away"),
            ("dico", ["dicitis"], "say"),
            ("cogitatio", ["cogitatione"], "thought"),
            ("accipio", ["accipient"], "receive"),
            ("vanitas", ["vanitate"], "vanity"),
            ("civitas", ["civitates"], "city"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Divine Judgment": [
                ("occido", "Destruction of wicked"),
                ("peccator", "Sinners identified"),
            ],
            "Violent Men": [
                ("sanguis", "Bloody men"),
                ("vir", "Violent individuals"),
            ],
            "False Claims": [
                ("vanitas", "Empty boasts"),
                ("civitas", "Cities as prize"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    func testPsalm138BLines11and12() {
        let line11 = psalm138B[10]  // "Nonne qui oderunt te, Domine, oderam? et super inimicos tuos tabescebam?"
        let line12 = psalm138B[11]  // "Perfecto odio oderam illos: inimici facti sunt mihi."
        let combinedText = line11 + " " + line12

        latinService.configureDebugging(target: "facio")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 11)
        latinService.configureDebugging(target: "")

        // Lemma verification
        let testLemmas = [
            ("odi", ["oderunt", "oderam", "oderam"], "hate"),
            ("dominus", ["domine"], "Lord"),
            ("inimicus", ["inimicos", "inimici"], "enemy"),
            ("tabesco", ["tabescebam"], "waste away"),
            ("perfectus", ["perfecto"], "perfect"),
            ("facio", ["facti"], "make"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Righteous Hatred": [
                ("odi", "Hatred of evil"),
                ("perfectus", "Complete rejection"),
            ],
            "Identification with God": [
                ("inimicus", "Shared enemies"),
                ("tabesco", "Emotional response"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:11-12 ANALYSIS:")
            print("11: \"\(line11)\"")
            print("12: \"\(line12)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    func testPsalm138BLines13and14() {
        let line13 = psalm138B[12]  // "Proba me, Deus, et scito cor meum: interroga me, et cognosce semitas meas."
        let line14 = psalm138B[13]  // "Et vide si via iniquitatis in me est: et deduc me in via aeterna."
        let combinedText = line13 + " " + line14
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 13)

        // Lemma verification
        let testLemmas = [
            ("probo", ["proba"], "test"),
            ("deus", ["deus"], "God"),
            ("scio", ["scito"], "know"),
            ("cor", ["cor"], "heart"),
            ("interrogo", ["interroga"], "examine"),
            ("cognosco", ["cognosce"], "know"),
            ("semita", ["semitas"], "path"),
            ("video", ["vide"], "see"),
            ("via", ["via", "via"], "way"),
            ("iniquitas", ["iniquitatis"], "wickedness"),
            ("deduco", ["deduc"], "lead"),
            ("aeternus", ["aeterna"], "eternal"),
        ]

        // Thematic analysis
        let expectedThemes = [
            "Divine Examination": [
                ("probo", "Request for testing"),
                ("interrogo", "Divine inquiry"),
            ],
            "Heart Knowledge": [
                ("cor", "Inner being"),
                ("scio", "Deep knowing"),
            ],
            "Eternal Guidance": [
                ("deduco", "Divine leading"),
                ("aeternus", "Everlasting way"),
            ],
        ]

        if verbose {
            print("\nPSALM 138B:13-14 ANALYSIS:")
            print("13: \"\(line13)\"")
            print("14: \"\(line14)\"")

            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }

            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }

        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }

    // MARK: - Helper Methods
    private func verifyWordsInAnalysis(
        _ analysis: PsalmAnalysisResult,
        confirmedWords: [(lemma: String, forms: [String], translation: String)]
    ) {
        let caseInsensitiveDict = Dictionary(
            uniqueKeysWithValues:
                analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )

        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                print("\n❌ MISSING LEMMA IN DICTIONARY: \(lemma)")
                XCTFail("Missing lemma: \(lemma)")
                continue
            }

            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )

            // Verify morphological coverage (case-insensitive)
            let entryFormsLowercased = Dictionary(
                uniqueKeysWithValues:
                    entry.forms.map { ($0.key.lowercased(), $0.value) }
            )

            let missingForms = forms.filter { entryFormsLowercased[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }

            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entryFormsLowercased[form.lowercased()] ?? 0
                    print(
                        "  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")"
                    )
                }
            }
        }
    }

    private func verifyThematicElements(
        analysis: PsalmAnalysisResult,
        expectedThemes: [String: [(lemma: String, description: String)]]
    ) {
        for (theme, elements) in expectedThemes {
            for (lemma, description) in elements {
                guard analysis.dictionary[lemma] != nil else {
                    XCTFail("Missing lemma for theme verification: \(lemma) (theme: \(theme))")
                    continue
                }

                if verbose {
                    print("VERIFIED THEME: \(theme) - \(lemma) (\(description))")
                }
            }
        }
    }
}
