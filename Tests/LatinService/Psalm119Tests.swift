import XCTest

@testable import LatinService

class Psalm119Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    let id = PsalmIdentity(number: 119, category: nil)
    private let expectedVerseCount = 6

    // MARK: - Test Data Properties

    private let psalm119 = [
        "Ad Dominum cum tribularer clamavi, et exaudivit me.",
        "Domine, libera anima mea a labiis iniquis, et a lingua dolosa.",
        "Quid detur tibi, aut quid apponatur tibi ad linguam dolosam?",
        "Sagittae potentis acutae, cum carbonibus desolatoriis.",
        "Heu mihi, quia incolatus meus prolongatus est: habitavi cum habitantibus Cedar: multum incola fuit anima mea.",
        "Cum his, qui oderunt pacem, ego pacem quaerebam: et cum loquerer illis, impugnabant me gratis.",
    ]

    private let englishText = [
        "To the Lord, when I was in tribulation, I cried out: and he heard me.",
        "O Lord, deliver my soul from wicked lips, and a deceitful tongue.",
        "What shall be given to thee, or what shall be added to thee, against a deceitful tongue?",
        "The sharp arrows of the mighty, with coals that lay waste.",
        "Woe is me, that my sojourning is prolonged: I have dwelt with the inhabitants of Cedar, long hath my soul been a sojourner.",
        "With them that hate peace, I sought peace: and when I spoke thereof to them, they fought against me without cause.",
    ]

    private let lineKeyLemmas = [
        (1, ["ad", "dominus", "tribulor", "clamo", "exaudio"]),
        (2, ["dominus", "libero", "anima", "labium", "iniquus", "lingua", "dolosus"]),
        (3, ["quis", "do", "appono", "lingua", "dolosus"]),
        (4, ["sagitta", "potens", "acutus", "carbo", "desolatorius"]),
        (
            5,
            [
                "heu", "incolatus", "prolongo", "habito", "cedar", "multus", "incola",
                "anima",
            ]
        ),
        (6, ["cum", "odi", "pax", "quaero", "loquor", "impugno", "gratis"]),
    ]

    private let structuralThemes = [
        (
            "Distress → Deliverance",
            "From inner affliction to divine liberation from deceit",
            ["tribulor", "clamo", "exaudio", "libero", "labium", "iniquus", "lingua", "dolosus"],
            1,
            2,
            "The psalmist begins with a cry to the Lord in time of trouble and receives assurance of being heard, followed by a specific plea for deliverance from deceitful lips and a lying tongue.",
            "Augustine sees this as the cry of the soul caught in inner tribulation, not just external hardship. The deceitful tongue symbolizes confusion and heresy. God hears, not to shield physically, but to deliver the soul through truth. The movement from anguish to 'libera animam meam' marks grace's work in pulling the soul out of lies and into light (Enarr. Ps. 119.1–2)."
        ),
        (
            "Deception → Purifying Judgment",
            "The harm of lies is answered by divine fire and piercing correction",
            ["do", "appono", "lingua", "sagitta", "potens", "acutus", "carbo", "desolatorius"],
            3,
            4,
            "The psalmist asks what punishment fits a deceitful tongue, answering with the metaphor of a warrior's sharp arrows and the desolating coals of juniper.",
            "Augustine reads these verses as the divine response to false speech. The tongue, which wounds through deceit, will receive 'sharp arrows' and 'desolating coals.' But these are not simply for destruction: they are purifying instruments. The 'coals' represent the burning power of charity, which scorches away sin and heals the deceived (Enarr. Ps. 119.3–5)."
        ),
        (
            "Exile → Conflict",
            "Dwelling long among the ungodly deepens the soul's sorrow",
            ["heu", "incolatus", "prolongo", "cedar", "incola", "impugno", "gratis"],
            5,
            6,
            "'Heu mihi' is Augustine's sigh of the pilgrim soul exiled from its true home. To live in Kedar — a symbol of those who live in the flesh — is to be surrounded by hostility toward peace. The soul has dwelt too long here, not because of years, but because it feels the pain of separation from the City of God.",
            "Augustine interprets this verse as the voice of Christ and His Church: always seeking peace, yet constantly met with opposition. The psalmist speaks kindly, yet is attacked 'gratis' — without cause. This unjust suffering anticipates the passion of Christ, who was hated for no reason."
        ),
    ]

    private let conceptualThemes = [
        (
            "Divine Response",
            "God's hearing and answering of prayers",
            ["exaudio", "clamo", "dominus"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Deceitful Speech",
            "The harm and corruption of lying tongues",
            ["lingua", "dolosus", "iniquus", "labium"],
            ThemeCategory.sin,
            2...3
        ),
        (
            "Divine Judgment",
            "God's purifying and corrective response to falsehood",
            ["sagitta", "potens", "acutus", "carbo", "desolatorius"],
            ThemeCategory.justice,
            3...4
        ),
        (
            "Spiritual Exile",
            "The soul's separation from its true home",
            ["incolatus", "prolongo", "cedar", "incola", "anima"],
            ThemeCategory.virtue,
            5...5
        ),
        (
            "Peace and Conflict",
            "The struggle between seeking peace and facing opposition",
            ["pax", "quaero", "impugno", "gratis"],
            ThemeCategory.conflict,
            6...6
        ),
        (
            "Divine Deliverance",
            "God's liberation from spiritual bondage",
            ["libero", "anima", "tribulor"],
            ThemeCategory.virtue,
            1...2
        ),
        (
            "Weapon Imagery",
            "Military metaphors for divine correction",
            ["sagitta", "carbo", "potens", "acutus"],
            ThemeCategory.conflict,
            4...4
        ),
        (
            "Geographical Exile",
            "Physical and spiritual displacement from home",
            ["cedar", "incolatus", "prolongo", "habito"],
            ThemeCategory.opposition,
            5...5
        ),
    ]

    // MARK: - Test Methods

    func testTotalVerses() {
        XCTAssertEqual(
            psalm119.count, expectedVerseCount, "Psalm 119 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 119 English text should have \(expectedVerseCount) verses")
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm119.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm119,
            "Normalized Latin text should match expected classical forms"
        )
    }

    // MARK: - Line by Line Key Lemmas Test

    func testLineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm119,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testStructuralThemes() {
        utilities.testStructuralThemes(
            psalmText: psalm119,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        utilities.testConceptualThemes(
            psalmText: psalm119,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    // MARK: - Test Cases

    func testPersecutionVocabulary() {
        let latinService = LatinService.shared
        latinService.configureDebugging(target: "inpugno")
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        let persecutionTerms = [
            ("tribulor", ["tribularer"], "afflict"),  // v.1
            ("iniquus", ["iniquis"], "unjust"),  // v.2
            ("impugno", ["impugnabant"], "attack"),  // v.7
            ("desolatorius", ["desolatoriis"], "destructive"),  // v.4
        ]

        verifyWordsInAnalysis(analysis, confirmedWords: persecutionTerms)
        latinService.configureDebugging(target: "")
    }

    func testVerbApponatur() {
        let latinService = LatinService.shared
        latinService.configureDebugging(target: "appono")
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        let apponoEntry = analysis.dictionary["appono"]
        XCTAssertNotNil(apponoEntry, "Lemma 'appono' should exist for 'apponatur'")

        if let entity = apponoEntry?.entity {
            let result = entity.analyzeFormWithMeaning("apponatur")
            XCTAssertTrue(
                result.contains("present") && result.contains("passive")
                    && result.contains("subjunctive"),
                "Expected present passive subjunctive, got: \(result)")
        }
    }

    func testLinguisticImagery() {
        let latinService = LatinService.shared
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        let speechTerms = [
            ("labium", ["labiis"], "lip"),  // v.2
            ("lingua", ["lingua", "linguam"], "tongue"),  // v.2, v.3
            ("loquor", ["loquerer"], "speak"),  // v.7
        ]

        verifyWordsInAnalysis(analysis, confirmedWords: speechTerms)
    }
    func testVerbLoquerer() {
        let latinService = LatinService.shared
        latinService.configureDebugging(target: "loquor")
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        // Verify "loquerer" comes from "loquor"
        let loquorEntry = analysis.dictionary["loquor"]
        XCTAssertNotNil(loquorEntry, "Lemma 'loquor' should exist for 'loquerer'")

        // Check translation
        let translation = loquorEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("speak") || translation.contains("talk"),
            "Expected 'loquor' to mean 'speak' or 'talk', got: \(translation)"
        )

        // Check if "loquerer" is a recognized form
        let loquererFormCount = loquorEntry?.forms["loquerer"] ?? 0
        XCTAssertGreaterThan(
            loquererFormCount, 0,
            "Form 'loquerer' should exist for lemma 'loquor'"
        )

        if let entity = loquorEntry?.entity {
            let result = entity.analyzeFormWithMeaning("loquerer")

            // Verify it's imperfect active subjunctive (1st singular)
            XCTAssertTrue(
                result.lowercased().contains("i would speak")
                    || result.lowercased().contains("imperfect")
                    || result.lowercased().contains("subjunctive"),
                "Expected 'I would speak' (imperfect subjunctive), got: \(result)"
            )

            if verbose {
                print("\nLOQUOR Analysis:")
                print("  Translation: \(loquorEntry?.translation ?? "?")")
                print("  Form 'loquerer' analysis: \(result)")
            }
        } else {
            XCTFail("Entity for 'loquor' not found")
        }

        latinService.configureDebugging(target: "")
    }

    func testGeographicalReferences() {
        let latinService = LatinService.shared
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        let places = [
            ("cedar", ["Cedar"], "Kedar"),  // v.5
            ("incolatus", ["incolatus"], "sojourn"),  // v.5
        ]

        verifyWordsInAnalysis(analysis, confirmedWords: places)
    }

    func testMilitaryMetaphors() {
        let latinService = LatinService.shared
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        let weaponTerms = [
            ("sagitta", ["Sagittae"], "arrow"),  // v.4
            ("carbo", ["carbonibus"], "coal"),  // v.4
        ]

        verifyWordsInAnalysis(analysis, confirmedWords: weaponTerms)
    }

    func testVerbImpugnabant() {
        let latinService = LatinService.shared
        latinService.configureDebugging(target: "impugno")
        let analysis = latinService.analyzePsalm(id, text: psalm119)

        // Verify "impugnabant" comes from "impugno"
        let impugnoEntry = analysis.dictionary["impugno"]
        XCTAssertNotNil(impugnoEntry, "Lemma 'impugno' should exist for 'impugnabant'")

        // Check translation
        let translation = impugnoEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("attack") || translation.contains("assail"),
            "Expected 'impugno' to mean 'attack' or 'assail', got: \(translation)"
        )

        // Check if "impugnabant" is a recognized form
        let impugnabantFormCount = impugnoEntry?.forms["impugnabant"] ?? 0
        XCTAssertGreaterThan(
            impugnabantFormCount, 0,
            "Form 'impugnabant' should exist for lemma 'impugno'"
        )

        if let entity = impugnoEntry?.entity {
            let result = entity.analyzeFormWithMeaning("impugnabant")

            // Verify it's imperfect active indicative (3rd plural)
            XCTAssertTrue(
                result.lowercased().contains("they were attacking"),
                "Expected 'they were attacking' (imperfect active), got: \(result)"
            )

            if verbose {
                print("\nIMPUGNO Analysis:")
                print("  Translation: \(impugnoEntry?.translation ?? "?")")
                print("  Form 'impugnabant' analysis: \(result)")
            }
        } else {
            XCTFail("Entity for 'impugno' not found")
        }
    }

    func testSaveTexts() {
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm119,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm119_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
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
            filename: "output_psalm119_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }

    // MARK: - Helper
    private func verifyWordsInAnalysis(
        _ analysis: PsalmAnalysisResult,
        confirmedWords: [(
            lemma: String,
            forms: [String],
            translation: String
        )]
    ) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }

            // Verify semantic domain through translation
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )

            // Verify morphological coverage
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }

            // NEW: Verify each form's grammatical analysis
            for form in forms {
                if let entity = entry.entity {
                    let result = entity.analyzeFormWithMeaning(form)

                    // Check if analysis contains either:
                    // 1. The exact translation we expect
                    // 2. Or appropriate grammatical markers
                    XCTAssertTrue(
                        result.lowercased().contains(translation.lowercased())
                            || result.lowercased().contains("verb")
                            || result.lowercased().contains("participle")
                            || result.lowercased().contains("noun"),
                        """
                        For form '\(form)' of lemma '\(lemma)':
                        Expected analysis to contain '\(translation)' or grammatical info,
                        but got: \(result)
                        """
                    )

                    if verbose {
                        print("  Analysis of '\(form)': \(result)")
                    }
                } else {
                    XCTFail("Entity for lemma '\(lemma)' not found")
                }
            }

            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                print(
                    "  Forms found: \(entry.forms.keys.filter { forms.map { $0.lowercased() }.contains($0) }.count)/\(forms.count)"
                )
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print(
                        "  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")"
                    )
                }
            }
        }
    }

}
