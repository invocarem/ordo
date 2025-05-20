import XCTest
@testable import LatinService

class Psalm6Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
     let identity = PsalmIdentity(number: 6, section: nil)
     let id = PsalmIdentity(number: 6, section: nil)
    
    
    // MARK: - Test Data
    let psalm6 = [
        "Domine, ne in furore tuo arguas me, neque in ira tua corripias me.",
        "Miserere mei, Domine, quoniam infirmus sum; sana me, Domine, quoniam conturbata sunt ossa mea.",
        "Et anima mea turbata est valde; sed tu, Domine, usquequo?",
        "Convertere, Domine, et eripe animam meam; salvum me fac propter misericordiam tuam.",
        "Quoniam non est in morte qui memor sit tui; in inferno autem quis confitebitur tibi?",
        "Laboravi in gemitu meo, lavabo per singulas noctes lectum meum; lacrimis meis stratum meum rigabo.",
        "Turbatus est a furore oculus meus; inveteravi inter omnes inimicos meos.",
        "Discedite a me, omnes qui operamini iniquitatem, quoniam exaudivit Dominus vocem fletus mei.",
        "Exaudivit Dominus deprecationem meam; Dominus orationem meam suscepit.",
        "Erubescant et conturbentur vehementer omnes inimici mei; convertantur et erubescant valde velociter."
    ]
