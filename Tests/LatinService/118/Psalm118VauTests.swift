import XCTest
@testable import LatinService

class Psalm118VauTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "vau")
    
    // MARK: - Test Data
    private let psalm118Vau = [
        "Et veniat super me misericordia tua, Domine, salutare tuum secundum eloquium tuum.",
        "Et respondebo exprobrantibus mihi verbum, quia speravi in sermonibus tuis.",
        "Et ne auferas de ore meo verbum veritatis usquequaque, quia in iudiciis tuis supersperavi.",
        "Et custodiam legem tuam semper, in saeculum et in saeculum saeculi.",
        "Et ambulabam in latitudine, quia mandata tua exquisivi.",
        "Et loquebar de testimoniis tuis in conspectu regum, et non confundebar.",
        "Et meditabar in mandatis tuis, quae dilexi.",
        "Et levavi manus meas ad mandata tua quae dilexi, et exercebar in iustificationibus tuis."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118VauLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS including rare words
        let lineTests = [
            (1, ["venio", "super", "misericordia", "dominus", "salutare", "secundum", "eloquium"]),
            (2, ["respondeo", "exprobro", "verbum", "spero", "sermo"]),
            (3, ["aufero", "os", "verbum", "veritas", "usquequaque", "iudicium", "superspero"]),
            (4, ["custodio", "lex", "semper", "saeculum"]),
            (5, ["ambulo", "latitudo", "mandatum", "exquiro"]),
            (6, ["loquor", "testimonium", "conspectus", "rex", "confundo"]),
            (7, ["meditor", "mandatum", "diligo"]),
            (8, ["levo", "manus", "mandatum", "diligo", "exerceo", "iustificatio"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Vau[lineNumber - 1]
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
    
    func testDivineMercyAndSalvationTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Vau.joined(separator: " "))
        
        let mercyLemmas = ["misericordia", "salutare", "eloquium", "spero", "superspero", "venio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = mercyLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE MERCY THEME: Found \(foundLemmas.count)/\(mercyLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine mercy/salvation lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testWordAndTruthTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Vau.joined(separator: " "))
        
        let wordLemmas = ["verbum", "veritas", "eloquium", "sermo", "testimonium", "mandatum"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wordLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nWORD AND TRUTH THEME: Found \(foundLemmas.count)/\(wordLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 word/truth lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testFaithfulObedienceTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Vau.joined(separator: " "))
        
        let obedienceLemmas = ["custodio", "ambulo", "exquiro", "loquor", "meditor", "exerceo", "levo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = obedienceLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nOBEDIENCE THEME: Found \(foundLemmas.count)/\(obedienceLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 obedience/action lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testProtectionAndConfidenceTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Vau.joined(separator: " "))
        
        let confidenceLemmas = ["respondeo", "confundo", "rex", "conspectus", "usquequaque", "latitudo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = confidenceLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nCONFIDENCE THEME: Found \(foundLemmas.count)/\(confidenceLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 confidence/protection lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}