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
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm118He)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'concupisco' forms:", analysis.dictionary["concupisco"]?.forms ?? [:])
            print("'statuo' forms:", analysis.dictionary["statuo"]?.forms ?? [:])
            print("'spero' forms:", analysis.dictionary["spero"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
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