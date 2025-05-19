import XCTest
@testable import LatinService

class Psalm125Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 125, section: nil)
    
    // MARK: - Test Data
    let psalm125 = [
        "In convertendo Dominus captivitatem Sion: facti sumus sicut consolati.",
        "Tunc repletum est gaudio os nostrum: et lingua nostra exsultatione.",
        "Tunc dicent inter gentes: Magnificavit Dominus facere cum eis.",
        "Magnificavit Dominus facere nobiscum: facti sumus lætantes.",
        "Converte, Domine, captivitatem nostram: sicut torrens in austro.",
        "Qui seminant in lacrimis: in exsultatione metent.",
        "Euntes ibant et flebant: mittentes semina sua.",
        "Venientes autem venient cum exsultatione: portantes manipulos suos."
    ]
    
    // MARK: - Test Cases
    
    // 1. Test for Restoration and Return
    func testRestorationThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm125)
        
        let restorationTerms = [
            ("converto", ["convertendo", "Converte"], "turn/restore"),
            ("captivitas", ["captivitatem", "captivitatem"], "captivity"),
            ("Sion", ["Sion"], "Zion"),
            ("consolor", ["consolati"], "comfort"),
            ("torrens", ["torrens"], "stream")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: restorationTerms)
    }
    
    // 2. Test for Joy and Exultation
    func testJoyExpressions() {
        let analysis = latinService.analyzePsalm(id, text: psalm125)
        
        let joyTerms = [
            ("gaudium", ["gaudio"], "joy"),
            ("exsultatio", ["exsultatione", "exsultatione"], "exultation"),
            ("laetor", ["lætantes"], "rejoice"),
            ("magnifico", ["Magnificavit", "Magnificavit"], "magnify"),
            ("os", ["os"], "mouth")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: joyTerms)
    }
    
    // 3. Test for Agricultural Metaphors (Sowing and Reaping)
    func testAgriculturalImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm125)
        
        let agriculturalTerms = [
            ("semen", ["semina"], "seed"),
            ("meto", ["metent"], "reap"),
            ("lacrima", ["lacrimis"], "tears"),
            ("manipulus", ["manipulos"], "sheaf"),
            ("fleo", ["flebant"], "weep")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: agriculturalTerms)
    }
    
    // 4. Test for Divine Action
    func testDivineIntervention() {
        let analysis = latinService.analyzePsalm(id, text: psalm125)
        
        let divineTerms = [
            
            ("facio", ["facere", "facere"], "make"),
            ("repleo", ["repletum"], "fill"),
            ("mitto", ["mittentes"], "send"),
            ("porto", ["portantes"], "carry")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    // 5. Test for Movement and Journey
    func testMovementThemes() {
        let analysis = latinService.analyzePsalm(id, text: psalm125)
        
        let movementTerms = [
            ("eo", ["euntes"], "go"),  
            ("venio", ["venientes"], "come"),
            ("auster", ["austro"], "south wind"),
            ("inter", ["inter"], "among"),
            ("noster", ["nostrum", "nostra", "nostram"], "our")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: movementTerms)
    }
    func testsAnalysisSummary() {
        let analysis = latinService.analyzePsalm(id, text: psalm125)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'eo' forms:", analysis.dictionary["eo"]?.forms ?? [:])

             print("'quis' forms:", analysis.dictionary["quis"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
    // Create a case-insensitive dictionary lookup
    let caseInsensitiveDictionary = Dictionary(uniqueKeysWithValues: 
        analysis.dictionary.map { key, value in
            (key.lowercased(), value)
        }
    )
    
    for (lemma, forms, translation) in confirmedWords {
        // Case-insensitive lemma lookup
        guard let entry = caseInsensitiveDictionary[lemma.lowercased()] else {
            XCTFail("Missing lemma: \(lemma)")
            continue
        }
        
        // Case-insensitive translation check
        let translationMatch = entry.translation?.lowercased().contains(translation.lowercased()) ?? false
        XCTAssertTrue(
            translationMatch,
            "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
        )
        
        // Case-insensitive form checking
        let entryFormsLowercased = Dictionary(uniqueKeysWithValues:
            entry.forms.map { key, value in
                (key.lowercased(), value)
            }
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
                print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
            }
        }
    }
}
}