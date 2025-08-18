import XCTest
@testable import LatinService

class Psalm47Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let identity = PsalmIdentity(number: 47, category: "divine_sovereignty")
    
    // MARK: - Test Data (Psalm 47)
    let psalm47 = [
        "Magnus Dominus, et laudabilis nimis in civitate Dei nostri, in monte sancto eius.",
        "Fundatur exsultatione universae terrae, mons Sion; latera aquilonis, civitas regis magni.",
        "Deus in domibus eius cognoscetur, cum suscipiet eam.",
        "Quoniam ecce reges terrae congregati sunt; convenerunt in unum.",
        "Ipsi videntes sic admirati sunt, conturbati sunt, commoti sunt;",
        "tremor apprehendit eos ibi, dolores ut parturientis.",
        "In spiritu vehementi conteres naves Tharsis.",
        "Sicut audivimus, sic vidimus in civitate Domini virtutum, in civitate Dei nostri; Deus fundavit eam in aeternum.",
        "Suscepimus, Deus, misericordiam tuam in medio templi tui.",
        "Secundum nomen tuum, Deus, sic et laus tua in fines terrae; iustitia plena est dextera tua.",
        "Laetetur mons Sion, et exsultent filiae Iudae propter iudicia tua, Domine.",
        "Circumdate Sion, et complectimini eam; narrate in turribus eius.",
        "Ponite corda vestra in virtute eius, et distribuite domos eius, ut enarretis in progenie altera.",
        "Quoniam hic est Deus, Deus noster in aeternum et in saeculum saeculi; ipse reget nos in saecula."
    ]
    
    // MARK: - Test Cases
    
    func testDivineSovereigntyTerms() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let sovereigntyTerms = [
            ("magnus", ["magnus", "magni"], "great"), // v.1, v.2
            ("rex", ["regis", "reges"], "king"), // v.2, v.4
            ("dominus", ["Dominus", "Domini", "Domine"], "Lord"), // v.1, v.8, v.11
            ("rego", ["reget"], "rule") // v.14
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sovereigntyTerms)
    }
    
    func testZionReferences() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let zionTerms = [
            ("Sion", ["Sion"], "Zion"), // v.2, v.11 (proper noun, indeclinable)
            ("civitas", ["civitate", "civitas"], "city"), // v.1, v.2, v.8
            ("mons", ["monte", "mons"], "mountain"), // v.1, v.2, v.11
            ("templum", ["templi"], "temple") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: zionTerms)
    }
    
    func testDivineJudgment() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let judgmentTerms = [
            ("iudicium", ["iudicia"], "judgment"), // v.11
            ("iustitia", ["iustitia"], "justice"), // v.10
            ("tremor", ["tremor"], "trembling"), // v.6 (noun)
            ("conturbo", ["conturbati"], "disturb"), // v.5
            ("admiror", ["admirati"], "admire") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    func testPraiseAndRejoicing() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let praiseTerms = [
            ("laudabilis", ["laudabilis"], "praiseworthy"), 
            ("laus", ["laus"], "praise"), // v.10 (noun)
            ("exsulto", ["exsultent"], "rejoice"), // v.11 (verb)
            ("exsultatio", ["exsultatione"], "rejoicing"), // v.2 (noun)
            ("laetor", ["Laetetur"], "rejoice"), // v.11
            ("narro", ["narrate"], "tell"), // 2nd pl. present imperative active
            ("enarro", ["enarretis"], "relate") // 2nd pl. future indicative active
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: praiseTerms)
    }
    
    func testEternalNature() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let eternalTerms = [
            ("aeternus", ["aeternum"], "eternal"), // v.8
            ("saeculum", ["saeculum", "saeculi", "saecula"], "age"), // v.14
            ("fundo", ["fundatur", "fundavit"], "establish"), // v.2, v.8
            ("suscipio", ["suscipiet", "Suscepimus"], "receive") // v.3, v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: eternalTerms)
    }
    
    func testDivinePower() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let powerTerms = [
            ("virtus", ["virtute", "virtutum"], "power"), // v.13, v.8
            ("contero", ["conteres"], "shatter"), // v.7
            ("dexter", ["dextera"], "right hand"), // v.10
            ("apprehendo", ["apprehendit"], "seize") // v.6
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: powerTerms)
    }
    func testProblematicPrepositionalPhrases() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let prepositionalTerms = [
            ("medium", ["medio"], "midst"), // v.9 "in medio templi"
            ("finis", ["fines"], "end"), // v.10 "in fines terrae"
            ("unus", ["unum"], "one"), // v.4 "in unum"
            ("aeternum", ["aeternum"], "eternity") // v.8, v.14
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: prepositionalTerms)
    }

    func testRareForms() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let rareForms = [
            ("vehemens", ["vehementi"], "violent"), // v.7 "spiritu vehementi"
            ("enarro", ["enarretis"], "recount"), // v.13 - Prefixed verb
            ("latus", ["latera"], "broad"), // v.2 "latera aquilonis"
            ("aquilo", ["aquilonis"], "north"),
            ("complector", ["complectimini"], "embrace"), // v.12 - Rare imperative
            ("distribuo", ["distribuite"], "distribute"), // v.13 - Administrative term
            ("parturio", ["parturientis"], "be in labor") // v.6 - Unique metaphor
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareForms)
    }


    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'dominus' forms:", analysis.dictionary["dominus"]?.forms ?? [:])
            print("'rex' forms:", analysis.dictionary["rex"]?.forms ?? [:])
            print("'iudicium' forms:", analysis.dictionary["iudicium"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Form verification (case-insensitive)
            let entryFormsLowercased = Dictionary(uniqueKeysWithValues:
                entry.forms.map { ($0.key.lowercased(), $0.value) }
            )
            
            let missingForms = forms.filter { entryFormsLowercased[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entryFormsLowercased[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}