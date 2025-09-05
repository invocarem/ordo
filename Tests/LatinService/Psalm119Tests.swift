import XCTest
@testable import LatinService

class Psalm119Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 119, category: nil)
    
    // MARK: - Test Data
    let psalm119 = 
         [
                "Ad Dominum cum tribularer clamavi, et exaudivit me.",
                "Domine, libera anima mea a labiis iniquis, et a lingua dolosa.",
                "Quid detur tibi, aut quid apponatur tibi ad linguam dolosam?",
                "Sagittae potentis acutae, cum carbonibus desolatoriis.",
                "Heu mihi, quia incolatus meus prolongatus est: habitavi cum habitantibus Cedar: multum incola fuit anima mea.",
                "Cum his, qui oderunt pacem, ego pacem quaerebam: et cum loquerer illis, impugnabant me gratis."
            ]

    
    // MARK: - Test Cases
    
    func testPersecutionVocabulary() {
        latinService.configureDebugging(target: "inpugno")
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let persecutionTerms = [
            ("tribulor", ["tribularer"], "afflict"), // v.1
            ("iniquus", ["iniquis"], "unjust"), // v.2
            ("impugno", ["impugnabant"], "attack"), // v.7
            ("desolatorius", ["desolatoriis"], "destructive") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: persecutionTerms)
        latinService.configureDebugging(target: "")
    }
    
    func testVerbApponatur() {
        latinService.configureDebugging(target: "appono")
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let apponoEntry = analysis.dictionary["appono"]
        XCTAssertNotNil(apponoEntry, "Lemma 'appono' should exist for 'apponatur'")
        
        if let entity = apponoEntry?.entity {
            let result = entity.analyzeFormWithMeaning("apponatur")
            XCTAssertTrue(result.contains("present") && result.contains("passive") && result.contains("subjunctive"),
                        "Expected present passive subjunctive, got: \(result)")
        }
    }
    
    func testLinguisticImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let speechTerms = [
            ("labium", ["labiis"], "lip"), // v.2
            ("lingua", ["lingua", "linguam"], "tongue"), // v.2, v.3
            ("loquor", ["loquerer"], "speak") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: speechTerms)
    }
    func testVerbLoquerer() {
       latinService.configureDebugging(target: "loquor")
        let analysis = latinService.analyzePsalm(id, text: psalm119)
    
        // Verify "loquerer" comes from "loquor"
        let loquorEntry = analysis.dictionary["loquor"]
        XCTAssertNotNil(loquorEntry, "Lemma 'loquor' should exist for 'loquerer'")
        
        // Check translation
        let translation = loquorEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("speak") || translation.contains("talk"),
            "Expected 'loquor' to mean 'speak' or 'talk', got: \(translation)"
        )
        
        // Check if "loquerer" is a recognized form
        let loquererFormCount = loquorEntry?.forms["loquerer"] ?? 0
        XCTAssertGreaterThan(
            loquererFormCount, 0,
            "Form 'loquerer' should exist for lemma 'loquor'"
        )
        
        if let entity = loquorEntry?.entity {
            let result = entity.analyzeFormWithMeaning("loquerer")
            
            // Verify it's imperfect active subjunctive (1st singular)
            XCTAssertTrue(
                result.lowercased().contains("i would speak") || 
                result.lowercased().contains("imperfect") ||
                result.lowercased().contains("subjunctive"),
                "Expected 'I would speak' (imperfect subjunctive), got: \(result)"
            )
            
            if verbose {
                print("\nLOQUOR Analysis:")
                print("  Translation: \(loquorEntry?.translation ?? "?")")
                print("  Form 'loquerer' analysis: \(result)")
            }
        } else {
            XCTFail("Entity for 'loquor' not found")
        }
        
        latinService.configureDebugging(target: "")
    }
    
    func testGeographicalReferences() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let places = [
            ("cedar", ["Cedar"], "Kedar"), // v.5
            ("incolatus", ["incolatus"], "sojourn") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: places)
    }
    
    func testMilitaryMetaphors() {
        let analysis = latinService.analyzePsalm(id, text: psalm119)
        
        let weaponTerms = [
            ("sagitta", ["Sagittae"], "arrow"), // v.4
            ("carbo", ["carbonibus"], "coal") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: weaponTerms)
    }

    func testVerbImpugnabant() {
    latinService.configureDebugging(target: "impugno")
    let analysis = latinService.analyzePsalm(id, text: psalm119)
    
    // Verify "impugnabant" comes from "impugno"
    let impugnoEntry = analysis.dictionary["impugno"]
    XCTAssertNotNil(impugnoEntry, "Lemma 'impugno' should exist for 'impugnabant'")
    
    // Check translation
    let translation = impugnoEntry?.translation?.lowercased() ?? ""
    XCTAssertTrue(
        translation.contains("attack") || translation.contains("assail"),
        "Expected 'impugno' to mean 'attack' or 'assail', got: \(translation)"
    )
    
    // Check if "impugnabant" is a recognized form
    let impugnabantFormCount = impugnoEntry?.forms["impugnabant"] ?? 0
    XCTAssertGreaterThan(
        impugnabantFormCount, 0,
        "Form 'impugnabant' should exist for lemma 'impugno'"
    )
    
    if let entity = impugnoEntry?.entity {
        let result = entity.analyzeFormWithMeaning("impugnabant")
        
        // Verify it's imperfect active indicative (3rd plural)
        XCTAssertTrue(
            result.lowercased().contains("they were attacking"),
               "Expected 'they were attacking' (imperfect active), got: \(result)"
        )
        
        if verbose {
            print("\nIMPUGNO Analysis:")
            print("  Translation: \(impugnoEntry?.translation ?? "?")")
            print("  Form 'impugnabant' analysis: \(result)")
        }
    } else {
        XCTFail("Entity for 'impugno' not found")
    }
}
    
    // MARK: - Helper
      private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, 
                                     confirmedWords: [(lemma: String, 
                                                     forms: [String], 
                                                     translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain through translation
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            // NEW: Verify each form's grammatical analysis
            for form in forms {
                if let entity = entry.entity {
                    let result = entity.analyzeFormWithMeaning(form)
                    
                    // Check if analysis contains either:
                    // 1. The exact translation we expect
                    // 2. Or appropriate grammatical markers
                    XCTAssertTrue(
                        result.lowercased().contains(translation.lowercased()) ||
                        result.lowercased().contains("verb") ||
                        result.lowercased().contains("participle") ||
                        result.lowercased().contains("noun"),
                        """
                        For form '\(form)' of lemma '\(lemma)':
                        Expected analysis to contain '\(translation)' or grammatical info,
                        but got: \(result)
                        """
                    )
                    
                    if verbose {
                        print("  Analysis of '\(form)': \(result)")
                    }
                } else {
                    XCTFail("Entity for lemma '\(lemma)' not found")
                }
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                print("  Forms found: \(entry.forms.keys.filter { forms.map { $0.lowercased() }.contains($0) }.count)/\(forms.count)")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
    
}