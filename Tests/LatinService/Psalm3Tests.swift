import XCTest
@testable import LatinService 

class Psalm3Tests: XCTestCase {
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

    func testAnalyzePsalm3() {
        let psalm3 = [
            "Domine, quid multiplicati sunt qui tribulant me? multi insurgunt adversum me.",
            "Multi dicunt animae meae: Non est salus ipsi in Deo ejus.",
            "Tu autem, Domine, susceptor meus es, gloria mea, et exaltans caput meum.",
            "Voce mea ad Dominum clamavi, et exaudivit me de monte sancto suo.",
            "Ego dormivi, et soporatus sum; et exsurrexi, quia Dominus suscepit me.",
            "Non timebo millia populi circumdantis me: exsurge, Domine; salvum me fac, Deus meus.",
            "Quoniam tu percussisti omnes adversantes mihi sine causa; dentes peccatorum contrivisti.",
            "Domini est salus; et super populum tuum benedictio tua."
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm3)
        
        // ===== TEST METRICS =====
        let totalWords = 82  // Actual word count in Psalm 3
        let testedLemmas = 38 // Number of lemmas tested
        let testedForms = 45  // Number of word forms verified
        
        // ===== 2. COMPREHENSIVE VOCABULARY TEST =====
        let confirmedWords = [
            ("multiplio", ["multiplicati"], "multiply"),
            ("tribulo", ["tribulant"], "trouble"),
            ("insurgo", ["insurgunt"], "rise up"),
            ("dico", ["dicunt"], "say"),
            ("animus", ["animae"], "soul"),
            ("salus", ["salus"], "salvation"),
            ("salvus", ["salvum"], "safe"),
            ("susceptor", ["susceptor"], "protector"),
            ("gloria", ["gloria"], "glory"),
            ("exalto", ["exaltans"], "lift up"),
            ("caput", ["caput"], "head"),
            ("vox", ["voce"], "voice"),
            ("clamo", ["clamavi"], "cry out"),
            ("exaudio", ["exaudivit"], "hear"),
            ("mons", ["monte"], "mountain"),
            ("dormio", ["dormivi"], "sleep"),
            ("soporo", ["soporatus"], "fall asleep"),
            ("exsurgo", ["exsurrexi", "exsurge"], "arise"),
            ("suscipio", ["suscepit"], "uphold"),
            ("timeo", ["timebo"], "fear"),
            ("mille", ["millia"], "thousand"),
            ("populus", ["populi", "populum"], "people"),
            ("circumdo", ["circumdantis"], "surround"),
           
            ("percutio", ["percussisti"], "strike"),
            ("adverso", ["adversantes"], "oppose"),
            ("dens", ["dentes"], "tooth"),
            ("peccator", ["peccatorum"], "sinner"),
            ("contero", ["contrivisti"], "crush"),
            ("benedictio", ["benedictio"], "blessing"),
            ("dominus", ["domine", "dominum", "domini"], "lord"),
            ("deus", ["deo", "deus"], "god"),
            ("meus", ["meus", "mea", "meum"], "my"),
            ("tuus", ["tuum", "tua"], "your"),
            ("sanctus", ["sancto"], "holy"),
            ("sine", ["sine"], "without"),
            ("causa", ["causa"], "cause"),
            ("super", ["super"], "over"),
            ("quoniam", ["quoniam"], "because")
        ]
        
        if self.verbose {
            print("\n=== Psalm 3 Test Coverage ===")
            print("Total words: \(totalWords)")
            print("Unique lemmas: \(analysis.uniqueLemmas)")
            print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
            print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
        // ===== 3. KEY THEOLOGICAL CHECKS =====
        // Divine protection theme
        if let susceptorInfo = analysis.dictionary["susceptor"] {
            XCTAssertGreaterThanOrEqual(susceptorInfo.count, 1, "'Protector' should appear")
        }
        
        if let salusInfo = analysis.dictionary["salus"] {
            XCTAssertGreaterThanOrEqual(salusInfo.count, 2, "'Salvation' should appear multiple times")
        }
        
        // ===== 4. GRAMMAR CHECKS =====
        // Perfect tense
        if let exaudioInfo = analysis.dictionary["exaudio"] {
            XCTAssertEqual(exaudioInfo.forms["exaudivit"], 1, "Perfect 'exaudivit'")
        }
        
        // Future tense
        if let timeoInfo = analysis.dictionary["timeo"] {
            XCTAssertEqual(timeoInfo.forms["timebo"], 1, "Future 'timebo'")
        }
        
        // Imperative
        if let exsurgoInfo = analysis.dictionary["exsurgo"] {
            XCTAssertEqual(exsurgoInfo.forms["exsurge"], 1, "Imperative 'exsurge'")
        }
        
        // ===== 5. DEBUG OUTPUT =====
        if verbose {
            print("\n=== Key Terms ===")
            print("'dominus' forms:", analysis.dictionary["dominus"]?.forms ?? [:])
            print("'salus' forms:", analysis.dictionary["salus"]?.forms ?? [:])
            print("'exsurgo' forms:", analysis.dictionary["exsurgo"]?.forms ?? [:])
        }
    }
}