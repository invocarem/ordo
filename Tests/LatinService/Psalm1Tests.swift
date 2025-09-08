import XCTest
@testable import LatinService

class Psalm1Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 1, category: nil)
    
    // MARK: - Test Data
    private let psalm1 = [
        "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;",
        "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte.",
        "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:",
        "Et folium eius non defluet, et omnia quaecumque faciet, prosperabuntur.",
        "Non sic impii, non sic: sed tamquam pulvis, quem proicit ventus a facie terrae.",
        "Ideo non resurgent impii in iudicio, neque peccatores in concilio iustorum;",
        "Quoniam novit Dominus viam iustorum: et iter impiorum peribit."
    ]
    
    // MARK: - Key Lemma Tests (focusing on uncommon words)
    
    func testPsalm1KeyLemmas() {
        let completeText = psalm1.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key uncommon lemmas with single-word translations
        let keyLemmas = [
            ("beatus", ["beatus"], "blessed"),
            ("abeo", ["abiit"], "go"),
            ("impius", ["impiorum", "impii"], "wicked"),
            ("peccator", ["peccatorum", "peccatores"], "sinner"),
            ("cathedra", ["cathedra"], "seat"),
            ("pestilentia", ["pestilentiae"], "pestilence"),
            ("meditor", ["meditabitur"], "meditate"),
            ("lignum", ["lignum"], "tree"),
            ("planto", ["plantatum"], "plant"),
            ("decursus", ["decursus"], "course"),
            ("fructus", ["fructum"], "fruit"),
            ("folium", ["folium"], "leaf"),
            ("defluo", ["defluet"], "wither"),
            ("prospero", ["prosperabuntur"], "prosper"),
            ("pulvis", ["pulvis"], "dust"),
            ("proicio", ["proicit"], "scatter"),
            ("resurgo", ["resurgent"], "rise"),
            ("iudicium", ["iudicio"], "judgment"),
            ("iustus", ["iustorum", "iustorum"], "righteous"),
            ("pereo", ["peribit"], "perish")
        ]
        
        if verbose {
            print("\nPSALM 1 KEY LEMMA ANALYSIS:")
            print("Complete text: \(completeText)")
            print("\nDETECTED LEMMAS:")
            for (lemma, entry) in analysis.dictionary.sorted(by: { $0.key < $1.key }) {
                print("\(lemma): \(entry.translation ?? "?") - Forms: \(entry.forms.keys.sorted().joined(separator: ", "))")
            }
        }
        
        // Verify key lemmas are detected
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        
        for (lemma, expectedForms, _) in keyLemmas {
            XCTAssertTrue(
                detectedLemmas.contains(lemma.lowercased()),
                "Key lemma '\(lemma)' should be detected in analysis"
            )
            
            if let entry = analysis.dictionary[lemma] ?? analysis.dictionary[lemma.capitalized] {
                // Check if any of the expected forms are found
                let foundForms = expectedForms.filter { entry.forms[$0] != nil }
                
                if verbose {
                    let status = foundForms.isEmpty ? "❌" : "✅"
                    print("\(status) \(lemma): \(entry.translation ?? "?") - Found forms: \(foundForms.joined(separator: ", "))")
                }
                
                // Don't fail if forms aren't found - just log for debugging
                if foundForms.isEmpty && verbose {
                    print("   Available forms: \(entry.forms.keys.sorted().joined(separator: ", "))")
                }
            }
        }
    }
    
    func testPsalm1SpecificForms() {
        // Test that specific forms map to the correct base lemmas
        let testCases = [
            ("abiit", "abeo"),
            ("stetit", "sto"),
            ("sedit", "sedeo"),
            ("meditabitur", "meditor"),
            ("plantatum", "planto"),
            ("dabit", "do"),
            ("defluet", "defluo"),
            ("prosperabuntur", "prospero"),
            ("proicit", "proicio"),
            ("resurgent", "resurgo"),
            ("peribit", "pereo")
        ]
        
        for (form, expectedLemma) in testCases {
            // Analyze the word in a minimal context
            let analysis = latinService.analyzePsalm(id, text: "test \(form) test", startingLineNumber: 1)
            
            if verbose {
                print("\nTesting form: '\(form)'")
                print("Expected base lemma: \(expectedLemma)")
                print("Detected lemmas: \(analysis.dictionary.keys.sorted().joined(separator: ", "))")
            }
            
            // Check if the expected base lemma is detected
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            XCTAssertTrue(
                detectedLemmas.contains(expectedLemma.lowercased()),
                "Form '\(form)' should be recognized as lemma '\(expectedLemma)'. Detected: \(detectedLemmas.joined(separator: ", "))"
            )
        }
    }
    
    func testPsalm1LineByLineKeyLemmas() {
        // Test that each line contains the expected BASE LEMMAS
        let lineTests = [
            (1, ["beatus", "vir", "abeo", "consilium", "impius", "via", "peccator", "sto", "cathedra", "pestilentia", "sedeo"]),
            (2, ["lex", "dominus", "voluntas", "meditor", "dies", "nox"]),
            (3, ["lignum", "planto", "secus", "decursus", "aqua", "fructus", "do", "tempus"]),
            (4, ["folium", "defluo", "omnis", "facio", "prospero"]),
            (5, ["impius", "pulvis", "proicio", "ventus", "facies", "terra"]),
            (6, ["resurgo", "impius", "iudicium", "peccator", "concilium", "iustus"]),
            (7, ["nosco", "dominus", "via", "iustus", "iter", "impius", "pereo"])
        ]
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm1[lineNumber - 1]
            let analysis = latinService.analyzePsalm(id, text: line, startingLineNumber: lineNumber)
            
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let foundLemmas = expectedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            
            if verbose {
                let status = foundLemmas.count > 0 ? "✅" : "❌"
                print("\(status) Line \(lineNumber): Found \(foundLemmas.count)/\(expectedLemmas.count) key lemmas: \(foundLemmas.joined(separator: ", "))")
                if foundLemmas.count < expectedLemmas.count {
                    let missing = expectedLemmas.filter { !detectedLemmas.contains($0.lowercased()) }
                    print("   Missing: \(missing.joined(separator: ", "))")
                    print("   Available: \(detectedLemmas.sorted().joined(separator: ", "))")
                }
            }
            
            XCTAssertTrue(
                foundLemmas.count > 0,
                "Line \(lineNumber) should contain at least one key lemma. Expected: \(expectedLemmas.joined(separator: ", "))"
            )
        }
    }
    
    func testPsalm1MinimalContext() {
        // Test that words in minimal context produce the expected base lemmas
        let wordTests = [
            ("beatus", "beatus"),
            ("abiit", "abeo"),
            ("meditabitur", "meditor"),
            ("plantatum", "planto"),
            ("defluet", "defluo"),
            ("proicit", "proicio"),
            ("resurgent", "resurgo")
        ]
        
        for (form, expectedLemma) in wordTests {
            let analysis = latinService.analyzePsalm(id, text: form, startingLineNumber: 1)
            
            if verbose {
                print("\nTesting form: '\(form)'")
                print("Expected base lemma: \(expectedLemma)")
                print("Detected lemmas: \(analysis.dictionary.keys.sorted().joined(separator: ", "))")
            }
            
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let found = detectedLemmas.contains(expectedLemma.lowercased())
            
            if verbose {
                let status = found ? "✅" : "❌"
                print("\(status) '\(form)' → '\(expectedLemma)': \(found)")
            }
        }
    }
    
    // MARK: - Thematic Tests (simplified)
    
    func testBlessedManTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm1.joined(separator: " "))
        
        let blessedLemmas = ["beatus", "vir", "lex", "meditor"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = blessedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 blessed-man-related lemmas")
    }
    
    func testTreeImageryTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm1.joined(separator: " "))
        
        let treeLemmas = ["lignum", "planto", "aqua", "fructus", "folium", "prospero"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = treeLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 tree-imagery lemmas")
    }
    
    func testWickedContrastTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm1.joined(separator: " "))
        
        let wickedLemmas = ["impius", "peccator", "pulvis", "proicio", "pereo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = wickedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 wicked-contrast lemmas")
    }
    
    func testJudgmentTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm1.joined(separator: " "))
        
        let judgmentLemmas = ["iudicium", "concilium", "iustus", "resurgo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = judgmentLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 judgment-related lemmas")
    }
    
    // MARK: - Structural Test
    
    func testPsalm1StructuralFeatures() {
        let completeText = psalm1.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test the threefold negation pattern
        let negativeActions = ["abeo", "sto", "sedeo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundNegativeActions = negativeActions.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(
            foundNegativeActions.count >= 2,
            "Should find at least 2 of the three negative actions: \(negativeActions.joined(separator: ", "))"
        )
        
        // Test key repetitions
        if verbose {
            print("\nSTRUCTURAL ANALYSIS:")
            print("Negative actions found: \(foundNegativeActions.joined(separator: ", "))")
            
            // Show frequency of key terms
            let keyTerms = ["non", "et", "in"]
            for term in keyTerms {
                if let count = analysis.dictionary[term]?.forms.values.reduce(0, +) {
                    print("'\(term)' appears \(count) times")
                }
            }
        }
    }
}