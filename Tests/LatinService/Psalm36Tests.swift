import XCTest
@testable import LatinService 

class Psalm36Tests: XCTestCase {
     private var latinService: LatinService!
     override func setUp() {
        super.setUp()
        latinService = LatinService.shared
        
        
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    func testAnalyzePsalm36() {
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
        
        // ===== 1. Verify ACTUAL words in this psalm =====
         let confirmedWords = [         
            ("delecto", ["delectare", "delectabuntur"], "delight"),
            ("petitio", ["petitiones"], "petition"),
            ("aemulari", ["aemulari"], "envy"),
            ("gladius", ["gladium", "gladius"], "sword"),
            ("mansuetus", ["mansueti"], "meek"),
            ("haeredito", ["haereditabunt"], "inherit"),
            ("fenum", ["fenum"], "grass"),
            ("iniquitas", ["iniquitatem"], "iniquity"),
            ("strideo", ["stridebit"], "gnash"),
            ("benedico", ["benedicentes"], "bless"),
            ("malignor", ["maligneris"], "do evil"),
            ("pusillum", ["pusillum"], "little while"),
            ("zelo", ["zelaveris"], "be jealous"),
            ("herba", ["herbarum"], "herb"),
            ("meridies", ["meridiem"], "noonday"),
            ("trucido", ["trucident"], "slaughter"),
            ("olus", ["olera"], "vegetable"),
            ("modicum", ["modicum"], "small amount"),
            ("inops", ["inopem"], "needy"),
            ("evagino", ["evaginaverunt"], "unsheathe"),
            ("confringo", ["confringatur"], "break"),
            ("honorifico", ["honorificati"], "honor"),
            ("collido", ["collidetur"], "strike/dash"),
            ("commodo", ["commodat"], "lend"),
            ("injustitia", ["injustitias"], "injustice"),
            ("furor", ["furorem"], "fury"),
            ("prospero", ["prosperatur"], "prosper"),
            ("extermino", ["exterminabuntur"], "destroy"),
            ("pauper", ["pauperem"], "poor"),
            ("rectus", ["rectos"], "upright")
        ]
        
        
        print("\n=== ACTUAL Words in Psalm 36 ===")
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            for form in forms {
                let count = entry.forms[form] ?? 0
                print("\(form): \(count > 0 ? "✅" : "❌")")
                XCTAssertGreaterThan(count, 0, 
                                   "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
        
        // ===== 2. Verify grammatical forms =====
        // Future tense "haereditabunt" (appears three times)
        if let haereditoEntry = analysis.dictionary["haeredito"] {
            let haereditabuntCount = haereditoEntry.forms["haereditabunt"] ?? 0
            XCTAssertGreaterThanOrEqual(haereditabuntCount, 3, 
                                      "Expected at least 3 occurrences of 'haereditabunt'")
        }
        
        // Accusative singular "terram" (appears three times)
        if let terraEntry = analysis.dictionary["terra"] {
            let terramCount = terraEntry.forms["terram"] ?? 0
            XCTAssertGreaterThanOrEqual(terramCount, 3, 
                                      "Expected at least 3 occurrences of 'terram'")
        }
        
        // Nominative/accusative plural "peccatores" (appears twice)
        if let peccatorEntry = analysis.dictionary["peccator"] {
            let peccatoresCount = peccatorEntry.forms["peccatores"] ?? 0
            XCTAssertGreaterThanOrEqual(peccatoresCount, 2, 
                                      "Expected at least 2 occurrences of 'peccatores'")
        }

         // Present subjunctive "maligneris" (appears once)
        if let malignorEntry = analysis.dictionary["malignor"] {
            let malignerisCount = malignorEntry.forms["maligneris"] ?? 0
            XCTAssertEqual(malignerisCount, 1, 
                         "Expected exactly 1 occurrence of 'maligneris'")
        }
        
        // Nominative/accusative "pusillum" (appears once)
        if let pusillumEntry = analysis.dictionary["pusillum"] {
            let pusillumCount = pusillumEntry.forms["pusillum"] ?? 0
            XCTAssertEqual(pusillumCount, 1, 
                         "Expected exactly 1 occurrence of 'pusillum'")
        }
        
        // ===== 3. Debug output =====
        let verbose = true // Set to false to suppress debug output
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'delecto' forms:", analysis.dictionary["delecto"]?.forms ?? [:])
            print("'petitio' forms:", analysis.dictionary["petitio"]?.forms ?? [:])
            print("'aemulari' forms:", analysis.dictionary["aemulari"]?.forms ?? [:])
            print("'gladius' forms:", analysis.dictionary["gladius"]?.forms ?? [:])
            print("'mansuetus' forms:", analysis.dictionary["mansuetus"]?.forms ?? [:])
            print("'haeredito' forms:", analysis.dictionary["haeredito"]?.forms ?? [:])
    
    
        }
    }
}