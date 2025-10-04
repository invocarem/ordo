import XCTest
@testable import LatinService

final class LatinWordTests: XCTestCase {
    private var latinService: LatinService!
    private let psalm66 = """
        Deus misereatur nostri, et benedicat nobis; illuminet vultum suum super nos, et misereatur nostri.
        Ut cognoscamus in terra viam tuam, in omnibus gentibus salutare tuum.
        Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.
        Laetentur et exsultent gentes, quoniam judicas populos in aequitate, et gentes in terra dirigis.
        Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.
        Terra dedit fructum suum; benedicat nos Deus, Deus noster.
        Benedicat nos Deus; et metuant eum omnes fines terrae.
        """
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
        
        
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    
    func testWordsAreLoaded() {
        let allWords = latinService.getWordEntities()
        XCTAssertFalse(allWords.isEmpty, "Should have loaded wordEntities")
    }
    
    func testTranslationsAreLoaded() {
        XCTAssertFalse(latinService.getTranslations().isEmpty, "Should have loaded translations")
    }
func testTransferoFuturePassive() {
    let testText = [
        "et transferentur montes in cor maris.",
    ]
    let identity = PsalmIdentity(number: 45, category: nil)
    latinService.configureDebugging(target: "transfero")
    let analysis = latinService.analyzePsalm(identity, text: testText)
    let entry = analysis.dictionary["transfero"]
    // Safely unwrap the optional
    guard let entry = entry else {
        XCTFail("Entry is nil")
        return
    }
    
    // Check if transferentur was found and counted
    let transferenturCount = entry.forms["transferentur"] ?? 0
    XCTAssertEqual(transferenturCount, 1, "Should find 'transferentur' once in the text")
    
    // Also check if it's recognized as a future_passive form
    print("\nAll found forms for transfero:")
    for form in entry.forms.sorted(by: { $0.key < $1.key }) {
        print("\(form.key): \(form.value)")
    }
}
 
    func testAnalyzeLevo() {
    // Setup test data - using Vulgate verses that contain 'levo' and its forms
    let testText = [
        "Leva oculos tuos et vide",                       // Genesis 13:14 - "Lift up your eyes and see" (Imperative)
        "Levavi oculos meos in montes",                   // Psalm 121:1 - "I have lifted up my eyes to the mountains" (Perfect)
        "Qui levat in altum oculos suos",                 // Proverbs 21:4 (Vulgate) - "Who raises his eyes on high" (Present relative)
        "Levantes autem oculos suos",                     // Matthew 17:8 - "But lifting up their eyes" (Present Participle)
        "Nonne haec levabis super eum parabolam?",        // Micah 2:4 (Vulgate) - "Will you not utter a parable against him?" (Future)
        "Levabit enim Dominus super eos",                 // Isaiah 19:1 (Vulgate) - "For the Lord will lift up against them" (Future)
        "Qui levat de terra inopem",                      // Psalm 113:7 - "Who raises up the needy from the earth" (Present)
        "Levatus est autem et abiit",                     // John 5:15 - "But he was raised up and he went away" (Perfect Passive)
        "Levamus corda nostra cum manibus ad Deum",       // Lamentations 3:41 (Vulgate) - "Let us lift up our hearts with our hands to God" (Present)
        "Leva manum tuam super gentes alienas",           // Jeremiah 50:25 (Vulgate) - "Lift up your hand against foreign nations" (Imperative)
        "Et levavit Ioseph currum suum",                  // Genesis 46:29 (Vulgate) - "And Joseph prepared his chariot" (Perfect - idiomatic use)
        "Levabit signum in nationes procul",              // Isaiah 5:26 (Vulgate) - "He will lift up a signal to distant nations" (Future)
        "Nolite levare coram hominibus",                  // Matthew 6:1 (Vulgate) - "Do not practice your righteousness before men" (Infinitive - "to display")
        "Quoniam tu es qui levabis me",                   // Psalm 4:8 (Vulgate) - "For you are the one who will lift me up" (Future)
        "Levatus que est rex de solio suo"                 // 1 Kings 1:53 (Vulgate) - "And the king was raised from his throne" (Perfect Passive)
    ]
    let identity = PsalmIdentity(number: 999, category: nil)
    
    // Create analysis
    let analysis = latinService.analyzePsalm(identity, text: testText)
    
    // Verify lemma exists
    guard let entry = analysis.dictionary["levo"] else {
        XCTFail("Missing 'levo' lemma")
        return
    }
    
    print("\n=== levō Forms ===")
    
    // Check expected forms
    let expectedForms = [
        ("leva", "imperative_sg", 2),         // "lift!" (command)
        ("levavi", "perfect_1s", 1),          // "I have lifted"
        ("levat", "present_3s", 1),           // "he lifts"
        ("levantes", "pres_part", 1),         // "lifting" (present participle)
        ("levabit", "future_3s", 2),          // "he will lift"
        ("levamus", "present_1pl", 1),        // "we lift"
        ("levatus", "perf_part", 2),          // "having been lifted" (perfect passive participle)
        ("levavit", "perfect_3s", 1),         // "he lifted"
        ("levare", "infinitive", 1),          // "to lift"
        ("levetur", "pres_subj_3s", 0),       // "may he be lifted" (optional check)
    ]
    
    for (form, tenseMood, minCount) in expectedForms {
        let count = entry.forms[form] ?? 0
        print("\(form.padding(toLength: 10, withPad: " ", startingAt: 0)) | \(tenseMood.padding(toLength: 20, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        if minCount > 0 {
            XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(tenseMood))")
        }
    }
    
