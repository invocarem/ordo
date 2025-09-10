import XCTest
@testable import LatinService

class Psalm1Tests: XCTestCase {
    // private var latinService: LatinService!
    private let utilities = PsalmTestUtilities.self

    private let verbose = true

    override func setUp() {
        super.setUp()
//        latinService = LatinService.shared
    }

    let id = PsalmIdentity(number: 1, category: nil)

    // MARK: - Test Data
    private let psalm1 = [
        "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;",
        "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte.",
        "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:",
        "Et folium eius non defluet, et omnia quaecumque faciet, prosperabuntur.",
        "Non sic impii, non sic: sed tamquam pulvis, quem proicit ventus a facie terrae.",
        "Ideo non resurgent impii in iudicio, neque peccatores in concilio iustorum;",
        "Quoniam novit Dominus viam iustorum: et iter impiorum peribit."
    ]

    private let lineKeyLemmas = [
        (1, ["beatus", "vir", "abeo", "consilium", "impius", "via", "peccator", "sto", "cathedra", "pestilentia", "sedeo"]),
        (2, ["lex", "dominus", "voluntas", "meditor", "dies", "nox"]),
        (3, ["lignum", "planto", "secus", "decursus", "aqua", "fructus", "do", "tempus"]),
        (4, ["folium", "defluo", "omnis", "facio", "prospero"]),
        (5, ["impius", "pulvis", "proicio", "ventus", "facies", "terra"]),
        (6, ["resurgo", "impius", "iudicium", "peccator", "concilium", "iustus"]),
        (7, ["nosco", "dominus", "via", "iustus", "iter", "impius", "pereo"])
    ]

    private let structuralThemes = [
        (
            "Separation → Delight",
            "From avoidance of the wicked to joy in God's law",
            ["sto", "abeo", "sedeo", "lex", "meditor"],
            1,
            2,
            "The blessed one turns away from the path of the wicked and instead finds delight in the law of the Lord.",
            "Augustine interprets this as a triple renunciation (consilium → via → cathedra), culminating in the joy of meditating on the Law. For him, the righteous one is defined by inward transformation and desire for God (Enarr. Ps. 1.1–2)."
        ),
        (
            "Rootedness → Fruitfulness",
            "From spiritual planting to lasting vitality and success",
            ["lignum", "planto", "aqua", "fructus", "prospero"],
            3,
            4,
            "The just is like a tree planted by streams, yielding fruit in its season and not withering. This image emphasizes stability, growth, and enduring vitality through divine nourishment.",
            "Augustine reads the tree as one rooted in grace and Scripture, continually refreshed by Christ, the living water. Its fruit signifies good works in due season, prospering by God's help (Enarr. Ps. 1.3)."
        ),
        (
            "Chaff → Separation",
            "From unstable wickedness to final divine separation",
            ["pulvis", "iudicium", "via", "iter", "pereo", "nosco"],
            5,
            7,
            "The wicked cannot stand in judgment or in the assembly of the righteous, for the Lord knows the way of the just while the way of the impious comes to nothing.",
            "Augustine contrasts the rooted tree of the righteous with the empty lightness of the ungodly. The Lord 'knows' (novit) the way of the just with covenantal intimacy, but the way of the wicked perishes — eternal separation from God (Enarr. Ps. 1.5–6)."
        )
    ]

    private let conceptualThemes = [
        (
            "Divine Sovereignty",
            "God's authority and knowledge",
            ["nosco"],
            ThemeCategory.divine,
            nil as ClosedRange<Int>?
        ),
        (
            "Divine Justice",
            "God's righteous judgment", 
            ["pereo", "resurgo", "proicio", "ventus", "pulvis", "terra"],
            .justice,
            5...7
        ),
        (
            "Righteous Worship",
            "The blessed man's devotion",
            ["meditor", "voluntas"],
            .worship,
            2...2
        ),
        (
            "Virtuous Life",
            "Qualities of the righteous person",
            ["beatus", "iustus", "prospero", "fructus", "lignum", "aqua", "folium"],
            .virtue,
            nil as ClosedRange<Int>?
        ),
        (
            "Spiritual Conflict",
            "Walking in the way of sinners",
            ["peccator", "sto"],
            .conflict,
            1...1
        ),
        (
            "Sinful Nature", 
            "Following counsel of wicked",
            ["impius", "abeo"],
            .sin,
            1...1
        ),
        (
            "Worldly Opposition",
            "Sitting in seat of pestilence",
            ["pestilentia", "sedeo"],
            .opposition,
            1...1
        )
    ]

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm1LineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm1,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testPsalm1StructuralThemes() {
        utilities.testStructuralThemes(
            psalmText: psalm1,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testPsalm1ConceptualThemes() {
        utilities.testConceptualThemes(
            psalmText: psalm1,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testSavePsalm1Themes() {
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
            filename: "output_psalm1_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}