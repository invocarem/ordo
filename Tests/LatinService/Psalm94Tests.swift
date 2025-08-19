import XCTest
@testable import LatinService

class Psalm94Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let identity = PsalmIdentity(number: 94, category: "")
    
    // MARK: - Test Data (Psalm 94)
    let psalm94 = [
        "Venite, exsultemus Domino; iubilemus Deo salutari nostro.",
        "Praeveniamus faciem eius in confessione, et in psalmis iubilemus ei.",
        "Quoniam Deus magnus Dominus, et rex magnus super omnes deos.",
        "Quia in manu eius sunt omnes fines terrae, et altitudines montium ipsius sunt.",
        "Quoniam ipsius est mare, et ipse fecit illud, et aridam fundaverunt manus eius.",
        "Venite, adoremus, et procidamus ante Deum; ploremus coram Domino qui fecit nos.",
        "Quia ipse est Dominus Deus noster, et nos populus pascuae eius, et oves manus eius.",
        "Hodie si vocem eius audieritis, nolite obdurare corda vestra,",
        "sicut in exacerbatione secundum diem tentationis in deserto, ubi tentaverunt me patres vestri, probaverunt et viderunt opera mea.",
        "Quadraginta annis offensus fui generationi illi, et dixi: Semper hi errant corde.",
        "Et isti non cognoverunt vias meas: ut iuravi in ira mea: Si introibunt in requiem meam."
    ]
    
    // MARK: - Critical Tests for Psalm 94
    
    func testInvitatoryVerbs() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let invitatoryVerbs = [
            ("venio", ["Venite"], "come"), // v.1, v.6 - Repeated call
            ("exsulto", ["exsultemus"], "rejoice"), // v.1
            ("iubilo", ["iubilemus"], "shout"), // v.1, v.2
            ("praevenio", ["Praeveniamus"], "come before") // v.2 - Rare liturgical term
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: invitatoryVerbs)
    }
    
    func testWorshipActions() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let worshipTerms = [
            ("adoro", ["adoremus"], "adore"), // v.6
            ("procido", ["procidamus"], "prostrate"), // v.6 - Physical worship
            ("ploro", ["ploremus"], "weep"), // v.6 - Emotional response
            ("confessio", ["confessione"], "confession") // v.2 - Liturgical context
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: worshipTerms)
    }
    
    func testDivineCreationTerms() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let creationTerms = [
            ("salutaris", ["salutari"], "saving"), // v.1 - Divine title
            ("fundo", ["fundaverunt"], "establish"), // v.5 - Creation act
            ("aridus", ["aridam"], "dry"), // v.5 - Specific creation element
            ("altitudo", ["altitudines"], "height") // v.4 - Geographical feature
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: creationTerms)
    }
    
    func testShepherdImagery() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let shepherdTerms = [
            ("pascuum", ["pascuae"], "pasture"), // v.7 - Unique to this psalm
            ("ovis", ["oves"], "sheep"), // v.7
            ("populus", ["populus"], "people"), // v.7 - Covenant relationship
            ("manus", ["manu", "manus"], "hand") // v.4, v.5, v.7 - Divine care
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: shepherdTerms)
    }
    
    func testWarningAndJudgment() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let warningTerms = [
            ("obduro", ["obdurare"], "harden"), // v.8 - Key warning
            ("exacerbatio", ["exacerbatione"], "provocation"), // v.9 - Technical term
            ("tentatio", ["tentationis"], "trial"), // v.9
            ("offendo", ["offensus"], "offend") // v.10 - Divine response
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: warningTerms)
    }
    
    func testHistoricalReferences() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let historicalTerms = [
            ("quadraginta", ["Quadraginta"], "forty"), // v.10 - Specific number
            ("desertum", ["deserto"], "wilderness"), // v.9
            ("generatio", ["generationi"], "generation"), // v.10
            ("requies", ["requiem"], "rest") // v.11 - Promised land reference
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: historicalTerms)
    }
    
    func testCognitiveVerbs() {
        let analysis = latinService.analyzePsalm(identity, text: psalm94)
        
        let cognitiveTerms = [
            ("cognosco", ["cognoverunt"], "know"), // v.11
            ("erro", ["errant"], "err"), // v.10
            ("probo", ["probaverunt"], "test"), // v.9
            ("tento", ["tentaverunt"], "tempt") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: cognitiveTerms)
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
            
            // Form verification (case-insensitive)
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