    // Verify verb properties
    XCTAssertEqual(entry.entity?.partOfSpeech, .verb)
    XCTAssertEqual(entry.entity?.conjugation, 1) // 1st conjugation verb
    // Verify translation captures the meaning
    let translationContainsLift = entry.translation?.contains("lift") == true
    let translationContainsRaise = entry.translation?.contains("raise") == true
    XCTAssertTrue(translationContainsLift || translationContainsRaise, 
                 "Translation should include 'lift' or 'raise'")
    
    // Print all found forms for debugging
    print("\nAll found forms for levō:")
    for (form, count) in entry.forms.sorted(by: { $0.key < $1.key }) {
        if count > 0 {
            print("\(form): \(count)")
        }
    }
}

    func testAnalyzeIntendo() {
        // Setup test data - using Vulgate verses that contain 'intendo' and its forms
        let testText = [
            "Intende in adiutorium meum",                   // Psalm 70:12 - "Direct yourself to help me" (Imperative)
            "Quia intendit orationem pauperis",            // Psalm 102:17 - "For he directs the prayer of the poor" (Perfect)
            "Aures tuae intendunt in precem eorum",        // Psalm 10:17 (Vulgate) - "Your ears are directed to their prayer" (Present)
            "Et intendentes in eum lumina vestra",         // Wisdom 2:2 (Vulgate) - "And directing your eyes to him" (Present Participle)
            "Intendite vias eius",                         // Jeremiah 18:15 (Vulgate) - "Direct your ways" (Imperative plural)
            "Qui intendit iracundiam suam",                // Psalm 7:13 (Vulgate) - "Who aims his anger" (Present relative)
            "Intendisti arcum tuum",                       // Habakkuk 3:9 (Vulgate) - "You have strung your bow" (Perfect)
            "Intendentium in misericordiam tuam",          // Psalm 33:22 (Vulgate) - "Of those who wait for your mercy" (Genitive plural participle)
            "Et non intendit in vanitates",                // Psalm 24:1 (Vulgate) - "And does not pay attention to vanities"
            "Anima mea intendit in te",                    // Psalm 25:1 (Vulgate) - "My soul is directed toward you"
            "Intendite corda vestra in verba mea",         // Judges 9:3 (Vulgate) - "Direct your hearts to my words"
            "Et intendam ad te oculos meos"                // Psalm 141:8 (Vulgate) - "And I will direct my eyes to you" (Future)
        ]
        let identity = PsalmIdentity(number: 999, category: nil)
        
        // Create analysis
        let analysis = latinService.analyzePsalm(identity, text: testText)
        
        // Verify lemma exists
        guard let entry = analysis.dictionary["intendo"] else {
            XCTFail("Missing 'intendo' lemma")
            return
        }
        
        print("\n=== intendō Forms ===")
        
        // Check expected forms
        let expectedForms = [
            ("intende", "imperative_sg", 1),      // "direct!" (command)
            ("intendite", "imperative_pl", 1),    // "direct!" (plural command)
            ("intendit", "perfect_3s", 1),        // "he has directed"
            ("intendisti", "perfect_2s", 1),      // "you have directed"
            ("intendunt", "present_3pl", 1),      // "they direct"
            ("intendentes", "pres_part", 1),      // "directing" (present participle)
            ("intendentium", "gen_pl_part", 1),   // "of those directing" (genitive plural participle)
            ("intendam", "future_1s", 1),         // "I will direct"
        ]
        
        for (form, tenseMood, minCount) in expectedForms {
            let count = entry.forms[form] ?? 0
            print("\(form.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(tenseMood.padding(toLength: 20, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
            if minCount > 0 {
                XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(tenseMood))")
            }
        }
        
        // Verify verb properties
        XCTAssertEqual(entry.entity?.partOfSpeech, .verb)
        XCTAssertEqual(entry.entity?.conjugation, 3) // 3rd conjugation verb
        // Verify translation captures the meaning
        let translationContainsDirect = entry.translation?.contains("direct") == true
        let translationContainsAim = entry.translation?.contains("aim") == true
        let translationContainsStretch = entry.translation?.contains("stretch") == true
        let translationContainsIntend = entry.translation?.contains("intend") == true
        XCTAssertTrue(translationContainsDirect || translationContainsAim || translationContainsStretch || translationContainsIntend, 
                    "Translation should include 'direct', 'aim', 'stretch', or 'intend'")
        
        // Print all found forms for debugging
        print("\nAll found forms for intendō:")
        for (form, count) in entry.forms.sorted(by: { $0.key < $1.key }) {
            if count > 0 {
                print("\(form): \(count)")
            }
        }
    }


