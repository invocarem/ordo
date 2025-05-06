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
        "Laudate Dominum in sanctis ejus: laudate eum in firmamento virtutis ejus.",
        "Laudate eum in virtutibus ejus: laudate eum secundum multitudinem magnitudinis ejus.",
        "Laudate eum in sono tubae: laudate eum in psalterio, et cithara.",
        "Laudate eum in tympano, et choro: laudate eum in chordis, et organo.",
        "Laudate eum in cymbalis benesonantibus: laudate eum in cymbalis jubilationis.",
        "Omnis spiritus laudet Dominum."
    ]
    
    // MARK: - Test Cases
    
    func testPraiseVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm150)
        
        let praiseTerms = [
            ("laudo", ["Laudate", "laudet"], "praise"),
            ("magnitudo", ["magnitudinis"], "greatness"),
            ("jubilatio", ["jubilationis"], "jubilation"),
            ("virtus", ["virtutis", "virtutibus"], "power"),
            ("sanctus", ["sanctis"], "holy")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: praiseTerms)
    }
    
    func testMusicalInstruments() {
        let analysis = latinService.analyzePsalm(text: psalm150)
        
        let instrumentTerms = [
            ("tuba", ["tubae"], "trumpet"),
            ("psalterium", ["psalterio"], "psaltery"),
            ("cithara", ["cithara"], "harp"),
            ("tympanum", ["tympano"], "tambourine"),
            ("chorda", ["chordis"], "string"),
            ("organum", ["organo"], "organ"),
            ("cymbalum", ["cymbali", "cymbalis"], "cymbal")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: instrumentTerms)
    }
    
    func testMusicalContext() {
        let analysis = latinService.analyzePsalm(text: psalm150)
        
        let musicTerms = [
            ("sonus", ["sono"], "sound"),
            ("chorus", ["choro"], "dance"),
            ("benesonans", ["benesonantibus"], "resounding"),
            ("psallere", ["psalterio"], "to play the psaltery")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: musicTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm150)
        
        let divineTerms = [
            ("Dominus", ["Dominum"], "Lord"),
            ("firmamentum", ["firmamento"], "firmament"),
            ("multitudo", ["multitudinem"], "multitude"),
            ("spiritus", ["spiritus"], "spirit")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testStructuralElements() {
        let analysis = latinService.analyzePsalm(text: psalm150)
        
        let structuralTerms = [
            ("in", ["in"], "in"),
            ("et", ["et"], "and"),
            ("secundum", ["secundum"], "according to"),
            ("omnis", ["Omnis"], "all")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: structuralTerms)
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