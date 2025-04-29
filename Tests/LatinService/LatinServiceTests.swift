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
    func testPsalm109Analysis() {
    let psalm109 = [
        "Dixit Dominus Domino meo: Sede a dextris meis, donec ponam inimicos tuos scabellum pedum tuorum.",
        "Virgam virtutis tuae emittet Dominus ex Sion: dominare in medio inimicorum tuorum.",
        "Tecum principium in die virtutis tuae in splendoribus sanctorum: ex utero ante luciferum genui te.",
        "Juravit Dominus, et non poenitebit eum: Tu es sacerdos in aeternum secundum ordinem Melchisedech.",
        "Dominus a dextris tuis; confregit in die irae suae reges.",
        "Judicabit in nationibus, implebit ruinas; conquassabit capita in terra multorum.",
        "De torrente in via bibet; propterea exaltabit caput."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm109)
    
    // Test basic statistics
    XCTAssertEqual(analysis.totalWords, 84, "Psalm 109 should have 84 words")
    XCTAssertEqual(analysis.uniqueLemmas, 60, "Should identify unique lemmas") 
    
    // Test specific word counts
    func assertCount(_ lemma: String, _ expected: Int, file: StaticString = #file, line: UInt = #line) {
        guard let info = analysis.dictionary[lemma] else {
            XCTFail("Missing '\(lemma)' in analysis", file: file, line: line)
            return
        }
        XCTAssertEqual(info.count, expected, 
                    "'\(lemma)' should appear \(expected) times", 
                    file: file, line: line)
    }

    // Updated counts based on actual text analysis
    assertCount("dominus", 5)  // 4x "dominus" + 1x "domino"
    assertCount("in", 8)       
    assertCount("et", 1)       
    
    // Test possessive forms under "tu" lemma
    if let tuInfo = analysis.dictionary["tu"] {
        print("DEBUG - Actual 'tu' forms:", tuInfo.forms)

        XCTAssertEqual(tuInfo.count, 8, "All forms of 'tu' (including possessives)")
        XCTAssertTrue(tuInfo.forms.keys.contains("tuos"), "Accusative plural")
        XCTAssertTrue(tuInfo.forms.keys.contains("tuae"), "Feminine form")
        XCTAssertTrue(tuInfo.forms.keys.contains("tuis"), "Dative plural")
        XCTAssertTrue(tuInfo.forms.keys.contains("tuorum"), "Genitive plural")
    } else {
        XCTFail("Missing 'tu' in analysis")
    }
    
    // Test dominus forms
    if let dominusInfo = analysis.dictionary["dominus"] {
        XCTAssertEqual(dominusInfo.forms.keys.count, 2, "Should have 'dominus' and 'domino' forms")
        XCTAssertEqual(dominusInfo.forms["dominus"], 4, "Nominative count") // Actual count
        XCTAssertEqual(dominusInfo.forms["domino"], 1, "Dative count")
    } else {
        XCTFail("Missing 'dominus' in analysis")
    }
    
    // Test translations
    if let sacerdosInfo = analysis.dictionary["sacerdos"] {
        XCTAssertEqual(sacerdosInfo.translation, "priest", "Translation should match")
    } else {
        XCTFail("Missing 'sacerdos' in analysis")
    }
    
    // Test proper noun handling
    if let melchisedechInfo = analysis.dictionary["melchisedech"] {
        XCTAssertNil(melchisedechInfo.entity, "Proper nouns shouldn't have entity info")
    }
    
    // Test verb forms
    if let dicoInfo = analysis.dictionary["dico"] {
        XCTAssertTrue(dicoInfo.forms.keys.contains("dixit"), "Should recognize perfect tense")
    } else {
        XCTFail("Missing 'dico' in analysis")
    }

    if let virtusInfo = analysis.dictionary["virtus"] {
        XCTAssertEqual(virtusInfo.count, 2, "Should find 2 occurrences in Psalm 109")
        XCTAssertTrue(virtusInfo.forms.keys.contains("virtutis"), "Should have genitive form")
        XCTAssertEqual(virtusInfo.forms["virtutis"], 2, "Two genitive occurrences")
    } else {
        XCTFail("Missing 'virtus' in analysis")
    }

     if let scabellumInfo = analysis.dictionary["scabellum"] {
        XCTAssertEqual(scabellumInfo.count, 1, "'scabellum' should appear once")
        XCTAssertEqual(scabellumInfo.translation, "footstool", "Check translation")
        XCTAssertTrue(scabellumInfo.forms.keys.contains("scabellum"), "Should have nominative form")
    } else {
        XCTFail("Missing 'scabellum' in analysis")
    }
    if let pesInfo = analysis.dictionary["pes"] {
        print("DEBUG - Actual 'pes' forms:", pesInfo.forms)
        
        XCTAssertEqual(pesInfo.count, 1, "Should find 'pedum' form")
        XCTAssertEqual(pesInfo.translation, "foot", "Check translation")
        XCTAssertTrue(pesInfo.forms.keys.contains("pedum"), "Should have genitive plural form")
        XCTAssertEqual(pesInfo.forms["pedum"], 1, "Should appear once in 'scabellum pedum tuorum'")
    } else {
        XCTFail("Missing 'pes' in analysis")
    }

    if let juroInfo = analysis.dictionary["juro"] {
        XCTAssertEqual(juroInfo.count, 1, "Should find 'juravit' once")
        XCTAssertEqual(juroInfo.translation, "swear, take an oath")
        XCTAssertTrue(juroInfo.forms.keys.contains("juravit"), "Should recognize perfect tense")
    } else {
        XCTFail("Missing 'juro' in analysis")
    }

    func assertPrepositionA() {
            guard let aInfo = analysis.dictionary["a"] else {
                XCTFail("Preposition 'a' missing in analysis")
                return
            }
            
            XCTAssertEqual(aInfo.count, 2, "Should appear twice for psalm 109")
            XCTAssertEqual(aInfo.translation, "from", "Should translate to 'from'")
            XCTAssertEqual(aInfo.entity?.partOfSpeech?.rawValue, "preposition", "Should be tagged as preposition")
        }
        
    assertPrepositionA()
      
        
    
    assertInimicusForms(from: analysis)
}
 func testPart2ForPsalm109() {
    let psalm109 = [
        "Dixit Dominus Domino meo: Sede a dextris meis, donec ponam inimicos tuos scabellum pedum tuorum.",
        "Virgam virtutis tuae emittet Dominus ex Sion: dominare in medio inimicorum tuorum.",
        "Tecum principium in die virtutis tuae in splendoribus sanctorum: ex utero ante luciferum genui te.",
        "Juravit Dominus, et non poenitebit eum: Tu es sacerdos in aeternum secundum ordinem Melchisedech.",
        "Dominus a dextris tuis; confregit in die irae suae reges.",
        "Judicabit in nationibus, implebit ruinas; conquassabit capita in terra multorum.",
        "De torrente in via bibet; propterea exaltabit caput."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm109)
    assertInimicusForms(from: analysis)
 }

    func testAnalyzePsalm66() {
        let analysis = latinService.analyzePsalm(text: psalm66)
        
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
        let analysis = latinService.analyzePsalm(text: psalm66)
        
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
        let analysis = latinService.analyzePsalm(text: psalm66)
        
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
    
    let analysis = latinService.analyzePsalm(text: psalm90)
    
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
    
    // Create analysis
    let analysis = latinService.analyzePsalm(text: testText)
    
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
        
        // Create analysis
        let analysis = latinService.analyzePsalm(text: testText)
        
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
        
        let analysis = latinService.analyzePsalm(text: psalm119Sade)
        
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

}