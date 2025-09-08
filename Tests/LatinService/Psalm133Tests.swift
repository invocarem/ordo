@testable import LatinService
import XCTest

class Psalm133Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 133, category: "")

    // MARK: - Test Data Properties

    private let psalm133 = [
        "Ecce nunc benedicite Dominum, omnes servi Domini:",
        "Qui statis in domo Domini, in atriis domus Dei nostri.",
        "In noctibus extollite manus vestras in sancta, et benedicite Dominum.",
        "Benedicat te Dominus ex Sion, qui fecit caelum et terram.",
    ]

    private let lineKeyLemmas = [
        (1, ["ecce", "nunc", "benedico", "dominus", "omnis", "servus"]),
        (2, ["qui", "sto", "domus", "dominus", "atrium", "domus", "deus", "noster"]),
        (3, ["nox", "extollo", "manus", "vester", "sanctus", "benedico", "dominus"]),
        (4, ["benedico", "dominus", "ex", "sion", "qui", "facio", "caelum", "terra"]),
    ]

    private let themeKeyLemmas = [
        ("Blessing", "Call to bless and be blessed by God", ["benedico"]),
        ("Divine Service", "Service and standing in God's house", ["servus", "sto", "domus", "atrium"]),
        ("Sacred Space", "Holy places and worship settings", ["sanctus", "sion", "domus", "atrium"]),
        ("Divine Majesty", "God's creative power and sovereignty", ["dominus", "deus", "facio", "caelum", "terra"]),
        ("Worship Posture", "Physical acts of worship", ["extollo", "manus", "sto", "nox"]),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm133LineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm133[lineNumber - 1]
            let analysis = latinService.analyzePsalm(id, text: line, startingLineNumber: lineNumber)

            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let foundLemmas = expectedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = expectedLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                print("\(status) Line \(lineNumber): Found \(foundLemmas.count)/\(expectedLemmas.count) key lemmas: \(foundLemmas.joined(separator: ", "))")

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                    print("   Available: \(detectedLemmas.sorted().joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append("Line \(lineNumber): Missing lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Missing lemmas detected:\n" + allFailures.joined(separator: "\n"))
        }
    }

    func testPsalm133Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm133.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []

        for (themeName, themeDescription, themeLemmas) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                print("\n\(status) \(themeName.uppercased()): \(themeDescription)")
                print("   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")

                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }
            }

            if !missingLemmas.isEmpty {
                allFailures.append("Theme \(themeName): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }

        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }
}
