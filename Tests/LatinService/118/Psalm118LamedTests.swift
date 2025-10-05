import XCTest
@testable import LatinService

class Psalm118LamedTests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true
    private var latinService: LatinService!
    let id = PsalmIdentity(number: 118, category: "lamed")

    // MARK: - Test Data Properties

    private let expectedVerseCount = 8
    private let text = [
        "In aeternum, Domine, verbum tuum permanet in caelo.",
        "In generationem et generationem veritas tua; fundasti terram, et permanet.",
        "Ordinatione tua perseverat dies, quoniam omnia serviunt tibi.",
        "Nisi quod lex tua meditatio mea est, tunc forte periissem in humilitate mea.",
        "In aeternum non obliviscar iustificationes tuas, quia in ipsis vivificasti me.",
        "Tuus sum ego, salvum me fac, quoniam iustificationes tuas exquisivi.",
        "Me exspectaverunt peccatores ut perderent me; testimonia tua intellexi.",
        "Omnis consummationis vidi finem, latum mandatum tuum nimis."
    ]

    private let englishText = [
        "For ever, O Lord, thy word standeth firm in heaven.",
        "Thy truth unto all generations: thou hast founded the earth, and it continueth.",
        "By thy ordinance the day goeth on: for all things serve thee.",
        "Unless your law had been my meditation, I had then perhaps perished in my abjection.",
        "Thy justifications I will never forget: for by them thou hast given me life.",
        "I am thine, save thou me: for I have sought thy justifications.",
        "The wicked have waited for me to destroy me: but I have understood thy testimonies.",
        "I have seen an end of all perfection: thy commandment is exceeding broad."
    ]

    private let lineKeyLemmas = [
        (1, ["aeternum", "dominus", "verbum", "permaneo", "caelum"]),
        (2, ["generatio", "veritas", "fundo", "terra", "permaneo"]),
        (3, ["ordinatio", "persevero", "dies", "quoniam", "omnis", "servio"]),
        (4, ["nisi", "lex", "meditatio", "tunc", "forte", "pereo", "humilitas"]),
        (5, ["aeternum", "obliviscor", "iustificatio", "quia", "vivifico"]),
        (6, ["tuus", "sum", "salvus", "facio", "quoniam", "iustificatio", "exquiro"]),
        (7, ["exspecto", "peccator", "perdo", "testimonium", "intellego"]),
        (8, ["omnis", "consummatio", "video", "finis", "latus", "mandatum", "nimis"])
    ]


    private let structuralThemes = [
    (
        "Cosmic Foundation",
        "God's eternal word in heaven and His founding of the earth",
        ["aeternum", "dominus", "verbum", "permaneo", "caelum", "generatio", "veritas", "fundo", "terra"],
        1,
        2,
        "The psalmist declares that God's word stands firm in heaven forever, and His truth endures through all generations, having founded the earth which continues.",
        "Augustine sees this as establishing God's word as the eternal foundation of all creation. The permanence of God's word in heaven contrasts with earthly transience, while His truth provides stability across all generations."
    ),
    (
        "Temporal Sustenance", 
        "God's governance of daily cycles and the life-giving power of meditating on His law",
        ["ordinatio", "persevero", "dies", "omnis", "servio", "nisi", "lex", "meditatio", "pereo", "humilitas"],
        3,
        4,
        "By God's ordinance the day goes on, for all things serve Him. Unless God's law had been the psalmist's meditation, he would have perished in his abjection.",
        "For Augustine, this shows how God's law governs the natural order and provides spiritual sustenance. The psalmist's meditation on God's law becomes his lifeline, preventing spiritual death in times of humility and trial."
    ),
    (
        "Covenantal Life",
        "Eternal remembrance of God's justifications leading to life and salvation",
        ["aeternum", "obliviscor", "iustificatio", "vivifico", "tuus", "sum", "salvus", "facio", "exquiro"],
        5,
        6,
        "The psalmist will never forget God's justifications, for by them God has given him life. He belongs to God and asks for salvation, for he has sought God's justifications.",
        "Augustine interprets this as the soul's recognition of its dependence on God's justifications for life. The psalmist's ownership by God ('Tuus sum ego') reflects the covenant relationship, while seeking justifications shows active engagement with divine law."
    ),
    (
        "Divine Completeness",
        "Understanding God's testimonies despite opposition and recognizing the boundless nature of His commandment",
        ["exspecto", "peccator", "perdo", "testimonium", "intellego", "consummatio", "video", "finis", "latus", "mandatum"],
        7,
        8,
        "The wicked have waited to destroy the psalmist, but he has understood God's testimonies. He has seen an end of all perfection, but God's commandment is exceedingly broad.",
        "Augustine sees this as the contrast between human limitations and divine completeness. While human perfection has limits, God's commandment encompasses all things, providing infinite scope for spiritual growth and understanding."
    ),
]
    private let conceptualThemes = [
        (
            "Eternal Truth",
            "God's eternal word and truth that endures through all generations",
            ["aeternum", "verbum", "permaneo", "generatio", "veritas", "fundo"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Divine Governance",
            "God's ordinance and law governing all creation and providing spiritual sustenance",
            ["ordinatio", "persevero", "servio", "lex", "meditatio"],
            ThemeCategory.divine,
            3...4
        ),
        (
            "Life and Salvation",
            "God's justifications as the source of life and the psalmist's plea for salvation",
            ["vivifico", "iustificatio", "salvus", "tuus", "exquiro"],
            ThemeCategory.divine,
            5...6
        ),
        (
            "Understanding and Wisdom",
            "Understanding God's testimonies and recognizing the breadth of His commandment",
            ["intellego", "testimonium", "consummatio", "video", "latus", "mandatum"],
            ThemeCategory.virtue,
            7...8
        ),
        (
            "Opposition and Protection",
            "Wicked opposition and divine protection through understanding",
            ["exspecto", "peccator", "perdo", "intellego"],
            ThemeCategory.conflict,
            7...7
        ),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Test Cases

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 118 Lamed should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 118 Lamed English text should have \(expectedVerseCount) verses"
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
            filename: "output_psalm118Lamed_texts.json"
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
            filename: "output_psalm118Lamed_themes.json"
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

    // MARK: - Original Thematic Tests (kept for backward compatibility)
    
    func testEternalWordTheme() {
        let eternalTerms = [
            ("aeternum", ["aeternum"], "forever"),
            ("permaneo", ["permanet"], "remain"),
            ("generatio", ["generationem"], "generation"),
            ("veritas", ["veritas"], "truth"),
            ("ordinatio", ["ordinatione"], "ordinance"),
            ("persevero", ["perseverat"], "persevere")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: eternalTerms,
            verbose: verbose
        )
    }
    
    func testDivineCreationTheme() {
        let creationTerms = [
            ("fundo", ["fundasti"], "found"),
            ("terra", ["terram"], "earth"),
            ("caelum", ["caelo"], "heaven"),
            ("servio", ["serviunt"], "serve"),
            ("omnis", ["omnia"], "all"),
            ("ordinatio", ["ordinatione"], "ordinance")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: creationTerms,
            verbose: verbose
        )
    }
    
    func testSalvationTheme() {
        let salvationTerms = [
            ("vivifico", ["vivificasti"], "give life"),
            ("salvus", ["salvum"], "save"),
            ("facio", ["fac"], "make"),
            ("pereo", ["periissem"], "perish"),
            ("humilitas", ["humilitate"], "humility"),
            ("obliviscor", ["obliviscar"], "forget")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: salvationTerms,
            verbose: verbose
        )
    }
    
    func testUnderstandingTheme() {
        let understandingTerms = [
            ("intellego", ["intellexi"], "understand"),
            ("meditatio", ["meditatio"], "meditation"),
            ("exquiro", ["exquisivi"], "seek"),
            ("video", ["vidi"], "see"),
            ("finis", ["finem"], "end"),
            ("consummatio", ["consummationis"], "perfection"),
            ("latus", ["latum"], "broad")
        ]
        
        let utilities = PsalmTestUtilities.self
        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: understandingTerms,
            verbose: verbose
        )
    }
}