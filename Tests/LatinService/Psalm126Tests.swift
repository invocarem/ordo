import XCTest
@testable import LatinService

class Psalm126Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let identity = PsalmIdentity(number: 126, category: nil)
    // MARK: - Test Data
    let psalm126 = [
        "Nisi Dominus ædificaverit domum: in vanum laboraverunt qui ædificant eam.",
        "Nisi Dominus custodierit civitatem: frustra vigilat qui custodit eam.",
        "Vanum est vobis ante lucem surgere: surgite postquam sederitis, qui manducatis panem doloris.",
        "Cum dederit dilectis suis somnum: ecce hæreditas Domini, filii; merces, fructus ventris.",
        "Sicut sagittæ in manu potentis: ita filii excussorum.",
        "Beatus vir qui implevit desiderium suum ex ipsis: non confundetur cum loquetur inimicis suis in porta."
    ]
    
    // MARK: - Test Cases
    
    // 1. Test Divine Providence (Nisi Dominus...)
    func testDivineProvidence() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let providenceTerms = [
            ("nisi", ["Nisi"], "unless"),
            ("Dominus", ["Dominus"], "Lord"),
            ("ædifico", ["ædificaverit", "ædificant"], "build"),
            ("custodio", ["custodierit", "custodit"], "guard"),
            ("vanus", ["vanum", "Vanum"], "vain")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: providenceTerms)
    }
    
    // 2. Test Labor Themes
    func testLaborThemes() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let laborTerms = [
            ("laboro", ["laboraverunt"], "labor"),
            ("vigilo", ["vigilat"], "stay awake"),
            ("surgere", ["surgere", "surgite"], "rise"),
            ("sedeo", ["sederitis"], "sit"),
            ("dolor", ["doloris"], "pain")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: laborTerms)
    }
    
    // 3. Test Family Blessings
    func testFamilyBlessings() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let familyTerms = [
            ("hæreditas", ["hæreditas"], "inheritance"),
            ("filius", ["filii", "filii"], "son"),
            ("venter", ["ventris"], "womb"),
            ("merces", ["merces"], "reward"),
            ("beatus", ["Beatus"], "blessed")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: familyTerms)
    }
    
    // 4. Test Military Metaphors
    func testMilitaryMetaphors() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let militaryTerms = [
            ("sagitta", ["sagittæ"], "arrow"),
            ("potens", ["potentis"], "mighty"),
            ("excutio", ["excussorum"], "shake off"),
            ("inimicus", ["inimicis"], "enemy"),
            ("porta", ["porta"], "gate")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: militaryTerms)
    }
    
    // 5. Test Promise of Security
    func testSecurityPromises() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let securityTerms = [
            ("dilectus", ["dilectis"], "beloved"),
            ("somnus", ["somnum"], "sleep"),
            ("fructus", ["fructus"], "fruit"),
            ("impleo", ["implevit"], "fulfill"),
            ("confundo", ["confundetur"], "be ashamed")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: securityTerms)
    }
    func testsAnalysisSummary() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'eo' forms:", analysis.dictionary["eo"]?.forms ?? [:])

             print("'torrens' forms:", analysis.dictionary["torrens"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    // MARK: - Helper (Case-Insensitive)
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Case-insensitive translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Case-insensitive form check
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