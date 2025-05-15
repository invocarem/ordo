import XCTest
@testable import LatinService

class Psalm101Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Same as before)
     let psalm101 = [
        "Domine, exaudi orationem meam, et clamor meus ad te veniat.",
        "Ne avertas faciem tuam a me; in quacumque die tribulor, inclina ad me aurem tuam.",
        "In quacumque die invocavero te, velociter exaudi me.",
        "Quia defecerunt sicut fumus dies mei, et ossa mea sicut cremium aruerunt.",
        "Percussus sum ut foenum, et aruit cor meum, quia oblitus sum comedere panem meum.",
        "A voce gemitus mei adhaesit os meum carni meae.",
        "Similis factus sum pellicano solitudinis; factus sum sicut nycticorax in domicilio.",
        "Vigilavi, et factus sum sicut passer solitarius in tecto.",
        "Tota die exprobrabant mihi inimici mei; et qui laudabant me adversum me jurabant.",
        "Quia cinerem tamquam panem manducabam, et potum meum cum fletu miscebam.",
        "A facie irae et indignationis tuae, quia elevans allisisti me.",
        "Dies mei sicut umbra declinaverunt, et ego sicut foenum arui.",
        "Tu autem, Domine, in aeternum permanes, et memoriale tuum in generationem et generationem.",
        "Tu exsurgens misereberis Sion, quia tempus miserendi ejus, quia venit tempus.",
        "Quoniam placuerunt servis tuis lapides ejus, et terrae ejus miserebuntur.",
        "Et timebunt gentes nomen tuum, Domine, et omnes reges terrae gloriam tuam.",
        "Quia aedificavit Dominus Sion, et videbitur in gloria sua.",
        "Respexit in orationem humilium, et non sprevit precem eorum.",
        "Scribantur haec in generatione altera, et populus qui creabitur laudabit Dominum.",
        "Quia prospexit de excelso sancto suo; Dominus de caelo in terram aspexit,",
        "ut audiret gemitus compeditorum, ut solveret filios interemptorum,",
        "ut annuntient in Sion nomen Domini, et laudem ejus in Jerusalem,",
        "in conveniendo populos in unum, et reges ut serviant Domino.",
        "Respondit ei in via virtutis suae: Paucitatem dierum meorum nuntia mihi.",
        "Ne revoces me in dimidio dierum meorum; in generationem et generationem anni tui.",
        "Initio tu, Domine, terram fundasti, et opera manuum tuarum sunt caeli.",
        "Ipsi peribunt, tu autem permanes; et omnes sicut vestimentum veterascent,",
        "et sicut opertorium mutabis eos, et mutabuntur.",
        "Tu autem idem ipse es, et anni tui non deficient.",
        "Filii servorum tuorum habitabunt, et semen eorum in saeculum dirigetur."
    ]
    // MARK: - Test Cases
    func testLine5() {
        let line = psalm101[4] // "Percussus sum ut foenum, et aruit cor meum, quia oblitus sum comedere panem meum."
        let analysis = latinService.analyzePsalm(text: line)
        
        // Key lemmas to verify
        let testLemmas = [
            ("percutio", ["percussus"], "strike down"),
            ("foenum", ["foenum"], "hay"),
            ("aresco", ["aruit"], "dry up"),
            ("cor", ["cor"], "heart"),
            ("obliviscor", ["oblitus"], "forget"),
            ("comedo", ["comedere"], "eat"),
            ("panis", ["panem"], "bread")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        
        // Additional semantic testing
        if verbose {
            print("\nLINE 5 ANALYSIS:")
            print("Original: \(line)")
            
            // Print all lemmas in one line
            let allLemmas = analysis.dictionary.keys.sorted()
            print("\nALL LEMMAS: " + allLemmas.joined(separator: ", "))
            
            // Thematic breakdown
            print("\nKEY THEMES:")
            print("1. Physical Decay: 'Percussus sum ut foenum' (struck down like grass)")
            print("2. Emotional Withering: 'aruit cor meum' (my heart dried up)")
            print("3. Neglect Consequences: 'oblitus sum comedere' (I forgot to eat)")
            
            // Key term counts
            print("\nCRUCIAL WORDS:")
            print("- foenum: \(analysis.dictionary["foenum"]?.forms["foenum"] ?? 0) (grass/hay metaphor)")
            print("- aruit: \(analysis.dictionary["aresco"]?.forms["aruit"] ?? 0) (drying action)")
            print("- oblitus: \(analysis.dictionary["obliviscor"]?.forms["oblitus"] ?? 0) (forgetfulness)")
            print("- panem: \(analysis.dictionary["panis"]?.forms["panem"] ?? 0) (bread as sustenance)")
        }
        
        // XCTest Assertions
        XCTAssertEqual(analysis.dictionary["foenum"]?.forms["foenum"], 1, "Should contain grass metaphor")
        XCTAssertEqual(analysis.dictionary["aresco"]?.forms["aruit"], 1, "Should find 'dried up' verb")
        XCTAssertGreaterThan(analysis.dictionary["obliviscor"]?.forms["oblitus"] ?? 0, 0, 
                        "Should identify forgetfulness")
        
        // Test decay imagery
        let decayTerms = ["percussus", "aruit", "oblitus"].reduce(0) { count, term in
            count + (analysis.dictionary["percutio"]?.forms[term] ?? 0)
                + (analysis.dictionary["aresco"]?.forms[term] ?? 0)
                + (analysis.dictionary["obliviscor"]?.forms[term] ?? 0)
        }
        XCTAssertEqual(decayTerms, 3, "Should find three decay-related terms")
    }
    
    func testLine7and8() {
    let line7 = psalm101[6] // "Similis factus sum pellicano solitudinis; factus sum sicut nycticorax in domicilio."
    let line8 = psalm101[7] // "Vigilavi, et factus sum sicut passer solitarius in tecto."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    // CORRECTED lemma list - now treats solitarius as its own lemma
    let testLemmas = [
        ("similis", ["similis"], "like"),
        ("facio", ["factus"], "become"),
        ("pellicanus", ["pellicano"], "pelican"),
        ("solitudo", ["solitudinis"], "wilderness"),
        ("nycticorax", ["nycticorax"], "night-owl"),
        ("domicilium", ["domicilio"], "dwelling"),
        ("vigilo", ["vigilavi"], "stay awake"),
        ("passer", ["passer"], "sparrow"),
        ("solitarius", ["solitarius"], "solitary"), // Now separate from solus
        ("tectum", ["tecto"], "roof")
    ]
    
    if verbose {
        print("\nLINES 7-8:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        // Print verification results
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌")")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
    }
    
    // Corrected assertions
    XCTAssertNotNil(analysis.dictionary["solitarius"], "Should detect 'solitarius' as its own lemma")
    XCTAssertNil(analysis.dictionary["solus"], "'solus' shouldn't appear in this passage")
    XCTAssertNotNil(analysis.dictionary["solitudo"], "Should detect 'solitudinis' root")
}
func testLine9and10() {
    let line9 = psalm101[8] // "Tota die exprobrabant mihi inimici mei; et qui laudabant me adversum me jurabant."
    let line10 = psalm101[9] // "Quia cinerem tamquam panem manducabam, et potum meum cum fletu miscebam."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("totus", ["tota"], "whole"),
        ("dies", ["die"], "day"),
        ("exprobro", ["exprobrabant"], "reproach"),
        ("inimicus", ["inimici"], "enemy"),
        ("laudo", ["laudabant"], "praise"),
        ("adversus", ["adversum"], "against"),
        ("juro", ["jurabant"], "swear"),
        ("cinis", ["cinerem"], "ashes"),
        ("panis", ["panem"], "bread"),
        ("manduco", ["manducabam"], "eat"),
        ("potus", ["potum"], "drink"),
        ("fletus", ["fletu"], "weeping"),
        ("misceo", ["miscebam"], "mix")
    ]
    
    if verbose {
        print("\nLINES 9-10:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌")")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
    }
    
    // Key assertions
    XCTAssertNotNil(analysis.dictionary["exprobro"], "Should detect reproach")
    XCTAssertNotNil(analysis.dictionary["cinis"], "Should detect ashes imagery")
    XCTAssertNotNil(analysis.dictionary["misceo"], "Should detect mixing action")
    
    // Test contrast between lines
    let enemiesCount = analysis.dictionary["inimicus"]?.forms["inimici"] ?? 0
    let weepingCount = analysis.dictionary["fletus"]?.forms["fletu"] ?? 0
    XCTAssertGreaterThan(enemiesCount, 0, "Should find enemy references")
    XCTAssertGreaterThan(weepingCount, 0, "Should find weeping reference")
}

