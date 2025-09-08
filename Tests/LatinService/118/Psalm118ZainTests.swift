import XCTest
@testable import LatinService

class Psalm118ZainTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "zain")
    
    // MARK: - Test Data Properties
    private let psalm118Zain = [
        "Memor esto verbi tui servo tuo, in quo mihi spem dedisti.",
        "Haec me consolata est in humilitate mea, quia eloquium tuum vivificavit me.",
        "Superbi inique agebant usquequaque, a lege autem tua non declinavi.",
        "Memor fui iudiciorum tuorum a saeculo, Domine, et consolatus sum.",
        "Defectio tenuit me, pro peccatoribus derelinquentibus legem tuam.",
        "Cantabiles mihi erant iustificationes tuae in loco peregrinationis meae.",
        "Memor fui nocte nominis tui, Domine, et custodivi legem tuam.",
        "Hoc factum est mihi, quia iustificationes tuas exquisivi."
    ]
    
    private let lineKeyLemmas = [
        (1, ["memor", "verbum", "servus", "spes", "do"]),
        (2, ["hic", "consolor", "humilitas", "quia", "eloquium", "vivifico"]),
        (3, ["superbus", "inique", "ago", "usquequaque", "declino"]),
        (4, ["memor", "sum", "iudicium", "saeculum", "dominus", "consolor"]),
        (5, ["defectio", "teneo", "pro", "peccator", "derelinquo", "lex"]),
        (6, ["cantabilis", "sum", "iustificatio", "locus", "peregrinatio"]),
        (7, ["memor", "nox", "nomen", "dominus", "custodio", "lex"]),
        (8, ["hic", "facio", "quia", "iustificatio", "exquiro"])
    ]
    
    private let themeKeyLemmas = [
        ("Divine Word", "References to God's word, law, and judgments", ["verbum", "eloquium", "iustificatio", "lex", "nomen", "iudicium"]),
        ("Memory", "Themes of remembrance and recalling", ["memor", "memini", "recordor", "reminiscor", "saeculum", "nox"]),
        ("Comfort", "Expressions of consolation and hope", ["consolor", "vivifico", "cantabilis", "spes", "defectio", "peregrinatio"]),
        ("Faithfulness", "Steadfastness amidst adversity and the wicked", ["custodio", "declino", "derelinquo", "superbus", "inique", "peccator", "teneo"])
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm118ZainLineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm118Zain[lineNumber - 1]
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

    // MARK: - Combined Theme Test
    func testPsalm118ZainThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Zain.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []
        
        for (themeName, themeDescription, themeLemmas) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }
            
            if verbose {
                let status = foundLemmas.count >= minimumLemmasPerTheme ? "✅" : "❌"
                print("\n\(status) \(themeName.uppercased()): \(themeDescription)")
                print("   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
                
                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }
            }
            
            if foundLemmas.count < minimumLemmasPerTheme {
                allFailures.append("Theme \(themeName): Found only \(foundLemmas.count) lemmas (needed \(minimumLemmasPerTheme)): \(foundLemmas.joined(separator: ", "))")
            }
        }
        
        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }
}