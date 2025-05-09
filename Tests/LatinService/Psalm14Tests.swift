import XCTest
@testable import LatinService

class Psalm14Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 14)
    let psalm14 = [
        "Domine, quis habitabit in tabernaculo tuo? aut quis requiescet in monte sancto tuo?",
        "Qui ingreditur sine macula, et operatur justitiam;",
        "Qui loquitur veritatem in corde suo, qui non egit dolum in lingua sua;",
        "Nec fecit proximo suo malum, et opprobrium non sustinuit adversus proximos suos;",
        "Ad nihilum deductus est in conspectu ejus malignus, timentes autem Dominum glorificat;",
        "Qui jurat proximo suo, et non decipit;",
        "Qui pecuniam suam non dedit ad usuram, et munera super innocentem non accepit.",
        "Qui facit haec, non movebitur in aeternum."
    ]
    
    // MARK: - Test Cases
    
    func testDwellingRequirements() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        
        let dwellingTerms = [
            ("habito", ["habitabit"], "dwell"), // v.1
            ("requiesco", ["requiescet"], "rest"), // v.1
            ("tabernaculum", ["tabernaculo"], "tabernacle"), // v.1
            ("mons", ["monte"], "mountain") // v.1
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: dwellingTerms)
    }
    
    func testMoralQualifications() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        
        let moralTerms = [
            ("macula", ["macula"], "blemish"), // v.2
            ("justus", ["justitiam"], "justice"), // v.2
            ("veritas", ["veritatem"], "truth"), // v.3
            ("dolus", ["dolum"], "deceit") // v.3
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: moralTerms)
    }
    
    func testSocialEthics() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        
        let socialTerms = [
            ("proximus", ["proximo", "proximos", "proximo"], "neighbor"), // v.3, v.4, v.6
            ("malum", ["malum"], "evil"), // v.4
            ("opprobrium", ["opprobrium"], "reproach"), // v.4
            ("juro", ["jurat"], "swear") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: socialTerms)
    }
    
    func testFinancialIntegrity() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        
        let financialTerms = [
            ("pecunia", ["pecuniam"], "money"), // v.7
            ("usura", ["usuram"], "interest"), // v.7
            ("munus", ["munera"], "bribe"), // v.7
            ("innocens", ["innocentem"], "innocent") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: financialTerms)
    }
    
    func testDivineRelationship() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        
        let divineTerms = [
            ("malignus", ["malignus"], "wicked"), // v.5
            ("timeo", ["timentes"], "fear"), // v.5
            ("glorifico", ["glorificat"], "honor"), // v.5
            ("dominus", ["dominum", "dominum"], "lord") // v.5, v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testEternalStability() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        
        let stabilityTerms = [
            ("aeternus", ["aeternum"], "forever"), // v.8
            ("moveo", ["movebitur"], "be moved"), // v.8
            ("facio", ["facit"], "do") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: stabilityTerms)
    }
    func testsAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm14)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'timeo' forms:", analysis.dictionary["timeo"]?.forms ?? [:])

             print("'quis' forms:", analysis.dictionary["quis"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            let verbose = false
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