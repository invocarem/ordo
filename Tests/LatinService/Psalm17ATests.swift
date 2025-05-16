import XCTest
@testable import LatinService

class Psalm17ATests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm17A = [
        "Diligo te, Domine, fortitudo mea;",
        "Dominus firmamentum meum, et refugium meum, et liberator meus.",
        "Deus meus, adjutor meus, et sperabo in eum;",
        "protector meus, et cornu salutis meae, et susceptor meus.",
        "Laudans invocabo Dominum, et ab inimicis meis salvus ero.",
        "Circumdederunt me dolores mortis, et torrentes iniquitatis conturbaverunt me.",
        "Dolores inferni circumdederunt me, praeoccupaverunt me laquei mortis.",
        "In tribulatione mea invocavi Dominum, et ad Deum meum clamavi;",
        "exaudivit de templo sancto suo vocem meam, et clamor meus in conspectu ejus introivit in aures ejus.",
        "Commota est, et contremuit terra; fundamenta montium conturbata sunt,",
        "et commota sunt, quoniam iratus est eis.",
        "Ascendit fumus in ira ejus, et ignis a facie ejus exarsit;",
        "carbones succensi sunt ab eo.",
        "Inclinavit coelos, et descendit, et caligo sub pedibus ejus.",
        "Et ascendit super cherubim, et volavit; volavit super pennas ventorum.",
        "Et posuit tenebras latibulum suum; in circuitu ejus tabernaculum ejus,",
        "tenebrosa aqua in nubibus aeris.",
        "Praefulgor ante eum nubes, grando et carbones ignis.",
        "Et intonuit de coelo Dominus, et Altissimus dedit vocem suam:",
        "grandinem et carbones ignis.",
        "Et misit sagittas suas, et dissipavit eos;",
        "fulgura multiplicavit, et conturbavit eos.",
        "Et apparuerunt fontes aquarum, et revelata sunt fundamenta orbis terrarum",
        "ab increpatione tua, Domine, ab inspiratione spiritus irae tuae.",
        "Misit de summo, et accepit me; assumpsit me de aquis multis.",
        "Eripuit me de inimico meo potentissimo, et ab his qui oderunt me:",
        "quoniam confortati sunt super me.",
        "Praevenerunt me in die afflictionis meae, et factus est Dominus protector meus.",
        "Et eduxit me in latitudinem; salvum me fecit, quoniam voluit me.",
        "Retribuet mihi Dominus secundum justitiam meam, et secundum puritatem manuum mearum retribuet mihi.",
        "Quia custodivi vias Domini, nec impie gessi a Deo meo.",
        "Quoniam omnia judicia ejus in conspectu meo, et justitias ejus non repuli a me.",
        "Et ero immaculatus cum eo, et observabo me ab iniquitate mea.",
        "Et retribuet mihi Dominus secundum justitiam meam, et secundum puritatem manuum mearum in conspectu oculorum ejus."
    ]
    
    // MARK: - Test Cases
    // MARK: - Grouped Line Tests for Psalm 17 (A)
