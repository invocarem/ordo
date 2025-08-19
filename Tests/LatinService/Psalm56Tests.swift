import XCTest
@testable import LatinService

class Psalm56Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm56 = [
        "Si vere utique justitiam loquimini, recte judicate, filii hominum.",
        "Etenim in corde iniquitates operamini, in terra injustitias manus vestras praeparant.",
        "Alienati sunt peccatores a vulva, erraverunt ab utero, locuti sunt falsa.",
        "Furor illis secundum similitudinem serpentis, sicut aspidis surdae et obturantis aures suas.",
        "Quae non exaudiet vocem incantantium, et venefici incantantis sapienter.",
        "Deus conteret dentes eorum in ore ipsorum; molas leonum confringet Dominus.",
        "Ad nihilum devenient tamquam aqua decurrens; intendit arcum suum donec infirmentur.",
        "Sicut cera quae fluit auferentur; ceciderunt ignis super eos, et non viderunt solem.",
        "Priusquam intelligerent spinae vestrae rhamnum, sicut viventes, sicut in ira absorbet eos.",
        "Laetabitur justus cum viderit vindictam; manus suas lavabit in sanguine peccatorum.",
        "Et dicet homo: Si utique est fructus justo, utique est Deus judicans eos in terra."
    ]
    
    // MARK: - Test Cases
    
    func testPsalm56Lines1and2() {
        let line1 = psalm56[0] // "Si vere utique justitiam loquimini, recte judicate, filii hominum."
        let line2 = psalm56[1] // "Etenim in corde iniquitates operamini, in terra injustitias manus vestras praeparant."
        let combinedText = line1 + " " + line2
        latinService.configureDebugging(target: "loquor")
        let analysis = latinService.analyzePsalm(text: combinedText)
        latinService.configureDebugging(target: "")
        
        let testLemmas = [
            ("verus", ["vere"], "truly"),
            ("justitia", ["justitiam"], "justice"),
            ("loquor", ["loquimini"], "speak"),
            ("recte", ["recte"], "rightly"),
            ("judico", ["judicate"], "judge"),
            ("filius", ["filii"], "sons"),
            ("homo", ["hominum"], "men"),
            ("cor", ["corde"], "heart"),
            ("iniquitas", ["iniquitates"], "wickedness"),
            ("operor", ["operamini"], "work"),
            ("injustitia", ["injustitias"], "injustice"),
            ("manus", ["manus"], "hands"),
            ("praeparo", ["praeparant"], "prepare")
        ]
        
        if verbose {
            print("\nPSALM 56:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Judicial Hypocrisy: Call to speak justice while working iniquity")
            print("2. Heart vs Hands: Contrast between inner wickedness and outward actions")
            print("3. Human Condition: Address to 'filii hominum' (sons of men) implying fallen nature")
        }
        
        // Justice assertions
        XCTAssertEqual(analysis.dictionary["justitia"]?.forms["justitiam"], 1, "Should find justice reference")
        XCTAssertEqual(analysis.dictionary["judico"]?.forms["judicate"], 1, "Should find judge verb")
        
        // Sin language
        XCTAssertEqual(analysis.dictionary["iniquitas"]?.forms["iniquitates"], 1, "Should find wickedness reference")
        XCTAssertEqual(analysis.dictionary["injustitia"]?.forms["injustitias"], 1, "Should find injustice reference")
        
        // Body parts as sin instruments
        let sinInstruments = ["corde", "manus"].reduce(0) {
            $0 + (analysis.dictionary["cor"]?.forms[$1] ?? 0)
            + (analysis.dictionary["manus"]?.forms[$1] ?? 0)
        }
        XCTAssertEqual(sinInstruments, 2, "Should find heart and hands as instruments of sin")
    }
    
    func testPsalm56Lines3and4() {
        let line3 = psalm56[2] // "Alienati sunt peccatores a vulva, erraverunt ab utero, locuti sunt falsa."
        let line4 = psalm56[3] // "Furor illis secundum similitudinem serpentis, sicut aspidis surdae et obturantis aures suas."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        let testLemmas = [
            ("alieno", ["alienati"], "estranged"),
            ("peccator", ["peccatores"], "sinners"),
            ("vulva", ["vulva"], "womb"),
            ("erro", ["erraverunt"], "go astray"),
            ("uterus", ["utero"], "womb"),
            ("loquor", ["locuti"], "speak"),
            ("falsus", ["falsa"], "false"),
            ("furor", ["furor"], "fury"),
            ("similitudo", ["similitudinem"], "likeness"),
            ("serpens", ["serpentis"], "serpent"),
            ("aspis", ["aspidis"], "asp"),
            ("surdus", ["surdae"], "deaf"),
            ("obturo", ["obturantis"], "stop up"),
            ("auris", ["aures"], "ears")
        ]
        
        if verbose {
            print("\nPSALM 56:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Inborn Sin: 'a vulva/ab utero' showing sin from birth")
            print("2. Serpentine Imagery: Comparison to deaf adder (traditional symbol of willful evil)")
            print("3. Willful Ignorance: Stopped ears as metaphor for rejecting truth")
        }
        
        // Sin nature assertions
        XCTAssertEqual(analysis.dictionary["alieno"]?.forms["alienati"], 1, "Should find estrangement")
        XCTAssertEqual(analysis.dictionary["peccator"]?.forms["peccatores"], 1, "Should find sinners reference")
        
        // Serpent imagery
        XCTAssertEqual(analysis.dictionary["serpens"]?.forms["serpentis"], 1, "Should find serpent reference")
        XCTAssertEqual(analysis.dictionary["aspis"]?.forms["aspidis"], 1, "Should find asp reference")
        
        // Sensory rejection
        XCTAssertEqual(analysis.dictionary["obturo"]?.forms["obturantis"], 1, "Should find ear-stopping verb")
        XCTAssertEqual(analysis.dictionary["surdus"]?.forms["surdae"], 1, "Should find deafness reference")
    }
    
    func testPsalm56Lines5and6() {
        let line5 = psalm56[4] // "Quae non exaudiet vocem incantantium, et venefici incantantis sapienter."
        let line6 = psalm56[5] // "Deus conteret dentes eorum in ore ipsorum; molas leonum confringet Dominus."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        let testLemmas = [
            ("exaudio", ["exaudiet"], "hear"),
            ("vox", ["vocem"], "voice"),
            ("incanto", ["incantantium", "incantantis"], "enchant"),
            ("veneficus", ["venefici"], "sorcerer"),
            ("sapienter", ["sapienter"], "wisely"),
            ("contero", ["conteret"], "crush"),
            ("dens", ["dentes"], "teeth"),
            ("os", ["ore"], "mouth"),
            ("mola", ["molas"], "molars"),
            ("leo", ["leonum"], "lion"),
            ("confringo", ["confringet"], "shatter")
        ]
        
        if verbose {
            print("\nPSALM 56:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Occult Resistance: Immunity to enchantments showing divine protection")
            print("2. Judicial Mutilation: Tooth destruction as symbolic defeat")
            print("3. Lion Imagery: Powerful enemies rendered harmless by God")
        }
        
        // Divine judgment
        XCTAssertEqual(analysis.dictionary["contero"]?.forms["conteret"], 1, "Should find crushing verb")
        XCTAssertEqual(analysis.dictionary["confringo"]?.forms["confringet"], 1, "Should find shattering verb")
        
        // Enemy imagery
        XCTAssertEqual(analysis.dictionary["leo"]?.forms["leonum"], 1, "Should find lion reference")
        XCTAssertEqual(analysis.dictionary["dens"]?.forms["dentes"], 1, "Should find teeth reference")
    }
    
    func testPsalm56Lines7and8() {
        let line7 = psalm56[6] // "Ad nihilum devenient tamquam aqua decurrens; intendit arcum suum donec infirmentur."
        let line8 = psalm56[7] // "Sicut cera quae fluit auferentur; ceciderunt ignis super eos, et non viderunt solem."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        let testLemmas = [
            ("nihil", ["nihilum"], "nothing"),
            ("devenio", ["devenient"], "come to"),
            ("aqua", ["aqua"], "water"),
            ("decurro", ["decurrens"], "run down"),
            ("intendo", ["intendit"], "stretch"),
            ("arcus", ["arcum"], "bow"),
            ("infirmo", ["infirmentur"], "weaken"),
            ("cera", ["cera"], "wax"),
            ("fluo", ["fluit"], "flow"),
            ("aufero", ["auferentur"], "carry"),
            ("cado", ["ceciderunt"], "fall"),
            ("ignis", ["ignis"], "fire"),
            ("sol", ["solem"], "sun")
        ]
        
        if verbose {
            print("\nPSALM 56:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Transience: Water and wax as symbols of impermanence")
            print("2. Divine Warfare: Bow stretched in judgment")
            print("3. Spiritual Blindness: Fire falling yet not seeing the sun (divine light)")
        }
        
        // Transience imagery
        XCTAssertEqual(analysis.dictionary["aqua"]?.forms["aqua"], 1, "Should find water reference")
        XCTAssertEqual(analysis.dictionary["cera"]?.forms["cera"], 1, "Should find wax reference")
        
        // Judgment actions
        XCTAssertEqual(analysis.dictionary["intendo"]?.forms["intendit"], 1, "Should find bow-stretching verb")
        XCTAssertEqual(analysis.dictionary["ignis"]?.forms["ignis"], 1, "Should find fire reference")
    }
    
    func testPsalm56Lines9and10() {
        let line9 = psalm56[8] // "Priusquam intelligerent spinae vestrae rhamnum, sicut viventes, sicut in ira absorbet eos."
        let line10 = psalm56[9] // "Laetabitur justus cum viderit vindictam; manus suas lavabit in sanguine peccatorum."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(text: combinedText)
        
        let testLemmas = [
            ("priusquam", ["priusquam"], "before"),
            ("intelligo", ["intelligerent"], "understand"),
            ("spina", ["spinae"], "thorn"),
            ("rhamnus", ["rhamnum"], "bramble"),
            ("vivo", ["viventes"], "live"),
            ("ira", ["ira"], "wrath"),
            ("absorbeo", ["absorbet"], "swallow"),
            ("laetor", ["laetabitur"], "rejoice"),
            ("justus", ["justus"], "righteous"),
            ("vindicta", ["vindictam"], "vengeance"),
            ("lavo", ["lavabit"], "wash"),
            ("sanguis", ["sanguine"], "blood"),
            ("peccator", ["peccatorum"], "sinner")
        ]
        
        if verbose {
            print("\nPSALM 56:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Sudden Judgment: 'Before they understand' showing unexpected doom")
            print("2. Righteous Vindication: Joy at God's justice being manifest")
            print("3. Controversial Imagery: Washing hands in blood (symbolic of complete victory)")
        }
        
        // Judgment timing
        XCTAssertEqual(analysis.dictionary["priusquam"]?.forms["priusquam"], 1, "Should find temporal conjunction")
        XCTAssertEqual(analysis.dictionary["absorbeo"]?.forms["absorbet"], 1, "Should find swallowing verb")
        
        // Righteous response
        XCTAssertEqual(analysis.dictionary["laetor"]?.forms["laetabitur"], 1, "Should find rejoicing verb")
        XCTAssertEqual(analysis.dictionary["justus"]?.forms["justus"], 1, "Should find righteous reference")
    }
    
    func testPsalm56Lines11() {
        let line11 = psalm56[10] // "Et dicet homo: Si utique est fructus justo, utique est Deus judicans eos in terra."
        let analysis = latinService.analyzePsalm(text: line11)
        
        let testLemmas = [
            ("homo", ["homo"], "man"),
            ("fructus", ["fructus"], "fruit"),
            ("justus", ["justo"], "righteous"),
            ("deus", ["deus"], "God"),
            ("judico", ["judicans"], "judge"),
            ("terra", ["terra"], "earth")
        ]
        
        if verbose {
            print("\nPSALM 56:11 ANALYSIS:")
            print("11: \"\(line11)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                let found = analysis.dictionary[lemma] != nil
                print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
            }
            
            print("\nKEY THEMES:")
            print("1. Human Acknowledgement: Universal recognition of divine justice")
            print("2. Earthly Judgment: God's verdicts manifest in temporal realm")
            print("3. Righteous Reward: 'Fruit' as metaphor for blessed outcomes")
        }
        
        // Divine justice
        XCTAssertEqual(analysis.dictionary["judico"]?.forms["judicans"], 1, "Should find judging verb")
        XCTAssertEqual(analysis.dictionary["deus"]?.forms["deus"], 1, "Should find God reference")
        
        // Reward language
        XCTAssertEqual(analysis.dictionary["fructus"]?.forms["fructus"], 1, "Should find fruit reference")
        XCTAssertEqual(analysis.dictionary["justus"]?.forms["justo"], 1, "Should find righteous reference")
    }
    
    // MARK: - Thematic Tests
    
    func testSerpentineImagery() {
        let analysis = latinService.analyzePsalm(text: psalm56)
        
        let serpentTerms = [
            ("serpens", ["serpentis"], "serpent"),
            ("aspis", ["aspidis"], "asp"),
            ("surdus", ["surdae"], "deaf"),
            ("obturo", ["obturantis"], "stop up")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: serpentTerms)
    }
    
    func testDivineJudgmentVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm56)
        
        let judgmentTerms = [
            ("contero", ["conteret"], "crush"),
            ("confringo", ["confringet"], "shatter"),
            ("intendo", ["intendit"], "stretch"),
            ("absorbeo", ["absorbet"], "swallow"),
            ("judico", ["judicans"], "judge")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    func testTransienceImagery() {
        let analysis = latinService.analyzePsalm(text: psalm56)
        
        let transientTerms = [
            ("aqua", ["aqua"], "water"),
            ("cera", ["cera"], "wax"),
            ("fluo", ["fluit"], "flow"),
            ("nihil", ["nihilum"], "nothing")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: transientTerms)
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
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}