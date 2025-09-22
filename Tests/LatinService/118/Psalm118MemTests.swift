import XCTest
@testable import LatinService

class Psalm118MemTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "mem")
    
    // MARK: - Test Data Properties
    private let psalm118Mem = [
        "Quomodo dilexi legem tuam, Domine! tota die meditatio mea est.",
        "Super inimicos meos prudentem me fecisti mandato tuo, quia in aeternum mihi est.",
        "Super omnes docentes me intellexi, quia testimonia tua meditatio mea est.",
        "Super senes intellexi, quia mandata tua quaesivi.",
        "In omni via mala prohibui pedes meos, ut custodiam verba tua.",
        "A iudiciis tuis non declinavi, quia tu legem posuisti mihi.",
        "Quam dulcia faucibus meis eloquia tua! super mel ori meo.",
        "A mandatis tuis intellexi, propterea odivi omnem viam iniquitatis."
    ]
    
    private let englishText = [
        "O how have I loved thy law, O Lord: it is my meditation all the day.",
        "Through thy commandment thou hast made me wiser than my enemies: for it is ever with me.",
        "I have understood more than all my teachers: because thy testimonies are my meditation.",
        "I have had understanding above ancients: because I have sought thy commandments.",
        "I have restrained my feet from every evil way: that I may keep thy words.",
        "I have not declined from thy judgments: because thou hast set me a law.",
        "How sweet are thy words to my palate! more than honey to my mouth.",
        "By thy commandments I have had understanding: therefore have I hated every way of iniquity."
    ]
    
    private let lineKeyLemmas = [
        (1, ["quomodo", "diligo", "lex", "dominus", "totus", "dies", "meditatio"]),
        (2, ["super", "inimicus", "prudens", "facio", "mandatum", "quia", "aeternum"]),
        (3, ["super", "omnis", "doceo", "intellego", "quia", "testimonium", "meditatio"]),
        (4, ["super", "senex", "intellego", "quia", "mandatum", "quaero"]),
        (5, ["omnis", "via", "malus", "prohibeo", "pes", "custodio", "verbum"]),
        (6, ["iudicium", "declino", "quia", "lex", "pono"]),
        (7, ["quis", "dulcis", "faux", "eloquium", "super", "mel", "os"]),
        (8, ["mandatum", "intellego", "propterea", "odi", "omnis", "via", "iniquitas"])
    ]
    
    private let structuralThemes = [
        (
            "Love → Meditation",
            "The psalmist's deep love for God's law and his constant meditation on it",
            ["quomodo", "diligo", "lex", "dominus", "totus", "dies", "meditatio", "super", "inimicus", "prudens", "facio", "mandatum"],
            1,
            2,
            "The psalmist expresses his deep love for God's law, which is his meditation all day long, and acknowledges that through God's commandment he has been made wiser than his enemies.",
            "Augustine sees this as the soul's passionate devotion to divine truth. The 'quomodo dilexi legem tuam' (how I have loved your law) shows the believer's intense affection for God's word, while the constant meditation demonstrates the soul's complete absorption in divine wisdom."
        ),
        (
            "Understanding → Superiority",
            "The psalmist's superior understanding gained through God's testimonies and commandments",
            ["intellego", "testimonium", "meditatio", "senex", "mandatum", "quaero", "omnis", "doceo"],
            3,
            4,
            "The psalmist has understood more than all his teachers because God's testimonies are his meditation, and he has had understanding above the ancients because he has sought God's commandments.",
            "For Augustine, this represents the soul's spiritual insight gained through divine instruction. The superiority over teachers and ancients shows that divine wisdom surpasses human learning, while the seeking of commandments demonstrates the active pursuit of divine truth."
        ),
        (
            "Restraint → Preservation",
            "The psalmist's self-restraint from evil ways and his commitment to keep God's words",
            ["via", "malus", "prohibeo", "pes", "custodio", "verbum", "iudicium", "declino", "lex", "pono"],
            5,
            6,
            "The psalmist has restrained his feet from every evil way to keep God's words, and he has not declined from God's judgments because God has set him a law.",
            "Augustine interprets this as the soul's moral discipline and steadfastness. The 'prohibui pedes meos' (I have restrained my feet) shows the believer's active resistance to temptation, while the non-declining from judgments demonstrates unwavering commitment to divine truth."
        ),
        (
            "Sweetness → Hatred",
            "The psalmist's delight in God's words and his hatred of iniquity",
            ["quis", "dulcis", "faux", "eloquium", "mel", "os", "mandatum", "intellego", "propterea", "odi", "iniquitas"],
            7,
            8,
            "The psalmist finds God's words sweet to his palate, sweeter than honey to his mouth, and through God's commandments he has had understanding, therefore he has hated every way of iniquity.",
            "For Augustine, this represents the soul's complete transformation through divine truth. The sweetness of God's words shows the believer's spiritual taste, while the hatred of iniquity demonstrates the soul's moral clarity and rejection of evil that comes from divine understanding."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Law",
            "References to God's law, commandments, and testimonies",
            ["lex", "mandatum", "testimonium", "verbum", "eloquium", "iudicium"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Love and Meditation",
            "Themes of love for God's word and constant meditation",
            ["diligo", "meditatio", "quomodo", "totus", "dies", "dulcis", "mel"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Understanding and Wisdom",
            "The psalmist's superior understanding and wisdom gained through divine instruction",
            ["intellego", "prudens", "doceo", "senex", "quaero", "propterea"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Protection and Discipline",
            "Themes of moral restraint and protection from evil",
            ["prohibeo", "custodio", "declino", "super", "inimicus", "malus", "odi", "iniquitas"],
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
            psalm118Mem.count, 8, "Psalm 118 Mem should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Mem English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Mem.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Mem,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Mem,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Mem_texts.json"
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
            filename: "output_psalm118Mem_themes.json"
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
            psalmText: psalm118Mem,
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
            psalmText: psalm118Mem,
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
            psalmText: psalm118Mem,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}