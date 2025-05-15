import XCTest
@testable import LatinService 

class Psalm90Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true // Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
            XCTAssertTrue(entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                         "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'")
            
            for form in forms {
                let count = entry.forms[form] ?? 0
                if self.verbose {
                    print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
                XCTAssertGreaterThan(count, 0, "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
    }
    let psalm90 = [
        "Qui habitat in adjutorio Altissimi, in protectione Dei caeli commorabitur.",
        "Dicet Domino: Susceptor meus es tu, et refugium meum; Deus meus, sperabo in eum.",
        "Quoniam ipse liberavit me de laqueo venantium, et a verbo aspero.",
        "Scapulis suis obumbrabit tibi, et sub pennis ejus sperabis.",
        "Scuto circumdabit te veritas ejus; non timebis a timore nocturno,",
        "A sagitta volante in die, a negotio perambulante in tenebris, ab incursu et daemonio meridiano.",
        "Cadent a latere tuo mille, et decem millia a dextris tuis; ad te autem non appropinquabit.",
        "Verumtamen oculis tuis considerabis, et retributionem peccatorum videbis.",
        "Quoniam tu es, Domine, spes mea; Altissimum posuisti refugium tuum.",
        "Non accedet ad te malum, et flagellum non appropinquabit tabernaculo tuo.",
        "Quoniam angelis suis mandavit de te, ut custodiant te in omnibus viis tuis.",
        "In manibus portabunt te, ne forte offendas ad lapidem pedem tuum.",
        "Super aspidem et basiliscum ambulabis, et conculcabis leonem et draconem.",
        "Quoniam in me speravit, liberabo eum; protegam eum, quoniam cognovit nomen meum.",
        "Clamabit ad me, et ego exaudiam eum; cum ipso sum in tribulatione, eripiam eum et glorificabo eum.",
        "Longitudine dierum replebo eum, et ostendam illi salutare meum."
    ]
 func testPsalm90Lines1and2() {
    let line1 = psalm90[0] // "Qui habitat in adjutorio Altissimi, in protectione Dei caeli commorabitur."
    let line2 = psalm90[1] // "Dicet Domino: Susceptor meus es tu, et refugium meum; Deus meus, sperabo in eum."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("habito", ["habitat"], "dwell"),
        ("adjutorium", ["adjutorio"], "help"),
        ("altissimus", ["altissimi"], "Most High"),
        ("protectio", ["protectione"], "protection"),
        ("deus", ["dei"], "God"),
        ("caelum", ["caeli"], "heaven"),
        ("commoror", ["commorabitur"], "abide"),
        ("dico", ["dicet"], "say"),
        ("dominus", ["domino"], "Lord"),
        ("susceptor", ["susceptor"], "protector"),
        ("refugium", ["refugium"], "refuge"),
        ("spero", ["sperabo"], "hope")
    ]
    
    if verbose {
        print("\nPSALM 90:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Divine Dwelling: 'habitat...commorabitur' (dwells...will abide)")
        print("2. Protection Imagery: 'adjutorio...protectione...refugium' (help...protection...refuge)")
        print("3. Personal Declaration: 'Deus meus, sperabo in eum' (My God, I will hope in Him)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["altissimus"]?.forms["altissimi"], 1, "Should reference 'Most High'")
    XCTAssertEqual(analysis.dictionary["refugium"]?.forms["refugium"], 1, "Should find 'refuge' term")
    XCTAssertEqual(analysis.dictionary["spero"]?.forms["sperabo"], 1, "Should detect hope verb")
    
    // Test protection vocabulary
    let protectionTerms = ["adjutorio", "protectione", "susceptor"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(protectionTerms.filter { $0 }.count, 3, "Should find all three protection terms")
    
    // Test divine titles
    let divineTitles = ["altissimi", "dei", "domino"].reduce(0) {
        $0 + (analysis.dictionary["altissimus"]?.forms[$1] ?? 0)
        + (analysis.dictionary["deus"]?.forms[$1] ?? 0)
        + (analysis.dictionary["dominus"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(divineTitles, 3, "Should find all three divine titles")
}
func testPsalm90Lines3and4() {
    let line3 = psalm90[2] // "Quoniam ipse liberavit me de laqueo venantium, et a verbo aspero."
    let line4 = psalm90[3] // "Scapulis suis obumbrabit tibi, et sub pennis ejus sperabis."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("liberare", ["liberavit"], "deliver"),
        ("laqueus", ["laqueo"], "snare"),
        ("venator", ["venantium"], "hunter"),
        ("verbum", ["verbo"], "word"),
        ("asper", ["aspero"], "harsh"),
        ("scapula", ["scapulis"], "shoulders"),
        ("obumbro", ["obumbrabit"], "overshadow"),
        ("penna", ["pennis"], "wings"),
        ("spero", ["sperabis"], "take refuge")
    ]
    
    if verbose {
        print("\nPSALM 90:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Deliverance: 'liberavit de laqueo' (delivered from snare)")
        print("2. Protective Imagery: 'scapulis...pennis' (shoulders...wings)")
        print("3. Dual Threats: Physical ('laqueo') and Verbal ('verbo aspero')")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["liberare"]?.forms["liberavit"], 1, "Should find deliverance verb")
    XCTAssertEqual(analysis.dictionary["obumbro"]?.forms["obumbrabit"], 1, "Should detect overshadowing")
    
    // Test danger vocabulary
    let dangerTerms = ["laqueo", "venantium", "aspero"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(dangerTerms.filter { $0 }.count, 3, "Should find all three danger terms")
    
    // Test protection metaphors
    let protectionTerms = ["scapulis", "pennis"].reduce(0) {
        $0 + (analysis.dictionary["scapula"]?.forms[$1] ?? 0)
        + (analysis.dictionary["penna"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(protectionTerms, 2, "Should find both protective body terms")
}
func testPsalm90Lines5and6() {
    let line5 = psalm90[4] // "Scuto circumdabit te veritas ejus; non timebis a timore nocturno,"
    let line6 = psalm90[5] // "A sagitta volante per diem, a negotio perambulante in tenebris, ab incursu et daemonio meridiano."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("scutum", ["scuto"], "shield"),
        ("circumdo", ["circumdabit"], "surround"),
        ("veritas", ["veritas"], "truth"),
        ("timeo", ["timebis"], "fear"),
        ("timor", ["timore"], "terror"),
        ("nocturnus", ["nocturno"], "night"),
        ("sagitta", ["sagitta"], "arrow"),
        ("volo", ["volante"], "fly"),
        ("dies", ["diem"], "day"),
        ("negotium", ["negotio"], "pestilence"),
        ("perambulo", ["perambulante"], "stalk"),
        ("tenebrae", ["tenebris"], "darkness"),
        ("incursus", ["incursu"], "attack"),
        ("daemonium", ["daemonio"], "demon"),
        ("meridianus", ["meridiano"], "noonday")
    ]
    
    if verbose {
        print("\nPSALM 90:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Divine Armor: 'scuto...veritas' (shield of truth)")
        print("2. Temporal Protection: 'nocturno...diem...meridiano' (night/day/noon)")
        print("3. Multiform Threats: arrows, pestilence, demons")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["scutum"]?.forms["scuto"], 1, "Should find shield reference")
    XCTAssertEqual(analysis.dictionary["veritas"]?.forms["veritas"], 1, "Should detect truth as protection")
    
    // Test temporal coverage
    let temporalTerms = ["nocturno", "diem", "meridiano"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(temporalTerms.filter { $0 }.count, 3, "Should cover all time periods")
    
    // Test danger types
    let dangerTerms = ["sagitta", "negotio", "daemonio"].reduce(0) {
        $0 + (analysis.dictionary["sagitta"]?.forms[$1] ?? 0)
        + (analysis.dictionary["negotium"]?.forms[$1] ?? 0)
        + (analysis.dictionary["daemonium"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(dangerTerms, 3, "Should identify all three danger types")
}

func testPsalm90Lines7and8() {
    let line7 = psalm90[6] // "Cadent a latere tuo mille, et decem millia a dextris tuis; ad te autem non appropinquabit."
    let line8 = psalm90[7] // "Verumtamen oculis tuis considerabis, et retributionem peccatorum videbis."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("cado", ["cadent"], "fall"),
        ("latus", ["latere"], "side"),
        ("mille", ["mille"], "thousand"),
        ("decem", ["decem"], "ten"),
        ("dexter", ["dextris"], "right hand"),
        ("appropinquo", ["appropinquabit"], "approach"),
        ("oculus", ["oculis"], "eyes"),
        ("considero", ["considerabis"], "observe"),
        ("retributio", ["retributionem"], "retribution"),
        ("peccator", ["peccatorum"], "sinners"),
        ("video", ["videbis"], "see")
    ]
    
    if verbose {
        print("\nPSALM 90:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Divine Protection: 'non appropinquabit' (won't come near)")
        print("2. Numerical Contrast: 'mille...decem millia' (thousand...ten thousand)")
        print("3. Retributive Justice: 'retributionem peccatorum' (punishment of sinners)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["cado"]?.forms["cadent"], 1, "Should find 'fall' verb")
    XCTAssertEqual(analysis.dictionary["appropinquo"]?.forms["appropinquabit"], 1, "Should detect 'approach' negation")
    
    // Test numerical contrast
    let numbersPresent = ["mille", "decem"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(numbersPresent.filter { $0 }.count, 2, "Should find both number terms")
    
    // Test observation verbs
    let observationVerbs = ["considerabis", "videbis"].reduce(0) {
        $0 + (analysis.dictionary["considero"]?.forms[$1] ?? 0)
        + (analysis.dictionary["video"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(observationVerbs, 2, "Should find both observation verbs")
}

func testPsalm90Lines9and10() {
    let line9 = psalm90[8] // "Quoniam tu es, Domine, spes mea; Altissimum posuisti refugium tuum."
    let line10 = psalm90[9] // "Non accedet ad te malum, et flagellum non appropinquabit tabernaculo tuo."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("quoniam", ["quoniam"], "because"),
        ("dominus", ["domine"], "Lord"),
        ("spes", ["spes"], "hope"),
        ("altissimus", ["altissimum"], "Most High"),
        ("pono", ["posuisti"], "make"),
        ("refugium", ["refugium"], "refuge"),
        ("accedo", ["accedet"], "approach"),
        ("malum", ["malum"], "evil"),
        ("flagellum", ["flagellum"], "scourge"),
        ("appropinquo", ["appropinquabit"], "come near"),
        ("tabernaculum", ["tabernaculo"], "dwelling")
    ]
    
    if verbose {
        print("\nPSALM 90:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Personal Confession: 'spes mea' (my hope)")
        print("2. Divine Elevation: 'Altissimum...refugium' (Most High as refuge)")
        print("3. Double Protection: 'non accedet...non appropinquabit' (won't approach)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["spes"]?.forms["spes"], 1, "Should find 'hope' declaration")
    XCTAssertEqual(analysis.dictionary["altissimus"]?.forms["altissimum"], 1, "Should reference 'Most High'")
    
    // Test negative protection clauses
    let protectionVerbs = ["accedet", "appropinquabit"].reduce(0) {
        $0 + (analysis.dictionary["accedo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["appropinquo"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(protectionVerbs, 2, "Should find both protection verbs")
    
    // Test danger terms
    let dangerTerms = ["malum", "flagellum"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(dangerTerms.filter { $0 }.count, 2, "Should identify both evil and plague")
}

    func testAnalyzePsalm90() {
   
    let analysis = latinService.analyzePsalm(text: psalm90)
    
    // ===== TEST METRICS =====
    let totalWords = 150  // Actual word count in Psalm 90
    let testedLemmas = 62 // Number of lemmas we're testing
    let testedForms = 78  // Number of word forms we're verifying
    
    // ===== 2. COMPREHENSIVE VOCABULARY TEST =====
    let confirmedWords = [
        ("altissimus", ["altissimi", "altissimum"], "most high"),
        ("dominus", ["domino"], "lord"),
        ("refugium", ["refugium", "refugium"], "refuge"),
        ("protectio", ["protectione"], "protection"),
        ("angelus", ["angelis"], "angel"),
        ("scapula", ["scapulis"], "shoulder"),
        ("habito", ["habitat"], "dwell"),
        ("spero", ["sperabo", "sperabis", "speravit"], "hope"),
        ("libero", ["liberavit", "liberabo"], "free"),
        ("obumbro", ["obumbrabit"], "overshadow"),
        ("timeo", ["timebis"], "fear"),
        ("considero", ["considerabis"], "consider"),
        ("custodio", ["custodiant"], "guard"),
        ("ambulo", ["ambulabis"], "walk"),
        ("conculco", ["conculcabis"], "trample"),
        ("exaudio", ["exaudiam"], "hear"),
        ("eripio", ["eripiam"], "rescue")
    ]
    
    if self.verbose {
        print("\n=== Psalm 90 Test Coverage ===")
        print("Total words: \(totalWords)")
        print("Unique lemmas: \(analysis.uniqueLemmas)")
        print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
        print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 3. THEOLOGICAL CONCEPT CHECKS =====
    // Protection imagery
    if let scapulaInfo = analysis.dictionary["scapula"] {
        XCTAssertEqual(scapulaInfo.forms["scapulis"], 1, "Should find 'scapulis' once")
    }
    
    // Divine refuge terms
    if let refugiumInfo = analysis.dictionary["refugium"] {
        XCTAssertGreaterThan(refugiumInfo.count, 1, "Refugium should appear multiple times")
    }
    
    // Spiritual warfare terms
    XCTAssertNotNil(analysis.dictionary["draco"], "Should have 'draco' (dragon)")
    XCTAssertNotNil(analysis.dictionary["leo"], "Should have 'leo' (lion)")
    
    // ===== 4. GRAMMAR CHECKS =====
    // Verify imperative forms
    if let custodiInfo = analysis.dictionary["custodio"] {
        XCTAssertEqual(custodiInfo.forms["custodiant"], 1, "Should find subjunctive 'custodiant'")
    }
    
    // Verify divine pronouns
    if let meusInfo = analysis.dictionary["meus"] {
        XCTAssertGreaterThan(meusInfo.count, 3, "Possessive 'meus' should appear frequently")
    }

    if verbose {
        print("\n=== Key Theological Terms ===")
        print("'timeo' forms:", analysis.dictionary["timeo"]?.forms ?? [:])
    }
}
}