// MARK: - Line Group Tests
func testPsalm6Lines1and2() {
    let line1 = psalm6[0] // "Domine, ne in furore tuo arguas me, neque in ira tua corripias me."
    let line2 = psalm6[1] // "Miserere mei, Domine, quoniam infirmus sum; sana me, Domine, quoniam conturbata sunt ossa mea."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
    
    let testLemmas = [
        ("dominus", ["domine"], "Lord"),
        ("furor", ["furore"], "wrath"),
        ("arguo", ["arguas"], "rebuke"),
        ("ira", ["ira"], "anger"),
        ("corripio", ["corripias"], "chasten"),
        ("misereor", ["miserere"], "have mercy"),
        ("infirmus", ["infirmus"], "weak"),
        ("sano", ["sana"], "heal"),
        ("os", ["ossa"], "bones"),
        ("conturbo", ["conturbata"], "troubled")
    ]
    
    if verbose {
        print("\nPSALM 6:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Divine Wrath: furor (wrath) + ira (anger)")
        print("2. Physical Suffering: infirmus (weak) + ossa (bones)")
        print("3. Plea for Mercy: miserere (have mercy) + sana (heal)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["dominus"]?.forms["domine"], 2, "Should find two 'Lord' references")
    XCTAssertNotNil(analysis.dictionary["misereor"], "Should find plea for mercy")
    XCTAssertNotNil(analysis.dictionary["sano"], "Should find healing request")
}

func testPsalm6Lines3and4() {
    let line3 = psalm6[2] // "Et anima mea turbata est valde; sed tu, Domine, usquequo?"
    let line4 = psalm6[3] // "Convertere, Domine, et eripe animam meam; salvum me fac propter misericordiam tuam."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
    
    let testLemmas = [
        ("anima", ["anima"], "soul"),
        ("turbo", ["turbata"], "troubled"),
        ("dominus", ["domine"], "Lord"),
        ("usquequo", ["usquequo"], "how long"),
        ("converto", ["convertere"], "turn"),
        ("eripio", ["eripe"], "deliver"),
        ("salvus", ["salvum"], "save"),
        ("misericordia", ["misericordiam"], "mercy")
    ]
    
    if verbose {
        print("\nPSALM 6:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Spiritual Anguish: anima (soul) + turbata (troubled)")
        print("2. Divine Timing: usquequo (how long)")
        print("3. Deliverance Plea: convertere (turn) + eripe (deliver)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["turbo"]?.forms["turbata"], 1, "Should find troubled soul reference")
    XCTAssertNotNil(analysis.dictionary["usquequo"], "Should find 'how long' question")
    XCTAssertNotNil(analysis.dictionary["eripio"], "Should find deliverance verb")
}

func testPsalm6Lines5and6() {
    let line5 = psalm6[4] // "Quoniam non est in morte qui memor sit tui; in inferno autem quis confitebitur tibi?"
    let line6 = psalm6[5] // "Laboravi in gemitu meo, lavabo per singulas noctes lectum meum; lacrimis meis stratum meum rigabo."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
    
    let testLemmas = [
        ("mors", ["morte"], "death"),
        ("memor", ["memor"], "remember"),
        ("infernus", ["inferno"], "hell"),
        ("confiteor", ["confitebitur"], "confess"),
        ("laboro", ["laboravi"], "labor"),
        ("gemitus", ["gemitu"], "groaning"),
        ("lavo", ["lavabo"], "wash"),
        ("nox", ["noctes"], "night"),
        ("lacrima", ["lacrimis"], "tears"),
        ("rigo", ["rigabo"], "drench")
    ]
    
    if verbose {
        print("\nPSALM 6:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Mortality Theme: morte (death) + inferno (hell)")
        print("2. Nocturnal Suffering: noctes (nights) + lacrimis (tears)")
        print("3. Physical Manifestations: laboravi (labored) + rigabo (drench)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["infernus"]?.forms["inferno"], 1, "Should find reference to hell")
    XCTAssertNotNil(analysis.dictionary["gemitus"], "Should find groaning reference")
    XCTAssertNotNil(analysis.dictionary["rigo"], "Should find drenching with tears")
}

func testPsalm6Lines7and8() {
    let line7 = psalm6[6] // "Turbatus est a furore oculus meus; inveteravi inter omnes inimicos meos."
    let line8 = psalm6[7] // "Discedite a me, omnes qui operamini iniquitatem, quoniam exaudivit Dominus vocem fletus mei."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
    
    let testLemmas = [
        ("turbo", ["turbatus"], "troubled"),
        ("furor", ["furore"], "anger"),
        ("oculus", ["oculus"], "eye"),
        ("invetero", ["inveteravi"], "grow old"),
        ("inimicus", ["inimicos"], "enemies"),
        ("discedo", ["discedite"], "depart"),
        ("iniquitas", ["iniquitatem"], "iniquity"),
        ("exaudio", ["exaudivit"], "hear"),
        ("dominus", ["dominus"], "Lord"),
        ("fletus", ["fletus"], "weeping")
    ]
    
    if verbose {
        print("\nPSALM 6:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Physical Distress: oculus (eye) + turbatus (troubled)")
        print("2. Enemies Mentioned: inimicos (enemies) + iniquitatem (iniquity)")
        print("3. Divine Response: exaudivit (heard) + fletus (weeping)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["oculus"]?.forms["oculus"], 1, "Should find 'eye' reference")
    XCTAssertNotNil(analysis.dictionary["invetero"], "Should find rare verb 'grow old'")
    XCTAssertEqual(analysis.dictionary["exaudio"]?.forms["exaudivit"], 1, "Should find God hearing")
}

func testPsalm6Lines9and10() {
    let line9 = psalm6[8] // "Exaudivit Dominus deprecationem meam; Dominus orationem meam suscepit."
    let line10 = psalm6[9] // "Erubescant et conturbentur vehementer omnes inimici mei; convertantur et erubescant valde velociter."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 9)
    
    let testLemmas = [
        ("exaudio", ["exaudivit"], "hear"),
        ("dominus", ["dominus"], "Lord"),
        ("deprecatio", ["deprecationem"], "supplication"),
        ("oratio", ["orationem"], "prayer"),
        ("suscipio", ["suscepit"], "receive"),
        ("erubesco", ["erubescant"], "ashamed"),
        ("conturbo", ["conturbentur"], "troubled"),
        ("inimicus", ["inimici"], "enemies"),
        ("converto", ["convertantur"], "turn"),
        ("velox", ["velociter"], "swiftly")
    ]
    
    if verbose {
        print("\nPSALM 6:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Prayer Answered: exaudivit (heard) + suscepit (received)")
        print("2. Enemy Shame: erubescant (ashamed) repeated")
        print("3. Swift Justice: velociter (swiftly) + convertantur (turn)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["dominus"]?.forms["dominus"], 2, "Should find two 'Lord' references")
    XCTAssertEqual(analysis.dictionary["erubesco"]?.forms["erubescant"], 2, "Should find double 'ashamed'")
    XCTAssertNotNil(analysis.dictionary["velox"], "Should find 'swiftly' adverb")
}

    func testUnlemmatizedWords() {
    let analysis = latinService.analyzePsalm(identity, text: psalm6)
    
    // Print words with only 1 occurrence (likely not lemmatized)
    let unlemmatized = analysis.dictionary.filter { $0.value.forms.count == 1 }
    print("\n=== Unlemmatized Words ===")
    unlemmatized.forEach { lemma, entry in
        print("Lemma: \(lemma) → Form: \(entry.forms.keys.first!)")
    }
    
    // Print frequency of high-count words
    print("\n=== High-Frequency Forms ===")
    let forms = psalm6.flatMap { $0.components(separatedBy: .whitespaces) }
    let frequencyDict = Dictionary(grouping: forms, by: { $0.lowercased() })
        .mapValues { $0.count }
        .sorted { $0.value > $1.value }
    
    frequencyDict.prefix(10).forEach { word, count in
        print("\(word): \(count)x")
    }
}
    // MARK: - Test Cases
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(id, text: psalm6)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'gemitus' forms:", analysis.dictionary["gemitus"]?.forms ?? [:])
            print("'rigo' forms:", analysis.dictionary["rigo"]?.forms ?? [:])
            print("'fio' forms:", analysis.dictionary["fio"]?.forms ?? [:])
            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    func testPenitentialVocabulary() {
        let analysis = latinService.analyzePsalm(identity, text: psalm6)
        
        let penitentialTerms = [
            ("misereor", ["miserere"], "have mercy"),
            ("fletus", ["fletus"], "weeping"),
            ("lacrima", ["lacrimis"], "tear"),
            ("gemitus", ["gemitu"], "groaning"),
            ("infernus", ["inferno"], "hell")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: penitentialTerms)
    }
    func testConturboForms() {
    let analysis = latinService.analyzePsalm(identity, text: psalm6)
    verifyWordsInAnalysis(
        analysis,
        confirmedWords: [("conturbo", ["conturbata", "conturbentur"], "trouble")]
    )
}

func testTurboForms() {
    let analysis = latinService.analyzePsalm(identity, text: psalm6)
    verifyWordsInAnalysis(
        analysis,
        confirmedWords: [("turbo", ["turbata", "turbatus"], "disturb")]
    )
}
    func testUniqueVerbForms() {
        let analysis = latinService.analyzePsalm(identity, text: psalm6)
        
        let rareVerbs = [
            ("invetero", ["inveteravi"], "grow old"), // Hapax legomenon
            ("rigo", ["rigabo"], "drench"),
            ("erubesco", ["erubescant"], "ashamed"),
            ("confiteor", ["confitebitur"], "confess")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareVerbs)
    }
    
    func testImperatives() {
        let analysis = latinService.analyzePsalm(identity, text: psalm6)
        
        let commands = [
            ("converto", ["convertere"], "turn back"), // Deponent imperative
            ("discedo", ["discedite"], "depart"), // Plural imperative
            ("eripio", ["eripe"], "rescue")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: commands)
    }
    func testImperativesAndDeponents() {
        let analysis = latinService.analyzePsalm(identity, text: psalm6)
        
        let imperatives = [
            ("arguo", ["arguas"], "rebuke"),
            ("converto", ["convertere"], "turn back"),
            ("eripio", ["eripe"], "deliver"),
            ("exaudio", ["exaudivit"], "hear"),
            ("suscipio", ["suscepit"], "receive")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: imperatives)
    }
    
    func testBodyPartMetaphors() {
        let analysis = latinService.analyzePsalm(identity, text: psalm6)
        
        let bodilyTerms = [
            ("os", ["ossa"], "bone"),
            ("oculus", ["oculus"], "eye"),
            ("animus", ["anima"], "soul")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodilyTerms)
    }
 func testRemainingVerbLemmas() {
    let analysis = latinService.analyzePsalm(identity, text: psalm6)
    
    let untestedVerbs = [
        ("arguo", ["arguas"], "rebuke"),      // Ps 6:1 ("ne in furore tuo arguas me")
        ("corripio", ["corripias"], "rerrect"), // Ps 6:1 ("neque in ira tua corripias me")
        ("sano", ["sana"], "heal"),          // Ps 6:2 ("sana me, Domine")
        ("laboro", ["laboravi"], "labor"),    // Ps 6:6 ("Laboravi in gemitu meo")
        ("lavo", ["lavabo"], "wash"),        // Ps 6:6 ("lavabo per singulas noctes lectum meum")       
         ("fio", ["fiet"], "become"),
         ("memor", ["memor"], "mindful"),  // Ps 6:5 ("non est in morte qui memor sit tui")
        ("velox", ["velociter"], "swift") 
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: untestedVerbs)
}   
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation match
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "Translation mismatch for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify form existence
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            XCTAssertTrue(
                missingForms.isEmpty,
                "\(lemma) missing forms: \(missingForms.joined(separator: ", "))"
            )
            
            if verbose {
                print("\n\(lemma.uppercased()) (\"\(translation)\")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count)x")
                }
            }
        }
    }
}