func testPsalm17ALines1and2() {
    let line1 = psalm17A[0] // "Diligo te, Domine, fortitudo mea;"
    let line2 = psalm17A[1] // "Dominus firmamentum meum, et refugium meum, et liberator meus."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("diligo", ["diligo"], "love"),
        ("dominus", ["domine", "dominus"], "Lord"),
        ("fortitudo", ["fortitudo"], "strength"),
        ("firmamentum", ["firmamentum"], "support"),
        ("refugium", ["refugium"], "refuge"),
        ("liberator", ["liberator"], "deliverer")
    ]
    
    if verbose {
        print("\nPSALM 17:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Personal Devotion: 'Diligo te' (I love you)")
        print("2. Divine Protection: Triple declaration of God as support, refuge, and deliverer")
        print("3. Possessive Language: Repeated 'meum/meus' (my) showing personal relationship")
    }
    
    // Devotion assertions
    XCTAssertEqual(analysis.dictionary["diligo"]?.forms["diligo"], 1, "Should find love declaration")
    
    // Divine roles
    XCTAssertEqual(analysis.dictionary["firmamentum"]?.forms["firmamentum"], 1, "Should find support reference")
    XCTAssertEqual(analysis.dictionary["refugium"]?.forms["refugium"], 1, "Should find refuge reference")
    XCTAssertEqual(analysis.dictionary["liberator"]?.forms["liberator"], 1, "Should find deliverer reference")
    
    // Possessive pronouns
    let possessiveCount = ["mea", "meum", "meus"].reduce(0) {
        $0 + (analysis.dictionary["meus"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(possessiveCount, 4, "Should find all possessive pronouns")
}

func testPsalm17ALines3and4() {
    let line3 = psalm17A[2] // "Deus meus, adjutor meus, et sperabo in eum;"
    let line4 = psalm17A[3] // "protector meus, et cornu salutis meae, et susceptor meus."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("deus", ["deus"], "God"),
        ("adjutor", ["adjutor"], "helper"),
        ("spero", ["sperabo"], "hope"),
        ("protector", ["protector"], "protector"),
        ("cornu", ["cornu"], "horn"),
        ("salus", ["salutis"], "salvation"),
        ("susceptor", ["susceptor"], "upholder")
    ]
    
    if verbose {
        print("\nPSALM 17:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Compound Divine Titles: Six roles declared in two verses")
        print("2. Future Hope: 'sperabo in eum' (I will hope in him)")
        print("3. Salvation Imagery: 'cornu salutis' (horn of salvation)")
    }
    
    // Divine titles
    XCTAssertEqual(analysis.dictionary["adjutor"]?.forms["adjutor"], 1, "Should find helper reference")
    XCTAssertEqual(analysis.dictionary["protector"]?.forms["protector"], 1, "Should find protector reference")
    
    // Future tense
    XCTAssertEqual(analysis.dictionary["spero"]?.forms["sperabo"], 1, "Should find future hope verb")
    
    // Salvation metaphor
    XCTAssertEqual(analysis.dictionary["cornu"]?.forms["cornu"], 1, "Should find horn metaphor")
}

func testPsalm17ALines5and6() {
    let line5 = psalm17A[4] // "Laudans invocabo Dominum, et ab inimicis meis salvus ero."
    let line6 = psalm17A[5] // "Circumdederunt me dolores mortis, et torrentes iniquitatis conturbaverunt me."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("laudo", ["laudans"], "praise"),
        ("invoco", ["invocabo"], "call upon"),
        ("inimicus", ["inimicis"], "enemy"),
        ("salvus", ["salvus"], "safe"),
        ("circumdo", ["circumdederunt"], "surround"),
        ("dolor", ["dolores"], "pain"),
        ("mors", ["mortis"], "death"),
        ("torrens", ["torrentes"], "torrent"),
        ("iniquitas", ["iniquitatis"], "wickedness"),
        ("conturbo", ["conturbaverunt"], "trouble")
    ]
    
    if verbose {
        print("\nPSALM 17:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Praise and Petition: 'Laudans invocabo' (Praising I will call)")
        print("2. Deliverance Promise: 'salvus ero' (I will be safe)")
        print("3. Distress Imagery: 'dolores mortis' (pains of death) and 'torrentes iniquitatis' (torrents of wickedness)")
    }
    
    // Worship assertions
    XCTAssertEqual(analysis.dictionary["laudo"]?.forms["laudans"], 1, "Should find praising participle")
    XCTAssertEqual(analysis.dictionary["invoco"]?.forms["invocabo"], 1, "Should find future invocation")
    
    // Danger imagery
    XCTAssertEqual(analysis.dictionary["dolor"]?.forms["dolores"], 1, "Should find pains reference")
    XCTAssertEqual(analysis.dictionary["torrens"]?.forms["torrentes"], 1, "Should find torrents reference")
    
    // Contrast between verses
    let hasSalvation = analysis.dictionary["salvus"]?.forms["salvus"] ?? 0 > 0
    let hasDanger = analysis.dictionary["conturbo"]?.forms["conturbaverunt"] ?? 0 > 0
    XCTAssertTrue(hasSalvation && hasDanger, "Should contrast salvation promise with present danger")
}

// Continue with similar implementations for the remaining verse pairs...

