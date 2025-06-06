import XCTest
@testable import LatinService

class Psalm118MemTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "mem")
    
    // MARK: - Test Data (Psalm 118:97-104 "Mem" category)
    let psalm118Mem = [
        "Quomodo dilexi legem tuam, Domine! tota die meditatio mea est.",
        "Super inimicos meos prudentem me fecisti mandato tuo, quia in aeternum mihi est.",
        "Super omnes docentes me intellexi, quia testimonia tua meditatio mea est.",
        "Super senes intellexi, quia mandata tua quaesivi.",
        "In omni via mala prohibui pedes meos, ut custodiam verba tua.",
        "A judiciis tuis non declinavi, quia tu legem posuisti mihi.",
        "Quam dulcia faucibus meis eloquia tua! super mel ori meo.",
        "A mandatis tuis intellexi, propterea odivi omnem viam iniquitatis."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118MemLines1and2() {
        let line1 = psalm118Mem[0] // "Quomodo dilexi legem tuam, Domine! tota die meditatio mea est."
        let line2 = psalm118Mem[1] // "Super inimicos meos prudentem me fecisti mandato tuo, quia in aeternum mihi est."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("diligo", ["dilexi"], "love"),
            ("lex", ["legem"], "law"),
            ("meditatio", ["meditatio"], "meditation"),
            ("inimicus", ["inimicos"], "enemies"),
            ("prudens", ["prudentem"], "prudent"),
            ("mandatum", ["mandato"], "commandment"),
            ("aeternum", ["aeternum"], "eternity")
        ]
        
        if verbose {
            print("\nPSALM 118 MEM:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Love for God's Law: dilexi (loved) + legem (law)")
            print("2. Transformative Commandments: prudentem (prudent) + mandato (commandment)")
            print("3. Constant Meditation: tota die (all day) + meditatio (meditation)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["diligo"]?.forms["dilexi"], 1, "Should find 'love' reference")
        XCTAssertNotNil(analysis.dictionary["prudens"], "Should find 'prudent' reference")
        XCTAssertNotNil(analysis.dictionary["mandatum"], "Should find 'commandment' reference")
    }
    
    func testPsalm118MemLines3and4() {
        let line3 = psalm118Mem[2] // "Super omnes docentes me intellexi, quia testimonia tua meditatio mea est."
        let line4 = psalm118Mem[3] // "Super senes intellexi, quia mandata tua quaesivi."
        let combinedText = line3 + " " + line4

        latinService.configureDebugging(target: "doceo")
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("doceo", ["docentes"], "teach"),
            ("intellego", ["intellexi", "intellexi"], "understand"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("senex", ["senes"], "elder"),
            ("quaero", ["quaesivi"], "seek"),
            ("mandatum", ["mandata"], "commandments")
        ]
        
        if verbose {
            print("\nPSALM 118 MEM:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Superior Understanding: super (above) + intellexi (understood)")
            print("2. Testimonies as Meditation: testimonia (testimonies) + meditatio (meditation)")
            print("3. Seeking Commandments: quaesivi (sought) + mandata (commandments)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["intellego"]?.forms["intellexi"], 2, "Should find 'understand' references")
        XCTAssertNotNil(analysis.dictionary["testimonium"], "Should find 'testimonies' reference")
        XCTAssertNotNil(analysis.dictionary["quaero"], "Should find 'seek' verb")
    }
    
    func testPsalm118MemLines5and6() {
        let line5 = psalm118Mem[4] // "In omni via mala prohibui pedes meos, ut custodiam verba tua."
        let line6 = psalm118Mem[5] // "A judiciis tuis non declinavi, quia tu legem posuisti mihi."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("via", ["via"], "way"),
            ("malus", ["mala"], "evil"),
            ("prohibeo", ["prohibui"], "restrain"),
            ("custodio", ["custodiam"], "keep"),
            ("verbum", ["verba"], "words"),
            ("judicium", ["judiciis"], "judgments"),
            ("declino", ["declinavi"], "turn aside"),
            ("pono", ["posuisti"], "set")
        ]
        
        if verbose {
            print("\nPSALM 118 MEM:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Path Avoidance: via (way) + prohibui (restrained) + mala (evil)")
            print("2. Faithful Obedience: non declinavi (did not turn aside) + judiciis (judgments)")
            print("3. Divine Initiative: posuisti (you set) + legem (law)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["prohibeo"]?.forms["prohibui"], 1, "Should find 'restrain' reference")
        XCTAssertNotNil(analysis.dictionary["declino"], "Should find 'turn aside' verb")
        XCTAssertNotNil(analysis.dictionary["pono"], "Should find 'set' verb")
    }
    
    func testPsalm118MemLines7and8() {
        let line7 = psalm118Mem[6] // "Quam dulcia faucibus meis eloquia tua! super mel ori meo."
        let line8 = psalm118Mem[7] // "A mandatis tuis intellexi, propterea odivi omnem viam iniquitatis."
        let combinedText = line7 + " " + line8
        latinService.configureDebugging(target: "odi")
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("dulcis", ["dulcia"], "sweet"),
            ("faux", ["faucibus"], "mouth"),
            ("eloquium", ["eloquia"], "words"),
            ("mel", ["mel"], "honey"),
            ("os", ["ori"], "mouth"),
            ("intellego", ["intellexi"], "understand"),
            ("odi", ["odivi"], "hate"),
            ("iniquitas", ["iniquitatis"], "iniquity")
        ]
        
        if verbose {
            print("\nPSALM 118 MEM:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Sensory Delight: dulcia (sweet) + eloquia (words) + mel (honey)")
            print("2. Understanding Leading to Rejection: intellexi (understood) + odivi (hated)")
            print("3. Radical Rejection: odivi (hated) + iniquitatis (iniquity)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["dulcis"]?.forms["dulcia"], 1, "Should find 'sweet' reference")
        XCTAssertNotNil(analysis.dictionary["odi"], "Should find 'hate' verb")
        XCTAssertNotNil(analysis.dictionary["iniquitas"], "Should find 'iniquity' reference")
    }
    
    // MARK: - Thematic Tests
    func testLoveForLawTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Mem)
        
        let loveTerms = [
            ("diligo", ["dilexi"], "love"),
            ("meditatio", ["meditatio", "meditatio"], "meditation"),
            ("quaero", ["quaesivi"], "seek"),
            ("custodio", ["custodiam"], "keep")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: loveTerms)
    }
    
    func testUnderstandingTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Mem)
        
        let understandingTerms = [
            ("intellego", ["intellexi", "intellexi", "intellexi"], "understand"),
            ("prudens", ["prudentem"], "prudent"),
            ("testimonium", ["testimonia"], "testimonies"),
            ("judicium", ["judiciis"], "judgments")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: understandingTerms)
    }
    
    func testSensoryDelightTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Mem)
        
        let sensoryTerms = [
            ("dulcis", ["dulcia"], "sweet"),
            ("eloquium", ["eloquia"], "words"),
            ("mel", ["mel"], "honey"),
            ("os", ["ori"], "mouth")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sensoryTerms)
    }
    
    func testRejectionOfEvilTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Mem)
        
        let rejectionTerms = [
            ("prohibeo", ["prohibui"], "restrain"),
            ("declino", ["declinavi"], "turn aside"),
            ("odi", ["odivi"], "hate"),
            ("iniquitas", ["iniquitatis"], "iniquity")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rejectionTerms)
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
