import XCTest
@testable import LatinService

class Psalm63Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 63, category: nil)
    
    // MARK: - Test Data
    let psalm63 = [
        "Exaudi, Deus, orationem meam cum deprecor; a timore inimici eripe animam meam.",
        "Protexisti me a conventu malignantium, a multitudine operantium iniquitatem.",
        "Quia exacuerunt ut gladium linguas suas; intenderunt arcum rem amaram,",
        "Ut sagittent in occultis immaculatum.",
        "Subito sagittabunt eum, et non timebunt; firmaverunt sibi sermonem nequam.",
        "Narrabunt ut abscondant laqueos; dixerunt: Quis videbit eos?",
        "Scrutati sunt iniquitates; defecerunt scrutantes scrutinio.",
        "Accedet homo ad cor altum, et exaltabitur Deus.",
        "Sagittae parvulorum factae sunt plagae eorum,",
        "Et infirmatae sunt contra eos linguae eorum. Conturbati sunt omnes qui videbant eos;",
        "Et timuit omnis homo. Et annuntiaverunt opera Dei, et facta ejus intellexerunt.",
        "Laetabitur justus in Domino, et sperabit in eo; et laudabuntur omnes recti corde."
    ]
    
    // MARK: - Thematic Test Cases
    
    // 1. Divine Protection Theme
    func testDivineProtectionTheme() {
        latinService.configureDebugging(target: "protego")
        let analysis = latinService.analyzePsalm(id, text: psalm63)
        
        let protectionTerms = [
            ("exaudio", ["Exaudi"], "hear"), // v.1
            ("eripio", ["eripe"], "rescue"), // v.1
            ("protego", ["Protexisti"], "protect"), // v.2
            ("firmo", ["firmaverunt"], "strengthen") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    // 2. Enemy Attacks Theme
    func testEnemyAttacksTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm63)
        
        let enemyTerms = [
            ("inimicus", ["inimici"], "enemy"), // v.1
            ("gladius", ["gladium"], "sword"), // v.3
            ("arcus", ["arcum"], "bow"), // v.3
            ("sagitto", ["sagittent", "sagittabunt"], "arrow"), // v.4,5,
            ("sagitta", ["Sagittae"], "arrow"), // 9
            ("laqueus", ["laqueos"], "snare") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    
    // 3. Justice Theme
    func testJusticeTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm63)
        
        let justiceTerms = [
            ("justus", ["justus"], "righteous"), // v.12
            ("rectus", ["recti"], "upright"), // v.12
            ("iniquitas", ["iniquitatem", "iniquitates"], "wickedness"), // v.2,7
            ("scrutor", ["Scrutati", "scrutantes" ], "examine") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
    }
    
    // 4. Trust in God Theme
    func testTrustTheme() {
        latinService.configureDebugging(target: "spero")
        let analysis = latinService.analyzePsalm(id, text: psalm63)
        
        let trustTerms = [
            ("spero", ["sperabit"], "hope"), // v.12
            ("laetor", ["Laetabitur"], "rejoice"), // v.12
            ("laudo", ["laudabuntur"], "praise"), // v.12
            ("exalto", ["exaltabitur"], "exalt") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: trustTerms)
    }
    
    // MARK: - Verb Tests
    
    func testVerbExaudio() {
        latinService.configureDebugging(target: "exaudio")
        let analysis = latinService.analyzePsalm(id, text: psalm63)
        
        let exaudioEntry = analysis.dictionary["exaudio"]
        XCTAssertNotNil(exaudioEntry, "Lemma 'exaudio' should exist for 'Exaudi'")
        
        let translation = exaudioEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("hear") || translation.contains("listen"),
            "Expected 'exaudio' to mean 'hear/listen', got: \(translation)"
        )
        
        let formCount = exaudioEntry?.forms["exaudi"] ?? 0
        XCTAssertGreaterThan(formCount, 0, "Form 'Exaudi' should exist for lemma 'exaudio'")
        
        if let entity = exaudioEntry?.entity {
            let result = entity.analyzeFormWithMeaning("Exaudi")
            XCTAssertTrue(result.contains("imperative") || result.contains("command"),
                         "Expected 'Exaudi' to be imperative, got: \(result)")
        }
    }
    
    func testVerbSagitto() {
        latinService.configureDebugging(target: "sagitto")
        let analysis = latinService.analyzePsalm(id, text: psalm63)
        
        let sagittoEntry = analysis.dictionary["sagitto"]
        XCTAssertNotNil(sagittoEntry, "Lemma 'sagitto' should exist for 'sagittent'")
        
        let translation = sagittoEntry?.translation?.lowercased() ?? ""
        XCTAssertTrue(
            translation.contains("shoot") || translation.contains("arrow"),
            "Expected 'sagitto' to relate to shooting arrows, got: \(translation)"
        )
        
        let formsToCheck = ["sagittent", "sagittabunt" ]
        for form in formsToCheck {
            let formCount = sagittoEntry?.forms[form.lowercased()] ?? 0
            XCTAssertGreaterThan(formCount, 0, "Form '\(form)' should exist for lemma 'sagitto'")
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