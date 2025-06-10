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
        ("commoveo", ["commota"], "shake"),
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
    latinService.configureDebugging(target: "coelum")
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
func testPsalm17ALines15and16() {
    let line15 = psalm17A[14] // "Et ascendit super cherubim, et volavit; volavit super pennas ventorum."
    let line16 = psalm17A[15] // "Et posuit tenebras latibulum suum; in circuitu ejus tabernaculum ejus,"
    let combinedText = line15 + " " + line16
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("ascendo", ["ascendit"], "ascend"),
        ("cherub", ["cherubim"], "cherubim"),
        ("volo", ["volavit"], "fly"),
        ("penna", ["pennas"], "wing"),
        ("ventus", ["ventorum"], "wind"),
        ("pono", ["posuit"], "place"),
        ("tenebrae", ["tenebras"], "darkness"),
        ("latibulum", ["latibulum"], "hiding place"),
        ("circuitus", ["circuitu"], "surrounding"),
        ("tabernaculum", ["tabernaculum"], "tent")
    ]
    
    if verbose {
        print("\nPSALM 17:15-16 ANALYSIS:")
        print("15: \"\(line15)\"")
        print("16: \"\(line16)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Mobility: Double 'volavit' emphasizing God's swift movement")
        print("2. Mysterious Presence: Darkness as God's hiding place")
        print("3. Mobile Sanctuary: Tabernacle imagery suggesting God's portable presence")
    }
    
    // Flight imagery
    XCTAssertEqual(analysis.dictionary["volo"]?.forms["volavit"], 2, "Should find two instances of flying")
    XCTAssertEqual(analysis.dictionary["cherub"]?.forms["cherubim"], 1, "Should find cherubim reference")
    
    // Divine dwelling
    XCTAssertEqual(analysis.dictionary["latibulum"]?.forms["latibulum"], 1, "Should find hiding place")
    XCTAssertEqual(analysis.dictionary["tabernaculum"]?.forms["tabernaculum"], 1, "Should find tent reference")
}

func testPsalm17ALines17and18() {
    let line17 = psalm17A[16] // "tenebrosa aqua in nubibus aeris."
    let line18 = psalm17A[17] // "Praefulgor ante eum nubes, grando et carbones ignis."
    let combinedText = line17 + " " + line18
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("tenebrosus", ["tenebrosa"], "dark"),
        ("aqua", ["aqua"], "water"),
        ("nubes", ["nubibus", "nubes"], "cloud"),
        ("aer", ["aeris"], "air"),
        ("praefulgor", ["praefulgor"], "shine forth"),
        ("grando", ["grando"], "hail"),
        ("carbo", ["carbones"], "coal"),
        ("ignis", ["ignis"], "fire")
    ]
    
    if verbose {
        print("\nPSALM 17:17-18 ANALYSIS:")
        print("17: \"\(line17)\"")
        print("18: \"\(line18)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Atmospheric Contrast: Dark waters vs shining clouds")
        print("2. Storm Imagery: Hail and fire coals as divine weapons")
        print("3. Elemental Juxtaposition: Water and fire coexisting")
    }
    
    // Elemental contrast
    XCTAssertEqual(analysis.dictionary["aqua"]?.forms["aqua"], 1, "Should find water reference")
    XCTAssertEqual(analysis.dictionary["ignis"]?.forms["ignis"], 1, "Should find fire reference")
    
    // Storm elements
    XCTAssertEqual(analysis.dictionary["grando"]?.forms["grando"], 1, "Should find hail reference")
    XCTAssertEqual(analysis.dictionary["carbo"]?.forms["carbones"], 1, "Should find coals reference")
}

