import XCTest
@testable import LatinService

class Psalm75Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm75 = [ "Notus in Judaea Deus; in Israel magnum nomen ejus.",
                "Et factus est in pace locus ejus, et habitatio ejus in Sion.",
                "Ibi confregit potentias arcuum, scutum, gladium, et bellum.",
                "Illuminas tu mirabiliter a montibus aeternis.",
                "Turbati sunt omnes insipientes corde; dormierunt somnum suum, et nihil invenerunt omnes viri divitiarum in manibus suis.",
                "Ab increpatione tua, Deus Jacob, dormitaverunt qui ascenderunt equos.",
                "Tu terribilis es, et quis resistet tibi? ex tunc ira tua.",
                "De caelo auditum fecisti judicium; terra tremuit et quievit.",
                "Cum exsurgeret in judicium Deus, ut salvos faceret omnes mansuetos terrae.",
                "Quoniam cogitatio hominis confitebitur tibi, et reliquiae cogitationis diem festum agent tibi."
    ]
// MARK: - Grouped Line Tests for Psalm 75
func testPsalm75Lines1and2() {
    let line1 = psalm75[0] // "Notus in Judaea Deus; in Israel magnum nomen ejus."
    let line2 = psalm75[1] // "Et factus est in pace locus ejus, et habitatio ejus in Sion."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("notus", ["notus"], "known"),
        ("judaea", ["judaea"], "Judah"),
        ("deus", ["deus"], "God"),
        ("israel", ["israel"], "Israel"),
        ("nomen", ["nomen"], "name"),
        ("pax", ["pace"], "peace"),
        ("locus", ["locus"], "place"),
        ("habitatio", ["habitatio"], "dwelling"),
        ("sion", ["sion"], "Zion")
    ]
    
    if verbose {
        print("\nPSALM 75:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Recognition: 'Notus in Judaea Deus' (God is known in Judah)")
        print("2. Sacred Geography: Movement from Judah/Israel to specific dwelling in Zion")
        print("3. Peaceful Establishment: 'factus est in pace locus ejus' (His place was made in peace)")
    }
    
    // Geographic assertions
    XCTAssertEqual(analysis.dictionary["judaea"]?.forms["judaea"], 1, "Should find Judah reference")
    XCTAssertEqual(analysis.dictionary["sion"]?.forms["sion"], 1, "Should find Zion reference")
    
    // Divine presence
    XCTAssertEqual(analysis.dictionary["habitatio"]?.forms["habitatio"], 1, "Should find dwelling reference")
    XCTAssertEqual(analysis.dictionary["locus"]?.forms["locus"], 1, "Should find place reference")
    
    // Peace establishment
    XCTAssertEqual(analysis.dictionary["pax"]?.forms["pace"], 1, "Should find peace reference")
}

