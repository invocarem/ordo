import XCTest
@testable import LatinService

class Psalm118GimelTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "gimel")
    
    // MARK: - Test Data
    private let psalm118Gimel = [
        "Retribue servo tuo, vivifica me, et custodiam sermones tuos.",
        "Revela oculos meos, et considerabo mirabilia de lege tua.",
        "Incola ego sum in terra, non abscondas a me mandata tua.",
        "Concupivit anima mea desiderare iustificationes tuas in omni tempore.",
        "Increpasti superbos, maledicti qui declinant a mandatis tuis.",
        "Aufer a me opprobrium et contemptum, quia testimonia tua exquisivi.",
        "Etenim sederunt principes, et adversum me loquebantur; servus autem tuus exercebatur in iustificationibus tuis.",
        "Nam et testimonia tua meditatio mea est, et consilium meum iustificationes tuae."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118GimelLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS (common words removed)
        let lineTests = [
            (1, ["retribuo", "servus", "vivifico", "custodio", "sermo"]),
            (2, ["revelo", "oculus", "considero", "mirabilis", "lex"]),
            (3, ["incola", "terra", "abscondo", "mandatum"]),
            (4, ["concupisco", "anima", "desidero", "iustificatio", "omnis", "tempus"]),
            (5, ["increpo", "superbus", "maledictus", "declino", "mandatum"]),
            (6, ["aufero", "opprobrium", "contemptus", "testimonium", "exquiro"]),
            (7, ["etenim", "sedeo", "princeps", "adversus", "loquor", "servus", "exerceo", "iustificatio"]),
            (8, ["nam", "testimonium", "meditatio", "consilium", "iustificatio"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Gimel[lineNumber - 1]
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
    
    func testPetitionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Gimel.joined(separator: " "))
        
        let petitionLemmas = ["retribuo", "vivifico", "revelo", "abscondo", "aufero", "concupisco"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = petitionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPETITION THEME: Found \(foundLemmas.count)/\(petitionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 petition lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testOppositionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Gimel.joined(separator: " "))
        
        let oppositionLemmas = ["superbus", "maledictus", "increpo", "opprobrium", "contemptus", "princeps", "adversum"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = oppositionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nOPPOSITION THEME: Found \(foundLemmas.count)/\(oppositionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 opposition lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDevotionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Gimel.joined(separator: " "))
        
        let devotionLemmas = ["custodio", "considero", "exquiro", "exerceo", "meditatio", "desidero"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = devotionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDEVOTION THEME: Found \(foundLemmas.count)/\(devotionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 devotion lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineWordTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Gimel.joined(separator: " "))
        
        let wordLemmas = ["sermo", "lex", "mandatum", "iustificatio", "testimonium", "mirabilis"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wordLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE WORD THEME: Found \(foundLemmas.count)/\(wordLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine word lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}