func testPsalm17ALines19and20() {
    let line19 = psalm17A[18] // "Et intonuit de coelo Dominus, et Altissimus dedit vocem suam:"
    let line20 = psalm17A[19] // "grandinem et carbones ignis."
    let combinedText = line19 + " " + line20
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("intono", ["intonuit"], "thunder"),
        ("coelum", ["coelo"], "heaven"),
        ("dominus", ["dominus"], "Lord"),
        ("altissimus", ["altissimus"], "Most High"),
        ("do", ["dedit"], "give"),
        ("vox", ["vocem"], "voice"),
        ("grando", ["grandinem"], "hail"),
        ("carbo", ["carbones"], "coal"),
        ("ignis", ["ignis"], "fire")
    ]
    
    if verbose {
        print("\nPSALM 17:19-20 ANALYSIS:")
        print("19: \"\(line19)\"")
        print("20: \"\(line20)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Voice: Thunder as God's speech")
        print("2. Compound Title: 'Dominus...Altissimus' showing authority and transcendence")
        print("3. Storm Artillery: Hail and fire as divine projectiles")
    }
    
    // Divine voice
    XCTAssertEqual(analysis.dictionary["intono"]?.forms["intonuit"], 1, "Should find thundering verb")
    XCTAssertEqual(analysis.dictionary["vox"]?.forms["vocem"], 1, "Should find voice reference")
    
    // Divine titles
    XCTAssertEqual(analysis.dictionary["dominus"]?.forms["dominus"], 1, "Should find Lord reference")
    XCTAssertEqual(analysis.dictionary["altissimus"]?.forms["altissimus"], 1, "Should find Most High reference")
}

func testPsalm17ALines21and22() {
    let line21 = psalm17A[20] // "Et misit sagittas suas, et dissipavit eos;"
    let line22 = psalm17A[21] // "fulgura multiplicavit, et conturbavit eos."
    let combinedText = line21 + " " + line22
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("mitto", ["misit"], "send"),
        ("sagitta", ["sagittas"], "arrow"),
        ("dissipo", ["dissipavit"], "scatter"),
        ("fulgur", ["fulgura"], "lightning"),
        ("multiplico", ["multiplicavit"], "multiply"),
        ("conturbo", ["conturbavit"], "confound")
    ]
    
    if verbose {
        print("\nPSALM 17:21-22 ANALYSIS:")
        print("21: \"\(line21)\"")
        print("22: \"\(line22)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Warfare: Arrows and lightning as weapons")
        print("2. Enemy Defeat: Double verbs of scattering and confounding")
        print("3. Perfect Tense: Completed actions showing decisive victory")
    }
    
    // Warfare imagery
    XCTAssertEqual(analysis.dictionary["sagitta"]?.forms["sagittas"], 1, "Should find arrows reference")
    XCTAssertEqual(analysis.dictionary["fulgur"]?.forms["fulgura"], 1, "Should find lightning reference")
    
    // Victory verbs
    XCTAssertEqual(analysis.dictionary["dissipo"]?.forms["dissipavit"], 1, "Should find scattering verb")
    XCTAssertEqual(analysis.dictionary["conturbo"]?.forms["conturbavit"], 1, "Should find confounding verb")
}

func testPsalm17ALines23and24() {
    let line23 = psalm17A[22] // "Et apparuerunt fontes aquarum, et revelata sunt fundamenta orbis terrarum"
    let line24 = psalm17A[23] // "ab increpatione tua, Domine, ab inspiratione spiritus irae tuae."
    let combinedText = line23 + " " + line24
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("appareo", ["apparuerunt"], "appear"),
        ("fons", ["fontes"], "spring"),
        ("aqua", ["aquarum"], "water"),
        ("revelo", ["revelata"], "reveal"),
        ("fundamentum", ["fundamenta"], "foundation"),
        ("orbis", ["orbis"], "world"),
        ("terra", ["terrarum"], "earth"),
        ("increpatio", ["increpatione"], "rebuke"),
        ("inspiratio", ["inspiratione"], "breath"),
        ("spiritus", ["spiritus"], "spirit"),
        ("ira", ["irae"], "wrath")
    ]
    
    if verbose {
        print("\nPSALM 17:23-24 ANALYSIS:")
        print("23: \"\(line23)\"")
        print("24: \"\(line24)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Cosmic Exposure: Waters and foundations revealed")
        print("2. Divine Breath: 'spiritus irae' as expression of God's power")
        print("3. Cause and Effect: Rebuke leading to cosmic upheaval")
    }
    
    // Cosmic imagery
    XCTAssertEqual(analysis.dictionary["fons"]?.forms["fontes"], 1, "Should find springs reference")
    XCTAssertEqual(analysis.dictionary["fundamentum"]?.forms["fundamenta"], 1, "Should find foundations reference")
    
    // Divine action
    XCTAssertEqual(analysis.dictionary["increpatio"]?.forms["increpatione"], 1, "Should find rebuke reference")
    XCTAssertEqual(analysis.dictionary["ira"]?.forms["irae"], 1, "Should find wrath reference")
}

