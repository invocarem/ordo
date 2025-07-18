import XCTest
@testable import LatinService

final class LatinServiceTests: XCTestCase {
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
    func testIntendeGeneration() {
        let intende = LatinWordEntity(
        lemma: "intendo",
        partOfSpeech: .verb,
        declension: nil, // Not needed for verbs
        gender: nil,     // Not needed for verbs
        vocative: nil,   // Not needed for verbs
        nominative: nil, // Not needed for verbs
        dative: nil,    // Not needed for verbs
        accusative: nil, // Not needed for verbs
        genitive: nil,   // Not needed for verbs
        ablative: nil,   // Not needed for verbs
        nominative_plural: nil, // Not needed for verbs
        genitive_plural: nil,   // Not needed for verbs
        dative_plural: nil,     // Not needed for verbs
        accusative_plural: nil, // Not needed for verbs
        ablative_plural: nil,   // Not needed for verbs
        possessive: nil,       // Not needed for verbs
        perfect: "intendi",
        infinitive: "intendere",
        supine: "intentum",
        conjugation: 3,
        forms: nil,             // Optional: Add if you have irregular forms
        formsPlural: nil,       // Optional: Add if needed
        baseForm: "intende",    // The imperative form you're testing
        derivedFrom: nil,       // Optional: Parent word if derived
        translations: [
            "en": "to stretch, aim, direct attention, intend",
            "la": "intendo, intendere"
        ]
    )
    
    
    let forms = intende.generatedVerbForms()    
    print("All generated forms: \(forms)") // Debug the full output
    
    // Check if keys exist before force-unwrapping
    if let present = forms["present"] {
        print("Present: \(present)")
        XCTAssertEqual(present, ["intendeo", "intendes", "intendet", "intendemus", "intendetis", "intendent"])
    } else {
        XCTFail("Missing 'present' forms")
    }
    
    if let perfect = forms["perfect"] {
        print("Perfect: \(perfect)")
        XCTAssertEqual(perfect, ["intendi", "intendisti", "intendit", "intendimus", "intendistis", "intenderunt"])
    } else {
        XCTFail("Missing 'perfect' forms")
    }
    
    if let pastParticiple = forms["past_participle"] {
        print("Past Participle: \(pastParticiple)")
        XCTAssertEqual(pastParticiple, ["intentus"])
    } else {
        XCTFail("Missing 'past_participle'")
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
        
        if let populusInfo = analysis.dictionary["populus"] {
            XCTAssertEqual(populusInfo.count, 4, "'populus' should appear 4 times")
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
    let identity = PsalmIdentity(number: 118, category: nil)
    
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
    func testAnalyzeJustus() {
        let psalm119Sade = [
            "Justus es, Domine",        // verse 137 (masc.nom)
            "Mandasti justitiam",       // verse 138 (fem.acc)
            "Justitiae tuae"           // verse 138 (fem.gen)
            
        ]
    let id = PsalmIdentity(number: 118, category: nil)
        
        let analysis = latinService.analyzePsalm(id, text: psalm119Sade)
        
        // 1. Validate lemma exists        
        guard let justusEntry = analysis.dictionary["justus"], 
              let entity = justusEntry.entity else {
            XCTFail("Missing 'justus' lemma or entity")
            return
        }
    
        // 4. Debug output
        print("\nAll forms detected:")
        justusEntry.forms.forEach { 
            print("- \($0.key): \($0.value)") 
            let analysis = entity.analyzeFormWithMeaning($0.key)
            print("\($0.key): \(analysis)")
            
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

func testEripio() {
    let eripio = LatinWordEntity(
        lemma: "eripio",
        partOfSpeech: .verb,
        present: "eripio",
        perfect: "eripui",
        infinitive: "eripere",
        supine: "ereptum",
        conjugation: 3
    )

    let forms = eripio.generatedVerbForms()
    forms.sorted(by: { $0.key < $1.key }).forEach { key, values in
        print("\(key): \(values.joined(separator: ", "))")
    }

    // Check that it's recognized as a 3rd-io verb: present starts with eripio
    XCTAssertEqual(forms["present"]?.prefix(6), [
        "eripio", "eripis", "eripit", "eripimus", "eripitis", "eripiunt"
    ].prefix(6))

    // Present active participle: eripiens
    XCTAssertTrue(forms["present_active_participle"]?.contains("eripiens") == true)

    // Future passive (3rd-io): eripiar, eripieris, ...
    XCTAssertEqual(forms["future_passive"], [
        "eripiar", "eripieris", "eripietur",
        "eripiemur", "eripiemini", "eripientur"
    ])

    // Present passive subjunctive: eripiar, etc.
    XCTAssertEqual(forms["present_passive_subjunctive"], [
        "eripiar", "eripiaris", "eripiatur",
        "eripiamur", "eripiamini", "eripiantur"
    ])
    
    // Perfect
    XCTAssertEqual(forms["perfect"], [
        "eripui", "eripuisti", "eripuit",
        "eripuimus", "eripuistis", "eripuerunt"
    ])
}



}