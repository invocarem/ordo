import XCTest
@testable import LatinService

class Psalm118PeTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 118, category: "pe")
    
    // MARK: - Test Data Properties
    private let psalm118Pe = [
        "Mirabilia testimonia tua, ideo scrutata est ea anima mea.",
        "Declaratio sermonum tuorum illuminat, et intellectum dat parvulis.",
        "Os meum aperui et attraxi spiritum, quia mandata tua desiderabam.",
        "Aspice in me et miserere mei, secundum iudicium diligentium nomen tuum.",
        "Gressus meos dirige secundum eloquium tuum, et non dominetur mei omnis iniquitas.",
        "Redime me a calumniis hominum, ut custodiam mandata tua.",
        "Faciem tuam illumina super servum tuum, et doce me iustificationes tuas.",
        "Exitus aquae deduxerunt oculi mei, quia non custodierunt legem tuam."
    ]
    
    private let lineKeyLemmas = [
        (1, ["mirabilis", "testimonium", "ideo", "scrutor", "anima"]),
        (2, ["declaratio", "sermo", "illumino", "intellectus", "do", "parvulus"]),
        (3, ["os", "aperio", "attraho", "spiritus", "quia", "mandatum", "desidero"]),
        (4, ["aspicio", "misereor", "secundum", "iudicium", "diligo", "nomen"]),
        (5, ["gressus", "dirigo", "secundum", "eloquium", "non", "dominor", "omnis", "iniquitas"]),
        (6, ["redimo", "calumnia", "homo", "ut", "custodio", "mandatum"]),
        (7, ["facies", "illumino", "super", "servus", "doceo", "iustificatio"]),
        (8, ["exitus", "aqua", "deduco", "oculus", "quia", "non", "custodio", "lex"])
    ]
    
    private let themeKeyLemmas = [
        ("Divine Revelation", "God's wondrous testimonies and illuminating word", ["mirabilis", "testimonium", "declaratio", "illumino", "intellectus", "eloquium"]),
        ("Desire and Longing", "Soul's yearning for God's commandments", ["scrutor", "desidero", "anima", "spiritus", "diligo"]),
        ("Prayer for Guidance", "Requests for direction, mercy, and redemption", ["dirigo", "aspicio", "misereor", "redimo", "custodio"]),
        ("Protection from Evil", "Deliverance from iniquity and human calumny", ["iniquitas", "calumnia", "dominor", "non", "homo"]),
        ("Divine Instruction", "Teaching of God's statutes and commandments", ["doceo", "iustificatio", "mandatum", "lex", "nomen"]),
        ("Emotional Response", "Physical expressions of spiritual longing", ["os", "aperio", "attraho", "oculus", "exitus", "aqua", "deduco"])
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm118PeLineByLineKeyLemmas() {
        var allFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineKeyLemmas {
            let line = psalm118Pe[lineNumber - 1]
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

    func testPsalm118PeThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm118Pe.joined(separator: " "))
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
                allFailures.append("Theme \(themeName): Missing \(missingLemmas.count) lemmas: \(missingLemmas.joined(separator: ", "))")
            }
        }
        
        if !allFailures.isEmpty {
            XCTFail("Theme lemma requirements not met:\n" + allFailures.joined(separator: "\n"))
        }
    }
}