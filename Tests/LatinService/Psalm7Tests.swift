import XCTest
@testable import LatinService

class Psalm7Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 7, section: nil)
    
    // MARK: - Test Data
    let psalm7 = [
        "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me.",
        "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat.",
        "Domine Deus meus, si feci istud, si est iniquitas in manibus meis,",
        "si reddidi retribuentibus mihi mala, decidam merito ab inimicis meis inanis.",
        "Persequatur inimicus animam meam, et comprehendat, et conculcet in terra vitam meam, et gloriam meam in pulverem deducat.",
        "Exsurge, Domine, in ira tua; exaltare in finibus inimicorum meorum.",
        "Et exsurge, Domine Deus meus, in praecepto quod mandasti, et synagoga populorum circumdabit te.",
        "Et propter hanc in altum regredere; Dominus judicat populos.",
        "Judica me, Domine, secundum justitiam meam, et secundum innocentiam meam super me.",
        "Consumetur nequitia peccatorum, et diriges justum, scrutans corda et renes, Deus.",
        "Justum adjutorium meum a Domino, qui salvos facit rectos corde.",
        "Deus judex justus, fortis, et patiens; numquid irascitur per singulos dies?",
        "Nisi conversi fueritis, gladium suum vibrabit; arcum suum tetendit, et paravit illum.",
        "Et in eo paravit vasa mortis; sagittas suas ardentibus effecit.",
        "Ecce parturiit injustitiam, concepit dolorem, et peperit iniquitatem.",
        "Lacum aperuit, et effodit eum, et incidit in foveam quam fecit.",
        "Convertetur dolor ejus in caput ejus, et in verticem ipsius iniquitas ejus descendet.",
        "Confitebor Domino secundum justitiam ejus, et psallam nomini Domini altissimi."
    ]
    func testLine1() {
    let line = psalm7[0] // "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me."
    let analysis = latinService.analyzePsalm(id, text: line)
    
    // Key lemmas to verify
    let testLemmas = [
        ("dominus", ["domine"], "Lord"),
        ("deus", ["deus"], "God"),
        ("spero", ["speravi"], "hope"),
        ("salvus", ["salvum"], "save"),
        ("facio", ["fac"], "make"),
        ("persequor", ["persequentibus"], "pursue"),
        ("libero", ["libera"], "free")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    
    // Additional semantic testing
    if verbose {
        print("\nLINE 1 ANALYSIS:")
        print("Original: \(line)")
        
        // Print all lemmas in one line
        let allLemmas = analysis.dictionary.keys.sorted()
        print("\nALL LEMMAS: " + allLemmas.joined(separator: ", "))
        
        // Thematic breakdown
        print("\nKEY THEMES:")
        print("1. Divine Address: 'Domine Deus meus' (my Lord and God)")
        print("2. Trust: 'in te speravi' (in you I have hoped)")
        print("3. Dual Petition: 'salvum me fac' (make me safe) + 'libera me' (free me)")
        print("4. Enemy Mention: 'ex omnibus persequentibus me' (from all who pursue me)")
        
        // Key term counts
        print("\nCRUCIAL WORDS:")
        print("- domine: \(analysis.dictionary["dominus"]?.forms["domine"] ?? 0)")
        print("- speravi: \(analysis.dictionary["spero"]?.forms["speravi"] ?? 0)")
        print("- salvum: \(analysis.dictionary["salvus"]?.forms["salvum"] ?? 0)")
        print("- libera: \(analysis.dictionary["libero"]?.forms["libera"] ?? 0)")
    }
    
    // XCTest Assertions
    XCTAssertEqual(analysis.dictionary["dominus"]?.forms["domine"], 1, "Should contain 'Domine' address")
    XCTAssertEqual(analysis.dictionary["spero"]?.forms["speravi"], 1, "Should find 'speravi' (hoped)")
    XCTAssertGreaterThan(analysis.dictionary["persequor"]?.forms["persequentibus"] ?? 0, 0, 
                       "Should identify pursuers")
    
    // Test combined salvation vocabulary
    let salvationTerms = ["salvum", "libera"].reduce(0) { count, term in
        count + (analysis.dictionary["salvus"]?.forms[term] ?? 0)
             + (analysis.dictionary["libero"]?.forms[term] ?? 0)
    }
    XCTAssertEqual(salvationTerms, 2, "Should find two salvation-related terms")
}
    
    func testLine2() {
        let line = psalm7[1] // "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat."
        let analysis = latinService.analyzePsalm(id, text: line)
        
        // Key lemmas to verify
        let testLemmas = [
            ("nequando", ["nequando"], "lest ever"),
            ("rapio", ["rapiat"], "snatch"),
            ("leo", ["leo"], "lion"),
            ("anima", ["animam"], "soul"),
            ("redimo", ["redimat"], "redeem"),
            ("salvus", ["salvum"], "save"),
            ("facio", ["faciat"], "make")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        
        // Additional semantic testing
        if verbose {
            print("\nLINE 2 ANALYSIS:")
            print("Original: \(line)")
            
            // Print all lemmas in one line
            let allLemmas = analysis.dictionary.keys.sorted()
            print("\nALL LEMMAS: " + allLemmas.joined(separator: ", "))
            
            // Thematic summary
            print("\nKEY THEMES:")
            print("1. Predatory Threat: 'rapiat ut leo' (snatch like a lion)")
            print("2. Absence of Rescue: 'non est qui redimat' (none to redeem)")
            print("3. Salvific Contrast: 'salvum faciat' (make safe)")
            
            // Word-specific counts
            print("\nCRUCIAL WORDS:")
            print("- leo: \(analysis.dictionary["leo"]?.forms["leo"] ?? 0) occurrence(s)")
            print("- rapiat: \(analysis.dictionary["rapio"]?.forms["rapiat"] ?? 0) occurrence(s)")
            print("- redimat: \(analysis.dictionary["redimo"]?.forms["redimat"] ?? 0) occurrence(s)")
        }
        
        // XCTest Assertions
        XCTAssertEqual(analysis.dictionary["leo"]?.forms["leo"], 1, "Lion reference should appear once")
        XCTAssertGreaterThan(analysis.dictionary["rapio"]?.forms["rapiat"] ?? 0, 0, "Should contain 'snatch' action")
        XCTAssertTrue(line.contains("non est"), "Should contain negative existential clause")
    }

    func testLine12() {
        let line = psalm7[11] 
        let analysis = latinService.analyzePsalm(id, text: line)
        
        let divineAttributes = [
            ("judex", ["judex"], "judge"),
            ("justus", ["justus"], "just"),
            ("fortis", ["fortis"], "strong"),
            ("patiens", ["patiens"], "patient"),
            ("irascor", ["irascitur"], "be angry")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineAttributes)
        
        // Additional semantic testing
        if verbose {
            print("\nLINE 12 ANALYSIS:")
            print("Original: \(line)")

            // Print all lemmas        
            let allLemmas = analysis.dictionary.keys.sorted()
            
            // Print in single line format
            print("\nALL LEMMAS: " + allLemmas.joined(separator: ", "))

        }
    }
        func testLine13() { 
        // "Nisi conversi fueritis, gladium suum vibrabit; arcum suum tetendit, et paravit illum."
        let line = psalm7[12] // Note: Index 12 for line 13 (array is 0-based)
        let analysis = latinService.analyzePsalm(text: line)
        
        // Key words to verify
        let threatTerms = [
            ("converto", ["conversi"], "convert"),
            ("gladius", ["gladium"], "sword"),
            ("vibro", ["vibrabit"], "brandish"),
            ("arcus", ["arcum"], "bow"),
            ("tendo", ["tetendit"], "draw"),
            ("paro", ["paravit"], "prepare")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: threatTerms)
        
        if verbose {
            print("\nLINE 13 ANALYSIS:")
            print("Original: \(line)")
            
            // Print all lemmas in one line
            let allLemmas = analysis.dictionary.keys.sorted()
            print("\nALL LEMMAS: " + allLemmas.joined(separator: ", "))
            
            // Thematic breakdown
            print("\nKey Themes:")
            print("- Conditional warning ('Nisi conversi fueritis')")
            print("- Violent imagery (sword/bow preparation)")
            print("- Divine readiness for judgment")

            if let sum = analysis.dictionary["sum"] {
                print("- Sum (fueritis): \(sum.forms["fueritis"] ?? 0) occurrences")
            }
            
            // Detailed weapon terms
            print("\nWeapon Terms:")
            if let sword = analysis.dictionary["gladius"] {
                print("- Sword: \(sword.forms["gladium"] ?? 0) occurrences")
            }
            if let bow = analysis.dictionary["arcus"] {
                print("- Bow: \(bow.forms["arcum"] ?? 0) occurrences")
            }
        }
    }

func testMissingWords() {
    let analysis = latinService.analyzePsalm(text: psalm7)
    
    let missingWords = [
        ("nequando", ["nequando"], "lest ever"),
        ("rapio", ["rapiat"], "seize"),
        ("aperio", ["aperuit"], "open"),
         ("effodio", ["effodit"], "dig"),
        ("vibro", ["vibrabit"], "brandish")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: missingWords)
}

    func testPoeticReversals() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        let reversalTerms = [
            ("converto", ["convertetur"], "turn back"),
            ("incido", ["incidit"], "fall"),
            ("parturio", ["parturiit"], "give birth"),
            ("fovea", ["foveam"], "pit"),
            ("lacus", ["lacum"], "pit")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: reversalTerms)
    }
    
    func testLegalTrialTheme() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let legalTerms = [
            ("judex", ["judex"], "judge"),
            ("judico", ["judicat", "judica"], "judge"),
            ("justus", ["justitiam", "justitiam"], "justice"),
        
            ("innocentia", ["innocentiam"], "innocence"),
            ("retribuere", ["retribuentibus"], "repay")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: legalTerms)
    }

   

    func testPurityAndDarkness() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        let purityTerms = [
            // Lemma      | Forms in Psalm 7          | Translation
            ("innocentia", ["innocentiam"],           "innocence"),  // v. 9
            ("scrutor",    ["scrutans"],              "examine"),   // v. 10
            ("iniquitas",  ["iniquitas", "iniquitatem"], "wickedness"), // v. 3, 15
            ("pulvis",     ["pulverem"],              "dust")        // v. 6
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: purityTerms)
    }

    
    func testViolentEnemyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let enemyTerms = [
            ("leo", ["leo"], "lion"),
            ("gladius", ["gladium"], "sword"),
            ("arcus", ["arcum"], "bow"),
            ("sagitta", ["sagittas"], "arrow"),
            ("conculco", ["conculcet"], "to trample"),
            ("persequor", ["persequentibus", "persequatur"], "to pursue")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    func testBoomerangJustice() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        // Test both the action and target vocabulary
        let boomerangTerms = [
            ("converto", ["convertetur"], "turn back"),
            ("caput", ["caput"], "head"),
            ("incido", ["incidit"], "fall upon")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: boomerangTerms)
    }
    
    func testPoeticJusticeMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let justiceTerms = [
            ("parturio", ["parturiit"], "to give birth"),
            ("concipio", ["concepit"], "to conceive"),
            ("pario", ["peperit"], "to bring forth"),
            ("fovea", ["foveam"], "pit"),
            ("lacus", ["lacum"], "pit")
           
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
    }
    
    func testDivineProtectionTheme() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let protectionTerms = [
            ("spero", ["speravi"], "hope"),
            ("salvus", ["salvum", "salvos"], "save"),
            ("libero", ["libera"], "free"),
            ("redimo", ["redimat"], "redeem"),
            ("adjutorium", ["adjutorium"], "help"),
            ("exsurgo", ["exsurge", "exsurge"], "rise up")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm7)
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
    
   
}