import XCTest
@testable import LatinService

class Psalm118BethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "beth")
    
    // MARK: - Test Data
    private let psalm118Beth = [
        "In quo corrigit adolescentior viam suam? In custodiendo sermones tuos.",
        "In toto corde meo exquisivi te, ne repellas me a mandatis tuis.",
        "In corde meo abscondi eloquia tua, ut non peccem tibi.",
        "Benedictus es, Domine, doce me iustificationes tuas.",
        "In labiis meis pronuntiavi omnia iudicia oris tui.",
        "In via testimoniorum tuorum delectatus sum, sicut in omnibus divitiis.",
        "In mandatis tuis exercebor, et considerabo vias tuas.",
        "In iustificationibus tuis meditabor, non obliviscar sermones tuos."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118BethLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS (common words removed)
        let lineTests = [
            (1, ["corrigo", "adolescens", "custodio", "sermo"]), // removed in, quo, via, suus
            (2, ["totus", "exquiro", "repello", "mandatum"]), // removed in, cor, meus, ne
            (3, ["abscondo", "eloquium", "pecco"]), // removed in, cor, meus, ut, non, tibi
            (4, ["benedictus", "dominus", "doceo", "iustificatio"]), // removed es, me
            (5, ["labium", "pronuntio", "omnis", "iudicium", "os"]), // removed in, meus
            (6, ["testimonium", "delecto", "sicut", "divitiae"]), // removed in, via, omnis
            (7, ["mandatum", "exerceo", "considero"]), // removed in, tuus, et, via
            (8, ["iustificatio", "meditor", "obliviscor", "sermo"]) // removed in, tuus, non
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Beth[lineNumber - 1]
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
    
    func testInstructionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Beth.joined(separator: " "))
        
        let instructionLemmas = ["corrigo", "doceo", "pronuntio", "considero", "meditor"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = instructionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nINSTRUCTION THEME: Found \(foundLemmas.count)/\(instructionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 instruction lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDelightTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Beth.joined(separator: " "))
        
        let delightLemmas = ["delector", "divitiae", "benedictus", "exquiro", "abscondo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = delightLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDELIGHT THEME: Found \(foundLemmas.count)/\(delightLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 delight lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineWordTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Beth.joined(separator: " "))
        
        let wordLemmas = ["sermo", "eloquium", "iustificatio", "testimonium", "iudicium", "mandatum"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wordLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE WORD THEME: Found \(foundLemmas.count)/\(wordLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine word lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testProtectionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Beth.joined(separator: " "))
        
        let protectionLemmas = ["custodio", "repello", "abscondo", "obliviscor", "pecco", "adolescentior"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = protectionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPROTECTION THEME: Found \(foundLemmas.count)/\(protectionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 protection lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}