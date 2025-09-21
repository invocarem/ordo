import XCTest
@testable import LatinService

class Psalm118DalethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 4
    let id = PsalmIdentity(number: 118, category: "daleth")
    
    // MARK: - Test Data Properties
    private let psalm118Daleth = [
        "Adhaesit pavimento anima mea, vivifica me secundum verbum tuum.",
        "Vias meas enuntiavi, et exaudisti me; doce me iustificationes tuas.",
        "Viam iustificationum tuarum instrue me, et exercebor in mirabilibus tuis.",
        "Dormitavit anima mea prae taedio, confirma me in verbis tuis.",
        "Viam iniquitatis amove a me, et de lege tua miserere mei.",
        "Viam veritatis elegi, iudicia tua non sum oblitus.",
        "Adhaesi testimoniis tuis, Domine, noli me confundere.",
        "Viam mandatorum tuorum cucurri, cum dilatasti cor meum."
    ]
    
    private let englishText = [
        "My soul cleaveth unto the dust: quicken thou me according to thy word.",
        "I have declared my ways, and thou heardest me: teach me thy statutes.",
        "Make me to understand the way of thy precepts: so shall I meditate on thy wondrous works.",
        "My soul melteth away for heaviness: strengthen thou me according unto thy word.",
        "Remove from me the way of lying: and grant me thy law graciously.",
        "I have chosen the way of truth: thy judgments have I not forgotten.",
        "I have stuck unto thy testimonies: O Lord, put me not to shame.",
        "I will run the way of thy commandments, when thou shalt enlarge my heart."
    ]
    
    private let lineKeyLemmas = [
        (1, ["adhaereo", "pavimentum", "anima", "vivifico", "secundum", "verbum"]),
        (2, ["enuntio", "exaudio", "doceo", "iustificatio"]),
        (3, ["iustificatio", "instruo", "exerceo", "mirabilis"]),
        (4, ["dormito", "anima", "taedium", "confirmo", "verbum"]),
        (5, ["iniquitas", "amoveo", "lex", "misereor"]),
        (6, ["veritas", "eligo", "iudicium", "obliviscor"]),
        (7, ["adhaereo", "testimonium", "dominus", "confundo"]),
        (8, ["mandatum", "curro", "dilato", "cor"])
    ]
    
    private let structuralThemes = [
        (
            "Mortal Anguish",
            "Deep distress requiring divine intervention",
            ["adhaereo", "pavimentum", "dormito", "taedium", "confirmo"],
            1,
            4,
            "Physical metaphors for spiritual crisis",
            "The psalmist describes his soul clinging to the dust in mortal distress, sleeping from weariness, and needing divine strengthening according to God's word."
        ),
        (
            "Divine Rescue",
            "Pleas for life and preservation",
            ["vivifico", "confirmo", "opprobrium", "misereor"],
            1,
            8,
            "Requests for God to act amid suffering",
            "The psalmist repeatedly asks God to quicken him, strengthen him, and show mercy, recognizing his complete dependence on divine intervention for life and preservation."
        ),
        (
            "Pedagogy of Suffering",
            "Learning through affliction and divine instruction",
            ["doceo", "instruo", "exerceo", "mirabilis", "enuntio"],
            2,
            3,
            "Divine teaching through trials",
            "The psalmist declares his ways to God, receives instruction, and exercises in God's wondrous works, showing how suffering becomes a school for divine wisdom."
        ),
        (
            "Path of Truth → Heart Expansion",
            "Choosing truth and running in God's commandments with enlarged heart",
            ["veritas", "eligo", "curro", "mandatum", "dilato", "cor"],
            5,
            8,
            "Progressive spiritual growth through obedience",
            "The psalmist chooses the way of truth, sticks to God's testimonies, and runs in His commandments, experiencing the expansion of heart that comes from divine grace."
        )
    ];

    private let conceptualThemes = [
        (
            "Affliction",
            "References to weariness, clinging to dust, and need for revival",
            ["adhaereo", "pavimentum", "dormito", "taedium", "confundo", "iniquitas"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Petition",
            "Requests for teaching, confirmation, and mercy",
            ["vivifico", "exaudio", "doceo", "instruo", "confirmo", "amoveo", "misereor"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Path",
            "Emphasis on choosing, running, and staying on God's path",
            ["via", "eligo", "curro", "veritas", "iustificatio", "mandatum"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Transformation",
            "Themes of expansion, exercise, and declaration",
            ["dilato", "exerceo", "enuntio", "obliviscor", "adhaereo", "mirabilis"],
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
            psalm118Daleth.count, 8, "Psalm 118 Daleth should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Daleth English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Daleth.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Daleth,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Daleth,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Daleth_texts.json"
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
            filename: "output_psalm118Daleth_themes.json"
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
            psalmText: psalm118Daleth,
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
            psalmText: psalm118Daleth,
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
            psalmText: psalm118Daleth,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}