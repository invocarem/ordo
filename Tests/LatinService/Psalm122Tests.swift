import XCTest
@testable import LatinService

class Psalm122Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm121 = [
        "Ad Dominum cum tribularer clamavi, et exaudivit me.",
        "Domine, libera animam meam a labiis iniquis et a lingua dolosa.",
        "Quid detur tibi aut quid apponatur tibi ad linguam dolosam?",
        "Sagittae potentis acutae cum carbonibus desolatoriis.",
        "Heu mihi quia incolatus meus prolongatus est! Habitavi cum habitantibus Cedar.",
        "Multum incola fuit anima mea cum his qui oderunt pacem.",
        "Ego pacem cum eis eram; cum loquebar illis, impugnabant me gratis."
    ]
    
    // MARK: - Test Cases
    
    func testDistressVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let distressTerms = [
            ("tribulor", ["tribularer"], "be distressed"), // v.1
            ("heu", ["Heu"], "woe"), // v.5
            ("incolatus", ["incolatus"], "sojourn"), // v.5
            ("prolongo", ["prolongatus"], "prolonged") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: distressTerms)
    }
    
    func testDivineResponseVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let responseTerms = [
            ("clamo", ["clamavi"], "cry out"), // v.1
            ("exaudio", ["exaudivit"], "hear"), // v.1
            ("libero", ["libera"], "deliver") // v.2
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: responseTerms)
    }
    
    func testDeceptiveSpeechVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let speechTerms = [
            ("labium", ["labiis"], "lips"), // v.2
            ("lingua", ["lingua", "linguam"], "tongue"), // v.2,3
            ("dolosus", ["dolosa", "dolosam"], "deceitful"), // v.2,3
            ("loquor", ["loquebar"], "speak") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: speechTerms)
    }
    
    func testViolentImagery() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let violentTerms = [
            ("sagitta", ["Sagittae"], "arrow"), // v.4
            ("potens", ["potentis"], "powerful"), // v.4
            ("carbo", ["carbonibus"], "coal"), // v.4
            ("desolatorius", ["desolatoriis"], "destructive"), // v.4
            ("impugno", ["impugnabant"], "attack") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: violentTerms)
    }
    
    func testGeographicalReferences() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let geoTerms = [
            ("Cedar", ["Cedar"], "Kedar"), // v.5
            ("habito", ["habitavi", "habitantibus"], "dwell") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: geoTerms)
    }
    
    func testSocialConflictVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let conflictTerms = [
            ("odium", ["oderunt"], "hate"), // v.6
            ("pax", ["pacem", "pacem"], "peace"), // v.6,7
            ("gratis", ["gratis"], "without cause") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: conflictTerms)
    }
    
    func testPersonalPronouns() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let pronounTerms = [
            ("ego", ["Ego"], "I"), // v.7
            ("meus", ["meus"], "my"), // v.5
            ("mea", ["mea"], "my"), // v.6
            ("me", ["me", "me", "me"], "me") // v.1,2,7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: pronounTerms)
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