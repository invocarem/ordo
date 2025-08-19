import XCTest
@testable import LatinService

class Psalm129Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    let id   =  PsalmIdentity(number: 129, category: nil)
     
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm129 = [
        "De profundis clamavi ad te, Domine;",
        "Domine, exaudi vocem meam. Fiant aures tuae intendentes in vocem deprecationis meae.",
        "Si iniquitates observaveris, Domine, Domine, quis sustinebit?",
        "Quia apud te propitiatio est, et propter legem tuam sustinui te, Domine.",
        "Sustinuit anima mea in verbo ejus; speravit anima mea in Domino.",
        "A custodia matutina usque ad noctem, speret Israel in Domino.",
        "Quia apud Dominum misericordia, et copiosa apud eum redemptio.",
        "Et ipse redimet Israel ex omnibus iniquitatibus ejus."
    ]
    
    // MARK: - Test Cases
    
    func testDepthAndRedemptionVocabulary() {
        let analysis = latinService.analyzePsalm(id, text: psalm129)
        
        let keyTerms = [
            ("profundum", ["profundis"], "depth"),
            ("propitiatio", ["propitiatio"], "propitiation"),
            ("redemptio", ["redemptio"], "redemption"),
            ("iniquitas", ["iniquitates", "iniquitatibus"], "iniquity"),
            ("misericordia", ["misericordia"], "mercy")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: keyTerms)
    }
    
    func testDivineResponseVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm129)
        
        let responseVerbs = [
            ("clamo", ["clamavi"], "cry out"),
            ("exaudio", ["exaudi"], "hear"),
            ("spero", ["speravit", "speret"], "hope"),
            ("sustineo", ["sustinebit", "sustinui", "sustinuit"], "endure"),
            ("redimo", ["redimet"], "redeem")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: responseVerbs)
    }
    
    func testPrayerElements() {
        let analysis = latinService.analyzePsalm(id, text: psalm129)
        
        let prayerTerms = [
            ("deprecatio", ["deprecationis"], "supplication"),
            ("vox", ["vocem", "vocem"], "voice"),
            ("auris", ["aures"], "ear"),
            ("custodia", ["custodia"], "watch"),
            ("animus", ["anima"], "soul")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: prayerTerms)
    }
    
    func testTemporalReferences() {
        let analysis = latinService.analyzePsalm(id, text: psalm129)
        
        let timeTerms = [
            ("matutinus", ["matutina"], "morning"),
            ("nox", ["noctem"], "night"),
            ("usque", ["usque"], "all the way")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: timeTerms)
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