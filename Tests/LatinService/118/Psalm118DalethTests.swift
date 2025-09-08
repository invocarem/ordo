import XCTest
@testable import LatinService

class Psalm118DalethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "daleth")
    
    // MARK: - Test Data
    private let psalm118Daleth = [
        "Adhaesit pavimento anima mea, vivifica me secundum verbum tuum.",
        "Vias meas enuntiavi, et exaudisti me; doce me iustificationes tuas.",
        "Viam iustificationum tuarum instrue me, et exercebor in mirabilibus tuis.",
        "Dormitavit anima mea prae taedio, confirma me in verbis tuis.",
        "Viam iniquitatis amove a me, et de lege tua miserere mei.",
        "Viam veritatis elegi, iudicia tua non sum oblitus.",
        "Adhaesi testimoniis tuis, Domine, noli me confundere.",
        "Viam mandatorum tuorum cucurri, cum dilatasti cor meum."
    ]
    
    // MARK: - Line by Line Key Lemmas Test (STRICT - fails for any missing lemma)
    func testPsalm118DalethLineByLineKeyLemmas() {
        // Test that each line contains ALL expected BASE LEMMAS (common words removed)
        let lineTests = [
            (1, ["adhaereo", "pavimentum", "anima", "vivifico", "secundum", "verbum"]),
            (2, ["enuntio", "exaudio", "doceo", "iustificatio"]),
            (3, ["iustificatio", "instruo", "exerceo", "mirabilis"]),
            (4, ["dormito", "anima", "taedium", "confirmo", "verbum"]),
            (5, ["iniquitas", "amoveo", "lex", "misereor"]),
            (6, ["veritas", "eligo", "iudicium", "obliviscor"]),
            (7, ["adhaereo", "testimonium", "dominus", "confundo"]),
            (8, [ "mandatum", "curro", "dilato", "cor"])
        ]
        
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118Daleth[lineNumber - 1]
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
    
    func testAfflictionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Daleth.joined(separator: " "))
        
        let afflictionLemmas = ["adhaereo", "pavimentum", "dormito", "taedium", "confundo", "iniquitas"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = afflictionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nAFFLICTION THEME: Found \(foundLemmas.count)/\(afflictionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 affliction lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testPetitionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Daleth.joined(separator: " "))
        
        let petitionLemmas = ["vivifico", "exaudio", "doceo", "instruo", "confirmo", "amoveo", "misereor"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = petitionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPETITION THEME: Found \(foundLemmas.count)/\(petitionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 petition lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testPathTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Daleth.joined(separator: " "))
        
        let pathLemmas = ["via", "eligo", "curro", "veritas", "iustificatio", "mandatum"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = pathLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPATH THEME: Found \(foundLemmas.count)/\(pathLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 path lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testTransformationTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Daleth.joined(separator: " "))
        
        let transformationLemmas = ["dilato", "exerceor", "enuntio", "obliviscor", "adhaereo", "mirabilis"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = transformationLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nTRANSFORMATION THEME: Found \(foundLemmas.count)/\(transformationLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 transformation lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
}