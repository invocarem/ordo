import XCTest
@testable import LatinService

class Psalm5Tests: XCTestCase {
    private var latinService: LatinService!
    let id = PsalmIdentity(number: 5, category: nil)
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm5 = [
        "Verba mea auribus percipe, Domine, intellige clamorem meum.",
        "Intende voci orationis meae, Rex meus et Deus meus.",
        "Quoniam ad te orabo, Domine; mane exaudies vocem meam.",
        "Mane astabo tibi et videbo, quoniam non Deus volens iniquitatem tu es.",
        "Neque habitabit iuxta te malignus, neque permanebunt iniusti ante oculos tuos.",
        "Odisti omnes qui operantur iniquitatem; perdes omnes qui loquuntur mendacium.",
        "Virum sanguinum et dolosum abominabitur Dominus.",
        "Ego autem in multitudine misericordiae tuae introibo in domum tuam; adorabo ad templum sanctum tuum in timore tuo.",
        "Domine, deduc me in iustitia tua; propter inimicos meos dirige in conspectu tuo viam meam.",
        "Quoniam non est in ore eorum veritas; cor eorum vanum est.",
        "Sepulchrum patens est guttur eorum; linguis suis dolose agebant, iudica illos, Deus.",
        "Decidant a cogitationibus suis; secundum multitudinem impietatum eorum expelle eos, quoniam irritaverunt te, Domine.",
        "Et laetentur omnes qui sperant in te, in aeternum exsultabunt; et habitabis in eis.",
        "Et gloriabuntur in te omnes qui diligunt nomen tuum, quoniam tu benedices iusto.",
        "Domine, ut scuto bonae voluntatis tuae coronasti nos." 
    ]
    
    // MARK: - Line Pair Tests
    func testPsalm5Lines1and2() {
        let line1 = psalm5[0]
        let line2 = psalm5[1]
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        let testLemmas = [
            ("verbum", ["Verba"], "words"),
            ("auris", ["auribus"], "ears"),
            ("intelligo", ["intellige"], "understand"),
            ("intendo", ["Intende"], "give heed"),
            ("oratio", ["orationis"], "prayer"),
            ("rex", ["Rex"], "king")
        ]
        
        if verbose {
            print("\nPSALM 5:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Prayerful Appeal: Verba (words) + orationis (prayer)")
            print("2. Divine Attention: auribus (ears) + Intende (give heed)")
        }
        
        XCTAssertNotNil(analysis.dictionary["verbum"], "Should find 'words' reference")
        XCTAssertEqual(analysis.dictionary["intelligo"]?.forms["intellige"], 1, "Should find 'understand' verb")
    }
    
    func testPsalm5Lines3and4() {
        let line3 = psalm5[2]
        let line4 = psalm5[3]
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        let testLemmas = [
            ("oro", ["orabo"], "pray"),
            ("mane", ["mane", "Mane"], "morning"),
            ("exaudio", ["exaudies"], "hear"),
            ("asto", ["astabo"], "stand ready"),
            ("video", ["videbo"], "see"),
            ("iniquitas", ["iniquitatem"], "wickedness")
        ]
        
        if verbose {
            print("\nPSALM 5:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Morning Prayer: mane (morning) + orabo (I will pray)")
            print("2. Divine Response: exaudies (you will hear) + videbo (I will see)")
        }
        
        XCTAssertNotNil(analysis.dictionary["mane"], "Should find 'morning' reference")
        XCTAssertEqual(analysis.dictionary["exaudio"]?.forms["exaudies"], 1, "Should find 'hear' verb")
    }
    
    func testPsalm5Lines5and6() {
        let line5 = psalm5[4]
        let line6 = psalm5[5]
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        let testLemmas = [
            ("habito", ["habitabit"], "dwell"),
            ("malignus", ["malignus"], "evil"),
            ("permaneo", ["permanebunt"], "remain"),
            ("iniquitas", ["iniquitatem"], "wickedness"),
            ("perdo", ["perdes"], "destroy"),
            ("mendacium", ["mendacium"], "lie")
        ]
        
        if verbose {
            print("\nPSALM 5:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Separation from Evil: malignus (evil) + permanebunt (will remain)")
            print("2. Divine Judgment: perdes (you will destroy) + mendacium (lie)")
        }
        
        XCTAssertNotNil(analysis.dictionary["malignus"], "Should find 'evil' reference")
        XCTAssertEqual(analysis.dictionary["perdo"]?.forms["perdes"], 1, "Should find 'destroy' verb")
    }
    
    func testPsalm5Lines7and8() {
        let line7 = psalm5[6]
        let line8 = psalm5[7]
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        let testLemmas = [
            ("sanguis", ["sanguinum"], "blood"),
            ("dolus", ["dolosum"], "deceit"),
            ("abominor", ["abominabitur"], "abhor"),
            ("misericordia", ["misericordiae"], "mercy"),
            ("introeo", ["introibo"], "enter"),
            ("adoro", ["adorabo"], "worship")
        ]
        
        if verbose {
            print("\nPSALM 5:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Wicked Condemned: sanguinum (bloodthirsty) + abominabitur (will abhor)")
            print("2. Righteous Worship: introibo (I will enter) + adorabo (I will worship)")
        }
        
        XCTAssertNotNil(analysis.dictionary["sanguis"], "Should find 'blood' reference")
        XCTAssertEqual(analysis.dictionary["adoro"]?.forms["adorabo"], 1, "Should find 'worship' verb")
    }
    
