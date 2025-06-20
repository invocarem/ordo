import XCTest
@testable import LatinService

class Psalm121Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 121, category: nil)
    
    // MARK: - Test Data
    let psalm121 = [
        "Laetatus sum in his quae dicta sunt mihi: In domum Domini ibimus.",
        "Stantes erant pedes nostri in atriis tuis, Jerusalem.",
        "Jerusalem, quae aedificatur ut civitas, cujus participatio ejus in idipsum.",
        "Illuc enim ascenderunt tribus, tribus Domini, testimonium Israel, ad confitendum nomini Domini.",
        "Quia illic sederunt sedes in judicio, sedes super domum David.",
        "Rogate quae ad pacem sunt Jerusalem, et abundantia diligentibus te.",
        "Fiat pax in virtute tua, et abundantia in turribus tuis.",
        "Propter fratres meos et proximos meos, loquebar pacem de te.",
        "Propter domum Domini Dei nostri, quaesivi bona tibi."
    ]
    
    // MARK: - Thematic Test Cases
    
    // 1. Pilgrimage Theme
    func testPilgrimageTheme() {
        latinService.configureDebugging(target: "laetor")
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let pilgrimageTerms = [
            ("laetor", ["Laetatus"], "rejoice"), // v.1
            ("domus", ["domum"], "house"), // v.1
            ("eo", ["ibimus"], "go"), // v.1
            ("sto", ["stantes"], "stand"), // v.2
            ("atrium", ["atriis"], "sacred space"), // v.2
            ("ascendo", ["ascenderunt"], "ascend") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: pilgrimageTerms)
        
        latinService.configureDebugging(target: "")
        
    }
    
    // 2. Jerusalem as Sacred Center
    func testJerusalemTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let jerusalemTerms = [
            ("civitas", ["civitas"], "city"), // v.3
            ("aedifico", ["aedificatur"], "build"), // v.3
            ("turris", ["turribus"], "tower"), // v.7
            ("sedes", ["sedes"], "throne"), // v.5
            ("judicium", ["judicio"], "justice") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: jerusalemTerms)
        
       
    }

    func testVerbAedifico() {
        latinService.configureDebugging(target: "aedifico")
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let aedificoEntry = analysis.dictionary["aedifico"]
        XCTAssertNotNil(aedificoEntry, "Lemma 'aedifico' should exist for 'aedificatur'")
        
        // Check translation
        let translation = aedificoEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("build") || translation.contains("construct"),
            "Expected 'aedifico' to mean 'build/construct', got: \(translation)"
        )
        
        // Check if "aedificatur" is a recognized form
        let aedificaturFormCount = aedificoEntry?.forms["aedificatur"] ?? 0
        XCTAssertGreaterThan(
            aedificaturFormCount, 0,
            "Form 'aedificatur' should exist for lemma 'aedifico'"
        )
        
        if let entity = aedificoEntry?.entity {
            let result = entity.analyzeFormWithMeaning("aedificatur")
            XCTAssertTrue(result.contains("present") || result.contains("passive"),
                        "Expected 'aedificatur' to be present passive, got: \(result)")
            
            if verbose {
                print("Analysis of 'aedificatur': \(result)")
            }
        } else {
            XCTFail("Entity for 'aedifico' not found")
        }
    }

    func testVerbDico() {
        latinService.configureDebugging(target: "dico")
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        latinService.configureDebugging(target: "dico")
        
        // Verify "dicta" comes from "dico"
        let dictaEntry = analysis.dictionary["dico"]
        XCTAssertNotNil(dictaEntry, "Lemma 'dico' should exist for 'dicta'")
        
        // Check translation
        let translation = dictaEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("say") || translation.contains("speak"),
            "Expected 'dico' to mean 'say' or 'speak', got: \(translation)"
        )
        
        // Check if "dicta" is a recognized form
        let dictaFormCount = dictaEntry?.forms["dicta"] ?? 0
        XCTAssertGreaterThan(
            dictaFormCount, 0,
            "Form 'dicta' should exist for lemma 'dico'"
        )
        
        if let entity = dictaEntry?.entity {
           let result = entity.analyzeFormWithMeaning("dicta")
                XCTAssertTrue(result.contains("have been"),
                    "Expected translation like 'have been', got: \(result)")
    
                if verbose {
                    print("Translation of 'dicta': \(result)")
                }
            } else {
            XCTFail("Entity for 'dico' not found")
        }
        
        if verbose {
            print("\nDICO Analysis:")
            print("  Translation: \(dictaEntry?.translation ?? "?")")
            print("  Form 'dicta' found: \(dictaFormCount > 0 ? "✅" : "❌")")
            print("  All forms: \(dictaEntry?.forms.keys.joined(separator: ", ") ?? "none")")
        }
    }

    func testVerbRogo() {
    latinService.configureDebugging(target: "rogo")
    let analysis = latinService.analyzePsalm(id, text: psalm121)
    
    // Verify "rogate" comes from "rogo"
    let rogoEntry = analysis.dictionary["rogo"]
    XCTAssertNotNil(rogoEntry, "Lemma 'rogo' should exist for 'rogate'")
    
    // Check translation
    let translation = rogoEntry?.translation?.lowercased() ?? ""
    XCTAssertTrue(
        translation.contains("ask") || translation.contains("pray") || translation.contains("request"),
        "Expected 'rogo' to mean 'ask/pray/request', got: \(translation)"
    )
    
    // Check if "rogate" is a recognized form
    let rogateFormCount = rogoEntry?.forms["rogate"] ?? 0
    XCTAssertGreaterThan(
        rogateFormCount, 0,
        "Form 'rogate' should exist for lemma 'rogo'"
    )
    
    if let entity = rogoEntry?.entity {
        let result = entity.analyzeFormWithMeaning("rogate")
        XCTAssertTrue(result.contains("imperative") || result.contains("command"),
                     "Expected 'rogate' to be imperative, got: \(result)")
        
        if verbose {
            print("Analysis of 'rogate': \(result)")
        }
    } else {
        XCTFail("Entity for 'rogo' not found")
    }
    
    if verbose {
        print("\nROGO Analysis:")
        print("  Translation: \(rogoEntry?.translation ?? "?")")
        print("  Form 'rogate' found: \(rogateFormCount > 0 ? "✅" : "❌")")
    }

}

    func testVerbAscendo() {
        latinService.configureDebugging(target: "ascendo")
        let analysis = latinService.analyzePsalm(id, text: psalm121)

        // 1. Lookup entry for "ascendo"
        let ascendoEntry = analysis.dictionary["ascendo"]
        XCTAssertNotNil(ascendoEntry, "Lemma 'ascendo' should exist for 'ascenderunt'")

        // 2. Translation sanity check
        let translation = ascendoEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("ascend") || translation.contains("go up") || translation.contains("climb"),
            "Expected 'ascendo' to mean 'ascend', got: \(translation)"
        )

        // 3. Confirm the form is recorded
        let formCount = ascendoEntry?.forms["ascenderunt"] ?? 0
        XCTAssertGreaterThan(
            formCount, 0,
            "Form 'ascenderunt' should exist for lemma 'ascendo'"
        )

        // 4. Analyze the form
        if let entity = ascendoEntry?.entity {
            let result = entity.analyzeFormWithMeaning("ascenderunt")
            XCTAssertTrue(result.contains("they") && result.contains("have") && result.contains("ascend"),
                        "Expected 'ascenderunt' to mean something like 'they have ascended', got: \(result)")

            if verbose {
                print("\nASCENDO Analysis:")
                print("  Translation: \(ascendoEntry?.translation ?? "?")")
                print("  Form 'ascenderunt' analysis: \(result)")
            }
        } else {
            XCTFail("Entity for 'ascendo' not found")
        }
    }


    // 3. Unity and Community
    func testUnityTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let unityTerms = [
            ("participatio", ["participatio"], "unity"), // v.3
            ("tribus", ["tribus"], "tribe"), // v.4
            ("confiteor", ["confitendum"], "confess"), // v.4
            ("frater", ["fratres"], "brother"), // v.8
            ("proximus", ["proximos"], "neighbor") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: unityTerms)
    }
    
    // 4. Divine Protection
    func testProtectionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        
        let protectionTerms = [
            ("turris", ["turribus"], "tower"), // v.7
            ("virtus", ["virtute"], "strength"), // v.7
            ("bonus", ["bona"], "good") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    // 5. Peace and Abundance
    func testPeaceTheme() {
        latinService.configureDebugging(target: "rogo")
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        latinService.configureDebugging(target: "")
        
        let peaceTerms = [
            ("pax", ["pacem", "pax"], "peace"), // v.6,7,8
            ("abundantia", ["abundantia"], "plenty"), // v.6,7
            ("rogo", ["rogate"], "ask"), // v.6
            ("diligo", ["diligentibus"], "love") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: peaceTerms)
        
        
    }
    
    // 6. Worship and Praise
    func testWorshipTheme() {
        latinService.configureDebugging(target: "laetor")
        let analysis = latinService.analyzePsalm(id, text: psalm121)
        latinService.configureDebugging(target: "")
        
        let worshipTerms = [
            ("nomen", ["nomini"], "name"), // v.4
            ("testimonium", ["testimonium"], "testimony"), // v.4
            ("laetor", ["Laetatus"], "rejoice"), // v.1
            ("quaero", ["quaesivi"], "seek") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: worshipTerms)
    }
    
    // MARK: - Helper Methods
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
        
        // NEW: Verify each form's analysis matches the expected translation
        for form in forms {
            if let entity = entry.entity {
                let analysisResult = entity.analyzeFormWithMeaning(form)
                
                // Check if the analysis contains either:
                // 1. The exact translation we expect (e.g., "go")
                // 2. Or a grammatical form that implies the meaning (e.g., "future" for "ibimus")
                XCTAssertTrue(
                    analysisResult.lowercased().contains(translation.lowercased()) ||
                    (lemma == "eo" && form == "ibimus" && analysisResult.lowercased().contains("future")),
                    """
                    For form '\(form)' of lemma '\(lemma)':
                    Expected analysis to contain '\(translation)' or appropriate tense,
                    but got: \(analysisResult)
                    """
                )
                
                if verbose {
                    print("  Analysis of '\(form)': \(analysisResult)")
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
    private func xverifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, 
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