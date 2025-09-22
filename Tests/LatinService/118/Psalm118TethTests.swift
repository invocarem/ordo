import XCTest
@testable import LatinService

class Psalm118TethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "teth")
    
    // MARK: - Test Data Properties
    private let psalm118Teth = [
        "Bonitatem fecisti cum servo tuo, Domine, secundum verbum tuum.",
        "Bonitatem et disciplinam et scientiam doce me, quia mandatis tuis credidi.",
        "Priusquam humiliarer ego deliqui, propterea eloquium tuum custodivi.",
        "Bonus es tu, et in bonitate tua doce me iustificationes tuas.",
        "Multiplicata est super me iniquitas superborum, ego autem in toto corde meo scrutabor mandata tua.",
        "Coagulatum est sicut lac cor eorum, ego vero legem tuam meditatus sum.",
        "Bonum mihi quia humiliasti me, ut discam iustificationes tuas.",
        "Bonum mihi lex oris tui, super milia auri et argenti."
    ]
    
    private let englishText = [
        "Thou hast done good to thy servant, O Lord: according to thy word.",
        "Teach me goodness and discipline and knowledge: for I have believed thy commandments.",
        "Before I was humbled I offended: therefore have I kept thy word.",
        "Thou art good: and in thy goodness teach me thy justifications.",
        "The iniquity of the proud hath been multiplied over me: but I will seek thy commandments with my whole heart.",
        "Their heart is curdled like milk: but I have meditated on thy law.",
        "It is good for me that thou hast humbled me: that I may learn thy justifications.",
        "The law of thy mouth is good to me: above thousands of gold and silver."
    ]
    
    private let lineKeyLemmas = [
        (1, ["bonitas", "facio", "servus", "dominus", "verbum"]),
        (2, ["bonitas", "disciplina", "scientia", "doceo", "mandatum", "credo"]),
        (3, ["priusquam", "humilio", "delinquo", "propterea", "eloquium", "custodio"]),
        (4, ["bonus", "sum", "bonitas", "doceo", "iustificatio"]),
        (5, ["multiplico", "iniquitas", "superbus", "totus", "cor", "scrutor", "mandatum"]),
        (6, ["coagulo", "lac", "cor", "lex", "meditor"]),
        (7, ["bonus", "humilio", "disco", "iustificatio"]),
        (8, ["bonus", "lex", "os", "mille", "aurum", "argentum"])
    ]
    
    private let structuralThemes = [
        (
            "Goodness → Teaching",
            "The psalmist's recognition of God's goodness and his plea to be taught goodness, discipline, and knowledge",
            ["bonitas", "facio", "servus", "dominus", "verbum", "disciplina", "scientia", "doceo", "mandatum", "credo"],
            1,
            2,
            "The psalmist acknowledges that God has done good to His servant according to His word, and he asks to be taught goodness, discipline, and knowledge because he has believed God's commandments.",
            "Augustine sees this as the soul's recognition of divine beneficence and its desire for comprehensive spiritual formation. The 'bonitatem fecisti' (you have done good) shows the believer's gratitude for divine favor, while the request for teaching demonstrates the soul's hunger for complete instruction in divine wisdom."
        ),
        (
            "Offense → Preservation",
            "The psalmist's acknowledgment of his past offense and his commitment to keep God's word",
            ["priusquam", "humilio", "delinquo", "propterea", "eloquium", "custodio", "bonus", "sum", "bonitas", "doceo"],
            3,
            4,
            "Before the psalmist was humbled, he offended, but therefore he has kept God's word, and he acknowledges that God is good and asks to be taught God's justifications in His goodness.",
            "For Augustine, this represents the soul's honest confession of sin and its recognition that divine discipline leads to greater faithfulness. The 'priusquam humiliarer ego deliqui' (before I was humbled I offended) shows the believer's self-awareness, while the keeping of God's word demonstrates the fruit of divine correction."
        ),
        (
            "Multiplication → Meditation",
            "The psalmist's response to the multiplied iniquity of the proud through whole-hearted seeking and meditation on God's law",
            ["multiplico", "iniquitas", "superbus", "totus", "cor", "scrutor", "mandatum", "coagulo", "lac", "lex", "meditor"],
            5,
            6,
            "The iniquity of the proud has been multiplied over the psalmist, but he will seek God's commandments with his whole heart, while their heart is curdled like milk, but he has meditated on God's law.",
            "Augustine interprets this as the soul's steadfastness in the face of external corruption. The 'multiplicata est super me iniquitas superborum' (the iniquity of the proud has been multiplied over me) shows the believer's awareness of surrounding evil, while the whole-hearted seeking and meditation demonstrate the soul's commitment to divine truth despite external pressures."
        ),
        (
            "Humiliation → Value",
            "The psalmist's recognition that divine humiliation is good for learning and that God's law is more valuable than gold and silver",
            ["bonus", "humilio", "disco", "iustificatio", "lex", "os", "mille", "aurum", "argentum"],
            7,
            8,
            "It is good for the psalmist that God has humbled him so he may learn God's justifications, and God's law is good to him, above thousands of gold and silver.",
            "For Augustine, this represents the soul's mature understanding of divine pedagogy and the supreme value of divine truth. The 'bonum mihi quia humiliasti me' (it is good for me that you have humbled me) shows the believer's acceptance of divine discipline, while the comparison with gold and silver demonstrates the incomparable worth of divine instruction."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Goodness",
            "References to God's goodness and beneficence",
            ["bonitas", "bonus", "facio", "sum", "disciplina", "scientia"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Teaching and Learning",
            "Themes of divine instruction and the psalmist's desire to learn",
            ["doceo", "disco", "scientia", "disciplina", "iustificatio", "lex"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Humility and Discipline",
            "The psalmist's experience of divine discipline and its benefits",
            ["humilio", "delinquo", "priusquam", "propterea", "custodio"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Value and Worth",
            "The supreme value of divine law and instruction",
            ["bonus", "lex", "mille", "aurum", "argentum", "meditor", "scrutor"],
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
            psalm118Teth.count, 8, "Psalm 118 Teth should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Teth English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Teth.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Teth,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Teth,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Teth_texts.json"
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
            filename: "output_psalm118Teth_themes.json"
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
            psalmText: psalm118Teth,
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
            psalmText: psalm118Teth,
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
            psalmText: psalm118Teth,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}
