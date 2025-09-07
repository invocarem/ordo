import XCTest
@testable import LatinService

class Psalm128Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 128, category: nil)
    
    // MARK: - Test Data
    private let psalm128 = [
        "Saepe expugnaverunt me a iuventute mea, dicat nunc Israel;",
        "saepe expugnaverunt me a iuventute mea, etenim non potuerunt mihi.",
        "Supra dorsum meum fabricaverunt peccatores; prolongaverunt iniquitatem suam.",
        "Dominus iustus concidit cervices peccatorum. confundantur et convertantur retrorsum omnes qui oderunt Sion.",
        "Fiant sicut foenum tectorum, quod priusquam evellatur exaruit,",
        "De quo non implevit manum suam qui metit, et sinum suum qui manipulos colligit.",
        "Et non dixerunt qui praeteribant: Benedictio Domini super vos; benediximus vobis in nomine Domini."
    ]
    
    // MARK: - Key Lemma Tests
    
    func testPsalm128KeyLemmas() {
        let completeText = psalm128.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key lemmas with single-word translations
        let keyLemmas = [
            ("saepe", ["saepe"], "often"),
            ("expugno", ["expugnaverunt"], "fight against"),
            ("iuventus", ["iuventute"], "youth"),
            ("dico", ["dicat"], "say"),
            ("nunc", ["nunc"], "now"),
            ("Israel", ["Israel"], "Israel"),
            ("etenim", ["etenim"], "for indeed"),
            ("possum", ["potuerunt"], "be able"),
            ("supra", ["supra"], "upon"),
            ("dorsum", ["dorsum"], "back"),
            ("fabricor", ["fabricaverunt"], "build/weave"),
            ("peccator", ["peccatores", "peccatorum"], "sinner"),
            ("prolongo", ["prolongaverunt"], "prolong"),
            ("iniquitas", ["iniquitatem"], "iniquity"),
            ("dominus", ["dominus"], "Lord"),
            ("iustus", ["iustus"], "just"),
            ("concido", ["concidit"], "cut down"),
            ("cervix", ["cervices"], "neck"),
            ("confundo", ["confundantur"], "be confounded"),
            ("converto", ["convertantur"], "turn"),
            ("retrorsum", ["retrorsum"], "backward"),
            ("odi", ["oderunt"], "hate"),
            ("Sion", ["Sion"], "Zion"),
            ("fio", ["fiant"], "become"),
            ("sicut", ["sicut"], "like"),
            ("foenum", ["foenum"], "hay"),
            ("tectum", ["tectorum"], "roof"),
            ("priusquam", ["priusquam"], "before"),
            ("evello", ["evellatur"], "pluck out"),
            ("exaresco", ["exaruit"], "wither"),
            ("impleo", ["implevit"], "fill"),
            ("manus", ["manum"], "hand"),
            ("meto", ["metit"], "reap"),
            ("sinus", ["sinum"], "bosom/lap"),
            ("manipulus", ["manipulos"], "handful/bundle"),
            ("colligo", ["colligit"], "gather"),
            ("praetereo", ["praeteribant"], "pass by"),
            ("benedictio", ["benedictio"], "blessing"),
            ("super", ["super"], "upon"),
            ("benedico", ["benediximus"], "bless"),
            ("nomen", ["nomine"], "name")
        ]
        
        if verbose {
            print("\nPSALM 128 KEY LEMMA ANALYSIS:")
            print("Complete text: \(completeText)")
            print("\nDETECTED LEMMAS:")
            for (lemma, entry) in analysis.dictionary.sorted(by: { $0.key < $1.key }) {
                print("\(lemma): \(entry.translation ?? "?") - Forms: \(entry.forms.keys.sorted().joined(separator: ", "))")
            }
        }
        
        // Verify key lemmas are detected
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        var failedLemmas: [String] = []
        
        for (lemma, expectedForms, expectedTranslation) in keyLemmas {
            let lemmaLower = lemma.lowercased()
            let isDetected = detectedLemmas.contains(lemmaLower)
            
            if !isDetected {
                failedLemmas.append(lemma)
                if verbose {
                    print("❌ \(lemma): NOT DETECTED - Expected forms: \(expectedForms.joined(separator: ", "))")
                }
            } else if let entry = analysis.dictionary[lemma] ?? analysis.dictionary[lemma.capitalized] {
                // Check if any of the expected forms are found
                let foundForms = expectedForms.filter { entry.forms[$0] != nil }
                
                if verbose {
                    let status = foundForms.isEmpty ? "⚠️" : "✅"
                    print("\(status) \(lemma): \(entry.translation ?? "?") - Found forms: \(foundForms.joined(separator: ", "))")
                    if foundForms.isEmpty {
                        print("   Expected forms: \(expectedForms.joined(separator: ", "))")
                        print("   Available forms: \(entry.forms.keys.sorted().joined(separator: ", "))")
                    }
                }
            }
        }
        
        if !failedLemmas.isEmpty {
            XCTFail("Failed to detect the following lemmas: \(failedLemmas.joined(separator: ", "))")
        }
    }
    
    // MARK: - Line by Line Key Lemmas Test
    func testPsalm128LineByLineKeyLemmas() {
        // Test that each line contains the expected BASE LEMMAS
        let lineTests = [
            (1, ["saepe", "expugno", "iuventus", "dico", "nunc", "Israel"]),
            (2, ["saepe", "expugno", "iuventus", "etenim", "possum"]),
            (3, ["supra", "dorsum", "fabricor", "peccator", "prolongo", "iniquitas"]),
            (4, ["dominus", "iustus", "concido", "cervix", "peccator", "confundo", "converto", "retrorsum", "odi", "Sion"]),
            (5, ["fio", "sicut", "foenum", "tectum", "priusquam", "evello", "exaresco"]),
            (6, ["impleo", "manus", "meto", "sinus", "manipulus", "colligo"]),
            (7, ["dico", "praetereo", "benedictio", "dominus", "super", "benedico", "nomen", "dominus"])
        ]
        
        var lineFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm128[lineNumber - 1]
            let analysis = latinService.analyzePsalm(id, text: line, startingLineNumber: lineNumber)
            
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let foundLemmas = expectedLemmas.filter { detectedLemmas.contains($0.lowercased()) }
            let missingLemmas = expectedLemmas.filter { !detectedLemmas.contains($0.lowercased()) }
            
            if verbose {
                let status = foundLemmas.count == expectedLemmas.count ? "✅" : foundLemmas.count > 0 ? "⚠️" : "❌"
                print("\(status) Line \(lineNumber): Found \(foundLemmas.count)/\(expectedLemmas.count) key lemmas: \(foundLemmas.joined(separator: ", "))")
                
                if !missingLemmas.isEmpty {
                    print("   Missing: \(missingLemmas.joined(separator: ", "))")
                    print("   Available: \(detectedLemmas.sorted().joined(separator: ", "))")
                }
            }
            
            if foundLemmas.isEmpty {
                lineFailures.append("Line \(lineNumber): Missing all expected lemmas. Expected: \(expectedLemmas.joined(separator: ", "))")
            } else if foundLemmas.count < expectedLemmas.count / 2 {
                lineFailures.append("Line \(lineNumber): Found only \(foundLemmas.count)/\(expectedLemmas.count) lemmas. Missing: \(missingLemmas.joined(separator: ", "))")
            }
        }
        
        if !lineFailures.isEmpty {
            XCTFail("Line-by-line test failures:\n" + lineFailures.joined(separator: "\n"))
        }
    }
    
    // MARK: - Thematic Tests
    
    func testPersecutionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm128.joined(separator: " "))
        
        let persecutionLemmas = ["expugno", "iuventus", "dorsum", "fabricor", "prolongo", "iniquitas"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = persecutionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPERSECUTION THEME: Found \(foundLemmas.count)/\(persecutionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 persecution-related lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testDivineJusticeTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm128.joined(separator: " "))
        
        let justiceLemmas = ["dominus", "iustus", "concido", "confundo", "converto", "retrorsum"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = justiceLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE JUSTICE THEME: Found \(foundLemmas.count)/\(justiceLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 divine justice lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testAgriculturalImageryTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm128.joined(separator: " "))
        
        let agriculturalLemmas = ["foenum", "evello", "exaresco", "meto", "manipulus", "colligo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = agriculturalLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nAGRICULTURAL THEME: Found \(foundLemmas.count)/\(agriculturalLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 agricultural imagery lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testBlessingTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm128.joined(separator: " "))
        
        let blessingLemmas = ["benedictio", "benedico", "nomen", "dominus"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = blessingLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nBLESSING THEME: Found \(foundLemmas.count)/\(blessingLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 blessing-related lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    // MARK: - Structural Test
    
    func testPsalm128StructuralFeatures() {
        let completeText = psalm128.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key repetitions
        let keyLemmas = ["saepe", "expugno", "dominus", "peccator"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundKeyLemmas = keyLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nSTRUCTURAL ANALYSIS:")
            print("Key lemmas found: \(foundKeyLemmas.joined(separator: ", "))")
            
            // Show frequency of key terms
            let keyTerms = ["saepe", "expugno", "dominus", "peccator"]
            for term in keyTerms {
                if let count = analysis.dictionary[term]?.forms.values.reduce(0, +) {
                    print("'\(term)' appears \(count) times")
                } else {
                    print("'\(term)' appears 0 times")
                }
            }
        }
        
        XCTAssertTrue(
            foundKeyLemmas.count >= 2,
            "Should find at least 2 key repeated lemmas: \(keyLemmas.joined(separator: ", ")). Found: \(foundKeyLemmas.joined(separator: ", "))"
        )
    }
    
    // MARK: - Rare Words Test
    
    func testPsalm128RareWords() {
        let analysis = latinService.analyzePsalm(id, text: psalm128.joined(separator: " "))
        
        let rareLemmas = ["retrorsum", "exaresco", "manipulus", "praetereo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundRareLemmas = rareLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nRARE LEMMAS FOUND: \(foundRareLemmas.joined(separator: ", "))")
            let missingRare = rareLemmas.filter { !detectedLemmas.contains($0.lowercased()) }
            if !missingRare.isEmpty {
                print("MISSING RARE LEMMAS: \(missingRare.joined(separator: ", "))")
            }
        }
        
        XCTAssertTrue(
            foundRareLemmas.count >= 2,
            "Should find at least 2 rare lemmas: \(rareLemmas.joined(separator: ", ")). Found: \(foundRareLemmas.joined(separator: ", "))"
        )
    }
}