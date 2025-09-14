import XCTest

@testable import LatinService

class Psalm149Tests: XCTestCase {
    private var latinService: LatinService!
    private let utilities = PsalmTestUtilities.self

    let verbose = true

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Test Data

    let psalm149 = [
        "Cantate Domino canticum novum: laus eius in ecclesia sanctorum.",
        "Laetetur Israel in eo qui fecit eum: et filii Sion exsultent in rege suo.",
        "Laudent nomen eius in choro: in tympano, et psalterio psallant ei.",
        "Quia beneplacitum est Domino in populo suo: et exaltabit mansuetos in salutem.",
        "Exsultabunt sancti in gloria: laetabuntur in cubilibus suis.",
        "Exaltationes Dei in gutture eorum: et gladii ancipites in manibus eorum:",
        "Ad faciendam vindictam in nationibus: increpationes in populis.",
        "Ad alligandos reges eorum in compedibus: et nobiles eorum in manicis ferreis.",
        "Ut faciant in eis iudicium conscriptum: gloria haec est omnibus sanctis eius.",
    ]
    let id = PsalmIdentity(number: 149, category: nil)

    // MARK: - Line-by-line key lemmas (Psalm 149)

    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["canto", "dominus", "canticum", "novus", "laus", "ecclesia", "sanctus"]),
        (2, ["laetor", "israel", "facio", "sion", "exsulto", "rex"]),
        (3, ["laudo", "nomen", "chorus", "tympanum", "psalterium", "psallo"]),
        (4, ["beneplacitum", "dominus", "populus", "exalto", "mansuetus", "salus"]),
        (5, ["exsulto", "sanctus", "gloria", "laetor", "cubile"]),
        (6, ["exaltatio", "deus", "guttur", "gladius", "anceps", "manus"]),
        (7, ["facio", "vindicta", "natio", "increpatio", "populus"]),
        (8, ["alligo", "rex", "compedes", "nobilis", "manicae", "ferreus"]),
        (9, ["iudicium", "conscriptus", "gloria", "sanctus"]),
    ]

    // MARK: - Structural Themes

    private let structuralThemes = [
        (
            "New Song → Holy Assembly",
            "From a fresh hymn to communal worship",
            ["canticum", "novus", "ecclesia", "sanctus"],
            1,
            2,
            "The psalm begins with the call to sing a new song in the assembly, rejoicing in the Creator and King.",
            "Augustine sees the 'new song' as the praise of the new man in Christ, sung by the whole Church gathered as the holy people of God."
        ),
        (
            "Dance → Divine Favor",
            "From festal dance to God’s delight in the meek",
            ["chorus", "tympanum", "psalterium", "beneplacitum", "mansuetus"],
            3,
            4,
            "Praise through dance and instruments is met with God’s favor, who lifts up the humble.",
            "For Augustine, instruments symbolize virtues in action. The meek are exalted because their harmony with God is itself His delight."
        ),
        (
            "Glorious Rest → Exalted Voice",
            "From joy in rest to power in proclamation",
            ["gloria", "cubile", "guttur", "exaltatio", "gladius"],
            5,
            6,
            "The saints rejoice even in their resting places, but their throats also sound with God’s exaltation like a two-edged sword.",
            "Augustine interprets this as the saints resting in hope yet proclaiming God’s word with piercing authority, sharper than any blade."
        ),
        (
            "Judgment → Subjugation",
            "From executing judgment to binding rulers",
            ["vindicta", "increpatio", "rex", "compedes", "manicae"],
            7,
            8,
            "The faithful enact God’s decreed judgment, binding nations and kings with fetters.",
            "Augustine notes this as the spiritual victory of the Church, where proud rulers are subdued under Christ’s authority through the saints."
        ),
        (
            "Written Judgment → Shared Glory",
            "From decree fulfilled to honor for all saints",
            ["iudicium", "conscriptus", "gloria", "sanctus"],
            9,
            9,
            "The final verse declares the written judgment accomplished, granting glory to all the saints.",
            "Augustine sees this as the consummation of God’s plan: His judgment executed in history becomes the eternal glory of His holy ones."
        ),
    ]

 private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = [
        (
            "Divine Worship",
            "Praise and adoration of God",
            ["canto", "laudo", "laus", "psallo", "exsulto"],
            ThemeCategory.worship,
            1...3
        ),
        (
            "Divine Favor",
            "God's pleasure and delight in His people",
            ["beneplacitum", "exalto", "salus"],
            ThemeCategory.divine,
            4...4
        ),
        (
            "Saints' Glory",
            "The honor and joy of the holy ones",
            ["sanctus", "gloria", "exsulto", "laetor", "cubile"],
            ThemeCategory.virtue,
            1...5
        ),
        (
            "Divine Judgment",
            "God's righteous judgment and vengeance",
            ["vindicta", "increpatio", "iudicium", "conscriptus"],
            ThemeCategory.justice,
            7...9
        ),
        (
            "Spiritual Authority",
            "Power and authority given to the saints",
            ["gladius", "anceps", "alligo", "rex", "compedes", "nobilis"],
            ThemeCategory.virtue,
            6...8
        ),
        (
            "Divine Exaltation",
            "God's majesty and elevation",
            ["exaltatio", "deus", "gloria"],
            ThemeCategory.divine,
            5...6
        ),
        (
            "Communal Praise",
            "Corporate worship and celebration",
            ["ecclesia", "chorus", "populus"],
            ThemeCategory.worship,
            1...4
        ),
        (
            "Earthly Opposition",
            "Resistance from nations and rulers",
            ["natio", "populus", "rex", "nobilis"],
            ThemeCategory.opposition,
            7...8
        )
    ]
    // MARK: - Test Cases

    func testPsalm149Verses() {
        XCTAssertEqual(
            psalm149.count, 9, "Psalm 149 should have 9 verses in the Benedictine Office")
        let normalized = psalm149.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(normalized, psalm149, "Normalized Latin text should match expected forms")
    }

    func testPsalm149LineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm149,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testPsalm149StructuralThemes() {
        utilities.testStructuralThemes(
            psalmText: psalm149,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }
     func testPsalm149ConceptualThemes() {
        utilities.testConceptualThemes(
            psalmText: psalm149,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
    func testSavePsalm149Themes() {
        guard let jsonString = utilities.generateCompleteThemesJSONString(
            psalmNumber: id.number,
            conceptualThemes: conceptualThemes,
            structuralThemes: structuralThemes
        ) else {
            XCTFail("Failed to generate complete themes JSON")
            return
        }

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm149_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }

}
}
