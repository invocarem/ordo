import XCTest
@testable import LatinService

class Psalm118CophTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let identity = PsalmIdentity(number: 118, category: "pe")
    // MARK: - Test Data (Psalm 118:145-152 "Coph" category)
    let psalm118Coph = [
        "Clamavi in toto corde meo, exaudi me, Domine; justificationes tuas requiram.",
        "Clamavi ad te, salvum me fac, ut custodiam mandata tua.",
        "Praeveni in maturitate, et clamavi, quia in verba tua supersperavi.",
        "Praevenerunt oculi mei ad te diluculo, ut meditarer eloquia tua.",
        "Vocem meam audi secundum misericordiam tuam, Domine, et secundum judicium tuum vivifica me.",
        "Appropinquaverunt persequentes me iniquitatem, a lege autem tua longe facti sunt.",
        "Prope es tu, Domine, et omnes viae tuae veritas.",
        "Initio cognovi de testimoniis tuis, quia in aeternum fundasti ea."
    ]
    
    // MARK: - Test Cases
    
    func testUrgentPetitions() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Coph)
        
        let petitions = [
            ("clamo", ["clamavi", "clamavi", "clamavi"], "cry out"), // v.145, v.146, v.147
            ("exaudio", ["exaudi"], "hear"), // v.145
            ("salvus", ["salvum"], "save"), // v.146
            ("audio", ["audi"], "hear"), // v.149
            ("vivifico", ["vivifica"], "give life") // v.149
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: petitions)
    }
    
    func testTemporalReferences() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Coph)
        
        let temporalTerms = [
            ("maturitas", ["maturitate"], "dawn"), // v.147
            ("diluculum", ["diluculo"], "daybreak"), // v.148
            ("initium", ["initio"], "beginning") // v.152
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: temporalTerms)
    }
    
    func testTorahEngagement() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Coph)
        
        let engagementTerms = [
            ("justificatio", ["justificationes"], "ordinance"), // v.145
            ("mandatum", ["mandata"], "commandment"), // v.146
            ("verbum", ["verba"], "word"), // v.147
            ("elogium", ["elogia"], "expression"), // v.148
            ("lex", ["lege"], "law"), // v.150
            ("testimonium", ["testimoniis"], "testimony") // v.152
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: engagementTerms)
    }
    
    func testDivineProximity() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Coph)
        
        let proximityTerms = [
            ("prope", ["prope"], "near"), // v.151
            ("longe", ["longe"], "far"), // v.150
            ("appropinquo", ["appropinquaverunt"], "draw near"), // v.150
            ("praevenio", ["praeveni", "praevenerunt"], "come before") // v.147, v.148
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: proximityTerms)
    }
    
    func testContrastingStates() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Coph)
        
        let contrasts = [
            ("misericordia", ["misericordiam"], "mercy"), // v.149
            ("judicium", ["judicium"], "judgment"), // v.149
            ("iniquitas", ["iniquitatem"], "wickedness"), // v.150
            ("veritas", ["veritas"], "truth") // v.151
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: contrasts)
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