import XCTest
@testable import LatinService

class Psalm8Tests: XCTestCase {
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

    // MARK: - Test Data (Psalm 8)
    let id = PsalmIdentity(number: 8, category: nil)
    private let expectedVerseCount = 9

    private let text = [
        "Domine, Dominus noster, quam admirabile est nomen tuum in universa terra!",
        "Quoniam elevata est magnificentia tua super caelos.",
        "Ex ore infantium et lactentium perfecisti laudem propter inimicos tuos: ut destruas inimicum et ultorem.",
        "Quoniam videbo caelos tuos, opera digitorum tuorum: lunam et stellas quae tu fundasti.",
        "Quid est homo quod memor es eius? aut filius hominis, quoniam visitas eum?",
        "Minuisti eum paulo minus ab angelis: gloria et honore coronasti eum. Et constituisti eum super opera manuum tuarum:",
        "Omnia subiecisti sub pedibus eius. Oves et boves universas: insuper et pecora campi.",
        "Volucres caeli, et pisces maris: qui perambulant semitas maris.",
        "Domine, Dominus noster: quam admirabile est nomen tuum in universa terra!"
    ]

    private let englishText = [
        "O Lord, our Lord, how admirable is thy name in the whole earth!",
        "For thy magnificence is elevated above the heavens.",
        "Out of the mouth of infants and of sucklings thou hast perfected praise, because of thy enemies: that thou mayst destroy the enemy and the avenger.",
        "For I will behold thy heavens, the works of thy fingers: the moon and the stars which thou hast founded.",
        "What is man that thou art mindful of him? or the son of man that thou visitest him?",
        "Thou hast made him a little less than the angels: thou hast crowned him with glory and honour. And hast set him over the works of thy hands:",
        "Thou hast subjected all things under his feet. All sheep and oxen: moreover the cattle also of the field.",
        "The birds of the air, and the fishes of the sea: that pass through the paths of the sea.",
        "O Lord, our Lord: how admirable is thy name in the whole earth!"
    ]

    private let lineKeyLemmas = [
        (1, ["dominus", "noster", "admirabilis", "nomen", "universus", "terra"]),
        (2, ["quoniam", "elevo", "magnificentia", "caelum"]),
        (3, ["os", "infans", "lactens", "perficio", "laus", "inimicus", "ultor"]),
        (4, ["video", "caelum", "opus", "digitus", "luna", "stella", "fundo"]),
        (5, ["homo", "memor", "filius", "visito"]),
        (6, ["minuo", "angelus", "gloria", "honor", "corono", "constituo", "manus"]),
        (7, ["subjicio", "pes", "ovis", "bos", "pecus", "campus"]),
        (8, ["volucris", "caelum", "piscis", "mare", "perambulo", "semita"]),
        (9, ["dominus", "noster", "admirabilis", "nomen", "universus", "terra"])
    ]

    private let structuralThemes = [
        (
            "Name → Majesty",
            "God's admirable name on earth leads to His majesty exalted above heavens",
            ["nomen", "admirabile", "magnificentia", "caelum"],
            1,
            2,
            "The psalm opens with praise for God's wonderful name throughout the earth, acknowledging His majesty elevated above the heavens.",
            "Augustine sees this as revealing God's glory both in creation and beyond, with the heavens pointing to Christ's ascension (Enarr. Ps. 8.1-2)."
        ),
        (
            "Weakness → Strength",
            "Praise from infants leads to the defeat of God's enemies",
            ["infans", "laudem", "inimicus", "destruo"],
            3,
            4,
            "God perfects praise from the mouths of infants and nursing babies, using this weakness to destroy the enemy and avenger.",
            "Augustine interprets this as Christ's humility silencing the devil through the praise of the humble Church (Enarr. Ps. 8.3-4)."
        ),
        (
            "Humanity → Glory",
            "God's remembrance of humble humanity leads to their crowning with glory",
            ["homo", "memoro", "gloria", "corono"],
            5,
            6,
            "The psalmist marvels that God remembers mere humans, making them little less than angels and crowning them with glory and honor.",
            "Augustine sees this fulfilled in Christ, the Son of Man, through whom humanity is exalted and glorified (Enarr. Ps. 8.5-6)."
        ),
        (
            "Dominion → Praise",
            "Human authority over creation circles back to praise of God's name",
            ["subjicio", "pes", "volucris", "piscis", "nomen"],
            7,
            9,
            "God subjects all creation under human feet—animals, birds, and fish—which leads back to praising God's wonderful name throughout the earth.",
            "Augustine views this dominion as fulfilled in Christ's authority over creation, with all things ultimately returning to praise God (Enarr. Ps. 8.7-9)."
        ),
    ]

    private let conceptualThemes = [
        (
            "Divine Majesty",
            "God's supreme greatness and glory manifested in creation",
            ["dominus", "magnificentia", "caelum", "admirabilis", "nomen"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Perfect Praise",
            "The completion and perfection of worship from the humble",
            ["perficio", "laus", "infans", "lactens", "os"],
            ThemeCategory.worship,
            3...4
        ),
        (
            "Divine Creation",
            "God's handiwork in the heavens and celestial bodies",
            ["opus", "digitus", "luna", "stella", "fundo", "caelum"],
            ThemeCategory.divine,
            4...4
        ),
        (
            "Human Dignity",
            "The exalted status and worth of human beings in God's plan",
            ["homo", "filius", "memor", "visito", "gloria", "honor"],
            ThemeCategory.virtue,
            5...6
        ),
        (
            "Divine Appointment",
            "God's establishment of human authority over creation",
            ["constituo", "manus", "subjicio", "pes"],
            ThemeCategory.divine,
            6...7
        ),
        (
            "Cosmic Dominion",
            "Human stewardship and authority over all living creatures",
            ["ovis", "bos", "pecus", "campus", "volucris", "piscis", "mare"],
            ThemeCategory.virtue,
            7...8
        ),
        (
            "Universal Praise",
            "The all-encompassing scope of worship and adoration",
            ["universus", "terra", "nomen", "admirabilis"],
            ThemeCategory.worship,
            1...9
        ),
        (
            "Divine Wonder",
            "The marvelous and admirable nature of God's works",
            ["admirabilis", "mirabilis", "opus", "magnificentia"],
            ThemeCategory.divine,
            1...9
        ),
    ]

    // MARK: - Test Methods

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 8 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 8 English text should have \(expectedVerseCount) verses"
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
            filename: "output_psalm8_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
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

    func testSavePsalm8Themes() {
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
            filename: "output_psalm8_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}