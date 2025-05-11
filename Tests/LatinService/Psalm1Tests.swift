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
    func testTreeMetaphor() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let treeTerms = [
            ("lignum", ["lignum"], "tree"),
            ("planto", ["plantatum"], "plant"),
            ("fructus", ["fructum"], "fruit"),
            ("folium", ["folium"], "leaf"),
            ("defluo", ["defluet"], "wither"),
            ("decursus", ["decursus"], "flow")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: treeTerms)
        
        // Verify water connection
        XCTAssertNotNil(analysis.dictionary["aqua"], "Water imagery missing")
    }
    
    // MARK: - Test Cases
    func testChaffMetaphor() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let chaffMetaphorWords = [
            ("pulvis", ["pulvis"], "dust"),
            ("ventus", ["ventus"], "wind"),
            
            ("proicio", ["proicit"], "scatter"),
            ("facies", ["facie"], "face")
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
     func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'corono' forms:", analysis.dictionary["corono"]?.forms ?? [:])
            print("'humilis' forms:", analysis.dictionary["humilis"]?.forms ?? [:])
            print("'propitior' forms:", analysis.dictionary["propitior"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
     func testStructuralFeatures() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        // Verify triple negation pattern
        let negatedVerbs = ["abiit", "stetit", "sedit"]
        let negationsFound = negatedVerbs.filter { verb in
            analysis.dictionary.values.contains { entry in
                entry.forms.keys.contains(verb)
            }
        }
        XCTAssertEqual(negationsFound.count, 3, "Should find all three negated actions")
        
        // Verify key repetitions
        XCTAssertGreaterThan(analysis.dictionary["non"]?.forms.values.reduce(0, +) ?? 0, 3, "Key negation word")
    }
    

    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Form verification (case-insensitive)
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