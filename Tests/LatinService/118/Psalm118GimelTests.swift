import XCTest
@testable import LatinService

class Psalm118GimelTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 4
    let id = PsalmIdentity(number: 118, category: "gimel")
    
    // MARK: - Test Data Properties
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
    
    private let lineKeyLemmas = [
        (1, ["retribuo", "servus", "vivifico", "custodio", "sermo"]),
        (2, ["revelo", "oculus", "considero", "mirabilis", "lex"]),
        (3, ["incola", "terra", "abscondo", "mandatum"]),
        (4, ["concupisco", "anima", "desidero", "iustificatio", "omnis", "tempus"]),
        (5, ["increpo", "superbus", "maledictus", "declino", "mandatum"]),
        (6, ["aufero", "opprobrium", "contemptus", "testimonium", "exquiro"]),
        (7, ["etenim", "sedeo", "princeps", "adversus", "loquor", "servus", "exerceo", "iustificatio"]),
        (8, ["nam", "testimonium", "meditatio", "consilium", "iustificatio"])
    ]
    
    private let themeKeyLemmas = [
        ("Petition", "Requests for God's action and intervention", ["retribuo", "vivifico", "revelo", "abscondo", "aufero", "concupisco"]),
        ("Opposition", "References to enemies, pride, and opposition", ["superbus", "maledictus", "increpo", "opprobrium", "contemptus", "princeps", "adversus"]),
        ("Devotion", "Expressions of commitment, exercise, and meditation", ["custodio", "considero", "exquiro", "exerceo", "meditatio", "desidero"]),
        ("Divine Word", "References to God's law, statutes, and testimonies", ["sermo", "lex", "mandatum", "iustificatio", "testimonium", "mirabilis"])
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm118GimelLineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
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

    // MARK: - Combined Theme Test
    func testPsalm118GimelThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Gimel.joined(separator: " "))
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