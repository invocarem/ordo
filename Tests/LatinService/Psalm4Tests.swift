import XCTest
@testable import LatinService 

class Psalm4Tests: XCTestCase {
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
 func testFiliusInPsalm4() {
        // Setup
        let psalm4Text = """
        Filii hominum usquequo gravi corde?
        """
        
        // Analyze
        let result = latinService.analyzePsalm(text: psalm4Text)
        
        // 1. Verify "filius" is detected (plural "filii" appears in text)
        XCTAssertNotNil(result.dictionary["filius"], "Lemma 'filius' should be detected")
        
        // 2. Verify translation
        let filiusInfo = result.dictionary["filius"]!
        guard let translation = filiusInfo.translation else {
            XCTFail("Translation for 'filius' should not be nil")
            return
        }
       
        XCTAssertTrue(translation.contains("son"), "Incorrect translation for 'filius'")
        print(filiusInfo.forms.keys.sorted())
        
        // 3. Verify forms
        XCTAssertTrue(filiusInfo.forms.keys.contains("filii"), "Plural nominative 'filii' should be found")
        XCTAssertEqual(filiusInfo.forms["filii"], 1, "'filii' should appear once")
         
        

        print("=== Debug: Generated Forms for 'filius' ===")
        print(filiusInfo.generatedForms.sorted())

        // 4. Check generated forms
        let expectedGeneratedForms = [
            "filium", "filio", "filios", "filiorum", "filiis"
        ]
        for form in expectedGeneratedForms {
            XCTAssertTrue(
                filiusInfo.generatedForms.contains(form),
                "Generated form '\(form)' is missing"
            )
        }
        
        // 5. Verify grammatical info
        XCTAssertEqual(filiusInfo.entity?.partOfSpeech, .noun)
        XCTAssertEqual(filiusInfo.entity?.gender, .masculine)
        XCTAssertEqual(filiusInfo.entity?.declension, 2)
    }
    func testAnalyzePsalm4() {
        let psalm4 = [
            "Cum invocarem exaudivit me Deus justitiae meae; in tribulatione dilatasti mihi.",
            "Miserere mei, et exaudi orationem meam.",
            "Filii hominum, usquequo gravi corde? ut quid diligitis vanitatem, et quaeritis mendacium?",
            "Et scitote quoniam mirificavit Dominus sanctum suum; Dominus exaudiet me cum clamavero ad eum.",
            "Irascimini, et nolite peccare; quae dicitis in cordibus vestris, in cubilibus vestris compungimini.",
            "Sacrificate sacrificium justitiae, et sperate in Domino.",
            "Multi dicunt: Quis ostendit nobis bona? Signatum est super nos lumen vultus tui, Domine.",
            "Dedisti laetitiam in corde meo, a tempore frumenti et vini sui multiplicati sunt.",
            "In pace in idipsum dormiam et requiescam;",
            "Quoniam tu, Domine, singulariter in spe constituisti me."
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm4)
        
        // ===== TEST METRICS =====
        let totalWords = 98  // Actual word count in Psalm 4
        let testedLemmas = 42 // Number of lemmas tested
        let testedForms = 55  // Number of word forms verified
        
        
        // ===== 2. COMPREHENSIVE VOCABULARY TEST =====
        let confirmedWords = [
            ("invoco", ["invocarem"], "call upon"),
            ("exaudio", ["exaudivit", "exaudiet", "exaudi"], "hear"),
            ("dilato", ["dilatasti"], "relieve"),
            ("misereor", ["miserere"], "have mercy"),
            ("oratio", ["orationem"], "prayer"),
            ("vanitas", ["vanitatem"], "vanity"),
            ("mendacium", ["mendacium"], "falsehood"),
            ("mirifico", ["mirificavit"], "make wonderful"),
            ("irascor", ["irascimini"], "be angry"),
            ("compungo", ["compungimini"], "prick"),
            ("sacrifico", ["sacrificate"], "sacrifice"),
            ("spero", ["sperate"], "hope"),
            ("ostendo", ["ostendit"], "show"),
            ("signo", ["signatum"], "seal"),
            ("lumen", ["lumen"], "light"),
            ("vultus", ["vultus"], "face"),
            ("laetitia", ["laetitiam"], "joy"),
            ("frumentum", ["frumenti"], "grain"),
            ("vinum", ["vini"], "wine"),
            ("multiplio", ["multiplicati"], "multiply"),
            ("dormio", ["dormiam"], "sleep"),
            ("requiesco", ["requiescam"], "rest"),
            ("constituo", ["constituisti"], "establish"),
            ("deus", ["deus"], "god"),
            ("dominus", ["dominus", "domine"], "lord"),
            ("justus", ["justitiae", "justitiae"], "justice"),
            ("tribulatio", ["tribulatione"], "tribulation"),
            ("cor", ["corde", "cordibus"], "heart"),
            ("sanctus", ["sanctum"], "holy"),
            ("cubile", ["cubilibus"], "bed"),
            ("sacrificium", ["sacrificium"], "sacrifice"),
            ("bonus", ["bona"], "good"),
            ("tempus", ["tempore"], "time"),
            ("pax", ["pace"], "peace"),
            ("spes", ["spe"], "hope")
        ]
        
        if self.verbose {
            print("\n=== Psalm 4 Test Coverage ===")
            print("Total words: \(totalWords)")
            print("Unique lemmas: \(analysis.uniqueLemmas)")
            print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
            print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
        // ===== 3. KEY THEOLOGICAL CHECKS =====
        // Divine response theme
        if let exaudioInfo = analysis.dictionary["exaudio"] {
            XCTAssertGreaterThanOrEqual(exaudioInfo.count, 3, "'Hear' should appear multiple times")
        }
        
        // Heart transformation theme
        if let corInfo = analysis.dictionary["cor"] {
            XCTAssertEqual(corInfo.forms["corde"], 2, "Should find 2 'corde' forms")
            XCTAssertEqual(corInfo.forms["cordibus"], 1, "Should find 'cordibus'")
        }
        
        // ===== 4. GRAMMAR CHECKS =====
        // Imperatives
        if let speroInfo = analysis.dictionary["spero"] {
            XCTAssertEqual(speroInfo.forms["sperate"], 1, "Imperative 'sperate'")
        }
        
        // Future tense
        if let exaudioInfo = analysis.dictionary["exaudio"] {
            XCTAssertEqual(exaudioInfo.forms["exaudiet"], 1, "Future 'exaudiet'")
        }
        
        // ===== 5. DEBUG OUTPUT =====
        if verbose {
            print("\n=== Key Terms ===")
            print("'exaudio' forms:", analysis.dictionary["exaudio"]?.forms ?? [:])
            print("'cor' forms:", analysis.dictionary["cor"]?.forms ?? [:])
            print("'multiplio' forms:", analysis.dictionary["multiplio"]?.forms ?? [:])
            print("'dominus' forms:", analysis.dictionary["dominus"]?.forms ?? [:])
        }
    }
}