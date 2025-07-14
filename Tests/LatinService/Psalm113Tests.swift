import XCTest
@testable import LatinService

class Psalm113Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let identity = PsalmIdentity(number: 113, category: "exodus")
    
    // MARK: - Test Data (Psalm 113)
    let psalm113 = [
        "In exitu Israel de Aegypto, domus Jacob de populo barbaro,",
        "Facta est Judaea sanctificatio ejus, Israel potestas ejus.",
        "Mare vidit et fugit; Jordanis conversus est retrorsum.",
        "Montes exsultaverunt ut arietes, et colles sicut agni ovium.",
        "Quid est tibi, mare, quod fugisti? et tu, Jordanis, quia conversus es retrorsum?",
        "Montes, exsultastis sicut arietes? et colles, sicut agni ovium?",
        "A facie Domini mota est terra, a facie Dei Jacob.",
        "Qui convertit petram in stagna aquarum, et rupem in fontes aquarum.",
        "Non nobis, Domine, non nobis: sed nomini tuo da gloriam.",
        "Super misericordia tua, et veritate tua: nequando dicant gentes: Ubi est Deus eorum?",
        "Deus autem noster in caelo: omnia quaecumque voluit, fecit.",
        "Simulacra gentium argentum et aurum, opera manuum hominum.",
        "Os habent, et non loquentur: oculos habent, et non videbunt.",
        "Aures habent, et non audient: nares habent, et non odorabunt.",
        "Manus habent, et non palpabunt: pedes habent, et non ambulabunt: non clamabunt in gutture suo.",
        "Similes illis fiant qui faciunt ea: et omnes qui confidunt in eis.",
        "Domus Israel speravit in Domino: adjutor eorum et protector eorum est.",
        "Domus Aaron speravit in Domino: adjutor eorum et protector eorum est.",
        "Qui timent Dominum, speraverunt in Domino: adjutor eorum et protector eorum est.",
        "Dominus memor fuit nostri: et benedixit nobis.",
        "Benedixit domui Israel: benedixit domui Aaron.",
        "Benedixit omnibus qui timent Dominum, pusillis cum majoribus.",
        "Adjiciat Dominus super vos: super vos, et super filios vestros.",
        "Benedicti vos a Domino, qui fecit caelum et terram.",
        "Caelum caeli Domino: terram autem dedit filiis hominum.",
        "Non mortui laudabunt te, Domine: neque omnes qui descendunt in infernum.",
        "Sed nos qui vivimus, benedicimus Domino, ex hoc nunc et usque in saeculum."
    ]
    
   
    // MARK: - Thematic Tests
    func testExodusTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm113)
        
        let terms = [
            ("exitus", ["exitu"], "departure"),
            ("aegyptus", ["aegypto"], "Egypt"),
            ("israel", ["israel"], "Israel"),
            ("jacob", ["jacob"], "Jacob")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testNatureMiracleTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm113)
        
        let terms = [
            ("mare", ["mare"], "sea"),
            ("jordanis", ["Jordanis"], "Jordan"),
            ("converto", ["conversus", "conversus", "convertit"], "turn"),
            ("petra", ["petram"], "rock"),
            ("stagnum", ["stagna"], "pool")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testIdolContrastTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm113)
        
        let terms = [
            ("simulacrum", ["simulacra"], "idols"),
            ("argentum", ["argentum"], "silver"),
            ("aurum", ["aurum"], "gold"),
            ("os", ["os"], "mouth"),
            ("oculus", ["oculos"], "eyes"),
            ("auris", ["aures"], "ears")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    func testBlessingTheme() {
        let analysis = latinService.analyzePsalm(identity, text: psalm113)
        
        let terms = [
            ("benedico", ["benedixit", "benedixit", "benedixit", "benedicimus"] , "bless"),
            ("spero", ["speravit", "speravit", "speraverunt"], "hope"),
            ("adjutor", ["adjutor"], "helper"),
            ("protector", ["protector"], "protector")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }
    
    // MARK: - Test Cases
    // MARK: - Line Pair Tests
    func testPsalm113Lines1and2() {
        let line1 = psalm113[0]
        let line2 = psalm113[1]
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("exitus", ["exitu"], "departure"),
            ("aegyptus", ["aegypto"], "Egypt"),
            ("jacob", ["jacob"], "Jacob"),
            ("sanctificatio", ["sanctificatio"], "sanctification"),
            ("potestas", ["potestas"], "power")
        ]
        
        if verbose {
            print("\nPSALM 113:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Exodus Narrative: exitu (departure) + Aegypto (Egypt)")
            print("2. Divine Election: sanctificatio (sanctification) + potestas (power)")
        }
        
        XCTAssertNotNil(analysis.dictionary["exitus"], "Should find 'departure' reference")
        XCTAssertNotNil(analysis.dictionary["aegyptus"], "Should find 'Egypt' reference")
    }
    
    func testPsalm113Lines3and4() {
        let line3 = psalm113[2]
        let line4 = psalm113[3]
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("mare", ["mare"], "sea"),
            ("fugio", ["fugit"], "flee"),
            ("jordanis", ["jordanis"], "Jordan"),
            ("converto", ["conversus"], "turn back"),
            ("mons", ["montes"], "mountains"),
            ("exsulto", ["exsultaverunt"], "leap"),
            ("collis", ["colles"], "hill")
        ]
        
        if verbose {
            print("\nPSALM 113:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Nature's Flight: mare (sea) + fugit (fled)")
            print("2. Cosmic Rejoicing: montes (mountains) exsultaverunt (leaped)")
        }
        
        XCTAssertNotNil(analysis.dictionary["mare"], "Should find 'sea' reference")
        XCTAssertEqual(analysis.dictionary["fugio"]?.forms["fugit"], 1, "Should find 'flee' verb")
    }
    
    func testPsalm113Lines5and6() {
        let line5 = psalm113[4]
        let line6 = psalm113[5]
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("mare", ["mare"], "sea"),
            ("fugio", ["fugisti"], "flee"),
            ("Jordanis", ["Jordanis"], "Jordan"),
            ("converto", ["conversus"], "turn back"),
            ("mons", ["montes"], "mountains"),
            ("exsulto", ["exsultastis"], "leap"),
            ("collis", ["colles"], "hills")
        ]
        
        if verbose {
            print("\nPSALM 113:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Rhetorical Questions: quid est tibi (why is it to you) + quia (because)")
            print("2. Nature's Submission: fugisti (you fled) + conversus es (you turned)")
        }
        
        XCTAssertEqual(analysis.dictionary["fugio"]?.forms["fugisti"], 1, "Should find 'fled' verb")
        XCTAssertEqual(analysis.dictionary["exsulto"]?.forms["exsultastis"], 1, "Should find 'leaped' verb")
    }
    
    func testPsalm113Lines7and8() {
        let line7 = psalm113[6]
        let line8 = psalm113[7]
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("facies", ["facie", "facie"], "presence"),
            ("moveo", ["mota"], "shake"),
            ("terra", ["terra"], "earth"),
            ("converto", ["convertit"], "turn"),
            ("petra", ["petram"], "rock"),
            ("stagnum", ["stagna"], "pool"),
            ("rupes", ["rupem"], "cliff"),
            ("fons", ["fontes"], "spring")
        ]
        
        if verbose {
            print("\nPSALM 113:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Presence: facie Domini (Lord's presence) + mota est terra (earth trembled)")
            print("2. Miraculous Transformation: convertit (turned) + petram (rock) in stagna (pools)")
        }
        
        XCTAssertNotNil(analysis.dictionary["facies"], "Should find 'presence' reference")
        XCTAssertEqual(analysis.dictionary["moveo"]?.forms["mota"], 1, "Should find 'shake' verb")
    }
    
    func testPsalm113Lines9and10() {
        let line9 = psalm113[8]
        let line10 = psalm113[9]
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 9)
        
        let testLemmas = [
            ("nomen", ["nomini"], "name"),
            ("gloria", ["gloriam"], "glory"),
            ("misericordia", ["misericordia"], "mercy"),
            ("veritas", ["veritate"], "truth"),
            ("gens", ["gentes"], "nations")
        ]
        
        if verbose {
            print("\nPSALM 113:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Glory: nomini tuo (your name) + da gloriam (give glory)")
            print("2. Covenant Faithfulness: misericordia (mercy) + veritate (truth)")
        }
        
        XCTAssertNotNil(analysis.dictionary["gloria"], "Should find 'glory' reference")
        XCTAssertNotNil(analysis.dictionary["misericordia"], "Should find 'mercy' reference")
    }
    
    func testPsalm113Lines11and12() {
        let line11 = psalm113[10]
        let line12 = psalm113[11]
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 11)
        
        let testLemmas = [
            ("caelum", ["caelo"], "heaven"),
            ("volo", ["voluit"], "will"),
            ("facio", ["fecit"], "do"),
            ("simulacrum", ["simulacra"], "idol"),
            ("argentum", ["argentum"], "silver"),
            ("aurum", ["aurum"], "gold"),
            ("opus", ["opera"], "work"),
            ("manus", ["manuum"], "hands")
        ]
        
        if verbose {
            print("\nPSALM 113:11-12 ANALYSIS:")
            print("11: \"\(line11)\"")
            print("12: \"\(line12)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Sovereignty: in caelo (in heaven) + omnia...fecit (all he wills)")
            print("2. Idol Contrast: simulacra (idols) + opera manuum (work of hands)")
        }
        
        XCTAssertNotNil(analysis.dictionary["caelum"], "Should find 'heaven' reference")
        XCTAssertEqual(analysis.dictionary["facio"]?.forms["fecit"], 1, "Should find 'do/make' verb")
    }
    
    func testPsalm113Lines13and14() {
        let line13 = psalm113[12]
        let line14 = psalm113[13]
        let combinedText = line13 + " " + line14
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 13)
        
        let testLemmas = [
            ("os", ["os"], "mouth"),
            ("loquor", ["loquentur"], "speak"),
            ("oculus", ["oculos"], "eyes"),
            ("video", ["videbunt"], "see"),
            ("auris", ["aures"], "ears"),
            ("audio", ["audient"], "hear"),
            ("naris", ["nares"], "nostrils"),
            ("odoror", ["odorabunt"], "smell")
        ]
        
        if verbose {
            print("\nPSALM 113:13-14 ANALYSIS:")
            print("13: \"\(line13)\"")
            print("14: \"\(line14)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Idol Impotence: habent...non (have...not) pattern")
            print("2. Sensory Deprivation: non loquentur (don't speak) + non videbunt (don't see)")
        }
        
        XCTAssertEqual(analysis.dictionary["os"]?.forms["os"], 1, "Should find 'mouth' reference")
        XCTAssertEqual(analysis.dictionary["video"]?.forms["videbunt"], 1, "Should find 'see' verb")
    }
    
    func testPsalm113Lines15and16() {
        let line15 = psalm113[14]
        let line16 = psalm113[15]
        let combinedText = line15 + " " + line16
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 15)
        
        let testLemmas = [
            ("manus", ["manus"], "hands"),
            ("palpo", ["palpabunt"], "feel"),
            ("pes", ["pedes"], "feet"),
            ("ambulo", ["ambulabunt"], "walk"),
            ("guttur", ["gutture"], "throat"),
            ("similis", ["similes"], "like"),
            ("confido", ["confidunt"], "trust")
        ]
        
        if verbose {
            print("\nPSALM 113:15-16 ANALYSIS:")
            print("15: \"\(line15)\"")
            print("16: \"\(line16)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Complete Impotence: non palpabunt (don't feel) + non ambulabunt (don't walk)")
            print("2. Idol Maker's Fate: similes illis (like them) + confidunt in eis (trust in them)")
        }
        
        XCTAssertEqual(analysis.dictionary["ambulo"]?.forms["ambulabunt"], 1, "Should find 'walk' verb")
        XCTAssertEqual(analysis.dictionary["confido"]?.forms["confidunt"], 1, "Should find 'trust' verb")
    }
    
    func testPsalm113Lines17and18() {
        let line17 = psalm113[16]
        let line18 = psalm113[17]
        let combinedText = line17 + " " + line18
        let analysis = latinService.analyzePsalm(identity, text: combinedText, startingLineNumber: 17)
        
        let testLemmas = [
            ("domus", ["domus"], "house"),
            ("spero", ["speravit"], "hope"),
            ("adjutor", ["adjutor"], "helper"),
            ("protector", ["protector"], "protector"),
            ("aaron", ["aaron"], "Aaron")
        ]
        
        if verbose {
            print("\nPSALM 113:17-18 ANALYSIS:")
            print("17: \"\(line17)\"")
            print("18: \"\(line18)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Covenant Trust: domus Israel (house of Israel) + speravit (hoped)")
            print("2. Divine Protection: adjutor (helper) + protector (protector)")
        }
        
        XCTAssertEqual(analysis.dictionary["spero"]?.forms["speravit"], 1, "Should find 'hope' verb")
        XCTAssertNotNil(analysis.dictionary["adjutor"], "Should find 'helper' reference")
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