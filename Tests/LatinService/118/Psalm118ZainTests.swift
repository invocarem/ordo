import XCTest
@testable import LatinService

class Psalm118ZainTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "zain")
    
    // MARK: - Test Data
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
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118ZainLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS including rare words
        let lineTests = [
            (1, ["memor",  "verbum", "servus", "spes", "do"]),
            (2, ["hic", "consolor", "humilitas", "quia", "eloquium", "vivifico"]),
            (3, ["superbus", "inique", "ago", "usquequaque", "declino"]),
            (4, ["memor", "sum", "iudicium", "saeculum", "dominus", "consolor"]),
            (5, ["defectio", "teneo", "pro", "peccator", "derelinquo", "lex"]),
            (6, ["cantabilis", "sum", "iustificatio", "locus", "peregrinatio"]),
            (7, ["memor",  "nox", "nomen", "dominus", "custodio", "lex"]),
            (8, ["hic", "facio", "quia", "iustificatio", "exquiro"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
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
    
    // MARK: - Thematic Tests
    
    func testDivineWordAndPromiseTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Zain.joined(separator: " "))
        
        let wordLemmas = ["verbum", "eloquium", "iustificatio", "lex", "nomen", "iudicium"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wordLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE WORD THEME: Found \(foundLemmas.count)/\(wordLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine word lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testMemoryAndRemembranceTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Zain.joined(separator: " "))
        
        let memoryLemmas = ["memor", "memini", "recordor", "reminiscor", "saeculum", "nox"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = memoryLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nMEMORY THEME: Found \(foundLemmas.count)/\(memoryLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 memory/remembrance lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testComfortAndConsolationTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Zain.joined(separator: " "))
        
        let comfortLemmas = ["consolor", "vivifico", "cantabilis", "spes", "defectio", "peregrinatio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = comfortLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nCOMFORT THEME: Found \(foundLemmas.count)/\(comfortLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 comfort/consolation lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testFaithfulnessAmidstAdversityTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Zain.joined(separator: " "))
        
        let faithfulnessLemmas = ["custodio", "declino", "derelinquo", "superbus", "inique", "peccator", "teneo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = faithfulnessLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nFAITHFULNESS THEME: Found \(foundLemmas.count)/\(faithfulnessLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 faithfulness/adversity lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}