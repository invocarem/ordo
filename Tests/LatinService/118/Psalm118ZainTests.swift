import XCTest
@testable import LatinService

class Psalm118ZainTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "zain")
    
    // MARK: - Test Data Properties
    private let psalm118Zain = [
        "Memor esto verbi tui servo tuo, in quo mihi spem dedisti.",
        "Haec me consolata est in humilitate mea, quia eloquium tuum vivificavit me.",
        "Superbi inique agebant usquequaque, a lege autem tua non declinavi.",
        "Memor fui iudiciorum tuorum a saeculo, Domine, et consolatus sum.",
        "Defectio tenuit me, pro peccatoribus derelinquentibus legem tuam.",
        "Cantabiles mihi erant iustificationes tuae in loco peregrinationis meae.",
        "Memor fui nocte nominis tui, Domine, et custodivi legem tuam.",
        "Hoc factum est mihi, quia iustificationes tuas exquisivi."
    ]
    
    private let englishText = [
        "Remember the word unto thy servant, upon which thou hast caused me to hope.",
        "This is my comfort in my affliction: for thy word hath quickened me.",
        "The proud have had me greatly in derision: yet have I not declined from thy law.",
        "I remembered thy judgments of old, O Lord; and have comforted myself.",
        "Horror hath taken hold upon me because of the wicked that forsake thy law.",
        "Thy statutes have been my songs in the house of my pilgrimage.",
        "I have remembered thy name, O Lord, in the night, and have kept thy law.",
        "This I had, because I kept thy precepts."
    ]
    
    private let lineKeyLemmas = [
        (1, ["memor", "verbum", "servus", "spes", "do"]),
        (2, ["hic", "consolor", "humilitas", "quia", "eloquium", "vivifico"]),
        (3, ["superbus", "inique", "ago", "usquequaque", "declino"]),
        (4, ["memor", "sum", "iudicium", "saeculum", "dominus", "consolor"]),
        (5, ["defectio", "teneo", "pro", "peccator", "derelinquo", "lex"]),
        (6, ["cantabilis", "sum", "iustificatio", "locus", "peregrinatio"]),
        (7, ["memor", "nox", "nomen", "dominus", "custodio", "lex"]),
        (8, ["hic", "facio", "quia", "iustificatio", "exquiro"])
    ]
    
    private let structuralThemes = [
        (
            "Divine Promise → Comfort",
            "The psalmist's remembrance of God's word and the comfort it brings in affliction",
            ["memor", "verbum", "servus", "spes", "consolor", "humilitas", "eloquium", "vivifico"],
            1,
            2,
            "The psalmist asks God to remember His word to His servant, in which He has given hope, and finds comfort in his affliction because God's word has quickened him.",
            "Augustine sees this as the soul's fundamental dependence on divine promises and the comfort that comes from God's word in times of trial. The 'memor esto' (remember) shows the soul's trust in God's faithfulness, while the comfort in affliction demonstrates the power of divine truth to sustain the believer."
        ),
        (
            "Adversity → Steadfastness",
            "The psalmist's faithfulness to God's law despite the derision of the proud and wicked",
            ["superbus", "inique", "ago", "usquequaque", "declino", "memor", "iudicium", "saeculum", "consolor"],
            3,
            4,
            "The proud have greatly derided the psalmist, yet he has not declined from God's law, and he remembers God's judgments of old and finds comfort in them.",
            "For Augustine, this represents the soul's steadfastness in the face of persecution and mockery. The 'non declinavi' (I have not declined) shows the believer's unwavering commitment to divine truth, while the remembrance of God's judgments provides strength and comfort in adversity."
        ),
        (
            "Horror → Song",
            "The psalmist's distress at the wicked and his finding of song in God's statutes",
            ["defectio", "teneo", "peccator", "derelinquo", "lex", "cantabilis", "iustificatio", "locus", "peregrinatio"],
            5,
            6,
            "Horror has taken hold of the psalmist because of the wicked who forsake God's law, yet God's statutes have been his songs in the house of his pilgrimage.",
            "Augustine interprets this as the soul's response to the wickedness of the world and its finding of joy in divine truth. The 'defectio' (horror) shows the believer's sensitivity to sin, while the 'cantabiles' (songs) express the joy that comes from meditating on God's law even in exile."
        ),
        (
            "Night Vigil → Obedience",
            "The psalmist's remembrance of God's name in the night and his faithful keeping of the law",
            ["memor", "nox", "nomen", "dominus", "custodio", "lex", "hic", "facio", "iustificatio", "exquiro"],
            7,
            8,
            "The psalmist has remembered God's name in the night and kept His law, and this has been his portion because he has sought God's precepts.",
            "For Augustine, this represents the highest form of spiritual discipline—the night vigil of prayer and meditation that leads to faithful obedience. The 'memor fui nocte' (I remembered in the night) shows the soul's devotion to God even in darkness, while the keeping of the law demonstrates the fruit of such devotion."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Word",
            "References to God's word, law, and judgments",
            ["verbum", "eloquium", "iustificatio", "lex", "nomen", "iudicium"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Memory",
            "Themes of remembrance and recalling",
            ["memor", "memini", "recordor", "reminiscor", "saeculum", "nox"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Comfort",
            "Expressions of consolation and hope",
            ["consolor", "vivifico", "cantabilis", "spes", "defectio", "peregrinatio"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Faithfulness",
            "Steadfastness amidst adversity and the wicked",
            ["custodio", "declino", "derelinquo", "superbus", "inique", "peccator", "teneo"],
            ThemeCategory.virtue,
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
            psalm118Zain.count, 8, "Psalm 118 Zain should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Zain English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Zain.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Zain,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Zain,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Zain_texts.json"
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
            filename: "output_psalm118Zain_themes.json"
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
            psalmText: psalm118Zain,
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
            psalmText: psalm118Zain,
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
            psalmText: psalm118Zain,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}