func testRespicio() {
    let respicio = LatinWordEntity(
        lemma: "respicio",
        partOfSpeech: .verb,
        present: "respicio",
        perfect: "respexi",
        infinitive: "respicere",
        supine: "respectum",
        conjugation: 3
    )
    
    let forms = respicio.generatedVerbForms()
    
    // Debug print all forms
    print("===== ALL GENERATED FORMS FOR RESPICIO =====")
    forms.sorted(by: { $0.key < $1.key }).forEach { key, values in
        print("\(key): \(values.joined(separator: ", "))")
    }
    print("===========================================")

 // Verify future active indicative contains correct form "respices"
    if let futureForms = forms["future"] {
        XCTAssertTrue(futureForms.contains("respices"), 
                     "Future forms should contain 'respices'. Found: \(futureForms)")
    } else {
        XCTFail("Future forms not generated at all")
    }
    
    // Additional verification for other expected forms
    XCTAssertEqual(forms["infinitive"], ["respicere"])
    XCTAssertEqual(forms["present_passive"], [
        "respicior", "respiceris", "respicitur", 
        "respicimur", "respicimini", "respiciuntur"
    ])

}
  func testGratulor() {
        let gratulor = LatinWordEntity(
            lemma: "gratulor",
            partOfSpeech: .verb,
            present: "gratulor",
            perfect: "gratulatus",
            infinitive: "gratulari",
            supine: "gratulatum",
            conjugation: 1,
            forms: [
                "present_active_participle": ["gratulans"]
            ]
        )
        
        let forms = gratulor.generatedVerbForms()
         forms.sorted(by: { $0.key < $1.key }).forEach { key, values in
        print("\(key): \(values.joined(separator: ", "))")
    }
        // Present Passive
        XCTAssertEqual(forms["present_passive"], [
            "gratulor", "gratularis", "gratulatur",
            "gratulamur", "gratulamini", "gratulantur"
        ])
        
        // Should respect manual override for participle
        XCTAssertEqual(forms["present_active_participle"], ["gratulans"])
    }

