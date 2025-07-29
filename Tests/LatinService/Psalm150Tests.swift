import XCTest
@testable import LatinService

class Psalm150Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm150 = [
        "Laudate Dominum in sanctis eius: laudate eum in firmamento virtutis eius.",
        "Laudate eum in virtutibus eius: laudate eum secundum multitudinem magnitudinis eius.",
        "Laudate eum in sono tubae: laudate eum in psalterio, et cithara.",
        "Laudate eum in tympano, et choro: laudate eum in chordis, et organo.",
        "Laudate eum in cymbalis benesonantibus: laudate eum in cymbalis iubilationis.",
        "Omnis spiritus laudet Dominum."
    ]
    let id = PsalmIdentity(number: 150, category: nil)
    
    // MARK: - Test Cases

    func testThemeLemmas() {
        let analysis = latinService.analyzePsalm(id, text: psalm150)
        
        // First theme (lines 1-2): Temple → Majesty
        let templeTerms = [
            ("sanctus", ["sanctis"], "holy"),
            ("firmamentum", ["firmamento"], "firmament"),
            ("virtus", ["virtutis", "virtutibus"], "power"),
            ("magnitudo", ["magnitudinis"], "greatness")
        ]
        
        // Second theme (lines 3-4): Instruments → Communion  
        let instrumentTerms = [
            ("tuba", ["tubae"], "trumpet"),
            ("psalterium", ["psalterio"], "psaltery"),
            ("cithara", ["cithara"], "harp"),
            ("tympanum", ["tympano"], "tambourine"),
            ("chorda", ["chordis"], "string"),
            ("organum", ["organo"], "organ")
        ]
        
        // Third theme (lines 5-6): Cymbals → Breath
        let cymbalTerms = [
            ("cymbalum", ["cymbalis"], "cymbal"),
            ("iubilatio", ["iubilationis"], "jubilation"),
            ("spiritus", ["spiritus"], "spirit"),
            ("laudo", ["Laudate", "laudet"], "praise")
        ]
        
        // Verify each theme group exactly like testPraiseVocabulary does
        verifyWordsInAnalysis(analysis, confirmedWords: templeTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: instrumentTerms) 
        verifyWordsInAnalysis(analysis, confirmedWords: cymbalTerms)
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