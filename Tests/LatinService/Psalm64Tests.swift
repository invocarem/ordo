import XCTest
@testable import LatinService

class Psalm64Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 64, category: nil)
    
    // MARK: - Test Data
    let psalm64 = [
        "Te decet hymnus, Deus, in Sion; et tibi reddetur votum in Jerusalem.",
        "Exaudi orationem meam; ad te omnis caro veniet.",
        "Verba iniquorum praevaluerunt super nos; et impietatibus nostris tu propitiaberis.",
        "Beatus quem elegisti et assumpsisti; inhabitabit in atriis tuis.",
        "Replebimur in bonis domus tuae; sanctum est templum tuum, mirabile in aequitate.",
        "Exaudi nos, Deus, salutaris noster; spes omnium finium terrae et in mari longe.",
        "Praeparans montes in virtute tua, accinctus potentia;",
        "Qui conturbas profundum maris, sonum fluctuum ejus. Turbabuntur gentes,",
        "Et timebunt qui habitant terminos a signis tuis; exitus matutini et vespere delectabis.",
        "Visitasti terram, et inebriasti eam; multiplicasti locupletare eam.",
        "Flumen Dei repletum est aquis; parasti cibum illorum, quoniam ita est praeparatio ejus.",
        "Rivos ejus inebria, multiplica genimina ejus; in stillicidiis ejus laetabitur germinans.",
        "Benedices coronae anni benignitatis tuae; et campi tui replebuntur ubertate.",
        "Pinguescent speciosa deserti; et exsultatione colles accingentur.",
        "Induti sunt arietes ovium, et valles abundabunt frumento; clamabunt, etenim hymnum dicent."
    ]
    
    // MARK: - Thematic Test Cases
    
    // 1. Divine Worship Theme
    func testWorshipTheme() {
        latinService.configureDebugging(target: "hymnus")
        let analysis = latinService.analyzePsalm(id, text: psalm64)
        
        let worshipTerms = [
            ("hymnus", ["hymnus"], "hymn"), // v.1
            ("votum", ["votum"], "vow"), // v.1
            ("sanctus", ["sanctum"], "holy"), // v.5
            ("templum", ["templum"], "temple"), // v.5
            ("benedico", ["Benedices"], "bless") // v.13
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: worshipTerms)
    }
    
    // 2. Divine Power Theme
    func testDivinePowerTheme() {
        latinService.configureDebugging(target: "praeparo")
        let analysis = latinService.analyzePsalm(id, text: psalm64)
        
        let powerTerms = [
            ("virtus", ["virtute"], "power"), // v.7
            ("potentia", ["potentia"], "might"), // v.7
            ("conturbo", ["conturbas" ], "disturb"), // v.8
            ("praeparatio", ["praeparatio"], "preparation") ,
            ("praeparo", ["Praeparans" ], "prepare") // v.7,11
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: powerTerms)
    }
    
    // 3. Agricultural Abundance Theme
    func testAbundanceTheme() {
        latinService.configureDebugging(target: "genimen")
        let analysis = latinService.analyzePsalm(id, text: psalm64)
        
        let abundanceTerms = [
            ("repleo", ["Replebimur", "repletum", "replebuntur"], "fill"), // v.5,11,13
            ("genimen", ["genimina"], "produce"), // v.12
            ("uber", ["ubertate"], "breast"), // v.13
            ("frumentum", ["frumento"], "grain"), // v.15
            ("germino", ["germinans"], "sprout") // v.12
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: abundanceTerms)
    }
    
    // 4. Prayer and Response Theme
    func testPrayerTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm64)
        
        let prayerTerms = [
            ("exaudio", ["Exaudi"], "hear"), // v.2,6
            ("oratio", ["orationem"], "prayer"), // v.2
            ("propitior", ["propitiaberis"], "appease"), // v.3
            ("visito", ["Visitasti"], "visit") // v.10
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: prayerTerms)
    }
    
    // MARK: - Verb Tests
    
    func testVerbRepleo() {
        latinService.configureDebugging(target: "repleo")
        let analysis = latinService.analyzePsalm(id, text: psalm64)
        
        let repleoEntry = analysis.dictionary["repleo"]
        XCTAssertNotNil(repleoEntry, "Lemma 'repleo' should exist")
        
        let translation = repleoEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("fill") || translation.contains("replenish"),
            "Expected 'repleo' to mean 'to fill', got: \(translation)"
        )
        
        let formsToCheck = [
            ("Replebimur", "we shall be filled", "future passive"), // v.5
            ("repletum", "filled", "perfect passive participle"), // v.11
            ("replebuntur", "they shall be filled", "future passive") // v.13
        ]
        
        for (form, expectedMeaning, expectedGrammar) in formsToCheck {
            let formCount = repleoEntry?.forms[form.lowercased()] ?? 0
            XCTAssertGreaterThan(formCount, 0, "Form '\(form)' should exist")
            
            if let entity = repleoEntry?.entity {
                let result = entity.analyzeFormWithMeaning(form)
                XCTAssertTrue(
                    result.contains(expectedMeaning) || result.contains(expectedGrammar),
                    "For '\(form)': expected \(expectedMeaning)/\(expectedGrammar), got \(result)"
                )
            }
        }
    }
    func testVerbTurbo() {
    latinService.configureDebugging(target: "turbo")
    let analysis = latinService.analyzePsalm(id, text: psalm64)
    
    // 1. Verify lemma exists
    let turboEntry = analysis.dictionary["turbo"]
    XCTAssertNotNil(turboEntry, "Lemma 'turbo' should exist for 'turbabuntur'")
    
    // 2. Check base verb meaning
    let translation = turboEntry?.translation?.lowercased() ?? ""
    XCTAssertTrue(
        translation.contains("disturb") || translation.contains("agitate"),
        "Expected 'turbo' to mean 'to disturb/agitate', got: \(translation)"
    )
    
    // 3. Verify form exists
    let formCount = turboEntry?.forms["turbabuntur"] ?? 0
    XCTAssertGreaterThan(
        formCount, 0,
        "Form 'turbabuntur' should exist for lemma 'turbo'"
    )
    
    // 4. Detailed analysis with multiple verification points
    if let entity = turboEntry?.entity {
        let analysisResult = entity.analyzeFormWithMeaning("turbabuntur")
        
        // Semantic check
        XCTAssertTrue(
            analysisResult.lowercased().contains("they will be disturbed") ||
            analysisResult.lowercased().contains("will be agitated"),
            "Expected meaning about future disturbance, got: \(analysisResult)"
        )
        
        // Grammatical checks
        XCTAssertTrue(
            analysisResult.contains("future passive") ,
            "Expected future passive 3rd plural, got: \(analysisResult)"
        )
        
                
        if verbose {
            print("\nTURBABUNTUR Analysis:")
            print("Full output: \(analysisResult)")
            print("Breakdown:")
            print("- Tense: \(analysisResult.contains("future") ? "✅" : "❌")")
            print("- Voice: \(analysisResult.contains("passive") ? "✅" : "❌")")
        }
    } else {
        XCTFail("Entity for 'turbo' not found")
    }
    
}
    
    func testVerbConturbo() {
        latinService.configureDebugging(target: "conturbo")
        let analysis = latinService.analyzePsalm(id, text: psalm64)
        
        let conturboEntry = analysis.dictionary["conturbo"]
        XCTAssertNotNil(conturboEntry, "Lemma 'conturbo' should exist")
        
        let translation = conturboEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("disturb") || translation.contains("confuse"),
            "Expected 'conturbo' to mean 'to disturb', got: \(translation)"
        )
        
        let formsToCheck = [
            ("conturbas", "you disturb", "present active 2nd singular"), // v.8
        ]
        
        for (form, expectedMeaning, expectedGrammar) in formsToCheck {
            let formCount = conturboEntry?.forms[form.lowercased()] ?? 0
            XCTAssertGreaterThan(formCount, 0, "Form '\(form)' should exist")
        }
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