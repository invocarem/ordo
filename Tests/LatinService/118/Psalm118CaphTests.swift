import XCTest
@testable import LatinService

class Psalm118CaphTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "caph")
    
    // MARK: - Test Data
    private let psalm118Caph = [
        "Defecit in salutare tuum anima mea, et in verbum tuum supersperavi.",
        "Defecerunt oculi mei in eloquium tuum, dicentes: Quando consolaberis me?",
        "Quia factus sum sicut uter in pruina, iustificationes tuas non sum oblitus.",
        "Quot sunt dies servi tui? quando facies de persequentibus me iudicium?",
        "Narraverunt mihi iniqui fabulationes, sed non ut lex tua.",
        "Omnia mandata tua veritas; inique persecuti sunt me, adiuva me.",
        "Paulo minus consummaverunt me in terra, ego autem non dereliqui mandata tua.",
        "Secundum misericordiam tuam vivifica me, et custodiam testimonia oris tui."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118CaphLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS including rare words
        let lineTests = [
            (1, ["deficio", "salus", "anima", "verbum", "superspero"]),
            (2, ["deficio", "oculus", "eloquium", "dico", "quando", "consolor"]),
            (3, ["quia", "facio", "sicut", "uter", "pruina", "iustificatio", "obliviscor"]),
            (4, ["quot", "dies", "servus", "quando", "facio", "persequor", "iudicium"]),
            (5, ["narro", "iniquus", "fabulatio", "lex"]),
            (6, ["omnis", "mandatum", "veritas", "inique", "persequor", "adiuvo"]),
            (7, ["paulus", "minus", "consummo", "terra", "derelinquo", "mandatum"]),
            (8, ["secundum", "misericordia", "vivifico", "custodio", "testimonium", "os"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Caph[lineNumber - 1]
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
    
    func testLongingForSalvationTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Caph.joined(separator: " "))
        
        let salvationLemmas = ["deficio", "salus", "superspero", "consolor", "vivifico", "adiuvo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = salvationLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nLONGING FOR SALVATION THEME: Found \(foundLemmas.count)/\(salvationLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 salvation-longing lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testPersecutionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Caph.joined(separator: " "))
        
        let persecutionLemmas = ["persequor", "iniquus", "consummo", "terra", "fabulatio", "iudicium"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = persecutionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPERSECUTION THEME: Found \(foundLemmas.count)/\(persecutionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 persecution lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testFaithfulnessTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Caph.joined(separator: " "))
        
        let faithfulnessLemmas = ["custodio", "derelinquo", "obliviscor", "mandatum", "testimonium", "iustificatio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = faithfulnessLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nFAITHFULNESS THEME: Found \(foundLemmas.count)/\(faithfulnessLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 faithfulness lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineWordTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Caph.joined(separator: " "))
        
        let wordLemmas = ["verbum", "eloquium", "lex", "mandatum", "veritas", "testimonium"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wordLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE WORD THEME: Found \(foundLemmas.count)/\(wordLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine word lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}