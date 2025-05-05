import XCTest
@testable import LatinService

class Psalm118ReshTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 118:153-160 "Resh" section)
    let psalm118Resh = [
        "Vide humilitatem meam, et eripe me, quia legem tuam non sum oblitus.",
        "Judica judicium meum, et redime me, propter eloquium tuum vivifica me.",
        "Longe a peccatoribus salus, quia justificationes tuas non exquisierunt.",
        "Misericordiae tuae multae, Domine, secundum judicium tuum vivifica me.",
        "Multi qui persequuntur me, et tribulant me; a testimoniis tuis non declinavi.",
        "Vidi praevaricantes, et tabescebam, quia eloquia tua non custodierunt.",
        "Vide quoniam mandata tua dilexi, Domine, in misericordia tua vivifica me.",
        "Principium verborum tuorum veritas, in aeternum omnia judicia justitiae tuae."
    ]
    
    // MARK: - Test Cases
    
    func testPetitionVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm118Resh)
        
        let petitions = [
            ("video", ["vide", "vide"], "see"), // v.153, v.159
            ("eripio", ["eripe"], "rescue"), // v.153
            ("judico", ["judica"], "judge"), // v.154
            ("redimo", ["redime"], "redeem"), // v.154
            ("vivifico", ["vivifica", "vivifica"], "give life") // v.154, v.156, v.159
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: petitions)
    }
    
    func testContrastingParties() {
        let analysis = latinService.analyzePsalm(text: psalm118Resh)
        
        let parties = [
            ("peccator", ["peccatoribus"], "sinner"), // v.155
            ("praevaricator", ["praevaricantes"], "transgressor"), // v.158
            ("persequor", ["persequuntur"], "persecutor") // v.157
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: parties)
    }
    
    func testTorahCommitment() {
        let analysis = latinService.analyzePsalm(text: psalm118Resh)
        
        let commitmentTerms = [
            ("lex", ["legem"], "law"), // v.153
            ("eloquium", ["eloquium"], "word"), // v.154, v.158
            ("elogium", ["elogia"], "expression"),
            ("justificatio", ["justificationes"], "ordinance"), // v.155
            ("testimonium", ["testimoniis"], "testimony"), // v.157
            ("mandatum", ["mandata"], "commandment") // v.159
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: commitmentTerms)
    }
    
    func testEmotionalResponses() {
        let analysis = latinService.analyzePsalm(text: psalm118Resh)
        
        let emotions = [
            ("humilitas", ["humilitatem"], "affliction"), // v.153
            ("tribulo", ["tribulant"], "trouble"), // v.157
            ("tabesco", ["tabescebam"], "languish"), // v.158
            ("diligo", ["dilexi"], "love") // v.159
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: emotions)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm118Resh)
        
        let attributes = [
            ("misericordia", ["misericordiae", "misericordia"], "mercy"), // v.156, v.159
            ("judicium", ["judicium", "judicia"], "judgment"), // v.156, v.160
            ("veritas", ["veritas"], "truth"), // v.160
            ("justitia", ["justitiae"], "righteousness") // v.160
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: attributes)
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