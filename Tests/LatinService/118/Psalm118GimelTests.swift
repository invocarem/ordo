import XCTest
@testable import LatinService

class Psalm118GimelTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "gimel")
    
    // MARK: - Test Data (Psalm 118:17-24 "Gimel" category)
    let psalm118Gimel = [
        "Retribue servo tuo, vivifica me, et custodiam sermones tuos.",
        "Revela oculos meos, et considerabo mirabilia de lege tua.",
        "Incola ego sum in terra, non abscondas a me mandata tua.",
        "Concupivit anima mea desiderare justificationes tuas in omni tempore.",
        "Increpasti superbos, maledicti qui declinant a mandatis tuis.",
        "Aufer a me opprobrium et contemptum, quia testimonia tua exquisivi.",
        "Etenim sederunt principes, et adversum me loquebantur; servus autem tuus exercebatur in justificationibus tuis.",
        "Nam et testimonia tua meditatio mea est, et consilium meum justificationes tuae."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118GimelLines1and2() {
        let line1 = psalm118Gimel[0] // "Retribue servo tuo, vivifica me, et custodiam sermones tuos."
        let line2 = psalm118Gimel[1] // "Revela oculos meos, et considerabo mirabilia de lege tua."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("retribuo", ["retribue"], "repay"),
            ("servus", ["servo"], "servant"),
            ("vivifico", ["vivifica"], "give life"),
            ("custodio", ["custodiam"], "keep"),
            ("sermo", ["sermones"], "word"),
            ("revelo", ["revela"], "disclose"),
            ("oculus", ["oculos"], "eye"),
            ("considero", ["considerabo"], "consider"),
            ("mirabile", ["mirabilia"], "wonder"),
            ("lex", ["lege"], "law")
        ]
        
        if verbose {
            print("\nPSALM 118 GIMEL:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine-Human Exchange: retribue (repay) + servo tuo (your servant)")
            print("2. Spiritual Perception: revela (open) + oculos (eyes) + mirabilia (wonders)")
            print("3. Life in Obedience: vivifica (give life) + custodiam (I will keep)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["vivifico"]?.forms["vivifica"], 1, "Should find 'give life' reference")
        XCTAssertNotNil(analysis.dictionary["revelo"], "Should find 'disclose' verb")
        XCTAssertNotNil(analysis.dictionary["mirabile"], "Should find 'wonders' reference")
    }
    
    func testPsalm118GimelLines3and4() {
        let line3 = psalm118Gimel[2] // "Incola ego sum in terra, non abscondas a me mandata tua."
        let line4 = psalm118Gimel[3] // "Concupivit anima mea desiderare justificationes tuas in omni tempore."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("incola", ["incola"], "sojourner"),
            ("terra", ["terra"], "earth"),
            ("abscondo", ["abscondas"], "hide"),
            ("mandatum", ["mandata"], "commandments"),
            ("concupisco", ["concupivit"], "long"),
            ("anima", ["anima"], "soul"),
            ("desidero", ["desiderare"], "desire"),
            ("justificatio", ["justificationes"], "ordinance"),
            ("tempus", ["tempore"], "time")
        ]
        
        if verbose {
            print("\nPSALM 118 GIMEL:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Earthly Pilgrimage: incola (sojourner) + terra (earth)")
            print("2. Divine Disclosure: non abscondas (do not hide) + mandata (commandments)")
            print("3. Soul's Longing: concupivit (longed) + anima (soul) + desiderare (desire)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["justificatio"]?.forms["justificationes"], 1, "Should find 'ordinances' reference")
        XCTAssertNotNil(analysis.dictionary["incola"], "Should find 'sojourner' reference")
        XCTAssertNotNil(analysis.dictionary["concupisco"], "Should find 'long' verb")
    }
    
    func testPsalm118GimelLines5and6() {
        let line5 = psalm118Gimel[4] // "Increpasti superbos, maledicti qui declinant a mandatis tuis."
        let line6 = psalm118Gimel[5] // "Aufer a me opprobrium et contemptum, quia testimonia tua exquisivi."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("increpo", ["increpasti"], "rebuke"),
            ("superbus", ["superbos"], "proud"),
            ("maledictus", ["maledicti"], "cursed"),
            ("declino", ["declinant"], "turn aside"),
            ("mandatum", ["mandatis"], "commandments"),
            ("aufero", ["aufer"], "remove"),
            ("opprobrium", ["opprobrium"], "reproach"),
            ("contemptus", ["contemptum"], "contempt"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("exquiro", ["exquisivi"], "seek diligently")
        ]
        
        if verbose {
            print("\nPSALM 118 GIMEL:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Judgment: increpasti (rebuked) + superbos (proud)")
            print("2. Protection from Shame: aufer (remove) + opprobrium (reproach)")
            print("3. Covenant Loyalty: exquisivi (sought) + testimonia (testimonies)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["testimonium"]?.forms["testimonia"], 1, "Should find 'testimonies' reference")
        XCTAssertNotNil(analysis.dictionary["increpo"], "Should find 'rebuke' verb")
        XCTAssertNotNil(analysis.dictionary["opprobrium"], "Should find 'reproach' reference")
    }
    
    func testPsalm118GimelLines7and8() {
        let line7 = psalm118Gimel[6] // "Etenim sederunt principes, et adversum me loquebantur; servus autem tuus exercebatur in justificationibus tuis."
        let line8 = psalm118Gimel[7] // "Nam et testimonia tua meditatio mea est, et consilium meum justificationes tuae."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("princeps", ["principes"], "princes"),
            ("adversus", ["adversum"], "against"),
            ("loquor", ["loquebantur"], "speak"),
            ("servus", ["servus"], "servant"),
            ("exerceo", ["exercebatur"], "exercise"),
            ("justificatio", ["justificationibus", "justificationes"], "ordinance"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("meditatio", ["meditatio"], "meditation"),
            ("consilium", ["consilium"], "counsel")
        ]
        
        if verbose {
            print("\nPSALM 118 GIMEL:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Opposition from Power: principes (princes) + adversum (against)")
            print("2. Faithful Obedience: servus (servant) + exercebatur (exercised)")
            print("3. Meditation on Truth: meditatio (meditation) + testimonia (testimonies)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["justificatio"]?.forms["justificationes"], 1, "Should find 'ordinances' reference")
        XCTAssertNotNil(analysis.dictionary["exerceo"], "Should find 'exercise' verb")
        XCTAssertNotNil(analysis.dictionary["meditatio"], "Should find 'meditation' reference")
    }
    
    // MARK: - Thematic Tests
    func testDivineActionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Gimel)
        
        let terms = [
            ("retribuo", ["retribue"], "repay"),
            ("vivifico", ["vivifica"], "give life"),
            ("revelo", ["revela"], "disclose"),
            ("increpo", ["increpasti"], "rebuke")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testHumanResponseTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Gimel)
        
        let terms = [
            ("custodio", ["custodiam"], "guard"),
            ("considero", ["considerabo"], "consider"),
            ("desidero", ["desiderare"], "desire"),
            ("exquiro", ["exquisivi"], "seek")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testOppositionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Gimel)
        
        let terms = [
            ("superbus", ["superbos"], "proud"),
            ("princeps", ["principes"], "prince"),
            ("adversus", ["adversum"], "against"),
            ("opprobrium", ["opprobrium"], "reproach")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testTorahDelightTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Gimel)
        
        let terms = [
            ("justificatio", ["justificationes", "justificationibus"], "ordinance"),
            ("testimonium", ["testimonia"], "testimony"),
            ("meditatio", ["meditatio"], "meditation"),
            ("mirabile", ["mirabilia"], "wonder")
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