import XCTest
@testable import LatinService

class Psalm118CaphTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "caph")
    // MARK: - Test Data (Psalm 118:81-88 "Caph" category)
    let psalm118Caph = [
        "Defecit in salutare tuum anima mea, et in verbum tuum supersperavi.",
        "Defecerunt oculi mei in eloquium tuum, dicentes: Quando consolaberis me?",
        "Quia factus sum sicut uter in pruina, justificationes tuas non sum oblitus.",
        "Quot sunt dies servi tui? quando facies de persequentibus me judicium?",
        "Narraverunt mihi iniqui fabulationes, sed non ut lex tua.",
        "Omnia mandata tua veritas; inique persecuti sunt me, adjuva me.",
        "Paulo minus consummaverunt me in terra, ego autem non dereliqui mandata tua.",
        "Secundum misericordiam tuam vivifica me, et custodiam testimonia oris tui."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118CaphLines1and2() {
        let line1 = psalm118Caph[0] // "Defecit in salutare tuum anima mea, et in verbum tuum supersperavi."
        let line2 = psalm118Caph[1] // "Defecerunt oculi mei in eloquium tuum, dicentes: Quando consolaberis me?"
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("deficio", ["defecit", "defecerunt"], "fail"),
            ("salus", ["salutare"], "salvation"),
            ("anima", ["anima"], "soul"),
            ("verbum", ["verbum", "eloquium"], "word"),
            ("superspero", ["supersperavi"], "hope exceedingly"),
            ("oculus", ["oculi"], "eyes"),
            ("consolor", ["consolaberis"], "comfort"),
            ("dico", ["dicentes"], "say")
        ]
        
        if verbose {
            print("\nPSALM 118 CAPH:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Longing for Salvation: defecit (longs) + salutare (salvation)")
            print("2. Word of God: verbum (word) + eloquium (speech)")
            print("3. Desperate Hope: supersperavi (hoped exceedingly) + consolaberis (comfort)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["deficio"]?.forms["defecit"], 1, "Should find 'long for' verb")
        XCTAssertNotNil(analysis.dictionary["superspero"], "Should find 'exceedingly hope' verb")
        XCTAssertNotNil(analysis.dictionary["consolor"], "Should find 'comfort' verb")
    }
    
    func testPsalm118CaphLines3and4() {
        let line3 = psalm118Caph[2] // "Quia factus sum sicut uter in pruina, justificationes tuas non sum oblitus."
        let line4 = psalm118Caph[3] // "Quot sunt dies servi tui? quando facies de persequentibus me judicium?"
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("fio", ["factus"], "become"),
            ("uter", ["uter"], "wineskin"),
            ("pruina", ["pruina"], "frost"),
            ("justificatio", ["justificationes"], "ordinances"),
            ("obliviscor", ["oblitus"], "forget"),
            ("servus", ["servi"], "servant"),
            ("persequor", ["persequentibus"], "persecute"),
            ("judicium", ["judicium"], "judgment")
        ]
        
        if verbose {
            print("\nPSALM 118 CAPH:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Suffering Imagery: uter (wineskin) + pruina (frost)")
            print("2. Faithfulness: non oblitus (not forgotten)")
            print("3. Cry for Justice: judicium (judgment) + persequentibus (persecutors)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["justificatio"]?.forms["justificationes"], 1, "Should find 'ordinances' reference")
        XCTAssertNotNil(analysis.dictionary["obliviscor"], "Should find 'forget' verb")
        XCTAssertNotNil(analysis.dictionary["judicium"], "Should find 'judgment' noun")
    }
    
    func testPsalm118CaphLines5and6() {
        let line5 = psalm118Caph[4] // "Narraverunt mihi iniqui fabulationes, sed non ut lex tua."
        let line6 = psalm118Caph[5] // "Omnia mandata tua veritas; inique persecuti sunt me, adjuva me."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("narro", ["narraverunt"], "tell"),
            ("iniquus", ["iniqui", "inique"], "wicked"),
            ("fabula", ["fabulationes"], "false tales"),
            ("lex", ["lex"], "law"),
            ("mandatum", ["mandata"], "commandments"),
            ("veritas", ["veritas"], "truth"),
            ("persequor", ["persecuti"], "persecute"),
            ("adjuvio", ["adjuva"], "help")
        ]
        
        if verbose {
            print("\nPSALM 118 CAPH:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. False vs True: fabulationes (false tales) vs veritas (truth)")
            print("2. Persecution: inique (wicked) + persecuti (persecuted)")
            print("3. Divine Help: adjuva (help) me")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["veritas"]?.forms["veritas"], 1, "Should find 'truth' reference")
        XCTAssertNotNil(analysis.dictionary["fabula"], "Should find 'false tales' reference")
        XCTAssertNotNil(analysis.dictionary["adjuvio"], "Should find 'help' verb")
    }
    
    func testPsalm118CaphLines7and8() {
        let line7 = psalm118Caph[6] // "Paulo minus consummaverunt me in terra, ego autem non dereliqui mandata tua."
        let line8 = psalm118Caph[7] // "Secundum misericordiam tuam vivifica me, et custodiam testimonia oris tui."
        let combinedText = line7 + " " + line8
        latinService.configureDebugging(target: "consummo")
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        latinService.configureDebugging(target: "")
        
        let testLemmas = [
            ("consummo", ["consummaverunt"], "consume"),
            ("terra", ["terra"], "earth"),
            ("derelinquo", ["dereliqui"], "forsake"),
            ("mandatum", ["mandata"], "commandments"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("vivifico", ["vivifica"], "give life"),
            ("custodio", ["custodiam"], "keep"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("os", ["oris"], "mouth")
        ]
        
        if verbose {
            print("\nPSALM 118 CAPH:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Near Destruction: consummaverunt (almost consumed)")
            print("2. Faithfulness: non dereliqui (did not forsake)")
            print("3. Life and Mercy: vivifica (give life) + misericordiam (mercy)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["consummo"]?.forms["consummaverunt"], 1, "Should find 'consume' verb")
        XCTAssertNotNil(analysis.dictionary["vivifico"], "Should find 'give life' verb")
        XCTAssertNotNil(analysis.dictionary["misericordia"], "Should find 'mercy' reference")
    }
    
    // MARK: - Thematic Tests
    func testLongingTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Caph)
        
        let longingTerms = [
            ("deficio", ["defecit", "defecerunt"], "long for"), // v.1, v.2
            ("superspero", ["supersperavi"], "hope exceedingly"), // v.1
            ("consolor", ["consolaberis"], "comfort") // v.2
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: longingTerms)
    }
    
    func testPersecutionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Caph)
        
        let persecutionTerms = [
            ("persequor", ["persequentibus", "persecuti"], "persecute"), // v.4, v.6
            ("iniquus", ["iniqui", "inique"], "wicked"), // v.5, v.6
            ("consummo", ["consummaverunt"], "consume") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: persecutionTerms)
    }
    
    func testFaithfulnessTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Caph)
        
        let faithfulnessTerms = [
            ("oblitus", ["oblitus"], "forget"), // v.3 (negated)
            ("derelinquo", ["dereliqui"], "forsake"), // v.7 (negated)
            ("custodio", ["custodiam"], "keep") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: faithfulnessTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Caph)
        
        let divineTerms = [
            ("misericordia", ["misericordiam"], "mercy"), // v.8
            ("veritas", ["veritas"], "truth"), // v.6
            ("judicium", ["judicium"], "judgment") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
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
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}