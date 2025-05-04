import XCTest
@testable import LatinService

class Psalm133Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
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