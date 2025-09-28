import XCTest

@testable import LatinService

class Psalm118CaphTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let id = PsalmIdentity(number: 118, category: "caph")

    // MARK: - Test Data
    private let expectedVerseCount = 8

    private let text = [
        /* 1 */
        "Defecit in salutare tuum anima mea, et in verbum tuum supersperavi.",
        /* 2 */ "Defecerunt oculi mei in eloquium tuum, dicentes: Quando consolaberis me?",
        /* 3 */ "Quia factus sum sicut uter in pruina, iustificationes tuas non sum oblitus.",
        /* 4 */ "Quot sunt dies servi tui? quando facies de persequentibus me iudicium?",
        /* 5 */ "Narraverunt mihi iniqui fabulationes, sed non ut lex tua.",
        /* 6 */ "Omnia mandata tua veritas; inique persecuti sunt me, adiuva me.",
        /* 7 */ "Paulo minus consummaverunt me in terra, ego autem non dereliqui mandata tua.",
        /* 8 */ "Secundum misericordiam tuam vivifica me, et custodiam testimonia oris tui.",
    ]

    private let englishText = [
        /* 1 */
        "My soul hath fainted after thy salvation: and in thy word I have hoped exceedingly.",
        /* 2 */ "My eyes have failed for thy word, saying: When wilt thou comfort me?",
        /* 3 */
        "For I am become like a bottle in the frost: I have not forgotten thy justifications.",
        /* 4 */
        "How many are the days of thy servant? When wilt thou execute judgment on them that persecute me?",
        /* 5 */ "The wicked have told me fables: but not as thy law.",
        /* 6 */
        "All thy commandments are truth: they have persecuted me unjustly, do thou help me.",
        /* 7 */
        "They had almost made an end of me upon earth: but I have not forsaken thy commandments.",
        /* 8 */
        "Quicken thou me according to thy mercy: and I shall keep the testimonies of thy mouth.",
    ]

    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["deficio", "salus", "anima", "verbum", "superspero"]),
        (2, ["deficio", "oculus", "eloquium", "dico", "quando", "consolor"]),
        (3, ["quia", "facio", "sicut", "uter", "pruina", "iustificatio", "obliviscor"]),
        (4, ["quot", "dies", "servus", "quando", "facio", "persequor", "iudicium"]),
        (5, ["narro", "iniquus", "fabula", "lex"]),
        (6, ["omnis", "mandatum", "veritas", "inique", "persequor", "adiuvo"]),
        (7, ["paulus", "minus", "consummo", "terra", "derelinquo", "mandatum"]),
        (8, ["secundum", "misericordia", "vivifico", "custodio", "testimonium", "os"]),
    ]

    private let structuralThemes = [
        (
            "Fainting → Hope",
            "The soul and eyes grow faint while waiting for God's salvation and comfort",
            ["deficio", "salus", "superspero", "eloquium", "consolor"],
            1,
            2,
            "The psalmist's soul faints for God's salvation while his eyes fail looking for God's word, crying out 'When will you comfort me?' yet maintaining supreme hope.",
            "Augustine sees this as the soul's weary longing for Christ, the true salvation. The physical exhaustion represents spiritual thirst, while the 'superspero' shows hope that transcends human weakness."
        ),
        (
            "Affliction → Memory",
            "Becoming like a wineskin in frost while still remembering God's justifications",
            ["fio", "uter", "pruina", "iustificatio", "obliviscor"],
            3,
            4,
            "Though made like a wineskin shriveled by frost - a image of extreme affliction - the psalmist has not forgotten God's statutes. He questions how long until God judges his persecutors.",
            "For Augustine, the frozen wineskin represents the soul shriveled by suffering and waiting. The memory of God's justifications preserves faith during this frozen state, while the cry for judgment expresses trust in divine justice."
        ),
        (
            "Deception → Truth",
            "Facing false stories from the wicked while clinging to God's true commandments",
            ["narro", "iniquus", "fabula", "veritas", "persequor", "adiuvo"],
            5,
            6,
            "The wicked tell deceptive stories, but not according to God's law. The psalmist affirms all God's commandments are truth, cries that the wicked persecute him unjustly, and begs for help.",
            "Augustine interprets this as the conflict between worldly wisdom and divine truth. The 'fabulae' represent human philosophies opposed to God's law. The prayer for help acknowledges that only divine aid can preserve truth in persecution."
        ),
        (
            "Consumption → Preservation",
            "Nearly consumed on earth yet not abandoning God's commandments, seeking life through mercy",
            ["consummo", "derelinquo", "misericordia", "vivifico", "custodio", "testimonium"],
            7,
            8,
            "Though nearly consumed on earth, the psalmist has not abandoned God's precepts. He pleads for life according to God's mercy so he may keep the testimonies of God's mouth.",
            "Augustine sees the near-consummation as the final assault of temptation. Not abandoning the commandments demonstrates grace-enabled perseverance. The appeal for life 'secundum misericordiam' acknowledges salvation depends on mercy, not merit."
        ),
    ]

    private let conceptualThemes = [
        (
            "Spiritual Exhaustion",
            "The soul and eyes growing faint while waiting for God's salvation and comfort",
            ["deficio", "salus", "superspero", "consolor", "oculus", "eloquium"],
            ThemeCategory.virtue,
            1...2
        ),
        (
            "Divine Word Longing",
            "Intense desire for God's word and comfort in times of spiritual dryness",
            ["verbum", "eloquium", "consolor", "quando", "superspero"],
            ThemeCategory.worship,
            1...2
        ),
        (
            "Affliction and Memory",
            "Physical and spiritual affliction while maintaining memory of God's justifications",
            ["uter", "pruina", "iustificatio", "obliviscor", "fio"],
            ThemeCategory.virtue,
            3...4
        ),
        (
            "Persecution and Justice",
            "Facing persecution while seeking divine judgment and justice",
            ["persequor", "iudicium", "iniquus", "consummo", "terra"],
            ThemeCategory.justice,
            4...7
        ),
        (
            "Truth vs. Deception",
            "The conflict between divine truth and human deception",
            ["veritas", "fabula", "lex", "mandatum", "narro", "iniquus"],
            ThemeCategory.conflict,
            5...6
        ),
        (
            "Divine Mercy and Life",
            "Seeking life and preservation through God's mercy and testimonies",
            ["misericordia", "vivifico", "custodio", "testimonium", "os"],
            ThemeCategory.divine,
            7...8
        ),
        (
            "Faithful Perseverance",
            "Maintaining faithfulness to God's commandments despite persecution",
            ["custodio", "derelinquo", "mandatum", "testimonium", "iustificatio"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Salvation Hope",
            "Hope in God's salvation that transcends physical and spiritual exhaustion",
            ["salus", "superspero", "vivifico", "adiuvo", "consolor"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Divine Word Authority",
            "The authority and truth of God's word over human philosophies",
            ["verbum", "eloquium", "lex", "mandatum", "veritas", "testimonium"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Spiritual Warfare",
            "The ongoing battle between divine truth and worldly deception",
            ["persequor", "iniquus", "fabula", "veritas", "adiuvo"],
            ThemeCategory.conflict,
            5...6
        ),
        (
            "Grace-Enabled Obedience",
            "Obedience to God's law enabled by divine grace and mercy",
            ["custodio", "mandatum", "misericordia", "vivifico", "testimonium"],
            ThemeCategory.virtue,
            7...8
        ),
        (
            "Divine Comfort",
            "Seeking and finding comfort in God's word during spiritual trials",
            ["consolor", "quando", "eloquium", "verbum", "superspero"],
            ThemeCategory.worship,
            1...2
        ),
    ]

    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: text,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    // MARK: - Thematic Tests

    func testLongingForSalvationTheme() {
        let salvationTerms = [
            ("deficio", ["Defecit", "Defecerunt"], "faint"),
            ("salus", ["salutare"], "salvation"),
            ("superspero", ["supersperavi"], "hope exceedingly"),
            ("consolor", ["consolaberis"], "comfort"),
            ("vivifico", ["vivifica"], "give life"),
            ("adiuvo", ["adiuva"], "help"),
        ]

        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: salvationTerms,
            verbose: verbose
        )
    }

    func testPersecutionTheme() {
        let persecutionTerms = [
            ("persequor", ["persequentibus"], "persecute"),
            ("iniquus", ["iniqui", "inique"], "wicked"),
            ("consummo", ["consummaverunt"], "consume"),
            ("terra", ["terra"], "earth"),
            ("fabula", ["fabulationes"], "fables"),
            ("iudicium", ["iudicium"], "judgment"),
        ]

        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: persecutionTerms,
            verbose: verbose
        )
    }

    func testFaithfulnessTheme() {
        let faithfulnessTerms = [
            ("custodio", ["custodiam"], "keep"),
            ("derelinquo", ["dereliqui"], "forsake"),
            ("obliviscor", ["oblitus"], "forget"),
            ("mandatum", ["mandata", "mandata"], "commandments"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("iustificatio", ["iustificationes"], "justifications"),
        ]

        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: faithfulnessTerms,
            verbose: verbose
        )
    }

    func testDivineWordTheme() {
        let divineWordTerms = [
            ("verbum", ["verbum", "verbum"], "word"),
            ("eloquium", ["eloquium", "eloquium"], "speech"),
            ("lex", ["lex"], "law"),
            ("mandatum", ["mandata", "mandata"], "commandments"),
            ("veritas", ["veritas"], "truth"),
            ("testimonium", ["testimonia"], "testimonies"),
        ]

        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: divineWordTerms,
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

    // MARK: - Additional Test Methods

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount,
            "Psalm 118 Caph should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 118 Caph English text should have \(expectedVerseCount) verses"
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
            filename: "output_psalm118caph_texts.json"
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
            filename: "output_psalm118caph_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