func testDominor() {
    let dominor = LatinWordEntity(
        lemma: "dominor",
        partOfSpeech: .verb,
        present: "dominor",
        perfect: "dominatus",
        infinitive: "dominari",
        future: "dominabo",
        supine: "dominatum",
        conjugation: 1
    )
    
    let forms = dominor.generatedVerbForms()
    forms.sorted(by: { $0.key < $1.key }).forEach { key, values in
        print("\(key): \(values.joined(separator: ", "))")
    }
    
    // Present Passive (should match present forms for deponents)
    XCTAssertEqual(forms["present_passive"], [
        "dominor", "dominaris", "dominatur",
        "dominamur", "dominamini", "dominantur"
    ], "present_passive")
    
    XCTAssertEqual(forms["present_passive_subjunctive"], [
        "dominer", "domineris", "dominetur",
        "dominemur", "dominemini", "dominentur"
    ], "present_passive_subjunctive")

    // Future Passive
    XCTAssertEqual(forms["future_passive"], [
        "dominabor", "dominaberis", "dominabitur",
        "dominabimur", "dominabimini", "dominabuntur"
    ], "future_passive")
    
    // Perfect System (active forms for deponents)
    XCTAssertEqual(forms["perfect"], [
        "dominatus", "dominatus", "dominatus",
        "dominatus", "dominatus", "dominatus"
    ], "perfect")
}

 func testCognosco() {
        let cognosco = LatinWordEntity(
            lemma: "cognosco",
            partOfSpeech: .verb,
            perfect: "cognovi",
            infinitive: "cognoscere",            
            supine: "cognitum",
            conjugation: 3
        )

        let forms = cognosco.generatedVerbForms()
        
        XCTAssertEqual(forms["perfect"], [
            "cognovi", "cognovisti", "cognovit",
            "cognovimus", "cognovistis", "cognoverunt"
        ])
        
        XCTAssertEqual(forms["imperfect_active_subjunctive"], [
            "cognoscerem", "cognosceres", "cognosceret",
            "cognosceremus", "cognosceretis", "cognoscerent"
        ])
    }

   func testAnalyzePsalm66() {
        let identity = PsalmIdentity(number: 66, category: nil)
        let analysis = latinService.analyzePsalm(identity, text: psalm66)
        
        // Basic statistics
        XCTAssertGreaterThan(analysis.totalWords, 0, "Should have words in psalm")
        XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should have unique words")
        XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should have unique lemmas")
        
        // Verify specific words in the dictionary
        XCTAssertNotNil(analysis.dictionary["deus"], "Should have 'deus' in dictionary")
        XCTAssertNotNil(analysis.dictionary["populus"], "Should have 'populus' in dictionary")
        XCTAssertNotNil(analysis.dictionary["terra"], "Should have 'terra' in dictionary")
        
        // Verify forms and counts
        if let deusInfo = analysis.dictionary["deus"] {
           
            XCTAssertGreaterThan(deusInfo.count, 0, "'deus' should appear multiple times")
            XCTAssertEqual(deusInfo.translation, "god", "Translation should match")
            XCTAssertTrue(deusInfo.forms.keys.contains("deus"), "Should have 'deus' form")
        } else {
            XCTFail("Missing 'deus' in analysis")
        }
        
        if let populusInfo = analysis.dictionary["populus"] {
            XCTAssertTrue(populusInfo.forms.keys.contains("populi"), "Should have 'populi' form")
        }
    }
    
    
    func testPsalm66WordCounts() {
        let identity = PsalmIdentity(number: 66, category: nil)
        let analysis = latinService.analyzePsalm(identity, text: psalm66)
        
        // Verify specific word counts
        if let deusInfo = analysis.dictionary["deus"] {
            let totalDeusOccurrences = deusInfo.forms.values.reduce(0, +)
            XCTAssertEqual(totalDeusOccurrences, deusInfo.count, "Form counts should sum to lemma count")
            XCTAssertEqual(deusInfo.count, 6, "'deus' should appear 6 times in Psalm 66")
        }
        // 4 populi, 1 populos
        if let populusInfo = analysis.dictionary["populus"] {
            XCTAssertEqual(populusInfo.count, 5, "'populus' should appear 5 times")
        }
    }
    
    func testEntityInformation() {
        let identity = PsalmIdentity(number: 66, category: nil)
        let analysis = latinService.analyzePsalm(identity, text: psalm66)
        
        if let deusInfo = analysis.dictionary["deus"] {
            XCTAssertNotNil(deusInfo.entity, "Should have entity info for 'deus'")
            XCTAssertEqual(deusInfo.entity?.lemma, "deus", "Entity lemma should match")
            XCTAssertEqual(deusInfo.entity?.genitive, "dei", "Genitive form should be 'dei'")
        }
        
        if let tuInfo = analysis.dictionary["tuus"] {
            XCTAssertNotNil(tuInfo.entity, "Should have entity info for possessive 'tuus'")
        }
    }
    
    // Helper to get word counts for debugging
    func printWordCounts(from analysis: PsalmAnalysisResult) {
        let sorted = analysis.dictionary.sorted { $0.value.count > $1.value.count }
        for (lemma, info) in sorted {
            print("\(lemma): \(info.count) [translation: \(info.translation ?? "none")]")
            print("  Forms: \(info.forms)")
        }
    }

    func assertInimicusForms(from analysis: PsalmAnalysisResult) {
    // CORRECT: Check for the LEMMA ("inimicus"), not the form ("inimicos")
    guard let inimicusInfo = analysis.dictionary["inimicus"] else {
        XCTFail("""
            Missing lemma 'inimicus' in analysis. 
            Found words: \(analysis.dictionary.keys.sorted())
            This means 'inimicos'/'inimicorum' didn't map to 'inimicus'.
            """)
        return
    }

    // Now verify the forms are grouped under the lemma
    XCTAssertEqual(inimicusInfo.count, 2, "Should find 2 total occurrences (inimicos + inimicorum)")
    XCTAssertEqual(inimicusInfo.forms["inimicos"], 1, "Should find 'inimicos' once")
    XCTAssertEqual(inimicusInfo.forms["inimicorum"], 1, "Should find 'inimicorum' once")
}

   
func testAnalyzePsalm90() {
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
    let identity = PsalmIdentity(number: 90, category: nil)
    
    let analysis = latinService.analyzePsalm(identity, text: psalm90)
    
    // 1. Basic statistics
    XCTAssertGreaterThan(analysis.totalWords, 0, "Should have words in psalm")
    XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should have unique words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should have unique lemmas")
    
    // 2. Test key theological words
    XCTAssertNotNil(analysis.dictionary["altissimus"], "Should have 'altissimus' (Most High)")
    XCTAssertNotNil(analysis.dictionary["dominus"], "Should have 'dominus' (Lord)")
    XCTAssertNotNil(analysis.dictionary["refugium"], "Should have 'refugium' (refuge)")
    XCTAssertNotNil(analysis.dictionary["protectio"], "Should have 'protectio' (protection)")
    XCTAssertNotNil(analysis.dictionary["angelus"], "Should have 'angelus' (angel)")
    
    // 3. Test protection imagery words
    XCTAssertNotNil(analysis.dictionary["scapula"], "Should have 'scapula' (shoulder/wings)")
}
func testAnalyzeAdolescens() {
    // Setup test data
    let testText = [
        "Adolescens sum ego et contemptus", // Psalm 119:141
        "Vide adolescentem currentem",      // Example sentence
        "Da intellectum adolescentibus"     // Plural example
    ]
    let identity = PsalmIdentity(number: 999, category: nil)
    
    // Create analysis
    let analysis = latinService.analyzePsalm(identity, text: testText)
    
    // Verify lemma exists
    guard let entry = analysis.dictionary["adolescens"] else {
        XCTFail("Missing 'adolescens' lemma")
        return
    }
    
    print("\n=== adolescens Forms ===")
    
    // Check expected forms
    let expectedForms = [
        ("adolescens", "nominative", 1),  // Verse 141
        ("adolescentem", "accusative", 1),
        ("adolescentibus", "dative_plural", 1)
    ]
    
    for (form, caseName, minCount) in expectedForms {
        let count = entry.forms[form] ?? 0
        print("\(form.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(caseName.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(caseName))")
    }
    
    // Verify noun properties
    XCTAssertEqual(entry.entity?.partOfSpeech, .noun)
    XCTAssertEqual(entry.translation?.contains("youth"), true)
}

    func testAnalyzeCustodio() {
        // Setup test data
        let testText = [
            "Custodiam mandata tua",          // Future tense
            "Custodi verba haec",             // Imperative
            "Custodiebant testamentum"        // Imperfect
        ]
    let identity = PsalmIdentity(number: 118, category: nil)
        
        // Create analysis
        let analysis = latinService.analyzePsalm(identity, text: testText)
        
        // Verify lemma exists
        guard let entry = analysis.dictionary["custodio"] else {
            XCTFail("Missing 'custodio' lemma")
            return
        }
        
        print("\n=== custodio Forms ===")
        
        // Check expected forms
        let expectedForms = [
            ("custodiam", "future", 1),
            ("custodi", "imperative", 1),
            ("custodiebant", "imperfect", 1)
        ]
        
        for (form, tense, minCount) in expectedForms {
            let count = entry.forms[form] ?? 0
            print("\(form.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(tense.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
            XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(tense))")
        }
        
        // Verify verb properties
        XCTAssertEqual(entry.entity?.partOfSpeech, .verb)
        XCTAssertEqual(entry.translation?.contains("guard"), true)
    }

