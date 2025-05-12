import XCTest
@testable import LatinService

class Psalm118VauTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm118Vau = [
        "Et veniat super me misericordia tua, Domine, salutare tuum secundum eloquium tuum.",
        "Et respondebo exprobrantibus mihi verbum, quia speravi in sermonibus tuis.",
        "Et ne auferas de ore meo verbum veritatis usquequaque, quia in judiciis tuis supersperavi.",
        "Et custodiam legem tuam semper, in saeculum et in saeculum saeculi.",
        "Et ambulabam in latitudine, quia mandata tua exquisivi.",
        "Et loquebar de testimoniis tuis in conspectu regum, et non confundebar.",
        "Et meditabar in mandatis tuis, quae dilexi.",
        "Et levavi manus meas ad mandata tua quae dilexi, et exercebar in justificationibus tuis."
    ]
    
    // MARK: - Test Cases
    func testPrayerLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm118Vau)
        
        let prayerTerms = [
            ("aufero", ["auferas"], "take away"),  // Psalm 118:43
            ("venio", ["veniat"], "come"),        // v.41 (subjunctive)
            ("custodiam", ["custodiam"], "keep")   // v.44 (deliberative)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: prayerTerms)
    }
        
    // 1. Test Divine Promise Vocabulary
    func testDivinePromiseTerms() {
        let analysis = latinService.analyzePsalm(text: psalm118Vau)
        
        let promiseTerms = [
            ("eloquium", ["eloquium"], "promise"),  // v.41
            ("sermo", ["sermonibus"], "word"),      // v.42
            ("veritas", ["veritatis"], "truth"),     // v.43
            ("salutare", ["salutare"], "salvation")  // v.41
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: promiseTerms)
        
        // Verify promise-related verbs
        XCTAssertNotNil(analysis.dictionary["spero"], "Key verb 'speravi' missing")
        XCTAssertNotNil(analysis.dictionary["superspero"], "Unique intensified hope")
    }
    
    // 2. Test Law-Keeping Actions
    func testLawKeepingActions() {
        let analysis = latinService.analyzePsalm(text: psalm118Vau)
        
        let actionTerms = [
            ("custodio", ["custodiam"], "keep"),        // v.44
            ("exerceo", ["exercebar"], "practice"),     // v.48
            ("meditor", ["meditabar"], "meditate"),     // v.47
            ("exquiro", ["exquisivi"], "seek diligently") // v.45
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: actionTerms)
        
        // Verify all actions are directed toward God's law
        let lawTermsCount = analysis.dictionary["lex"]?.forms.values.reduce(0, +) ?? 0
        XCTAssertGreaterThan(lawTermsCount, 0, "Law focus missing")
    }
    
    // 3. Test Confidence Motifs
    func testConfidenceThemes() {
        let analysis = latinService.analyzePsalm(text: psalm118Vau)
        
        let confidenceTerms = [
            ("latitudo", ["latitudine"], "freedom"),    // v.45
            ("confundor", ["confundebar"], "ashamed"), // v.46
            ("respondeo", ["respondebo"], "answer"),    // v.42
            ("levo", ["levavi"], "lift")            // v.48
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: confidenceTerms)
        
        // Verify contrast with adversaries
        let adversaryTerms = analysis.dictionary["exprobro"]?.forms["exprobrantibus"] ?? 0
        XCTAssertEqual(adversaryTerms, 1, "Should reference adversaries")
    }
    
    // 4. Test Rare Intensive Forms
    func testRareIntensives() {
        let analysis = latinService.analyzePsalm(text: psalm118Vau)
        
        let intensiveTerms = [
            ("superspero", ["supersperavi"], "hope exceedingly"), // v.43
            ("usquequaque", ["usquequaque"], "utterly")          // v.43
           
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: intensiveTerms)
    }
    
    // 5. Test Love for God's Commands
    func testLoveForCommands() {
        let analysis = latinService.analyzePsalm(text: psalm118Vau)
        
        let loveTerms = [
            ("diligo", ["dilexi", "dilexi"], "love"),      // v.47, 48
            ("mandatum", ["mandata", "mandatis"], "command"), // v.45, 47
            ("testimonium", ["testimoniis"], "testimony") // v.46

        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: loveTerms)
        
        // Verify physical devotion gesture
        let handsLifted = analysis.dictionary["levo"]?.forms["levavi"] ?? 0
        XCTAssertEqual(handsLifted, 1, "Lifting hands gesture missing")
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
            
            // Form verification
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