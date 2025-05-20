import XCTest
@testable import LatinService

class Psalm118AlephTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    
    let identity = PsalmIdentity(number: 118, section: "aleph")
    // MARK: - Test Data (Psalm 118:1-8 "Aleph" section)
    let psalm118Aleph = [
        "Beati immaculati in via, qui ambulant in lege Domini.",
        "Beati qui scrutantur testimonia eius, in toto corde exquirunt eum.",
        "Non enim qui operantur iniquitatem, in viis eius ambulaverunt.",
        "Tu mandasti mandata tua custodire nimis.",
        "Utinam dirigantur viae meae ad custodiendas justificationes tuas!",
        "Tunc non confundar, cum perspexero in omnibus mandatis tuis.",
        "Confitebor tibi in directione cordis, in eo quod didici judicia justitiae tuae.",
        "Justificationes tuas custodiam; non me derelinquas usquequaque."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Group Tests
func testPsalm118AlephLines1and2() {
    let line1 = psalm118Aleph[0] // "Beati immaculati in via, qui ambulant in lege Domini."
    let line2 = psalm118Aleph[1] // "Beati qui scrutantur testimonia eius, in toto corde exquirunt eum."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
    
    let testLemmas = [
        ("beatus", ["beati"], "blessed"),
        ("immaculatus", ["immaculati"], "blameless"),
        ("via", ["via"], "way"),
        ("ambulo", ["ambulant"], "walk"),
        ("lex", ["lege"], "law"),
        ("dominus", ["domini"], "Lord"),
        ("scrutor", ["scrutantur"], "search"),
        ("testimonium", ["testimonia"], "testimonies"),
        ("cor", ["corde"], "heart"),
        ("exquiro", ["exquirunt"], "seek")
    ]
    
    if verbose {
        print("\nPSALM 118 ALEPH:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Double Beatitude: beati (blessed) repeated")
        print("2. Torah Obedience: lege (law) + testimonia (testimonies)")
        print("3. Wholeheartedness: toto corde (whole heart)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["beatus"]?.forms["beati"], 2, "Should find two 'blessed' references")
    XCTAssertNotNil(analysis.dictionary["immaculatus"], "Should find blameless reference")
    XCTAssertNotNil(analysis.dictionary["exquiro"], "Should find seeking verb")
}

func testPsalm118AlephLines3and4() {
    let line3 = psalm118Aleph[2] // "Non enim qui operantur iniquitatem, in viis eius ambulaverunt."
    let line4 = psalm118Aleph[3] // "Tu mandasti mandata tua custodire nimis."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
    
    let testLemmas = [
        ("iniquitas", ["iniquitatem"], "iniquity"),
        ("via", ["viis"], "ways"),
        ("ambulo", ["ambulaverunt"], "walk"),
        ("mando", ["mandasti"], "command"),
        ("mandatum", ["mandata"], "commandments"),
        ("custodio", ["custodire"], "keep"),
        ("nimis", ["nimis"], "diligently")
    ]
    
    if verbose {
        print("\nPSALM 118 ALEPH:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Contrast: iniquitatem (iniquity) vs mandata (commandments)")
        print("2. Path Imagery: viis (ways) + ambulaverunt (walked)")
        print("3. Divine Command: mandasti (commanded) + custodire (keep)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["via"]?.forms["viis"], 1, "Should find 'ways' reference")
    XCTAssertNotNil(analysis.dictionary["custodio"], "Should find keeping commandment")
    XCTAssertNotNil(analysis.dictionary["nimis"], "Should find 'diligently' adverb")
}

func testPsalm118AlephLines5and6() {
    let line5 = psalm118Aleph[4] // "Utinam dirigantur viae meae ad custodiendas justificationes tuas!"
    let line6 = psalm118Aleph[5] // "Tunc non confundar, cum perspexero in omnibus mandatis tuis."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
    
    let testLemmas = [
        ("dirigo", ["dirigantur"], "direct"),
        ("via", ["viae"], "ways"),
        ("custodio", ["custodiendas"], "keep"),
        ("justificatio", ["justificationes"], "ordinances"),
        ("confundor", ["confundar"], "ashamed"),
        ("perspicio", ["perspexero"], "look"),
        ("mandatum", ["mandatis"], "commandments")
    ]
    
    if verbose {
        print("\nPSALM 118 ALEPH:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Divine Guidance: dirigantur (directed) + viae (ways)")
        print("2. Obedience Result: non confundar (not ashamed)")
        print("3. Comprehensive Study: omnibus mandatis (all commandments)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["dirigo"]?.forms["dirigantur"], 1, "Should find 'direct' verb")
    XCTAssertNotNil(analysis.dictionary["justificatio"], "Should find ordinances reference")
    XCTAssertNotNil(analysis.dictionary["perspicio"], "Should find 'look' verb")
}

    func testBeatitudeStatements() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Aleph)
        
        let blessedTerms = [
            ("beatus", ["Beati"], "blessed"), // v.1, v.2
            ("immaculatus", ["immaculati"], "blameless"), // v.1
            ("confundor", ["confundar"], "be ashamed") // v.6 (negated)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: blessedTerms)
    }
    
    func testTorahActionVerbs() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Aleph)
        
        let actionVerbs = [
            ("ambulo", ["ambulant", "ambulaverunt"], "walk"), // v.1, v.3
            ("scrutor", ["scrutantur"], "search"), // v.2
            ("custodio", ["custodire", "custodiendas", "custodiam"], "keep") // v.4, v.5, v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: actionVerbs)
    }
    
    func testDivinePrecepts() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Aleph)
        
        let lawTerms = [
            ("lex", ["lege"], "law"), // v.1
            ("testimonium", ["testimonia"], "testimony"), // v.2
            ("mandatum", ["mandata", "mandatis"], "commandment"), // v.4, v.6
            ("justificatio", ["justificationes", "justificationes"], "ordinance") // v.5, v.8
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lawTerms)
    }
    
    func testSpiritualDirection() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Aleph)
        
        let guidanceTerms = [
            ("via", ["via", "viis", "viae"], "way"), // v.1, v.3, v.5
            ("dirigo", ["dirigantur"], "direct"), // v.5
            ("derelinquo", ["derelinquas"], "forsake") // v.8 (negated)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: guidanceTerms)
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