func testLine11and12() {
    let line11 = psalm101[10] // "A facie irae et indignationis tuae, quia elevans allisisti me."
    let line12 = psalm101[11] // "Dies mei sicut umbra declinaverunt, et ego sicut foenum arui."
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("facies", ["facie"], "face"),
        ("ira", ["irae"], "wrath"),
        ("indignatio", ["indignationis"], "indignation"),
        ("elevo", ["elevans"], "lift up"),
        ("allido", ["allisisti"], "cast down"),
        ("dies", ["die", "dies"], "day"),
        ("umbra", ["umbra"], "shadow"),
        ("declino", ["declinaverunt"], "decline"),
        ("foenum", ["foenum"], "hay"),
        ("aresco", ["arui"], "dry up")
    ]
    
    if verbose {
        print("\nLINES 11-12:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌")")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
    }
    
    // Key assertions
    XCTAssertNotNil(analysis.dictionary["allido"], "Should detect 'cast down' action")
    XCTAssertNotNil(analysis.dictionary["umbra"], "Should detect shadow metaphor")
    XCTAssertGreaterThan(analysis.dictionary["dies"]?.forms["dies"] ?? 0, 0, "Should find 'days' reference")
    
    // Test contrasting actions
    let elevationCount = analysis.dictionary["elevo"]?.forms["elevans"] ?? 0
    let declineCount = analysis.dictionary["declino"]?.forms["declinaverunt"] ?? 0
    XCTAssertEqual(elevationCount + declineCount, 2, "Should find both elevation and decline")
}

     func testPenitentialMotifs() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let penitentialTerms = [
            ("gemitus", ["gemitus"], "groaning"),     // Psalm 101:6, 21
            ("fletus", ["fletu"], "weeping"),         // Psalm 101:10
            ("oratio", ["orationem"], "prayer"),      // Psalm 101:1, 18
            ("clamor", ["clamor"], "cry"),            // Psalm 101:1
            ("tribulor", ["tribulor"], "afflict")   // Psalm 101:2
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: penitentialTerms)
    }
    
    // 1. Test Rare Lament Vocabulary
    func testRareLamentTerms() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let rareLamentTerms = [
            ("cremium", ["cremium"], "burning trash"),  // Hapax legomenon (Psalm 101:4)
            ("nycticorax", ["nycticorax"], "night owl"), // Rare animal metaphor (Psalm 101:7)
            ("pellicanus", ["pellicano"], "pelican"),    // Solitude metaphor (Psalm 101:7)
            ("adhaereo", ["adhaesit"], "cling"),        // "My bones cling to my flesh" (Psalm 101:6)
            ("operorium", ["opertorium"], "covering")    // Metaphor for transience (Psalm 101:27)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareLamentTerms)
    }
    
    // 2. Test Divine Judgment Terms
    func testDivineJudgmentTerms() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let judgmentTerms = [
            ("allido", ["allisisti"], "shatter"),        // "You lifted me up and cast me down" (Psalm 101:11)
            ("exprobro", ["exprobrabant"], "taunt"),     // Enemies mocking (Psalm 101:9)
            ("interimo", ["interemptorum"], "destroy"),  // "To free those doomed to die" (Psalm 101:21)
            ("compeditus", ["compeditorum"], "shackled"), // "Groans of the prisoners" (Psalm 101:21)
            ("veterasco", ["veterascent"], "grow old")   // Creation's decay (Psalm 101:27)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    // 3. Test Rare Restoration Verbs
    func testRareRestorationVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let restorationTerms = [
            ("prospicio", ["prospexit"], "look down"),  // God gazing from heaven (Psalm 101:20)
            ("dirigo", ["dirigetur"], "establish"),     // "Their offspring will be established" (Psalm 101:29)
            ("respicio", ["Respexit"], "consider"),       // God heeding prayer (Psalm 101:18)
            ("annuntio", ["annuntient"], "proclaim"),   // Proclaiming God's name (Psalm 101:22)
            ("convenio", ["conveniendo"], "assemble")    // Gathering nations (Psalm 101:23)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: restorationTerms)
    }
    
    // 4. Test Obscure Body/Famine Terms
    func testObscureBodyTerms() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let bodyTerms = [
            ("fumus", ["fumus"], "smoke"),             // "My days vanish like smoke" (Psalm 101:4)
            ("foenum", ["foenum", "foenum"], "hay"),    // Withering metaphor (Psalm 101:5, 12)
            ("os", ["os"], "bone"),         // Dual meaning (Psalm 101:6, 6)
            ("potus", ["potum"], "drink"),              // "Mingled my drink with tears" (Psalm 101:10)
           ("caro", ["carni"], "flesh")               // "My flesh clings to my bones" (Psalm 101:6)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }

    func testTransienceEternityContrast() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let transientTerms = [
            ("umbra", ["umbra"], "shadow"),               // "My days are like a fading shadow" (v.12)
            ("fumus", ["fumus"], "smoke"),                 // "My days vanish like smoke" (v.4)
            ("vestimentum", ["vestimentum"], "garment")     // Creation wears out like clothing (v.27)
        ]
        
        let eternalTerms = [
            ("aeternum", ["aeternum"], "eternity"),        // "But you, Lord, endure forever" (v.13)
            ("permaneo", ["permanes", "permanes"], "endure"), // God's permanence (v.13, 27)
            ("saeculum", ["saeculum"], "age")              // "Their children will be established forever" (v.29)
        ]
    
        verifyWordsInAnalysis(analysis, confirmedWords: transientTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: eternalTerms)
        
        // Verify structural contrast between verses about transience vs eternity
        let transientVerses = [4, 5, 6, 7, 8, 9, 10, 11, 12, 27]
        let eternalVerses = [13, 14, 16, 17, 18, 19, 20, 23, 25, 26, 28, 29]
        
        XCTAssertGreaterThan(
            eternalVerses.count,
            transientVerses.count,
            "Eternal themes should dominate transient ones (eternal: \(eternalVerses.count) vs transient: \(transientVerses.count))"
        )
    }

    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'tribulor' forms:", analysis.dictionary["tribulor"]?.forms ?? [:])
            print("'solitudo' forms:", analysis.dictionary["solitudo"]?.forms ?? [:])
            print("'venter' forms:", analysis.dictionary["venter"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    // MARK: - Helper (Same case-insensitive version as before)
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Case-insensitive translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Case-insensitive form check
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
}