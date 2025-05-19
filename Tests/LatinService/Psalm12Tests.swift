import XCTest
@testable import LatinService

class Psalm12Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 12, section: nil)
    // MARK: - Test Data (Psalm 12)
    let psalm12 = [
        "Usquequo, Domine, oblivisceris me in finem? usquequo avertis faciem tuam a me?",
        "Quandiu ponam consilia in anima mea, dolorem in corde meo per diem?",
        "Usquequo exaltabitur inimicus meus super me?",
        "Respice, et exaudi me, Domine Deus meus. Illumina oculos meos, ne umquam obdormiam in morte;",
        "Nequando dicat inimicus meus: Praevalui adversus eum. Qui tribulant me, exsultabunt si motus fuero;",
        "Ego autem in misericordia tua speravi. Exsultabit cor meum in salutari tuo; cantabo Domino qui bona tribuit mihi, et psallam nomini Domini altissimi."
    ]
    
    // MARK: - Test Cases
    func testAnalysis() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'pono' forms:", analysis.dictionary["pono"]?.forms ?? [:])
            print("'exsulto' forms:", analysis.dictionary["exsulto"]?.forms ?? [:])
            print("'respicio' forms:", analysis.dictionary["respicio"]?.forms ?? [:])
            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    func testLamentVerbs() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let lamentTerms = [
            ("obliviscor", ["oblivisceris"], "forget"), // v.1
            ("averto", ["avertis"], "turn away"), // v.1
            ("pono", ["ponam"], "place"), // v.2
            ("respiro", ["respice"], "look"), // v.4
            ("exaudio", ["exaudi"], "hear") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lamentTerms)
    }
    
    func testTemporalExpressions() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let timeTerms = [
            ("usquequo", ["usquequo", "usquequo", "usquequo"], "how long"), // v.1 (2x), v.3
            ("quandiu", ["quandiu"], "how long"), // v.2
            ("per", ["per"], "through"), // v.2
            ("umquam", ["umquam"], "ever") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: timeTerms)
    }
    
    func testEnemyLanguage() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let enemyTerms = [
            ("inimicus", ["inimicus", "inimicus"], "enemy"), // v.3, v.5
            ("praevaleo", ["praevalui"], "prevail"), // v.5
            ("tribulo", ["tribulant"], "afflict"), // v.5
            ("exsulto", ["exsultabunt"], "rejoice") // v.5 (enemy's joy)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    
    func testSpiritualFaculties() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let facultyTerms = [
            ("animus", ["anima"], "soul"), // v.2
            ("cor", ["corde", "cor"], "heart"), // v.2, v.6
            ("oculus", ["oculos"], "eye"), // v.4
            ("vultus", ["faciem", "faciem"], "face") // v.1, v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: facultyTerms)
    }
    
    func testHopeTransition() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let hopeTerms = [
            ("misericordia", ["misericordia"], "mercy"), // v.6
            ("salus", ["salutari"], "salvation"), // v.6
            ("canto", ["cantabo"], "sing"), // v.6
            ("psallo", ["psallam"], "sing praises"), // v.6
            ("spero", ["speravi"], "hope") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: hopeTerms)
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