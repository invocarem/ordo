import XCTest
@testable import LatinService

class Psalm141Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm141 = [
        "Voce mea ad Dominum clamavi: voce mea ad Dominum deprecatus sum:",
        "Effundo in conspectu ejus orationem meam, et tribulationem meam ante ipsum pronuntio.",
        "In deficiendo ex me spiritum meum, et tu cognovisti semitas meas.",
        "In via hac qua ambulabam, absconderunt laqueum mihi.",
        "Considerabam ad dexteram, et videbam: et non erat qui cognosceret me.",
        "Periit fuga a me, et non est qui requirat animam meam.",
        "Clamavi ad te, Domine, dixi: Tu es spes mea, portio mea in terra viventium.",
        "Intende ad deprecationem meam: quia humiliatus sum nimis.",
        "Libera me a persequentibus me: quia confortati sunt super me.",
        "Educ de custodia animam meam ad confitendum nomini tuo: me exspectant justi, donec retribuas mihi."
    ]
    
    // MARK: - Test Cases
    
    func testPrayerVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm141)
        
        let prayerTerms = [
            ("clamo", ["clamavi"], "cry out"),
            ("deprecor", ["deprecatus"], "plead"),
            ("deprecatio", ["deprecationem"], "plea"),
            ("oratio", ["orationem"], "prayer"),
            ("confiteor", ["confitendum"], "confess")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: prayerTerms)
    }
    
    func testDistressTerms() {
        let analysis = latinService.analyzePsalm(text: psalm141)
        
        let distressTerms = [
            ("tribulatio", ["tribulationem"], "tribulation"),
            ("laqueus", ["laqueum"], "snare"),
            ("fuga", ["fuga"], "flight"),
            ("custodia", ["custodia"], "prison")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: distressTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm141)
        
        let divineTerms = [
            ("spes", ["spes"], "hope"),
            ("portio", ["portio"], "portion"),
            ("justus", ["justi"], "righteous"),
            ("retribuo", ["retribuas"], "to repay")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testKeyVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm141)
        
        let keyVerbs = [
            ("effundo", ["effundo"], "our out"),
            ("cognosco", ["cognovisti", "cognosceret"], "know"),
            ("intende", ["intende"], "pay attention"),
            ("educo", ["educ"], "lead out")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
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