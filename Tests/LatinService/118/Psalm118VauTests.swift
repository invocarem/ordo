import XCTest
@testable import LatinService

class Psalm118VauTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "vau")
    
    // MARK: - Test Data
    private let psalm118Vau = [
        "Et veniat super me misericordia tua, Domine, salutare tuum secundum eloquium tuum.",
        "Et respondebo exprobrantibus mihi verbum, quia speravi in sermonibus tuis.",
        "Et ne auferas de ore meo verbum veritatis usquequaque, quia in iudiciis tuis supersperavi.",
        "Et custodiam legem tuam semper, in saeculum et in saeculum saeculi.",
        "Et ambulabam in latitudine, quia mandata tua exquisivi.",
        "Et loquebar de testimoniis tuis in conspectu regum, et non confundebar.",
        "Et meditabar in mandatis tuis, quae dilexi.",
        "Et levavi manus meas ad mandata tua quae dilexi, et exercebar in iustificationibus tuis."
    ]
    
    private let englishText = [
        "Let thy mercies come also unto me, O Lord, even thy salvation, according to thy word.",
        "So shall I have wherewith to answer him that reproacheth me: for I trust in thy word.",
        "And take not the word of truth utterly out of my mouth; for I have hoped in thy judgments.",
        "So shall I keep thy law continually for ever and ever.",
        "And I will walk at liberty: for I seek thy precepts.",
        "I will speak of thy testimonies also before kings, and will not be ashamed.",
        "And I will delight myself in thy commandments, which I have loved.",
        "My hands also will I lift up unto thy commandments, which I have loved; and I will meditate in thy statutes."
    ]
    
    private let lineKeyLemmas = [
        (1, ["venio", "super", "misericordia", "dominus", "salutare", "secundum", "eloquium"]),
        (2, ["respondeo", "exprobro", "verbum", "spero", "sermo"]),
        (3, ["aufero", "os", "verbum", "veritas", "usquequaque", "iudicium", "superspero"]),
        (4, ["custodio", "lex", "semper", "saeculum"]),
        (5, ["ambulo", "latitudo", "mandatum", "exquiro"]),
        (6, ["loquor", "testimonium", "conspectus", "rex", "confundo"]),
        (7, ["meditor", "mandatum", "diligo"]),
        (8, ["levo", "manus", "mandatum", "diligo", "exerceo", "iustificatio"])
    ]
    
    private let structuralThemes = [
        (
            "Divine Mercy → Trust",
            "The psalmist's request for divine mercy and his trust in God's word",
            ["venio", "misericordia", "salutare", "eloquium", "spero", "sermo"],
            1,
            2,
            "The psalmist asks for God's mercy and salvation to come upon him according to His word, and expresses his trust in God's word as he responds to those who reproach him.",
            "Augustine sees this as the soul's fundamental dependence on divine mercy and its trust in God's promises. The 'veniat' (let it come) shows the soul's openness to divine grace, while 'speravi' (I have hoped) demonstrates the faith that undergirds all spiritual life."
        ),
        (
            "Truth Preservation → Eternal Obedience",
            "The psalmist's plea for truth to remain in his mouth and his commitment to eternal obedience",
            ["aufero", "verbum", "veritas", "usquequaque", "custodio", "lex", "semper", "saeculum"],
            3,
            4,
            "The psalmist asks that the word of truth not be taken from his mouth, for he has hoped in God's judgments, and commits to keeping God's law continually forever.",
            "For Augustine, this represents the soul's desire to be preserved in truth and its commitment to eternal obedience. The 'usquequaque' (utterly) shows the completeness of the psalmist's dependence on divine truth, while 'saeculum saeculi' (forever and ever) expresses the eternal nature of God's law."
        ),
        (
            "Liberty → Bold Witness",
            "The psalmist's experience of walking in liberty and his bold witness before kings",
            ["ambulo", "latitudo", "mandatum", "exquiro", "loquor", "testimonium", "rex", "confundo"],
            5,
            6,
            "The psalmist walks at liberty because he seeks God's precepts, and speaks of God's testimonies before kings without being ashamed.",
            "Augustine interprets this as the true freedom that comes from obedience to God's law and the boldness that flows from divine confidence. The 'latitudine' (liberty) is not license but the freedom of the soul that walks in God's ways, while the bold witness before kings shows the power of divine truth."
        ),
        (
            "Love → Devotion",
            "The psalmist's love for God's commandments and his devoted meditation",
            ["meditor", "mandatum", "diligo", "levo", "manus", "exerceo", "iustificatio"],
            7,
            8,
            "The psalmist delights in and loves God's commandments, lifting up his hands to them and meditating in God's statutes.",
            "For Augustine, this represents the highest form of spiritual life—love for God's law that leads to devoted meditation and active engagement. The 'dilexi' (I have loved) shows the heart's affection for divine truth, while the lifting of hands and meditation express the soul's complete devotion to God's will."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Mercy and Salvation",
            "References to God's mercy, salvation, and trust in His word",
            ["misericordia", "salutare", "eloquium", "spero", "superspero", "venio"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Word and Truth",
            "Emphasis on God's word, truth, and testimonies",
            ["verbum", "veritas", "eloquium", "sermo", "testimonium", "mandatum"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Faithful Obedience",
            "Themes of keeping, walking, seeking, and meditating on God's law",
            ["custodio", "ambulo", "exquiro", "loquor", "meditor", "exerceo", "levo"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Protection and Confidence",
            "Requests for protection and expressions of confidence in God",
            ["respondeo", "confundo", "rex", "conspectus", "usquequaque", "latitudo"],
            ThemeCategory.virtue,
            1...8
        )
    ]
    
    // MARK: - Test Cases
    
    func testTotalVerses() {
        XCTAssertEqual(
            psalm118Vau.count, 8, "Psalm 118 Vau should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Vau English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Vau.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Vau,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Vau,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Vau_texts.json"
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
            filename: "output_psalm118Vau_themes.json"
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
            psalmText: psalm118Vau,
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
            psalmText: psalm118Vau,
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
            psalmText: psalm118Vau,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}