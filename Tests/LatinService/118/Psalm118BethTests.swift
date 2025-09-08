import XCTest
@testable import LatinService

class Psalm118BethTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 118, category: "beth")
    
    // MARK: - Test Data Properties
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
    
    private let lineKeyLemmas = [
        (1, ["corrigo", "adolescens", "custodio", "sermo"]),
        (2, ["totus", "exquiro", "repello", "mandatum"]),
        (3, ["abscondo", "eloquium", "pecco"]),
        (4, ["benedictus", "dominus", "doceo", "iustificatio"]),
        (5, ["labium", "pronuntio", "omnis", "iudicium", "os"]),
        (6, ["testimonium", "delecto", "sicut", "divitiae"]),
        (7, ["mandatum", "exerceo", "considero"]),
        (8, ["iustificatio", "meditor", "obliviscor", "sermo"])
    ]
    
    private let themeKeyLemmas = [
        ("Instruction", "Focus on correction, teaching, and meditation", ["corrigo", "doceo", "pronuntio", "considero", "meditor"]),
        ("Delight", "Emphasis on delighting in God's word and blessings", ["delecto", "divitiae", "benedictus", "exquiro", "abscondo"]),
        ("Divine Word", "References to God's words, statutes, and judgments", ["sermo", "eloquium", "iustificatio", "testimonium", "iudicium", "mandatum"]),
        ("Protection", "Themes of guarding, protecting, and not forgetting", ["custodio", "repello", "abscondo", "obliviscor", "pecco", "adolescentior"])
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm118BethLineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
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

    // MARK: - Combined Theme Test
    func testPsalm118BethThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Beth.joined(separator: " "))
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