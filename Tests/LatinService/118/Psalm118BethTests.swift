import XCTest
@testable import LatinService

class Psalm118BethTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm118Beth = [
        "In quo corrigit adolescentior viam suam? In custodiendo sermones tuos.",
        "In toto corde meo exquisivi te, ne repellas me a mandatis tuis.",
        "In corde meo abscondi eloquia tua, ut non peccem tibi.",
        "Benedictus es, Domine, doce me justificationes tuas.",
        "In labiis meis pronuntiavi omnia judicia oris tui.",
        "In via testimoniorum tuorum delectatus sum, sicut in omnibus divitiis.",
        "In mandatis tuis exercebor, et considerabo vias tuas.",
        "In justificationibus tuis meditabor, non obliviscar sermones tuos."
    ]

    func testBeth() {
    
        let analysis = latinService.analyzePsalm(text: psalm118Beth)
        
        print("All forms detected for 'mandatum':")
        analysis.dictionary["mandatum"]?.forms.forEach { print("\($0.key): \($0.value)") }

        print("All forms detected for 'benedico':")
        analysis.dictionary["benedico"]?.forms.forEach { print("\($0.key): \($0.value)") }

        print("All forms detected for 'benedictus':")
        analysis.dictionary["benedictus"]?.forms.forEach { print("\($0.key): \($0.value)") }

        // 1. Basic Statistics
        XCTAssertGreaterThan(analysis.totalWords, 0, "Should have words in psalm")
        XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should have unique words")
        XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should have unique lemmas")
        
        // 2. Key Lemmas (Nouns/Adjectives)
        XCTAssertNotNil(analysis.dictionary["adolescens"], "Should have 'adolescentior' (comparative of 'adolescens')")
        XCTAssertNotNil(analysis.dictionary["sermo"], "Should have 'sermo' (from 'sermones')")
        XCTAssertNotNil(analysis.dictionary["cor"], "Should have 'cor' (from 'corde')")

        // mandatis could be in mando or mandatum, which one it's????? here it should be mandatum
        XCTAssertNotNil(analysis.dictionary["mandatum"], "Should have 'mandatum' (from 'mandatis')")
    


        // 3. Verb Validation
        if let custodioEntry = analysis.dictionary["custodio"] {
            XCTAssertEqual(custodioEntry.entity?.partOfSpeech, .verb, "Should be a verb")
            XCTAssertGreaterThan(custodioEntry.forms["custodiendo"] ?? 0, 0, "Gerund 'custodiendo' should appear")
        } else {
            XCTFail("Missing 'custodio' in analysis")
        }
        
        // 4. Adjective Checks
        if let benedictusEntry = analysis.dictionary["benedictus"] {
            XCTAssertEqual(benedictusEntry.entity?.partOfSpeech, .adjective, "Should be an adjective")
            XCTAssertEqual(benedictusEntry.translation, "blessed", "Translation should match")
            XCTAssertGreaterThan(benedictusEntry.forms["benedictus"] ?? 0, 0, "Nominative form should appear")
        }
        
        // 5. Special Forms
        if let domineEntry = analysis.dictionary["dominus"] {
            XCTAssertGreaterThan(domineEntry.forms["domine"] ?? 0, 0, "Vocative 'domine' should appear")
        }
        
        // 6. Noun Properties
        if let sermoEntry = analysis.dictionary["sermo"] {
            XCTAssertEqual(sermoEntry.entity?.declension, 3, "Should be 3rd declension")
            XCTAssertEqual(sermoEntry.entity?.gender, .masculine, "Gender should be masculine")
            XCTAssertGreaterThan(sermoEntry.forms["sermones"] ?? 0, 0, "Plural form 'sermones' should appear")
        }
        
        // 7. Debug Output (Optional)
        print("\nObserved forms for 'custodio':")
        analysis.dictionary["custodio"]?.forms.forEach { print("- \($0.key): \($0.value)") }
    }

    // MARK: - Test Cases
    
    func testSpiritualGuidanceVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm118Beth)
        
        let guidanceTerms = [
            ("corrigo", ["corrigit"], "correct"),
            ("custodio", ["custodiendo"], "keep"),
            ("doceo", ["doce"], "teach"),
            ("considero", ["considerabo"], "consider"),
            ("meditor", ["meditabor"], "meditate")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: guidanceTerms)
    }
    
    func testDivineCommunicationTerms() {
        let analysis = latinService.analyzePsalm(text: psalm118Beth)
        
        let communicationTerms = [
            ("sermo", ["sermones", "sermones"], "word"),
            ("eloquium", ["eloquia"], "utterance"),
            ("judicium", ["judicia"], "judgment"),
            ("testimonium", ["testimoniorum"], "testimony"),
            ("mandatum", ["mandatis", "mandatis", "mandatis"], "commandment")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: communicationTerms)
    }
    
    func testInternalizationTerms() {
        let analysis = latinService.analyzePsalm(text: psalm118Beth)
        
        let internalTerms = [
            ("cor", ["corde", "corde"], "heart"),
            ("abscondo", ["abscondi"], "hide"),
            ("exquiro", ["exquisivi"], "seek"),
            ("obliviscor", ["obliviscar"], "forget"),
            ("pronuntio", ["pronuntiavi"], "declare")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: internalTerms)
    }
    
    func testBehavioralVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm118Beth)
        
        let behavioralVerbs = [
            ("delector", ["delectatus"], "delight"),
            ("exerceo", ["exercebor"], "exercise"),
            ("pecco", ["peccem"], "sin"),
            ("repello", ["repellas"], "reject"),
            ("benedico", ["benedictus"], "bless")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: behavioralVerbs)
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