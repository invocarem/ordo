import XCTest
@testable import LatinService

class Psalm118NunTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "nun")
    
    // MARK: - Test Data (Psalm 118:105-112 "Nun" category)
    let psalm118Nun = [
        "Lucerna pedibus meis verbum tuum, et lumen semitis meis.",
        "Juravi et statui custodire judicia justitiae tuae.",
        "Humiliatus sum usquequaque, Domine, vivifica me secundum verbum tuum.",
        "Voluntaria oris mei beneplacita fac, Domine, et judicia tua doce me.",
        "Anima mea in manibus tuis semper, et legem tuam non sum oblitus.",
        "Posuerunt peccatores laqueum mihi, et de mandatis tuis non erravi.",
        "Hereditate acquisivi testimonia tua in aeternum, quia exsultatio cordis mei sunt.",
        "Inclinavi cor meum ad faciendas justificationes tuas in aeternum, propter retributionem."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118NunLines1and2() {
        let line1 = psalm118Nun[0]
        let line2 = psalm118Nun[1]
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("lucerna", ["lucerna"], "lamp"),
            ("lumen", ["lumen"], "light"),
            ("verbum", ["verbum"], "word"),
            ("juro", ["juravi"], "swear"),
            ("statuo", ["statui"], "determine"),
            ("custodio", ["custodire"], "keep"),
            ("judicium", ["judicia"], "judgments")
        ]
        
        if verbose {
            print("\nPSALM 118 NUN:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Guidance: lucerna (lamp) + lumen (light) + semitis (paths)")
            print("2. Sacred Commitment: juravi (swore) + statui (determined)")
            print("3. Covenant Obedience: custodire (to keep) + judicia (judgments)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["lucerna"], "Should find 'lamp' reference")
        XCTAssertEqual(analysis.dictionary["juro"]?.forms["juravi"], 1, "Should find 'swear' verb")
        XCTAssertNotNil(analysis.dictionary["judicium"], "Should find 'judgments' reference")
    }
    
    func testPsalm118NunLines3and4() {
        let line3 = psalm118Nun[2]
        let line4 = psalm118Nun[3]
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("humilio", ["humiliatus"], "humbled"),
            ("vivifico", ["vivifica"], "revive"),
            ("voluntarius", ["voluntaria"], "voluntary"),
            ("os", ["oris"], "mouth"),
            ("beneplacitum", ["beneplacita"], "pleasing"),
            ("doceo", ["doce"], "teach")
        ]
        
        if verbose {
            print("\nPSALM 118 NUN:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Humble Petition: humiliatus (humbled) + vivifica (revive me)")
            print("2. Sacrificial Offering: voluntaria (voluntary offerings) + beneplacita (pleasing)")
            print("3. Teachable Spirit: doce me (teach me) + judicia tua (your judgments)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["humilio"]?.forms["humiliatus"], 1, "Should find 'humbled' verb")
        XCTAssertNotNil(analysis.dictionary["voluntarius"], "Should find 'voluntary' reference")
        XCTAssertEqual(analysis.dictionary["doceo"]?.forms["doce"], 1, "Should find 'teach' verb")
    }
    
    func testPsalm118NunLines5and6() {
        let line5 = psalm118Nun[4]
        let line6 = psalm118Nun[5]
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("anima", ["anima"], "soul"),
            ("manus", ["manibus"], "hands"),
            ("lex", ["legem"], "law"),
            ("obliviscor", ["oblitus"], "forget"),
            ("peccator", ["peccatores"], "sinners"),
            ("laqueus", ["laqueum"], "snare"),
            ("erro", ["erravi"], "stray")
        ]
        
        if verbose {
            print("\nPSALM 118 NUN:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Trustful Surrender: anima mea (my soul) + in manibus tuis (in your hands)")
            print("2. Covenant Memory: non sum oblitus (I have not forgotten) + legem tuam (your law)")
            print("3. Steadfast Obedience: non erravi (I did not stray) + de mandatis tuis (from your commands)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["manus"], "Should find 'hands' reference")
        XCTAssertEqual(analysis.dictionary["obliviscor"]?.forms["oblitus"], 1, "Should find 'forget' verb")
        XCTAssertEqual(analysis.dictionary["erro"]?.forms["erravi"], 1, "Should find 'stray' verb")
    }
    
    func testPsalm118NunLines7and8() {
        let line7 = psalm118Nun[6]
        let line8 = psalm118Nun[7]
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("hereditas", ["hereditate"], "inheritance"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("aeternum", ["aeternum", "aeternum"], "eternal"),
            ("exsultatio", ["exsultatio"], "joy"),
            ("inclino", ["inclinavi"], "incline"),
            ("justificatio", ["justificationes"], "ordinances"),
            ("retributio", ["retributionem"], "reward")
        ]
        
        if verbose {
            print("\nPSALM 118 NUN:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Eternal Inheritance: hereditate (inheritance) + in aeternum (forever)")
            print("2. Heartfelt Joy: exsultatio cordis (joy of heart) + testimonia (testimonies)")
            print("3. Wholehearted Commitment: inclinavi cor meum (I incline my heart) + justificationes (ordinances)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["hereditas"], "Should find 'inheritance' reference")
        XCTAssertEqual(analysis.dictionary["exsultatio"]?.forms["exsultatio"], 1, "Should find 'joy' noun")
        XCTAssertEqual(analysis.dictionary["inclino"]?.forms["inclinavi"], 1, "Should find 'incline' verb")
    }
    
    // MARK: - Thematic Tests
    func testDivineGuidanceTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Nun)
        
        let terms = [
            ("lucerna", ["lucerna"], "lamp"),
            ("lumen", ["lumen"], "light"),
            ("verbum", ["verbum", "verbum"], "word"),
            ("semita", ["semitis"], "path")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testCovenantCommitmentTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Nun)
        
        let terms = [
            ("juro", ["juravi"], "swear"),
            ("statuo", ["statui"], "determine"),
            ("custodio", ["custodire"], "keep"),
            ("obliviscor", ["oblitus"], "forget")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testSoulProtectionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Nun)
        
        let terms = [
            ("anima", ["anima"], "soul"),
            ("manus", ["manibus"], "hands"),
            ("laqueus", ["laqueum"], "snare"),
            ("erro", ["erravi"], "stray")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testEternalInheritanceTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Nun)
        
        let terms = [
            ("hereditas", ["hereditate"], "inheritance"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("aeternum", ["aeternum", "aeternum"], "eternal"),
            ("retributio", ["retributionem"], "reward")
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