func testPsalm17ALines7and8() {
    let line7 = psalm17A[6] // "Dolores inferni circumdederunt me, praeoccupaverunt me laquei mortis."
    let line8 = psalm17A[7] // "In tribulatione mea invocavi Dominum, et ad Deum meum clamavi;"
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("infernus", ["inferni"], "hell"),
        ("praeoccupo", ["praeoccupaverunt"], "seize beforehand"),
        ("laqueus", ["laquei"], "snare"),
        ("tribulatio", ["tribulatione"], "trouble"),
        ("invoco", ["invocavi"], "call upon"),
        ("clamo", ["clamavi"], "cry out")
    ]
    
    if verbose {
        print("\nPSALM 17:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Mortal Danger: 'laquei mortis' (snares of death)")
        print("2. Desperate Prayer: Past tense 'invocavi...clamavi' (I called...I cried)")
        print("3. Transition: From description of danger to record of prayer")
    }
    
    // Death imagery
    XCTAssertEqual(analysis.dictionary["laqueus"]?.forms["laquei"], 1, "Should find snares reference")
    XCTAssertEqual(analysis.dictionary["infernus"]?.forms["inferni"], 1, "Should find hell reference")
    
    // Prayer verbs
    XCTAssertEqual(analysis.dictionary["invoco"]?.forms["invocavi"], 1, "Should find past tense call")
    XCTAssertEqual(analysis.dictionary["clamo"]?.forms["clamavi"], 1, "Should find past tense cry")
}

// Continue implementing similar tests for the remaining verse pairs...
// Lines 9-10, 11-12, etc. following the same pattern

func testPsalm17ALines9and10() {
    let line9 = psalm17A[8] // "exaudivit de templo sancto suo vocem meam, et clamor meus in conspectu ejus introivit in aures ejus."
    let line10 = psalm17A[9] // "Commota est, et contremuit terra; fundamenta montium conturbata sunt,"
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("exaudio", ["exaudivit"], "hear"),
        ("templum", ["templo"], "temple"),
        ("sanctus", ["sancto"], "holy"),
        ("vox", ["vocem"], "voice"),
        ("clamor", ["clamor"], "cry"),
        ("conspectus", ["conspectu"], "presence"),
        ("auris", ["aures"], "ear"),
        ("commoveo", ["commota", "conturbata"], "shake"),
        ("contremisco", ["contremuit"], "tremble"),
        ("fundamentum", ["fundamenta"], "foundation"),
        ("mons", ["montium"], "mountain")
    ]
    
    if verbose {
        print("\nPSALM 17:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Answered Prayer: 'exaudivit...introivit' (heard...entered)")
        print("2. Cosmic Response: Earth shaking at God's intervention")
        print("3. Sensory Language: Voice, cry, ears - emphasizing God's attentiveness")
    }
    
    // Divine response
    XCTAssertEqual(analysis.dictionary["exaudio"]?.forms["exaudivit"], 1, "Should find hearing verb")
    XCTAssertEqual(analysis.dictionary["auris"]?.forms["aures"], 1, "Should find ear reference")
    
    // Earthly reaction
    XCTAssertGreaterThan(
        (analysis.dictionary["commoveo"]?.forms.values.reduce(0, +) ?? 0) +
        (analysis.dictionary["contremisco"]?.forms.values.reduce(0, +) ?? 0),
        0,
        "Should find shaking/trembling verbs"
    )
}