func testPsalm17ALines25and26() {
    let line25 = psalm17A[24] // "Misit de summo, et accepit me; assumpsit me de aquis multis."
    let line26 = psalm17A[25] // "Eripuit me de inimico meo potentissimo, et ab his qui oderunt me:"
    let combinedText = line25 + " " + line26
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("mitto", ["misit"], "send"),
        ("summus", ["summo"], "height"),
        ("accipio", ["accepit"], "take"),
        ("assumo", ["assumpsit"], "lift up"),
        ("aqua", ["aquis"], "water"),
        ("multus", ["multis"], "many"),
        ("eripio", ["eripuit"], "deliver"),
        ("inimicus", ["inimico"], "enemy"),
        ("potens", ["potentissimo"], "powerful"),
        ("odi", ["oderunt"], "hate")
    ]
    
    if verbose {
        print("\nPSALM 17:25-26 ANALYSIS:")
        print("25: \"\(line25)\"")
        print("26: \"\(line26)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Rescue: Triple verbs of taking, lifting, and delivering")
        print("2. Danger Imagery: Many waters and powerful enemies")
        print("3. Personal Testimony: Shift to first-person account of salvation")
    }
    
    // Rescue verbs
    XCTAssertEqual(analysis.dictionary["accipio"]?.forms["accepit"], 1, "Should find taking verb")
    XCTAssertEqual(analysis.dictionary["eripio"]?.forms["eripuit"], 1, "Should find delivering verb")
    
    // Danger description
    XCTAssertEqual(analysis.dictionary["aqua"]?.forms["aquis"], 1, "Should find waters reference")
    XCTAssertEqual(analysis.dictionary["potens"]?.forms["potentissimo"], 1, "Should find powerful enemy reference")
}

func testPsalm17ALines27and28() {
    let line27 = psalm17A[26] // "quoniam confortati sunt super me."
    let line28 = psalm17A[27] // "Praevenerunt me in die afflictionis meae, et factus est Dominus protector meus."
    let combinedText = line27 + " " + line28
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("conforto", ["confortati"], "strengthen"),
        ("praevenio", ["praevenerunt"], "confront"),
        ("dies", ["die"], "day"),
        ("afflictio", ["afflictionis"], "trouble"),
        ("fio", ["factus"], "become"),
        ("dominus", ["dominus"], "Lord"),
        ("protector", ["protector"], "protector")
    ]
    
    if verbose {
        print("\nPSALM 17:27-28 ANALYSIS:")
        print("27: \"\(line27)\"")
        print("28: \"\(line28)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Enemy Strength: 'confortati sunt' showing opposition's power")
        print("2. Timely Intervention: 'in die afflictionis' at the right moment")
        print("3. Role Transformation: God 'becoming' a protector in crisis")
    }
    
    // Enemy description
    XCTAssertEqual(analysis.dictionary["conforto"]?.forms["confortati"], 1, "Should find strengthened enemies")
    XCTAssertEqual(analysis.dictionary["praevenio"]?.forms["praevenerunt"], 1, "Should find confrontation verb")
    
    // Divine protection
    XCTAssertEqual(analysis.dictionary["protector"]?.forms["protector"], 1, "Should find protector reference")
}

func testPsalm17ALines29and30() {
    let line29 = psalm17A[28] // "Et eduxit me in latitudinem; salvum me fecit, quoniam voluit me."
    let line30 = psalm17A[29] // "Retribuet mihi Dominus secundum justitiam meam, et secundum puritatem manuum mearum retribuet mihi."
    let combinedText = line29 + " " + line30
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("educo", ["eduxit"], "lead out"),
        ("latitudo", ["latitudinem"], "broad place"),
        ("salvus", ["salvum"], "safe"),
        ("facio", ["fecit"], "make"),
        ("volo", ["voluit"], "will"),
        ("retribuo", ["retribuet"], "repay"),
        ("justitia", ["justitiam"], "righteousness"),
        ("puritas", ["puritatem"], "purity"),
        ("manus", ["manuum"], "hands")
    ]
    
    if verbose {
        print("\nPSALM 17:29-30 ANALYSIS:")
        print("29: \"\(line29)\"")
        print("30: \"\(line30)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Liberation: From confinement to spacious place")
        print("2. Divine Will: 'quoniam voluit me' showing God's pleasure")
        print("3. Righteous Reward: Double 'retribuet' with justice and purity")
    }
    
    // Deliverance imagery
    XCTAssertEqual(analysis.dictionary["latitudo"]?.forms["latitudinem"], 1, "Should find broad place reference")
    XCTAssertEqual(analysis.dictionary["salvus"]?.forms["salvum"], 1, "Should find safety reference")
    
    // Reward language
    XCTAssertEqual(analysis.dictionary["retribuo"]?.forms["retribuet"], 2, "Should find two repayments")
    XCTAssertEqual(analysis.dictionary["justitia"]?.forms["justitiam"], 1, "Should find righteousness reference")
}

