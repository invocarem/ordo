@testable import LatinService
import XCTest

class Psalm90Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 90, category: "")

    // MARK: - Test Data Properties

    private let psalm90 = [
        "Qui habitat in adiutorio Altissimi, in protectione Dei caeli commorabitur.",
        "Dicet Domino: Susceptor meus es tu, et refugium meum; Deus meus, sperabo in eum.",
        "Quoniam ipse liberavit me de laqueo venantium, et a verbo aspero.",
        "Scapulis suis obumbrabit tibi, et sub pennis eius sperabis.",
        "Scuto circumdabit te veritas eius; non timebis a timore nocturno,",
        "A sagitta volante per diem, a negotio perambulante in tenebris, ab incursu et daemonio meridiano.",
        "Cadent a latere tuo mille, et decem milia a dextris tuis; ad te autem non appropinquabit.",
        "Verumtamen oculis tuis considerabis, et retributionem peccatorum videbis.",
        "Quoniam tu es, Domine, spes mea; Altissimum posuisti refugium tuum.",
        "Non accedet ad te malum, et flagellum non appropinquabit tabernaculo tuo.",
        "Quoniam angelis suis mandavit de te, ut custodiant te in omnibus viis tuis.",
        "In manibus portabunt te, ne forte offendas ad lapidem pedem tuum.",
        "Super aspidem et basiliscum ambulabis, et conculcabis leonem et draconem.",
        "Quoniam in me speravit, liberabo eum; protegam eum quoniam cognovit nomen meum.",
        "Clamabit ad me, et ego exaudiam eum; cum ipso sum in tribulatione, eripiam eum et glorificabo eum.",
        "Longitudine dierum replebo eum, et ostendam illi salutare meum.",
    ]

    private let lineKeyLemmas = [
        (1, ["habito", "adiutorium", "altissimus", "protectio", "deus", "caelum", "commoror"]),
        (2, ["dico", "dominus", "susceptor", "refugium", "deus", "spero"]),
        (3, ["quoniam", "ipse", "libero", "laqueus", "venor", "verbum", "asper"]),
        (4, ["scapula", "obumbro", "penna", "spero"]),
        (5, ["scutum", "circumdo", "veritas", "timeo", "timor", "nocturnus"]),
        (6, ["sagitta", "volo", "dies", "negotium", "perambulo", "tenebrae", "incursus", "daemonium", "meridianus"]),
        (7, ["cado", "latus", "mille", "decem",  "dexter", "appropinquo"]),
        (8, ["verumtamen", "oculus", "considero", "retributio", "peccatum", "video"]),
        (9, ["quoniam", "dominus", "spes", "altissimus", "pono", "refugium"]),
        (10, ["accedo", "malum", "flagellum", "appropinquo", "tabernaculum"]),
        (11, ["quoniam", "angelus", "mando", "custodio", "omnis", "via"]),
        (12, ["manus", "porto", "offendo", "lapis", "pes"]),
        (13, ["aspis", "basiliscus", "ambulo", "conculco", "leo", "draco"]),
        (14, ["quoniam", "spero", "libero", "protego", "cognosco", "nomen"]),
        (15, ["clamo", "exaudio", "cum", "ipse", "sum", "tribulatio", "eripio", "glorifico"]),
        (16, ["longitudo", "dies", "repleo", "ostendo", "salutare"]),
    ]

    private let themeKeyLemmas = [
        ("Refuge", "God as shelter and safe haven", ["refugium", "adiutorium", "susceptor", "commoror", "tabernaculum"]),
        ("Hope", "Confidence and expectation in God", ["spero", "spes",  "considero"]),
        ("Evil and Danger", "Threats, traps, and spiritual enemies", ["laqueus", "daemonium", "malum", "incursus", "aspis", "basiliscus", "leo", "draco"]),
        ("Protection", "God's covering and defense", ["scutum", "obumbro", "circumdo", "protego", "custodio", "porto"]),
        ("Deliverance", "Rescue and salvation from danger", ["libero", "eripio", "salutare", "timeo", "appropinquo"]),
        ("Divine Response", "God's answering and presence", ["exaudio", "clamo", "ostendo", "glorifico", "video"]),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm90LineByLineKeyLemmas() {
        var allFailures: [String] = []

        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm90[lineNumber - 1]
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

    func testPsalm90Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm90.joined(separator: " "))
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
