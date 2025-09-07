import XCTest
@testable import LatinService

class Psalm118HeTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 118, category: "he")
    
    // MARK: - Test Data
    private let psalm118He = [
        "Legem pone mihi, Domine, viam iustificationum tuarum, et exquiram eam semper.",
        "Da mihi intellectum, et scrutabor legem tuam, et custodiam illam in toto corde meo.",
        "Deduc me in semitam mandatorum tuorum, quia ipsam volui.",
        "Inclina cor meum in testimonia tua, et non in avaritiam.",
        "Averte oculos meos ne videant vanitatem, in via tua vivifica me.",
        "Statue servo tuo eloquium tuum in timore tuo.",
        "Amputa opprobrium meum quod suspicatus sum, quia iudicia tua iucunda.",
        "Ecce concupivi mandata tua, in aequitate tua vivifica me."
    ]
    
    // MARK: - Key Lemma Tests
    
    func testPsalm118HeKeyLemmas() {
        let completeText = psalm118He.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key lemmas with single-word translations
        let keyLemmas = [
            ("lex", ["legem"], "law"),
            ("pono", ["pone"], "place/set"),
            ("dominus", ["domine"], "Lord"),
            ("via", ["viam", "via"], "way"),
            ("iustificatio", ["iustificationum"], "justification"),
            ("exquiro", ["exquiram"], "seek out"),
            ("semper", ["semper"], "always"),
            ("do", ["da"], "give"),
            ("intellectus", ["intellectum"], "understanding"),
            ("scrutor", ["scrutabor"], "examine"),
            ("custodio", ["custodiam"], "keep/guard"),
            ("cor", ["corde", "cor"], "heart"),
            ("deduco", ["deduc"], "lead/guide"),
            ("semita", ["semitam"], "path"),
            ("mandatum", ["mandatorum", "mandata"], "commandment"),
            ("volo", ["volui"], "will/want"),
            ("inclino", ["inclina"], "incline/bend"),
            ("testimonium", ["testimonia"], "testimony"),
            ("avaritia", ["avaritiam"], "greed"),
            ("averto", ["averte"], "turn away"),
            ("oculus", ["oculos"], "eye"),
            ("video", ["videant"], "see"),
            ("vanitas", ["vanitatem"], "vanity"),
            ("vivifico", ["vivifica"], "quicken/give life"),
            ("statuo", ["statue"], "establish/set"),
            ("servus", ["servo"], "servant"),
            ("eloquium", ["eloquium"], "word/speech"),
            ("timor", ["timore"], "fear"),
            ("amputo", ["amputa"], "cut off/remove"),
            ("opprobrium", ["opprobrium"], "reproach/shame"),
            ("suspicor", ["suspicatus"], "suspect"),
            ("iudicium", ["iudicia"], "judgment"),
            ("iucundus", ["iucunda"], "pleasant"),
            ("ecce", ["ecce"], "behold"),
            ("concupisco", ["concupivi"], "desire"),
            ("aequitas", ["aequitate"], "equity/righteousness")
        ]
        
        if verbose {
            print("\nPSALM 118 (HE) KEY LEMMA ANALYSIS:")
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
    func testPsalm118HeLineByLineKeyLemmas() {
        // Test that each line contains the expected BASE LEMMAS
        let lineTests = [
            (1, ["lex", "pono", "dominus", "via", "iustificatio", "exquiro", "semper"]),
            (2, ["do", "intellectus", "scrutor", "lex", "custodio", "cor"]),
            (3, ["deduco", "semita", "mandatum", "volo"]),
            (4, ["inclino", "cor", "testimonium", "avaritia"]),
            (5, ["averto", "oculus", "video", "vanitas", "via", "vivifico"]),
            (6, ["statuo", "servus", "eloquium", "timor"]),
            (7, ["amputo", "opprobrium", "suspicor", "iudicium", "iucundus"]),
            (8, ["ecce", "concupisco", "mandatum", "aequitas", "vivifico"])
        ]
        
        var lineFailures: [String] = []
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm118He[lineNumber - 1]
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
    
    func testDivineLawTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118He.joined(separator: " "))
        
        let lawLemmas = ["lex", "iustificatio", "mandatum", "testimonium", "iudicium", "eloquium"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = lawLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nDIVINE LAW THEME: Found \(foundLemmas.count)/\(lawLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 divine law lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testSpiritualGuidanceTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118He.joined(separator: " "))
        
        let guidanceLemmas = ["deduco", "semita", "via", "inclino", "averto", "statuo", "vivifico"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = guidanceLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nSPIRITUAL GUIDANCE THEME: Found \(foundLemmas.count)/\(guidanceLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 4, "Should find at least 4 spiritual guidance lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testHeartAndDesireTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118He.joined(separator: " "))
        
        let heartLemmas = ["cor", "volo", "concupisco", "intellectus", "timor", "aequitas"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = heartLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nHEART AND DESIRE THEME: Found \(foundLemmas.count)/\(heartLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 heart/desire lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    func testProtectionFromEvilTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm118He.joined(separator: " "))
        
        let protectionLemmas = ["averto", "vanitas", "avaritia", "amputo", "opprobrium", "custodio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = protectionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nPROTECTION FROM EVIL THEME: Found \(foundLemmas.count)/\(protectionLemmas.count) lemmas: \(foundLemmas.joined(separator: ", "))")
        }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 protection from evil lemmas. Found: \(foundLemmas.joined(separator: ", "))")
    }
    
    // MARK: - Structural Test
    
    func testPsalm118HeStructuralFeatures() {
        let completeText = psalm118He.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key repetitions
        let keyLemmas = ["dominus", "lex", "mandatum", "via", "cor", "vivifico"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundKeyLemmas = keyLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        if verbose {
            print("\nSTRUCTURAL ANALYSIS:")
            print("Key lemmas found: \(foundKeyLemmas.joined(separator: ", "))")
            
            // Show frequency of key terms
            let keyTerms = ["dominus", "lex", "mandatum", "via", "cor", "vivifico"]
            for term in keyTerms {
                if let count = analysis.dictionary[term]?.forms.values.reduce(0, +) {
                    print("'\(term)' appears \(count) times")
                } else {
                    print("'\(term)' appears 0 times")
                }
            }
        }
        
        XCTAssertTrue(
            foundKeyLemmas.count >= 3,
            "Should find at least 3 key repeated lemmas: \(keyLemmas.joined(separator: ", ")). Found: \(foundKeyLemmas.joined(separator: ", "))"
        )
    }
    
    // MARK: - Rare Words Test
    
    func testPsalm118HeRareWords() {
        let analysis = latinService.analyzePsalm(id, text: psalm118He.joined(separator: " "))
        
        let rareLemmas = ["iustificatio", "exquiro", "semita", "avaritia", "eloquium", "opprobrium", "iucundus", "aequitas"]
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
            foundRareLemmas.count >= 4,
            "Should find at least 4 rare lemmas: \(rareLemmas.joined(separator: ", ")). Found: \(foundRareLemmas.joined(separator: ", "))"
        )
    }
    
    // MARK: - Specific Forms Test
    
    func testPsalm118HeSpecificForms() {
        // Test that specific forms map to the correct base lemmas
        let testCases = [
            ("pone", "pono"),
            ("exquiram", "exquiro"),
            ("scrutabor", "scrutor"),
            ("custodiam", "custodio"),
            ("deduc", "deduco"),
            ("volui", "volo"),
            ("inclina", "inclino"),
            ("averte", "averto"),
            ("videant", "video"),
            ("vivifica", "vivifico"),
            ("statue", "statuo"),
            ("amputa", "amputo"),
            ("suspicatus", "suspicor"),
            ("concupivi", "concupisco")
        ]
        
        var formFailures: [String] = []
        
        for (form, expectedLemma) in testCases {
            // Analyze the word in a minimal context
            let analysis = latinService.analyzePsalm(id, text: "test \(form) test", startingLineNumber: 1)
            
            // Check if the expected base lemma is detected
            let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
            let isDetected = detectedLemmas.contains(expectedLemma.lowercased())
            
            if verbose {
                let status = isDetected ? "✅" : "❌"
                print("\(status) Form '\(form)' -> Lemma '\(expectedLemma)': \(isDetected ? "FOUND" : "MISSING")")
                if !isDetected {
                    print("   Detected lemmas: \(detectedLemmas.sorted().joined(separator: ", "))")
                }
            }
            
            if !isDetected {
                formFailures.append("Form '\(form)' should map to lemma '\(expectedLemma)'")
            }
        }
        
        if !formFailures.isEmpty {
            XCTFail("Form-to-lemma mapping failures:\n" + formFailures.joined(separator: "\n"))
        }
    }
}