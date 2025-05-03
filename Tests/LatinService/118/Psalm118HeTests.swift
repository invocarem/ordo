import XCTest
@testable import LatinService

class Psalm118HeTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 118:33-40 "He" section)
    let psalm118He = [
        "Legem pone mihi, Domine, viam justificationum tuarum, et exquiram eam semper.",
        "Da mihi intellectum, et scrutabor legem tuam, et custodiam illam in toto corde meo.",
        "Deduc me in semitam mandatorum tuorum, quia ipsam volui.",
        "Inclina cor meum in testimonia tua, et non in avaritiam.",
        "Averte oculos meos ne videant vanitatem; in via tua vivifica me.",
        "Statue servo tuo eloquium tuum in timore tuo.",
        "Amputa opprobrium meum quod suspicatus sum, quia judicia tua jucunda.",
        "Ecce concupivi mandata tua; in aequitate tua vivifica me."
    ]
    
    // MARK: - Test Cases
    
    func testPetitionVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm118He)
        
        let petitions = [
            ("pono", ["pone"], "set before"), // v.33
            ("deduco", ["deduc"], "lead"), // v.35
            ("inclino", ["inclina"], "incline"), // v.36
            ("averto", ["averte"], "turn away") // v.37
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: petitions)
    }
    
    func testTorahTerminology() {
        let analysis = latinService.analyzePsalm(text: psalm118He)
        
        let lawTerms = [
            ("justificatio", ["justificationum"], "justice"), // v.33
            ("mandatum", ["mandatorum"], "commandment"), // v.35
            ("testimonium", ["testimonia"], "testimony"), // v.36
            ("judicium", ["judicia"], "judgment") // v.39
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lawTerms)
    }
    
    func testSpiritualFaculties() {
        let analysis = latinService.analyzePsalm(text: psalm118He)
        
        let faculties = [
            ("intellectus", ["intellectum"], "understanding"), // v.34
            ("cor", ["corde", "cor"], "heart"), // v.34, v.36
            ("oculus", ["oculos"], "eye") // v.37
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: faculties)
    }
    
    func testVitalityRequests() {
        let analysis = latinService.analyzePsalm(text: psalm118He)
        
        let lifeTerms = [
            ("vivifico", ["vivifica"], "give life"), // v.37, v.40
            ("custodio", ["custodiam"], "keep"), // v.34
            ("concupisco", ["concupivi"], "long for") // v.40
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lifeTerms)
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