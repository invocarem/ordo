import XCTest
@testable import LatinService

class Psalm15Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm15 = [
        "Conserva me, Domine, quoniam in te speravi;",
        "Dixi Domino: Deus meus es tu, quoniam bonorum meorum non eges.",
        "Sanctis qui sunt in terra ejus, mirificavit omnes voluntates meas in eis.",
        "Multiplicatae sunt infirmitates eorum; postea acceleraverunt.",
        "Non congregabo conventicula eorum de sanguinibus, nec memor ero nominum eorum per labia mea.",
        "Dominus pars haereditatis meae, et calicis mei: tu es qui restitues haereditatem meam mihi.",
        "Funes ceciderunt mihi in praeclaris; etenim haereditas mea praeclara est mihi.",
        "Benedicam Dominum qui tribuit mihi intellectum; insuper et usque ad noctem increpuerunt me renes mei.",
        "Providebam Dominum in conspectu meo semper: quoniam a dextris est mihi, ne commovear.",
        "Propter hoc laetatum est cor meum, et exsultavit lingua mea: insuper et caro mea requiescet in spe.",
        "Quoniam non derelinques animam meam in inferno, nec dabis sanctum tuum videre corruptionem.",
        "Notas mihi fecisti vias vitae; adimplebis me laetitia cum vultu tuo: delectationes in dextera tua usque in finem."
    ]
    
    // MARK: - Test Cases
    
    func testRefugeVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let refugeTerms = [
            ("conservo", ["conserva"], "preserve"),
            ("spero", ["speravi"], "hope"),
            ("pars", ["pars"], "portion"),
            ("haereditas", ["haereditatis", "haereditas"], "inheritance"),
            ("restituo", ["restitues"], "restore")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: refugeTerms)
    }
    
    func testBodyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let bodyTerms = [
            ("ren", ["renes"], "kidney"), // Seat of emotion
            ("cor", ["cor"], "heart"),
            ("lingua", ["lingua"], "tongue"),
            ("caro", ["caro"], "flesh"),
            ("labium", ["labia"], "lip")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    
    func testEschatologicalHope() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let hopeTerms = [
            ("infernus", ["inferno"], "hell"),
            ("corruptio", ["corruptionem"], "decay"),
            ("requiesco", ["requiescet"], "rest"),
            ("vita", ["vitae"], "life"),
            ("laetitia", ["laetitia"], "joy")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: hopeTerms)
    }
    
    func testCovenantalLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let covenantTerms = [
            ("sanctus", ["sanctis", "sanctum"], "holy"),
            ("calix", ["calicis"], "cup"),
            ("funis", ["funes"], "cord"),
            ("dexter", ["dextera"], "right hand"),
            ("vultus", ["vultu"], "face"),
            ("delectatio", ["delectationes"], "delight")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: covenantTerms)
    }
    
    func testDivinePresence() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let presenceTerms = [
            ("provideo", ["Providebam"], "keep before"),
            ("dexter", ["dextris", "dextera"], "right hand"),
            ("notus", ["notas"], "known"),
          
            ("mirifico", ["mirificavit"], "wonderfully show")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: presenceTerms)
    }
    func testzAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'calix' forms:", analysis.dictionary["calix"]?.forms ?? [:])
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