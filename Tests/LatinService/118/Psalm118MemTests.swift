import XCTest
@testable import LatinService

class Psalm118MemTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "mem")
    
    // MARK: - Test Data
    private let psalm118Mem = [
        "Quomodo dilexi legem tuam, Domine! tota die meditatio mea est.",
        "Super inimicos meos prudentem me fecisti mandato tuo, quia in aeternum mihi est.",
        "Super omnes docentes me intellexi, quia testimonia tua meditatio mea est.",
        "Super senes intellexi, quia mandata tua quaesivi.",
        "In omni via mala prohibui pedes meos, ut custodiam verba tua.",
        "A iudiciis tuis non declinavi, quia tu legem posuisti mihi.",
        "Quam dulcia faucibus meis eloquia tua! super mel ori meo.",
        "A mandatis tuis intellexi, propterea odivi omnem viam iniquitatis."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118MemLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS including rare words
        let lineTests = [
            (1, ["quomodo", "diligo", "lex", "dominus", "totus", "dies", "meditatio"]),
            (2, ["super", "inimicus", "prudens", "facio", "mandatum", "quia", "aeternum"]),
            (3, ["super", "omnis", "doceo", "intellego", "quia", "testimonium", "meditatio"]),
            (4, ["super", "senex", "intellego", "quia", "mandatum", "quaero"]),
            (5, ["omnis", "via", "malus", "prohibeo", "pes", "custodio", "verbum"]),
            (6, ["iudicium", "declino", "quia", "lex", "pono"]),
            (7, ["quam", "dulcis", "faux", "eloquium", "super", "mel", "os"]),
            (8, ["mandatum", "intellego", "propterea", "odi", "omnis", "via", "iniquitas"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Mem[lineNumber - 1]
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
    
    func testLoveForLawTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Mem.joined(separator: " "))
        
        let loveLemmas = ["diligo", "meditatio", "quaero", "custodio", "dulcis", "odi"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = loveLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nLOVE FOR LAW THEME: Found \(foundLemmas.count)/\(loveLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 love/affection lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testUnderstandingTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Mem.joined(separator: " "))
        
        let understandingLemmas = ["intellego", "prudens", "doceo", "senex", "testimonium", "propterea"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = understandingLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nUNDERSTANDING THEME: Found \(foundLemmas.count)/\(understandingLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 understanding lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testProtectionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Mem.joined(separator: " "))
        
        let protectionLemmas = ["prohibeo", "custodio", "declino", "super", "inimicus", "malus", "iniquitas"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = protectionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPROTECTION THEME: Found \(foundLemmas.count)/\(protectionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 protection lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineWordTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Mem.joined(separator: " "))
        
        let wordLemmas = ["lex", "mandatum", "testimonium", "verbum", "eloquium", "iudicium"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wordLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE WORD THEME: Found \(foundLemmas.count)/\(wordLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine word lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}