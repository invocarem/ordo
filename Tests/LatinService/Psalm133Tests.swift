import XCTest
@testable import LatinService

class Psalm133Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm133 = [
        "Ecce nunc benedicite Dominum, omnes servi Domini:",
        "Qui statis in domo Domini, in atriis domus Dei nostri.",
        "In noctibus extollite manus vestras in sancta, et benedicite Dominum.",
        "Benedicat te Dominus ex Sion, qui fecit caelum et terram."
    ]
    
    // MARK: - Test Cases
   // MARK: - Grouped Line Tests for Psalm 133
func testPsalm133Lines1and2() {
    let line1 = psalm133[0] // "Ecce nunc benedicite Dominum, omnes servi Domini:"
    let line2 = psalm133[1] // "Qui statis in domo Domini, in atriis domus Dei nostri."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("ecce", ["ecce"], "behold"),
        ("nunc", ["nunc"], "now"),
        ("benedico", ["benedicite"], "bless"),
        ("dominus", ["dominum", "domini"], "Lord"),
        ("servus", ["servi"], "servant"),
        ("sto", ["statis"], "stand"),
        ("domus", ["domo", "domus"], "house"),
        ("atrium", ["atriis"], "courtyard"),
        ("deus", ["dei"], "God"),
        ("noster", ["nostri"], "our")
    ]
    
    if verbose {
        print("\nPSALM 133:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Call to Worship: Urgent 'behold now' imperative")
        print("2. Temple Service: Standing in God's house and courtyards")
        print("3. Communal Identity: 'servi Domini' (servants of the Lord) and 'Dei nostri' (our God)")
    }
    
    // Worship imperatives
    XCTAssertEqual(analysis.dictionary["benedico"]?.forms["benedicite"], 1, "Should find blessing imperative")
    XCTAssertEqual(analysis.dictionary["ecce"]?.forms["ecce"], 1, "Should find attention-getter")
    
    // Temple context
    XCTAssertEqual(analysis.dictionary["domus"]?.forms["domo"], 1, "Should find house reference")
    XCTAssertEqual(analysis.dictionary["atrium"]?.forms["atriis"], 1, "Should find courtyard reference")
    
    // Test divine titles
    let lordReferences = ["dominum", "domini"].reduce(0) {
        $0 + (analysis.dictionary["dominus"]?.forms[$1] ?? 0)
    }
    XCTAssertTrue(lordReferences >= 2, "Should find both Lord references")
}

func testPsalm133Lines3and4() {
    let line3 = psalm133[2] // "In noctibus extollite manus vestras in sancta, et benedicite Dominum."
    let line4 = psalm133[3] // "Benedicat te Dominus ex Sion, qui fecit caelum et terram."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("nox", ["noctibus"], "night"),
        ("extollo", ["extollite"], "lift up"),
        ("manus", ["manus"], "hands"),
        ("sanctus", ["sancta"], "holy place"),
        ("benedico", ["benedicite", "benedicat"], "bless"),
        ("sion", ["sion"], "Zion"),
        ("facio", ["fecit"], "make"),
        ("caelum", ["caelum"], "heaven"),
        ("terra", ["terram"], "earth")
    ]
    
    if verbose {
        print("\nPSALM 133:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Night Worship: 'In noctibus' (in the nights) as special time for praise")
        print("2. Physical Posture: Lifted hands in holy place")
        print("3. Divine Benediction: Reciprocal blessing from Zion's Creator")
    }
    
    // Night worship
    XCTAssertEqual(analysis.dictionary["nox"]?.forms["noctibus"], 1, "Should find night reference")
    XCTAssertEqual(analysis.dictionary["extollo"]?.forms["extollite"], 1, "Should find lifting verb")
    
    // Creation theology
    XCTAssertEqual(analysis.dictionary["facio"]?.forms["fecit"], 1, "Should find creation verb")
    XCTAssertEqual(analysis.dictionary["caelum"]?.forms["caelum"], 1, "Should find heaven reference")
    
    // Test blessing forms
    let blessingForms = ["benedicite", "benedicat"].reduce(0) {
        $0 + (analysis.dictionary["benedico"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(blessingForms, 2, "Should find both imperative and subjunctive blessing forms")
    
    // Test body part metaphor
    XCTAssertEqual(analysis.dictionary["manus"]?.forms["manus"], 1, "Should find hands reference")
} 
    func testBlessingVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm133)
        
        let blessingTerms = [
            ("benedico", ["benedicite", "benedicite", "benedicat"], "bless"),
            ("sanctus", ["sancta"], "holy"),
            ("servus", ["servi"], "servant"),
            ("sion", ["sion"], "Zion")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: blessingTerms)
    }
    
    func testTempleImagery() {
        let analysis = latinService.analyzePsalm(text: psalm133)
        
        let templeTerms = [
            ("domus", ["domo", "domus"], "house"),
            ("atrium", ["atriis"], "court"),
            ("caelum", ["caelum"], "heaven"),
            ("terra", ["terram"], "earth")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: templeTerms)
    }
    
    func testWorshipActions() {
        let analysis = latinService.analyzePsalm(text: psalm133)
        
        let actionTerms = [
            ("sto", ["statis"], "stand"),
            ("extollo", ["extollite"], "lift up"),
            ("facio", ["fecit"], "make")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: actionTerms)
    }
    
    func testTemporalElements() {
        let analysis = latinService.analyzePsalm(text: psalm133)
        
        let timeTerms = [
            ("nunc", ["nunc"], "now"),
            ("nox", ["noctibus"], "night")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: timeTerms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}