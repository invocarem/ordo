import XCTest
@testable import LatinService

class Psalm52Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true
    private var latinService: LatinService!
    let id = PsalmIdentity(number: 52, category: "")

    // MARK: - Test Data Properties

    private let expectedVerseCount = 8
    private let text = [
        "Dixit insipiens in corde suo: Non est Deus.",
        "Corrupti sunt, et abominabiles facti sunt in iniquitatibus; non est qui faciat bonum.",
        "Deus de caelo prospexit super filios hominum, ut videat si est intelligens, aut requirens Deum.",
        "Omnes declinaverunt, simul inutiles facti sunt; non est qui faciat bonum, non est usque ad unum.",
        "Nonne scient omnes qui operantur iniquitatem, qui devorant plebem meam sicut escam panis?",
        "Deum non invocaverunt; illic trepidaverunt timore, ubi non erat timor.",
        "Quoniam Deus dissipavit ossa eorum qui hominibus placent; confusi sunt, quoniam Deus sprevit eos.",
        "Quis dabit ex Sion salutare Israel? cum averterit Deus captivitatem plebis suae, exsultabit Iacob, et laetabitur Israel."
    ]

    private let englishText = [
        "The fool hath said in his heart: There is no God.",
        "They are corrupt, and are become abominable in iniquities: there is none that doth good.",
        "God hath looked down from heaven upon the children of men, to see if there be any that understand and seek God.",
        "All have gone aside, they are become unprofitable together: there is none that doth good, no not one.",
        "Shall not all the workers of iniquity know, who eat up my people as they eat bread?",
        "They have not called upon God: there have they trembled for fear, where there was no fear.",
        "For God hath scattered the bones of them that please men: they have been confounded, because God hath despised them.",
        "Who will give out of Sion the salvation of Israel? when God shall bring back the captivity of his people, Jacob shall rejoice, and Israel shall be glad."
    ]

    private let lineKeyLemmas = [
        (1, ["dico", "insipiens", "cor", "sum", "deus"]),
        (2, ["corrumpo", "sum", "abominabilis", "facio", "sum", "iniquitas", "sum", "qui", "facio", "bonus"]),
        (3, ["deus", "caelum", "prospicio", "super", "filius", "homo", "video", "sum", "intelligo", "aut", "requiro", "deus"]),
        (4, ["omnis", "declino", "simul", "inutilis", "facio", "sum", "sum", "qui", "facio", "bonus", "sum", "usque", "ad", "unus"]),
        (5, ["nonne", "scio", "omnis", "qui", "operor", "iniquitas", "qui", "devoro", "plebs", "meus", "sicut", "esca", "panis"]),
        (6, ["deus", "non", "invoco", "illic", "trepido", "timor", "ubi", "non", "sum", "timor"]),
        (7, ["quoniam", "deus", "dissipo", "os", "is", "qui", "homo", "placeo", "confundo", "sum", "quoniam", "deus", "sperno", "is"]),
        (8, ["quis", "do", "ex", "sion", "salutare", "israel", "cum", "averto", "deus", "captivitas", "plebs", "suus", "exsulto", "iacob", "et", "laetor", "israel"])
    ]

    private let structuralThemes = [
        (
            "Folly and Denial",
            "The fool's denial of God and the resulting corruption",
            ["dico", "insipiens", "cor", "deus", "corrumpo", "abominabilis", "iniquitas", "bonus"],
            1,
            2,
            "The psalm begins with the fool's declaration that there is no God, leading to widespread corruption and absence of good deeds.",
            "This establishes the fundamental opposition between divine wisdom and human folly, showing how denial of God leads to moral decay."
        ),
        (
            "Divine Observation", 
            "God's observation from heaven and the universal human condition",
            ["deus", "caelum", "prospicio", "filius", "homo", "video", "intelligo", "requiro", "omnis", "declino", "inutilis"],
            3,
            4,
            "God looks down from heaven to see if any understand or seek Him, but finds all have turned aside and become unprofitable.",
            "This reveals God's active engagement with humanity and the universal nature of human sinfulness apart from divine grace."
        ),
        (
            "Iniquity and Judgment",
            "The workers of iniquity and their impending judgment",
            ["scio", "operor", "iniquitas", "devoro", "plebs", "invoco", "trepido", "timor", "dissipo", "confundo", "sperno"],
            5,
            7,
            "Those who work iniquity and devour God's people will know judgment; they tremble without cause and are confounded by God.",
            "This section contrasts the false security of the wicked with the true judgment that comes from God who sees all actions."
        ),
        (
            "Hope and Salvation",
            "The hope of salvation from Zion and restoration of God's people",
            ["do", "sion", "salutare", "israel", "averto", "captivitas", "plebs", "exsulto", "iacob", "laetor"],
            8,
            8,
            "The psalm concludes with hope for salvation from Zion, when God restores His people, bringing joy to Jacob and Israel.",
            "This final theme provides eschatological hope, pointing to God's ultimate redemption despite present circumstances of corruption and denial."
        ),
    ]

    private let conceptualThemes = [
        (
            "Atheistic Folly",
            "The fool's denial of God's existence and its consequences",
            ["insipiens", "dico", "cor", "deus"],
            ThemeCategory.conflict,
            1...1
        ),
        (
            "Universal Corruption", 
            "The widespread corruption and absence of goodness among humanity",
            ["corrumpo", "abominabilis", "iniquitas", "bonus", "omnis", "declino", "inutilis"],
            ThemeCategory.sin,
            2...4
        ),
        (
            "Divine Omniscience",
            "God's observation and knowledge of human affairs from heaven",
            ["deus", "caelum", "prospicio", "video", "intelligo", "requiro"],
            ThemeCategory.divine,
            3...3
        ),
        (
            "Wicked Oppression",
            "The wicked who oppress God's people and face judgment",
            ["operor", "iniquitas", "devoro", "plebs", "trepido", "dissipo", "confundo"],
            ThemeCategory.justice,
            5...7
        ),
        (
            "Redemptive Hope",
            "The hope of salvation and restoration for God's people",
            ["salutare", "israel", "captivitas", "plebs", "exsulto", "iacob", "laetor"],
            ThemeCategory.justice,
            8...8
        ),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Test Cases

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 52 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 52 English text should have \(expectedVerseCount) verses"
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
            filename: "output_psalm52_texts.json"
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
            filename: "output_psalm52_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
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

    // MARK: - Original Thematic Tests (kept for backward compatibility)
    
    func testFollyAndAtheismTheme() {
        let follyTerms = [
            ("insipiens", ["insipiens"], "fool"),
            ("dico", ["dixit"], "say"),
            ("cor", ["corde"], "heart"),
            ("deus", ["deus"], "God"),
            ("corrumpo", ["corrupti"], "corrupt"),
            ("abominabilis", ["abominabiles"], "abominable")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: follyTerms,
            verbose: verbose
        )
    }
    
    func testDivineObservationTheme() {
        let observationTerms = [
            ("deus", ["deus"], "God"),
            ("caelum", ["caelo"], "heaven"),
            ("prospicio", ["prospexit"], "look down"),
            ("video", ["videat"], "see"),
            ("intelligo", ["intelligens"], "understand"),
            ("requiro", ["requirens"], "seek")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: observationTerms,
            verbose: verbose
        )
    }
    
    func testHumanCorruptionTheme() {
        let corruptionTerms = [
            ("omnis", ["omnes"], "all"),
            ("declino", ["declinaverunt"], "turn aside"),
            ("inutilis", ["inutiles"], "unprofitable"),
            ("bonus", ["bonum"], "good"),
            ("iniquitas", ["iniquitatibus"], "iniquity"),
            ("operor", ["operantur"], "work")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: corruptionTerms,
            verbose: verbose
        )
    }
    
    func testSalvationTheme() {
        let salvationTerms = [
            ("salutare", ["salutare"], "salvation"),
            ("israel", ["israel"], "Israel"),
            ("captivitas", ["captivitatem"], "captivity"),
            ("plebs", ["plebem"], "people"),
            ("exsulto", ["exsultabit"], "rejoice"),
            ("laetor", ["laetabitur"], "be glad")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: salvationTerms,
            verbose: verbose
        )
    }
}