import XCTest
@testable import LatinService

class Psalm62Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = false
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 62, category: nil)
    
    // MARK: - Test Data
    let psalm62 = [
        "Deus, Deus meus, ad te de luce vigilo.",
        "Sitivit in te anima mea; quam multipliciter tibi caro mea!",
        "In terra deserta, et invia, et inaquosa, sic in sancto apparui tibi, ut viderem virtutem tuam et gloriam tuam.",
        "Quoniam melior est misericordia tua super vitas, labia mea laudabunt te.",
        "Sic benedicam te in vita mea; et in nomine tuo levabo manus meas.",
        "Sicut adipe et pinguedine repleatur anima mea, et labiis exsultationis laudabit os meum.",
        "Si memor fui tui super stratum meum, in matutinis meditabor in te.",
        "Quia fuisti adjutor meus, et in velamento alarum tuarum exsultabo.",
        "Adhaesit anima mea post te; me suscepit dextera tua.",
        "Ipsi vero in vanum quaesierunt animam mea; introibunt in inferiora terrae.",
        "Tradentur in manus gladii; partes vulpium erunt.",
        "Rex vero laetabitur in Deo; laudabuntur omnes qui jurant in eo, quia obstructum est os loquentium iniqua."
    ]
    
     func testPsalm62Vocabulary() {
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        // ===== TEST METRICS =====
        let totalWords = 120  // Actual word count in Psalm 62
        let testedLemmas = 35 // Number of lemmas we're testing
        let testedForms = 45  // Number of word forms verified
        
        // ===== VOCABULARY VERIFICATION =====
        let confirmedWords = [
            ("deus", ["deus", "deus"], "god"),
            ("vigilo", ["vigilo"], "watch"),
            ("sitio", ["sitivit"], "thirst"),
            ("anima", ["anima", "anima", "animam"], "soul"),
            ("caro", ["caro"], "flesh"),
            ("terra", ["terra"], "earth"),
            ("desertus", ["deserta"], "desert"),
            ("invius", ["invia"], "pathless"),
            ("inaquosus", ["inaquosa"], "waterless"),
            ("sanctus", ["sancto"], "holy"),
            ("appareo", ["apparui"], "appear"),
            ("video", ["viderem"], "see"),
            ("virtus", ["virtutem"], "power"),
            ("gloria", ["gloriam"], "glory"),
            ("misericordia", ["misericordia"], "mercy"),
            ("vita", ["vitas", "vita"], "life"),
            ("laudo", ["laudabunt", "laudabit", "laudabuntur"], "praise"),
            ("benedico", ["benedicam"], "bless"),
            ("nomen", ["nomine"], "name"),
            ("levo", ["levabo"], "lift"),
            ("manus", ["manus"], "hand"),
            ("adeps", ["adipe"], "fat"),
            ("pinguedo", ["pinguedine"], "richness"),
            ("repleo", ["repleatur"], "fill"),
            ("exsultatio", ["exsultationis"], "joy"),
            ("memor", ["memor"], "mindful"),
            ("stratum", ["stratum"], "bed"),
            ("meditor", ["meditabor"], "meditate"),
            ("adjutor", ["adjutor"], "helper"),
            ("velamen", ["velamento"], "covering"),
            ("ala", ["alarum"], "wing"),
            ("exsulto", ["exsultabo"], "rejoice"),
            ("adhaereo", ["adhaesit"], "cling"),
            ("dextera", ["dextera"], "right hand"),
            ("suscipio", ["suscepit"], "receive"),
            ("vanus", ["vanum"], "vain"),
            ("quaero", ["quaesierunt"], "seek"),
            ("inferior", ["inferiora"], "lower"),
            ("gladius", ["gladii"], "sword"),
            ("pars", ["partes"], "portion"),
            ("vulpes", ["vulpium"], "fox"),
            ("rex", ["rex"], "king"),
            ("laetor", ["laetabitur"], "rejoice"),
            ("juro", ["jurant"], "swear"),
            ("obstruo", ["obstructum"], "stop"),
            ("iniquus", ["iniqua"], "wicked")
        ]
        
        if verbose {
            print("\n=== Psalm 62 Test Coverage ===")
            print("Total words: \(totalWords)")
            print("Unique lemmas: \(analysis.uniqueLemmas)")
            print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
            print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    }

    // MARK: - Thematic Test Cases
    
    // 1. Soul's Longing Theme
    func testSoulLongingTheme() {
        latinService.configureDebugging(target: "sitio")
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        let longingTerms = [
            ("sitio", ["Sitivit"], "thirst"), // v.2
            ("adhaereo", ["Adhaesit"], "cling"), // v.9
            ("anima", ["anima"], "soul"), // v.2,6,9
            ("desertus", ["deserta"], "deserted") // v.3
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: longingTerms)
    }
    
    // 2. Divine Protection Theme
    func testDivineProtectionTheme() {
        latinService.configureDebugging(target: "velamen")
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        let protectionTerms = [
            ("adjutor", ["adjutor"], "helper"), // v.8
            ("velamen", ["velamento"], "covering"), // v.8
            ("dextera", ["dextera"], "right hand"), // v.9
            ("suscipio", ["suscepit"], "receive") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    // 3. Worship and Praise Theme
    func testWorshipTheme() {
        latinService.configureDebugging(target: "exsulto")
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        let worshipTerms = [
            ("laudo", ["laudabunt", "laudabit", "laudabuntur"], "praise"), // v.4,6,12
            ("benedico", ["benedicam"], "bless"), // v.5
            ("exsulto", ["exsultabo"], "rejoice"), // v.6,8
            ("exsultatio", ["exsultationis"], "rejoicing"), // v.6,8
            ("juro", ["jurant"], "swear") // v.12
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: worshipTerms)
    }
    
    // 4. Judgment Theme
    func testJudgmentTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        let judgmentTerms = [
            ("gladius", ["gladii"], "sword"), // v.11
            ("vulpes", ["vulpium"], "fox"), // v.11
            ("iniquus", ["iniqua"], "wicked"), // v.12
            ("obstruo", ["obstructum"], "silence") // v.12
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    // MARK: - Verb Tests
    
    func testVerbSitio() {
        latinService.configureDebugging(target: "sitio")
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        let entry = analysis.dictionary["sitio"]
        XCTAssertNotNil(entry, "Lemma 'sitio' should exist")
        
        let translation = entry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("thirst") || translation.contains("long"),
            "Expected 'sitio' to mean 'to thirst', got: \(translation)"
        )
        
        if let entity = entry?.entity {
            let result = entity.analyzeFormWithMeaning("Sitivit")
            XCTAssertTrue(
                result.contains("has thirsted") || result.contains("longed"),
                "Expected perfect tense meaning, got: \(result)"
            )
        }
    }
    
    func testVerbLaudo() {
        latinService.configureDebugging(target: "laudo")
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        let entry = analysis.dictionary["laudo"]
        XCTAssertNotNil(entry, "Lemma 'laudo' should exist")
        
        let formsToCheck = [
            ("laudabunt", "they will praise", "future active"), // v.4
            ("laudabit", "it will praise", "future active"), // v.6
            ("laudabuntur", "they will be praised", "future passive") // v.12
        ]
        
        for (form, expectedMeaning, expectedGrammar) in formsToCheck {
            let formCount = entry?.forms[form.lowercased()] ?? 0
            XCTAssertGreaterThan(formCount, 0, "Form '\(form)' should exist")
            
            if let entity = entry?.entity {
                let result = entity.analyzeFormWithMeaning(form)
                XCTAssertTrue(
                    result.contains(expectedMeaning) || result.contains(expectedGrammar),
                    "For '\(form)': expected \(expectedMeaning)/\(expectedGrammar), got \(result)"
                )
            }
        }
    }
    func testNounVulpes() {
        latinService.configureDebugging(target: "vulpes")
        let analysis = latinService.analyzePsalm(id, text: psalm62)
        
        // 1. Verify lemma exists
        let vulpesEntry = analysis.dictionary["vulpes"]
        XCTAssertNotNil(vulpesEntry, "Noun lemma 'vulpes' should exist")
        
        // 2. Check basic translation
        let translation = vulpesEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("fox"),
            "Expected 'vulpes' to mean 'fox', got: \(translation)"
        )
        
        // 3. Verify form exists
        let formCount = vulpesEntry?.forms["vulpium"] ?? 0
        XCTAssertGreaterThan(
            formCount, 0,
            "Genitive plural form 'vulpium' should exist for lemma 'vulpes'"
        )
        
        // 4. Detailed analysis
        if let entity = vulpesEntry?.entity {
            let result = entity.analyzeFormWithMeaning("vulpium")
            
            // Grammatical checks
            XCTAssertTrue(
                result.contains("genitive plural"),
                "Expected genitive plural, got: \(result)"
            )
            
            // Semantic checks
            XCTAssertTrue(
                result.lowercased().contains("fox") || 
                result.lowercased().contains("of fox"),
                "Expected reference to foxes, got: \(result)"
            )
            
        
            if verbose {
                print("\nVULPES Analysis (Psalm 62:11):")
                print("Actual text: 'partes vulpium erunt'")
                print("Form: Genitive plural of vulpes, vulpis f.")
                print("Literal meaning: 'they will be portions for foxes'")
                print("Analysis: \(result)")
            }
        } else {
            XCTFail("Entity for 'vulpes' not found")
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