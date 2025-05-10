import XCTest
@testable import LatinService

class Psalm130Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm130 = [
        "Domine, non est exaltatum cor meum, neque elati sunt oculi mei; neque ambulavi in magnis, neque in mirabilibus super me.",
        "Si non humiliter sentiebam, sed exaltavi animam meam; sicut ablactatus est super matre sua, ita retributio in anima mea.",
        "Speret Israel in Domino, ex hoc nunc et usque in saeculum."
    ]
    
    // MARK: - Test Cases
    
    // 1. Test Humility Theme
    func testHumilityTheme() {
        let analysis = latinService.analyzePsalm(text: psalm130)
        
        let humilityTerms = [
            ("humilis", ["humiliter"], "humble"),
            ("exalto", ["exaltatum", "exaltavi"], "exalt"),
            ("cor", ["cor"], "heart"),
            ("oculus", ["oculi"], "eye"),
            ("ambulo", ["ambulavi"], "walk")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: humilityTerms)
    }
    
    // 2. Test Contrast with Pride
    func testPrideContrast() {
        let analysis = latinService.analyzePsalm(text: psalm130)
        
        let prideTerms = [
            ("elatus", ["elati"], "lofty"),
            ("magnus", ["magnis"], "great"),
            ("mirabilis", ["mirabilibus"], "wonderful"),
            ("super", ["super"], "above")
           
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: prideTerms)
    }
    
    // 3. Test Weaning Metaphor
    func testWeaningMetaphor() {
        let analysis = latinService.analyzePsalm(text: psalm130)
        
        let metaphorTerms = [
            ("ablacto", ["ablactatus"], "wean"),
            ("mater", ["matre"], "mother"),
            ("sicut", ["sicut"], "as"),
            ("ita", ["ita"], "so"),
            ("retributio", ["retributio"], "recompense")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: metaphorTerms)
    }
    
    // 4. Test Trust in God
    func testTrustInGod() {
        let analysis = latinService.analyzePsalm(text: psalm130)
        
        let trustTerms = [
            ("spero", ["Speret"], "hope"),
            ("Israel", ["Israel"], "Israel"),
            ("Dominus", ["Domino"], "Lord"),
            ("saeculum", ["saeculum"], "age"),
            ("usque", ["usque"], "even unto")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: trustTerms)
    }
    
    // 5. Test Temporal Scope
    func testTemporalScope() {
        let analysis = latinService.analyzePsalm(text: psalm130)
        
        let temporalTerms = [
            ("hic", ["hoc"], "this"),
            ("nunc", ["nunc"], "now"),
            ("et", ["et"], "and"),
            ("ex", ["ex"], "from"),
            ("in", ["in"], "in")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: temporalTerms)
    }
    
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm130)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'exalto' forms:", analysis.dictionary["exalto"]?.forms ?? [:])
            print("'humilis' forms:", analysis.dictionary["humilis"]?.forms ?? [:])
            print("'spero' forms:", analysis.dictionary["spero"]?.forms ?? [:])
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