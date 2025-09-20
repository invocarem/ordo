@testable import LatinService
import XCTest

class Psalm133Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 133, category: "")

    // MARK: - Test Data Properties

    private let psalm133 = [
        "Ecce nunc benedicite Dominum, omnes servi Domini:",
        "Qui statis in domo Domini, in atriis domus Dei nostri.",
        "In noctibus extollite manus vestras in sancta, et benedicite Dominum.",
        "Benedicat te Dominus ex Sion, qui fecit caelum et terram.",
    ]

    private let englishText = [
        "Behold now bless ye the Lord, all ye servants of the Lord:",
        "Who stand in the house of the Lord, in the courts of the house of our God.",
        "In the nights lift up your hands to the holy places, and bless ye the Lord.",
        "May the Lord out of Sion bless thee, he that made heaven and earth.",
    ]

    private let lineKeyLemmas = [
        (1, ["ecce", "nunc", "benedico", "dominus", "omnis", "servus"]),
        (2, ["qui", "sto", "domus", "dominus", "atrium", "domus", "deus", "noster"]),
        (3, ["nox", "extollo", "manus", "vester", "sanctus", "benedico", "dominus"]),
        (4, ["benedico", "dominus", "ex", "sion", "qui", "facio", "caelum", "terra"]),
    ]

    private let structuralThemes = [
        (
            "Call → Standing",
            "Summon into active, vigilant worship",
            ["ecce", "nunc", "benedico", "sto", "domus", "servus"],
            1,
            2,
            "The psalm opens with a call: 'Behold now, bless the Lord, all you servants.' This is answered by their standing in the house of the Lord, a posture of vigilance and consecration. Worship is not passive but active, and standing symbolizes readiness and faithfulness, especially in the night watches.",
            "Augustine emphasizes that 'blessing the Lord' is not adding anything to Him, but aligning the soul with divine praise. To stand in His house means interior stability and perseverance in service, lifting the heart continually toward God (Enarr. Ps. 133.1–2)."
        ),
        (
            "Night Prayer → Blessing",
            "Darkness transfigured into ascent, crowned by God's cosmic blessing",
            ["nox", "extollo", "manus", "sanctus", "benedico", "caelum", "terra"],
            3,
            4,
            "The night, often a time of rest, becomes here a moment of prayerful ascent: hands lifted in holiness. The psalm concludes with blessing flowing not just from Zion, but from the Lord who made heaven and earth, grounding all worship in His creative power.",
            "For Augustine, nocturnal prayer symbolizes the Church in pilgrimage, persevering in faith amid darkness. The final blessing comes from the Creator Himself, showing that holiness derives not from the temple, but from the God who sanctifies it (Enarr. Ps. 133.3–4)."
        ),
    ]

    private let conceptualThemes = [
        (
            "Sacred Service",
            "Service in holy places and worship settings",
            ["servus", "domus", "atrium", "benedico", "sanctus", "sion"],
            ThemeCategory.worship,
            1...4
        ),
        (
            "Divine Majesty",
            "God's creative power and sovereignty",
            ["dominus", "deus", "facio", "caelum", "terra"],
            ThemeCategory.divine,
            1...4
        ),
        (
            "Worship Posture",
            "Physical acts of worship",
            ["extollo", "manus", "nox"],
            ThemeCategory.worship,
            1...3
        ),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Test Methods

    func testTotalVerses() {
        let expectedVerseCount = 4
        XCTAssertEqual(
            psalm133.count, expectedVerseCount, "Psalm 133 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 133 English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm133.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm133,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm133,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testStructuralThemes() {
        let utilities = PsalmTestUtilities.self
        utilities.testStructuralThemes(
            psalmText: psalm133,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        let utilities = PsalmTestUtilities.self
        utilities.testConceptualThemes(
            psalmText: psalm133,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm133,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm133_texts.json"
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
            filename: "output_psalm133_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
