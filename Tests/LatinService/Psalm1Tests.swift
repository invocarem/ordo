import XCTest
@testable import LatinService

class Psalm1Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm1 = [
        "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;",
        "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte.",
        "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:",
        "Et folium eius non defluet, et omnia quaecumque faciet prosperabuntur.",
        "Non sic impii, non sic: sed tamquam pulvis quem proicit ventus a facie terrae.",
        "Ideo non resurgent impii in judicio, neque peccatores in concilio iustorum;",
        "Quoniam novit Dominus viam justorum, et iter impiorum peribit."
    ]
    
    // MARK: - Test Cases
    func testChaffMetaphor() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let chaffMetaphorWords = [
            ("pulvis", ["pulvis"], "dust"),
            ("ventus", ["ventus"], "wind")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: chaffMetaphorWords)
        
        // Verify contrast with tree metaphor
        let treeCount = analysis.dictionary["lignum"]?.forms.values.reduce(0, +) ?? 0
        let chaffCount = analysis.dictionary["pulvis"]?.forms.values.reduce(0, +) ?? 0
        XCTAssertGreaterThan(treeCount, 0, "Tree metaphor should be present")
        XCTAssertGreaterThan(chaffCount, 0, "Chaff metaphor should be present")
    }
    func testJudgmentTheme() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let judgmentWords = [
            ("judicium", ["judicio"], "judgment"),
            ("concilium", ["concilio"], "assembly")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentWords)
    }
    
    func testRareNouns() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let rareNouns = [
            ("cathedra", ["cathedra"], "seat"),
            ("pulvis", ["pulvis"], "dust"),
            ("folium", ["folium"], "leaf"),
            ("decursus", ["decursus"], "flow")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareNouns)
    }
    
    func testUniqueVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let rareVerbs = [
            ("defluo", ["defluet"], "wither"),
            ("proicio", ["proicit"], "scatter"),
            ("resurgo", ["resurgent"], "rise up")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareVerbs)
    }
    
    func testKeyConcepts() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let thematicWords = [
            ("beatus", ["beatus"], "blessed"),
            ("impius", ["impiorum", "impii"], "wicked"),
            ("justus", ["justorum", "justorum"], "righteous")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: thematicWords)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify forms
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            XCTAssertTrue(
                missingForms.isEmpty,
                "Lemma \(lemma) missing forms: \(missingForms.joined(separator: ", "))"
            )
            
            if verbose {
                print("\n\(lemma.uppercased()) (\"\(translation)\")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count)x")
                }
            }
        }
    }
}