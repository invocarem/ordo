import XCTest

@testable import LatinService

class Psalm122Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    let id = PsalmIdentity(number: 122, category: nil)
    private let expectedVerseCount = 5

    // MARK: - Test Data Properties

    private let psalm122 = [
        "Ad te levavi oculos meos, qui habitas in caelis.",
        "Ecce sicut oculi servorum in manibus dominorum suorum,",
        "sicut oculi ancillae in manibus dominae suae: ita oculi nostri ad Dominum Deum nostrum, donec misereatur nostri.",
        "Miserere nostri, Domine, miserere nostri, quia multum repleti sumus despectione;",
        "quia multum repleta est anima nostra opprobrium abundantibus et despectio superbis.",
    ]

    private let englishText = [
        "To thee have I lifted up mine eyes, who dwellest in heaven.",
        "Behold as the eyes of servants are on the hands of their masters,",
        "As the eyes of the handmaid are on the hands of her mistress: so are our eyes unto the Lord our God, until he have mercy on us.",
        "Have mercy on us, O Lord, have mercy on us: for we are greatly filled with contempt.",
        "For our soul is greatly filled: we are a reproach to the rich, and contempt to the proud.",
    ]

    private let lineKeyLemmas = [
        (1, ["levo", "oculus", "habito", "caelum"]),
        (2, ["servus", "dominus", "manus"]),
        (3, ["ancilla", "misereor", "dominus", "deus"]),
        (4, ["misereor", "dominus", "repleo", "despectio"]),
        (5, ["repleo", "anima", "opprobrium", "abundo", "despectio", "superbus"]),
    ]

    private let structuralThemes = [
        (
            "Gaze → Servitude",
            "The lifting of eyes toward heaven is compared to the attentive gaze of a servant looking to their master's hand.",
            ["levo", "oculus", "habito", "caelum", "servus", "dominus"],
            1,
            2,
            "The psalmist directs his gaze upward to God who resides in the heavens. This posture is immediately compared to that of a servant (servus) looking to the hand of their master (dominus) for direction and provision.",
            "Augustine sees this as the soul's deepening posture after worship: first lifting its eyes to the God who dwells in heaven, then fixing them like a servant on the master's hand. This movement sets the tone for the Christian's humble vigilance after leaving the liturgy (Enarr. Ps. 122.1–2)."
        ),
        (
            "Attention → Plea",
            "The attentive gaze of a maid to her mistress leads to a persistent plea for mercy.",
            ["ancilla", "dominus", "misereor"],
            3,
            4,
            "The metaphor deepens with the image of a female servant (ancilla) looking to the hand of her mistress (domina). This sustained attention fuels the repeated cry for mercy ('Miserere nostri, Domine, miserere nostri').",
            "For Augustine, the soul's long silence and trust give way to urgent intercession. 'Miserere nostri, Domine' is not repetition, but intensification — showing a soul that still believes, but now pleads. The return to the world calls for deeper faith under pressure (Enarr. Ps. 122.3–4)."
        ),
        (
            "Contempt → Burdened Soul",
            "The soul is overwhelmed by scorn and insult from the proud, revealing the cost of faith in the world",
            ["repleo", "opprobrium", "despectio", "superbus", "abundo"],
            5,
            5,
            "The psalmist explains the reason for the desperate plea: the soul is overwhelmed, filled to the full with the contempt and reproach from those who are arrogant and abundant in pride.",
            "Augustine reads this as the soul's confession: after the heights of worship, it re-enters a world where the proud abound. The soul is repleta — filled not with grace but with contempt. The psalm ends not with resolution, but with honesty about the weight believers carry in the flesh (Enarr. Ps. 122.5)."
        ),
    ]

    private let conceptualThemes = [
        (
            "Servant Imagery",
            "Metaphors of servitude, gaze, and dependence on divine authority",
            ["servus", "ancilla", "manus", "levo", "oculus"],
            ThemeCategory.virtue,
            1...3
        ),
        (
            "Divine Presence",
            "Terms describing God's heavenly habitation and divine attributes",
            ["habito", "caelum", "dominus", "deus"],
            ThemeCategory.divine,
            1...3
        ),
        (
            "Mercy and Supplication",
            "Vocabulary of supplication, divine compassion, and soul's condition",
            ["misereor", "anima"],
            ThemeCategory.virtue,
            3...5
        ),
        (
            "Contempt and Pride",
            "Terms describing scorn, reproach, and the arrogance of the proud",
            ["despectio", "opprobrium", "repleo", "superbus", "abundo"],
            ThemeCategory.sin,
            4...5
        ),
    ]

    // MARK: - Test Methods

    func testTotalVerses() {
        XCTAssertEqual(
            psalm122.count, expectedVerseCount, "Psalm 122 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 122 English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm122.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm122,
            "Normalized Latin text should match expected classical forms"
        )
    }

    // MARK: - Line by Line Key Lemmas Test

    func testLineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm122,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testStructuralThemes() {
        utilities.testStructuralThemes(
            psalmText: psalm122,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        utilities.testConceptualThemes(
            psalmText: psalm122,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    // MARK: - Test Cases

    func testSaveTexts() {
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm122,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm122_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }

    func testSaveThemes() {
        guard
            let jsonString = utilities.generateCompleteThemesJSONString(
                psalmNumber: id.number,
                conceptualThemes: conceptualThemes,
                structuralThemes: structuralThemes
            )
        else {
            XCTFail("Failed to generate complete themes JSON")
            return
        }

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm122_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
