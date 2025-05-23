import XCTest
@testable import LatinService

final class Psalm118Tests: XCTestCase {
    let verbose : Bool = true
    private var latinService: LatinService!
     override func setUp() {
        super.setUp()
        latinService = LatinService.shared
        
        
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    
    func testAnalyzePsalm118Aleph() {
    let psalm119Aleph = [
        "Beati immaculati in via, qui ambulant in lege Domini.",
        "Beati qui scrutantur testimonia eius, in toto corde exquirunt eum.",
        "Non enim qui operantur iniquitatem, in viis eius ambulaverunt.",
        "Tu mandasti mandata tua custodire nimis.",
        "Utinam dirigantur viae meae ad custodiendas iustificationes tuas!",
        "Tunc non confundar, cum perspexero in omnibus mandatis tuis.",
        "Confitebor tibi in directione cordis, in eo quod didici iudicia iustitiae tuae.",
        "Iustificationes tuas custodiam; non me derelinquas usquequaque."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm119Aleph)
    // print("All words in analysis dictionary:")
    //analysis.dictionary.keys.sorted().forEach { print($0) }
    
    // Basic statistics
    XCTAssertGreaterThan(analysis.totalWords, 0, "Should have words in psalm")
    XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should have unique words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should have unique lemmas")

    
    // Test specific words
    XCTAssertNotNil(analysis.dictionary["ambulo"], "Should have 'ambulo' in dictionary")
   
    
     guard let ambuloEntry = analysis.dictionary["ambulo"] else {
        XCTFail("Dictionary should contain 'ambulo' lemma")
        return
    }
    
    // 3. Verify basic properties of the ambulo entry
    XCTAssertEqual(ambuloEntry.entity?.partOfSpeech?.rawValue, "verb", "Should be a verb")
    XCTAssertEqual(ambuloEntry.translation, "walk", "English translation should be 'walk'")
    // Verify forms and counts for 'ambulo' (lemma)
    if let ambuloInfo = analysis.dictionary["ambulo"] {
        XCTAssertEqual(ambuloInfo.translation, "walk", "Translation should match")
        
        // Check that the forms exist and have counts > 0
        if let ambulantCount = ambuloInfo.forms["ambulant"] {
            XCTAssertGreaterThan(ambulantCount, 0, "'ambulant' should appear at least once")
        } else {
            XCTFail("Missing 'ambulant' form in analysis")
        }
        
        if let ambulaveruntCount = ambuloInfo.forms["ambulaverunt"] {
            XCTAssertGreaterThan(ambulaveruntCount, 0, "'ambulaverunt' should appear at least once")
        } else {
            XCTFail("Missing 'ambulaverunt' form in analysis")
        }
    } else {
        XCTFail("Missing 'ambulo' in analysis")
    }
    
     // Update these checks to look for the lemma forms:
    XCTAssertNotNil(analysis.dictionary["beatus"], "Should have 'beatus' (lemma of 'beati') in dictionary")
    XCTAssertNotNil(analysis.dictionary["lex"], "Should have 'lex' (lemma of 'lege') in dictionary")
    
    // Additional checks for other important words in this psalm
    
    XCTAssertNotNil(analysis.dictionary["via"], "Should have 'via' in dictionary")
    
     XCTAssertNotNil(analysis.dictionary["immaculatus"], "Should have 'immaculatus' in dictionary")
    XCTAssertNotNil(analysis.dictionary["dominus"], "Should have 'dominus' in dictionary")
    XCTAssertNotNil(analysis.dictionary["mandatum"], "Should have 'mandatum' in dictionary")

}
    
    func testAnalyzePsalm118Gimel() {
    let psalm119Gimel = [
        "Retribue servo tuo, vivifica me, et custodiam sermones tuos.",
        "Revela oculos meos, et considerabo mirabilia de lege tua.",
        "Incola ego sum in terra, non abscondas a me mandata tua.",
        "Concupivit anima mea desiderare iustificationes tuas in omni tempore.",
        "Increpasti superbos; maledicti qui declinant a mandatis tuis.",
        "Aufer a me opprobrium et contemptum, quia testimonia tua custodivi.",
        "Etenim sederunt principes, et adversum me loquebantur; servus autem tuus exercebatur in iustificationibus tuis.",
        "Nam et testimonia tua meditatio mea est, et consilium meum iustificationes tuae."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm119Gimel)
    
    // Basic statistics
    XCTAssertGreaterThan(analysis.totalWords, 0, "Should have words in psalm")
    XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should have unique words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should have unique lemmas")
    
    // Test specific words (checking lemma forms)
    XCTAssertNotNil(analysis.dictionary["retribuo"], "Should have 'retribuo' (from 'Retribue') in dictionary")
    XCTAssertNotNil(analysis.dictionary["servus"], "Should have 'servus' in dictionary")
    XCTAssertNotNil(analysis.dictionary["custodio"], "Should have 'custodio' in dictionary")
    XCTAssertNotNil(analysis.dictionary["revelo"], "Should have 'revelo' (from 'Revela') in dictionary")
    XCTAssertNotNil(analysis.dictionary["lex"], "Should have 'lex' (from 'lege') in dictionary")
    XCTAssertNotNil(analysis.dictionary["anima"], "Should have 'anima' (from 'anima') in dictionary")
    XCTAssertNotNil(analysis.dictionary["desidero"], "Should have 'desidero' in dictionary")
    XCTAssertNotNil(analysis.dictionary["superbus"], "Should have 'superbus' in dictionary")


    XCTAssertNotNil(analysis.dictionary["anima"], "Should have 'anima' in dictionary")

    // Add detailed checks for 'anima':
    if let animaEntry = analysis.dictionary["anima"] {
        XCTAssertEqual(animaEntry.entity?.partOfSpeech?.rawValue, "noun", "Should be a noun")
        XCTAssertEqual(animaEntry.entity?.gender?.rawValue, "feminine", "Gender should be feminine")
        XCTAssertEqual(animaEntry.entity?.declension, 1, "Should be 1st declension")
        XCTAssertEqual(animaEntry.translation, "soul, life", "Translation should match")
        
        // Print all observed forms and their counts
        print("\nObserved Forms:")
        animaEntry.forms.forEach { form, count in
            print("- \(form): \(count) occurrence(s)")
        }
        // Verify forms (from your JSON)
        XCTAssertGreaterThan(animaEntry.forms["anima"] ?? 0, 0, "Should have 'anima' form")
        
    } else {
        XCTFail("Missing 'anima' in analysis")
    }
        
    // Detailed check for 'custodio' (appears multiple times)
    if let custodioEntry = analysis.dictionary["custodio"] {
        XCTAssertEqual(custodioEntry.entity?.partOfSpeech?.rawValue, "verb", "Should be a verb")
        XCTAssertGreaterThan(custodioEntry.count, 1, "'custodio' should appear multiple times")
        
        // Check specific forms
        XCTAssertGreaterThan(custodioEntry.forms["custodiam"] ?? 0, 0, "Should have 'custodiam' form")
        XCTAssertGreaterThan(custodioEntry.forms["custodivi"] ?? 0, 0, "Should have 'custodivi' form")
    } else {
        XCTFail("Missing 'custodio' in analysis")
    }
    
    // Check noun properties for 'lex'
    if let lexEntry = analysis.dictionary["lex"] {
        XCTAssertEqual(lexEntry.entity?.partOfSpeech?.rawValue, "noun", "Should be a noun")
        XCTAssertEqual(lexEntry.entity?.gender?.rawValue, "feminine", "Gender should be feminine")
        XCTAssertEqual(lexEntry.entity?.declension, 3, "Should be 3rd declension")
    }
    
    // Check adjective properties for 'superbus'
    if let superbusEntry = analysis.dictionary["superbus"] {
        XCTAssertEqual(superbusEntry.entity?.partOfSpeech?.rawValue, "adjective", "Should be an adjective")
        XCTAssertEqual(superbusEntry.entity?.gender?.rawValue, "masculine", "Default gender should be masculine")
    }
}
func testAnalyzePsalm118Daleth() {
    let psalm119Daleth = [
        "Adhaesit pavimento anima mea: vivifica me secundum verbum tuum.",
        "Vias meas enuntiavi et exaudisti me: doce me iustificationes tuas.",
        "Viam mandatorum tuorum instrue me: et meditabor in mirabilibus tuis.",
        "Dormitavit anima mea prae taedio: confirma me in verbis tuis.",
        "Viam iniquitatis amove a me: et de lege tua miserere mei.",
        "Viam veritatis elegi: iudicia tua non sum oblitus.",
        "Adhaesi testimoniis tuis Domine: noli me confundere.",
        "Viam mandatorum tuorum cucurri: cum dilatasti cor meum."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm119Daleth)
    
    // Debug print if needed
    // print("All words in analysis dictionary:")
    // analysis.dictionary.keys.sorted().forEach { print($0) }
    
    // 1. Basic statistics
    XCTAssertGreaterThan(analysis.totalWords, 0, "Should have words in psalm")
    XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should have unique words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should have unique lemmas")
    
    // 2. Test specific important words in Daleth category
    XCTAssertNotNil(analysis.dictionary["adhaereo"], "Should have 'adhaereo' in dictionary")
    XCTAssertNotNil(analysis.dictionary["vivifico"], "Should have 'vivifico' in dictionary")
    XCTAssertNotNil(analysis.dictionary["verbum"], "Should have 'verbum' in dictionary")
    XCTAssertNotNil(analysis.dictionary["via"], "Should have 'via' in dictionary")
    XCTAssertNotNil(analysis.dictionary["iustificatio"], "Should have 'iustificatio' in dictionary")
    XCTAssertNotNil(analysis.dictionary["mandatum"], "Should have 'mandatum' in dictionary")
    XCTAssertNotNil(analysis.dictionary["dominus"], "Should have 'dominus' in dictionary")
    
    // 3. Detailed test for 'vivifico' (to give life) as sample verb
    guard let vivificoEntry = analysis.dictionary["vivifico"] else {
        XCTFail("Dictionary should contain 'vivifico' lemma")
        return
    }
    
    // Verify basic properties
    XCTAssertEqual(vivificoEntry.entity?.partOfSpeech?.rawValue, "verb", "Should be a verb")
   
    
    // Verify forms and counts
    if let vivificoInfo = analysis.dictionary["vivifico"] {
        // Check imperative form "vivifica" appears
        if let vivificaCount = vivificoInfo.forms["vivifica"] {
            XCTAssertGreaterThan(vivificaCount, 0, "'vivifica' should appear at least once")
        } else {
            XCTFail("Missing 'vivifica' form in analysis")
        }
    } else {
        XCTFail("Missing 'vivifico' in analysis")
    }
    
    
}

    func testAnalyzePsalm119He() {
    let psalm119He = [
        "Legem pone mihi, Domine, viam justificationum tuarum, et exquiram eam semper.",
        "Da mihi intellectum, et scrutabor legem tuam, et custodiam illam in toto corde meo.",
        "Deduc me in semitam mandatorum tuorum, quia ipsam volui.",
        "Inclina cor meum in testimonia tua, et non in avaritiam.",
        "Averte oculos meos ne videant vanitatem; in via tua vivifica me.",
        "Statue servo tuo eloquium tuum in timore tuo.",
        "Amputa opprobrium meum quod suspicatus sum, quia judicia tua jucunda.",
        "Ecce concupivi mandata tua; in aequitate tua vivifica me."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm119He)
    
    // Debug: Print all detected lemmas
    print("\n=== Detected Lemmas ===")
    analysis.dictionary.keys.sorted().forEach { print($0) }
    
    // 1. Basic statistics
    XCTAssertGreaterThan(analysis.totalWords, 0, "Should process words")
    XCTAssertGreaterThan(analysis.uniqueWords, 0, "Should identify unique words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 0, "Should identify unique lemmas")
    
    // 2. Test specific words
    guard let mandatumEntry = analysis.dictionary["mandatum"] else {
        XCTFail("Mandatum lemma missing - check lemmatization")
        return
    }
    
    // Check forms using the actual storage format
    print("\n'mandatum' forms:", mandatumEntry.forms)
    XCTAssertGreaterThan(mandatumEntry.forms["mandatorum"] ?? 0, 0, 
                       "'mandatorum' (gen.pl) should appear in: 'mandatorum tuorum'")
    XCTAssertGreaterThan(mandatumEntry.forms["mandata"] ?? 0, 0,
                       "'mandata' (acc.pl) should appear in: 'mandata tua'")
    
    // 3. Test verb forms
    if let custodioEntry = analysis.dictionary["custodio"] {
        print("'custodio' forms:", custodioEntry.forms)
        XCTAssertGreaterThan(custodioEntry.forms["custodiam"] ?? 0, 0,
                          "Should find future form 'custodiam'")
    } else {
        XCTFail("Missing 'custodio' - check verb lemmatization")
    }
    
    // 4. Test verb parsing
    if let vivoEntry = analysis.dictionary["vivo"] {
        XCTAssertGreaterThan(vivoEntry.forms["vivifica"] ?? 0, 0,
                          "Should find imperative 'vivifica'")
    }
    
    // 5. Final debug output
    print("\n=== Analysis Summary ===")
    print("Total words:", analysis.totalWords)
    print("Unique lemmas:", analysis.dictionary.keys.count)
    print("'mandatum' count:", mandatumEntry.count)
}
func testAnalyzePsalm118He_Comprehensive() {
    let psalm119He = [
        "Legem pone mihi, Domine, viam justificationum tuarum, et exquiram eam semper.",
        "Da mihi intellectum, et scrutabor legem tuam, et custodiam illam in toto corde meo.",
        "Deduc me in semitam mandatorum tuorum, quia ipsam volui.",
        "Inclina cor meum in testimonia tua, et non in avaritiam.",
        "Averte oculos meos ne videant vanitatem; in via tua vivifica me.",
        "Statue servo tuo eloquium tuum in timore tuo.",
        "Amputa opprobrium meum quod suspicatus sum, quia judicia tua jucunda.",
        "Ecce concupivi mandata tua; in aequitate tua vivifica me."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm119He)
    
    // ===== 1. Core Validation =====
    XCTAssertGreaterThan(analysis.totalWords, 50, "Should process all words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 30, "Should identify 30+ unique lemmas")
    
    // ===== 2. Noun Validation =====
    let nounsToCheck = [
        ("mandatum", ["mandatorum", "mandata"], "commandment"),
        ("lex", ["legem", "tuam"], "law"), 
        ("testimonium", ["testimonia"], "testimony"),
        ("cor", ["corde", "meo"], "heart"),
        ("oculus", ["oculos", "meos"], "eye")
    ]
    
    for (lemma, forms, _) in nounsToCheck {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing noun lemma: \(lemma)")
            continue
        }
        
        
        for form in forms {
            XCTAssertGreaterThan(entry.forms[form] ?? 0, 0, 
                              "Missing form '\(form)' for \(lemma)")
        }
    }
    
    // ===== 3. Verb Validation =====
    let verbsToCheck = [
        ("custodio", ["custodiam"], "to guard"),
        ("vivo", ["vivo", "vivi"], "to live"),
        ("scrutor", ["scrutabor"], "to examine"),
        ("volo", ["volui"], "to want"),
        ("concupio", ["concupivi"], "to desire")
    ]
    
    for (lemma, forms, translation) in verbsToCheck {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing verb lemma: \(lemma)")
            continue
        }
        
        XCTAssertEqual(entry.entity?.partOfSpeech, .verb, "\(lemma) should be verb")
        
        for form in forms {
            print("translation verb: \(lemma) \(form) \(String(describing: entry.translation)) vs \(translation)")
            XCTAssertGreaterThan(entry.forms[form] ?? 0, 0,
                              "Missing form '\(form)' for \(lemma)")
        }
    }
    
    // ===== 4. Adjective/Pronoun Validation =====
    let adjectivesToCheck = [
        ("meus", ["mihi", "meo", "meos", "meum"], "my"),
        ("tuus", ["tuam", "tua", "tuo", "tuorum"], "your"),
        ("jucundus", ["jucunda"], "pleasant")
    ]
    
    for (lemma, forms, translation) in adjectivesToCheck {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing adjective/pronoun: \(lemma)")
            continue
        }

        
        for form in forms {
            print("translation: \(lemma) \(form) \(String(describing: entry.translation)) vs \(translation)")
            XCTAssertTrue(entry.translation?.contains(translation) != nil, "Incorrect translation for \(lemma) \(String(describing: entry.translation))")
        }
    }
    
    // ===== 5. Special Cases =====
    // Check Deus/Domine separately due to vocative
    if let dominusEntry = analysis.dictionary["dominus"] {
        XCTAssertGreaterThan(dominusEntry.forms["domine"] ?? 0, 0,
                          "Missing vocative 'Domine'")
    } else {
        XCTFail("Missing 'dominus' lemma")
    }
    
    // ===== 6. Debug Output =====
    print("\n=== Top 10 Lemmas ===")
    analysis.dictionary.keys
        .sorted()
        .prefix(10)
        .forEach { lemma in
            let entry = analysis.dictionary[lemma]!
            print("\(lemma): \(entry.count)x - \(entry.translation ?? "")")
        }
    
    print("\n=== Sample Forms ===")
    let sampleLemmas = ["mandatum", "custodio", "meus"]
    sampleLemmas.forEach { lemma in
        if let entry = analysis.dictionary[lemma] {
            print("\(lemma) forms:", entry.forms.sorted(by: { $0.key < $1.key }))
        }
    }
}

func testAnalyzePsalm118Teth() {
    let psalm119Teth = [
        "Bonitatem fecisti cum servo tuo, Domine, secundum verbum tuum.",
        "Bonitatem et disciplinam et scientiam doce me, quia mandatis tuis credidi.",
        "Priusquam humiliarer ego delinquebam; propterea eloquium tuum custodivi.",
        "Bonus es tu, et in bonitate tua doce me justificationes tuas.",
        "Multiplicata est super me iniquitas superborum; ego autem in toto corde meo scrutabor mandata tua.",
        "Coagulatum est sicut lac cor eorum; ego vero legem tuam meditatus sum.",
        "Bonum mihi quia humiliasti me, ut discam justificationes tuas.",
        "Bonum mihi lex oris tui super milia auri et argenti."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm119Teth)
    
    // ===== 1. Core Statistics =====
    XCTAssertGreaterThan(analysis.totalWords, 60, "Should process all words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 25, "Should identify 25+ unique lemmas")
    
    // ===== 2. Key Hebrew Letter Teth Words =====
    let tethWords = [
        ("bonus", ["bonitatem", "bonum", "bona"], "good"),
        ("humilio", ["humiliasti"], "to humble"),
        ("servus", ["servo"], "servant"),
        ("superbia", ["superborum"], "pride")
    ]
    
    for (lemma, forms, translation) in tethWords {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing Teth-themed lemma: \(lemma)")
            continue
        }
        
        XCTAssertEqual(entry.translation, translation, "Incorrect translation for \(lemma)")
        
        for form in forms {
            XCTAssertGreaterThan(entry.forms[form] ?? 0, 0,
                              "Missing Teth form '\(form)' for \(lemma)")
        }
    }
    
    // ===== 3. Grammatical Highlights =====
    // A. Supine construction "coagulatum est"
    if let coaguloEntry = analysis.dictionary["coagulo"] {
        XCTAssertGreaterThan(coaguloEntry.forms["coagulatum"] ?? 0, 0,
                          "Should find supine 'coagulatum'")
    } else {
        XCTFail("Missing 'coagulo' - check supine verb forms")
    }
    
    // B. Comparative "super milia"
    if let superEntry = analysis.dictionary["super"] {
        XCTAssertGreaterThan(superEntry.count, 0, "Missing comparative preposition")
    }
    
    // ===== 4. Verse-Specific Checks =====
    // Verse 65: "Bonitatem fecisti..."
    if let facioEntry = analysis.dictionary["facio"] {
        XCTAssertGreaterThan(facioEntry.forms["fecisti"] ?? 0, 0,
                          "Should find perfect 'fecisti'")
    }
    
    // Verse 71: "Bonum mihi quia humiliasti me..."
    if let discoEntry = analysis.dictionary["disco"] {
        XCTAssertGreaterThan(discoEntry.forms["discam"] ?? 0, 0,
                          "Should find subjunctive 'discam'")
    }
    
    // ===== 5. Debug Output =====
    print("\n=== Teth-Themed Lemmas ===")
    tethWords.forEach { lemma, _, _ in
        if let entry = analysis.dictionary[lemma] {
            print("\(lemma): \(entry.forms.filter { $0.value > 0 }.keys.sorted())")
        }
    }
    
    print("\n=== Grammatical Highlights ===")
    print("Supine forms:", analysis.dictionary["coagulo"]?.forms["coagulatum"] ?? 0)
    print("Comparative 'super':", analysis.dictionary["super"]?.count ?? 0)
}





func testAnalyzePsalm118Resh() {
    let psalm118Resh = [
        "Vide humilitatem meam, et eripe me: quia legem tuam non sum oblitus.",
        "Judica judicium meum, et redime me: propter eloquium tuum vivifica me.",
        "Longe a peccatoribus salus: quia justificationes tuas non exquisierunt.",
        "Misericordiae tuae multae, Domine: secundum judicium tuum vivifica me.",
        "Multi qui persequuntur me, et tribulant me: a testimoniis tuis non declinavi.",
        "Vidi praevaricantes, et tabescebam: quia eloquia tua non custodierunt.",
        "Vide quoniam mandata tua dilexi, Domine: in misericordia tua vivifica me.",
        "Principium verborum tuorum veritas: in aeternum omnia judicia justitiae tuae."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm118Resh)
    
    // ===== 1. Core Statistics =====
    XCTAssertGreaterThan(analysis.totalWords, 50, "Should process all words")
    XCTAssertGreaterThan(analysis.uniqueLemmas, 25, "Should identify 25+ unique lemmas")
    
    // ===== 2. Resh-Theme Words (ר) =====
    let reshWords = [
        ("video", ["vide", "vidi"], "see"),
        ("judicium", ["judicium", "judicia"], "judgment"),
        ("misericordia", ["misericordiae", "misericordia"], "mercy"),
        ("verbum", ["verborum"], "word"),
        ("justus", ["justitiae"], "just"),
        ("aeternus", ["aeternum"], "eternal"),
        ("redimo", ["redime"], "redeem"),
        ("praevaricator", ["praevaricantes"], "transgressor")
    ]
    
    if verbose {
        print("\n=== Resh-Themed Lemmas ===")
    }
    for (lemma, forms, translation) in reshWords {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing Resh-themed lemma: \(lemma)")
            continue
        }
        
        // Verify translation contains expected meaning
        XCTAssertTrue(entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                     "Incorrect translation for \(lemma)")
        
        // Verify each expected form exists
        for form in forms {
            let count = entry.forms[form] ?? 0
            if verbose {
                print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
            }
            XCTAssertGreaterThan(count, 0, "Missing form '\(form)' for \(lemma)")
        }
    }
    
