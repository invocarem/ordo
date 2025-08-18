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
            ("rex", ["regis"], "king"), // v.2
            ("dominium", ["Domini"], "Lord"), // v.1, v.8
            ("regnum", ["reget"], "rule") // v.14
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sovereigntyTerms)
    }
    
    func testZionReferences() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let zionTerms = [
            ("Sion", ["Sion"], "Zion"), // v.2, v.11
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
            ("tremor", ["tremor"], "trembling"), // v.6
            ("conturbo", ["conturbati"], "disturb") // v.5
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    func testPraiseAndRejoicing() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let praiseTerms = [
            ("laudo", ["laudabilis", "laus"], "praise"), // v.1, v.10
            ("exsulto", ["exsultatione", "exsultent"], "rejoice"), // v.2, v.11
            ("laetitia", ["Laetetur"], "gladness"), // v.11
            ("narro", ["narrate", "enarretis"], "declare") // v.12, v.13
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: praiseTerms)
    }
    
    func testEternalNature() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        
        let eternalTerms = [
            ("aeternus", ["aeternum"], "eternal"), // v.8
            ("saeculum", ["saeculum", "saeculi", "saecula"], "age/forever"), // v.14
            ("fundamentum", ["fundatur", "fundavit"], "establish"), // v.2, v.8
            ("suscipio", ["suscipiet", "Suscepimus"], "receive") // v.3, v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: eternalTerms)
    }
    
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(identity, text: psalm47)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'magnus' forms:", analysis.dictionary["magnus"]?.forms ?? [:])
            print("'Sion' forms:", analysis.dictionary["Sion"]?.forms ?? [:])
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