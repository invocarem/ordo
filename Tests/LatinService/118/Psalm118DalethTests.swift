import XCTest
@testable import LatinService

class Psalm118DalethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 4
    let id = PsalmIdentity(number: 118, category: "daleth")
    
    // MARK: - Test Data Properties
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
    
    private let lineKeyLemmas = [
        (1, ["adhaereo", "pavimentum", "anima", "vivifico", "secundum", "verbum"]),
        (2, ["enuntio", "exaudio", "doceo", "iustificatio"]),
        (3, ["iustificatio", "instruo", "exerceo", "mirabilis"]),
        (4, ["dormito", "anima", "taedium", "confirmo", "verbum"]),
        (5, ["iniquitas", "amoveo", "lex", "misereor"]),
        (6, ["veritas", "eligo", "iudicium", "obliviscor"]),
        (7, ["adhaereo", "testimonium", "dominus", "confundo"]),
        (8, ["mandatum", "curro", "dilato", "cor"])
    ]
    
    private let themeKeyLemmas = [
        ("Affliction", "References to weariness, clinging to dust, and need for revival", ["adhaereo", "pavimentum", "dormito", "taedium", "confundo", "iniquitas"]),
        ("Petition", "Requests for teaching, confirmation, and mercy", ["vivifico", "exaudio", "doceo", "instruo", "confirmo", "amoveo", "misereor"]),
        ("Path", "Emphasis on choosing, running, and staying on God's path", ["via", "eligo", "curro", "veritas", "iustificatio", "mandatum"]),
        ("Transformation", "Themes of expansion, exercise, and declaration", ["dilato", "exerceo", "enuntio", "obliviscor", "adhaereo", "mirabilis"])
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm118DalethLineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
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

    // MARK: - Combined Theme Test
    func testPsalm118DalethThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Daleth.joined(separator: " "))
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