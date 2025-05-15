import XCTest
@testable import LatinService

class Psalm2Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    // MARK: - Test Data
    let psalm2 = [
        "Quare fremuerunt gentes, et populi meditati sunt inania?",
        "Astiterunt reges terrae, et principes convenerunt in unum adversus Dominum, et adversus christum ejus.",
        "Dirumpamus vincula eorum, et projiciamus a nobis jugum ipsorum.",
        "Qui habitat in caelis irridebit eos, et Dominus subsannabit eos.",
        "Tunc loquetur ad eos in ira sua, et in furore suo conturbabit eos.",
        "Ego autem constitutus sum rex ab eo super Sion montem sanctum ejus, praedicans praeceptum ejus.",
        "Dominus dixit ad me: Filius meus es tu, ego hodie genui te.",
        "Postula a me, et dabo tibi gentes hereditatem tuam, et possessionem tuam terminos terrae.",
        "Reges eos in virga ferrea, et tamquam vas figuli confringes eos.",
        "Et nunc, reges, intelligite; erudimini, qui judicatis terram.",
        "Servite Domino in timore, et exsultate ei cum tremore.",
        "Apprehendite disciplinam, nequando irascatur Dominus, et pereatis de via justa. Cum exarserit in brevi ira ejus, beati omnes qui confidunt in eo."
    ]
    
    // MARK: 
    func testPsalm2Lines1and2() {
    let line1 = psalm2[0] 
    let line2 = psalm2[1] 
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("quare", ["quare"], "why"),
        ("fremo", ["fremuerunt"], "rage"),
        ("gens", ["gentes"], "nations"),
        ("populus", ["populi"], "people"),
        ("meditor", ["meditati"], "plot"),
        ("inanis", ["inania"], "vain"),
        ("asto", ["astiterunt"], "take stand"),
        ("rex", ["reges"], "kings"),
        ("terra", ["terrae"], "earth"),
        ("princeps", ["principes"], "ruler"),
        ("convenio", ["convenerunt"], "assemble"),
        ("unus", ["unum"], "one"),
        ("adversus", ["adversus"], "against"),
        ("dominus", ["dominum"], "Lord"),
        ("christus", ["christum"], "anointed")
    ]
    
    if verbose {
        print("\nPSALM 2:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Rebel Alliance: gentes (nations) + reges (kings) + principes (rulers)")
        print("2. Divine Challenge: adversus Dominum (against the Lord)")
        print("3. Messianic Reference: christum ejus (His anointed)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["fremo"]?.forms["fremuerunt"], 1, "Should find 'raged' verb")
    XCTAssertEqual(analysis.dictionary["adversus"]?.forms["adversus"], 2, "Should find double 'against'")
    XCTAssertEqual(analysis.dictionary["christus"]?.forms["christum"], 1, "Should find messianic reference")
    
    // Test rebel coalition terms
    let rebelTerms = ["gentes", "reges", "principes"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(rebelTerms.filter { $0 }.count, 3, "Should find all three rebel group terms")
    
    // Test divine focus
    let divineTerms = ["dominum", "christum"].reduce(0) {
        $0 + (analysis.dictionary["dominus"]?.forms[$1] ?? 0)
        + (analysis.dictionary["christus"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(divineTerms, 2, "Should find both divine references")
}
func testPsalm2Lines3and4() {
    let line3 = psalm2[2] // "Dirumpamus vincula eorum, et projiciamus a nobis jugum ipsorum."
    let line4 = psalm2[3] // "Qui habitat in caelis irridebit eos, et Dominus subsannabit eos."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("dirumpo", ["dirumpamus"], "break apart"),
        ("vinculum", ["vincula"], "bonds"),
        ("projicio", ["projiciamus"], "cast"),
        ("jugum", ["jugum"], "yoke"),
        ("habito", ["habitat"], "dwell"),
        ("caelum", ["caelis"], "heaven"),
        ("irrideo", ["irridebit"], "laugh at"),
        ("subsanno", ["subsannabit"], "deride"),
        ("dominus", ["dominus"], "Lord")
    ]
    
    if verbose {
        print("\nPSALM 2:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY CONTRASTS:")
        print("Human Rebellion: dirumpamus (let's break) ↔ Divine Mockery: irridebit (will laugh)")
        print("Physical Bonds: vincula (chains) vs Spiritual Authority: caelis (heavens)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["dirumpo"]?.forms["dirumpamus"], 1, "Should find rebel action")
    XCTAssertEqual(analysis.dictionary["irrideo"]?.forms["irridebit"], 1, "Should find divine mockery")
    
    // Test bond/yoke imagery
    let bondageTerms = ["vincula", "jugum"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(bondageTerms.filter { $0 }.count, 2, "Should find both bondage terms")
    
    // Test divine perspective verbs
    let mockeryVerbs = ["irridebit", "subsannabit"].reduce(0) {
        $0 + (analysis.dictionary["irrideo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["subsanno"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(mockeryVerbs, 2, "Should find both divine mockery verbs")
}
  func testPsalm2Lines5and6() {
    let line5 = psalm2[4] // "Tunc loquetur ad eos in ira sua, et in furore suo conturbabit eos."
    let line6 = psalm2[5] // "Ego autem constitutus sum rex ab eo super Sion montem sanctum ejus, praedicans praeceptum ejus."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("loquor", ["loquetur"], "speak"),
        ("ira", ["ira"], "wrath"),
        ("furor", ["furore"], "fury"),
        ("conturbo", ["conturbabit"], "terrify"),
        ("constituo", ["constitutus"], "establish"),
        ("rex", ["rex"], "king"),
        ("sion", ["sion"], "Zion"),
        ("mons", ["montem"], "mountain"),
        ("sanctus", ["sanctum"], "holy"),
        ("praedico", ["praedicans"], "declare"),
        ("praeceptum", ["praeceptum"], "decree")
    ]
    
    if verbose {
        print("\nPSALM 2:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Divine Wrath: ira (wrath) + furor (fury) → conturbabit (will terrify)")
        print("2. Royal Decree: constitutus sum rex (I was established king) + praedicans (declaring)")
        print("3. Holy Mountain: Sion + montem sanctum (holy mountain)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["ira"]?.forms["ira"], 1, "Should find divine wrath")
    XCTAssertEqual(analysis.dictionary["rex"]?.forms["rex"], 1, "Should find kingly title")
    XCTAssertEqual(analysis.dictionary["Sion"]?.forms["Sion"], 1, "Should find Zion reference")
    
    // Test divine speech actions
    let speechVerbs = ["loquetur", "praedicans"].reduce(0) {
        $0 + (analysis.dictionary["loquor"]?.forms[$1] ?? 0)
        + (analysis.dictionary["praedico"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(speechVerbs, 2, "Should find both speech actions")
    
    // Test authority terms
    let authorityTerms = ["rex", "praeceptum", "constitutus"].map {
        analysis.dictionary.values.flatMap { $0.forms.keys }.contains($0)
    }
    XCTAssertEqual(authorityTerms.filter { $0 }.count, 3, "Should find all authority terms")
}
func testPsalm2Lines7and8() {
    let lines = [psalm2[6], psalm2[7]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("dico", ["dixit"], "say"),
        ("filius", ["filius"], "son"),
        ("hodie", ["hodie"], "today"),
        ("gigno", ["genui"], "beget"),
        ("postulo", ["postula"], "ask"),
        ("do", ["dabo"], "give"),
        ("gens", ["gentes"], "nations"),
        ("hereditas", ["hereditatem"], "inheritance"),
        ("possessio", ["possessionem"], "possession"),
        ("terminus", ["terminos"], "ends")
    ]
    
    if verbose {
        print("\nPSALM 2:7-8 ANALYSIS:")
        print("7: \"\(psalm2[6])\"")
        print("8: \"\(psalm2[7])\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Sonship: 'Filius meus es tu' (You are my Son)")
        print("2. Universal Reign: 'gentes...terminos terrae' (nations...ends of earth)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["filius"]?.forms["filius"], 1, "Sonship declaration missing")
    XCTAssertEqual(analysis.dictionary["gigno"]?.forms["genui"], 1, "Begetting verb missing")
    XCTAssertEqual(analysis.dictionary["terminus"]?.forms["terminos"], 1, "Earth's ends reference missing")
}

func testPsalm2Lines9and10() {
    let lines = [psalm2[8], psalm2[9]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("rego", ["reges"], "rule"),
        ("virga", ["virga"], "rod"),
        ("ferreus", ["ferrea"], "iron"),
        ("vas", ["vas"], "vessel"),
        ("figulus", ["figuli"], "potter"),
        ("confringo", ["confringes"], "shatter"),
        ("intelligo", ["intelligite"], "understand"),
        ("erudio", ["erudimini"], "be instructed"),
        ("judico", ["judicatis"], "judge")
    ]
    
    if verbose {
        print("\nPSALM 2:9-10 ANALYSIS:")
        print("9: \"\(psalm2[8])\"")
        print("10: \"\(psalm2[9])\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Iron Rule: 'virga ferrea' (iron rod) + 'confringes' (shatter)")
        print("2. Royal Warning: 'intelligite...erudimini' (understand...be instructed)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["virga"]?.forms["virga"], 1, "Iron rod reference missing")
    XCTAssertEqual(analysis.dictionary["confringo"]?.forms["confringes"], 1, "Shattering action missing")
    XCTAssertEqual(analysis.dictionary["erudio"]?.forms["erudimini"], 1, "Instruction verb missing")
}

func testPsalm2Lines11and12() {
    let lines = [psalm2[10], psalm2[11]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("servio", ["servite"], "serve"),
        ("timor", ["timore"], "fear"),
        ("exsulto", ["exsultate"], "rejoice"),
        ("tremor", ["tremore"], "trembling"),
        ("apprehendo", ["apprehendite"], "take hold"),
        ("disciplina", ["disciplinam"], "discipline"),
        ("irascor", ["irascatur"], "be angry"),
        ("pereo", ["pereatis"], "perish"),
        ("beatus", ["beati"], "blessed"),
        ("confido", ["confidunt"], "trust")
    ]
    
    if verbose {
        print("\nPSALM 2:11-12 ANALYSIS:")
        print("11: \"\(psalm2[10])\"")
        print("12: \"\(psalm2[11])\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nTHEMES:")
        print("1. Paradoxical Worship: 'Servite...cum tremore' (Serve...with trembling)")
        print("2. Urgent Warning: 'nequando irascatur' (lest He be angry)")
        print("3. Final Beatitude: 'beati qui confidunt' (blessed are those who trust)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["timor"]?.forms["timore"], 1, "Fear reference missing")
    XCTAssertEqual(analysis.dictionary["beatus"]?.forms["beati"], 1, "Blessing declaration missing")
    XCTAssertEqual(analysis.dictionary["confido"]?.forms["confidunt"], 1, "Trust verb missing")
}

    func testRareNouns() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        let rareNouns = [
            ("jugum", ["jugum"], "yoke"),
            ("virga", ["virga"], "rod"),
            ("vas", ["vas"], "vessel"),
            ("terminus", ["terminos"], "boundary")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareNouns)
    }
    
    func testUniqueVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        let rareVerbs = [
            ("fremo", ["fremuerunt"], "rage"),
            ("subsanno", ["subsannabit"], "mock"),
            ("conturbo", ["conturbabit"], "terrify"),
            ("confringo", ["confringes"], "shatter")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareVerbs)
    }
    
    func testHapaxLegomena() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        // Words appearing only once in Psalm 2
        let uniqueWords = [
            ("figulus", ["figuli"], "potter"),
            ("tremor", ["tremore"], "trembling"),
            ("disciplina", ["disciplinam"], "instruction")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: uniqueWords)
    }

    func testRebellionTheme() {
        let analysis = latinService.analyzePsalm(text: psalm2)
        
        let rebellionWords = [
            ("fremo", ["fremuerunt"], "rage"),
            ("adversus", ["adversus"], "against"),
            ("dirumpo", ["dirumpamus"], "break apart"),
            ("projicio", ["projiciamus"], "cast")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rebellionWords)
        
     
    }
    func testMetaphoricalLanguage() {
    let analysis = latinService.analyzePsalm(text: psalm2)
    
    // Key components of metaphors in Psalm 2
    let metaphoricalElements = [
        ("bondage_imagery", ["vincula", "jugum"], ["chain", "yoke"]),
        ("pottery_imagery", ["vas", "figuli"], ["vessel", "potter"]),
        ("rulership_imagery", ["virga", "ferrea"], ["rod", "iron"]),
        ("anger_imagery", ["ira", "furore"], ["wrath", "fury"]),
        ("inheritance_imagery", ["hereditatem", "terminos"], ["inheritance", "boundary"])
    ]
    
    for (imageryName, latinWords, englishWords) in metaphoricalElements {
        // Verify Latin words exist in analysis
        for word in latinWords {
            let found = analysis.dictionary.contains { (_, entry) in
                entry.forms.keys.contains(word.lowercased())
            }
            
            XCTAssertTrue(found, "Word '\(word)' for \(imageryName) imagery should be present in analysis")
            
            if verbose && !found {
                print("Missing word for \(imageryName) imagery: \(word)")
            }
        }
        
        // Verify English translations contain expected concepts
        for (latinWord, englishWord) in zip(latinWords, englishWords) {
            if let entry = analysis.dictionary.first(where: { (_, entry) in
                entry.forms.keys.contains(latinWord.lowercased())
            })?.value {
                let translationContains = entry.translation?.lowercased().contains(englishWord.lowercased()) ?? false
                XCTAssertTrue(translationContains,
                             "Translation for \(latinWord) should include concept '\(englishWord)' for \(imageryName) imagery")
                
                if verbose && !translationContains {
                    print("Translation for \(latinWord) (\(entry.translation ?? "")) missing concept: \(englishWord)")
                }
            }
        }
    }
}
    
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
            XCTAssertTrue(entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                         "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'")
            
            // Verify forms
            for form in forms {
                let count = entry.forms[form.lowercased()] ?? 0
                if verbose {
                    print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
                XCTAssertGreaterThan(count, 0, "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
    }
}