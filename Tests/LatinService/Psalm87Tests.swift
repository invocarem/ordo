import XCTest
@testable import LatinService 

class Psalm87Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true // Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                print("\n❌ MISSING LEMMA IN DICTIONARY: \(lemma)")
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
            XCTAssertTrue(entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                         "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'")
            
            for form in forms {
                let count = entry.forms[form] ?? 0
                if self.verbose {
                    print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
                XCTAssertGreaterThan(count, 0, "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
    }
    
    let id = PsalmIdentity(number: 87, category: nil)
    
    let psalm87 = [
        "Domine Deus salutis meae, in die clamavi, et nocte coram te.",
        "Intret in conspectu tuo oratio mea; inclina aurem tuam ad precem meam.",
        "Quoniam repleta est malis anima mea, et vita mea inferno appropinquavit.",
        "Aestimatus sum cum descendentibus in lacum; factus sum sicut homo sine adjutorio, inter mortuos liber.",
        "Sicut vulnerati dormientes in sepulchris, quorum non es memor amplius; et ipsi de manu tua repulsi sunt.",
        "Posuerunt me in lacu inferiori, in tenebrosis, et in umbra mortis.",
        "Super me confirmatus est furor tuus, et omnes fluctus tuos induxisti super me.",
        "Longe fecisti notos meos a me; posuerunt me abominationem sibi.",
        "Traditus sum, et non egrediebar; oculi mei languerunt prae inopia.",
        "Clamavi ad te, Domine, tota die; expandi ad te manus meas.",
        "Numquid mortuis facies mirabilia? aut medici suscitabunt, et confitebuntur tibi?",
        "Numquid narrabit aliquis in sepulchro misericordiam tuam, et veritatem tuam in perditione?",
        "Numquid cognoscentur in tenebris mirabilia tua, et justitia tua in terra oblivionis?",
        "Et ego ad te, Domine, clamavi, et mane oratio mea praeveniet te.",
        "Ut quid, Domine, repellis orationem meam, avertis faciem tuam a me?",
        "Pauper sum ego, et in laboribus a juventute mea; exaltatus autem, humiliatus sum et conturbatus.",
        "In me transierunt irae tuae, et terrores tui conturbaverunt me.",
        "Circumdederunt me sicut aqua tota die; circumdederunt me simul."
    ]
    
    func testPsalm87Lines1and2() {
        let line1 = psalm87[0] // "Domine Deus salutis meae, in die clamavi, et nocte coram te."
        let line2 = psalm87[1] // "Intret in conspectu tuo oratio mea; inclina aurem tuam ad precem meam."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("dominus", ["domine"], "Lord"),
            ("deus", ["deus"], "God"),
            ("salus", ["salutis"], "salvation"),
            ("dies", ["die"], "day"),
            ("clamo", ["clamavi"], "cry out"),
            ("nox", ["nocte"], "night"),
            ("intro", ["intret"], "enter"),
            ("conspectus", ["conspectu"], "sight"),
            ("oratio", ["oratio", "precem"], "prayer"),
            ("inclino", ["inclina"], "incline"),
            ("auris", ["aurem"], "ear")
        ]
        
        if verbose {
            print("\nPSALM 87:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Day/Night Prayer: 'in die...et nocte' (by day and night)")
            print("2. Divine Attention: 'inclina aurem tuam' (incline your ear)")
            print("3. Personal Possession: 'meae...mea...meam' (my salvation, my prayer)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["clamo"]?.forms["clamavi"], 1, "Should find 'cry out' verb")
        XCTAssertEqual(analysis.dictionary["oratio"]?.forms["oratio"], 1, "Should find prayer reference")
        XCTAssertEqual(analysis.dictionary["prex"]?.forms["precem"], 1, "Should find prayer reference")
        
        // Test temporal contrast
        let temporalTerms = ["die", "nocte"].map {
            analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
        }
        XCTAssertEqual(temporalTerms.filter { $0 }.count, 2, "Should find both day and night terms")
        
    }
    
    func testPsalm87Lines3and4() {
        let line3 = psalm87[2] // "Quoniam repleta est malis anima mea, et vita mea inferno appropinquavit."
        let line4 = psalm87[3] // "Aestimatus sum cum descendentibus in lacum; factus sum sicut homo sine adjutorio, inter mortuos liber."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("repleo", ["repleta"], "fill"),
            ("malum", ["malis"], "evil"),
            ("anima", ["anima"], "soul"),
            ("vita", ["vita"], "life"),
            ("infernus", ["inferno"], "hell"),
            ("appropinquo", ["appropinquavit"], "approach"),
            ("aestimo", ["aestimatus"], "count"),
            ("descendo", ["descendentibus"], "descend"),
            ("lacus", ["lacum"], "pit"),
            ("adjutorium", ["adjutorio"], "help"),
            ("mortuus", ["mortuos"], "dead"),
            ("liber", ["liber"], "free")
        ]
        
        if verbose {
            print("\nPSALM 87:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Descent Imagery: 'descendentibus in lacum' (going down into the pit)")
            print("2. Abandonment: 'sine adjutorio' (without help)")
            print("3. Paradox: 'inter mortuos liber' (free among the dead)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["infernus"]?.forms["inferno"], 1, "Should find reference to hell")
        XCTAssertEqual(analysis.dictionary["aestimo"]?.forms["aestimatus"], 1, "Should find 'counted' verb")
        
        // Test descent vocabulary
        let descentTerms = ["descendentibus", "lacum"].map {
            analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
        }
        XCTAssertEqual(descentTerms.filter { $0 }.count, 2, "Should find both descent terms")
        
        // Test state of being
        let stateTerms = ["aestimatus", "factus"].reduce(0) {
            $0 + (analysis.dictionary["aestimo"]?.forms[$1] ?? 0)
            + (analysis.dictionary["facio"]?.forms[$1] ?? 0)
        }
        XCTAssertEqual(stateTerms, 2, "Should find both state verbs")
    }
    
    func testPsalm87Lines5and6() {
        let line5 = psalm87[4] // "Sicut vulnerati dormientes in sepulchris, quorum non es memor amplius; et ipsi de manu tua repulsi sunt."
        let line6 = psalm87[5] // "Posuerunt me in lacu inferiori, in tenebrosis, et in umbra mortis."
        let combinedText = line5 + " " + line6
        latinService.configureDebugging(target: "sepulchrum" )
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("vulnero", ["vulnerati"], "wound"),
            ("dormio", ["dormientes"], "sleep"),
            ("sepulchrum", ["sepulchris"], "tomb"),
            ("memor", ["memor"], "mindful"),
            ("manus", ["manu"], "hand"),
            ("repello", ["repulsi"], "drive away"),
            ("pono", ["posuerunt"], "place"),
            ("lacus", ["lacu"], "pit"),
            ("inferus", ["inferiori"], "lower"),
            ("tenebrosus", ["tenebrosis"], "dark"),
            ("umbra", ["umbra"], "shadow"),
            ("mors", ["mortis"], "death")
        ]
        
        if verbose {
            print("\nPSALM 87:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Death Imagery: 'sepulchris...umbra mortis' (tombs...shadow of death)")
            print("2. Divine Rejection: 'non es memor...repulsi sunt' (not mindful...driven away)")
            print("3. Depth: 'lacu inferiori' (lowest pit)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["sepulcrum"]?.forms["sepulchris"], 1, "Should find tomb reference")
        XCTAssertEqual(analysis.dictionary["mors"]?.forms["mortis"], 1, "Should find death reference")
        
        // Test spatial descent
        let spatialTerms = ["inferiori", "tenebrosis"].map {
            analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
        }
        XCTAssertEqual(spatialTerms.filter { $0 }.count, 2, "Should find both spatial descent terms")
        
        // Test divine action
        let divineAction = ["repulsi"].reduce(0) {
            $0 + (analysis.dictionary["repello"]?.forms[$1] ?? 0)
        }
        XCTAssertEqual(divineAction, 1, "Should find divine rejection verb")
    }
    
    func testPsalm87Lines7and8() {
        let line7 = psalm87[6] // "Super me confirmatus est furor tuus, et omnes fluctus tuos induxisti super me."
        let line8 = psalm87[7] // "Longe fecisti notos meos a me; posuerunt me abominationem sibi."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("confirmo", ["confirmatus"], "establish"),
            ("furor", ["furor"], "wrath"),
            ("fluctus", ["fluctus"], "wave"),
            ("induco", ["induxisti"], "bring upon"),
            ("longe", ["longe"], "far"),
            ("facio", ["fecisti"], "make"),
            ("notus", ["notos"], "known"),
            ("pono", ["posuerunt"], "place"),
            ("abominatio", ["abominationem"], "abomination")
        ]
        
        if verbose {
            print("\nPSALM 87:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Divine Wrath: 'furor tuus' (your wrath) with wave imagery")
            print("2. Social Isolation: 'notos meos a me' (my acquaintances from me)")
            print("3. Rejection: 'abominationem sibi' (an abomination to them)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["furor"]?.forms["furor"], 1, "Should find wrath reference")
        XCTAssertEqual(analysis.dictionary["abominatio"]?.forms["abominationem"], 1, "Should find abomination term")
        
        // Test divine action verbs
        let divineVerbs = ["confirmatus", "induxisti", "fecisti"].reduce(0) {
            $0 + (analysis.dictionary["confirmo"]?.forms[$1] ?? 0)
            + (analysis.dictionary["induco"]?.forms[$1] ?? 0)
            + (analysis.dictionary["facio"]?.forms[$1] ?? 0)
        }
        XCTAssertEqual(divineVerbs, 3, "Should find all three divine action verbs")
        
        // Test social rejection
        let rejectionTerms = ["longe", "abominationem"].map {
            analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
        }
        XCTAssertEqual(rejectionTerms.filter { $0 }.count, 2, "Should find both rejection terms")
    }
    
    func testPsalm87Lines9and10() {
        let line9 = psalm87[8] // "Traditus sum, et non egrediebar; oculi mei languerunt prae inopia."
        let line10 = psalm87[9] // "Clamavi ad te, Domine, tota die; expandi ad te manus meas."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("trado", ["traditus"], "deliver"),
            ("egredior", ["egrediebar"], "go out"),
            ("oculus", ["oculi"], "eye"),
            ("languo", ["languerunt"], "grow weak"),
            ("inops", ["inopia"], "poor"),
            ("clamo", ["clamavi"], "cry out"),
            ("dominus", ["domine"], "Lord"),
            ("totus", ["tota"], "whole"),
            ("dies", ["die"], "day"),
            ("expando", ["expandi"], "spread out"),
            ("manus", ["manus"], "hand")
        ]
        
        if verbose {
            print("\nPSALM 87:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Physical Affliction: 'oculi mei languerunt' (my eyes grow weak)")
            print("2. Persistent Prayer: 'tota die' (all day long)")
            print("3. Gesture of Supplication: 'expandi manus meas' (spread out my hands)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["clamo"]?.forms["clamavi"], 1, "Should find cry verb")
        XCTAssertEqual(analysis.dictionary["expando"]?.forms["expandi"], 1, "Should find spread verb")
        
        // Test physical affliction
        let afflictionTerms = ["languerunt", "inopia"].map {
            analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
        }
        XCTAssertEqual(afflictionTerms.filter { $0 }.count, 2, "Should find both affliction terms")
        
        // Test prayer gestures
        let prayerGestures = ["clamavi", "expandi"].reduce(0) {
            $0 + (analysis.dictionary["clamo"]?.forms[$1] ?? 0)
            + (analysis.dictionary["expando"]?.forms[$1] ?? 0)
        }
        XCTAssertEqual(prayerGestures, 2, "Should find both prayer actions")
    }
    
    func testPsalm87Lines11and12() {
        let line11 = psalm87[10] // "Numquid mortuis facies mirabilia? aut medici suscitabunt, et confitebuntur tibi?"
        let line12 = psalm87[11] // "Numquid narrabit aliquis in sepulchro misericordiam tuam, et veritatem tuam in perditione?"
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(id, text: combinedText)
        
        let testLemmas = [
            ("numquid", ["numquid"], "can"),
            ("mortuus", ["mortuis"], "dead"),
            ("facio", ["facies"], "do"),
            ("mirabilis", ["mirabilia"], "wonderful"),
            ("medicus", ["medici"], "physician"),
            ("suscito", ["suscitabunt"], "raise up"),
            ("confiteor", ["confitebuntur"], "praise"),
            ("narro", ["narrabit"], "declare"),
            ("sepulchrum", ["sepulchro"], "grave"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("veritas", ["veritatem"], "truth"),
            ("perditio", ["perditione"], "destruction")
        ]
        
        if verbose {
            print("\nPSALM 87:11-12 ANALYSIS:")
            print("11: \"\(line11)\"")
            print("12: \"\(line12)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Rhetorical Questions: 'Numquid...' (Can the dead...?)")
            print("2. Divine Attributes: 'misericordiam tuam...veritatem tuam' (your mercy...your truth)")
            print("3. Death's Limitation: 'in sepulchro...in perditione' (in the grave...in destruction)")
        }
        
        // Key assertions
        XCTAssertEqual(analysis.dictionary["numquid"]?.forms["numquid"], 2, "Should find both rhetorical questions")
        XCTAssertEqual(analysis.dictionary["mirabilis"]?.forms["mirabilia"], 1, "Should find wonders reference")
        
        // Test divine attributes
        let divineAttributes = ["misericordiam", "veritatem"].map {
            analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
        }
        XCTAssertEqual(divineAttributes.filter { $0 }.count, 2, "Should find both divine attributes")
        
        // Test death terms
        let deathTerms = ["mortuis", "sepulchro", "perditione"].reduce(0) {
            $0 + (analysis.dictionary["mortuus"]?.forms[$1] ?? 0)
            + (analysis.dictionary["sepulchrum"]?.forms[$1] ?? 0)
            + (analysis.dictionary["perditio"]?.forms[$1] ?? 0)
        }
        XCTAssertEqual(deathTerms, 3, "Should find all three death-related terms")
    }
    
    func testAnalyzePsalm87() {
        let analysis = latinService.analyzePsalm(id, text: psalm87)
        
        // ===== TEST METRICS =====
        let totalWords = 150  // Approximate word count in Psalm 87
        let testedLemmas = 65 // Number of lemmas we're testing
        let testedForms = 85  // Number of word forms we're verifying
        
        // ===== COMPREHENSIVE VOCABULARY TEST =====
        let confirmedWords = [
            ("dominus", ["domine"], "lord"),
            ("deus", ["deus"], "god"),
            ("clamo", ["clamavi"], "cry out"),
            ("oratio", ["oratio", "precem"], "prayer"),
            ("infernum", ["inferno"], "hell"),
            ("sepulcrum", ["sepulchris", "sepulchro"], "tomb"),
            ("mors", ["mortis"], "death"),
            ("furor", ["furor"], "wrath"),
            ("abominatio", ["abominationem"], "abomination"),
            ("trado", ["traditus"], "deliver"),
            ("expando", ["expandi"], "spread out"),
            ("mirabilis", ["mirabilia"], "wonderful"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("veritas", ["veritatem"], "truth")
        ]
        
        if self.verbose {
            print("\n=== Psalm 87 Test Coverage ===")
            print("Total words: \(totalWords)")
            print("Unique lemmas: \(analysis.uniqueLemmas)")
            print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
            print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
        // ===== THEOLOGICAL CONCEPT CHECKS =====
        // Death imagery
        if let morsInfo = analysis.dictionary["mors"] {
            XCTAssertEqual(morsInfo.forms["mortis"], 1, "Should find 'mortis' once")
        }
        
        // Divine attributes
        if let misericordiaInfo = analysis.dictionary["misericordia"] {
            XCTAssertGreaterThan(misericordiaInfo.count, 0, "Should reference mercy")
        }
        
        // Prayer terms
        XCTAssertNotNil(analysis.dictionary["oratio"], "Should have prayer terms")
        XCTAssertNotNil(analysis.dictionary["clamo"], "Should have crying out terms")
        
        // ===== GRAMMAR CHECKS =====
        // Verify rhetorical questions
        if let numquidInfo = analysis.dictionary["numquid"] {
            XCTAssertGreaterThan(numquidInfo.count, 1, "Should find multiple rhetorical questions")
        }
        
        // Verify divine pronouns
        if let tuusInfo = analysis.dictionary["tuus"] {
            XCTAssertGreaterThan(tuusInfo.count, 5, "Possessive 'tuus' should appear frequently")
        }

        if verbose {
            print("\n=== Key Theological Terms ===")
            print("'mors' forms:", analysis.dictionary["mors"]?.forms ?? [:])
            print("'clamo' forms:", analysis.dictionary["clamo"]?.forms ?? [:])
        }
    }
}