func testAnalyzeEgo() {
    // Setup test data - using Vulgate verses that contain 'ego' and its forms
    let testText = [
        "Ego sum via, veritas, et vita",          // John 14:6 - "I am the way..."
        "Libera me de persequentibus me",         // Psalm 119:170 - "...persecuting me"
        "Domine, non est exaltatum cor meum",     // Psalm 131:1 - "...my heart"
        "Mihi autem nimis honorati sunt",         // Psalm 139:17 - "To me, however..."
        "Miserere mei, Deus"
    ]
    let identity = PsalmIdentity(number: 999, category: nil)
    
    // Create analysis
    let analysis = latinService.analyzePsalm(identity, text: testText)
    
    // Verify lemma exists
    guard let entry = analysis.dictionary["ego"] else {
        XCTFail("Missing 'ego' lemma")
        return
    }
    
    print("\n=== ego Forms ===")
    
    // Check expected forms
    let expectedForms = [
        ("ego", "nominative", 1),        // "I" - subject
        ("me", "accusative", 1),         // "me" - object
        ("mihi", "dative", 1),           // "to/for me" - indirect object
        ("mei", "genitive", 1),          // "of me" - possession
        ("me", "ablative", 1)            // "by/with/from me" - ablative
    ]
    
    for (form, caseName, minCount) in expectedForms {
        let count = entry.forms[form] ?? 0
        print("\(form.padding(toLength: 10, withPad: " ", startingAt: 0)) | \(caseName.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(caseName))")
    }
    
    // Verify pronoun properties
    XCTAssertEqual(entry.entity?.partOfSpeech, .pronoun)
    XCTAssertEqual(entry.translation?.contains("I") == true || entry.translation?.contains("me") == true, true)
}
    func testAnalyzeNos() {
        // Setup test data - using Vulgate verses that contain 'nos' and its forms
        let testText = [
            "Nos autem populus eius et oves pascuae eius", // Psalm 95:7 - "But we are his people..."
            "Libera nos a malo",                           // Matthew 6:13 - "Deliver us from evil"
            "Propter nos et propter nostram salutem",      // Creed - "For us and for our salvation"
            "Nobis autem revelavit Deus" ,                  // 1 Corinthians 2:10 - "But to us God revealed"
            "Miserere nostri, Domine"   
        ]
        let identity = PsalmIdentity(number: 999, category: nil)
        
        // Create analysis
        let analysis = latinService.analyzePsalm(identity, text: testText)
        
        // Verify lemma exists
        guard let entry = analysis.dictionary["nos"] else {
            XCTFail("Missing 'nos' lemma")
            return
        }
        
        print("\n=== nos Forms ===")
        
        // Check expected forms
        let expectedForms = [
            ("nos", "nominative", 1),         // "we" - subject
            ("nos", "accusative", 1),         // "us" - object
            ("nobis", "dative", 1),           // "to/for us" - indirect object
            ("nostri", "genitive", 1),        // "of us" - possession
            ("nobis", "ablative", 1)          // "by/with/from us" - ablative
        ]
        
        for (form, caseName, minCount) in expectedForms {
            let count = entry.forms[form] ?? 0
            print("\(form.padding(toLength: 10, withPad: " ", startingAt: 0)) | \(caseName.padding(toLength: 15, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
            XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(caseName))")
        }
        
        // Verify pronoun properties
        XCTAssertEqual(entry.entity?.partOfSpeech, .pronoun)
        XCTAssertEqual(entry.translation?.contains("we") == true || entry.translation?.contains("us") == true, true)
    }

    func testAnalyzeQuis() {
    // Setup test data - using Vulgate verses that contain interrogative 'quis' forms
    let testText = [
        "Quis ostendet nobis bona?",                           // Psalm 4:6 - "Who will show us good things?" (nom. m/f)
        "Quid est homo quod memor es eius?",                  // Psalm 8:4 - "What is man that you are mindful of him?" (nom. n)
        "A quo trepidabis et timebis?",                       // ... context
        "Quem adiuvabit intellegentia eius?",                 // Isaiah 40:14 (Vulgate) - "Whom will his understanding help?" (acc. m)
        "Domine, quis habitabit in tabernaculo tuo?",         // Psalm 15:1 - "Lord, who will dwell in your tabernacle?" (nom. m/f)
        "Aut quis requiescet in monte sancto tuo?",           // ... verse continues
        "Ad quem autem confugiet miseria mea?",               // Job 6:13 (Vulgate) - "But to whom will my misery flee?" (dat. m)
        "Quid retribuam Domino pro omnibus quae retribuit mihi?", // Psalm 116:12 - "What shall I return to the Lord?" (acc. n)
        "Cuius est imago haec et superscriptio?",             // Matthew 22:20 - "Whose image and inscription is this?" (gen. m/f/n)
        "Quem vultis vobis dimitti?",                         // Matthew 27:17 - "Whom do you want me to release to you?" (acc. m)
        "Quid faciemus?",                                     // Acts 2:37 - "What shall we do?" (acc. n)
        "Si Deus pro nobis, quis contra nos?",                // Romans 8:31 - "If God is for us, who is against us?" (nom. m/f)
        "Quid enim est vita vestra?",                         // James 4:14 - "For what is your life?" (nom. n)
        "In quo enim iudicio iudicaveritis",                  // Matthew 7:2 - "For with what judgment you judge" (abl. n)
        "Cui autem similem esse hominem generationem istam?"  // ... context
    ]
    let identity = PsalmIdentity(number: 999, category: nil)
    
    // Create analysis
    let analysis = latinService.analyzePsalm(identity, text: testText)
    
    // Verify lemma exists
    guard let entry = analysis.dictionary["quis"] else {
        XCTFail("Missing 'quis' lemma")
        return
    }
    
    print("\n=== quis (interrogative) Forms ===")
    
    // Check expected forms
    let expectedForms = [
        ("quis", "nom_mf_sg", 4),        // "who?" (m/f nominative singular)
        ("quid", "nom_n_sg", 2),         // "what?" (neuter nominative singular)
        ("quem", "acc_m_sg", 2),         // "whom?" (masculine accusative singular)
        ("quid", "acc_n_sg", 2),         // "what?" (neuter accusative singular)
        ("cuius", "gen_sg", 1),          // "whose? of whom?" (genitive singular)
        ("cui", "dat_sg", 1),            // "to/for whom?" (dative singular)
        ("quo", "abl_m_sg", 1),          // "by/with whom?" (masculine ablative singular)
        ("quo", "abl_n_sg", 1),          // "by/with what?" (neuter ablative singular)
        ("quem", "acc_m_sg", 2),         // "whom?" (masculine accusative singular)
    ]
    
    for (form, caseDescription, minCount) in expectedForms {
        let count = entry.forms[form] ?? 0
        print("\(form.padding(toLength: 8, withPad: " ", startingAt: 0)) | \(caseDescription.padding(toLength: 20, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        if minCount > 0 {
            XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(caseDescription))")
        }
    }
    
    // Verify pronoun properties
    XCTAssertEqual(entry.entity?.partOfSpeech, .pronoun)
    XCTAssertEqual(entry.entity?.declension, 0)
    // Verify translation captures interrogative meaning
    let translationContainsWho = entry.translation?.contains("who") == true
    let translationContainsWhat = entry.translation?.contains("what") == true
    XCTAssertTrue(translationContainsWho || translationContainsWhat, 
                 "Translation should include 'who' or 'what' (interrogative)")
    
    // Verify this is the interrogative pronoun, not relative
    XCTAssertTrue(entry.translation?.contains("who?") == true || 
                 entry.translation?.contains("what?") == true ||
                 entry.translation?.contains("anyone") == true,
                 "Should be identified as interrogative/indefinite pronoun")
    
    // Print all found forms for debugging
    print("\nAll found forms for quis:")
    for (form, count) in entry.forms.sorted(by: { $0.key < $1.key }) {
        if count > 0 {
            print("\(form): \(count)")
        }
    }
}

