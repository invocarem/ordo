import XCTest
@testable import LatinService

class Psalm118GimelTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 4
    let id = PsalmIdentity(number: 118, category: "gimel")
    
    // MARK: - Test Data Properties
    private let psalm118Gimel = [
        "Retribue servo tuo, vivifica me, et custodiam sermones tuos.",
        "Revela oculos meos, et considerabo mirabilia de lege tua.",
        "Incola ego sum in terra, non abscondas a me mandata tua.",
        "Concupivit anima mea desiderare iustificationes tuas in omni tempore.",
        "Increpasti superbos, maledicti qui declinant a mandatis tuis.",
        "Aufer a me opprobrium et contemptum, quia testimonia tua exquisivi.",
        "Etenim sederunt principes, et adversum me loquebantur; servus autem tuus exercebatur in iustificationibus tuis.",
        "Nam et testimonia tua meditatio mea est, et consilium meum iustificationes tuae."
    ]
    
    private let englishText = [
        "Deal bountifully with thy servant, that I may live and keep thy words.",
        "Open thou mine eyes, that I may behold the wondrous things of thy law.",
        "I am a stranger on the earth: hide not thy commandments from me.",
        "My soul breaketh for the longing it hath unto thy judgments at all times.",
        "Thou hast rebuked the proud that are cursed, which do err from thy commandments.",
        "Remove from me reproach and contempt; for I have kept thy testimonies.",
        "Princes also did sit and speak against me: but thy servant did meditate in thy statutes.",
        "Thy testimonies also are my delight and my counsellors."
    ]
    
    private let lineKeyLemmas = [
        (1, ["retribuo", "servus", "vivifico", "custodio", "sermo"]),
        (2, ["revelo", "oculus", "considero", "mirabilis", "lex"]),
        (3, ["incola", "terra", "abscondo", "mandatum"]),
        (4, ["concupisco", "anima", "desidero", "iustificatio", "omnis", "tempus"]),
        (5, ["increpo", "superbus", "maledictus", "declino", "mandatum"]),
        (6, ["aufero", "opprobrium", "contemptus", "testimonium", "exquiro"]),
        (7, ["etenim", "sedeo", "princeps", "adversus", "loquor", "servus", "exerceo", "iustificatio"]),
        (8, ["nam", "testimonium", "meditatio", "consilium", "iustificatio"])
    ]
    
    private let structuralThemes = [
        (
            "Servant Identity",
            "The psalmist's self-understanding as God's servant",
            ["servus", "vivifico", "custodio", "exerceo", "incola"],
            1,
            3,
            "Repeated servant language with active obedience",
            "The psalmist identifies as God's servant seeking life through keeping His words, asking for divine revelation, and acknowledging his status as a stranger on earth."
        ),
        (
            "Divine Illumination",
            "Prayers for spiritual understanding",
            ["revelo", "oculus", "considero", "mirabilis", "lex"],
            2,
            3,
            "Vision metaphors for Torah comprehension",
            "The psalmist asks God to open his eyes to see the wondrous things of His law, recognizing his need for divine illumination to understand God's commandments."
        ),
        (
            "Exilic Longing",
            "The soul's intense desire for God's judgments",
            ["concupisco", "anima", "desidero", "iustificatio", "tempus"],
            4,
            4,
            "Intense spiritual longing and desire",
            "The psalmist's soul breaks with longing for God's judgments at all times, expressing the deep spiritual hunger of one who seeks divine wisdom."
        ),
        (
            "Opposition → Vindication",
            "The contrast between the proud who oppose and the servant who meditates",
            ["superbus", "increpo", "opprobrium", "princeps", "adversus", "meditatio", "consilium"],
            5,
            8,
            "Contrast between enemies and faithful servant",
            "The psalmist describes how the proud are rebuked and princes speak against him, but he remains faithful as God's servant, finding delight and counsel in God's testimonies."
        )
    ];

    private let conceptualThemes = [
        (
            "Petition",
            "Requests for God's action and intervention",
            ["retribuo", "vivifico", "revelo", "abscondo", "aufero", "concupisco"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Opposition",
            "References to enemies, pride, and opposition",
            ["superbus", "maledictus", "increpo", "opprobrium", "contemptus", "princeps", "adversus"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Devotion",
            "Expressions of commitment, exercise, and meditation",
            ["custodio", "considero", "exquiro", "exerceo", "meditatio", "desidero"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Divine Word",
            "References to God's law, statutes, and testimonies",
            ["sermo", "lex", "mandatum", "iustificatio", "testimonium", "mirabilis"],
            ThemeCategory.divine,
            1...8
        )
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Cases
    
    func testTotalVerses() {
        XCTAssertEqual(
            psalm118Gimel.count, 8, "Psalm 118 Gimel should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Gimel English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Gimel.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Gimel,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Gimel,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Gimel_texts.json"
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
            filename: "output_psalm118Gimel_themes.json"
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
            psalmText: psalm118Gimel,
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
            psalmText: psalm118Gimel,
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
            psalmText: psalm118Gimel,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}