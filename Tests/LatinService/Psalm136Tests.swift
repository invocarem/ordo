import XCTest
@testable import LatinService

class Psalm136Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 136, category: nil)
    
    // MARK: - Test Data
    let psalm136 = [
        "Super flumina Babylonis, illic sedimus et flevimus: cum recordaremur Sion.",
        "In salicibus in medio ejus, suspendimus organa nostra.",
        "Quia illic interrogaverunt nos, qui captivos duxerunt nos, verba cantionum.",
        "Et qui abduxerunt nos: Hymnum cantate nobis de canticis Sion.",
        "Quomodo cantabimus canticum Domini in terra aliena?",
        "Si oblitus fuero tui, Jerusalem, oblivioni detur dextera mea.",
        "Adhaereat lingua mea faucibus meis, si non meminero tui: si non proposuero Jerusalem, in principio laetitiae meae.",
        "Memor esto, Domine, filiorum Edom, in die Jerusalem: qui dicunt: Exinanite, exinanite usque ad fundamentum in ea.",
        "Filia Babylonis misera: beatus qui retribuet tibi retributionem tuam, quam retribuisti nobis.",
        "Beatus qui tenebit, et allidet parvulos tuos ad petram."
    ]
    
    // MARK: - Theme Tests
    
    func testExileToParalysis_Lines1and2() {
        let line1 = psalm136[0]
        let line2 = psalm136[1]
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("flumen", ["flumina"], "rivers"),
            ("babylon", ["babylonis"], "babylon"),
            ("sedeo", ["sedimus"], "sit"),
            ("fleo", ["flevimus"], "weep"),
            ("sion", ["sion"], "Zion"),
            ("salix", ["salicibus"], "willows"),
            ("organum", ["organa"], "harps")
        ]
        
        verifyTheme(analysis: analysis, 
                    themeName: "Exile → Paralysis",
                    description: "From displacement in Babylon to emotional and spiritual suspension",
                    testLemmas: testLemmas,
                    lines: [line1, line2])
    }
    
    func testMockeryToDefiance_Lines3and4() {
        let line3 = psalm136[2]
        let line4 = psalm136[3]
        let combinedText = line3 + " " + line4
        latinService.configureDebugging(target: "terra")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("captivus", ["captivos"], "captives"),
            ("interrogo", ["interrogaverunt"], "ask"),
            ("canticum", ["cantionum", "canticis"], "song"),
            ("hymnus", ["hymnum"], "hymn"),
            ("terra", ["terra"], "land"),
            ("alienus", ["aliena"], "foreign")
        ]
        
        verifyTheme(analysis: analysis,
                   themeName: "Mockery → Defiance",
                   description: "From captors' demands to theological resistance",
                   testLemmas: testLemmas,
                   lines: [line3, line4])
    }
    
    func testForgettingToOath_Lines5and6() {
        let line5 = psalm136[4]
        let line6 = psalm136[5]
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(text: combinedText)
        let testLemmas = [
            ("obliviscor", ["oblitus"], "forget"),
            ("jerusalem", ["jerusalem"], "Jerusalem"),
            ("dextera", ["dextera"], "right hand"),
        ]
       if verbose {
    print("\nFULL ANALYSIS DICTIONARY:")
    analysis.dictionary.forEach { lemma, info in
        print("- \(lemma): \(info.forms.keys.joined(separator: ", "))")
    }
} 
        verifyTheme(analysis: analysis,
                   themeName: "Forgetting → Oath",
                   description: "From risk of amnesia to bodily oath of remembrance",
                   testLemmas: testLemmas,
                   lines: [line5, line6])
    }
    
    func testDestructionToImprecation_Lines7and8() {
        let line7 = psalm136[6]
        let line8 = psalm136[7]
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        let testLemmas = [
            ("edom", ["edom"], "Edom"),
            ("exinanio", ["exinanite"], "demolish"),
            ("fundamentum", ["fundamentum"], "foundation"),
            ("memor", ["memor"], "remember")
        ]
        
        verifyTheme(analysis: analysis,
                   themeName: "Destruction → Imprecation",
                   description: "From Edom's violence to prophetic curse",
                   testLemmas: testLemmas,
                   lines: [line7, line8])
    }
    
    func testInfantsToDivineJustice_Lines9and10() {
        let line9 = psalm136[8]
        let line10 = psalm136[9]
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        let testLemmas = [
            ("babylon", ["babylonis"], "babylon"),
            ("miser", ["misera"], "wretched"),
            ("beatus", ["beatus"], "blessed"),
            ("retributio", ["retributionem"], "repayment"),
            ("allido", ["allidet"], "dash against"),
            ("petra", ["petram"], "rock")
        ]
        
        verifyTheme(analysis: analysis,
                   themeName: "Infants → Divine Justice",
                   description: "From helpless victims to divine retribution",
                   testLemmas: testLemmas,
                   lines: [line9, line10])
    }
    
    // MARK: - Helper Methods
    
    private func verifyTheme(analysis: PsalmAnalysisResult, 
                           themeName: String,
                           description: String,
                           testLemmas: [(lemma: String, forms: [String], translation: String)],
                           lines: [String]) {
        if verbose {
            print("\nTHEME: \(themeName.uppercased())")
            print(description)
            print("\nVERSES:")
            lines.enumerated().forEach { print("\($0.offset + 1): \"\($0.element)\"") }
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. \(themeName.components(separatedBy: " → ").first!): \(lines[0])")
            print("2. \(themeName.components(separatedBy: " → ").last!): \(lines[1])")
        }
        
        // Verify all expected lemmas are present
        for (lemma, forms, translation) in testLemmas {
            XCTAssertNotNil(analysis.dictionary[lemma], "Missing lemma: \(lemma) for theme \(themeName)")
            
            // Verify at least one form exists for each lemma
            let hasForm = forms.contains { analysis.dictionary[lemma]?.forms[$0.lowercased()] != nil }
            XCTAssertTrue(hasForm, "Lemma \(lemma) should have at least one of these forms: \(forms.joined(separator: ", "))")
        }
        
        // Verify theme-specific assertions
        switch themeName {
        case "Exile → Paralysis":
            XCTAssertNotNil(analysis.dictionary["organum"], "Should find 'organum' (harps) for exile theme")
            XCTAssertGreaterThan(analysis.dictionary["sedeo"]?.forms["sedimus"] ?? 0, 0, "Should find 'sedimus' (we sat)")
            
        case "Mockery → Defiance":
            XCTAssertGreaterThan(analysis.dictionary["canticum"]?.forms.values.reduce(0, +) ?? 0, 1, "Should find multiple song references")
            
        case "Forgetting → Oath":
            XCTAssertGreaterThan(analysis.dictionary["obliviscor"]?.forms["oblitus"] ?? 0, 0, "Should find forgetting verb")
            XCTAssertGreaterThan(analysis.dictionary["memini"]?.forms["meminero"] ?? 0, 0, "Should find remembering verb")
            
        case "Destruction → Imprecation":
            XCTAssertGreaterThan(analysis.dictionary["exinanio"]?.forms["exinanite"] ?? 0, 0, "Should find demolition verb")
            
        case "Infants → Divine Justice":
            XCTAssertGreaterThan(analysis.dictionary["allido"]?.forms["allidet"] ?? 0, 0, "Should find violent action verb")
            XCTAssertGreaterThan(analysis.dictionary["beatus"]?.forms["beatus"] ?? 0, 0, "Should find blessed term")
            
        default:
            break
        }
    }
    
    // MARK: - Original Tests (kept for backward compatibility)
    
    func testExileVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        let exileTerms = [
            ("flumen", ["flumina"], "rivers"),
            ("salix", ["salicibus"], "willows"),
            ("captivus", ["captivos"], "captives"),
            ("organum", ["organa"], "harps")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: exileTerms)
    }
    
    func testPoeticDevices() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        let poeticTerms = [
            ("cantus", ["canticum", "cantionum"], "song"),
            ("memini", ["meminero"], "remember"),
            ("retributio", ["retributionem"], "repayment"),
            ("exinanio", ["Exinanite"], "demolish")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: poeticTerms)
    }
    
    func testGeographicalReferences() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        let places = [
            ("babylon", ["babylonis"], "babylon"),
            ("sion", ["sion"], "zion"),
            ("jerusalem", ["jerusalem"], "jerusalem"),
            ("edom", ["edom"], "edom")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: places)
    }
    
    func testViolentImagery() {
        let analysis = latinService.analyzePsalm(text: psalm136)
        let violentTerms = [
            ("allido", ["allidet"], "dash against"),
            ("fundamentum", ["fundamentum"], "foundation"),
            ("petra", ["petram"], "rock")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: violentTerms)
    }
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
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