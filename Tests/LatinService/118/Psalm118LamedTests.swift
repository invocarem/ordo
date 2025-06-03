import XCTest
@testable import LatinService

class Psalm118LamedTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "lamed")
    
    // MARK: - Test Data (Psalm 118:89-96 "Lamed" category)
    let psalm118Lamed = [
        "In aeternum, Domine, verbum tuum permanet in caelo.",
        "In generationem et generationem veritas tua; fundasti terram, et permanet.",
        "Ordinatione tua perseverat dies, quoniam omnia serviunt tibi.",
        "Nisi quod lex tua meditatio mea est, tunc forte periissem in humilitate mea.",
        "In aeternum non obliviscar justificationes tuas, quia in ipsis vivificasti me.",
        "Tuus sum ego, salvum me fac, quoniam justificationes tuas exquisivi.",
        "Me exspectaverunt peccatores ut perderent me; testimonia tua intellexi.",
        "Omnis consummationis vidi finem, latum mandatum tuum nimis."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118LamedLines1and2() {
        let line1 = psalm118Lamed[0] // "In aeternum, Domine, verbum tuum permanet in caelo."
        let line2 = psalm118Lamed[1] // "In generationem et generationem veritas tua; fundasti terram, et permanet."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("aeternum", ["aeternum"], "eternity"),
            ("verbum", ["verbum"], "word"),
            ("permaneo", ["permanet"], "endure"),
            ("caelum", ["caelo"], "heaven"),
            ("generatio", ["generationem", "generationem"], "generation"),
            ("veritas", ["veritas"], "truth"),
            ("fundo", ["fundasti"], "establish"),
            ("terra", ["terram"], "earth")
        ]
        
        if verbose {
            print("\nPSALM 118 LAMED:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Eternal Word: aeternum (eternity) + verbum (word) + permanet (endures)")
            print("2. Creation: fundasti (established) + terram (earth)")
            print("3. Enduring Truth: veritas (truth) + permanet (endures)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["verbum"]?.forms["verbum"], 1, "Should find 'word' reference")
        XCTAssertNotNil(analysis.dictionary["permaneo"], "Should find 'endure' verb")
        XCTAssertNotNil(analysis.dictionary["veritas"], "Should find 'truth' reference")
    }
    
    func testPsalm118LamedLines3and4() {
        let line3 = psalm118Lamed[2] // "Ordinatione tua perseverat dies, quoniam omnia serviunt tibi."
        let line4 = psalm118Lamed[3] // "Nisi quod lex tua meditatio mea est, tunc forte periissem in humilitate mea."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("ordinatio", ["ordinatione"], "ordinance"),
            ("persevero", ["perseverat"], "persevere"),
            ("dies", ["dies"], "day"),
            ("servio", ["serviunt"], "serve"),
            ("lex", ["lex"], "law"),
            ("meditatio", ["meditatio"], "meditation"),
            ("pereo", ["periissem"], "perish"),
            ("humilitas", ["humilitate"], "humility")
        ]
        
        if verbose {
            print("\nPSALM 118 LAMED:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Order: ordinatione (ordinance) + perseverat (perseveres)")
            print("2. Service to God: serviunt (serve) + tibi (you)")
            print("3. Law as Refuge: lex (law) + meditatio (meditation) prevents perishing")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["lex"]?.forms["lex"], 1, "Should find 'law' reference")
        XCTAssertNotNil(analysis.dictionary["meditatio"], "Should find 'meditation' reference")
        XCTAssertNotNil(analysis.dictionary["pereo"], "Should find 'perish' verb")
    }
    
    func testPsalm118LamedLines5and6() {
        let line5 = psalm118Lamed[4] // "In aeternum non obliviscar justificationes tuas, quia in ipsis vivificasti me."
        let line6 = psalm118Lamed[5] // "Tuus sum ego, salvum me fac, quoniam justificationes tuas exquisivi."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("obliviscor", ["obliviscar"], "forget"),
            ("justificatio", ["justificationes", "justificationes"], "ordinances"),
            ("vivifico", ["vivificasti"], "give life"),
            ("tuus", ["tuus"], "yours"),
            ("salvo", ["salvum"], "save"),
            ("exquiro", ["exquisivi"], "seek diligently")
        ]
        
        if verbose {
            print("\nPSALM 118 LAMED:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Eternal Memory: aeternum (eternity) + non obliviscar (will not forget)")
            print("2. Life in Ordinances: vivificasti (gave life) + justificationes (ordinances)")
            print("3. Personal Relationship: tuus (yours) + salvum me fac (save me)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["justificatio"]?.forms["justificationes"], 2, "Should find 'ordinances' references")
        XCTAssertNotNil(analysis.dictionary["vivifico"], "Should find 'give life' verb")
        XCTAssertNotNil(analysis.dictionary["exquiro"], "Should find 'seek diligently' verb")
    }
    
    func testPsalm118LamedLines7and8() {
        let line7 = psalm118Lamed[6] // "Me exspectaverunt peccatores ut perderent me; testimonia tua intellexi."
        let line8 = psalm118Lamed[7] // "Omnis consummationis vidi finem, latum mandatum tuum nimis."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("exspecto", ["exspectaverunt"], "lie in wait"),
            ("peccator", ["peccatores"], "sinners"),
            ("perdo", ["perderent"], "destroy"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("intellego", ["intellexi"], "understand"),
            ("consummatio", ["consummationis"], "perfection"),
            ("finis", ["finem"], "end"),
            ("latus", ["latum"], "broad"),
            ("mandatum", ["mandatum"], "commandment")
        ]
        
        if verbose {
            print("\nPSALM 118 LAMED:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Opposition: peccatores (sinners) + perderent (destroy)")
            print("2. Understanding: intellexi (understood) + testimonia (testimonies)")
            print("3. Boundless Command: latum (broad) + mandatum (commandment)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["testimonium"]?.forms["testimonia"], 1, "Should find 'testimonies' reference")
        XCTAssertNotNil(analysis.dictionary["consummatio"], "Should find 'perfection' reference")
        XCTAssertNotNil(analysis.dictionary["mandatum"], "Should find 'commandment' reference")
    }
    
    // MARK: - Thematic Tests
    func testEternityTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Lamed)
        
        let eternityTerms = [
            ("aeternum", ["aeternum"], "eternity"), // v.1, v.5
            ("permaneo", ["permanet"], "endure"), // v.1, v.2
            ("persevero", ["perseverat"], "persevere") // v.3
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: eternityTerms)
    }
    
    func testDivineWordTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Lamed)
        
        let wordTerms = [
            ("verbum", ["verbum"], "word"), // v.1
            ("lex", ["lex"], "law"), // v.4
            ("testimonium", ["testimonia"], "testimonies"), // v.7
            ("mandatum", ["mandatum"], "commandment") // v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: wordTerms)
    }
    
    func testSalvationTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Lamed)
        
        let salvationTerms = [
            ("vivifico", ["vivificasti"], "give life"), // v.5
            ("salvo", ["salvum"], "save"), // v.6
            ("intellego", ["intellexi"], "understand") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: salvationTerms)
    }
    
    func testOppositionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Lamed)
        
        let oppositionTerms = [
            ("pereo", ["periissem"], "perish"), // v.4
            ("peccator", ["peccatores"], "sinners"), // v.7
            ("perdo", ["perderent"], "destroy") // v.7
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: oppositionTerms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage
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