    // ===== 3. Grammatical Highlights =====
    // A. Imperatives ("Vide", "Judica", "Vivifica")
    if let videoEntry = analysis.dictionary["video"] {
        XCTAssertGreaterThan(videoEntry.forms["vide"] ?? 0, 0,
                           "Should find imperative 'vide'")
    }
    
    if let judicoEntry = analysis.dictionary["judico"] {
        XCTAssertGreaterThan(judicoEntry.forms["judica"] ?? 0, 0,
                           "Should find imperative 'judica'")
    }
    
    // B. Perfect tense ("vidi", "tabescebam", "custodierunt")
    if let videoEntry = analysis.dictionary["video"] {
        XCTAssertGreaterThan(videoEntry.forms["vidi"] ?? 0, 0,
                           "Should find perfect 'vidi'")
    }
    
    // C. Substantive adjectives ("peccatoribus", "praevaricantes")
    if let peccoEntry = analysis.dictionary["peccator"] {
        XCTAssertGreaterThan(peccoEntry.forms["peccatoribus"] ?? 0, 0,
                           "Should find dative plural substantive")
    }
    
    // ===== 4. Verse-Specific Checks =====
    // Verse 153: "Vide humilitatem meam..."
    if let humilitasEntry = analysis.dictionary["humilitas"] {
        XCTAssertGreaterThan(humilitasEntry.forms["humilitatem"] ?? 0, 0,
                           "Should find accusative 'humilitatem'")
    }
    
