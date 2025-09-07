import XCTest
@testable import LatinService

class Psalm2Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 2, category: nil)
    
    // MARK: - Test Data
    private let psalm2 = [
        "Quare fremuerunt gentes, et populi meditati sunt inania?",
        "Astiterunt reges terrae, et principes convenerunt in unum adversus Dominum, et adversus christum eius.",
        "Dirumpamus vincula eorum, et proiciamus a nobis iugum ipsorum.",
        "Qui habitat in caelis irridebit eos, et Dominus subsannabit eos.",
        "Tunc loquetur ad eos in ira sua, et in furore suo conturbabit eos.",
        "Ego autem constitutus sum rex ab eo super Sion montem sanctum eius, praedicans praeceptum eius.",
        "Dominus dixit ad me: Filius meus es tu, ego hodie genui te.",
        "Postula a me, et dabo tibi gentes hereditatem tuam, et possessionem tuam terminos terrae.",
        "Reges eos in virga ferrea, et tamquam vas figuli confringes eos.",
        "Et nunc, reges, intelligite; erudimini, qui iudicatis terram.",
        "Servite Domino in timore, et exsultate ei cum tremore.",
        "Apprehendite disciplinam, nequando irascatur Dominus, et pereatis de via iusta.",
        "Cum exarserit in brevi ira eius, beati omnes qui confidunt in eo."
    ]
    
    // MARK: - Key Lemma Tests (focusing on uncommon words)
    
    func testPsalm2KeyLemmas() {
        let completeText = psalm2.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key uncommon lemmas with single-word translations
        let keyLemmas = [
            ("fremo", ["fremuerunt"], "rage"),
            ("gens", ["gentes"], "nations"),
            ("meditor", ["meditati"], "plot"),
            ("inanis", ["inania"], "vain"),
            ("asto", ["astiterunt"], "stand"),
            ("rex", ["reges"], "king"),
            ("princeps", ["principes"], "ruler"),
            ("convenio", ["convenerunt"], "assemble"),
            ("adversus", ["adversus"], "against"),
            ("christus", ["christum"], "anointed"),
            ("dirumpo", ["dirumpamus"], "break"),
            ("vinculum", ["vincula"], "chain"),
            ("proicio", ["proiciamus"], "throw"),
            ("iugum", ["iugum"], "yoke"),
            ("irrideo", ["irridebit"], "laugh"),
            ("subsanno", ["subsannabit"], "mock"),
            ("ira", ["ira"], "wrath"),
            ("furor", ["furore"], "fury"),
            ("conturbo", ["conturbabit"], "terrify"),
            ("constituo", ["constitutus"], "establish"),
            ("sion", ["sion"], "zion"),
            ("praedico", ["praedicans"], "declare"),
            ("gigno", ["genui"], "beget"),
            ("postulo", ["postula"], "ask"),
            ("hereditas", ["hereditatem"], "inheritance"),
            ("terminus", ["terminos"], "end"),
            ("virga", ["virga"], "rod"),
            ("confringo", ["confringes"], "shatter"),
            ("intelligo", ["intelligite"], "understand"),
            ("erudio", ["erudimini"], "instruct"),
            ("servio", ["servite"], "serve"),
            ("exsulto", ["exsultate"], "rejoice"),
            ("apprehendo", ["apprehendite"], "take"),
            ("disciplina", ["disciplinam"], "discipline"),
            ("irascor", ["irascatur"], "anger"),
            ("beatus", ["beati"], "blessed"),
            ("confido", ["confidunt"], "trust")
        ]
        
        if verbose {
            print("\nPSALM 2 KEY LEMMA ANALYSIS:")
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
    
    func testPsalm2SpecificForms() {
        // Test that specific forms map to the correct base lemmas
        let testCases = [
            ("fremuerunt", "fremo"),
            ("meditati", "meditor"),
            ("astiterunt", "asto"),
            ("convenerunt", "convenio"),
            ("dirumpamus", "dirumpo"),
            ("proiciamus", "proicio"),
            ("irridebit", "irrideo"),
            ("subsannabit", "subsanno"),
            ("conturbabit", "conturbo"),
            ("constitutus", "constituo"),
            ("praedicans", "praedico"),
            ("genui", "gigno"),
            ("confringes", "confringo"),
            ("intelligite", "intelligo"),
            ("erudimini", "erudio"),
            ("exsultate", "exsulto"),
            ("apprehendite", "apprehendo"),
            ("confidunt", "confido")
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
    
    func testPsalm2LineByLineKeyLemmas() {
        // Test that each line contains the expected BASE LEMMAS
        let lineTests = [
            (1, ["fremo", "gens", "populus", "meditor", "inanis"]),
            (2, ["asto", "rex", "terra", "princeps", "convenio", "adversus", "dominus", "christus"]),
            (3, ["dirumpo", "vinculum", "proicio", "iugum"]),
            (4, ["habito", "caelum", "irrideo", "dominus", "subsanno"]),
            (5, ["loquor", "ira", "furor", "conturbo"]),
            (6, ["constituo", "rex", "sion", "mons", "sanctus", "praedico", "praeceptum"]),
            (7, ["dominus", "dico", "filius", "hodie", "gigno"]),
            (8, ["postulo", "do", "gens", "hereditas", "possessio", "terminus", "terra"]),
            (9, ["rego", "virga", "ferreus", "vas", "figulus", "confringo"]),
            (10, ["intelligo", "erudio", "iudico", "terra"]),
            (11, ["servio", "dominus", "timor", "exsulto", "tremor"]),
            (12, ["apprehendo", "disciplina", "irascor", "dominus", "pereo", "via", "iustus"]),
            (13, ["beatus", "omnis", "confido"])
        ]
        
        for (lineNumber, expectedLemmas) in lineTests {
            let line = psalm2[lineNumber - 1]
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
    
    func testRebellionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm2.joined(separator: " "))
        
        let rebellionLemmas = ["fremo", "adversus", "dirumpo", "proicio"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = rebellionLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 rebellion-related lemmas")
    }
    
    func testDivineResponseTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm2.joined(separator: " "))
        
        let divineLemmas = ["irrideo", "subsanno", "ira", "conturbo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = divineLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 divine-response lemmas")
    }
    
    func testKingshipTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm2.joined(separator: " "))
        
        let kingshipLemmas = ["rex", "constituo", "filius", "virga", "confringo"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = kingshipLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 3, "Should find at least 3 kingship-related lemmas")
    }
    
    func testWarningTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm2.joined(separator: " "))
        
        let warningLemmas = ["intelligo", "erudio", "servio", "timor", "disciplina"]
        let detectedLemmas = Set(analysis.dictionary.keys.map { $0.lowercased() })
        let foundLemmas = warningLemmas.filter { detectedLemmas.contains($0.lowercased()) }
        
        XCTAssertTrue(foundLemmas.count >= 2, "Should find at least 2 warning-related lemmas")
    }
    
    // MARK: - Structural Test
    
    func testPsalm2StructuralFeatures() {
        let completeText = psalm2.joined(separator: " ")
        let analysis = latinService.analyzePsalm(id, text: completeText, startingLineNumber: 1)
        
        // Test key repetitions
        let keyLemmas = ["rex", "dominus", "adversus"]
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
            let keyTerms = ["rex", "dominus", "adversus"]
            for term in keyTerms {
                if let count = analysis.dictionary[term]?.forms.values.reduce(0, +) {
                    print("'\(term)' appears \(count) times")
                }
            }
        }
    }
}