import XCTest
@testable import LatinService

class Psalm127Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 127, category: nil)
    
    // MARK: - Test Data
    let psalm127 = [
        "Beati omnes qui timent Dominum, qui ambulant in viis ejus.",
        "Labores fructuum tuorum manducabis; beatus es, et bene tibi erit.",
        "Uxor tua sicut vitis abundans in lateribus domus tuae; filii tui sicut novellae olivarum in circuitu mensae tuae.",
        "Ecce sic benedicetur homo qui timet Dominum.",
        "Benedicat tibi Dominus ex Sion, et videas bona Jerusalem omnibus diebus vitae tuae.",
        "Et videas filios filiorum tuorum. Pax super Israel!"
    ]
    
    // MARK: - Test Cases
    
    // 1. Test Blessedness and Fear of the Lord
    func testBlessednessAndFearOfLord() {
        let analysis = latinService.analyzePsalm(id, text: psalm127)
        
        let blessedTerms = [
            ("beatus", ["Beati", "beatus"], "blessed"),
            ("timeo", ["timent", "timet"], "fear"),
            ("Dominus", ["Dominum", "Dominus"], "Lord"),
            ("ambulo", ["ambulant"], "walk"),
            ("via", ["viis"], "way")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: blessedTerms)
    }
    
    // 2. Test Labor and Reward
    func testLaborAndReward() {
        let analysis = latinService.analyzePsalm(id, text: psalm127)
        
        let laborTerms = [
            ("labor", ["Labores"], "labor"),
            ("fructus", ["fructuum"], "fruit"),
            ("manduco", ["manducabis"], "eat"),
            ("bene", ["bene"], "well"),
            ("bonus", ["bona"], "good")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: laborTerms)
    }
    
    // 3. Test Family Blessings
    func testFamilyBlessings() {
        let analysis = latinService.analyzePsalm(id, text: psalm127)
        
        let familyTerms = [
            ("uxor", ["Uxor"], "wife"),
            ("vitis", ["vitis"], "vine"),
            ("domus", ["domus", "domus"], "house"),
            ("filius", ["filii", "filiorum"], "son"),
            ("oliva", ["olivarum"], "olive")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: familyTerms)
    }
    
    // 4. Test Domestic Imagery
    func testDomesticImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm127)
        
        let domesticTerms = [
            ("latus", ["lateribus"], "wide"),
            ("mensa", ["mensae"], "table"),
            ("novellus", ["novellae"], "young"),
            ("circuitus", ["circuitu"], "around"),
            ("abundo", ["abundans"], "abound")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: domesticTerms)
    }
    
    // 5. Test National Blessings
    func testNationalBlessings() {
        let analysis = latinService.analyzePsalm(id, text: psalm127)
        
        let nationalTerms = [
            ("benedico", ["benedicetur", "benedicat"], "bless"),
            ("sion", ["sion"], "zion"),
            ("vita", ["vitae"], "life"),
            ("pax", ["Pax"], "peace")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: nationalTerms)
    }
    
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm127)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'beatus' forms:", analysis.dictionary["beatus"]?.forms ?? [:])
            print("'filius' forms:", analysis.dictionary["filius"]?.forms ?? [:])
            print("'Dominus' forms:", analysis.dictionary["Dominus"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    // MARK: - Helper (Case-Insensitive)
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Case-insensitive translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Case-insensitive form check
            let entryFormsLowercased = Dictionary(uniqueKeysWithValues:
                entry.forms.map { ($0.key.lowercased(), $0.value) }
            )
            
            let missingForms = forms.filter { entryFormsLowercased[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entryFormsLowercased[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}