func testAnalyzeIustusAndIustitia() {
    // Setup test data - using Vulgate verses
    let testText = [
        "Iustus ex fide vivit",                          // Romans 1:17 - "The just (m.nom) lives by faith"
        "Vidi impium superexaltatum et elevatum sicut cedros Libani", // Psalm 37:35 - Context
        "et transivi et ecce non erat et non inveni eum",// ... (verse continues)
        "Iustum deduxit Dominus per vias rectas",        // Wisdom 10:10 - "The Lord led the just (m.acc) on straight paths"
        "Beati qui esuriunt et sitiunt iustitiam",       // Matthew 5:6 - "...thirst for justice (f.acc)"
        "Quoniam ipsorum est regnum caelorum",           // ... (verse continues)
        "et iustitia eius manet in saeculum saeculi",    // Psalm 111:3 - "...and his justice (f.nom)"
        "Os iusti meditabitur sapientiam",               // Psalm 37:30 - "The mouth of the just (m.gen) will meditate on wisdom"
        "Voluntas autem iustorum prosperabitur",         // Proverbs 11:23 (Vulgate) - "The will of the just (m.gen.pl) will prosper"
        "Et lux orta est iusto",                         // Psalm 97:11 - "And light has dawned for the just (m.dat)"
        "Vidi impium superexaltatum",                    // Psalm 37:35 - "I have seen the wicked highly exalted"
        "et elevatum sicut cedros Libani",               // ... (verse continues)
        "Et ecce non erat et non inveni eum",            // ... (verse continues)
        "Iustus in perpetuum vivet",                     // Wisdom 5:15 - "The just (m.nom) will live forever"
        "Dominus custodit omnia ossa eorum",             // Psalm 34:20 - "The Lord keeps all their bones"
        "unum ex his non conteretur",                    // ... (verse continues)
        "Iusta iudicate, filii hominum"                  // Psalm 58:1 - "Judge just things (n.acc.pl), O sons of men"
    ]
    let identity = PsalmIdentity(number: 999, category: nil)
    
    // Create analysis
    let analysis = latinService.analyzePsalm(identity, text: testText)
    
    // Test for iustus (adjective)
    print("\n=== Testing iustus (adjective) ===")
    guard let iustusEntry = analysis.dictionary["iustus"] else {
        XCTFail("Missing 'iustus' lemma")
        return
    }
    
    let expectedIustusForms = [
        ("iustus", "nom_m", 2),        // "the just man" (subject)
        ("iustum", "acc_m", 1),        // "the just man" (object)
        ("iusti", "gen_m", 1),         // "of the just man"
        ("iusto", "dat_m", 1),         // "to/for the just man"
        ("iustorum", "gen_m_pl", 1),   // "of the just" (plural)
        ("iusta", "acc_n_pl", 1),      // "just things" (neuter plural)
    ]
    
    for (form, caseName, minCount) in expectedIustusForms {
        let count = iustusEntry.forms[form] ?? 0
        print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) | \(caseName.padding(toLength: 10, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(caseName)) for iustus")
    }
    
    // Verify it's categorized as an adjective
    XCTAssertEqual(iustusEntry.entity?.partOfSpeech, .adjective)
    
    // Test for iustitia (noun)
    print("\n=== Testing iustitia (noun) ===")
    guard let iustitiaEntry = analysis.dictionary["iustitia"] else {
        XCTFail("Missing 'iustitia' lemma")
        return
    }
    
    let expectedIustitiaForms = [
        ("iustitia", "nom_sg", 1),     // "justice" (subject)
        ("iustitiam", "acc_sg", 1),    // "justice" (object)
    ]
    
    for (form, caseName, minCount) in expectedIustitiaForms {
        let count = iustitiaEntry.forms[form] ?? 0
        print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) | \(caseName.padding(toLength: 10, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(caseName)) for iustitia")
    }
    
    // Verify it's categorized as a noun
    XCTAssertEqual(iustitiaEntry.entity?.partOfSpeech, .noun)
    
    // Print all found forms for debugging
    print("\nAll found forms for iustus:")
    for (form, count) in iustusEntry.forms.sorted(by: { $0.key < $1.key }) {
        if count > 0 {
            print("\(form): \(count)")
        }
    }
    
    print("\nAll found forms for iustitia:")
    for (form, count) in iustitiaEntry.forms.sorted(by: { $0.key < $1.key }) {
        if count > 0 {
            print("\(form): \(count)")
        }
    }
}

