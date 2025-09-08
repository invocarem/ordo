import XCTest
@testable import LatinService

class Psalm118NunTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 118, category: "nun")
    
    // MARK: - Test Data Properties
    private let psalm118Nun = [
        "Lucerna pedibus meis verbum tuum, et lumen semitis meis.",
        "Iuravi et statui custodire iudicia iustitiae tuae.",
        "Humiliatus sum usquequaque, Domine; vivifica me secundum verbum tuum.",
        "Voluntaria oris mei beneplacita fac, Domine, et iudicia tua doce me.",
        "Anima mea in manibus tuis semper, et legem tuam non sum oblitus.",
        "Posuerunt peccatores laqueum mihi, et de mandatis tuis non erravi.",
        "Hereditate acquisivi testimonia tua in aeternum, quia exsultatio cordis mei sunt.",
        "Inclinavi cor meum ad faciendas iustificationes tuas in aeternum, propter retributionem."
    ]
    
    private let lineKeyLemmas = [
        (1, ["lucerna", "pes", "verbum", "lumen", "semita"]),
        (2, ["iuro", "statuo", "custodio", "iudicium", "iustitia"]),
        (3, ["humilio", "usquequaque", "dominus", "vivifico", "secundum", "verbum"]),
        (4, ["voluntarius", "os", "beneplacitum", "facio", "dominus", "iudicium", "doceo"]),
        (5, ["anima", "manus", "semper", "lex", "obliviscor"]),
        (6, ["pono", "peccator", "laqueus", "mandatum", "erro"]),
        (7, ["hereditas", "acquiro", "testimonium", "aeternum", "exsultatio", "cor"]),
        (8, ["inclino", "cor", "facio", "iustificatio", "aeternum", "retributio"])
    ]
    
    private let themeKeyLemmas = [
        ("Guidance", "God's word as lamp and light, teaching and direction", ["lucerna", "lumen", "semita", "pes", "doceo", "custodio", "erro"]),
        ("Commitment", "Oaths, establishing resolutions, inclining the heart", ["iuro", "statuo", "acquiro", "inclino", "facio", "usquequaque"]),
        ("Humility", "Voluntary offerings, God's good pleasure, depending on God", ["humilio", "voluntarius", "beneplacitum", "exsultatio", "retributio", "vivifico"]),
        ("Eternal", "Inheritance, everlasting testimony, eternal reward", ["aeternum", "hereditas", "semper", "retributio", "acquiro", "testimonium"])
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm118NunLineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm118Nun[lineNumber - 1]
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

 func testPsalm118NunThemes() {
    let analysis = latinService.analyzePsalm(id, text: psalm118Nun.joined(separator: " "))
    let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
    var allFailures: [String] = []
    
    for (themeName, themeDescription, themeLemmas) in themeKeyLemmas {
        let foundLemmas = themeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        let missingLemmas = themeLemmas.filter { !detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            let status = missingLemmas.isEmpty ? "✅" : "❌"
            print("\n\(status) \(themeName.uppercased()): \(themeDescription)")
            print("   Found \(foundLemmas.count)/\(themeLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
            
            if !missingLemmas.isEmpty {
                print("   MISSING: \(missingLemmas.joined(separator: ", "))")
            }
        }
        
        if !missingLemmas.isEmpty {
            allFailures.append("Theme \(themeName): Missing \(missingLemmas.count) of \(themeLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))")
        }
    }
    
    // This line must be present to actually fail the test
    XCTAssertTrue(allFailures.isEmpty, "Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
}
}