func testPsalm17ALines31and32() {
    let line31 = psalm17A[30] // "Quia custodivi vias Domini, nec impie gessi a Deo meo."
    let line32 = psalm17A[31] // "Quoniam omnia judicia ejus in conspectu meo, et justitias ejus non repuli a me."
    let combinedText = line31 + " " + line32
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("custodio", ["custodivi"], "keep"),
        ("via", ["vias"], "way"),
        ("dominus", ["domini"], "Lord"),
        ("impius", ["impie"], "wickedly"),
        ("gero", ["gessi"], "behave"),
        ("deus", ["deo"], "God"),
        ("judicium", ["judicia"], "judgment"),
        ("conspectus", ["conspectu"], "sight"),
        ("justitia", ["justitias"], "justice"),
        ("repello", ["repuli"], "reject")
    ]
    
    if verbose {
        print("\nPSALM 17:31-32 ANALYSIS:")
        print("31: \"\(line31)\"")
        print("32: \"\(line32)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Covenant Faithfulness: 'custodivi vias' showing obedience")
        print("2. Double Negation: 'nec impie...non repuli' emphasizing loyalty")
        print("3. Judicial Awareness: Keeping God's judgments in view")
    }
    
    // Obedience language
    XCTAssertEqual(analysis.dictionary["custodio"]?.forms["custodivi"], 1, "Should find keeping verb")
    XCTAssertEqual(analysis.dictionary["repello"]?.forms["repuli"], 1, "Should find rejection verb (negated)")
    
    // Divine standards
    XCTAssertEqual(analysis.dictionary["judicium"]?.forms["judicia"], 1, "Should find judgments reference")
    XCTAssertEqual(analysis.dictionary["justitia"]?.forms["justitias"], 1, "Should find justice reference")
}

func testPsalm17ALines33and34() {
    let line33 = psalm17A[32] // "Et ero immaculatus cum eo, et observabo me ab iniquitate mea."
    let line34 = psalm17A[33] // "Et retribuet mihi Dominus secundum justitiam meam, et secundum puritatem manuum mearum in conspectu oculorum ejus."
    let combinedText = line33 + " " + line34
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("immaculatus", ["immaculatus"], "undefiled"),
        ("observo", ["observabo"], "keep"),
        ("iniquitas", ["iniquitate"], "sin"),
        ("retribuo", ["retribuet"], "repay"),
        ("dominus", ["dominus"], "Lord"),
        ("justitia", ["justitiam"], "righteousness"),
        ("puritas", ["puritatem"], "purity"),
        ("manus", ["manuum"], "hands"),
        ("conspectus", ["conspectu"], "sight"),
        ("oculus", ["oculorum"], "eyes")
    ]
    
    if verbose {
        print("\nPSALM 17:33-34 ANALYSIS:")
        print("33: \"\(line33)\"")
        print("34: \"\(line34)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Future Purity: 'ero immaculatus' as aspiration")
        print("2. Self-Watchfulness: 'observabo me' showing personal responsibility")
        print("3. Divine Perspective: Reward according to God's sight ('oculorum ejus')")
    }
    
    // Purity language
    XCTAssertEqual(analysis.dictionary["immaculatus"]?.forms["immaculatus"], 1, "Should find blameless reference")
    XCTAssertEqual(analysis.dictionary["puritas"]?.forms["puritatem"], 1, "Should find purity reference")
    
    // Divine perspective
    XCTAssertEqual(analysis.dictionary["oculus"]?.forms["oculorum"], 1, "Should find eyes reference")
    XCTAssertEqual(analysis.dictionary["conspectus"]?.forms["conspectu"], 1, "Should find sight reference")
}

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
            ("immaculatus", ["immaculatus"], "spotless"),
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