func testAnalyzeEripio() {
    // Setup test data - using Vulgate verses that contain 'eripio' and its forms
    let testText = [
        "Eripe me de inimicis meis, Deus meus",           // Psalm 59:1 - "Rescue me from my enemies, my God" (Imperative)
        "Et eripe me de manu filiorum alienorum",        // Psalm 144:11 - "And deliver me from the hand of foreign children"
        "Dominus eripiet me de manu peccatoris",         // Psalm 7:2 (Vulgate) - "The Lord will rescue me from the hand of the sinner" (Future)
        "Eripiam eos de loco isto",                      // Genesis 45:10 (Vulgate) - "I will rescue them from this place" (Future)
        "Qui eripuit me de ore leonis",                  // 2 Timothy 4:17 - "Who rescued me from the mouth of the lion" (Perfect)
        "Eripientes eos de manibus paganorum",           // 1 Maccabees 5:24 (Vulgate) - "Rescuing them from the hands of the pagans" (Present Participle)
        "Eripe me de operantibus iniquitatem",           // Psalm 119:2 - "Deliver me from those who work iniquity"
        "Et de inimicis meis potentibus eripuisti me",   // Psalm 18:17 - "And from my powerful enemies you have rescued me" (Perfect)
        "Nonne Deus requiret ista? ipse enim novit",     // ... (context for the next verse)
        "occulta cordis quoniam sapiens est",            // ... (context continued)
        "et eripiet animas servorum suorum",             // Wisdom 10:9 - "and he will rescue the souls of his servants" (Future)
        "et non condemnabuntur qui sperant in eum",      // ... (verse continues)
        "Eripiamus eum de manu impiorum"                 // Jeremiah 38:19 (Vulgate) - "Let us rescue him from the hand of the impious" (Hortatory Subjunctive)
    ]
    let identity = PsalmIdentity(number: 999, category: nil)
    
    // Create analysis
    let analysis = latinService.analyzePsalm(identity, text: testText)
    
    // Verify lemma exists
    guard let entry = analysis.dictionary["eripio"] else {
        XCTFail("Missing 'eripio' lemma")
        return
    }
    
    print("\n=== eripio Forms ===")
    
    // Check expected forms
    let expectedForms = [
        ("eripe", "imperative_sg", 2),      // "rescue!" (command)
        ("eripiet", "future_3s", 1),        // "he will rescue"
        ("eripiam", "future_1s", 1),        // "I will rescue"
        ("eripuit", "perfect_3s", 1),       // "he rescued"
        ("eripuisti", "perfect_2s", 1),     // "you have rescued"
        ("eripientes", "pres_part", 1),     // "rescuing" (present participle)
        ("eripiamus", "pres_subj_1pl", 1),  // "let us rescue" (hortatory subjunctive)
    ]
    
    for (form, tenseMood, minCount) in expectedForms {
        let count = entry.forms[form] ?? 0
        print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) | \(tenseMood.padding(toLength: 20, withPad: " ", startingAt: 0)) | \(count >= minCount ? "✅" : "❌")")
        if minCount > 0 {
            XCTAssertGreaterThanOrEqual(count, minCount, "Missing form '\(form)' (\(tenseMood))")
        }
    }
    
    // Verify verb properties
    XCTAssertEqual(entry.entity?.partOfSpeech, .verb)
    XCTAssertEqual(entry.entity?.conjugation, 3) // 3rd conjugation verb
    // Verify translation captures the meaning
    let translationContainsRescue = entry.translation?.contains("rescue") == true
    let translationContainsDeliver = entry.translation?.contains("deliver") == true
    let translationContainsSnatch = entry.translation?.contains("snatch") == true
    XCTAssertTrue(translationContainsRescue || translationContainsDeliver || translationContainsSnatch, 
                 "Translation should include 'rescue', 'deliver', or 'snatch'")
    
    // Print all found forms for debugging
    print("\nAll found forms for eripio:")
    for (form, count) in entry.forms.sorted(by: { $0.key < $1.key }) {
        if count > 0 {
            print("\(form): \(count)")
        }
    }
}

