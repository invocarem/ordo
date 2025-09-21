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
            "Divine Knowledge",
            "God's complete and perfect knowledge of all things",
            ["cognosco", "intellego", "praevideo", "scientia", "novissimus", "antiquus", "omnis"],
            ThemeCategory.divine,
            1...6
        ),
        (
            "Life Molding",
            "God as creator and shaper of human life",
            ["formo", "pono", "manus"],
            ThemeCategory.divine,
            1...4
        ),
        (
            "Omnipresence",
            "God's presence in all places and circumstances",
            ["ascendo", "caelum", "descendo", "infernus", "adsum", "mare", "extremus"],
            ThemeCategory.divine,
            6...9
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
            ["probo", "cogitatio", "semita", "funiculus"],
            ThemeCategory.divine,
            1...2
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
    private let expectedVerseCount = 14

    private let text = [
        "Et dixi: Forsitan tenebrae conculcabunt me: et nox illuminatio mea in deliciis meis.",
        "Quia tenebrae non obscurabuntur a te, et nox sicut dies illuminabitur: sicut tenebrae eius, ita et lumen eius.",
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

    private let englishText = [
        "And I said: Perhaps darkness shall cover me: and night shall be my light in my pleasures.",
        "But darkness shall not be dark to thee, and night shall be light as the day: the darkness thereof, and the light thereof are alike to thee.",
        "For thou hast possessed my reins: thou hast protected me from my mother's womb.",
        "I will praise thee, for thou art fearfully magnified: wonderful are thy works, and my soul knoweth right well.",
        "My bone is not hidden from thee, which thou hast made in secret: and my substance in the lower parts of the earth.",
        "Thy eyes did see my imperfect being, and in thy book all shall be written: days shall be formed, and no one in them.",
        "But to me thy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened.",
        "I will number them, and they shall be multiplied above the sand: I rose up and am still with thee.",
        "If thou wilt kill the wicked, O God, ye men of blood, depart from me.",
        "Because you say in thought: They shall receive thy cities in vain.",
        "Have I not hated them, O Lord, that hated thee: and pined away because of thy enemies?",
        "I have hated them with a perfect hatred: and they are become to me as enemies.",
        "Prove me, O God, and know my heart: examine me, and know my paths.",
        "And see if there be in me the way of iniquity: and lead me in the eternal way.",
    ]

    private let lineKeyLemmas = [
        (1, ["dico", "forsitan", "tenebrae", "conculco", "nox", "illuminatio", "deliciae"]),
        (2, ["tenebrae", "obscuro", "nox", "dies", "illumino", "lumen"]),
        (3, ["possideo", "ren", "suscipio", "uterus", "mater"]),
        (4, ["confiteor", "terribilis", "magnifico", "mirabilis", "opus", "anima", "cognosco"]),
        (5, ["occulto", "os", "facio", "substantia", "inferior", "terra"]),
        (6, ["imperfectus", "oculus", "video", "liber", "scribo", "dies", "formo"]),
        (7, ["honoro", "amicus", "deus", "conforto", "principatus"]),
        (8, ["dinumero", "arena", "multiplico", "exsurgo", "adhuc", "sum"]),
        (9, ["occido", "deus", "peccator", "vir", "sanguis", "declino"]),
        (10, ["dico", "cogitatio", "accipio", "vanitas", "civitas"]),
        (11, ["odi", "dominus", "tabesco", "inimicus"]),
        (12, ["perfectus", "odi", "inimicus", "facio"]),
        (13, ["probo", "deus", "scio", "cor", "interrogo", "cognosco", "semita"]),
        (14, ["video", "via", "iniquitas", "deduco", "aeternus"]),
    ]

    private let structuralThemes = [
        (
            "Darkness → Light",
            "The transformation of darkness into divine illumination and protection",
            [
                "dico", "forsitan", "tenebrae", "conculco", "nox", "illuminatio", "deliciae",
                "obscuro", "dies", "illumino", "lumen",
            ],
            1,
            2,
            "The psalmist's initial fear of darkness being overcome by God's light, where even night becomes as bright as day through divine presence.",
            "Augustine sees this as the soul's journey from spiritual darkness to divine illumination. The 'forsitan' (perhaps) shows human uncertainty, while God's light transforms even the deepest darkness, symbolizing how divine grace penetrates the darkest corners of the human heart."
        ),
        (
            "Formation → Praise",
            "Divine creation and formation leading to heartfelt praise and recognition",
            [
                "possideo", "ren", "suscipio", "uterus", "mater", "confiteor", "terribilis",
                "magnifico", "mirabilis", "opus", "anima", "cognosco",
            ],
            3,
            4,
            "God's intimate knowledge and formation of the psalmist from the womb, inspiring awe-filled praise for His wonderful works and fearful magnificence.",
            "For Augustine, this represents God's providential care from conception. The 'renes' (kidneys) symbolize the innermost being, while 'terribiliter magnificatus' shows the soul's proper response to divine majesty - not fear but reverent awe that leads to praise."
        ),
        (
            "Hidden → Revealed",
            "Divine omniscience revealing what is hidden and recording all in the book of life",
            [
                "occulto", "os", "facio", "substantia", "inferior", "terra", "imperfectus",
                "oculus", "video", "liber", "scribo", "dies", "formo",
            ],
            5,
            6,
            "Nothing is hidden from God's sight - not bones made in secret nor substance in the earth's depths, with all things recorded in His eternal book.",
            "Augustine interprets this as God's complete knowledge of human nature, both physical and spiritual. The 'liber' represents the book of predestination, where God has written all the days of each person's life before they are formed, showing His eternal foreknowledge and providence."
        ),
        (
            "Honor → Multiplication",
            "Divine friendship and honor leading to abundant blessing and constant presence",
            [
                "honoro", "amicus", "deus", "conforto", "principatus", "dinumero", "arena",
                "multiplico", "exsurgo", "adhuc", "sum",
            ],
            7,
            8,
            "God's friends are highly honored and strengthened, their number multiplied beyond counting like sand, with the psalmist rising to remain in God's presence.",
            "Augustine sees this as the Church's blessed state - those who are God's friends through grace receive honor and strength. The multiplication 'super arenam' represents the Church's growth throughout history, while 'exsurrexi' points to resurrection and eternal life with God."
        ),
        (
            "Judgment → Separation",
            "Divine judgment against the wicked and separation from those who speak vainly",
            [
                "occido", "deus", "peccator", "vir", "sanguis", "declino", "dico", "cogitatio",
                "accipio", "vanitas", "civitas",
            ],
            9,
            10,
            "A plea for God to destroy sinners and men of blood, with separation from those who speak vainly about receiving cities in vain.",
            "Augustine interprets this as the psalmist's desire for divine justice and separation from the wicked. The 'viri sanguinum' represent those who shed innocent blood, while the vain thoughts about cities show the emptiness of worldly ambition contrasted with divine blessing."
        ),
        (
            "Hatred → Enmity",
            "Righteous hatred of God's enemies leading to perfect enmity and separation",
            ["odi", "dominus", "tabesco", "inimicus", "perfectus", "facio"],
            11,
            12,
            "The psalmist's perfect hatred for those who hate God, causing him to waste away with grief, making them his enemies.",
            "For Augustine, this represents the soul's proper response to evil - not personal hatred but righteous rejection of what opposes God. The 'perfecto odio' is not sinful but a complete separation from evil, while 'tabesco' shows the soul's grief over sin and its effects."
        ),
        (
            "Examination → Guidance",
            "Divine testing and examination leading to eternal guidance and the way of life",
            [
                "probo", "deus", "scio", "cor", "interrogo", "cognosco", "semita", "video", "via",
                "iniquitas", "deduco", "aeternus",
            ],
            13,
            14,
            "A request for God to test and know the heart, examine and know the paths, leading to eternal guidance away from iniquity.",
            "Augustine sees this as the soul's final prayer for purification and guidance. The examination of heart and paths represents the process of sanctification, while the request for eternal guidance shows the soul's desire to walk in God's ways forever, away from the path of iniquity."
        ),
    ]

    private let conceptualThemes = [
        (
            "Light and Darkness",
            "The transformation of darkness into divine illumination",
            ["illuminatio", "illumino", "lumen", "tenebrae", "nox", "obscuro"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Life Formation",
            "God's intimate creation and shaping of human life from conception",
            ["possideo", "ren", "suscipio", "uterus", "mater", "formo"],
            ThemeCategory.divine,
            3...6
        ),
        (
            "Divine Knowledge",
            "God's complete omniscience and eternal record-keeping",
            ["cognosco", "scio", "oculus", "liber", "scribo", "imperfectus"],
            ThemeCategory.divine,
            1...14
        ),
        (
            "Divine Friendship",
            "The blessed state of being God's friend with honor and multiplication",
            ["honoro", "amicus", "conforto", "principatus", "dinumero", "arena", "multiplico"],
            ThemeCategory.divine,
            7...8
        ),
        (
            "Righteous Separation",
            "Divine judgment and separation from the wicked",
            ["occido", "peccator", "vir", "sanguis", "declino", "odi", "inimicus", "perfectus"],
            ThemeCategory.justice,
            9...12
        ),
        (
            "Heart Testing",
            "Divine examination and guidance of the human heart",
            ["probo", "cor", "interrogo", "semita", "via", "deduco", "aeternus"],
            ThemeCategory.divine,
            13...14
        ),
        (
            "Praise and Worship",
            "The soul's response of praise and recognition of God's works",
            ["confiteor", "terribilis", "magnifico", "mirabilis", "opus", "anima"],
            ThemeCategory.worship,
            4...4
        ),
    ]

    // MARK: - Test Methods

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 138B should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 138B English text should have \(expectedVerseCount) verses"
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
            filename: "output_psalm138B_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
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
            filename: "output_psalm138B_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
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
