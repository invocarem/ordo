import XCTest
@testable import LatinService

class Psalm15Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm15 = [
        "Conserva me, Domine, quoniam in te speravi;",
        "Dixi Domino: Deus meus es tu, quoniam bonorum meorum non eges.",
        "Sanctis qui sunt in terra ejus, mirificavit omnes voluntates meas in eis.",
        "Multiplicatae sunt infirmitates eorum; postea acceleraverunt.",
        "Non congregabo conventicula eorum de sanguinibus, nec memor ero nominum eorum per labia mea.",
        "Dominus pars haereditatis meae, et calicis mei: tu es qui restitues haereditatem meam mihi.",
        "Funes ceciderunt mihi in praeclaris; etenim haereditas mea praeclara est mihi.",
        "Benedicam Dominum qui tribuit mihi intellectum; insuper et usque ad noctem increpuerunt me renes mei.",
        "Providebam Dominum in conspectu meo semper: quoniam a dextris est mihi, ne commovear.",
        "Propter hoc laetatum est cor meum, et exsultavit lingua mea: insuper et caro mea requiescet in spe.",
        "Quoniam non derelinques animam meam in inferno, nec dabis sanctum tuum videre corruptionem.",
        "Notas mihi fecisti vias vitae; adimplebis me laetitia cum vultu tuo: delectationes in dextera tua usque in finem."
    ]
    
    // MARK: - Test Cases
    func testPsalm15Lines1and2() {
    let line1 = psalm15[0] // "Conserva me, Domine, quoniam in te speravi;"
    let line2 = psalm15[1] // "Dixi Domino: Deus meus es tu, quoniam bonorum meorum non eges."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("conservo", ["conserva"], "preserve"),
        ("dominus", ["domine", "domino"], "Lord"),
        ("quoniam", ["quoniam"], "because"),
        ("spero", ["speravi"], "hope"),
        ("dico", ["dixi"], "say"),
        ("deus", ["deus"], "God"),
        ("bonus", ["bonorum"], "good"),
        ("egeo", ["eges"], "need")
    ]
    
    if verbose {
        print("\nPSALM 15:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Prayer for Preservation: 'Conserva me' (Preserve me)")
        print("2. Personal Covenant: 'Deus meus es tu' (You are my God)")
        print("3. Divine Self-Sufficiency: 'bonorum meorum non eges' (You don't need my goods)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["conservo"]?.forms["conserva"], 1, "Should find preservation imperative")
    XCTAssertEqual(analysis.dictionary["deus"]?.forms["deus"], 1, "Should detect divine title")
    
    // Test personal declarations
    XCTAssertEqual(analysis.dictionary["ego"]?.forms["me"] ?? 0, 1, "Should find 'me'")
    XCTAssertEqual(analysis.dictionary["meus"]?.forms["meus"] ?? 0, 1, "Should find 'meus'")
    XCTAssertEqual(analysis.dictionary["meus"]?.forms["meorum"] ?? 0, 1, "Should find 'meorum'")
       
    // Test theological contrast
    let hasHumanGoods = analysis.dictionary["bonus"]?.forms["bonorum"] ?? 0 > 0
    let hasDivineNeed = analysis.dictionary["egeo"]?.forms["eges"] ?? 0 > 0
    XCTAssertTrue(hasHumanGoods && hasDivineNeed, "Should contrast human goods with divine needlessness")
}

func testPsalm15Lines3and4() {
    let line3 = psalm15[2] // "Sanctis qui sunt in terra ejus, mirificavit omnes voluntates meas in eis."
    let line4 = psalm15[3] // "Multiplicatae sunt infirmitates eorum; postea acceleraverunt."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("sanctus", ["sanctis"], "holy"),
        ("sum", ["sunt"], "are"),
        ("terra", ["terra"], "land"),
        ("mirifico", ["mirificavit"], "wonderful"),
        ("voluntas", ["voluntates"], "desires"),
        ("meus", ["meas"], "my"),
        ("multiplico", ["multiplicatae"], "multiplied"),
        ("infirmitas", ["infirmitates"], "sufferings"),
        ("postea", ["postea"], "afterwards"),
        ("accelero", ["acceleraverunt"], "accelerated")
    ]
    
    if verbose {
        print("\nPSALM 15:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Holy Community: 'sanctis in terra ejus' (holy ones in His land)")
        print("2. Divine Fulfillment: 'mirificavit voluntates meas' (wonderfully fulfilled my desires)")
        print("3. Contrast: Blessings (v3) vs Sufferings (v4)")
    }
    
    // Key assertions
    XCTAssertEqual(analysis.dictionary["sanctus"]?.forms["sanctis"], 1, "Should find 'holy ones' reference")
    XCTAssertEqual(analysis.dictionary["mirifico"]?.forms["mirificavit"], 1, "Should detect divine fulfillment")
    
    // Test contrast between verses
    let blessingsCount = analysis.dictionary["voluntas"]?.forms["voluntates"] ?? 0
    let sufferingsCount = analysis.dictionary["infirmitas"]?.forms["infirmitates"] ?? 0
    XCTAssertEqual(blessingsCount + sufferingsCount, 2, "Should find both blessings and sufferings")
    
    // Test verb sequence
    let perfectVerbs = ["mirificavit", "acceleraverunt"].reduce(0) {
        $0 + (analysis.dictionary["mirifico"]?.forms[$1] ?? 0)
        + (analysis.dictionary["accelero"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(perfectVerbs, 2, "Should find both perfect tense verbs")
}
func testPsalm15Lines5and6() {
    let line5 = psalm15[4] // "Non congregabo conventicula eorum de sanguinibus, nec memor ero nominum eorum per labia mea."
    let line6 = psalm15[5] // "Dominus pars haereditatis meae, et calicis mei: tu es qui restitues haereditatem meam mihi."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("congrego", ["congregabo"], "assemble"),
        ("conventiculum", ["conventicula"], "assemblies"),
        ("sanguis", ["sanguinibus"], "blood"),
        ("memor", ["memor"], "mindful"),
        ("nomen", ["nomina"], "names"),
        ("labium", ["labia"], "lips"),
        ("dominus", ["dominus"], "Lord"),
        ("pars", ["pars"], "portion"),
        ("haereditas", ["haereditatis", "haereditatem"], "inheritance"),
        ("calix", ["calicis"], "cup"),
        ("restituo", ["restitues"], "restore")
    ]
    
    if verbose {
        print("\nPSALM 15:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Rejection of Pagan Rites: 'sanguinibus' (blood sacrifices) + 'nomina' (names of false gods)")
        print("2. Divine Inheritance: 'pars haereditatis' (portion of inheritance)")
        print("3. Covenant Cup: 'calicis mei' (my cup) as liturgical symbol")
    }
    
    // Negative declaration assertions
    XCTAssertEqual(analysis.dictionary["congrego"]?.forms["congregabo"], 1, "Should find negative assembly verb")
    XCTAssertEqual(analysis.dictionary["memor"]?.forms["memor"], 1, "Should detect 'memor ero' negation")
    
    // Positive theological assertions
    XCTAssertEqual(analysis.dictionary["pars"]?.forms["pars"], 1, "Should find 'portion' declaration")
    XCTAssertEqual(analysis.dictionary["calix"]?.forms["calicis"], 1, "Should detect covenantal cup")
    
    // Test inheritance terminology
    let inheritanceTerms = ["haereditatis", "haereditatem"].reduce(0) {
        $0 + (analysis.dictionary["haereditas"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(inheritanceTerms, 2, "Should find both inheritance references")
    
    // Test blood sacrifice reference
    let isBloodPlural = analysis.dictionary["sanguis"]?.forms["sanguinibus"] == 1
    XCTAssertTrue(isBloodPlural, "Should find plural 'bloods' (ritual sacrifices)")
}
func testPsalm15Lines7and8() {
    let line7 = psalm15[6] // "Funes ceciderunt mihi in praeclaris; etenim haereditas mea praeclara est mihi."
    let line8 = psalm15[7] // "Benedicam Dominum qui tribuit mihi intellectum; insuper et usque ad noctem increpuerunt me renes mei."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("funis", ["funes"], "boundary lines"),
        ("cado", ["ceciderunt"], "fall"),
        ("praeclarus", ["praeclaris", "praeclara"], "excellent"),
        ("haereditas", ["haereditas"], "inheritance"),
        ("benedico", ["benedicam"], "bless"),
        ("tribuo", ["tribuit"], "give"),
        ("intellectus", ["intellectum"], "understanding"),
        ("usque", ["usque"], "even unto"),
        ("nox", ["noctem"], "night"),
        ("increpo", ["increpuerunt"], "admonish"),
        ("ren", ["renes"], "kidneys/inner self")
    ]
    
    if verbose {
        print("\nPSALM 15:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nALL DETECTED LEMMAS: " + analysis.dictionary.keys.sorted().joined(separator: ", "))
        
        print("\nKEY THEMES:")
        print("1. Land Allotment: 'funes...in praeclaris' (boundary lines in pleasant places)")
        print("2. Divine Instruction: 'tribuit intellectum' (gave understanding)")
        print("3. Nightly Examination: 'usque ad noctem increpuerunt me renes mei' (even at night my conscience instructs me)")
    }
    
    // Land inheritance assertions
    XCTAssertEqual(analysis.dictionary["funis"]?.forms["funes"], 1, "Should find boundary lines")
    XCTAssertEqual(analysis.dictionary["praeclarus"]?.forms["praeclaris"], 1, "Should detect 'pleasant places'")
    
    // Spiritual gifts testing
    let hasIntellectum = analysis.dictionary["intellectus"]?.forms["intellectum"] ?? 0 > 0
    let hasNightlyExamination = analysis.dictionary["increpo"]?.forms["increpuerunt"] ?? 0 > 0
    XCTAssertTrue(hasIntellectum && hasNightlyExamination, "Should find both divine gift and human response")
    
    // Test body part metaphor
    let renalGuidance = analysis.dictionary["ren"]?.forms["renes"] ?? 0
    XCTAssertEqual(renalGuidance, 1, "Should find kidneys/inner self reference")
    
    // Verify verb tenses
    let perfectVerb = analysis.dictionary["cado"]?.forms["ceciderunt"] ?? 0
    let futureVerb = analysis.dictionary["benedico"]?.forms["benedicam"] ?? 0
    XCTAssertEqual(perfectVerb + futureVerb, 2, "Should find both perfect and future verbs")
}

func testPsalm15Lines9and10() {
    let line9 = psalm15[8] // "Providebam Dominum in conspectu meo semper: quoniam a dextris est mihi, ne commovear."
    let line10 = psalm15[9] // "Propter hoc laetatum est cor meum, et exsultavit lingua mea: insuper et caro mea requiescet in spe."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("provideo", ["providebam"], "set before"),
        ("conspectus", ["conspectu"], "sight"),
        ("dexter", ["dextris"], "right hand"),
        ("commoveo", ["commovear"], "be shaken"),
        ("laetor", ["laetatum"], "rejoice"),
        ("cor", ["cor"], "heart"),
        ("exsulto", ["exsultavit"], "exult"),
        ("lingua", ["lingua"], "tongue"),
        ("caro", ["caro"], "flesh"),
        ("requiesco", ["requiescet"], "rest"),
        ("spes", ["spe"], "hope")
    ]
    
    if verbose {
        print("\nPSALM 15:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
    }
    
    // Continuous devotion assertions
    XCTAssertEqual(analysis.dictionary["provideo"]?.forms["providebam"], 1, "Should find continual 'setting before'")
    XCTAssertEqual(analysis.dictionary["dexter"]?.forms["dextris"], 1, "Should detect right hand position")
    
    // Joyful response testing
    let joyVerbs = ["laetatum", "exsultavit"].reduce(0) {
        $0 + (analysis.dictionary["laetor"]?.forms[$1] ?? 0)
        + (analysis.dictionary["exsulto"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(joyVerbs, 2, "Should find both joy verbs")
    
    // Test body-soul integration
    let bodyParts = ["cor", "lingua", "caro"].map {
        analysis.dictionary[$0]?.forms.values.reduce(0, +) ?? 0
    }
    XCTAssertEqual(bodyParts.reduce(0, +), 3, "Should find heart, tongue, and flesh references")
}
func testPsalm15Lines11and12() {
    let line11 = psalm15[10] // "Quoniam non derelinques animam meam in inferno, nec dabis sanctum tuum videre corruptionem."
    let line12 = psalm15[11] // "Notas mihi fecisti vias vitae; adimplebis me laetitia cum vultu tuo: delectationes in dextera tua usque in finem."
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("derelinquo", ["derelinques"], "abandon"),
        ("anima", ["animam"], "soul"),
        ("infernus", ["inferno"], "Sheol"),
        ("sanctus", ["sanctum"], "holy"),
        ("corruptio", ["corruptionem"], "decay"),
        ("notus", ["notas"], "known"),
        ("via", ["vias"], "way"),
        ("vita", ["vitae"], "life"),
        ("adimpleo", ["adimplebis"], "fill"),
        ("laetitia", ["laetitia"], "joy"),
        ("vultus", ["vultu"], "face"),
        ("delectatio", ["delectationes"], "pleasures"),
        ("finis", ["finem"], "end")
    ]
    
    if verbose {
        print("\nPSALM 15:11-12 ANALYSIS:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
    }
    
    // Resurrection theology
    XCTAssertEqual(analysis.dictionary["derelinquo"]?.forms["derelinques"], 1, "Should find 'not abandon' promise")
    XCTAssertEqual(analysis.dictionary["corruptio"]?.forms["corruptionem"], 1, "Should detect corruption negation")
    
    // Path of life assertions
    let pathTerms = ["vias", "vitae"].reduce(0) {
        $0 + (analysis.dictionary["via"]?.forms[$1] ?? 0)
        + (analysis.dictionary["vita"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(pathTerms, 2, "Should find 'paths of life'")
    
    // Eschatological joy
    let joyTerms = analysis.dictionary["laetitia"]?.forms["laetitia"] ?? 0
    let delightTerms = analysis.dictionary["delectatio"]?.forms["delectationes"] ?? 0
    XCTAssertEqual(joyTerms + delightTerms, 2, "Should find both joy and delight terms")
}


    func testRefugeVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let refugeTerms = [
            ("conservo", ["conserva"], "preserve"),
            ("spero", ["speravi"], "hope"),
            ("pars", ["pars"], "portion"),
            ("haereditas", ["haereditatis", "haereditas"], "inheritance"),
            ("restituo", ["restitues"], "restore")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: refugeTerms)
    }
    
    func testBodyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let bodyTerms = [
            ("ren", ["renes"], "kidney"), // Seat of emotion
            ("cor", ["cor"], "heart"),
            ("lingua", ["lingua"], "tongue"),
            ("caro", ["caro"], "flesh"),
            ("labium", ["labia"], "lip")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    
    func testEschatologicalHope() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let hopeTerms = [
            ("infernus", ["inferno"], "hell"),
            ("corruptio", ["corruptionem"], "decay"),
            ("requiesco", ["requiescet"], "rest"),
            ("vita", ["vitae"], "life"),
            ("laetitia", ["laetitia"], "joy")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: hopeTerms)
    }
    
    func testCovenantalLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let covenantTerms = [
            ("sanctus", ["sanctis", "sanctum"], "holy"),
            ("calix", ["calicis"], "cup"),
            ("funis", ["funes"], "cord"),
            ("dexter", ["dextera"], "right hand"),
            ("vultus", ["vultu"], "face"),
            ("delectatio", ["delectationes"], "delight")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: covenantTerms)
    }
    
    func testDivinePresence() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        
        let presenceTerms = [
            ("provideo", ["Providebam"], "set before"),
            ("dexter", ["dextris", "dextera"], "right hand"),
            ("notus", ["notas"], "known"),
            ("mirifico", ["mirificavit"], "make wonderful")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: presenceTerms)
    }
    func testzAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm15)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'calix' forms:", analysis.dictionary["calix"]?.forms ?? [:])
                    }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
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