func testOdiDefectiveVerb() {
    let odi = LatinWordEntity(
        lemma: "odi",
        partOfSpeech: .verb,
        present: nil, // no present form
        perfect: "odi",
        infinitive: "odisse",
        supine: "osum",
        conjugation: 0 // conjugation not needed for defective verbs
    )

    let forms = odi.generatedVerbForms()
    forms.sorted(by: { $0.key < $1.key }).forEach { key, values in
        print("\(key): \(values.joined(separator: ", "))")
    }

    // Only perfect system should be present
    XCTAssertEqual(forms["perfect"], [
        "odi", "odisti", "odit",
        "odimus", "odistis", "oderunt"
    ], "perfect")

    XCTAssertEqual(forms["pluperfect"], [
        "oderam", "oderas", "oderat",
        "oderamus", "oderatis", "oderant"
    ], "pluperfect")

    XCTAssertEqual(forms["future_perfect"], [
        "odero", "oderis", "oderit",
        "oderimus", "oderitis", "oderint"
    ], "future_perfect")

    // Present and other active forms should not exist
    XCTAssertEqual(forms["present"], [])
    XCTAssertEqual(forms["present_passive"], [])
    XCTAssertEqual(forms["future"], [])
    XCTAssertEqual(forms["imperfect_active"], [])
}
func testHumilio() {
    let verb = LatinWordEntity(
        lemma: "humilio",
        partOfSpeech: .verb,
        present: "humilio",
        perfect: "humiliavi",
        infinitive: "humiliare",
        supine: "humiliatum",
        conjugation: 1
    )


    let forms = verb.generatedVerbForms()
    forms.sorted(by: { $0.key < $1.key }).forEach { key, values in
        print("\(key): \(values.joined(separator: ", "))")
    }
    XCTAssertTrue(forms["imperfect_active"]?.contains("humiliabam") == true)
    XCTAssertTrue(forms["imperfect_passive"]?.contains("humiliabar") == true)
}



}