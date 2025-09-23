import XCTest
@testable import LatinService

class Psalm136Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 136, category: "")
    
    // MARK: - Test Data Properties
    private let psalm136 = [
        "Super flumina Babylonis, illic sedimus et flevimus: cum recordaremur Sion.",
        "In salicibus in medio eius, suspendimus organa nostra.",
        "Quia illic interrogaverunt nos, qui captivos duxerunt nos, verba cantionum.",
        "Et qui abduxerunt nos: Hymnum cantate nobis de canticis Sion.",
        "Quomodo cantabimus canticum Domini in terra aliena?",
        
        "Si oblitus fuero tui, Ierusalem, oblivioni detur dextera mea.",
        "Adhaereat lingua mea faucibus meis, si non meminero tui: ",
        "Si non proposuero Ierusalem, in principio laetitiae meae.",
        "Memor esto, Domine, filiorum Edom, in die Ierusalem: ",
        "qui dicunt: Exinanite, exinanite usque ad fundamentum in ea.",
        
        "Filia Babylonis misera: beatus qui retribuet tibi retributionem tuam, quam retribuisti nobis.",
        "Beatus qui tenebit, et allidet parvulos tuos ad petram."
    ]
    
    private let englishText = [
        "Upon the rivers of Babylon, there we sat and wept: when we remembered Sion.",
        "On the willows in the midst thereof we hung up our instruments.",
        "For there they that led us into captivity required of us the words of songs.",
        "And they that carried us away, said: Sing ye to us a hymn of the songs of Sion.",
        "How shall we sing the song of the Lord in a strange land?",
        "If I forget thee, O Jerusalem, let my right hand be forgotten.",
        "Let my tongue cleave to my jaws, if I do not remember thee:",
        "If I make not Jerusalem the beginning of my joy.",
        "Be mindful, O Lord, of the children of Edom, in the day of Jerusalem:",
        "Who say: Rase it, rase it, even to the foundation thereof.",
        "O daughter of Babylon, miserable: blessed shall he be who shall repay thee thy payment which thou hast paid us.",
        "Blessed be he that shall take and dash thy little ones against the rock."
    ]
    
    private let lineKeyLemmas = [
        (1, ["flumen", "babylon", "sedeo", "fleo", "recordor", "sion"]),
        (2, ["salix", "suspendo", "organum"]),
        (3, ["interrogo", "captivus", "duco", "verbum", "cantio"]),
        (4, ["abduco", "hymnus", "canto", "canticum", "sion"]),
        (5, ["canto", "canticum", "dominus", "terra", "alienus"]),
        (6, ["obliviscor", "ierusalem", "oblivio", "dexter"]),
        (7, ["adhaereo", "lingua", "faux", "memini"]),
        (8, ["propono", "ierusalem", "principium", "laetitia"]),
        (9, ["memor", "dominus", "filius", "edom", "dies", "ierusalem"]),
        (10, ["dico", "exinanio", "fundamentum"]),
        (11, ["filia", "babylon", "miser", "beatus", "retributio", "retribuo"]),
        (12, ["beatus", "teneo", "allido", "parvulus", "petra"])
    ]
    
    private let structuralThemes = [
        (
            "Exile → Paralysis",
            "Displacement in Babylon leading to emotional and spiritual suspension",
            ["flumen", "babylon", "sedeo", "fleo", "recordor", "sion", "salix", "suspendo", "organum"],
            1,
            2,
            "The psalmist describes sitting and weeping by the rivers of Babylon while remembering Zion, and hanging up their instruments on the willows.",
            "Augustine sees this as the soul's experience of spiritual exile and the suspension of joyful worship. The rivers represent the flow of worldly concerns, while the hanging of instruments shows the soul's inability to praise God in a foreign land."
        ),
        (
            "Mockery → Defiance",
            "Captors' demands for songs contrasted with theological resistance",
            ["interrogo", "captivus", "duco", "verbum", "cantio", "abduco", "hymnus", "canto", "canticum", "sion"],
            3,
            4,
            "The captors interrogate the exiles for songs and demand hymns of Zion, but the psalmist questions how they can sing the Lord's song in a foreign land.",
            "For Augustine, this represents the soul's resistance to profaning sacred worship. The captors' demands show the world's attempt to corrupt divine praise, while the question demonstrates the believer's refusal to compromise spiritual integrity."
        ),
        (
            "Sacred Music → Refusal",
            "The impossibility of singing sacred songs in a foreign land",
            ["canto", "canticum", "dominus", "terra", "alienus", "obliviscor", "ierusalem", "oblivio", "dexter"],
            5,
            6,
            "The psalmist questions how to sing the Lord's song in a foreign land and swears never to forget Jerusalem, even if his right hand should be forgotten.",
            "Augustine interprets this as the soul's absolute commitment to divine worship. The question about singing shows the impossibility of true worship in exile, while the oath demonstrates the believer's unwavering loyalty to the heavenly Jerusalem."
        ),
        (
            "Tongue → Joy",
            "The psalmist's vow about his tongue contrasted with making Jerusalem the beginning of joy",
            ["adhaereo", "lingua", "faux", "memini", "propono", "ierusalem", "principium", "laetitia"],
            7,
            8,
            "The psalmist vows that his tongue will cleave to his jaws if he forgets Jerusalem, and declares that if he does not make Jerusalem the beginning of his joy, his tongue will cleave to his jaws.",
            "Augustine sees this as the soul's complete identification with divine worship. The tongue imagery shows the believer's total commitment to divine praise, while the joy in Jerusalem demonstrates the soul's alignment with God's dwelling place."
        ),
        (
            "Destruction → Imprecation",
            "Edom's violence contrasted with prophetic curse and divine justice",
            ["memor", "dominus", "filius", "edom", "dies", "ierusalem", "dico", "exinanio", "fundamentum"],
            9,
            10,
            "The psalmist calls on God to remember the children of Edom in the day of Jerusalem, and describes how they say to rase it to the foundation.",
            "Augustine sees this as the soul's complete identification with divine justice. The call to remember Edom shows the believer's alignment with God's judgment against the enemies of His people, while the imprecation demonstrates the soul's commitment to divine retribution."
        ),
        (
            "Infants → Divine Justice",
            "The destruction of helpless victims contrasted with divine retribution",
            ["filia", "babylon", "miser", "beatus", "retributio", "retribuo", "teneo", "allido", "parvulus", "petra"],
            11,
            12,
            "The psalmist calls Babylon's daughter miserable and blesses those who will repay her, and blesses those who will dash her little ones against the rock.",
            "Augustine interprets this allegorically as the destruction of sinful desires. The infants represent the offspring of Babylon (worldly desires) that must be dashed against Christ the Rock, while the blessing shows the divine justice that destroys evil at its source."
        )
    ];

    private let conceptualThemes = [
        (
            "Exile and Captivity",
            "Themes of displacement and foreign oppression",
            ["flumen", "babylon", "captivus", "duco", "abduco", "terra", "alienus"],
            ThemeCategory.sin,
            1...12
        ),
        (
            "Sacred Music and Worship",
            "References to songs, hymns, and musical instruments",
            ["organum", "cantio", "hymnus", "canto", "canticum", "dominus"],
            ThemeCategory.worship,
            1...12
        ),
        (
            "Memory and Remembrance",
            "Themes of remembering and not forgetting",
            ["recordor", "memini", "memor", "obliviscor", "oblivio", "propono"],
            ThemeCategory.virtue,
            1...12
        ),
        (
            "Jerusalem and Zion",
            "References to the holy city and spiritual homeland",
            ["sion", "ierusalem", "principium", "laetitia"],
            ThemeCategory.divine,
            1...12
        ),
        (
            "Divine Justice and Retribution",
            "God's judgment and repayment of evil",
            ["beatus", "retributio", "retribuo", "allido", "petra", "exinanio", "fundamentum"],
            ThemeCategory.divine,
            1...12
        ),
        (
            "Enemy Nations",
            "References to opposing nations and peoples",
            ["edom", "babylon", "filia", "filius", "miser"],
            ThemeCategory.sin,
            1...12
        ),
        (
            "Body Parts and Physical Imagery",
            "References to physical body parts in spiritual context",
            ["lingua", "faux", "dexter", "parvulus"],
            ThemeCategory.virtue,
            1...12
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
            psalm136.count, 12, "Psalm 136 should have 12 verses"
        )
        XCTAssertEqual(
            englishText.count, 12,
            "Psalm 136 English text should have 12 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm136.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm136,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm136,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm136_texts.json"
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
            filename: "output_psalm136_themes.json"
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
            psalmText: psalm136,
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
            psalmText: psalm136,
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
            psalmText: psalm136,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}
