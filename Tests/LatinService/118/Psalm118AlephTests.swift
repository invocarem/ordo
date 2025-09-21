import XCTest
@testable import LatinService

class Psalm118AlephTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "aleph")
    
    // MARK: - Test Data Properties
    private let psalm118Aleph = [
        "Beati immaculati in via, qui ambulant in lege Domini.",
        "Beati qui scrutantur testimonia eius, in toto corde exquirunt eum.",
        "Non enim qui operantur iniquitatem, in viis eius ambulaverunt.",
        "Tu mandasti mandata tua custodiri nimis.",
        "Utinam dirigantur viae meae, ad custodiendas iustificationes tuas!",
        "Tunc non confundar, cum perspexero in omnibus praeceptis tuis.",
        "Confitebor tibi in directione cordis, in eo quod didici iudicia iustitiae tuae.",
        "Iustificationes tuas custodiam, non me derelinquas usquequaque."
    ]
    
    private let englishText = [
        "Blessed are the undefiled in the way, who walk in the law of the Lord.",
        "Blessed are they that search his testimonies, that seek him with their whole heart.",
        "For they that work iniquity have not walked in his ways.",
        "Thou hast commanded thy commandments to be kept most diligently.",
        "O that my ways may be directed to keep thy justifications!",
        "Then shall I not be confounded, when I shall look into all thy commandments.",
        "I will praise thee with uprightness of heart, when I shall have learned the judgments of thy justice.",
        "I will keep thy justifications: O do not thou utterly forsake me."
    ]
    
    private let lineKeyLemmas = [
        (1, ["beatus", "immaculatus", "ambulo", "dominus"]),
        (2, ["beatus", "scrutor", "testimonium", "totus", "exquiro"]),
        (3, ["enim", "operor", "iniquitas", "ambulo"]),
        (4, ["mando", "mandatum", "custodio", "nimis"]),
        (5, ["utinam", "dirigo", "custodio", "iustificatio"]),
        (6, ["tunc", "confundo", "perspicio", "omnis", "praeceptum"]),
        (7, ["confiteor", "directio", "disco", "iudicium", "iustitia"]),
        (8, ["iustificatio", "custodio", "derelinquo", "usquequaque"])
    ]
    
    private let structuralThemes = [
        (
            "Blessedness → Integrity",
            "The blessed state of the blameless who walk in God's law",
            ["beatus", "immaculatus", "via", "ambulo", "lex"],
            1,
            2,
            "The psalmist declares blessed those who are blameless in way and walk in the law of the Lord, who seek Him with their whole heart.",
            "Augustine sees this as describing those perfected in charity through grace. The 'immaculati' are not sinless by nature but made blameless through Christ, walking in His law of love."
        ),
        (
            "Contrast → Iniquity",
            "The distinction between workers of iniquity and followers of God's ways",
            ["iniquitas", "via", "ambulo", "custodio", "nimis"],
            3,
            4,
            "The workers of iniquity have not walked in God's ways, in contrast to those who diligently keep His commandments as He has ordained.",
            "For Augustine, this represents the fundamental choice between the broad way of destruction and the narrow way of life. God's strict command reveals the seriousness of this spiritual division."
        ),
        (
            "Desire → Direction",
            "The psalmist's longing for his ways to be directed to keep God's justifications",
            ["utinam", "dirigo", "custodio", "iustificatio", "confundo"],
            5,
            6,
            "The psalmist expresses his desire that his ways be directed to keep God's justifications, so that he will not be confounded when he looks into all God's commandments.",
            "Augustine interprets this as the soul's prayer for divine guidance. The 'utinam' expresses both desire and dependence on grace. Only God can direct the heart to keep His justifications, preventing the confusion that comes from human pride."
        ),
        (
            "Praise → Preservation",
            "The psalmist's commitment to praise God and keep His justifications",
            ["confiteor", "directio", "disco", "iudicium", "custodio", "derelinquo"],
            7,
            8,
            "The psalmist will praise God with uprightness of heart, having learned His judgments of justice, and vows to keep His justifications, asking not to be forsaken.",
            "For Augustine, this represents the soul's response to divine instruction. The praise flows from a heart made upright through grace, and the keeping of justifications is both gift and responsibility, requiring God's continued presence."
        )
    ];

    private let conceptualThemes = [
        (
            "Blessedness",
            "Focus on blessedness of following God's law",
            ["beatus", "immaculatus", "confundo", "iustitia", "directio"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Obedience",
            "Emphasis on walking in God's ways and keeping commandments",
            ["custodio", "ambulo", "mando", "dirigo", "perspicio"],
            ThemeCategory.virtue,
            1...8
        ),
        (
            "Divine Law",
            "References to God's commandments and statutes",
            ["testimonium", "mandatum", "iustificatio", "praeceptum", "iudicium"],
            ThemeCategory.divine,
            1...8
        ),
        (
            "Heart and Seeking",
            "Themes of whole-hearted seeking and learning",
            ["exquiro", "scrutor", "disco", "confiteor", "usquequaque"],
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
            psalm118Aleph.count, 8, "Psalm 118 Aleph should have 8 verses"
        )
        XCTAssertEqual(
            englishText.count, 8,
            "Psalm 118 Aleph English text should have 8 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm118Aleph.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm118Aleph,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm118Aleph,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm118Aleph_texts.json"
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
            filename: "output_psalm118Aleph_themes.json"
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
            psalmText: psalm118Aleph,
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
            psalmText: psalm118Aleph,
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
            psalmText: psalm118Aleph,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}