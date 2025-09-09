import XCTest
@testable import LatinService

class Psalm1Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 1, category: nil)
    
    // MARK: - Test Data
    private let psalm1 = [
        "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;",
        "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte.",
        "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:",
        "Et folium eius non defluet, et omnia quaecumque faciet, prosperabuntur.",
        "Non sic impii, non sic: sed tamquam pulvis, quem proicit ventus a facie terrae.",
        "Ideo non resurgent impii in iudicio, neque peccatores in concilio iustorum;",
        "Quoniam novit Dominus viam iustorum: et iter impiorum peribit."
    ]
    
    private let lineKeyLemmas = [
        (1, ["beatus", "vir", "abeo", "consilium", "impius", "via", "peccator", "sto", "cathedra", "pestilentia", "sedeo"]),
        (2, ["lex", "dominus", "voluntas", "meditor", "dies", "nox"]),
        (3, ["lignum", "planto", "secus", "decursus", "aqua", "fructus", "do", "tempus"]),
        (4, ["folium", "defluo", "omnis", "facio", "prospero"]),
        (5, ["impius", "pulvis", "proicio", "ventus", "facies", "terra"]),
        (6, ["resurgo", "impius", "iudicium", "peccator", "concilium", "iustus"]),
        (7, ["nosco", "dominus", "via", "iustus", "iter", "impius", "pereo"])
    ]


private let themeKeyLemmas: [(name: String, description: String, lemmas: [String], category: ThemeCategory)] = [
    (
        "Divine Sovereignty",
        "God's authority and knowledge",
        ["nosco"],
        .divine
    ),
    (
        "Divine Justice",
        "God's righteous judgment", 
        ["pereo", "resurgo", "proicio", "ventus", "pulvis", "terra"],
        .justice
    ),
    (
        "Righteous Worship",
        "The blessed man's devotion",
        ["meditor", "voluntas"],
        .worship
    ),
    (
        "Virtuous Life",
        "Qualities of the righteous person",
        ["beatus", "iustus", "prospero", "fructus", "lignum", "aqua", "folium"],
        .virtue
    ),
    (
        "Spiritual Conflict",
        "Walking in the way of sinners",
        ["peccator", "sto"],
        .conflict
    ),
    (
        "Sinful Nature", 
        "Following counsel of wicked",
        ["impius", "abeo"],
        .sin
    ),
    (
        "Worldly Opposition",
        "Sitting in seat of pestilence",
        ["pestilentia", "sedeo"],
        .opposition
    )
]
   
    // MARK: - Line by Line Key Lemmas Test
    
    func testPsalm1LineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm1[lineNumber - 1]
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
    
    // MARK: - Theme Tests
    
    func testPsalm1Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm1.joined(separator: " "))
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var allFailures: [String] = []
        
        for (themeName, themeDescription, themeLemmas, category) in themeKeyLemmas {
            let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }
            
            if verbose {
                let status = missingLemmas.isEmpty ? "✅" : "❌"
                let colorName = category.rawValue.uppercased()
                print("\n\(status) [\(colorName)] \(themeName): \(themeDescription)")
                print("   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
                
                if !missingLemmas.isEmpty {
                    print("   MISSING: \(missingLemmas.joined(separator: ", "))")
                }
            }
            
            if !missingLemmas.isEmpty {
                allFailures.append("Theme \(themeName) (\(category.rawValue)): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }
        
        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }
}