    func testPsalm5Lines9and10() {
        let line9 = psalm5[8]
        let line10 = psalm5[9]
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        let testLemmas = [
            ("deduco", ["deduc"], "lead"),
            ("iustitia", ["iustitia"], "justice"),
            ("inimicus", ["inimicos"], "enemy"),
            ("dirigo", ["dirige"], "direct"),
            ("veritas", ["veritas"], "truth"),
            ("vanus", ["vanum"], "vain")
        ]
        
        if verbose {
            print("\nPSALM 5:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Guidance: deduc (lead) + dirige (direct)")
            print("2. Enemy Character: inimicos (enemies) + vanum (vain)")
        }
        
        XCTAssertNotNil(analysis.dictionary["iustitia"], "Should find 'justice' reference")
        XCTAssertEqual(analysis.dictionary["deduco"]?.forms["deduc"], 1, "Should find 'lead' verb")
    }
    
    func testPsalm5Lines11and12() {
        let line11 = psalm5[10]
        let line12 = psalm5[11]
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 11)
        
        let testLemmas = [
            ("sepulchrum", ["Sepulchrum"], "grave"),
            ("dolus", ["dolose"], "deceit"),
            ("iudico", ["iudica"], "judge"),
            ("decido", ["Decidant"], "fall"),
            ("impietas", ["impietatum"], "wickedness"),
            ("irrito", ["irritaverunt"], "provoke")
        ]
        
        if verbose {
            print("\nPSALM 5:11-12 ANALYSIS:")
            print("11: \"\(line11)\"")
            print("12: \"\(line12)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Wicked Speech: Sepulchrum (grave) + dolose (deceitfully)")
            print("2. Divine Judgment: iudica (judge) + Decidant (may they fall)")
        }
        
        XCTAssertNotNil(analysis.dictionary["sepulchrum"], "Should find 'grave' reference")
        XCTAssertEqual(analysis.dictionary["iudico"]?.forms["iudica"], 1, "Should find 'judge' verb")
    }
    
    func testPsalm5Lines13and14() {
        let line13 = psalm5[12]
        let line14 = psalm5[13]
        let combinedText = line13 + " " + line14

        latinService.configureDebugging(target: "laetor")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 13)
        latinService.configureDebugging(target: "")
        
        let testLemmas = [
            ("laetor", ["laetentur"], "rejoice"),
            ("spero", ["sperant"], "hope"),
            ("exsulto", ["exsultabunt"], "exult"),
            ("glorior", ["gloriabuntur"], "glory"),
            ("diligo", ["diligunt"], "love"),
            ("benedico", ["benedices"], "bless")
        ]
        
        if verbose {
            print("\nPSALM 5:13-14 ANALYSIS:")
            print("13: \"\(line13)\"")
            print("14: \"\(line14)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Joyful Trust: laetentur (rejoice) + exsultabunt (will exult)")
            print("2. Divine Favor: diligunt (love) + benedices (you will bless)")
        }
        
        XCTAssertNotNil(analysis.dictionary["exsulto"], "Should find 'exult' reference")
        XCTAssertEqual(analysis.dictionary["benedico"]?.forms["benedices"], 1, "Should find 'bless' verb")
    }
    
    func testPsalm5Line15() {
        let line15 = psalm5[14]
        let analysis = latinService.analyzePsalm(id, text: line15, startingLineNumber: 15)
        
        let testLemmas = [
            ("scutum", ["scuto"], "shield"),
            ("voluntas", ["voluntatis"], "will"),
            ("corono", ["coronasti"], "crown")
        ]
        
        if verbose {
            print("\nPSALM 5:15 ANALYSIS:")
            print("15: \"\(line15)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 14, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nTHEMES:")
            print("1. Divine Protection: scuto (shield) + coronasti (you have crowned)")
        }
        
        XCTAssertNotNil(analysis.dictionary["scutum"], "Should find 'shield' reference")
        XCTAssertEqual(analysis.dictionary["corono"]?.forms["coronasti"], 1, "Should find 'crown' verb")
    }
    
    // MARK: - Thematic Tests (kept from original)
    func testMorningPrayerTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm5)
        
        let morningTerms = [
            ("mane", ["mane", "mane"], "morning"),
            ("astabo", ["astabo"], "stand ready"),
            ("oratio", ["orationis"], "prayer"),
            ("exaudio", ["exaudies"], "hear")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: morningTerms)
    }
    
    
    // MARK: - Helper Methods
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, 
                                     confirmedWords: [(lemma: String, 
                                                     forms: [String], 
                                                     translation: String)]) {
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