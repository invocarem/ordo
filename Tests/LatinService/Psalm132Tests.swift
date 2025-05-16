import XCTest
@testable import LatinService

class Psalm132Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm132 = [
 "Ecce quam bonum, et quam jucundum habitare fratres in unum.",
                "Sicut unguentum in capite, quod descendit in barbam, barbam Aaron,",
                "Quod descendit in oram vestimenti ejus: sicut ros Hermon, qui descendit in montem Sion.",
                "Quoniam illic mandavit Dominus benedictionem, et vitam usque in saeculum."
    ]
// MARK: - Grouped Line Tests for Psalm 132
func testPsalm132Lines1and2() {
    let line1 = psalm132[0] // "Ecce quam bonum, et quam jucundum habitare fratres in unum."
    let line2 = psalm132[1] // "Sicut unguentum in capite, quod descendit in barbam, barbam Aaron,"
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("ecce", ["ecce"], "behold"),
        ("bonus", ["bonum"], "good"),
        ("jucundus", ["jucundum"], "pleasant"),
        ("habito", ["habitare"], "dwell"),
        ("frater", ["fratres"], "brother"),
        ("unus", ["unum"], "one"),
        ("sicut", ["sicut"], "like"),
        ("unguentum", ["unguentum"], "ointment"),
        ("caput", ["capite"], "head"),
        ("descendo", ["descendit"], "descend"),
        ("barba", ["barbam"], "beard"),
        ("Aaron", ["aaron"], "Aaron")
    ]
    
    if verbose {
        print("\nPSALM 132:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Fraternal Unity: 'habitare fratres in unum' (brothers dwelling in unity)")
        print("2. Priestly Anointing: Sacred oil imagery connecting to Aaron")
        print("3. Sensory Descriptions: Goodness (bonum), pleasantness (jucundum), and fragrant oil")
    }
    
    // Unity assertions
    XCTAssertEqual(analysis.dictionary["frater"]?.forms["fratres"], 1, "Should find brothers reference")
    XCTAssertEqual(analysis.dictionary["unus"]?.forms["unum"], 1, "Should find unity reference")
    
    // Anointing imagery
    XCTAssertEqual(analysis.dictionary["unguentum"]?.forms["unguentum"], 1, "Should find ointment reference")
    XCTAssertEqual(analysis.dictionary["aaron"]?.forms["aaron"], 1, "Should find Aaron reference")
    
    // Test sensory adjectives
    let positiveAdjectives = ["bonum", "jucundum"].reduce(0) {
        $0 + (analysis.dictionary["bonus"]?.forms[$1] ?? 0)
        + (analysis.dictionary["jucundus"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(positiveAdjectives, 2, "Should find both 'good' and 'pleasant' descriptors")
}

func testPsalm132Lines3and4() {
    let line3 = psalm132[2] // "Quod descendit in oram vestimenti ejus: sicut ros Hermon, qui descendit in montem Sion."
    let line4 = psalm132[3] // "Quoniam illic mandavit Dominus benedictionem, et vitam usque in saeculum."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("ora", ["oram"], "edge"),
        ("vestimentum", ["vestimenti"], "garment"),
        ("ros", ["ros"], "dew"),
        ("Hermon", ["hermon"], "Hermon"),
        ("mons", ["montem"], "mountain"),
        ("Sion", ["sion"], "Zion"),
        ("mando", ["mandavit"], "command"),
        ("benedictio", ["benedictionem"], "blessing"),
        ("vita", ["vitam"], "life"),
        ("saeculum", ["saeculum"], "age/eternity")
    ]
    
    if verbose {
        print("\nPSALM 132:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Abundant Blessing: Dew imagery from Hermon to Zion")
        print("2. Sacred Geography: Movement from northern Hermon to Jerusalem")
        print("3. Eternal Promise: Divine command for perpetual blessing and life")
    }
    
    // Nature imagery
    XCTAssertEqual(analysis.dictionary["ros"]?.forms["ros"], 1, "Should find dew reference")
    XCTAssertEqual(analysis.dictionary["hermon"]?.forms["hermon"], 1, "Should find Hermon reference")
    
    // Divine promises
    XCTAssertEqual(analysis.dictionary["benedictio"]?.forms["benedictionem"], 1, "Should find blessing reference")
    XCTAssertEqual(analysis.dictionary["vita"]?.forms["vitam"], 1, "Should find life reference")
    
    // Test geographic terms
    let geographicTerms = ["hermon", "sion"].reduce(0) {
        $0 + (analysis.dictionary["hermon"]?.forms[$1] ?? 0)
        + (analysis.dictionary["sion"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(geographicTerms, 2, "Should find both Hermon and Zion references")
    
    // Test verb tenses
    XCTAssertEqual(analysis.dictionary["mando"]?.forms["mandavit"], 1, "Should find past tense 'commanded'")
}

}