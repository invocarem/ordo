import XCTest

@testable import LatinService

class Psalm2Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let id = PsalmIdentity(number: 2, category: nil)

    // MARK: - Test Data
    private let psalm2 = [
        "Quare fremuerunt gentes, et populi meditati sunt inania?",
        "Astiterunt reges terrae, et principes convenerunt in unum adversus Dominum, et adversus christum eius.",
        "Dirumpamus vincula eorum, et proiciamus a nobis iugum ipsorum.",
        "Qui habitat in caelis irridebit eos, et Dominus subsannabit eos.",
        "Tunc loquetur ad eos in ira sua, et in furore suo conturbabit eos.",
        "Ego autem constitutus sum rex ab eo super Sion montem sanctum eius, praedicans praeceptum eius.",
        "Dominus dixit ad me: Filius meus es tu, ego hodie genui te.",
        "Postula a me, et dabo tibi gentes hereditatem tuam, et possessionem tuam terminos terrae.",
        "Reges eos in virga ferrea, et tamquam vas figuli confringes eos.",
        "Et nunc, reges, intelligite; erudimini, qui iudicatis terram.",
        "Servite Domino in timore, et exsultate ei cum tremore.",
        "Apprehendite disciplinam, nequando irascatur Dominus, et pereatis de via iusta.",
        "Cum exarserit in brevi ira eius, beati omnes qui confidunt in eo.",
    ]

    private let lineKeyLemmas = [
        (1, ["fremo", "gens", "populus", "meditor", "inanis"]),
        (2, ["asto", "rex", "terra", "princeps", "convenio", "adversus", "dominus", "christus"]),
        (3, ["dirumpo", "vinculum", "proicio", "iugum"]),
        (4, ["habito", "caelum", "irrideo", "dominus", "subsanno"]),
        (5, ["loquor", "ira", "furor", "conturbo"]),
        (6, ["constituo", "rex", "sion", "mons", "sanctus", "praedico", "praeceptum"]),
        (7, ["dominus", "dico", "filius", "hodie", "gigno"]),
        (8, ["postulo", "do", "gens", "hereditas", "possessio", "terminus", "terra"]),
        (9, ["rego", "virga", "ferreus", "vas", "figulus", "confringo"]),
        (10, ["intelligo", "erudio", "iudico", "terra"]),
        (11, ["servio", "dominus", "timor", "exsulto", "tremor"]),
        (12, ["apprehendo", "disciplina", "irascor", "dominus", "pereo", "via", "iustus"]),
        (13, ["beatus", "omnis", "confido"]),
    ]

    private let themeKeyLemmas:
        [(name: String, description: String, lemmas: [String], category: ThemeCategory)] = [
            (
                "Opposition to God",
                "Earthly powers rebelling against God's authority",
                ["fremo", "adversus", "dirumpo", "proicio", "convenio", "asto", "inanis"],
                .opposition
            ),
            (
                "Divine Judgment",
                "God's response to rebellion through derision and wrath",
                [
                    "irrideo", "subsanno", "ira", "furor", "conturbo", "confringo", "irascor",
                    "pereo",
                ],
                .justice
            ),
            (
                "Divine Sovereignty",
                "God's authority and appointment of His Son as king",
                [
                    "constituo", "rex", "filius", "gigno", "rego", "virga", "do", "hereditas",
                    "possessio",
                ],
                .divine
            ),
            (
                "Rightful Worship",
                "The call to serve and worship God with fear and joy",
                ["servio", "timor", "exsulto", "tremor", "disciplina", "apprehendo", "confido"],
                .worship
            ),
        ]
    // MARK: - Line by Line Key Lemmas Test

    func testPsalm2LineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm2[lineNumber - 1]
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

    // MARK: - Theme Tests

    func testPsalm2Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm2.joined(separator: " "))
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
