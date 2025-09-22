import XCTest
@testable import LatinService

class Psalm118JodTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "jod")
    
    // MARK: - Test Data Properties
    private let psalm118Jod = [
        "Manus tuae fecerunt me, et plasmaverunt me; da mihi intellectum, et discam mandata tua.",
        "Qui timent te, videbunt me et laetabuntur, quia in verba tua supersperavi.",
        "Cognovi, Domine, quia aequitas iudicia tua, et in veritate tua humiliasti me.",
        "Fiat misericordia tua ut consoletur me, secundum eloquium tuum servo tuo.",
        "Veniant mihi miserationes tuae, et vivam, quia lex tua meditatio mea est.",
        "Confundantur superbi, quia iniuste iniquitatem fecerunt in me; ego autem exercebor in mandatis tuis.",
        "Convertantur mihi timentes te, et qui noverunt testimonia tua.",
        "Fiat cor meum immaculatum in iustificationibus tuis, ut non confundar."
    ]
    
    private let englishText = [
        "Thy hands have made me and fashioned me; give me understanding, and I will learn thy commandments.",
        "They that fear thee shall see me and be glad, because I have hoped exceedingly in thy words.",
        "I know, O Lord, that thy judgments are righteousness, and in thy truth thou hast humbled me.",
        "Let thy mercy be to comfort me, according to thy word unto thy servant.",
        "Let thy tender mercies come unto me, that I may live; for thy law is my meditation.",
        "Let the proud be put to shame, for they have dealt unjustly with me; but I will meditate on thy commandments.",
        "Let those that fear thee turn unto me, and they that know thy testimonies.",
        "Let my heart be perfect in thy statutes, that I be not put to shame."
    ]
    
    private let lineKeyLemmas = [
        (1, ["manus", "facio", "plasmo", "intellectus", "disco", "mandatum"]),
        (2, ["timeo", "video", "laetor", "quia", "verbum", "superspero"]),
        (3, ["cognosco", "dominus", "aequitas", "iudicium", "veritas", "humilio"]),
        (4, ["fio", "misericordia", "consolor", "eloquium", "servus"]),
        (5, ["venio", "miseratio", "vivo", "lex", "meditatio"]),
        (6, ["confundo", "superbus", "iniuste", "iniquitas", "facio", "exerceo", "mandatum"]),
        (7, ["converto", "timeo", "nosco", "testimonium"]),
        (8, ["fio", "cor", "immaculatus", "iustificatio", "confundo"])
    ]
    
    private let structuralThemes = [
        (
            "Creation → Understanding",
            "The psalmist's recognition of God as creator and his plea for understanding to learn God's commandments",
            ["manus", "facio", "plasmo", "intellectus", "disco", "mandatum"],
            1,
            2,
            "The psalmist acknowledges that God's hands have made and fashioned him, and he asks for understanding to learn God's commandments, while those who fear God will see him and be glad because he has hoped exceedingly in God's words.",
            "Augustine sees this as the soul's recognition of its divine origin and its need for grace to understand divine truth. The 'manus tuae fecerunt me' (your hands have made me) shows the believer's awareness of being God's creation, while the plea for understanding demonstrates the necessity of divine illumination for spiritual learning."
        ),
        (
            "Knowledge → Humility",
            "The psalmist's knowledge of God's righteous judgments and his experience of being humbled by God's truth",
            ["cognosco", "aequitas", "iudicium", "veritas", "humilio", "misericordia", "consolor"],
            3,
            4,
            "The psalmist knows that God's judgments are righteousness and that God has humbled him in His truth, and he asks that God's mercy comfort him according to His word to His servant.",
            "For Augustine, this represents the soul's growth in wisdom through divine instruction. The knowledge of God's righteous judgments leads to humility, while the request for mercy shows the believer's dependence on divine comfort in the process of spiritual formation."
        ),
        (
            "Life → Meditation",
            "The psalmist's desire for God's tender mercies to live and his commitment to meditate on God's law",
            ["miseratio", "vivo", "lex", "meditatio", "confundo", "superbus", "iniuste", "exerceo"],
            5,
            6,
            "The psalmist asks that God's tender mercies come to him so he may live, for God's law is his meditation, and he prays that the proud be put to shame for dealing unjustly with him while he will meditate on God's commandments.",
            "Augustine interprets this as the soul's recognition that true life comes from divine mercy and that meditation on God's law provides strength against injustice. The 'lex tua meditatio mea est' (your law is my meditation) shows the believer's commitment to divine truth as the source of life and protection."
        ),
        (
            "Community → Perfection",
            "The psalmist's desire for fellowship with the faithful and his prayer for a perfect heart in God's statutes",
            ["converto", "timeo", "nosco", "testimonium", "fio", "cor", "immaculatus", "iustificatio"],
            7,
            8,
            "The psalmist prays that those who fear God turn to him and that those who know God's testimonies come to him, and he asks that his heart be perfect in God's statutes so he will not be put to shame.",
            "For Augustine, this represents the soul's desire for communion with the faithful and its prayer for moral perfection. The turning of the faithful shows the believer's longing for spiritual fellowship, while the prayer for a perfect heart demonstrates the soul's aspiration to complete conformity to divine will."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Creation",
            "References to God as creator and fashioner",
            ["manus", "facio", "plasmo", "intellectus", "disco"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Understanding and Learning",
            "Themes of seeking understanding and learning God's commandments",
            ["intellectus", "disco", "mandatum", "cognosco", "nosco"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Mercy and Comfort",
            "Expressions of divine mercy and the need for comfort",
            ["misericordia", "consolor", "miseratio", "vivo", "aequitas"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Community and Fellowship",
            "The fellowship of believers and shared knowledge of God",
            ["timeo", "video", "laetor", "converto", "nosco", "testimonium"],
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
            psalm118Jod.count, 8, "Psalm 118 Jod should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Jod English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Jod.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Jod,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Jod,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Jod_texts.json"
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
            filename: "output_psalm118Jod_themes.json"
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
            psalmText: psalm118Jod,
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
            psalmText: psalm118Jod,
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
            psalmText: psalm118Jod,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}
