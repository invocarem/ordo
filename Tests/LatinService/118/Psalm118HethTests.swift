import XCTest
@testable import LatinService

class Psalm118HethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "heth")
    
    // MARK: - Test Data Properties
    private let psalm118Heth = [
        "Portio mea, Domine, dixi custodire legem tuam.",
        "Deprecatus sum faciem tuam in toto corde meo, miserere mei secundum eloquium tuum.",
        "Cogitavi vias meas, et converti pedes meos in testimonia tua.",
        "Paratus sum, et non sum turbatus, ut custodiam mandata tua.",
        "Funes peccatorum circumplexi sunt me, et legem tuam non sum oblitus.",
        "Media nocte surgebam ad confitendum tibi, super iudicia iustitiae tuae.",
        "Particeps ego sum omnium timentium te, et custodientium mandata tua.",
        "Misericordia tua, Domine, plena est terra, iustificationes tuas doce me."
    ]
    
    private let englishText = [
        "O Lord, my portion: I have said, I would keep thy law.",
        "I entreated thy face with my whole heart: have mercy on me according to thy word.",
        "I have thought on my ways: and turned my feet unto thy testimonies.",
        "I am ready, and am not troubled: that I may keep thy commandments.",
        "The cords of the wicked have encompassed me: but I have not forgotten thy law.",
        "At midnight I rose to give praise to thee: for the judgments of thy justice.",
        "I am a partaker with all them that fear thee: and that keep thy commandments.",
        "The earth, O Lord, is full of thy mercy: teach me thy justifications."
    ]
    
    private let lineKeyLemmas = [
        (1, ["portio", "dominus", "dico", "custodio", "lex"]),
        (2, ["deprecor", "facies", "totus", "cor", "miserere", "eloquium"]),
        (3, ["cogito", "via", "converto", "pes", "testimonium"]),
        (4, ["paratus", "sum", "turbo", "custodio", "mandatum"]),
        (5, ["funis", "peccator", "circumplector", "lex", "obliviscor"]),
        (6, ["medius", "nox", "surgo", "confiteor", "iudicium", "iustitia"]),
        (7, ["particeps", "sum", "omnis", "timeo", "custodio", "mandatum"]),
        (8, ["misericordia", "dominus", "plenus", "terra", "iustificatio", "doceo"])
    ]
    
    private let structuralThemes = [
        (
            "Portion → Devotion",
            "The psalmist's declaration of God as his portion and his commitment to keep God's law",
            ["portio", "dominus", "dico", "custodio", "lex", "deprecor", "facies", "totus", "cor"],
            1,
            2,
            "The psalmist declares that the Lord is his portion and he will keep God's law, and he entreats God's face with his whole heart for mercy according to God's word.",
            "Augustine sees this as the soul's fundamental choice of God as its inheritance and portion. The 'portio mea' (my portion) shows the believer's recognition that God alone is sufficient, while the whole-hearted entreaty demonstrates the depth of devotion and dependence on divine mercy."
        ),
        (
            "Reflection → Conversion",
            "The psalmist's thoughtful consideration of his ways and his turning to God's testimonies",
            ["cogito", "via", "converto", "pes", "testimonium", "paratus", "turbo", "custodio", "mandatum"],
            3,
            4,
            "The psalmist has thought on his ways and turned his feet to God's testimonies, and he is ready and not troubled to keep God's commandments.",
            "For Augustine, this represents the soul's process of self-examination and repentance. The 'cogitavi vias meas' (I have thought on my ways) shows the believer's honest self-assessment, while the turning of feet to testimonies demonstrates the practical commitment to follow God's truth."
        ),
        (
            "Encirclement → Faithfulness",
            "The psalmist's faithfulness to God's law despite being surrounded by the cords of the wicked",
            ["funis", "peccator", "circumplector", "lex", "obliviscor", "medius", "nox", "surgo", "confiteor"],
            5,
            6,
            "The cords of the wicked have encompassed the psalmist, but he has not forgotten God's law, and he rises at midnight to give praise for God's judgments of justice.",
            "Augustine interprets this as the soul's steadfastness in the face of external pressures and temptations. The 'funes peccatorum circumplexi sunt me' (the cords of sinners have encompassed me) shows the believer's awareness of surrounding evil, while the midnight vigil of praise demonstrates the soul's priority of divine worship over sleep."
        ),
        (
            "Community → Instruction",
            "The psalmist's participation in the community of the faithful and his desire for instruction in God's justifications",
            ["particeps", "omnis", "timeo", "custodio", "mandatum", "misericordia", "dominus", "plenus", "terra", "iustificatio", "doceo"],
            7,
            8,
            "The psalmist is a partaker with all who fear God and keep His commandments, and he acknowledges that the earth is full of God's mercy and asks to be taught God's justifications.",
            "For Augustine, this represents the soul's recognition of its place in the community of believers and its ongoing need for divine instruction. The 'particeps ego sum omnium timentium te' (I am a partaker with all who fear you) shows the believer's solidarity with the faithful, while the request for instruction demonstrates humility and the desire for continued growth in divine wisdom."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Law",
            "References to God's law, commandments, and testimonies",
            ["lex", "mandatum", "testimonium", "iustificatio", "iudicium"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Devotion",
            "Themes of whole-hearted commitment and faithfulness",
            ["portio", "custodio", "totus", "cor", "deprecor", "paratus", "particeps"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Mercy",
            "Expressions of divine mercy and the psalmist's need for it",
            ["miserere", "misericordia", "eloquium", "plenus", "terra"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Community",
            "The fellowship of believers and shared commitment to God",
            ["particeps", "omnis", "timeo", "confiteor", "surgo", "nox"],
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
            psalm118Heth.count, 8, "Psalm 118 Heth should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Heth English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Heth.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Heth,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Heth,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Heth_texts.json"
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
            filename: "output_psalm118Heth_themes.json"
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
            psalmText: psalm118Heth,
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
            psalmText: psalm118Heth,
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
            psalmText: psalm118Heth,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}
