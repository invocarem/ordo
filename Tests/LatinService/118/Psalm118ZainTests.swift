import XCTest
@testable import LatinService

class Psalm118ZainTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "zain")
    
    // MARK: - Test Data (Psalm 118:49-56 "Zain" category)
    let psalm118Zain = [
        "Memor esto verbi tui servo tuo, in quo mihi spem dedisti.",
        "Haec me consolata est in humilitate mea, quia eloquium tuum vivificavit me.",
        "Superbi inique agebant usquequaque, a lege autem tua non declinavi.",
        "Memor fui judiciorum tuorum a saeculo, Domine, et consolatus sum.",
        "Defectio tenuit me, pro peccatoribus derelinquentibus legem tuam.",
        "Cantabiles mihi erant justificationes tuae in loco peregrinationis meae.",
        "Memor fui nocte nominis tui, Domine, et custodivi legem tuam.",
        "Hoc factum est mihi, quia justificationes tuas exquisivi."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118ZainLines1and2() {
        let line1 = psalm118Zain[0]
        let line2 = psalm118Zain[1]
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("memor", ["memor"], "mindful"),
            ("verbum", ["verbi", "eloquium"], "word"),
            ("servus", ["servo"], "servant"),
            ("spes", ["spem"], "hope"),
            ("consolor", ["consolata"], "comfort"),
            ("humilitas", ["humilitate"], "humiliation"),
            ("vivifico", ["vivificavit"], "revive")
        ]
        
        if verbose {
            print("\nPSALM 118 ZAIN:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Covenant Remembrance: memor (remember) + verbi tui (your word)")
            print("2. Divine Comfort: consolata (comforted) + humilitate (humiliation)")
            print("3. Life-Giving Word: eloquium (word) + vivificavit (revived)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["spes"]?.forms["spem"], 1, "Should find 'hope' reference")
        XCTAssertNotNil(analysis.dictionary["humilitas"], "Should find 'humiliation' reference")
        XCTAssertEqual(analysis.dictionary["vivifico"]?.forms["vivificavit"], 1, "Should find 'revive' verb")
    }
    
    func testPsalm118ZainLines3and4() {
        let line3 = psalm118Zain[2]
        let line4 = psalm118Zain[3]
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("superbus", ["superbi"], "arrogant"),
            ("inique", ["inique"], "unjustly"),
            ("ago", ["agebant"], "act"),
            ("lex", ["lege"], "law"),
            ("declino", ["declinavi"], "turn aside"),
            ("memor", ["memor"], "mindful"),
            ("judicium", ["judiciorum"], "judgments"),
            ("saeculum", ["saeculo"], "age"),
            ("consolor", ["consolatus"], "comforted")
        ]
        
        if verbose {
            print("\nPSALM 118 ZAIN:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Resistance to Evil: superbi (arrogant) + inique (unjustly)")
            print("2. Steadfast Obedience: non declinavi (did not turn) + lege (law)")
            print("3. Eternal Perspective: memor fui (I remembered) + a saeculo (from of old)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["declino"]?.forms["declinavi"], 1, "Should find 'turn aside' verb")
        XCTAssertNotNil(analysis.dictionary["judicium"], "Should find 'judgments' reference")
        XCTAssertEqual(analysis.dictionary["consolor"]?.forms["consolatus"], 1, "Should find 'comforted' verb")
    }
    
    func testPsalm118ZainLines5and6() {
        let line5 = psalm118Zain[4]
        let line6 = psalm118Zain[5]
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("defectio", ["defectio"], "fainting"),
            ("teneo", ["tenuit"], "seize"),
            ("peccator", ["peccatoribus"], "sinners"),
            ("derelinquo", ["derelinquentibus"], "forsake"),
            ("cantabilis", ["cantabiles"], "sung"),
            ("justificatio", ["justificationes"], "ordinances"),
            ("peregrinatio", ["peregrinationis"], "sojourn")
        ]
        
        if verbose {
            print("\nPSALM 118 ZAIN:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Spiritual Exhaustion: defectio (fainting) + tenuit (seized)")
            print("2. Righteous Grief: pro peccatoribus (because of sinners) + derelinquentibus (forsaking)")
            print("3. Joyful Obedience: cantabiles (sung) + justificationes (ordinances)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["defectio"], "Should find 'fainting' reference")
        XCTAssertEqual(analysis.dictionary["teneo"]?.forms["tenuit"], 1, "Should find 'seize' verb")
        XCTAssertEqual(analysis.dictionary["cantabilis"]?.forms["cantabiles"], 1, "Should find 'sung' reference")
    }
    
    func testPsalm118ZainLines7and8() {
        let line7 = psalm118Zain[6]
        let line8 = psalm118Zain[7]
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("memor", ["memor"], "mindful"),
            ("nomen", ["nominis"], "name"),
            ("custodio", ["custodivi"], "keep"),
            ("lex", ["legem"], "law"),
            ("justificatio", ["justificationes", "justificationes"], "ordinances"),
            ("exquiro", ["exquisivi"], "seek diligently")
        ]
        
        if verbose {
            print("\nPSALM 118 ZAIN:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Nocturnal Devotion: memor fui (I remembered) + nocte (at night)")
            print("2. Covenant Fidelity: custodivi (I kept) + legem (law)")
            print("3. Diligent Pursuit: exquisivi (I sought) + justificationes (ordinances)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["custodio"]?.forms["custodivi"], 1, "Should find 'keep' verb")
        XCTAssertNotNil(analysis.dictionary["nomen"], "Should find 'name' reference")
        XCTAssertEqual(analysis.dictionary["exquiro"]?.forms["exquisivi"], 1, "Should find 'seek diligently' verb")
    }
    
    // MARK: - Thematic Tests
    func testDivinePromiseTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Zain)
        
        let terms = [
            ("memor", ["memor", "memor"], "remember"),
            ("verbum", ["verbi" ], "word"),
            ("spes", ["spem"], "hope"),
            ("consolor", ["consolata", "consolatus"], "comfort")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testCovenantFaithfulnessTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Zain)
        
        let terms = [
            ("custodio", ["custodivi"], "guard"),
            ("declino", ["declinavi"], "turn aside"),
            ("exquiro", ["exquisivi"], "seek"),
            ("derelinquo", ["derelinquentibus"], "forsake")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testSpiritualStruggleTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Zain)
        
        let terms = [
            ("humilitas", ["humilitate"], "affliction"),
            ("defectio", ["defectio"], "fainting"),
            ("superbus", ["superbi"], "arrogant"),
            ("peccator", ["peccatoribus"], "sinner")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testTorahDelightTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Zain)
        
        let terms = [
            ("justificatio", ["justificationes", "justificationes"], "ordinance"),
            ("cantabilis", ["cantabiles"], "sung"),
            ("judicium", ["judiciorum"], "judgment"),
            ("lex", ["lege", "legem", "legem"], "law")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    // MARK: - Helper
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
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}