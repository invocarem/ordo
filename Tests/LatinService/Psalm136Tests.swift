import XCTest
@testable import LatinService

class Psalm136Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm136 = [
        "Super flumina Babylonis, illic sedimus et flevimus: cum recordaremur Sion.",
        "In salicibus in medio ejus, suspendimus organa nostra.",
        "Quia illic interrogaverunt nos, qui captivos duxerunt nos, verba cantionum.",
        "Et qui abduxerunt nos: Hymnum cantate nobis de canticis Sion.",
        "Quomodo cantabimus canticum Domini in terra aliena?",
        "Si oblitus fuero tui, Jerusalem, oblivioni detur dextera mea.",
        "Adhaereat lingua mea faucibus meis, si non meminero tui: si non proposuero Jerusalem, in principio laetitiae meae.",
        "Memor esto, Domine, filiorum Edom, in die Jerusalem: qui dicunt: Exinanite, exinanite usque ad fundamentum in ea.",
        "Filia Babylonis misera: beatus qui retribuet tibi retributionem tuam, quam retribuisti nobis.",
        "Beatus qui tenebit, et allidet parvulos tuos ad petram."
    ]
    
    // MARK: - Test Cases
    
    func testExileVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        
        let exileTerms = [
            ("flumen", ["flumina"], "rivers"), // "Super flumina Babylonis" (v.1)
            ("salix", ["salicibus"], "willows"), // "In salicibus" (v.2)
            ("captivus", ["captivos"], "captives"), // "qui captivos duxerunt" (v.3)
            ("organum", ["organa"], "harps") // "suspendimus organa" (v.2)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: exileTerms)
    }
    
    func testPoeticDevices() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        
        let poeticTerms = [
            ("cantus", ["canticum", "cantionum"], "song"), // "verba cantionum" (v.3), "canticum Domini" (v.4)
            ("memini", ["meminero"], "remember"), // "si non meminero tui" (v.6)
            ("retributio", ["retributionem"], "repayment"), // "retribuet tibi retributionem" (v.8)
            ("exinanio", ["Exinanite"], "demolish") // "Exinanite usque ad fundamentum" (v.7)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: poeticTerms)
    }
    
    func testGeographicalReferences() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        
        let places = [
            ("Babylon", ["Babylonis"], "Babylon"), // "Super flumina Babylonis" (v.1)
            ("Sion", ["Sion"], "Zion"), // "recordaremur Sion" (v.1)
            ("Jerusalem", ["Jerusalem"], "Jerusalem"), // "Si oblitus fuero tui Jerusalem" (v.5)
            ("Edom", ["Edom"], "Edom") // "filiorum Edom" (v.7)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: places)
    }
    
    func testViolentImagery() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        
        let violentTerms = [
            ("allido", ["allidet"], "dash against"), // "allidet parvulos ad petram" (v.9)
            ("fundamentum", ["fundamentum"], "foundation"), // "usque ad fundamentum" (v.7)
            ("petra", ["petram"], "rock") // "ad petram" (v.9)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: violentTerms)
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