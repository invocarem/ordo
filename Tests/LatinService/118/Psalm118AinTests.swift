@testable import LatinService
import XCTest

class Psalm118AinTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 118, category: "Ain")

    // MARK: - Test Data Properties

    private let psalm118Ain = [
        "Feci iudicium et iustitiam; non tradas me calumniantibus me.",
        "Suscipe servum tuum in bonum; non calumnientur me superbi.",
        "Oculi mei defecerunt in salutare tuum, et in eloquium iustitiae tuae.",
        "Fac cum servo tuo secundum misericordiam tuam, et iustificationes tuas doce me.",
        "Servus tuus sum ego; da mihi intellectum, ut sciam testimonia tua.",
        "Tempus faciendi, Domine; dissipaverunt legem tuam.",
        "Ideo dilexi mandata tua super aurum et topazion.",
        "Propterea ad omnia mandata tua dirigebar; omnem viam iniquam odio habui."
    ]

    private let lineKeyLemmas = [
        (1, ["facio", "iudicium", "iustitia", "trado", "calumnior"]),
        (2, ["suscipio", "servus", "bonus", "calumnior", "superbus"]),
        (3, ["oculus", "deficio", "salutare", "eloquium", "iustitia"]),
        (4, ["facio", "servus", "secundum", "misericordia", "iustificatio", "doceo"]),
        (5, ["servus", "sum", "do", "intellectus", "scio", "testimonium"]),
        (6, ["tempus", "facio", "dominus", "dissipo", "lex"]),
        (7, ["diligo", "mandatum", "super", "aurum", "topazion"]),
        (8, ["propterea", "mandatum", "dirigo", "omnis", "via", "iniquus", "odium", "habeo"])
    ]

    private let themeKeyLemmas = [
        ("Justice and Righteousness", "Doing what is right and just before God", ["iudicium", "iustitia", "iustificatio", "salutare"]),
        ("Divine Protection", "Seeking God's protection from enemies", ["trado", "calumnior", "suscipio", "superbus"]),
        ("Servanthood", "Identity as God's servant and seeking guidance", ["servus", "facio", "doceo", "intellectus", "scio"]),
        ("Love for God's Word", "Affection for commandments and testimonies", ["diligo", "mandatum", "testimonium", "eloquium"]),
        ("Obedience and Direction", "Being guided by God's commandments", ["dirigo", "propterea", "secundum", "misericordia"]),
        ("Rejection of Evil", "Hatred for wicked paths and injustice", ["iniquus", "odium", "habeo", "via", "dissipo"]),
        ("Divine Timing", "Recognition of God's appointed time", ["tempus", "facio", "dominus"])
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm118AinLineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm118Ain[lineNumber - 1]
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

    func testPsalm118AinThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Ain.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []

        for (themeName, themeDescription, themeLemmas) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }

            if verbose {
                let status = foundLemmas.isEmpty ? "❌" : "✅"
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