func testPsalm17ALines11and12() {
    let line11 = psalm17A[10] // "et commota sunt, quoniam iratus est eis."
    let line12 = psalm17A[11] // "Ascendit fumus in ira ejus, et ignis a facie ejus exarsit;"
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("commoveo", ["commota"], "shake"),
        ("irascor", ["iratus"], "be angry"),
        ("ascendo", ["ascendit"], "rise"),
        ("fumus", ["fumus"], "smoke"),
        ("ira", ["ira", "ejus"], "wrath"),
        ("ignis", ["ignis"], "fire"),
        ("facies", ["facie"], "face"),
        ("exardesco", ["exarsit"], "blaze up")
    ]
    
    if verbose {
        print("\nPSALM 17:11-12 ANALYSIS:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Wrath: 'iratus est' (he was angry) with cosmic effects")
        print("2. Fire Imagery: Smoke and fire as manifestations of God's presence")
        print("3. Theophany Elements: Classic signs of divine appearance (smoke, fire)")
    }
    
    // Divine anger assertions
    XCTAssertEqual(analysis.dictionary["irascor"]?.forms["iratus"], 1, "Should find anger verb")
    XCTAssertEqual(analysis.dictionary["ira"]?.forms["ira"], 1, "Should find wrath reference")
    
    // Theophany elements
    XCTAssertEqual(analysis.dictionary["fumus"]?.forms["fumus"], 1, "Should find smoke reference")
    XCTAssertEqual(analysis.dictionary["ignis"]?.forms["ignis"], 1, "Should find fire reference")
    
    // Test verb sequence
    let perfectVerbs = ["iratus", "ascendit", "exarsit"].reduce(0) {
        $0 + (analysis.dictionary["irascor"]?.forms[$1] ?? 0)
        + (analysis.dictionary["ascendo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["exardesco"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(perfectVerbs, 3, "Should find all perfect tense verbs")
}

func testPsalm17ALines13and14() {
    let line13 = psalm17A[12] // "carbones succensi sunt ab eo."
    let line14 = psalm17A[13] // "Inclinavit coelos, et descendit, et caligo sub pedibus ejus."
    let combinedText = line13 + " " + line14
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("carbo", ["carbones"], "coal"),
        ("succendo", ["succensi"], "kindle"),
        ("inclino", ["inclinavit"], "bow"),
        ("coelum", ["coelos"], "heaven"),
        ("descendo", ["descendit"], "descend"),
        ("caligo", ["caligo"], "darkness"),
        ("pes", ["pedibus"], "feet")
    ]
    
    if verbose {
        print("\nPSALM 17:13-14 ANALYSIS:")
        print("13: \"\(line13)\"")
        print("14: \"\(line14)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Intensified Fire: 'carbones succensi' (burning coals)")
        print("2. Cosmic Descent: God bending heaven to come down")
        print("3. Mysterious Presence: Darkness under feet showing divine mystery")
    }
    
    // Fire imagery
    XCTAssertEqual(analysis.dictionary["carbo"]?.forms["carbones"], 1, "Should find coals reference")
    XCTAssertEqual(analysis.dictionary["succendo"]?.forms["succensi"], 1, "Should find kindling verb")
    
    // Descent imagery
    XCTAssertEqual(analysis.dictionary["inclino"]?.forms["inclinavit"], 1, "Should find bowing verb")
    XCTAssertEqual(analysis.dictionary["descendo"]?.forms["descendit"], 1, "Should find descent verb")
    
    // Contrast test
    let hasFire = analysis.dictionary["carbo"] != nil
    let hasDarkness = analysis.dictionary["caligo"] != nil
    XCTAssertTrue(hasFire && hasDarkness, "Should contain both fire and darkness imagery")
}
// Continue implementing the remaining verse pairs...
// [Rest of the implementation would follow the same pattern]


    func testDivineWarfareImagery() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let warfareTerms = [
            ("sagitta", ["sagittas"], "arrow"),
            ("fulgur", ["fulgura"], "lightning"),
            ("tono", ["intonuit"], "thunder"),
            ("ignis", ["ignis"], "fire"),
            ("carbo", ["carbones"], "coals"),
            ("grando", ["grandinem", "grando"], "hail"),
            ("fumus", ["fumus"], "smoke")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: warfareTerms)
    }
    
    func testDivineProtectionTitles() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let protectionTerms = [
            ("firmamentum", ["firmamentum"], "fortress"),
            ("susceptor", ["susceptor"], "upholder"),
            ("cornu", ["cornu"], "horn"),
            ("latibulum", ["latibulum"], "hiding place"),
            ("tabernaculum", ["tabernaculum"], "tent")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testCosmicDisturbances() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let cosmicTerms = [
            ("contremo", ["contremuit"], "tremble"),
            ("inclino", ["Inclinavit"], "bow down"),
            ("caligo", ["caligo"], "darkness"),
            ("fundamentum", ["fundamenta", "fundamenta"], "foundation"),
            ("cherub", ["cherubim"], "cherubim")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: cosmicTerms)
    }
    
    func testDeliveranceVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let deliveranceTerms = [
            ("eripio", ["Eripuit"], "rescue"),
            ("assumo", ["assumpsit"], "take up"),
            ("educo", ["eduxit"], "lead out"),
            ("praevenio", ["Praevenerunt"], "confront"),
            ("retribuo", ["Retribuet", "retribuet"], "repay")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: deliveranceTerms)
    }
    
    func testPurityVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let purityTerms = [
            ("immaculatus", ["immaculatus"], "blameless"),
            ("puritas", ["puritatem"], "purity"),
            ("iniquitas", ["iniquitate", "iniquitatis"], "wickedness"),
            ("justitia", ["justitiam", "justitias"], "righteousness"),
            ("judicium", ["judicia"], "judgment")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: purityTerms)
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
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}