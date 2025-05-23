import XCTest
@testable import LatinService

class Psalm128Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm128 = [
        "Saepe expugnaverunt me a juventute mea, dicat nunc Israel;",
        "saepe expugnaverunt me a juventute mea, etenim non potuerunt mihi.",
        "Supra dorsum meum fabricaverunt peccatores; prolongaverunt iniquitatem suam.",
        "Dominus justus concidit cervices peccatorum.",
        "Confundantur et convertantur retrorsum omnes qui oderunt Sion.",
        "Fiant sicut foenum tectorum, quod priusquam evellatur exaruit,",
        "de quo non implevit manum suam qui metit, et sinum suum qui manipulos colligit.",
        "Et non dixerunt qui praeteribant: Benedictio Domini super vos; benediximus vobis in nomine Domini."
    ]
    let id = PsalmIdentity(number: 13, category: nil)
     
    // MARK: - Test Cases
    
    // 1. Test Persecution Theme
    func testPersecutionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm128)
        
        let persecutionTerms = [
            ("saepe", ["Saepe", "saepe"], "often"),
            ("expugno", ["expugnaverunt"], "attack"),
            ("juventus", ["juventute"], "youth"),
            ("dorsum", ["dorsum"], "back"),
            ("fabricor", ["fabricaverunt"], "build/weave")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: persecutionTerms)
    }
    
    // 2. Test Divine Justice
    func testDivineJustice() {
        let analysis = latinService.analyzePsalm(id, text: psalm128)
        
        let justiceTerms = [
            ("Dominus", ["Dominus", "Domini"], "Lord"),
            ("justus", ["justus"], "just"),
            ("concido", ["concidit"], "cut down"),
            ("cervix", ["cervices"], "neck"),
            ("peccator", ["peccatores", "peccatorum"], "sinner")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
    }
    
    // 3. Test Enemies' Shame
    func testEnemiesShame() {
        let analysis = latinService.analyzePsalm(id, text: psalm128)
        
        let shameTerms = [
            ("confundo", ["Confundantur"], "be ashamed"),
            ("converto", ["convertantur"], "turn back"),
            ("retrorsum", ["retrorsum"], "backward"),
            ("odi", ["oderunt"], "hate"),
            ("Sion", ["Sion"], "Zion")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: shameTerms)
    }
    
    // 4. Test Agricultural Imagery
    func testAgriculturalImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm128)
        
        let agriculturalTerms = [
            ("foenum", ["foenum"], "hay"),
            ("tectum", ["tectorum"], "roof"),
            ("evello", ["evellatur"], "pluck out"),
            ("exaresco", ["exaruit"], "wither"),
            ("meto", ["metit"], "reap")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: agriculturalTerms)
    }
    
    // 5. Test Blessing Contrast
    func testBlessingContrast() {
        let analysis = latinService.analyzePsalm(text: psalm128)
        
        let blessingTerms = [
            ("benedictio", ["Benedictio"], "blessing"),
            ("super", ["super"], "upon"),
            ("nomen", ["nomine"], "name"),
            ("manipulus", ["manipulos"], "sheaf"),
            ("sinus", ["sinum"], "bosom")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: blessingTerms)
    }
    
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(id, text: psalm128)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'expugno' forms:", analysis.dictionary["expugno"]?.forms ?? [:])
            print("'Dominus' forms:", analysis.dictionary["Dominus"]?.forms ?? [:])
            print("'peccator' forms:", analysis.dictionary["peccator"]?.forms ?? [:])
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