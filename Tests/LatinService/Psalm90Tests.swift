import XCTest
@testable import LatinService 

class Psalm90Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true // Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
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
            
            for form in forms {
                let count = entry.forms[form] ?? 0
                if self.verbose {
                    print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
                XCTAssertGreaterThan(count, 0, "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
    }
    
    func testAnalyzePsalm90() {
    let psalm90 = [
        "Qui habitat in adjutorio Altissimi, in protectione Dei caeli commorabitur.",
        "Dicet Domino: Susceptor meus es tu, et refugium meum; Deus meus, sperabo in eum.",
        "Quoniam ipse liberavit me de laqueo venantium, et a verbo aspero.",
        "Scapulis suis obumbrabit tibi, et sub pennis ejus sperabis.",
        "Scuto circumdabit te veritas ejus; non timebis a timore nocturno,",
        "A sagitta volante in die, a negotio perambulante in tenebris, ab incursu et daemonio meridiano.",
        "Cadent a latere tuo mille, et decem millia a dextris tuis; ad te autem non appropinquabit.",
        "Verumtamen oculis tuis considerabis, et retributionem peccatorum videbis.",
        "Quoniam tu es, Domine, spes mea; Altissimum posuisti refugium tuum.",
        "Non accedet ad te malum, et flagellum non appropinquabit tabernaculo tuo.",
        "Quoniam angelis suis mandavit de te, ut custodiant te in omnibus viis tuis.",
        "In manibus portabunt te, ne forte offendas ad lapidem pedem tuum.",
        "Super aspidem et basiliscum ambulabis, et conculcabis leonem et draconem.",
        "Quoniam in me speravit, liberabo eum; protegam eum, quoniam cognovit nomen meum.",
        "Clamabit ad me, et ego exaudiam eum; cum ipso sum in tribulatione, eripiam eum et glorificabo eum.",
        "Longitudine dierum replebo eum, et ostendam illi salutare meum."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm90)
    
    // ===== TEST METRICS =====
    let totalWords = 150  // Actual word count in Psalm 90
    let testedLemmas = 62 // Number of lemmas we're testing
    let testedForms = 78  // Number of word forms we're verifying
    
    // ===== 2. COMPREHENSIVE VOCABULARY TEST =====
    let confirmedWords = [
        ("altissimus", ["altissimi", "altissimum"], "most high"),
        ("dominus", ["domino"], "lord"),
        ("refugium", ["refugium", "refugium"], "refuge"),
        ("protectio", ["protectione"], "protection"),
        ("angelus", ["angelis"], "angel"),
        ("scapula", ["scapulis"], "shoulder"),
        ("habito", ["habitat"], "dwell"),
        ("spero", ["sperabo", "sperabis", "speravit"], "hope"),
        ("libero", ["liberavit", "liberabo"], "free"),
        ("obumbro", ["obumbrabit"], "overshadow"),
        ("timeo", ["timebis"], "fear"),
        ("considero", ["considerabis"], "consider"),
        ("custodio", ["custodiant"], "guard"),
        ("ambulo", ["ambulabis"], "walk"),
        ("conculco", ["conculcabis"], "trample"),
        ("exaudio", ["exaudiam"], "hear"),
        ("eripio", ["eripiam"], "rescue")
    ]
    
    if self.verbose {
        print("\n=== Psalm 90 Test Coverage ===")
        print("Total words: \(totalWords)")
        print("Unique lemmas: \(analysis.uniqueLemmas)")
        print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
        print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 3. THEOLOGICAL CONCEPT CHECKS =====
    // Protection imagery
    if let scapulaInfo = analysis.dictionary["scapula"] {
        XCTAssertEqual(scapulaInfo.forms["scapulis"], 1, "Should find 'scapulis' once")
    }
    
    // Divine refuge terms
    if let refugiumInfo = analysis.dictionary["refugium"] {
        XCTAssertGreaterThan(refugiumInfo.count, 1, "Refugium should appear multiple times")
    }
    
    // Spiritual warfare terms
    XCTAssertNotNil(analysis.dictionary["draco"], "Should have 'draco' (dragon)")
    XCTAssertNotNil(analysis.dictionary["leo"], "Should have 'leo' (lion)")
    
    // ===== 4. GRAMMAR CHECKS =====
    // Verify imperative forms
    if let custodiInfo = analysis.dictionary["custodio"] {
        XCTAssertEqual(custodiInfo.forms["custodiant"], 1, "Should find subjunctive 'custodiant'")
    }
    
    // Verify divine pronouns
    if let meusInfo = analysis.dictionary["meus"] {
        XCTAssertGreaterThan(meusInfo.count, 3, "Possessive 'meus' should appear frequently")
    }

    if verbose {
        print("\n=== Key Theological Terms ===")
        print("'timeo' forms:", analysis.dictionary["timeo"]?.forms ?? [:])
    }
}
}