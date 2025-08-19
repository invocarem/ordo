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
        "Nisi Dominus aedificaverit domum: in vanum laboraverunt qui aedificant eam.",
        "Nisi Dominus custodierit civitatem: frustra vigilat qui custodit eam.",
        "Vanum est vobis ante lucem surgere: surgite postquam sederitis, qui manducatis panem doloris.",
        "Cum dederit dilectis suis somnum: ecce haereditas Domini, filii; merces, fructus ventris.",
        "Sicut sagittae in manu potentis: ita filii excussorum.",
        "Beatus vir qui implevit desiderium suum ex ipsis: non confundetur cum loquetur inimicis suis in porta."
    ]
    
    // MARK: - Test Cases
    
    // 1. Test Divine Providence (Nisi Dominus...)
    func testDivineProvidence() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let providenceTerms = [
            ("nisi", ["Nisi"], "unless"),
            ("Dominus", ["Dominus"], "Lord"),
            ("aedifico", ["aedificaverit", "aedificant"], "build"),
            ("custodio", ["custodierit", "custodit"], "guard"),
            ("vanus", ["vanum"], "vain")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: providenceTerms)
    }
    
    // 2. Test Verb Custodio
    func testVerbCustodio() {
        latinService.configureDebugging(target: "custodio")
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        // Verify "custodierit" and "custodit" come from "custodio"
        let custodioEntry = analysis.dictionary["custodio"]
        XCTAssertNotNil(custodioEntry, "Lemma 'custodio' should exist for 'custodierit' and 'custodit'")
        
        // Check translation
        let translation = custodioEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("guard") || translation.contains("protect") || translation.contains("watch"),
            "Expected 'custodio' to mean 'guard/protect/watch', got: \(translation)"
        )
        
        // Check if forms are recognized
        let custodieritCount = custodioEntry?.forms["custodierit"] ?? 0
        let custoditCount = custodioEntry?.forms["custodit"] ?? 0
        
        XCTAssertGreaterThan(
            custodieritCount, 0,
            "Form 'custodierit' should exist for lemma 'custodio'"
        )
        XCTAssertGreaterThan(
            custoditCount, 0,
            "Form 'custodit' should exist for lemma 'custodio'"
        )
        
        if let entity = custodioEntry?.entity {
            // Test custodierit (future perfect)
            let custodieritResult = entity.analyzeFormWithMeaning("custodierit")
            XCTAssertTrue(custodieritResult.contains("will have") || custodieritResult.contains("future perfect"),
                        "Expected 'custodierit' to be future perfect, got: \(custodieritResult)")
            
            // Test custodit (present)
            let custoditResult = entity.analyzeFormWithMeaning("custodit")
            XCTAssertTrue(custoditResult.contains("he/she/it") && custoditResult.contains("present"),
                        "Expected 'custodit' to be present tense, got: \(custoditResult)")
            
            if verbose {
                print("\nCUSTODIO Analysis:")
                print("  Translation: \(custodioEntry?.translation ?? "?")")
                print("  Form 'custodierit' analysis: \(custodieritResult)")
                print("  Form 'custodit' analysis: \(custoditResult)")
            }
        } else {
            XCTFail("Entity for 'custodio' not found")
        }
        
        latinService.configureDebugging(target: "")
    }
    
    // 3. Test Labor Themes
    func testLaborThemes() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let laborTerms = [
            ("laboro", ["laboraverunt"], "labor"),
            ("vigilo", ["vigilat"], "watch"),
            ("surgo", ["surgere", "surgite"], "rise"),
            ("sedeo", ["sederitis"], "sit"),
            ("dolor", ["doloris"], "pain")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: laborTerms)
    }
    
    // 4. Test Family Blessings
    func testFamilyBlessings() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let familyTerms = [
            ("haereditas", ["haereditas"], "inheritance"),
            ("filius", ["filii", "filii"], "son"),
            ("venter", ["ventris"], "womb"),
            ("merces", ["merces"], "reward"),
            ("beatus", ["Beatus"], "blessed")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: familyTerms)
    }
    
    // 5. Test Military Metaphors
    func testMilitaryMetaphors() {
        latinService.configureDebugging(target: "excutio")
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        latinService.configureDebugging(target: "")
        
        let militaryTerms = [
            ("sagitta", ["sagittae"], "arrow"),
            ("potens", ["potentis"], "mighty"),
            ("excutio", ["excussorum"], "expel"),
            ("inimicus", ["inimicis"], "enemy"),
            ("porta", ["porta"], "gate")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: militaryTerms)
    }
    
    // 6. Test Promise of Security
    func testSecurityPromises() {
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let securityTerms = [
            ("dilectus", ["dilectis"], "beloved"),
            ("somnus", ["somnum"], "sleep"),
            ("fructus", ["fructus"], "fruit"),
            ("impleo", ["implevit"], "fulfill"),
            ("confundo", ["confundetur"], "confuse")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: securityTerms)
    }
    
    // 7. Test Verb Aedifico
    func testVerbAedifico() {
        latinService.configureDebugging(target: "aedifico")
        let analysis = latinService.analyzePsalm(identity, text: psalm126)
        
        let aedificoEntry = analysis.dictionary["aedifico"]
        XCTAssertNotNil(aedificoEntry, "Lemma 'aedifico' should exist for 'aedificaverit' and 'aedificant'")
        
        // Check translation
        let translation = aedificoEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("build") || translation.contains("construct"),
            "Expected 'aedifico' to mean 'build/construct', got: \(translation)"
        )
        
        // Check forms
        let aedificaveritCount = aedificoEntry?.forms["aedificaverit"] ?? 0
        let aedificantCount = aedificoEntry?.forms["aedificant"] ?? 0
        
        XCTAssertGreaterThan(aedificaveritCount, 0, "Form 'aedificaverit' should exist")
        XCTAssertGreaterThan(aedificantCount, 0, "Form 'aedificant' should exist")
        
        if let entity = aedificoEntry?.entity {
            let aedificaveritResult = entity.analyzeFormWithMeaning("aedificaverit")
            XCTAssertTrue(aedificaveritResult.contains("will have built") || aedificaveritResult.contains("future perfect"),
                        "Expected 'aedificaverit' to be future perfect, got: \(aedificaveritResult)")
            
            let aedificantResult = entity.analyzeFormWithMeaning("aedificant")
            XCTAssertTrue(aedificantResult.contains("they build") || aedificantResult.contains("present"),
                        "Expected 'aedificant' to be present tense, got: \(aedificantResult)")
            
            if verbose {
                print("\nAEDIFICO Analysis:")
                print("  Translation: \(aedificoEntry?.translation ?? "?")")
                print("  Form 'aedificaverit' analysis: \(aedificaveritResult)")
                print("  Form 'aedificant' analysis: \(aedificantResult)")
            }
        } else {
            XCTFail("Entity for 'aedifico' not found")
        }
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
            
            // Verify form analysis
            if let entity = entry.entity {
                for form in forms {
                    let result = entity.analyzeFormWithMeaning(form)
                    XCTAssertTrue(
                        result.lowercased().contains(translation.lowercased()) ||
                        (lemma == "surgo" && form == "surgite" && result.lowercased().contains("imperative")),
                        """
                        For form '\(form)' of lemma '\(lemma)':
                        Expected analysis to contain '\(translation)' or appropriate tense,
                        but got: \(result)
                        """
                    )
                    
                    if verbose {
                        print("  Analysis of '\(form)': \(result)")
                    }
                }
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