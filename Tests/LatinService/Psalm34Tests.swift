import XCTest
@testable import LatinService

class Psalm34Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 34, category: "prayer")
    
    // MARK: - Test Data (Psalm 34)
    let psalm34 = [
        "Iudica, Domine, nocentes me; expugna impugnantes me.",
        "Apprehende arma et scutum, et exsurge in adiutorium mihi.",
        "Effunde frameam, et conclude adversus eos qui persequuntur me; dic animae meae: Salus tua ego sum.",
        "Confundantur et revereantur qui quaerunt animam meam; avertantur retrorsum et erubescant qui cogitant mihi mala.",
        "Fiant tamquam pulvis ante faciem venti; et angelus Domini coarctans eos.",
        "Fiat via illorum tenebrae et lubricum; et angelus Domini persequens illos.",
        "Quoniam gratis absconderunt mihi interitum laquei sui; supervacue exprobraverunt animam meam.",
        "Veniat illi laqueus quem ignorat; et captio quam abscondit apprehendat eum, et in laqueum cadat in ipsum.",
        "Anima autem mea exsultabit in Domino; et delectabitur super salutari suo.",
        "Omnia ossa mea dicent: Domine, quis similis tui?",
        "Eripiens inopem de manu fortiorum eius; egenum et pauperem a diripientibus eum.",
        "Surgentes testes iniqui, quae ignorabam interrogabant me.",
        "Retribuebant mihi mala pro bonis; sterilitatem animae meae.",
        "Ego autem cum mihi molesti essent, induebar cilicio; humiliabam in ieiunio animam meam, et oratio mea in sinu meo convertetur.",
        "Quasi proximum, et quasi fratrem nostrum, sic complacebam; quasi lugens et contristatus, sic humiliabar.",
        "Et adversum me laetati sunt, et convenerunt; congregata sunt super me flagella, et ignoravi.",
        "Dissipati sunt, nec compuncti; tentaverunt me, subsannaverunt me subsannatione, frenduerunt super me dentibus suis.",
        "Domine, quando respicies? restitue animam meam a malignitate eorum, a leonibus unicam meam.",
        "Confitebor tibi in ecclesia magna, in populo gravi laudabo te.",
        "Non supergaudeant mihi qui adversantur mihi inique; qui oderunt me gratis, et annuunt oculis.",
        "Quoniam mihi quidem pacifice loquebantur; et in iracundia terrae loquentes, dolos cogitabant.",
        "Et dilataverunt super me os suum; dixerunt: Euge, euge, viderunt oculi nostri.",
        "Vidisti, Domine, ne sileas; Domine, ne discedas a me.",
        "Exsurge, et intende iudicio meo; Deus meus, et Dominus meus, in causam meam.",
        "Iudica me secundum iustitiam tuam, Domine Deus meus; et non supergaudeant mihi.",
        "Non dicant in cordibus suis: Euge, euge, animae nostrae; nec dicant: Devoravimus eum.",
        "Erubescant et revereantur simul, qui gratulantur malis meis; induantur pudore et confusione, qui magnificuntur super me.",
        "Exsultent et laetentur qui volunt iustitiam meam; et dicant semper: Magnificetur Dominus, qui volunt pacem servi eius.",
        "Et lingua mea meditabitur iustitiam tuam; tota die laudem tuam."
    ]
    
    // MARK: - Test Cases
    // MARK: - Line Pair Tests
    func testPsalm34Lines1and2() {
        let line1 = psalm34[0]
        let line2 = psalm34[1]
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("iudico", ["iudica"], "judge"),
            ("noceo", ["nocentes"], "harm"),
            ("expugno", ["expugna"], "fight against"),
            ("apprehendo", ["Apprehende"], "take up"),
            ("arma", ["arma"], "weapons"),
            ("scutum", ["scutum"], "shield"),
            ("exsurgo", ["exsurge"], "arise")
        ]
        
        if verbose {
            print("\nPSALM 34:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Justice: Iudica (judge) + expugna (fight against)")
            print("2. Divine Protection: arma (weapons) + scutum (shield)")
        }
        
        XCTAssertNotNil(analysis.dictionary["iudico"], "Should find 'judge' reference")
        XCTAssertEqual(analysis.dictionary["exsurgo"]?.forms["exsurge"], 1, "Should find 'arise' verb")
    }
    
    func testPsalm34Lines3and4() {
        let line3 = psalm34[2]
        let line4 = psalm34[3]
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("effundo", ["Effunde"], "pour out"),
            ("framea", ["frameam"], "sword"),
            ("concludo", ["conclude"], "confine"),
            ("persequor", ["persequuntur"], "persecute"),
            ("salus", ["Salus"], "salvation"),
            ("confundo", ["Confundantur"], "be confounded"),
            ("revereor", ["revereantur"], "be put to shame")
        ]
        
        if verbose {
            print("\nPSALM 34:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Warfare: frameam (sword) + conclude (confine)")
            print("2. Enemy Shame: Confundantur (be confounded) + revereantur (be ashamed)")
        }
        
        XCTAssertNotNil(analysis.dictionary["framea"], "Should find 'sword' reference")
        XCTAssertEqual(analysis.dictionary["confundo"]?.forms["Confundantur"], 1, "Should find 'be confounded' verb")
    }
    
    func testPsalm34Lines5and6() {
        let line5 = psalm34[4]
        let line6 = psalm34[5]
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("pulvis", ["pulvis"], "dust"),
            ("ventus", ["venti"], "wind"),
            ("angelus", ["angelus"], "angel"),
            ("coarcto", ["coarctans"], "harass"),
            ("tenebrae", ["tenebrae"], "darkness"),
            ("lubricus", ["lubricum"], "slippery"),
            ("persequor", ["persequens"], "pursue")
        ]
        
        if verbose {
            print("\nPSALM 34:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Enemy Destruction: pulvis (dust) + venti (wind)")
            print("2. Angelic Intervention: angelus Domini (angel of the Lord) + persequens (pursuing)")
        }
        
        XCTAssertNotNil(analysis.dictionary["angelus"], "Should find 'angel' reference")
        XCTAssertEqual(analysis.dictionary["persequor"]?.forms["persequens"], 1, "Should find 'pursue' verb")
    }
    
    func testPsalm34Lines7and8() {
        let line7 = psalm34[6]
        let line8 = psalm34[7]
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("gratis", ["gratis"], "without cause"),
            ("interitus", ["interitum"], "destruction"),
            ("laqueus", ["laquei", "laqueus", "laqueum"], "snare"),
            ("supervacue", ["supervacue"], "vainly"),
            ("exprobro", ["exprobraverunt"], "reproach"),
            ("captio", ["captio"], "trap"),
            ("cado", ["cadat"], "fall")
        ]
        
        if verbose {
            print("\nPSALM 34:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Unjust Attacks: gratis (without cause) + supervacue (vainly)")
            print("2. Poetic Justice: laqueus (snare) + cadat (may fall)")
        }
        
        XCTAssertEqual(analysis.dictionary["laqueus"]?.forms["laquei"], 1, "Should find 'snare' reference")
        XCTAssertEqual(analysis.dictionary["cado"]?.forms["cadat"], 1, "Should find 'fall' verb")
    }
    
    func testPsalm34Lines9and10() {
        let line9 = psalm34[8]
        let line10 = psalm34[9]
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 9)
        
        let testLemmas = [
            ("exsulto", ["exsultabit"], "rejoice"),
            ("delector", ["delectabitur"], "delight"),
            ("salutaris", ["salutari"], "salvation"),
            ("os", ["ossa"], "bones"),
            ("similis", ["similis"], "like")
        ]
        
        if verbose {
            print("\nPSALM 34:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Joyful Trust: exsultabit (rejoice) + delectabitur (delight)")
            print("2. Bodily Praise: ossa (bones) + dicent (will say)")
        }
        
        XCTAssertEqual(analysis.dictionary["exsulto"]?.forms["exsultabit"], 1, "Should find 'rejoice' verb")
        XCTAssertNotNil(analysis.dictionary["salutaris"], "Should find 'salvation' reference")
    }
    
    func testPsalm34Lines11and12() {
        let line11 = psalm34[10]
        let line12 = psalm34[11]
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 11)
        
        let testLemmas = [
            ("eripio", ["Eripiens"], "rescue"),
            ("inops", ["inopem"], "needy"),
            ("fortis", ["fortiorum"], "strong"),
            ("egenus", ["egenum"], "poor"),
            ("testis", ["testes"], "witness"),
            ("inquiro", ["interrogabant"], "question")
        ]
        
        if verbose {
            print("\nPSALM 34:11-12 ANALYSIS:")
            print("11: \"\(line11)\"")
            print("12: \"\(line12)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Rescue: Eripiens (rescuing) + inopem (needy)")
            print("2. False Accusation: testes (witnesses) + interrogabant (questioned)")
        }
        
        XCTAssertEqual(analysis.dictionary["eripio"]?.forms["Eripiens"], 1, "Should find 'rescue' verb")
        XCTAssertNotNil(analysis.dictionary["testis"], "Should find 'witness' reference")
    }
    
    func testPsalm34Lines13and14() {
        let line13 = psalm34[12]
        let line14 = psalm34[13]
        let combinedText = line13 + " " + line14
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 13)
        
        let testLemmas = [
            ("retribuo", ["Retribuebant"], "repay"),
            ("malum", ["mala"], "evil"),
            ("sterilitas", ["sterilitatem"], "bereavement"),
            ("cilicium", ["cilicio"], "sackcloth"),
            ("humilio", ["humiliabam"], "humble"),
            ("ieiunium", ["ieiunio"], "fasting")
        ]
        
        if verbose {
            print("\nPSALM 34:13-14 ANALYSIS:")
            print("13: \"\(line13)\"")
            print("14: \"\(line14)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Repaid Evil: Retribuebant (they repaid) + mala (evil)")
            print("2. Penitential Practices: cilicio (sackcloth) + ieiunio (fasting)")
        }
        
        XCTAssertEqual(analysis.dictionary["retribuo"]?.forms["Retribuebant"], 1, "Should find 'repay' verb")
        XCTAssertNotNil(analysis.dictionary["humilio"], "Should find 'humble' reference")
    }
    
    func testPsalm34Lines15and16() {
        let line15 = psalm34[14]
        let line16 = psalm34[15]
        let combinedText = line15 + " " + line16
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 15)
        
        let testLemmas = [
            ("proximus", ["proximum"], "neighbor"),
            ("frater", ["fratrem"], "brother"),
            ("complaceo", ["complacebam"], "please"),
            ("lugeo", ["lugens"], "mourn"),
            ("contristo", ["contristatus"], "sadden"),
            ("convenio", ["convenerunt"], "assemble")
        ]
        
        if verbose {
            print("\nPSALM 34:15-16 ANALYSIS:")
            print("15: \"\(line15)\"")
            print("16: \"\(line16)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. False Friendship: proximum (neighbor) + fratrem (brother)")
            print("2. Betrayal: convenerunt (they assembled) + adversum me (against me)")
        }
        
        XCTAssertNotNil(analysis.dictionary["frater"], "Should find 'brother' reference")
        XCTAssertEqual(analysis.dictionary["convenio"]?.forms["convenerunt"], 1, "Should find 'assemble' verb")
    }
    
    // MARK: - Test Cases (continued)
    func testPsalm34Lines17and18() {
        let line17 = psalm34[16]
        let line18 = psalm34[17]
        let combinedText = line17 + " " + line18
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 17)
        
        let testLemmas = [
            ("dissipo", ["Dissipati"], "scatter"),
            ("compungo", ["compuncti"], "prick"),
            ("tento", ["tentaverunt"], "tempt"),
            ("subsanno", ["subsannaverunt", "subsannatione"], "mock"),
            ("frendo", ["frenduerunt"], "gnash"),
            ("respicio", ["respicies"], "look"),
            ("malignitas", ["malignitate"], "malice")
        ]
        
        if verbose {
            print("\nPSALM 34:17-18 ANALYSIS:")
            print("17: \"\(line17)\"")
            print("18: \"\(line18)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Enemy Mockery: subsannaverunt (mocked) + frenduerunt (gnashed)")
            print("2. Divine Intervention: respicies (look) + restitue (restore)")
        }
        
        XCTAssertEqual(analysis.dictionary["subsanno"]?.forms["subsannaverunt"], 1, "Should find 'mock' verb")
        XCTAssertNotNil(analysis.dictionary["malignitas"], "Should find 'malice' reference")
    }
    
    func testPsalm34Lines19and20() {
        let line19 = psalm34[18]
        let line20 = psalm34[19]
        let combinedText = line19 + " " + line20
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 19)
        
        let testLemmas = [
            ("confiteor", ["Confitebor"], "praise"),
            ("ecclesia", ["ecclesia"], "assembly"),
            ("laudo", ["laudabo"], "praise"),
            ("supergaudeo", ["supergaudeant"], "rejoice over"),
            ("adverso", ["adversantur"], "oppose"),
            ("odium", ["oderunt"], "hate")
        ]
        
        if verbose {
            print("\nPSALM 34:19-20 ANALYSIS:")
            print("19: \"\(line19)\"")
            print("20: \"\(line20)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Public Praise: Confitebor (I will praise) + laudabo (I will praise)")
            print("2. Unjust Enemies: adversantur (oppose) + oderunt (hate)")
        }
        
        XCTAssertEqual(analysis.dictionary["confiteor"]?.forms["Confitebor"], 1, "Should find 'praise' verb")
        XCTAssertEqual(analysis.dictionary["odium"]?.forms["oderunt"], 1, "Should find 'hate' verb")
    }
    
    func testPsalm34Lines21and22() {
        let line21 = psalm34[20]
        let line22 = psalm34[21]
        let combinedText = line21 + " " + line22
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 21)
        
        let testLemmas = [
            ("pacificus", ["pacifice"], "peacefully"),
            ("iracundia", ["iracundia"], "anger"),
            ("dolus", ["dolos"], "deceit"),
            ("dilato", ["dilataverunt"], "open wide"),
            ("euge", ["Euge", "euge"], "aha")
        ]
        
        if verbose {
            print("\nPSALM 34:21-22 ANALYSIS:")
            print("21: \"\(line21)\"")
            print("22: \"\(line22)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Hypocritical Speech: pacifice (peacefully) + iracundia (anger)")
            print("2. Mocking Gestures: dilataverunt (opened wide) + Euge (Aha)")
        }
        
        XCTAssertNotNil(analysis.dictionary["dolus"], "Should find 'deceit' reference")
    }
    
    func testPsalm34Lines23and24() {
        let line23 = psalm34[22]
        let line24 = psalm34[23]
        let combinedText = line23 + " " + line24
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 23)
        
        let testLemmas = [
            ("video", ["Vidisti"], "see"),
            ("sileo", ["sileas"], "be silent"),
            ("discedo", ["discedas"], "depart"),
            ("intendo", ["intende"], "attend"),
            ("causa", ["causam"], "case")
        ]
        
        if verbose {
            print("\nPSALM 34:23-24 ANALYSIS:")
            print("23: \"\(line23)\"")
            print("24: \"\(line24)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Urgent Petition: ne sileas (do not be silent) + ne discedas (do not depart)")
            print("2. Judicial Appeal: intende (attend) + causam (case)")
        }
        
        XCTAssertEqual(analysis.dictionary["sileo"]?.forms["sileas"], 1, "Should find 'be silent' verb")
        XCTAssertNotNil(analysis.dictionary["causa"], "Should find 'case' reference")
    }
    
    func testPsalm34Lines25and26() {
        let line25 = psalm34[24]
        let line26 = psalm34[25]
        let combinedText = line25 + " " + line26
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 25)
        
        let testLemmas = [
            ("iustitia", ["iustitiam"], "justice"),
            ("supergaudeo", ["supergaudeant"], "rejoice over"),
            ("cor", ["cordibus"], "heart"),
            ("devoro", ["Devoravimus"], "devour")
        ]
        
        if verbose {
            print("\nPSALM 34:25-26 ANALYSIS:")
            print("25: \"\(line25)\"")
            print("26: \"\(line26)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Righteous Judgment: iustitiam (justice) + iudica (judge)")
            print("2. Enemy Boasting: cordibus (hearts) + Devoravimus (we have devoured)")
        }
        
        XCTAssertNotNil(analysis.dictionary["iustitia"], "Should find 'justice' reference")
        XCTAssertEqual(analysis.dictionary["devoro"]?.forms["Devoravimus"], 1, "Should find 'devour' verb")
    }
    
    func testPsalm34Lines27and28() {
        let line27 = psalm34[26]
        let line28 = psalm34[27]
        let combinedText = line27 + " " + line28
        latinService.configureDebugging(target: "gratulor")
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 27)
        latinService.configureDebugging(target: "")
        
        let testLemmas = [
            ("erubesco", ["Erubescant"], "be ashamed"),
            ("revereor", ["revereantur"], "be dismayed"),
            ("gratulor", ["gratulantur"], "rejoice"),
            ("induo", ["induantur"], "clothe"),
            ("magnifico", ["magnificetur"], "be magnified")
        ]
        
        if verbose {
            print("\nPSALM 34:27-28 ANALYSIS:")
            print("27: \"\(line27)\"")
            print("28: \"\(line28)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Enemy Shame: Erubescant (be ashamed) + revereantur (be dismayed)")
            print("2. Righteous Joy: exsultent (rejoice) + magnificetur (be magnified)")
        }
        
        XCTAssertEqual(analysis.dictionary["erubesco"]?.forms["erubescant"], 1, "Should find 'be ashamed' verb")
        XCTAssertEqual(analysis.dictionary["magnifico"]?.forms["magnificetur"], 1, "Should find 'be magnified' verb")
    }
    
    func testPsalm34Line29() {
        let line29 = psalm34[28]
        let analysis = latinService.analyzePsalm(identity, text: line29, startingLineNumber: 29)
        
        let testLemmas = [
            ("lingua", ["lingua"], "tongue"),
            ("meditor", ["meditabitur"], "meditate"),
            ("iustitia", ["iustitiam"], "justice"),
            ("laus", ["laudem"], "praise")
        ]
        
        if verbose {
            print("\nPSALM 34:29 ANALYSIS:")
            print("29: \"\(line29)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Continual Praise: meditabitur (will meditate) + laudem (praise)")
            print("2. Daily Devotion: tota die (all day) + iustitiam (justice)")
        }
        
        XCTAssertEqual(analysis.dictionary["meditor"]?.forms["meditabitur"], 1, "Should find 'meditate' verb")
        XCTAssertNotNil(analysis.dictionary["laus"], "Should find 'praise' reference")
    }

 
    
    // MARK: - Thematic Tests
    func testDivineJusticeTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm34)
        
        let terms = [
            ("iudico", ["Iudica"], "judge"),
            ("expugno", ["expugna"], "fight against"),
            ("confundo", ["Confundantur"], "confound"),
            ("retribuo", ["Retribuebant"], "repay")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testEnemyShameTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm34)
        
        let terms = [
            ("revereor", ["revereantur"], "be ashamed"),
            ("erubesco", ["erubescant"], "be put to shame"),
            ("confusio", ["confusione"], "confusion"),
            ("pudor", ["pudore"], "shame")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testDivineProtectionTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm34)
        
        let terms = [
            ("arma", ["arma"], "weapons"),
            ("scutum", ["scutum"], "shield"),
            ("angelus", ["angelus"], "angel"),
            ("adiutorium", ["adiutorium"], "help")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testPersonalLamentTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm34)
        
        let terms = [
            ("anima", ["animae", "animam", "animae", "animam"] , "soul"),
            ("humilio", ["humiliabam", "humiliabar"], "humble"),
            ("oratio", ["oratio"], "prayer"),
            ("ieiumium", ["ieiunio"], "fasting")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}