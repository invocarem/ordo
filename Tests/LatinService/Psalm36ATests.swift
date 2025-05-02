import XCTest
@testable import LatinService 

class Psalm36ATests: XCTestCase {
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

     private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
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
    func testAnalyzePsalm36A() {
    let psalm36 = [
        "Noli aemulari in malignantibus; neque zelaveris facientes iniquitatem.",
        "Quoniam tamquam fenum velociter arescent; et quemadmodum olera herbarum cito decident.",
        "Spera in Domino, et fac bonitatem; et inhabita terram, et pasceris in divitiis ejus.",
        "Delectare in Domino, et dabit tibi petitiones cordis tui.",
        "Revela Domino viam tuam, et spera in eo, et ipse faciet.",
        "Et educet quasi lumen justitiam tuam, et judicium tuum tamquam meridiem.",
        "Subditus esto Domino, et ora eum; noli aemulari in eo qui prosperatur in via sua, in homine faciente injustitias.",
        "Dese ab ira, et derelinque furorem; noli aemulari ut maligneris.",
        "Quoniam qui malignantur exterminabuntur; sustinentes autem Dominum, ipsi haereditabunt terram.",
        "Et adhuc pusillum, et non erit peccator; et quaeres locum ejus, et non invenies.",
        "Mansueti autem haereditabunt terram, et delectabuntur in multitudine pacis.",
        "Observabit peccator justum, et stridebit super eo dentibus suis.",
        "Dominus autem irridebit eum, quoniam prospicit quod veniet dies ejus.",
        "Gladium evaginaverunt peccatores; intenderunt arcum suum, ut dejiciant pauperem et inopem, ut trucident rectos corde.",
        "Gladius eorum intret in corda ipsorum, et arcus eorum confringatur.",
        "Melius est modicum justo, super divitias peccatorum multas.",
        "Quoniam brachia peccatorum conterentur; confirmat autem justos Dominus.",
        "Novit Dominus dies immaculatorum; et haereditas eorum in aeternum erit.",
        "Non confundentur in tempore malo, et in diebus famis saturabuntur.",
        "Quia peccatores peribunt; inimici vero Domini mox ut honorificati fuerint et exaltati, deficiens quemadmodum fumus deficient.",
        "Mutuo accipiet peccator, et non solvet; justus autem miseretur et tribuet.",
        "Quia benedicentes ei haereditabunt terram; maledicentes autem ei disperibunt.",
        "Apud Dominum gressus hominis dirigentur; et viam ejus volet.",
        "Cum ceciderit, non collidetur, quia Dominus supponit manum suam.",
        "Junior fui, etenim senui; et non vidi justum derelictum, nec semen ejus quaerens panem.",
        "Tota die miseretur et commodat; et semen ejus in benedictione erit."
    ]
    
    let analysis = latinService.analyzePsalm(text: psalm36)
    
    // ===== TEST METRICS =====
    let totalWords = 170  // Actual word count in Psalm 36
    
    let testedLemmas = 45 // Number of lemmas we're testing
    let testedForms = 58  // Number of word forms we're verifying
    
    
    // ===== 2. COMPREHENSIVE VOCABULARY TEST =====
    let confirmedWords = [
        ("delecto", ["delectare", "delectabuntur"], "delight"),
        ("petitio", ["petitiones"], "petition"),
        ("aemulor", ["aemulari"], "envy"),
        ("gladius", ["gladium", "gladius"], "sword"),
        ("mansuetus", ["mansueti"], "meek"),
        ("haeredito", ["haereditabunt"], "inherit"),
        ("fenum", ["fenum"], "grass"),
        ("iniquitas", ["iniquitatem"], "iniquity"),
        ("strideo", ["stridebit"], "gnash"),
        ("benedico", ["benedicentes"], "bless"),
        ("malignor", ["maligneris"], "evil"),
        ("pusillus", ["pusillum"], "little while"),
        ("zelare", ["zelaveris"], "jealous"),
        ("herba", ["herbarum"], "herb"),
        ("meridies", ["meridiem"], "noonday"),
        ("trucido", ["trucident"], "slaughter"),
        ("olus", ["olera"], "vegetable"),
        ("modicum", ["modicum"], "small amount"),
        ("inops", ["inopem"], "needy"),
        ("evagino", ["evaginaverunt"], "unsheathe"),
        ("confringo", ["confringatur"], "break"),
        ("honorifico", ["honorificati"], "honor"),
        ("collido", ["collidetur"], "dash"),
        ("commodo", ["commodat"], "lend"),
        ("injustitia", ["injustitias"], "injustice"),
        ("furor", ["furorem"], "fury"),
        ("prospero", ["prosperatur"], "prosper"),
        ("extermino", ["exterminabuntur"], "destroy"),
        ("pauper", ["pauperem"], "poor"),
        ("rectus", ["rectos"], "upright"),
        ("spero", ["spera", "spera"], "hope"),
        ("revelo", ["revela"], "reveal"),
        ("educo", ["educet"], "lead out"),
        ("subdo", ["subditus"], "submit"),
        ("irrideo", ["irridebit"], "laugh at"),
        ("dirigo", ["dirigentur"], "direct"),
        ("suppono", ["supponit"], "put under"),
        ("misereri ", ["miseretur"], "have mercy")
    ]
    
    if self.verbose {
        print("\n=== Psalm 36 Test Coverage ===")
        print("Total words: \(totalWords)")
        print("Unique lemmas: \(analysis.uniqueLemmas)")
        print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
        print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 3. THEOLOGICAL CONCEPT CHECKS =====
    // Inheritance theme
    if let haereditoInfo = analysis.dictionary["haeredito"] {
        XCTAssertGreaterThanOrEqual(haereditoInfo.count, 3, "'Inherit' should appear multiple times")
    }
    
    // Justice/injustice contrast
    if let justusInfo = analysis.dictionary["justus"] {
        XCTAssertGreaterThan(justusInfo.count, 5, "Righteousness should be major theme")
    }
    
    // ===== 4. GRAMMAR CHECKS =====
    // Verify imperative forms
    if let speroInfo = analysis.dictionary["spero"] {
        XCTAssertEqual(speroInfo.forms["spera"], 2, "Imperative 'spera' appears twice")
    }
    
    // Verify contrasting verb tenses
    if let exterminoInfo = analysis.dictionary["extermino"] {
        XCTAssertEqual(exterminoInfo.forms["exterminabuntur"], 1, "Future passive 'exterminabuntur'")
    }
    
    // ===== 5. KEY PHRASE VERIFICATION =====
    // Check "haereditabunt terram" pattern
    if let terraInfo = analysis.dictionary["terra"] {
        XCTAssertEqual(terraInfo.forms["terram"], 3, "'Terram' should appear 3 times")
    }
    
    // Check sword imagery
    if let gladiusInfo = analysis.dictionary["gladius"] {
        XCTAssertGreaterThanOrEqual(gladiusInfo.count, 2, "Sword imagery appears multiple times")
    }
    
    XCTAssertTrue(
        analysis.dictionary["dominus"] != nil,
        "'dominus' should appear in Psalm 36 (e.g., 'Dominum')"
    )
     // 2. Verify at least 2 occurrences (Psalm 36:9, 36:22)
    if let dominusEntry = analysis.dictionary["dominus"] {
        XCTAssertGreaterThanOrEqual(dominusEntry.count, 2, "Expected at least 2 occurrences of 'dominus'")
        print("Dominus forms found:", dominusEntry.forms) // Debug output
    }
    // ===== 6. DEBUG OUTPUT =====

    if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'justus' forms:", analysis.dictionary["justus"]?.forms ?? [:])
            print("'peccator' forms:", analysis.dictionary["peccator"]?.forms ?? [:])
            print("'dominus' forms:", analysis.dictionary["dominium"]?.forms ?? [:])
            print("'gladius' forms:", analysis.dictionary["gladius"]?.forms ?? [:])
            
        }
}
 
}