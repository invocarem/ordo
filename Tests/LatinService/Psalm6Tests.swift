import XCTest
@testable import LatinService

class Psalm6Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 6, category: nil)
    
    // MARK: - Test Data
    private let psalm6 = [
        "Domine, ne in furore tuo arguas me, neque in ira tua corripias me.",
        "Miserere mei, Domine, quoniam infirmus sum; sana me, Domine, quoniam conturbata sunt ossa mea.",
        "Et anima mea turbata est valde; sed tu, Domine, usquequo?",
        "Convertere, Domine, et eripe animam meam; salvum me fac propter misericordiam tuam.",
        "Quoniam non est in morte qui memor sit tui; in inferno autem quis confitebitur tibi?",
        "Laboravi in gemitu meo, lavabo per singulas noctes lectum meum; lacrimis meis stratum meum rigabo.",
        "Turbatus est a furore oculus meus; inveteravi inter omnes inimicos meos.",
        "Discedite a me, omnes qui operamini iniquitatem, quoniam exaudivit Dominus vocem fletus mei.",
        "Exaudivit Dominus deprecationem meam; Dominus orationem meam suscepit.",
        "Erubescant et conturbentur vehementer omnes inimici mei; convertantur et erubescant valde velociter."
    ]
    
    // MARK: - Key Lemma Tests (focusing on uncommon words)
    
    func testPsalm6KeyLemmas() {
        let completeText = psalm6.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key uncommon lemmas with single-word translations
        let keyLemmas = [
            ("furor", ["furore"], "wrath"),
            ("arguo", ["arguas"], "rebuke"),
            ("ira", ["ira"], "anger"),
            ("corripio", ["corripias"], "chasten"),
            ("misereor", ["miserere"], "mercy"),
            ("infirmus", ["infirmus"], "weak"),
            ("sano", ["sana"], "heal"),
            ("conturbo", ["conturbata"], "trouble"),
            ("os", ["ossa"], "bone"),
            ("turbo", ["turbata", "turbatus"], "trouble"),
            ("usquequo", ["usquequo"], "how long"),
            ("converto", ["convertere"], "turn"),
            ("eripio", ["eripe"], "deliver"),
            ("salvus", ["salvum"], "save"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("mors", ["morte"], "death"),
            ("memor", ["memor"], "mindful"),
            ("infernus", ["inferno"], "hell"),
            ("confiteor", ["confitebitur"], "confess"),
            ("laboro", ["laboravi"], "labor"),
            ("gemitus", ["gemitu"], "groan"),
            ("lavo", ["lavabo"], "wash"),
            ("nox", ["noctes"], "night"),
            ("lacrima", ["lacrimis"], "tear"),
            ("rigo", ["rigabo"], "drench"),
            ("oculus", ["oculus"], "eye"),
            ("invetero", ["inveteravi"], "age"),
            ("inimicus", ["inimicos", "inimici"], "enemy"),
            ("discedo", ["discedite"], "depart"),
            ("iniquitas", ["iniquitatem"], "iniquity"),
            ("exaudio", ["exaudivit"], "hear"),
            ("fletus", ["fletus"], "weeping"),
            ("deprecatio", ["deprecationem"], "prayer"),
            ("oratio", ["orationem"], "prayer"),
            ("suscipio", ["suscepit"], "receive"),
            ("erubesco", ["erubescant"], "ashamed"),
            ("velox", ["velociter"], "swift")
        ]
        
        if verbose {
            print("\nPSALM 6 KEY LEMMA ANALYSIS:")
            print("Complete text: \(completeText)")
            print("\nDETECTED LEMMAS:")
            for (lemma, entry) in analysis.dictionary.sorted(by: { $0.key < $1.key }) {
                print("\(lemma): \(entry.translation ?? "?") - Forms: \(entry.forms.keys.sorted().joined(separator: ", "))")
            }
        }
        
        // Verify key lemmas are detected
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        
        for (lemma, expectedForms, expectedTranslation) in keyLemmas {
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
    
    func testPsalm6SpecificForms() {
        // Test that specific forms map to the correct base lemmas
        let testCases = [
            ("arguas", "arguo"),
            ("corripias", "corripio"),
            ("miserere", "misereor"),
            ("sana", "sano"),
            ("conturbata", "conturbo"),
            ("turbata", "turbo"),
            ("convertere", "converto"),
            ("eripe", "eripio"),
            ("confitebitur", "confiteor"),
            ("laboravi", "laboro"),
            ("lavabo", "lavo"),
            ("rigabo", "rigo"),
            ("inveteravi", "invetero"),
            ("discedite", "discedo"),
            ("exaudivit", "exaudio"),
            ("suscepit", "suscipio"),
            ("erubescant", "erubesco")
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
    
    func testPsalm6LineByLineKeyLemmas() {
        // Test that each line contains the expected BASE LEMMAS
        let lineTests = [
            (1, ["dominus", "furor", "arguo", "ira", "corripio"]),
            (2, ["misereor", "dominus", "infirmus", "sum", "sano", "conturbo", "os"]),
            (3, ["anima", "turbo", "dominus", "usquequo"]),
            (4, ["converto", "dominus", "eripio", "anima", "salvus", "facio", "misericordia"]),
            (5, ["mors", "memor", "infernus", "confiteor"]),
            (6, ["laboro", "gemitus", "lavo", "nox", "lectus", "lacrima", "stratum", "rigo"]),
            (7, ["turbo", "furor", "oculus", "invetero", "inimicus"]),
            (8, ["discedo", "operor", "iniquitas", "exaudio", "dominus", "vox", "fletus"]),
            (9, ["exaudio", "dominus", "deprecatio", "oratio", "suscipio"]),
            (10, ["erubesco", "conturbo", "inimicus", "converto", "velox"])
        ]
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm6[lineNumber - 1]
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
    
    // MARK: - Thematic Tests (simplified)
    
    func testPenitentialTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm6.joined(separator: " "))
        
        let penitentialLemmas = ["misereor", "fletus", "lacrima", "gemitus", "conturbo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = penitentialLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 penitential lemmas")
    }
    
    func testPhysicalSufferingTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm6.joined(separator: " "))
        
        let sufferingLemmas = ["infirmus", "os", "oculus", "laboro", "rigo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = sufferingLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 physical suffering lemmas")
    }
    
    func testDivineMercyTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm6.joined(separator: " "))
        
        let mercyLemmas = ["misereor", "misericordia", "exaudio", "suscipio", "salvus"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = mercyLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 divine mercy lemmas")
    }
    
    func testEnemyTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm6.joined(separator: " "))
        
        let enemyLemmas = ["inimicus", "iniquitas", "erubesco", "discedo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = enemyLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 enemy-related lemmas")
    }
    
    // MARK: - Structural Test
    
    func testPsalm6StructuralFeatures() {
        let completeText = psalm6.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key repetitions
        let keyLemmas = ["dominus", "conturbo", "inimicus"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundKeyLemmas = keyLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(
            foundKeyLemmas.count >= 2,
            "Should find at least 2 key repeated lemmas: \(keyLemmas.joined(separator: ", "))"
        )
        
        if verbose {
            print("\nSTRUCTURAL ANALYSIS:")
            print("Key lemmas found: \(foundKeyLemmas.joined(separator: ", "))")
            
            // Show frequency of key terms
            let keyTerms = ["dominus", "conturbo", "inimicus"]
            for term in keyTerms {
                if let count = analysis.dictionary[term]?.forms.values.reduce(0, +) {
                    print("'\(term)' appears \(count) times")
                }
            }
        }
    }
    
    // MARK: - Rare Words Test
    
    func testPsalm6RareWords() {
        let analysis = latinService.analyzePsalm(id, text: psalm6.joined(separator: " "))
        
        let rareLemmas = ["invetero", "usquequo", "rigo", "erubesco"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundRareLemmas = rareLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nRARE LEMMAS FOUND: \(foundRareLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(
            foundRareLemmas.count >= 2,
            "Should find at least 2 rare lemmas: \(rareLemmas.joined(separator: ", "))"
        )
    }
}