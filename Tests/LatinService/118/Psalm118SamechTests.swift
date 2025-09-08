@testable import LatinService
import XCTest

class Psalm118SamechTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 118, category: "Samech")

    // MARK: - Test Data Properties

    private let psalm118Samech = [
        "Iniquos odio habui, et legem tuam dilexi.",
        "Adiutor et susceptor meus es tu, et in verbum tuum supersperavi.",
        "Declinate a me, maligni, et scrutabor mandata Dei mei.",
        "Suscita me secundum verbum tuum, et vivam, et non confundas me ab exspectatione mea.",
        "Adiuva me, et salvus ero, et meditabor in iustificationibus tuis semper.",
        "Sprevisti omnes discedentes a iudiciis tuis, quia iniqua cogitatio eorum.",
        "Praevaricantes reputavi omnes peccatores terrae, ideo dilexi testimonia tua.",
        "Confige timore tuo carnes meas, a iudiciis enim tuis timui.",
    ]

    private let lineKeyLemmas = [
        (1, ["iniquus", "odium", "lex", "diligo"]),
        (2, ["adiutor", "susceptor", "verbum", "superspero"]),
        (3, ["declino", "malignus", "scrutor", "mandatum", "deus"]),
        (4, ["suscito", "secundum", "verbum", "vivo", "confundo", "exspectatio"]),
        (5, ["adiuvo", "salvus", "meditor", "iustificatio", "semper"]),
        (6, ["sperno", "discedo", "iudicium", "iniquus", "cogitatio"]),
        (7, ["praevaricor", "reputo", "peccator", "terra", "diligo", "testimonium"]),
        (8, ["configo", "timor", "caro", "iudicium", "timeo"]),
    ]

    private let themeKeyLemmas = [
        ("Love for God's Law", "Affection and devotion to God's commandments", ["lex", "diligo", "mandatum", "testimonium", "iustificatio"]),
        ("Divine Assistance", "God as helper and sustainer", ["adiutor", "susceptor", "adiuvo", "suscito", "salvus"]),
        ("Separation from Evil", "Rejection of wickedness and sinners", ["iniquus", "odium", "declino", "malignus", "sperno", "discedo", "praevaricor", "peccator"]),
        ("Trust and Hope", "Confidence in God's word and promises", ["verbum", "superspero", "exspectatio", "semper"]),
        ("Fear of God", "Reverential awe and obedience", ["timor", "timeo", "iudicium", "configo"]),
        ("Internal Reflection", "Examination of thoughts and meditation", ["cogitatio", "meditor", "reputo", "caro"]),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm118SamechLineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm118Samech[lineNumber - 1]
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

    func testPsalm118SamechThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Samech.joined(separator: " "))
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
