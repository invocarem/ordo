import XCTest
@testable import LatinService

class Psalm19Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 19, category: nil)
    // MARK: - Test Data
    let psalm19 = [
        "Exaudiat te Dominus in die tribulationis; protegat te nomen Dei Jacob.",
        "Mittat tibi auxilium de sancto, et de Sion tueatur te.",
        "Memor sit omnis sacrificii tui, et holocaustum tuum pingue fiat.",
        "Tribuat tibi secundum cor tuum, et omne consilium tuum confirmet.",
        "Laetabimur in salutari tuo; et in nomine Dei nostri magnificabimur.",
        "Impleat Dominus omnes petitiones tuas; nunc cognovi quoniam salvum fecit Dominus christum suum.",
        "Exaudiet illum de caelo sancto suo; in potentatibus salus dexterae ejus.",
        "Hi in curribus, et hi in equis; nos autem in nomine Domini Dei nostri invocabimus.",
        "Ipsi obligati sunt, et ceciderunt; nos autem surreximus et erecti sumus.",
        "Domine, salvum fac regem, et exaudi nos in die qua invocaverimus te."
    ]
    
    // MARK: - Test Cases
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'salvum' forms:", analysis.dictionary["salvus"]?.forms ?? [:])
        }
        
        XCTAssertGreaterThan(analysis.totalWords, 80)
        XCTAssertGreaterThan(analysis.uniqueLemmas, 40)
    }
    
    func testDivineIntervention() {
        latinService.configureDebugging(target: "tueor")
        let analysis = latinService.analyzePsalm(id, text: psalm19, startingLineNumber: 1)
        
        let interventionTerms = [
            ("exaudio", ["Exaudiat", "Exaudiet", "exaudi"], "hear"),
            ("protego", ["protegat"], "protect"),
            ("mitto", ["Mittat"], "send"),
            ("tueor", ["tueatur"], "guard"),
            ("impleo", ["Impleat"], "fulfill")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: interventionTerms)
    }
    
    func testRoyalMessianicLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        
        let royalTerms = [
            ("christus", ["christum"], "anointed"),
            ("rex", ["regem"], "king"),
            ("potentia", ["potentatibus"], "power"),
            ("dextera", ["dexterae"], "right hand"),
            ("confirmo", ["confirmet"], "strengthen")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: royalTerms)
    }
    
    func testSacrificialLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        
        let sacrificialTerms = [
            ("sacrificium", ["sacrificii"], "sacrifice"),
            ("holocaustum", ["holocaustum"], "burnt offering"),
            ("pinguis", ["pingue"], "rich/fat"),
            ("memor", ["Memor"], "mindful"),
            ("invoco", ["invocaverimus"], "call upon")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sacrificialTerms)
    }
    
    func testVictoryImagery() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        
        let victoryTerms = [
            ("currus", ["curribus"], "chariot"),
            ("equus", ["equis"], "horse"),
            ("cado", ["ceciderunt"], "fall"),
            ("surgo", ["surreximus"], "rise"),
            ("erigo", ["erecti"], "stand erect")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: victoryTerms)
    }
    
    func testCommunalResponse() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        
        let communalTerms = [
            ("laetor", ["Laetabimur"], "rejoice"),
            ("magnifico", ["magnificabimur"], "magnify"),
            ("nos", ["nos", "nobis"], "we/us"),
            ("nomen", ["nomine", "nomen"], "name"),
            ("salus", ["salutari", "salus"], "salvation")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: communalTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        
        let divineTerms = [
            ("dominus", ["dominus", "domini"], "lord"),
            ("deus", ["dei"], "god"),
            ("sanctus", ["sancto", "sancto"], "holy"),
            ("sion", ["sion"], "zion"),
            ("jacob", ["jacob"], "Jacob")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testHumanPetition() {
        let analysis = latinService.analyzePsalm(text: psalm19)
        
        let petitionTerms = [
            ("cor", ["cor"], "heart"),
            ("consilium", ["consilium"], "plan"),
            ("petitio", ["petitiones"], "petition"),
            ("dies", ["die"], "day"),
            ("tribulatio", ["tribulationis"], "trouble")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: petitionTerms)
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