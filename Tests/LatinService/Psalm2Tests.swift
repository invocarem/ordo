import XCTest
@testable import LatinService

class Psalm2Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    // MARK: - Test Data
    let psalm2 = [
        "Quare fremuerunt gentes, et populi meditati sunt inania?",
        "Astiterunt reges terrae, et principes convenerunt in unum adversus Dominum, et adversus christum ejus.",
        "Dirumpamus vincula eorum, et projiciamus a nobis jugum ipsorum.",
        "Qui habitat in caelis irridebit eos, et Dominus subsannabit eos.",
        "Tunc loquetur ad eos in ira sua, et in furore suo conturbabit eos.",
        "Ego autem constitutus sum rex ab eo super Sion montem sanctum ejus, praedicans praeceptum ejus.",
        "Dominus dixit ad me: Filius meus es tu, ego hodie genui te.",
        "Postula a me, et dabo tibi gentes hereditatem tuam, et possessionem tuam terminos terrae.",
        "Reges eos in virga ferrea, et tamquam vas figuli confringes eos.",
        "Et nunc, reges, intelligite; erudimini, qui judicatis terram.",
        "Servite Domino in timore, et exsultate ei cum tremore.",
        "Apprehendite disciplinam, nequando irascatur Dominus, et pereatis de via justa. Cum exarserit in brevi ira ejus, beati omnes qui confidunt in eo."
    ]
    
    // MARK: - Test Cases
      
    func testRareNouns() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        let rareNouns = [
            ("jugum", ["jugum"], "yoke"),
            ("virga", ["virga"], "rod"),
            ("vas", ["vas"], "vessel"),
            ("terminus", ["terminos"], "boundary")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareNouns)
    }
    
    func testUniqueVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        let rareVerbs = [
            ("fremo", ["fremuerunt"], "rage"),
            ("subsanno", ["subsannabit"], "mock"),
            ("conturbo", ["conturbabit"], "terrify"),
            ("confringo", ["confringes"], "shatter")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareVerbs)
    }
    
    func testHapaxLegomena() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        // Words appearing only once in Psalm 2
        let uniqueWords = [
            ("figulus", ["figuli"], "potter"),
            ("tremor", ["tremore"], "trembling"),
            ("disciplina", ["disciplinam"], "instruction")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: uniqueWords)
    }
    
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
            XCTAssertTrue(entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                         "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'")
            
            // Verify forms
            for form in forms {
                let count = entry.forms[form.lowercased()] ?? 0
                if verbose {
                    print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
                XCTAssertGreaterThan(count, 0, "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
    }
}