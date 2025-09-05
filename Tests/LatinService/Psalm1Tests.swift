import XCTest
@testable import LatinService

class Psalm1Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let identity = PsalmIdentity(number: 1, category: nil)
    // MARK: - Test Data
    let psalm1 = [
        "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;",
                "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte.",
                "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:",
                "Et folium eius non defluet, et omnia quaecumque faciet, prosperabuntur.",
                "Non sic impii, non sic: sed tamquam pulvis, quem proicit ventus a facie terrae.",
                "Ideo non resurgent impii in iudicio, neque peccatores in concilio iustorum; ",
                "Quoniam novit Dominus viam iustorum: et iter impiorum peribit."    
    ]

    func testPsalm1Lines1and2() {
        let line1 = psalm1[0] // "Beatus vir qui non abiit in consilio impiorum, et in via peccatorum non stetit, et in cathedra pestilentiae non sedit;"
        let line2 = psalm1[1] // "Sed in lege Domini voluntas eius, et in lege eius meditabitur die ac nocte."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
    
    let testLemmas = [
        ("beatus", ["beatus"], "blessed"),
        ("vir", ["vir"], "man"),
        ("abeo", ["abiit"], "go away"),
        ("consilium", ["consilio"], "counsel"),
        ("impius", ["impiorum"], "wicked"),
        ("via", ["via"], "way"),
        ("peccator", ["peccatorum"], "sinner"),
        ("sto", ["stetit"], "stand"),
        ("cathedra", ["cathedra"], "seat"),
        ("pestilentia", ["pestilentiae"], "pestilence"),
        ("sedeo", ["sedit"], "sit"),
        ("lex", ["lege"], "law"),
        ("dominus", ["domini"], "Lord"),
        ("voluntas", ["voluntas"], "will"),
        ("meditor", ["meditabitur"], "meditate"),
        ("dies", ["die"], "day"),
        ("nox", ["nocte"], "night")
    ]
    
    if verbose {
        print("\nPSALM 1:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nDETECTED THEMES:")
        analysis.themes.forEach { theme in
            print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
        }

        print("\nKEY CONTRASTS:")
        print("Negative (v1): abiit (went) → stetit (stood) → sedit (sat)")
        print("Positive (v2): meditabitur (will meditate)")
        print("Locations: consilio (counsel) vs lege (law)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["beatus"]?.forms["beatus"], 1, "Should find 'blessed' opening")
    XCTAssertEqual(analysis.dictionary["lex"]?.forms["lege"], 2, "Should find double 'law' reference")
    
    // Test progression of actions
    let negativeActions = ["abiit", "stetit", "sedit"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(negativeActions.filter { $0 }.count, 3, "Should find all three negative actions")
    
    // Test day/night merism
    XCTAssertNotNil(analysis.dictionary["dies"], "Should detect 'day'")
    XCTAssertNotNil(analysis.dictionary["nox"], "Should detect 'night'")
}

func testPsalm1Lines3and4() {
    let line3 = psalm1[2] // "Et erit tamquam lignum quod plantatum est secus decursus aquarum, quod fructum suum dabit in tempore suo:"
    let line4 = psalm1[3] // "Et folium eius non defluet, et omnia quaecumque faciet prosperabuntur."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
    
    let testLemmas = [
        ("lignum", ["lignum"], "tree"),
        ("planto", ["plantatum"], "planted"),
        ("secus", ["secus"], "beside"),
        ("decursus", ["decursus"], "course"),
        ("aqua", ["aquarum"], "waters"),
        ("fructus", ["fructum"], "fruit"),
        ("do", ["dabit"], "give"),
        ("tempus", ["tempore"], "time"),
        ("folium", ["folium"], "leaf"),
        ("defluo", ["defluet"], "wither"),
        ("omnis", ["omnia"], "all"),
        ("facio", ["faciet"], "do"),
        ("prospero", ["prosperabuntur"], "prosper")
    ]
    
    if verbose {
        print("\nPSALM 1:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Tree Imagery: plantatum (planted) → fructum (fruit) → folium (leaf)")
        print("2. Water Source: secus decursus aquarum (by streams of water)")
        print("3. Perpetual Vitality: non defluet (won't wither) → prosperabuntur (will prosper)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["lignum"]?.forms["lignum"], 1, "Should find tree reference")
    XCTAssertEqual(analysis.dictionary["aqua"]?.forms["aquarum"], 1, "Should find waters reference")
    
    // Test plant/fruit/leaf sequence
    let plantTerms = ["plantatum", "fructum", "folium"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(plantTerms.filter { $0 }.count, 3, "Should find all three plant parts")
    
    // Test positive outcomes
    let positiveTerms = ["dabit", "defluet", "prosperabuntur"].reduce(0) {
        $0 + (analysis.dictionary["do"]?.forms[$1] ?? 0)
        + (analysis.dictionary["defluo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["prospero"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(positiveTerms, 3, "Should find three positive outcome terms")
}
func testPsalm1Lines5and7() {
    //  "Non sic impii, non sic: sed tamquam pulvis quem proicit ventus a facie terrae.",
    //  "Ideo non resurgent impii in iudicio, neque peccatores in concilio iustorum; quoniam novit Dominus viam iustorum: et iter impiorum peribit."

    let line5 = psalm1[4] 
    let line6 = psalm1[5] 
    let line7 = psalm1[6] 
    let combinedText = line5 + " " + line6 + " " + line7
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
    
    let testLemmas = [
        ("impius", ["impii", "impiorum"], "wicked"),
        ("pulvis", ["pulvis"], "dust"),
        ("proicio", ["proicit"], "scatter"),
        ("ventus", ["ventus"], "wind"),
        ("facies", ["facie"], "face"),
        ("terra", ["terrae"], "earth"),
        ("resurgo", ["resurgent"], "rise up"),
        ("iudicium", ["iudicio"], "judgment"),
        ("peccator", ["peccatores"], "sinner"),
        ("concilium", ["concilio"], "assembly"),
        ("iustus", ["iustorum", "iustorum"], "righteous"),
        ("nosco", ["novit"], "know"),
        ("dominus", ["dominus"], "Lord"),
        ("via", ["viam"], "way"),
        ("iter", ["iter"], "path"),
        ("pereo", ["peribit"], "perish")
    ]
    
    if verbose {
        print("\nPSALM 1:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY CONTRASTS:")
        print("1. Wicked as Dust: pulvis (dust) vs justorum (righteous)")
        print("2. Final Destiny: resurgent (rise) vs peribit (perish)")
        print("3. Divine Knowledge: novit Dominus (the Lord knows)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["impius"]?.forms["impii"], 2, "Should find two 'wicked' references")
    XCTAssertEqual(analysis.dictionary["iustus"]?.forms["iustorum"], 2, "Should find two 'righteous' references")
    
    // Test dust/wind imagery
    let scatteringTerms = ["pulvis", "proicit", "ventus"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(scatteringTerms.filter { $0 }.count, 3, "Should find all three scattering terms")
    
    // Test final destiny contrast
    let destinyTerms = ["resurgent", "peribit"].reduce(0) {
        $0 + (analysis.dictionary["resurgo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["pereo"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(destinyTerms, 2, "Should find both destiny verbs")
}
    func testTreeMetaphor() {
        let analysis = latinService.analyzePsalm(identity, text: psalm1)
        
        let treeTerms = [
            ("lignum", ["lignum"], "tree"),
            ("planto", ["plantatum"], "plant"),
            ("fructus", ["fructum"], "fruit"),
            ("folium", ["folium"], "leaf"),
            ("defluo", ["defluet"], "wither"),
            ("decursus", ["decursus"], "flow")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: treeTerms)
        
        // Verify water connection
        XCTAssertNotNil(analysis.dictionary["aqua"], "Water imagery missing")
    }
    
    // MARK: - Test Cases
    func testChaffMetaphor() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let chaffMetaphorWords = [
            ("pulvis", ["pulvis"], "dust"),
            ("ventus", ["ventus"], "wind"),
            ("proicio", ["proicit"], "scatter"),
            ("facies", ["facie"], "face")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: chaffMetaphorWords)
        
        // Verify contrast with tree metaphor
        let treeCount = analysis.dictionary["lignum"]?.forms.values.reduce(0, +) ?? 0
        let chaffCount = analysis.dictionary["pulvis"]?.forms.values.reduce(0, +) ?? 0
        XCTAssertGreaterThan(treeCount, 0, "Tree metaphor should be present")
        XCTAssertGreaterThan(chaffCount, 0, "Chaff metaphor should be present")
    }
    func testJudgmentTheme() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let judgmentWords = [
            ("iudicium", ["iudicio"], "judgment"),
            ("concilium", ["concilio"], "assembly")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentWords)
    }
    
    func testRareNouns() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let rareNouns = [
            ("cathedra", ["cathedra"], "seat"),
            ("pulvis", ["pulvis"], "dust"),
            ("folium", ["folium"], "leaf"),
            ("decursus", ["decursus"], "flow")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareNouns)
    }
    
    func testKeyConcepts() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        let thematicWords = [
            ("beatus", ["beatus"], "blessed"),
            ("impius", ["impiorum", "impii"], "wicked"),
            ("iustus", ["iustorum", "iustorum"], "righteous")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: thematicWords)
    }
     func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'corono' forms:", analysis.dictionary["corono"]?.forms ?? [:])
            print("'humilis' forms:", analysis.dictionary["humilis"]?.forms ?? [:])
            print("'propitior' forms:", analysis.dictionary["propitior"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
     func testStructuralFeatures() {
        let analysis = latinService.analyzePsalm(text: psalm1)
        
        // Verify triple negation pattern
        let negatedVerbs = ["abiit", "stetit", "sedit"]
        let negationsFound = negatedVerbs.filter { verb in
            analysis.dictionary.values.contains { entry in
                entry.forms.keys.contains(verb)
            }
        }
        XCTAssertEqual(negationsFound.count, 3, "Should find all three negated actions")
        
        // Verify key repetitions
        XCTAssertGreaterThan(analysis.dictionary["non"]?.forms.values.reduce(0, +) ?? 0, 3, "Key negation word")
    }
    

    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Form verification (case-insensitive)
            let entryFormsLowercased = Dictionary(uniqueKeysWithValues:
                entry.forms.map { ($0.key.lowercased(), $0.value) }
            )
            
            let missingForms = forms.filter { entryFormsLowercased[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entryFormsLowercased[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
    
    // In Psalm1Tests.swift, add this helper function:

private func verifyThematicElements(analysis: PsalmAnalysisResult, expectedThemes: [String: [(lemma: String, description: String)]]) {
    for (theme, elements) in expectedThemes {
        for (lemma, description) in elements {
            guard analysis.dictionary[lemma.lowercased()] != nil else {
                XCTFail("Missing lemma for theme verification: \(lemma) (theme: \(theme))")
                continue
            }
            
            if verbose {
                print("VERIFIED THEME: \(theme) - \(lemma) (\(description))")
            }
        }
    }
}
}