import XCTest
@testable import LatinService

class Psalm118HeTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "he")
    
    // MARK: - Test Data
    private let psalm118He = [
        "Legem pone mihi, Domine, viam iustificationum tuarum, et exquiram eam semper.",
        "Da mihi intellectum, et scrutabor legem tuam, et custodiam illam in toto corde meo.",
        "Deduc me in semitam mandatorum tuorum, quia ipsam volui.",
        "Inclina cor meum in testimonia tua, et non in avaritiam.",
        "Averte oculos meos ne videant vanitatem, in via tua vivifica me.",
        "Statue servo tuo eloquium tuum in timore tuo.",
        "Amputa opprobrium meum quod suspicatus sum, quia iudicia tua iucunda.",
        "Ecce concupivi mandata tua, in aequitate tua vivifica me."
    ]
    
    private let englishText = [
        "Teach me, O Lord, the way of thy statutes; and I shall keep it unto the end.",
        "Give me understanding, and I shall keep thy law; yea, I shall observe it with my whole heart.",
        "Make me to go in the path of thy commandments; for therein do I delight.",
        "Incline my heart unto thy testimonies, and not to covetousness.",
        "Turn away mine eyes from beholding vanity; and quicken thou me in thy way.",
        "Stablish thy word unto thy servant, who is devoted to thy fear.",
        "Turn away my reproach which I fear: for thy judgments are good.",
        "Behold, I have longed after thy precepts: quicken me in thy righteousness."
    ]
    
    private let lineKeyLemmas = [
        (1, ["lex", "pono", "dominus", "via", "iustificatio", "exquiro", "semper"]),
        (2, ["do", "intellectus", "scrutor", "lex", "custodio", "cor"]),
        (3, ["deduco", "semita", "mandatum", "volo"]),
        (4, ["inclino", "cor", "testimonium", "avaritia"]),
        (5, ["averto", "oculus", "video", "vanitas", "via", "vivifico"]),
        (6, ["statuo", "servus", "eloquium", "timor"]),
        (7, ["amputo", "opprobrium", "suspicor", "iudicium", "iucundus"]),
        (8, ["ecce", "concupisco", "mandatum", "aequitas", "vivifico"])
    ]
    
    private let structuralThemes = [
        (
            "Divine Instruction → Obedience",
            "The psalmist's request for divine teaching and his commitment to keep God's law",
            ["lex", "pono", "intellectus", "custodio", "cor"],
            1,
            2,
            "The psalmist asks God to teach him His statutes and give him understanding, expressing his desire to keep and observe God's law with his whole heart.",
            "Augustine sees this as the fundamental posture of the Christian soul—seeking divine instruction and committing to obedience. The 'pono' (place/set) suggests God establishing His law in the heart, while the psalmist's whole-hearted commitment shows the cooperation of human will with divine grace."
        ),
        (
            "Heart Inclination → Divine Testimonies",
            "The psalmist's prayer for his heart to be inclined toward God's testimonies rather than covetousness",
            ["deduco", "mandatum", "volo", "inclino", "testimonium", "avaritia"],
            3,
            4,
            "The psalmist asks to be led in the path of God's commandments because he has willed it, and prays for his heart to be inclined to God's testimonies and not to covetousness.",
            "For Augustine, this represents the soul's battle between spiritual and carnal desires. The heart's inclination toward divine testimonies requires divine assistance, as the natural tendency is toward worldly vanities and covetousness."
        ),
        (
            "Protection → Divine Establishment",
            "The psalmist's request for protection from evil and divine establishment as God's servant",
            ["averto", "vanitas", "vivifico", "servus", "eloquium", "timor"],
            5,
            6,
            "The psalmist asks God to turn his eyes away from vanity and quicken him in His way, and to establish His word in His servant who fears Him.",
            "Augustine interprets this as the soul's need for divine protection from worldly distractions and its recognition of servanthood to God. The 'timor' (fear) is not servile fear but reverent awe, and the establishment of God's word comes through divine grace."
        ),
        (
            "Desire → Divine Life",
            "The psalmist's longing for God's precepts and his request for divine quickening",
            ["opprobrium", "iudicium", "concupisco", "mandatum", "aequitas", "vivifico"],
            7,
            8,
            "The psalmist asks for his reproach to be cut off and expresses his longing for God's precepts, asking to be quickened in His righteousness, recognizing that God's judgments are pleasant and good.",
            "For Augustine, this represents the soul's final movement toward complete union with God's will. The 'concupisco' (longing) is the highest form of spiritual desire, and the 'vivifico' (quicken) shows the soul's dependence on divine life for true fulfillment."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Law",
            "References to God's law, statutes, commandments, and testimonies",
            ["lex", "iustificatio", "mandatum", "testimonium", "iudicium", "eloquium"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Spiritual Guidance",
            "Requests for divine guidance, understanding, and direction",
            ["deduco", "semita", "via", "inclino", "averto", "statuo", "vivifico"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Heart and Desire",
            "Themes of heart inclination, desire, and spiritual longing",
            ["cor", "volo", "concupisco", "intellectus", "timor", "aequitas"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Protection from Evil",
            "Requests for protection from vanity, covetousness, and reproach",
            ["averto", "vanitas", "avaritia", "amputo", "opprobrium", "custodio"],
            ThemeCategory.virtue,
            1...8
        )
    ]
    
    // MARK: - Test Cases
    
    func testTotalVerses() {
        XCTAssertEqual(
            psalm118He.count, 8, "Psalm 118 He should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 He English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118He.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118He,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118He,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118He_texts.json"
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
            filename: "output_psalm118He_themes.json"
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
            psalmText: psalm118He,
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
            psalmText: psalm118He,
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
            psalmText: psalm118He,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}