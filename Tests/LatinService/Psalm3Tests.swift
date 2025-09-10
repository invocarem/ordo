import XCTest

@testable import LatinService

class Psalm3Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 3, category: "")

    // MARK: - Test Data Properties
    private let psalm3 = [
        "Domine, quid multiplicati sunt qui tribulant me? multi insurgunt adversum me.",
        "Multi dicunt animae meae: Non est salus ipsi in Deo eius.",
        "Tu autem, Domine, susceptor meus es, gloria mea, et exaltans caput meum.",
        "Voce mea ad Dominum clamavi, et exaudivit me de monte sancto suo.",
        "Ego dormivi et soporatus sum; exsurrexi, quia Dominus suscepit me.",
        "Non timebo milia populi circumdantis me: exsurge, Domine; salvum me fac, Deus meus.",
        "Quoniam tu percussisti omnes adversantes mihi sine causa; dentes peccatorum contrivisti.",
        "Domini est salus; et super populum tuum benedictio tua.",
    ]

    private let lineKeyLemmas = [
        (1, ["multiplico", "tribulo", "insurgo", "adversus"]),
        (2, ["dico", "anima", "salus"]),
        (3, ["susceptor", "gloria", "exalto", "caput"]),
        (4, ["vox", "clamo", "exaudio", "mons", "sanctus"]),
        (5, ["dormio", "soporor", "exsurgo", "suscipio"]),
        (6, ["timeo", "mille", "populus", "circumdo", "exsurgo", "salvus", "facio"]),
        (7, ["percutio", "adversor", "causa", "dens", "peccator", "contero"]),
        (8, ["salus", "benedictio"]),
    ]

    private let themeKeyLemmas:
        [(name: String, description: String, lemmas: [String], category: ThemeCategory)] = [
            (
                "Divine Protection",
                "God as shield and sustainer",
                ["susceptor", "suscipio", "exalto"],
                .divine
            ),
            (
                "Enemies and Opposition",
                "Adversaries and trouble",
                ["tribulo", "insurgo", "adversor", "peccator", "multiplico", "circumdo"],
                .opposition
            ),
            (
                "Trust and Confidence",
                "Lack of fear in God",
                ["timeo"],
                .virtue
            ),
            (
                "Prayer and Response",
                "Crying out and God's answer",
                ["clamo", "exaudio", "vox"],
                .worship
            ),
            (
                "Salvation and Deliverance",
                "God's saving action",
                ["salus", "salvus", "benedictio"],
                .divine
            ),
            (
                "Divine Justice",
                "God's powerful intervention against enemies",
                ["percutio", "contero"],
                .justice
            ),
        ]

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test
    func testPsalm3LineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm3[lineNumber - 1]
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

    func testPsalm3Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm3.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []

        for (themeName, themeDescription, themeLemmas, category) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                let colorName = category.rawValue.uppercased()
                print("\n\(status) [\(colorName)] \(themeName): \(themeDescription)")
                print(
                    "   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))"
                )

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
