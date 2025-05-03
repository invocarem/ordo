import XCTest
@testable import LatinService

class Psalm118AlephTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 118:1-8 "Aleph" section)
    let psalm118Aleph = [
        "Beati immaculati in via, qui ambulant in lege Domini.",
        "Beati qui scrutantur testimonia eius, in toto corde exquirunt eum.",
        "Non enim qui operantur iniquitatem, in viis eius ambulaverunt.",
        "Tu mandasti mandata tua custodire nimis.",
        "Utinam dirigantur viae meae ad custodiendas justificationes tuas!",
        "Tunc non confundar, cum perspexero in omnibus mandatis tuis.",
        "Confitebor tibi in directione cordis, in eo quod didici judicia justitiae tuae.",
        "Justificationes tuas custodiam; non me derelinquas usquequaque."
    ]
    
    // MARK: - Test Cases
    
    func testBeatitudeStatements() {
        let analysis = latinService.analyzePsalm(text: psalm118Aleph)
        
        let blessedTerms = [
            ("beatus", ["Beati"], "blessed"), // v.1, v.2
            ("immaculatus", ["immaculati"], "blameless"), // v.1
            ("confundor", ["confundar"], "be ashamed") // v.6 (negated)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: blessedTerms)
    }
    
    func testTorahActionVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm118Aleph)
        
        let actionVerbs = [
            ("ambulo", ["ambulant", "ambulaverunt"], "walk"), // v.1, v.3
            ("scrutor", ["scrutantur"], "search"), // v.2
            ("custodio", ["custodire", "custodiendas", "custodiam"], "keep") // v.4, v.5, v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: actionVerbs)
    }
    
    func testDivinePrecepts() {
        let analysis = latinService.analyzePsalm(text: psalm118Aleph)
        
        let lawTerms = [
            ("lex", ["lege"], "law"), // v.1
            ("testimonium", ["testimonia"], "testimony"), // v.2
            ("mandatum", ["mandata", "mandatis"], "commandment"), // v.4, v.6
            ("justificatio", ["justificationes", "justificationes"], "ordinance") // v.5, v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lawTerms)
    }
    
    func testSpiritualDirection() {
        let analysis = latinService.analyzePsalm(text: psalm118Aleph)
        
        let guidanceTerms = [
            ("via", ["via", "viis", "viae"], "way"), // v.1, v.3, v.5
            ("dirigo", ["dirigantur"], "direct"), // v.5
            ("derelinquo", ["derelinquas"], "forsake") // v.8 (negated)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: guidanceTerms)
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
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}