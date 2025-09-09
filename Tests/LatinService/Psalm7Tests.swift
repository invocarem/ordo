import XCTest

@testable import LatinService

class Psalm7Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 7, category: "")

    // MARK: - Test Data Properties

    private let psalm7 = [
        "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me.",
        "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat.",
        "Domine Deus meus, si feci istud, si est iniquitas in manibus meis,",
        "Si reddidi retribuentibus mihi mala, decidam merito ab inimicis meis inanis.",
        "Persequatur inimicus animam meam, et comprehendat, et conculcet in terra vitam meam, et gloriam meam in pulverem deducat.",
        "Exsurge, Domine, in ira tua; exaltare in finibus inimicorum meorum.",
        "Et exsurge, Domine Deus meus, in praecepto quod mandasti; et synagoga populorum circumdabit te.",
        "Et propter hanc in altum regredere; Dominus iudicat populos.",
        "Iudica me, Domine, secundum iustitiam meam, et secundum innocentiam meam super me.",
        "Consumetur nequitia peccatorum, et diriges iustum, scrutans corda et renes, Deus.",
        "Iustum adiutorium meum a Domino, qui salvos facit rectos corde.",
        "Deus iudex iustus, fortis, et patiens; numquid irascitur per singulos dies?",
        "Nisi conversi fueritis, gladium suum vibrabit; arcum suum tetendit, et paravit illum.",
        "Et in eo paravit vasa mortis; sagittas suas ardentibus effecit.",
        "Ecce parturiit iniustitiam, concepit dolorem, et peperit iniquitatem.",
        "Lacum aperuit, et effodit eum, et incidit in foveam quam fecit.",
        "Convertetur dolor eius in caput eius, et in verticem ipsius iniquitas eius descendet.",
        "Confitebor Domino secundum iustitiam eius, et psallam nomini Domini altissimi.",
    ]
    private let lineKeyLemmas = [
        (1, ["spero", "salvus", "omnis", "persequor", "libero"]),
        (2, ["nequando", "rapio", "leo", "anima", "dum", "redimo", "salvus"]),
        (3, ["facio", "iste", "iniquitas", "manus"]),
        (4, ["reddo", "retribuo", "malus", "decido", "mereor", "inimicus", "inanis"]),
        (5, ["persequor", "inimicus", "anima", "comprehendo", "conculco", "terra", "vita", "gloria", "pulvis", "deduco"]),
        (6, ["exsurgo", "ira", "exalto", "finis", "inimicus"]),
        (7, ["exsurgo", "praeceptum", "mando", "synagoga", "populus", "circumdo"]),
        (8, ["propter", "hic", "altus", "regredior", "iudico", "populus"]),
        (9, ["iudico", "secundum", "iustitia", "secundum", "innocentia", "super"]),
        (10, ["consumo", "nequitia", "peccator", "dirigo", "iustus", "scrutor", "ren"]),
        (11, ["iustus", "adiutorium", "salvus", "rectus"]),
        (12, ["iudex", "iustus", "fortis", "patiens", "irascor", "singulus", "dies"]),
        (13, ["nisi", "converto", "gladius", "vibro", "arcus", "tendo", "paro"]),
        (14, ["paro", "vas", "mors", "sagitta", "ardeo", "efficio"]),
        (15, ["ecce", "parturio", "iniustitia", "concipio", "dolor", "pario", "iniquitas"]),
        (16, ["lacus", "aperio", "effodio", "incido", "fovea", "facio"]),
        (17, ["converto", "dolor", "caput", "vertex", "iniquitas", "descendo"]),
        (18, ["confiteor", "secundum", "iustitia", "psallo", "nomen", "altissimus"]),
    ]
    private let themeKeyLemmas: [(name: String, description: String, lemmas: [String], category: ThemeCategory)] = [
        (
            "Divine Protection",
            "God's salvation and deliverance",
            ["spero", "salvus", "libero", "redimo", "adiutorium", "exsurgo"],
            .divine
        ),
        (
            "Divine Authority",
            "God's sovereignty, majesty, and commands",
            ["altissimus", "praeceptum", "mando", "regredior"],
            .divine
        ),
        (
            "Divine Judgment",
            "God's judicial process and righteous judgment",
            ["iudico", "iustitia", "iudex", "scrutor", "mereor", "retribuo", "decido"],
            .justice
        ),
        (
            "Human Innocence",
            "Declaration of righteousness before God",
            ["innocentia", "iustus", "rectus", "super"],
            .virtue
        ),
        (
            "Divine Wrath",
            "God's violent judgment against enemies",
            ["ira", "gladius", "arcus", "sagitta", "mors", "conculco", "vibro", "ardeo"],
            .justice
        ),
        (
            "Sin's Consequences",
            "Natural results of wrongdoing",
            ["iniquitas", "peccator", "nequitia", "dolor", "descendo", "parturio", "concipio", "pario"],
            .sin
        ),
        (
            "Enemy Opposition",
            "Adversaries and persecutors",
            ["inimicus", "persequor", "malus", "comprehendo", "rapio"],
            .opposition
        ),
        (
            "Worship Response",
            "Human praise and acknowledgment",
            ["confiteor", "psallo", "nomen", "exalto"],
            .worship
        ),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm7LineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm7[lineNumber - 1]
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

    func testPsalm7Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm7.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []

        for (themeName, themeDescription, themeLemmas, category) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                let colorName = category.rawValue.uppercased()
                print("\n\(status) [\(colorName)] \(themeName): \(themeDescription)")
                print("   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append(
                    "Theme \(themeName) (\(category.rawValue)): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))"
                )
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }
}
