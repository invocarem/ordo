import XCTest
@testable import LatinService

class Psalm118AlephTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "aleph")
    
    // MARK: - Test Data
    private let psalm118Aleph = [
        "Beati immaculati in via, qui ambulant in lege Domini.",
        "Beati qui scrutantur testimonia eius, in toto corde exquirunt eum.",
        "Non enim qui operantur iniquitatem, in viis eius ambulaverunt.",
        "Tu mandasti mandata tua custodiri nimis.",
        "Utinam dirigantur viae meae, ad custodiendas iustificationes tuas!",
        "Tunc non confundar, cum perspexero in omnibus praeceptis tuis.",
        "Confitebor tibi in directione cordis, in eo quod didici iudicia iustitiae tuae.",
        "Iustificationes tuas custodiam, non me derelinquas usquequaque."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118AlephLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS (common words removed)
        let lineTests = [
            (1, ["beatus", "immaculatus", "ambulo", "dominus"]), // removed via, lex
            (2, ["beatus", "scrutor", "testimonium", "totus", "exquiro"]), // removed cor
            (3, ["enim", "operor", "iniquitas", "ambulo"]), // removed non, via
            (4, ["mando", "mandatum", "custodio", "nimis"]), // removed tu
            (5, ["utinam", "dirigo", "custodio", "iustificatio"]), // removed via
            (6, ["tunc", "confundo", "perspicio", "omnis", "praeceptum"]), // removed non, cum
            (7, ["confiteor", "directio", "disco", "iudicium", "iustitia"]), // removed cor
            (8, ["iustificatio", "custodio", "derelinquo", "usquequaque"]) // removed non
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Aleph[lineNumber - 1]
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
    
    func testBlessednessTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Aleph.joined(separator: " "))
        
        let blessedLemmas = ["beatus", "immaculatus", "confundo", "iustitia", "directio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = blessedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nBLESSEDNESS THEME: Found \(foundLemmas.count)/\(blessedLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 blessedness lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testObedienceTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Aleph.joined(separator: " "))
        
        let obedienceLemmas = ["custodio", "ambulo", "mando", "dirigo", "perspicio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = obedienceLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nOBEDIENCE THEME: Found \(foundLemmas.count)/\(obedienceLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 obedience lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineLawTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Aleph.joined(separator: " "))
        
        let lawLemmas = ["testimonium", "mandatum", "iustificatio", "praeceptum", "iudicium"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = lawLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE LAW THEME: Found \(foundLemmas.count)/\(lawLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine law lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testHeartAndSeekingTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Aleph.joined(separator: " "))
        
        let heartLemmas = ["exquiro", "scrutor", "disco", "confiteor", "usquequaque"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = heartLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nHEART AND SEEKING THEME: Found \(foundLemmas.count)/\(heartLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 heart/seeking lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}