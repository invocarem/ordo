import XCTest
@testable import LatinService

class Psalm22Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let id  = PsalmIdentity(number: 22, category: "")
    
    // MARK: - Test Data
    let psalm22 = [
        "Dominus regit me, et nihil mihi deerit:",
        "in loco pascuae ibi me collocavit; super aquam refectionis educavit me.",
        "Animam meam convertit; deduxit me super semitas justitiae propter nomen suum.",
        "Nam etsi ambulavero in medio umbrae mortis, non timebo mala, quoniam tu mecum es; virga tua et baculus tuus, ipsa me consolata sunt.",
        "Parasti in conspectu meo mensam adversus eos qui tribulant me; impinguasti in oleo caput meum, et calix meus inebrians quam praeclarus est!",
        "Et misericordia tua subsequetur me omnibus diebus vitae meae; et ut inhabitem in domo Domini in longitudinem dierum."
    ]
    func testDeeritInPsalm22() {
    let analysis = latinService.analyzePsalm(id, text: psalm22)
    
        // Verify lemma and forms
        let verbTerms = [
            (
                lemma: "desum",
                forms: ["deerit"],  // Future tense form in Psalm 22:1
                translation: "to be lacking"
            )
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: verbTerms)
        
        // Optional: Test the full phrase context
        let keyPhrase = "nihil mihi deerit"
        XCTAssertTrue(
            psalm22.contains { $0.contains(keyPhrase) },
            "Missing key phrase: '\(keyPhrase)'"
        )
    }
    // MARK: - Thematic Test Cases
    
    func testPastoralImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm22)
        
        let pastoralTerms = [
            ("regere", ["regit"], "shepherd"),
            ("pascuum", ["pascuae"], "pasture"),
            ("aqua", ["aquam"], "water"),
            ("refectio", ["refectionis"], "refreshment"),
            ("virga", ["virga"], "rod"),
            ("baculus", ["baculus"], "staff")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: pastoralTerms)
    }
    
    func testProvisionMetaphors() {
        let analysis = latinService.analyzePsalm(id, text: psalm22)
        
        let provisionTerms = [
            ("collocare", ["collocavit"], "settle"),
            ("educare", ["educavit"], "lead forth"),
            ("mensa", ["mensam"], "table"),
            ("oleum", ["oleo"], "oil"),
            ("calix", ["calix"], "cup"),
            ("impinguare", ["impinguasti"], "anoint")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: provisionTerms)
    }
    
    func testJourneyVocabulary() {
        let analysis = latinService.analyzePsalm(id, text: psalm22)
        
        let journeyTerms = [
            ("semita", ["semitas"], "path"),
            ("ambulare", ["ambulavero"], "walk"),
            ("deduco", ["deduxit"], "lead"),
            ("umbra", ["umbrae"], "shadow"),
            ("mors", ["mortis"], "death")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: journeyTerms)
    }
    
    func testDivineProtectionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm22)
        
        let protectionTerms = [
            ("consolari", ["consolata"], "to comfort"),
            ("misericordia", ["misericordia"], "mercy"),
            ("subsequi", ["subsequetur"], "follow after"),
            ("inhabitare", ["inhabitem"], "dwell"),
            ("domus", ["domo"], "house")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testContrastThemes() {
        /*
        // Testing contrasting concepts that appear together
        let contrastPairs = [
            ("umbra mortis", "non timebo"),
            ("tribulant me", "mensam adversus eos"),
            ("medium umbrae", "tu mecum es"),
            ("diebus vitae", "longitudinem dierum")
        ]
        
        for (term1, term2) in contrastPairs {
            let text = psalm22
            let foundTerm1 = text.contains(term1)
            let foundTerm2 = text.contains(term2)
            
            XCTAssertTrue(foundTerm1 && foundTerm2, 
                        "Missing contrasting pair: '\(term1)' should contrast with '\(term2)'")
        }*/
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


