import XCTest
@testable import LatinService

class Psalm118BethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "beth")
    
    // MARK: - Test Data Properties
    private let psalm118Beth = [
        "In quo corrigit adolescentior viam suam? In custodiendo sermones tuos.",
        "In toto corde meo exquisivi te, ne repellas me a mandatis tuis.",
        "In corde meo abscondi eloquia tua, ut non peccem tibi.",
        "Benedictus es, Domine, doce me iustificationes tuas.",
        "In labiis meis pronuntiavi omnia iudicia oris tui.",
        "In via testimoniorum tuorum delectatus sum, sicut in omnibus divitiis.",
        "In mandatis tuis exercebor, et considerabo vias tuas.",
        "In iustificationibus tuis meditabor, non obliviscar sermones tuos."
    ]
    
    private let englishText = [
        "Wherewith shall a young man correct his way? By observing thy words.",
        "With my whole heart have I sought after thee: let me not stray from thy commandments.",
        "Thy words have I hidden in my heart, that I may not sin against thee.",
        "Blessed art thou, O Lord: teach me thy justifications.",
        "With my lips I have pronounced all the judgments of thy mouth.",
        "I have been delighted in the way of thy testimonies, as in all riches.",
        "I will meditate on thy commandments, and I will consider thy ways.",
        "I will think of thy justifications: I will not forget thy words."
    ]
    
    private let lineKeyLemmas = [
        (1, ["corrigo", "adolescens", "custodio", "sermo"]),
        (2, ["totus", "exquiro", "repello", "mandatum"]),
        (3, ["abscondo", "eloquium", "pecco"]),
        (4, ["benedictus", "dominus", "doceo", "iustificatio"]),
        (5, ["labium", "pronuntio", "omnis", "iudicium", "os"]),
        (6, ["testimonium", "delecto", "sicut", "divitiae"]),
        (7, ["mandatum", "exerceo", "considero"]),
        (8, ["iustificatio", "meditor", "obliviscor", "sermo"])
    ]
    
    private let structuralThemes = [
        (
            "Correction → Adherence",
            "The young person's path correction through keeping God's words and pleading not to be rejected",
            ["corrigo", "adolescens", "custodio", "sermo", "repello"],
            1,
            2,
            "The psalmist asks how a young man can correct his path—by keeping God's words. He has sought God with his whole heart and begs not to be rejected ('ne repellas me') from His commandments.",
            "Augustine sees this as the beginning of spiritual life—the correction from worldly ways through adherence to God's word. The 'repello' reveals the psalmist's deep fear of divine rejection and his desperate plea to remain within God's covenant boundaries, showing the soul's recognition of its complete dependence on divine mercy."
        ),
        (
            "Treasure → Preservation",
            "Hiding God's words in the heart as protection against sin",
            ["abscondo", "eloquium", "pecco", "benedictus", "doceo"],
            3,
            4,
            "God's words are hidden in the heart to avoid sin. The psalmist blesses the Lord and asks to be taught His justifications.",
            "For Augustine, hiding God's word in the heart represents internalizing Scripture through meditation and memory. This becomes protection against temptation and the foundation for ongoing divine instruction."
        ),
        (
            "Proclamation → Delight",
            "Speaking God's judgments and delighting in His testimonies",
            ["pronuntio", "iudicium", "delecto", "testimonium", "divitiae"],
            5,
            6,
            "The psalmist has pronounced all God's judgments with his lips and delights in His testimonies as in all riches.",
            "Augustine sees this as the natural progression from internal meditation to external proclamation. The delight in God's word surpasses all earthly wealth, showing the soul's true treasure."
        ),
        (
            "Meditation → Memory",
            "Exercising in commandments and meditating on justifications without forgetting",
            ["exerceo", "mandatum", "considero", "meditor", "obliviscor"],
            7,
            8,
            "The psalmist will exercise in God's commandments, consider His ways, meditate on His justifications, and not forget His words.",
            "For Augustine, this represents the complete spiritual discipline—active engagement with God's law, contemplation of His ways, and the grace of memory that preserves divine teaching in the heart."
        )
    ];

    private let conceptualThemes = [
        (
            "Instruction",
            "Focus on correction, teaching, and meditation",
            ["corrigo", "doceo", "pronuntio", "considero", "meditor"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Delight",
            "Emphasis on delighting in God's word and blessings",
            ["delecto", "divitiae", "benedictus", "exquiro", "abscondo"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Divine Word",
            "References to God's words, statutes, and judgments",
            ["sermo", "eloquium", "iustificatio", "testimonium", "iudicium", "mandatum"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Protection",
            "Themes of guarding, protecting, and avoiding divine rejection",
            ["custodio", "repello", "abscondo", "obliviscor", "pecco", "adolescens"],
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
            psalm118Beth.count, 8, "Psalm 118 Beth should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Beth English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Beth.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Beth,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Beth,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Beth_texts.json"
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
            filename: "output_psalm118Beth_themes.json"
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
            psalmText: psalm118Beth,
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
            psalmText: psalm118Beth,
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
            psalmText: psalm118Beth,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}