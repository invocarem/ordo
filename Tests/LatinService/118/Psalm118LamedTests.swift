import XCTest
@testable import LatinService

class Psalm118LamedTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "lamed")
    
    // MARK: - Test Data
    private let psalm118Lamed = [
        "In aeternum, Domine, verbum tuum permanet in caelo.",
        "In generationem et generationem veritas tua; fundasti terram, et permanet.",
        "Ordinatione tua perseverat dies, quoniam omnia serviunt tibi.",
        "Nisi quod lex tua meditatio mea est, tunc forte periissem in humilitate mea.",
        "In aeternum non obliviscar iustificationes tuas, quia in ipsis vivificasti me.",
        "Tuus sum ego, salvum me fac, quoniam iustificationes tuas exquisivi.",
        "Me exspectaverunt peccatores ut perderent me; testimonia tua intellexi.",
        "Omnis consummationis vidi finem, latum mandatum tuum nimis."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118LamedLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS including rare words
        let lineTests = [
            (1, ["aeternum", "dominus", "verbum", "permaneo", "caelum"]),
            (2, ["generatio", "veritas", "fundo", "terra", "permaneo"]),
            (3, ["ordinatio", "persevero", "dies", "quoniam", "omnis", "servio"]),
            (4, ["nisi", "lex", "meditatio", "tunc", "forte", "pereo", "humilitas"]),
            (5, ["aeternum", "obliviscor", "iustificatio", "quia", "vivifico"]),
            (6, ["tuus", "sum", "salvus", "facio", "quoniam", "iustificatio", "exquiro"]),
            (7, ["exspecto", "peccator", "perdo", "testimonium", "intellego"]),
            (8, ["omnis", "consummatio", "video", "finis", "latus", "mandatum", "nimis"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Lamed[lineNumber - 1]
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
    
    func testEternalWordTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Lamed.joined(separator: " "))
        
        let eternalLemmas = ["aeternum", "permaneo", "generatio", "veritas", "ordinatio", "persevero"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = eternalLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nETERNAL WORD THEME: Found \(foundLemmas.count)/\(eternalLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 eternal/enduring lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineCreationTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Lamed.joined(separator: " "))
        
        let creationLemmas = ["fundo", "terra", "caelum", "servio", "omnis", "ordinatio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = creationLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE CREATION THEME: Found \(foundLemmas.count)/\(creationLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 creation lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testSalvationTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Lamed.joined(separator: " "))
        
        let salvationLemmas = ["vivifico", "salvus", "facio", "pereo", "humilitas", "obliviscor"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = salvationLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nSALVATION THEME: Found \(foundLemmas.count)/\(salvationLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 salvation lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testUnderstandingTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Lamed.joined(separator: " "))
        
        let understandingLemmas = ["intellego", "meditatio", "exquiro", "video", "finis", "consummatio", "latus"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = understandingLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nUNDERSTANDING THEME: Found \(foundLemmas.count)/\(understandingLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 understanding/insight lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}