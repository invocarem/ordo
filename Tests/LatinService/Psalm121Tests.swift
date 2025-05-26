import XCTest
@testable import LatinService

class Psalm121Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 121, category: nil)
    
    // MARK: - Test Data
    let psalm121 = [
        "Laetatus sum in his quae dicta sunt mihi: In domum Domini ibimus.",
        "Stantes erant pedes nostri in atriis tuis, Jerusalem.",
        "Jerusalem, quae aedificatur ut civitas, cujus participatio ejus in idipsum.",
        "Illuc enim ascenderunt tribus, tribus Domini, testimonium Israel, ad confitendum nomini Domini.",
        "Quia illic sederunt sedes in judicio, sedes super domum David.",
        "Rogate quae ad pacem sunt Jerusalem, et abundantia diligentibus te.",
        "Fiat pax in virtute tua, et abundantia in turribus tuis.",
        "Propter fratres meos et proximos meos, loquebar pacem de te.",
        "Propter domum Domini Dei nostri, quaesivi bona tibi."
    ]
    
    // MARK: - Thematic Test Cases
    
    // 1. Pilgrimage Theme
    func testPilgrimageTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let pilgrimageTerms = [
            ("laetor", ["Laetatus"], "rejoice"), // v.1
            ("domus", ["domum"], "house"), // v.1
            ("eo", ["ibimus"], "go"), // v.1
            ("sto", ["Stantes"], "stay"), // v.2
            ("atrium", ["atriis"], "sacred space"), // v.2
            ("ascendo", ["ascenderunt"], "ascend") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: pilgrimageTerms)
        
        
    }
    
    // 2. Jerusalem as Sacred Center
    func testJerusalemTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let jerusalemTerms = [
            ("civitas", ["civitas"], "city"), // v.3
            ("aedifico", ["aedificatur"], "build"), // v.3
            ("turris", ["turribus"], "protection"), // v.7
            ("sedes", ["sedes"], "throne"), // v.5
            ("judicium", ["judicio"], "justice") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: jerusalemTerms)
        
       
    }
    
    // 3. Unity and Community
    func testUnityTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let unityTerms = [
            ("participatio", ["participatio"], "unity"), // v.3
            ("tribus", ["tribus"], "tribe"), // v.4
            ("confiteor", ["confitendum"], "confess"), // v.4
            ("frater", ["fratres"], "brother"), // v.8
            ("proximus", ["proximos"], "neighbor") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: unityTerms)
    }
    
    // 4. Divine Protection
    func testProtectionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let protectionTerms = [
            ("turris", ["turribus"], "tower"), // v.7
            ("virtus", ["virtute"], "strength"), // v.7
            ("bonus", ["bona"], "good") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    // 5. Peace and Abundance
    func testPeaceTheme() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let peaceTerms = [
            ("pax", ["pacem", "pax"], "peace"), // v.6,7,8
            ("abundantia", ["abundantia"], "plenty"), // v.6,7
            ("rogo", ["Rogate"], "pray"), // v.6
            ("diligo", ["diligentibus"], "love") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: peaceTerms)
        
        
    }
    
    // 6. Worship and Praise
    func testWorshipTheme() {
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        let worshipTerms = [
            ("nomen", ["nomini"], "name"), // v.4
            ("testimonium", ["testimonium"], "testimony"), // v.4
            ("laetor", ["Laetatus"], "rejoice"), // v.1
            ("quaero", ["quaesivi"], "seek") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: worshipTerms)
    }
    
    // MARK: - Helper Methods
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, 
                                     confirmedWords: [(lemma: String, 
                                                     forms: [String], 
                                                     translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain through translation
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
                print("  Forms found: \(entry.forms.keys.filter { forms.map { $0.lowercased() }.contains($0) }.count)/\(forms.count)")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
    
   
}