func testPsalm75Lines3and4() {
    let line3 = psalm75[2] // "Ibi confregit potentias arcuum, scutum, gladium, et bellum."
    let line4 = psalm75[3] // "Illuminas tu mirabiliter a montibus aeternis."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("confringo", ["confregit"], "shatter"),
        ("potentia", ["potentias"], "power"),
        ("arcus", ["arcuum"], "bow"),
        ("scutum", ["scutum"], "shield"),
        ("gladius", ["gladium"], "sword"),
        ("bellum", ["bellum"], "war"),
        ("illumino", ["illuminas"], "illuminate"),
        ("mirabilis", ["mirabiliter"], "wonderfully"),
        ("mons", ["montibus"], "mountain"),
        ("aeternus", ["aeternis"], "eternal")
    ]
    
    if verbose {
        print("\nPSALM 75:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Warrior: Shattering weapons of war (v3)")
        print("2. Divine Light: Miraculous illumination from eternal mountains (v4)")
        print("3. Contrast: Destruction of human weapons vs. establishment of divine light")
    }
    
    // War imagery
    XCTAssertEqual(analysis.dictionary["confringo"]?.forms["confregit"], 1, "Should find shattering verb")
    XCTAssertEqual(analysis.dictionary["bellum"]?.forms["bellum"], 1, "Should find war reference")
    
    // Light imagery
    XCTAssertEqual(analysis.dictionary["illumino"]?.forms["illuminas"], 1, "Should find illumination verb")
    XCTAssertEqual(analysis.dictionary["mirabilis"]?.forms["mirabiliter"], 1, "Should find wonderfully adverb")
    
    // Test weapon terms
    let weaponTerms = ["arcuum", "scutum", "gladium"].reduce(0) {
        $0 + (analysis.dictionary["arcus"]?.forms[$1] ?? 0)
        + (analysis.dictionary["scutum"]?.forms[$1] ?? 0)
        + (analysis.dictionary["gladius"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(weaponTerms, 3, "Should find all weapon references")
}

func testPsalm75Lines5and6() {
    let line5 = psalm75[4] // "Turbati sunt omnes insipientes corde; dormierunt somnum suum, et nihil invenerunt omnes viri divitiarum in manibus suis."
    let line6 = psalm75[5] // "Ab increpatione tua, Deus Jacob, dormitaverunt qui ascenderunt equos."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("turbo", ["turbati"], "disturb"),
        ("insipiens", ["insipientes"], "foolish"),
        ("cor", ["corde"], "heart"),
        ("dormio", ["dormierunt", "dormitaverunt"], "sleep"),
        ("somnus", ["somnum"], "sleep"),
        ("invenio", ["invenerunt"], "find"),
        ("vir", ["viri"], "man"),
        ("divitiae", ["divitiarum"], "riches"),
        ("manus", ["manibus"], "hand"),
        ("increpatio", ["increpatione"], "rebuke"),
        ("ascendo", ["ascenderunt"], "ascend"),
        ("equus", ["equos"], "horse")
    ]
    
    if verbose {
        print("\nPSALM 75:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Foolishness Exposed: 'insipientes corde' (foolish in heart)")
        print("2. Divine Rebuke: Sleep as metaphor for judgment")
        print("3. Military Futility: Horsemen put to sleep by God's rebuke")
    }
    
    // Foolishness assertions
    XCTAssertEqual(analysis.dictionary["insipiens"]?.forms["insipientes"], 1, "Should find foolish reference")
    XCTAssertEqual(analysis.dictionary["turbo"]?.forms["turbati"], 1, "Should find disturbance verb")
    
    // Sleep imagery
    let sleepVerbs = ["dormierunt", "dormitaverunt"].reduce(0) {
        $0 + (analysis.dictionary["dormio"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(sleepVerbs, 2, "Should find both sleep verbs")
    
    // Military reference
    XCTAssertEqual(analysis.dictionary["equus"]?.forms["equos"], 1, "Should find horses reference")
}

func testPsalm75Lines7and8() {
    let line7 = psalm75[6] // "Tu terribilis es, et quis resistet tibi? ex tunc ira tua."
    let line8 = psalm75[7] // "De caelo auditum fecisti judicium; terra tremuit et quievit."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("terribilis", ["terribilis"], "terrible"),
        ("resisto", ["resistet"], "resist"),
        ("ira", ["ira"], "wrath"),
        ("caelum", ["caelo"], "heaven"),
        ("auditus", ["auditum"], "hearing"),
        ("facio", ["fecisti"], "make"),
        ("judicium", ["judicium"], "judgment"),
        ("terra", ["terra"], "earth"),
        ("tremo", ["tremuit"], "tremble"),
        ("quiesco", ["quievit"], "be still")
    ]
    
    if verbose {
        print("\nPSALM 75:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Terror: Rhetorical question about resisting God")
        print("2. Cosmic Judgment: Heaven to earth judicial movement")
        print("3. Earth's Response: Trembling then stillness as proper response")
    }
    
    // Divine nature
    XCTAssertEqual(analysis.dictionary["terribilis"]?.forms["terribilis"], 1, "Should find terrible description")
    XCTAssertEqual(analysis.dictionary["ira"]?.forms["ira"], 1, "Should find wrath reference")
    
    // Judicial process
    XCTAssertEqual(analysis.dictionary["judicium"]?.forms["judicium"], 1, "Should find judgment reference")
    XCTAssertEqual(analysis.dictionary["caelum"]?.forms["caelo"], 1, "Should find heaven reference")
    
    // Earth's reaction
    XCTAssertEqual(analysis.dictionary["tremo"]?.forms["tremuit"], 1, "Should find trembling verb")
    XCTAssertEqual(analysis.dictionary["quiesco"]?.forms["quievit"], 1, "Should find stillness verb")
}

func testPsalm75Lines9and10() {
    let line9 = psalm75[8] // "Cum exsurgeret in judicium Deus, ut salvos faceret omnes mansuetos terrae."
    let line10 = psalm75[9] // "Quoniam cogitatio hominis confitebitur tibi, et reliquiae cogitationis diem festum agent tibi."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("exsurgo", ["exsurgeret"], "rise up"),
        ("judicium", ["judicium"], "judgment"),
        ("salvus", ["salvos"], "save"),
        ("facio", ["faceret"], "make"),
        ("mansuetus", ["mansuetos"], "meek"),
        ("cogitatio", ["cogitatio", "cogitationis"], "thought"),
        ("homo", ["hominis"], "man"),
        ("confiteor", ["confitebitur"], "confess"),
        ("reliquiae", ["reliquiae"], "remnant"),
        ("dies", ["diem"], "day"),
        ("festus", ["festum"], "festal"),
        ("ago", ["agent"], "keep")
    ]
    
    if verbose {
        print("\nPSALM 75:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Saving Justice: Judgment that saves the meek")
        print("2. Human Response: Confession and festal celebration")
        print("3. Eschatological Hope: Remnant theology in 'reliquiae cogitationis'")
    }
    
    // Salvation assertions
    XCTAssertEqual(analysis.dictionary["salvus"]?.forms["salvos"], 1, "Should find salvation reference")
    XCTAssertEqual(analysis.dictionary["mansuetus"]?.forms["mansuetos"], 1, "Should find meek reference")
    
    // Human response
    XCTAssertEqual(analysis.dictionary["confiteor"]?.forms["confitebitur"], 1, "Should find confession verb")
    XCTAssertEqual(analysis.dictionary["festus"]?.forms["festum"], 1, "Should find festal reference")
    
    // Test verb tenses
    let subjunctiveVerb = analysis.dictionary["exsurgo"]?.forms["exsurgeret"] ?? 0
    let futureVerb = analysis.dictionary["confiteor"]?.forms["confitebitur"] ?? 0
    XCTAssertEqual(subjunctiveVerb + futureVerb, 2, "Should find both subjunctive and future verbs")
}
}