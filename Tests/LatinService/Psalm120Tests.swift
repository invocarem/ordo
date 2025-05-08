import XCTest
@testable import LatinService

class Psalm120Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm120 = [
        "Levavi oculos meos in montes, unde veniet auxilium mihi.",
        "Auxilium meum a Domino, qui fecit caelum et terram.",
        "Non det in commotionem pedem tuum, neque dormitet qui custodit te.",
        "Ecce non dormitabit neque dormiet, qui custodit Israel.",
        "Dominus custodit te; Dominus protectio tua super manum dexteram tuam.",
        "Per diem sol non uret te, neque luna per noctem.",
        "Dominus custodit te ab omni malo; custodiat animam tuam Dominus.",
        "Dominus custodiat introitum tuum et exitum tuum, ex hoc nunc et usque in saeculum"
    ]
    
    // MARK: - Test Cases
    
    func testDivineProtectionVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let protectionTerms = [
            ("custodio", ["custodit", "custodiat", "custodiet"], "guard"), // v.3-8
            ("protectio", ["protectio"], "protection"), // v.5
            ("auxilium", ["auxilium", "auxilium"], "help"), // v.1-2
            ("malus", ["malo"], "evil") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let divineTerms = [
            ("dominus", ["Domino", "Dominus"], "Lord"), // v.2,4,5,7,8
            ("caelum", ["caelum"], "heaven"), // v.2
            ("terra", ["terram"], "earth"), // v.2
            ("Israel", ["Israel"], "Israel") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testHumanBodyReferences() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let bodyTerms = [
            ("oculus", ["oculos"], "eye"), // v.1
            ("pes", ["pedem"], "foot"), // v.3
            ("manus", ["manum"], "hand"), // v.5
            ("animus", ["animam"], "soul") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    
    func testTimeAndSpaceReferences() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let spaceTimeTerms = [
            ("mons", ["montes"], "mountain"), // v.1
            ("dies", ["diem"], "day"), // v.6
            ("nox", ["noctem"], "night"), // v.6
            ("saeculum", ["saeculum"], "age") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: spaceTimeTerms)
    }
    
    func testCelestialImagery() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let celestialTerms = [
            ("sol", ["sol"], "sun"), // v.6
            ("luna", ["luna"], "moon"), // v.6
            ("caelum", ["caelum"], "heaven"), // v.2
            ("terra", ["terram"], "earth") // v.2
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: celestialTerms)
    }
    
    func testMovementVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let movementTerms = [
            ("levo", ["Levavi"], "lift"), // v.1
            ("venio", ["veniet"], "come"), // v.1
            ("introitus", ["introitum"], "entrance"), // v.8
            ("exitus", ["exitum"], "exit") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: movementTerms)
    }
    
    func testNegativeProtectionVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        let negativeTerms = [
            ("dormito", ["dormitet", "dormitabit", "dormiet"], "sleep"), // v.3-4
            ("uro", ["uret"], "burn") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: negativeTerms)
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