import XCTest
@testable import LatinService

class Psalm118DalethTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 118, category: "daleth")
    
    // MARK: - Test Data (Psalm 118:25-32 "Daleth" category)
    let psalm118Daleth = [
        "Adhaesit pavimento anima mea, vivifica me secundum verbum tuum.",
        "Vias meas enuntiavi, et exaudisti me; doce me justificationes tuas.",
        "Viam justificationum tuarum instrue me, et exercebor in mirabilibus tuis.",
        "Dormitavit anima mea prae taedio, confirma me in verbis tuis.",
        "Viam iniquitatis amove a me, et de lege tua miserere mei.",
        "Viam veritatis elegi, judicia tua non sum oblitus.",
        "Adhaesi testimoniis tuis, Domine, noli me confundere.",
        "Viam mandatorum tuorum cucurri, cum dilatasti cor meum."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
    func testPsalm118DalethLines1and2() {
        let line1 = psalm118Daleth[0] // "Adhaesit pavimento anima mea, vivifica me secundum verbum tuum."
        let line2 = psalm118Daleth[1] // "Vias meas enuntiavi, et exaudisti me; doce me justificationes tuas."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("adhaereo", ["adhaesit", "adhaesi"], "cling"),
            ("pavimentum", ["pavimento"], "dust"),
            ("anima", ["anima"], "soul"),
            ("vivifico", ["vivifica"], "give life"),
            ("verbum", ["verbum"], "word"),
            ("via", ["vias"], "way"),
            ("enuntio", ["enuntiavi"], "declare"),
            ("exaudio", ["exaudisti"], "hear"),
            ("doceo", ["doce"], "teach"),
            ("justificatio", ["justificationes"], "ordinance")
        ]
        
        if verbose {
            print("\nPSALM 118 DALETH:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Soul's Desperation: adhaesit (clung) + pavimento (dust)")
            print("2. Divine Revival: vivifica (revive) + verbum tuum (your word)")
            print("3. Prayer Response: enuntiavi (declared) + exaudisti (heard)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["adhaereo"], "Should find 'cling' reference")
        XCTAssertNotNil(analysis.dictionary["pavimentum"], "Should find 'dust' reference")
        XCTAssertEqual(analysis.dictionary["vivifico"]?.forms["vivifica"], 1, "Should find 'revive' verb")
    }
    
    func testPsalm118DalethLines3and4() {
        let line3 = psalm118Daleth[2] // "Viam justificationum tuarum instrue me, et exercebor in mirabilibus tuis."
        let line4 = psalm118Daleth[3] // "Dormitavit anima mea prae taedio, confirma me in verbis tuis."
        let combinedText = line3 + " " + line4
        latinService.configureDebugging(target: "exerceor")
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("instruo", ["instrue"], "instruct"),
            ("justificatio", ["justificationum"], "ordinance"),
            ("exerceo", ["exercebor"], "exercise"),
            ("mirabile", ["mirabilibus"], "wonder"),
            ("dormito", ["dormitavit"], "be sleepy"),
            ("taedium", ["taedio"], "weariness"),
            ("anima", ["anima"], "soul"),
            ("confirmo", ["confirma"], "strengthen"),
            ("verbum", ["verbis"], "word")
        ]
        
        if verbose {
            print("\nPSALM 118 DALETH:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Guided Obedience: instrue (instruct) + justificationum (ordinances)")
            print("2. Spiritual Exhaustion: dormitavit (grew faint) + taedio (weariness)")
            print("3. Divine Sustenance: confirma (strengthen) + verbis tuis (your words)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["dormito"], "Should find 'be sleepy' reference")
        XCTAssertEqual(analysis.dictionary["confirmo"]?.forms["confirma"], 1, "Should find 'strengthen' verb")
        XCTAssertNotNil(analysis.dictionary["taedium"], "Should find 'weariness' reference")
    }
    
    func testPsalm118DalethLines5and6() {
        let line5 = psalm118Daleth[4] // "Viam iniquitatis amove a me, et de lege tua miserere mei."
        let line6 = psalm118Daleth[5] // "Viam veritatis elegi, judicia tua non sum oblitus."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("iniquitas", ["iniquitatis"], "iniquity"),
            ("amoveo", ["amove"], "remove"),
            ("lex", ["lege"], "law"),
            ("misereor", ["miserere"], "have mercy"),
            ("veritas", ["veritatis"], "truth"),
            ("eligo", ["elegi"], "choose"),
            ("judicium", ["judicia"], "judgment"),
            ("obliviscor", ["oblitus"], "forget")
        ]
        
        if verbose {
            print("\nPSALM 118 DALETH:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Moral Cleansing: amove (remove) + iniquitatis (iniquity)")
            print("2. Covenant Mercy: miserere (have mercy) + lege tua (your law)")
            print("3. Deliberate Choice: elegi (chose) + veritatis (truth)")
        }
        
        // Key assertions
        XCTAssertNotNil(analysis.dictionary["amoveo"], "Should find 'remove' verb")
        XCTAssertNotNil(analysis.dictionary["veritas"], "Should find 'truth' reference")
        XCTAssertEqual(analysis.dictionary["eligo"]?.forms["elegi"], 1, "Should find 'chose' verb")
    }
    
    func testPsalm118DalethLines7and8() {
        let line7 = psalm118Daleth[6] // "Adhaesi testimoniis tuis, Domine, noli me confundere."
        let line8 = psalm118Daleth[7] // "Viam mandatorum tuorum cucurri, cum dilatasti cor meum."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("adhaereo", ["adhaesi"], "cling"),
            ("testimonium", ["testimoniis"], "testimony"),
            ("confundo", ["confundere"], "shame"),
            ("curro", ["cucurri"], "run"),
            ("dilato", ["dilatasti"], "enlarge")
        ]
        
        if verbose {
            print("\nPSALM 118 DALETH:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Covenant Faithfulness: adhaesi (clung) + testimoniis (testimonies)")
            print("2. Energetic Obedience: cucurri (ran) + mandatorum (commandments)")
            print("3. Divine Empowerment: dilatasti (enlarged) + cor (heart)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["adhaereo"]?.forms["adhaesi"], 1, "Should find 'clung' verb")
        XCTAssertNotNil(analysis.dictionary["dilato"], "Should find 'enlarge' verb")
        XCTAssertEqual(analysis.dictionary["curro"]?.forms["cucurri"], 1, "Should find 'ran' reference")
    }
    
    // MARK: - Thematic Tests
    func testSpiritualCrisisTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Daleth)
        
        let terms = [
            ("pavimentum", ["pavimento"], "pavement"),
            ("dormito", ["dormitavit"], "slumber"),
            ("taedium", ["taedio"], "weariness"),
            ("confundo", ["confundere"], "confuse")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testDivineInterventionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Daleth)
        
        let terms = [
            ("vivifico", ["vivifica"], "give life"),
            ("exaudio", ["exaudisti"], "hear"),
            ("confirmo", ["confirma"], "strengthen"),
            ("dilato", ["dilatasti"], "enlarge")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testCovenantPathTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Daleth)
        
        let terms = [
            ("via", ["viam", "vias"], "way"),
            ("veritas", ["veritatis"], "truth"),
            ("mandatum", ["mandatorum"], "commandment"),
            ("testimonium", ["testimoniis"], "testimony")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testActiveFaithTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Daleth)
        
        let terms = [
            ("enuntio", ["enuntiavi"], "declare"),
            ("eligo", ["elegi"], "choose"),
            ("curro", ["cucurri"], "run"),
            ("exerceo", ["exercebor"], "exercise")
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