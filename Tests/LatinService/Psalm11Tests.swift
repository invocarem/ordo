import XCTest
@testable import LatinService

class Psalm11Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm11 = [
        "Salvum me fac, Domine, quoniam defecit sanctus, quoniam diminutae sunt veritates a filiis hominum.",
        "Vana locuti sunt unusquisque ad proximum suum; labia dolosa, in corde et corde locuti sunt.",
        "Disperdat Dominus universa labia dolosa, et linguam magniloquam.",
        "Qui dixerunt: Linguam nostram magnificabimus; labia nostra a nobis sunt, quis noster Dominus est?",
        "Propter miseriam inopum, et gemitum pauperum, nunc exsurgam, dicit Dominus.",
        "Ponam in salutari; fiducialiter agam in eo.",
        "Eloquia Domini, eloquia casta: argentum igne examinatum, probatum terrae, purgatum septuplum.",
        "Tu, Domine, servabis nos: et custodies nos a generatione hac in aeternum.",
        "In circuitu impii ambulant; secundum altitudinem tuam multiplicasti filios hominum."
    ]
    
    // MARK: - Test Cases
    
    func testDivineProtectionVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm11)
        
        let protectionTerms = [
            ("salvus", ["Salvum"], "save"),
            ("salutaris", ["salutari"], "salvation"),
            ("custodio", ["custodies"], "guard"),
            ("servo", ["servabis"], "preserve"),
            ("septuplus", ["septuplum"], "sevenfold") // Purity metaphor
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testDeceptiveSpeech() {
        let analysis = latinService.analyzePsalm(text: psalm11)
        
        let speechTerms = [
            ("labium", ["labia", "labia"], "lip"),
            ("dolosus", ["dolosa"], "deceitful"),
            ("lingua", ["linguam", "lingua"], "tongue"),
            ("magniloquus", ["magniloquam"], "boastful"),
            ("vanus", ["vana"], "empty")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: speechTerms)
    }
    
    func testMetallurgyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm11)
        
        let metalTerms = [
            ("argentum", ["argentum"], "silver"),
            ("examino", ["examinatum"], "test"),
            ("probo", ["probatum"], "prove"),
            ("purgo", ["purgatum"], "refine"),
            ("ignis", ["igne"], "fire")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: metalTerms)
    }
    
    func testHumanConditions() {
        let analysis = latinService.analyzePsalm(text: psalm11)
        
        let humanTerms = [
            ("inops", ["inopum"], "needy"),
            ("pauper", ["pauperum"], "poor"),
            ("gemitus", ["gemitum"], "groaning"),
            ("impius", ["impii"], "wicked"),
            ("homo", ["hominum"], "man")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: humanTerms)
    }
    
    func testKeyDivineActions() {
        let analysis = latinService.analyzePsalm(text: psalm11)
        
        let actionTerms = [
            ("exsurgo", ["exsurgam"], "arise"),
            ("disperdo", ["disperdat"], "destroy"),
            ("multiplico", ["multiplicasti"], "multiply"),
            ("facio", ["fac"], "make"),
            ("deficio", ["defecit"], "fail")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: actionTerms)
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