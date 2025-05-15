import XCTest
@testable import LatinService

class Psalm8Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm8 = [
        "Domine, Dominus noster, quam admirabile est nomen tuum in universa terra!",
        "Quoniam elevata est magnificentia tua super caelos.",
        "Ex ore infantium et lactentium perfecisti laudem propter inimicos tuos: ut destruas inimicum et ultorem.",
        "Quoniam videbo caelos tuos, opera digitorum tuorum: lunam et stellas quae tu fundasti.",
        "Quid est homo quod memor es ejus? aut filius hominis, quoniam visitas eum?",
        "Minuisti eum paulo minus ab angelis: gloria et honore coronasti eum.",
        "Et constituisti eum super opera manuum tuarum: omnia subjecisti sub pedibus ejus.",
        "Oves et boves universas: insuper et pecora campi.",
        "Volucres caeli, et pisces maris: qui perambulant semitas maris.",
        "Domine, Dominus noster: quam admirabile est nomen tuum in universa terra!"
    ]
    
    // MARK: - Test Cases
    func testConsecutiveLinePairs() {
    for i in 0..<psalm8.count-1 {
        let lineA = psalm8[i]
        let lineB = psalm8[i+1]
        let combinedText = lineA + " " + lineB
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        if verbose {
            print("\n\n=== LINES \(i+1) & \(i+2) ===")
            print("LINE \(i+1): \"\(lineA)\"")
            print("LINE \(i+2): \"\(lineB)\"")
            print("\nDETECTED LEMMAS (\(analysis.dictionary.count)):")
            print(analysis.dictionary.keys.sorted().joined(separator: ", "))
        }
        
        // Basic assertion that we found some lemmas
        XCTAssertFalse(analysis.dictionary.isEmpty, "Should find lemmas in lines \(i+1)-\(i+2)")
        
        // Print any potential missing words (simple check for words not found as lemmas)
        if verbose {
            let allWords = combinedText.components(separatedBy: .whitespacesAndNewlines)
                .map { $0.trimmingCharacters(in: .punctuationCharacters) }
                .filter { !$0.isEmpty }
            
            let missingWords = allWords.filter { word in
                !analysis.dictionary.keys.contains { lemma in
                    word.lowercased().contains(lemma.lowercased())
                }
            }
            
            if !missingWords.isEmpty {
                print("\nPOTENTIALLY MISSING WORDS:")
                print(missingWords.joined(separator: ", "))
            }
        }
    }
}
    func testDivinePraiseVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm8)
        
        let praiseTerms = [
            ("admirabilis", ["admirabile"], "admirable"),
            ("magnificentia", ["magnificentia"], "magnificence"),
            ("laus", ["laudem"], "praise"),
            ("gloria", ["gloria"], "glory"),
            ("honor", ["honore"], "honor")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: praiseTerms)
    }
    
    func testCreationTerms() {
        let analysis = latinService.analyzePsalm(text: psalm8)
        
        let creationTerms = [
            ("caelum", ["caelos", "caeli"], "heaven"),
            ("terra", ["terra"], "earth"),
            ("luna", ["lunam"], "moon"),
            ("stella", ["stellas"], "star"),
            ("opus", ["opera"], "work")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: creationTerms)
    }
    
    func testHumanityTerms() {
        let analysis = latinService.analyzePsalm(text: psalm8)
        
        let humanityTerms = [
            ("homo", ["homo", "hominis"], "man"),
            ("infans", ["infantium"], "infant"),
            ("lactens", ["lactentium"], "nursing"),
            ("pes", ["pedibus"], "foot"),
            ("digitus", ["digitorum"], "finger")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: humanityTerms)
    }
    
    func testAnimalTerms() {
        let analysis = latinService.analyzePsalm(text: psalm8)
        
        let animalTerms = [
            ("ovis", ["oves"], "sheep"),
            ("bos", ["boves"], "ox"),
            ("pecus", ["pecora"], "cattle"),
            ("volucris", ["volucres"], "bird"),
            ("piscis", ["pisces"], "fish")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: animalTerms)
    }
    
    func testKeyVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm8)
        
        let keyVerbs = [
            ("elevo", ["elevata"], "raise"),
            ("perficio", ["perfecisti"], "perfect"),
            ("destruo", ["destruas"], "destroy"),
            ("fundo", ["fundasti"], "establish"),
            ("subjicio", ["subjecisti"], "subject")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
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