import XCTest
@testable import LatinService

class Psalm119Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 119, section: nil)
    
    // MARK: - Test Data
    let psalm119 = [
        "Ad Dominum cum tribularer clamavi, et exaudivit me.",
        "Domine, libera anima mea a labiis iniquis, et a lingua dolosa.",
        "Quid detur tibi, aut quid apponatur tibi ad linguam dolosam?",
        "Sagittae potentis acutae, cum carbonibus desolatoriis.",
        "Heu mihi, quia incolatus meus prolongatus est: habitavi cum habitantibus Cedar.",
        "Multum incola fuit anima mea cum his qui oderunt pacem.",
        "Ego pacem quaerebam: et cum loquerer illis, impugnabant me gratis."
    ]
    
    // MARK: - Test Cases
    
    func testPersecutionVocabulary() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let persecutionTerms = [
            ("tribulor", ["tribularer"], "be distressed"), // v.1
            ("iniquus", ["iniquis"], "unjust"), // v.2
            ("impugno", ["impugnabant"], "attack"), // v.7
            ("desolatorius", ["desolatoriis"], "destructive") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: persecutionTerms)
    }
    
    func testLinguisticImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let speechTerms = [
            ("labium", ["labiis"], "lips"), // v.2
            ("lingua", ["lingua", "linguam"], "tongue"), // v.2, v.3
            ("loquor", ["loquerer"], "speak") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: speechTerms)
    }
    
    func testGeographicalReferences() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let places = [
            ("Cedar", ["Cedar"], "Kedar"), // v.5
            ("incolatus", ["incolatus"], "sojourn") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: places)
    }
    
    func testMilitaryMetaphors() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let weaponTerms = [
            ("sagitta", ["Sagittae"], "arrow"), // v.4
            ("carbo", ["carbonibus"], "coal") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: weaponTerms)
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