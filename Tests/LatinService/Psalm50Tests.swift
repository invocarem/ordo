import XCTest

@testable import LatinService

class Psalm50Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 50, category: "")

    // MARK: - Test Data Properties
    private let psalm50 = [
        "Miserere mei, Deus, secundum magnam misericordiam tuam;",
        "et secundum multitudinem miserationum tuarum, dele iniquitatem meam.",
        "Amplius lava me ab iniquitate mea, et a peccato meo munda me.",
        "Quoniam iniquitatem meam ego cognosco, et peccatum meum contra me est semper.",
        "Tibi soli peccavi, et malum coram te feci; ut iustificeris in sermonibus tuis, et vincas cum iudicaris.",
        "Ecce enim in iniquitatibus conceptus sum, et in peccatis concepit me mater mea.",
        "Ecce enim veritatem dilexisti; incerta et occulta sapientiae tuae manifestasti mihi.",
        "Asperges me hyssopo, et mundabor; lavabis me, et super nivem dealbabor.",
        "Auditui meo dabis gaudium et laetitiam, et exsultabunt ossa humiliata.",
        "Averte faciem tuam a peccatis meis, et omnes iniquitates meas dele.",
        "Cor mundum crea in me, Deus, et spiritum rectum innova in visceribus meis.",
        "Ne proicias me a facie tua, et spiritum sanctum tuum ne auferas a me.",
        "Redde mihi laetitiam salutaris tui, et spiritu principali confirma me.",
        "Docebo iniquos vias tuas, et impii ad te convertentur.",
        "Libera me de sanguinibus, Deus, Deus salutis meae, et exsultabit lingua mea iustitiam tuam.",
        "Domine, labia mea aperies, et os meum annuntiabit laudem tuam.",
        "Quoniam si voluisses sacrificium, dedissem utique; holocaustis non delectaberis.",
        "Sacrificium Deo spiritus contribulatus; cor contritum et humiliatum, Deus, non despicies.",
        "Benigne fac, Domine, in bona voluntate tua Sion, ut aedificentur muri Ierusalem.",
        "Tunc acceptabis sacrificium iustitiae, oblationes et holocausta; tunc imponent super altare tuum vitulos.",
    ]

    private let lineKeyLemmas = [
        (1, ["misereor", "deus", "secundum", "magnus", "misericordia"]),
        (2, ["secundum", "multitudo", "miseratio", "deleo", "iniquitas"]),
        (3, ["amplius", "lavo", "iniquitas", "peccatum", "mundo"]),
        (4, ["quoniam", "iniquitas", "cognosco", "peccatum", "contra", "semper"]),
        (
            5,
            ["solus", "pecco", "malum", "coram", "facio", "iustifico", "sermo", "vinco", "iudico"]
        ),
        (6, ["ecce", "iniquitas", "concipio", "peccatum", "mater"]),
        (7, ["ecce", "veritas", "diligo", "incertus", "occultus", "sapientia", "manifesto"]),
        (8, ["aspergo", "hyssopus", "mundo", "lavo", "super", "nix", "dealbo"]),
        (9, ["auditus", "do", "gaudium", "laetitia", "exsulto", "os", "humilio"]),
        (10, ["averto", "facies", "peccatum", "omnis", "iniquitas", "deleo"]),
        (11, ["cor", "mundus", "creo", "deus", "spiritus", "rectus", "innovo", "viscus"]),
        (12, ["proicio", "facies", "spiritus", "sanctus", "aufero"]),
        (13, ["reddo", "laetitia", "salutaris", "spiritus", "principalis", "confirmo"]),
        (14, ["doceo", "iniquus", "via", "impius", "converto"]),
        (15, ["libero", "sanguis", "deus", "salus", "exsulto", "lingua", "iustitia"]),
        (16, ["dominus", "labium", "aperio", "os", "annuntio", "laus"]),
        (17, ["quoniam", "volo", "sacrificium", "do", "holocaustum", "delector"]),
        (
            18,
            [
                "sacrificium", "deus", "spiritus", "contribulo", "cor", "contero", "humilio",
                "despicio",
            ]
        ),
        (
            19,
            [
                "benignus", "facio", "dominus", "bonus", "voluntas", "sion", "aedifico", "murus",
                "ierusalem",
            ]
        ),
        (
            20,
            [
                "tunc", "accipio", "sacrificium", "iustitia", "oblatio", "holocaustum", "impono",
                "super", "altare", "vitulus",
            ]
        ),
    ]

    private let themeKeyLemmas = [
        (
            "Repentance", "Acknowledgment of sin and guilt",
            ["peccatum", "iniquitas", "cognosco", "contra", "concipio"]
        ),
        (
            "Purification", "Cleansing and washing from sin",
            ["lavo", "mundo", "aspergo", "dealbo", "mundus"]
        ),
        (
            "Mercy", "Appeals to God's compassion",
            ["misereor", "misericordia", "miseratio", "benignus", "secundum"]
        ),
        (
            "Transformation", "Inner renewal and creation",
            ["creo", "innovo", "cor", "spiritus", "rectus", "confirmo"]
        ),
        (
            "Sacrifice", "True spiritual offerings",
            ["sacrificium", "holocaustum", "oblatio", "contribulo", "contero", "humilio"]
        ),
        (
            "Restoration", "Return of joy and salvation",
            ["gaudium", "laetitia", "exsulto", "salutaris", "reddo", "annuntio"]
        ),
        (
            "Divine Presence", "Relationship with God",
            ["facies", "spiritus", "sanctus", "principalis", "averto", "proicio"]
        ),
    ]

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test
    func testPsalm50LineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm50[lineNumber - 1]
            let analysis = latinService.analyzePsalm(id, text: line, startingLineNumber: lineNumber)

            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let foundLemmas = expectedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = expectedLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                print(
                    "\(status) Line \(lineNumber): Found \(foundLemmas.count)/\(expectedLemmas.count) key lemmas: \(foundLemmas.joined(separator: ", "))"
                )

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                    print("   Available: \(detectedLemmas.sorted().joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append(
                    "Line \(lineNumber): Missing lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Missing lemmas detected:\n" + allFailures.joined(separator: "\n"))
        }
    }

    func testPsalm50Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm50.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []

        for (themeName, themeDescription, themeLemmas) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                print("\n\(status) \(themeName.uppercased()): \(themeDescription)")
                print(
                    "   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))"
                )

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append(
                    "Theme \(themeName): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))"
                )
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }
}
