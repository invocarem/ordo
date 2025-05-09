import XCTest
@testable import LatinService

class Psalm13Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 13)
    let psalm13 = [
        "Dixit insipiens in corde suo: Non est Deus.",
        "Corrupti sunt, et abominabiles facti sunt in studiis suis; non est qui faciat bonum, non est usque ad unum.",
        "Dominus de caelo prospexit super filios hominum, ut videat si est intelligens, aut requirens Deum.",
        "Omnes declinaverunt, simul inutiles facti sunt; non est qui faciat bonum, non est usque ad unum.",
        "Nonne scient omnes qui operantur iniquitatem, qui devorant plebem meam ut cibum panis?",
        "Dominum non invocaverunt; illic trepidaverunt timore, ubi non erat timor.",
        "Quoniam Dominus in generatione justa est, consilium inopis confudistis, quoniam Dominus spes ejus est.",
        "Quis dabit ex Sion salutare Israel? cum averterit Dominus captivitatem plebis suae, exsultabit Jacob, et laetabitur Israel."
    ]
    
    // MARK: - Test Cases
    func testAnalysis() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'dico' forms:", analysis.dictionary["dico"]?.forms ?? [:])
            print("'iniquitas' forms:", analysis.dictionary["iniquitas"]?.forms ?? [:])
            print("'prospicio' forms:", analysis.dictionary["prospicio"]?.forms ?? [:])
            print("'corrumpo' forms:", analysis.dictionary["corrumpo"]?.forms ?? [:])
            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    
    func testFoolsDeclaration() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        
        let foolTerms = [
            ("insipiens", ["insipiens"], "fool"), // v.1
            ("cor", ["corde"], "heart"), // v.1
            ("deus", ["deus", "deum"], "god"), // v.1, v.3
            ("dico", ["dixit"], "say") // v.1
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: foolTerms)
    }
    
    func testMoralCorruption() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        
        let corruptionTerms = [
            ("corrumpo", ["corrupti"], "corrupt"), // v.2
            ("abominabilis", ["abominabiles"], "abominable"), // v.2
            ("iniquitas", ["iniquitatem"], "iniquity"), // v.5
            ("declino", ["declinaverunt"], "turn aside"), // v.4
            ("inutilis", ["inutiles"], "worthless") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: corruptionTerms)
    }
    
    func testDivineObservation() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        
        let observationTerms = [
            ("prospicio", ["prospexit"], "look forth"), // v.3
            ("video", ["videat"], "see"), // v.3
            ("caelum", ["caelo"], "heaven"), // v.3
            ("requiro", ["requirens"], "seek") // v.3
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: observationTerms)
    }
    
    func testSocialOppression() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        
        let oppressionTerms = [
            ("devoro", ["devorant"], "devour"), // v.5
            ("plebs", ["plebem", "plebis"], "people"), // v.5, v.8
            ("panis", ["panis"], "bread"), // v.5
            ("inops", ["inopis"], "poor") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: oppressionTerms)
    }
    
    func testRedemptionHope() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        
        let redemptionTerms = [
            ("saluto", ["salutare"], "salvation"), // v.8
            ("averto", ["averterit"], "restore"), // v.8
            ("captivitas", ["captivitatem"], "captivity"), // v.8
            ("exsulto", ["exsultabit"], "rejoice"), // v.8
            ("laetor", ["laetabitur"], "be glad") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: redemptionTerms)
    }
    
    func testContrastingGroups() {
        let analysis = latinService.analyzePsalm(text: psalm13)
        
        let groupTerms = [
            ("justus", ["justa"], "righteous"), // v.7
            ("generatio", ["generatione"], "generation"), // v.7
            ("jacob", ["jacob"], "jacob"), // v.8
            ("israel", ["israel", "israel"], "israel") // v.8 (2x)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: groupTerms)
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