    // Verse 160: "Principium verborum tuorum veritas..."
    if let principiumEntry = analysis.dictionary["principium"] {
        XCTAssertGreaterThan(principiumEntry.count, 0, "Missing 'principium'")
    }
    
    // ===== 5. Debug Output =====
    if verbose {
        print("\n=== Key Grammatical Features ===")
        print("Imperatives:")
        print("- vide:", analysis.dictionary["video"]?.forms["vide"] ?? 0)
        print("- judica:", analysis.dictionary["judico"]?.forms["judica"] ?? 0)
        
        print("\nPerfect Tense Forms:")
        print("- vidi:", analysis.dictionary["video"]?.forms["vidi"] ?? 0)
        print("- custodierunt:", analysis.dictionary["custodio"]?.forms["custodierunt"] ?? 0)
        
        print("\nSubstantive Adjectives:")
        print("- peccatoribus:", analysis.dictionary["peccator"]?.forms["peccatoribus"] ?? 0)
        print("- praevaricantes:", analysis.dictionary["praevaricator"]?.forms["praevaricantes"] ?? 0)
        
        print("\n=== Translation Samples ===")
        reshWords.forEach { lemma, _, _ in
            if let entry = analysis.dictionary[lemma] {
                print("\(lemma.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(entry.translation ?? "")")
            }
        }
    }
}
func testAnalyzePsalm118Sin() {
    let psalm118Sin = [
        "Principes persecuti sunt me gratis: et a verbis tuis formidavit cor meum.",
        "Laetor ego super eloquia tua: sicut qui invenit spolia multa.",
        "Mendacium odio habui, et abominatus sum: legem tuam dilexi.", // ACTUAL "mendacium" appears here
        "Septies in die laudem dixi tibi: super judicia justitiae tuae.",
        "Pax multa diligentibus legem tuam: et non est illis scandalum.", // ACTUAL "scandalum" appears here
        "Exspectabam salutem tuam, Domine: et mandata tua dilexi.",
        "Custodivit anima mea testimonia tua: et dilexi ea vehementer.",
        "Servavi mandata tua, et testimonia tua: quia omnes viae meae in conspectu tuo."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm118Sin)
    
    // ===== 1. Verify ACTUAL words in this category =====
    let confirmedWords = [
        ("mendacium", ["mendacium"], "falsehood"), // Present in verse 113
        ("scandalum", ["scandalum"], "stumbling block"), // Present in verse 115
        ("salus", ["salutem"], "salvation"), // "salutem" in verse 116
        ("diligo", ["dilexi"], "love"), // Appears twice
        ("lex", ["legem"], "law") // "legem" in verse 113
    ]
    
    print("\n=== ACTUAL Words in Psalm 118 Sin ===")
    for (lemma, forms, _) in confirmedWords {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing confirmed lemma: \(lemma)")
            continue
        }
        
        for form in forms {
            let count = entry.forms[form] ?? 0
            print("\(form): \(count > 0 ? "✅" : "❌")")
            XCTAssertGreaterThan(count, 0, 
                              "Confirmed word '\(form)' (\(lemma)) missing in analysis")
        }
    }
    
    // ===== 2. Verify grammatical forms =====
    // Perfect tense "dilexi" (appears twice)
    if let diligoEntry = analysis.dictionary["diligo"] {
        let dilexiCount = diligoEntry.forms["dilexi"] ?? 0
        XCTAssertGreaterThanOrEqual(dilexiCount, 2, 
                                  "Expected at least 2 occurrences of 'dilexi'")
    }
    
    // Participle "diligentibus" (dative plural)
    if let diligoEntry = analysis.dictionary["diligo"] {
        XCTAssertGreaterThan(
            diligoEntry.forms["diligentibus"] ?? 0, 
            0,
            "Should find participle 'diligentibus'"
        )
    }
    
    // ===== 3. Debug output =====
    if(verbose) {
        print("\n=== Full Analysis ===")
        print("Total words:", analysis.totalWords)
        print("Unique lemmas:", analysis.uniqueLemmas)
        print("'diligo' forms:", analysis.dictionary["diligo"]?.forms ?? [:])
        print("'mendacium' forms:", analysis.dictionary["mendacium"]?.forms ?? [:])
        print("'scandalum' forms:", analysis.dictionary["scandalum"]?.forms ?? [:])
    }
}

}