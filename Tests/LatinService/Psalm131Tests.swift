import XCTest
@testable import LatinService

class Psalm131Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm131 = [
                "Memento, Domine, David, et omnis mansuetudinis ejus.",
                "Sicut juravit Domino, votum vovit Deo Jacob:",
                "Si introiero in tabernaculum domus meae, si ascendero in lectum strati mei:",
                "Si dedero somnum oculis meis, et palpebris meis dormitationem:",
                "Et requiem temporibus meis: donec inveniam locum Domino, tabernaculum Deo Jacob.",
               
                "Ecce audivimus eam in Ephrata: invenimus eam in campis silvae.",
                "Introibimus in tabernaculum ejus: adorabimus in loco ubi steterunt pedes ejus.",
                "Surge, Domine, in requiem tuam, tu et arca sanctificationis tuae.",
                "Sacerdotes tui induantur justitiam: et sancti tui exsultent.",
                "Propter David servum tuum, non avertas faciem Christi tui.",
               
                "Juravit Dominus David veritatem, et non frustrabitur eam: De fructu ventris tui ponam super sedem tuam.",
                "Si custodierint filii tui testamentum meum, et testimonia mea haec, quae docebo eos:",
                "Et filii eorum usque in saeculum, sedebunt super sedem tuam.",
                "Quoniam elegit Dominus Sion: elegit eam in habitationem sibi.",
                "Haec requies mea in saeculum saeculi: hic habitabo, quoniam elegi eam.",
               
                "Viduam ejus benedicens benedicam: pauperes ejus saturabo panibus.",
                "Sacerdotes ejus induam salutari: et sancti ejus exsultatione exsultabunt.",
                "Illuc producam cornu David: paravi lucernam Christo meo.",
                "Inimicos ejus induam confusione: super ipsum autem efflorebit sanctificatio mea."

    ]

// MARK: - Grouped Line Tests for Psalm 131
func testPsalm131Lines1and2() {
    let line1 = psalm131[0] // "Memento, Domine, David, et omnis mansuetudinis ejus."
    let line2 = psalm131[1] // "Sicut juravit Domino, votum vovit Deo Jacob:"
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("memini", ["memento"], "remember"),
        ("dominus", ["domine"], "Lord"),
        ("david", ["david"], "david"),
        ("mansuetudo", ["mansuetudinis"], "meekness"),
        ("juro", ["juravit"], "swear"),
        ("votum", ["votum"], "vow"),
        ("voveo", ["vovit"], "vow"),
        ("jacob", ["jacob"], "Jacob")
    ]
    
    if verbose {
        print("\nPSALM 131:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Davidic Covenant: Opening plea to remember David")
        print("2. Sacred Oaths: Double reference to sworn vows")
        print("3. Patriarchal Connection: Linking to Jacob/Israel")
    }
    
    // Covenant assertions
    XCTAssertEqual(analysis.dictionary["david"]?.forms["david"], 1, "Should find David reference")
    XCTAssertEqual(analysis.dictionary["juro"]?.forms["juravit"], 1, "Should find oath verb")
    
    // Test vow terminology
    let vowTerms = ["votum", "vovit"].reduce(0) {
        $0 + (analysis.dictionary["votum"]?.forms[$1] ?? 0)
        + (analysis.dictionary["voveo"]?.forms[$1] ?? 0)
    }
    XCTAssertTrue(vowTerms >= 2, "Should find both vow terms")
}

func testPsalm131Lines3and4() {
    let line3 = psalm131[2] // "Si introiero in tabernaculum domus meae, si ascendero in lectum strati mei:"
    let line4 = psalm131[3] // "Si dedero somnum oculis meis, et palpebris meis dormitationem:"
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("introeo", ["introiero"], "enter"),
        ("tabernaculum", ["tabernaculum"], "tent"),
        ("domus", ["domus"], "house"),
        ("ascendo", ["ascendero"], "ascend"),
        ("lectus", ["lectum"], "bed"),
        ("stratum", ["strati"], "bedding"),
        ("somnus", ["somnum"], "sleep"),
        ("oculus", ["oculis"], "eye"),
        ("palpebra", ["palpebris"], "eyelid"),
        ("dormitatio", ["dormitationem"], "slumber")
    ]
    
    if verbose {
        print("\nPSALM 131:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Conditional Statements: Series of 'si' (if) clauses")
        print("2. Personal Sacrifice: Refusal of normal comforts")
        print("3. Bodily Denial: Sleep deprivation as devotion")
    }
    
    // Conditional clauses
    XCTAssertEqual(analysis.dictionary["introeo"]?.forms["introiero"], 1, "Should find conditional enter verb")
    XCTAssertEqual(analysis.dictionary["ascendo"]?.forms["ascendero"], 1, "Should find conditional ascend verb")
    
    // Sleep denial
    XCTAssertEqual(analysis.dictionary["somnus"]?.forms["somnum"], 1, "Should find sleep reference")
    XCTAssertEqual(analysis.dictionary["dormitatio"]?.forms["dormitationem"], 1, "Should find slumber reference")
}

func testPsalm131Lines5and6() {
    let line5 = psalm131[4] // "Et requiem temporibus meis: donec inveniam locum Domino, tabernaculum Deo Jacob."
    let line6 = psalm131[5] // "Ecce audivimus eam in Ephrata: invenimus eam in campis silvae."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("requies", ["requiem"], "rest"),
        ("tempus", ["temporibus"], "time"),
        ("invenio", ["inveniam", "invenimus"], "find"),
        ("locus", ["locum"], "place"),
        ("tabernaculum", ["tabernaculum"], "dwelling"),
        ("jacob", ["jacob"], "Jacob"),
        ("ephrata", ["ephrata"], "Ephrathah"),
        ("campus", ["campis"], "field"),
        ("silva", ["silvae"], "forest")
    ]
    
    if verbose {
        print("\nPSALM 131:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Dwelling: Seeking a place for God's presence")
        print("2. Geographic Journey: From Ephrathah to forest fields")
        print("3. Temporal Commitment: 'donec' (until) showing perseverance")
    }
    
    // Divine dwelling
    XCTAssertEqual(analysis.dictionary["tabernaculum"]?.forms["tabernaculum"], 1, "Should find dwelling reference")
    XCTAssertEqual(analysis.dictionary["locus"]?.forms["locum"], 1, "Should find place reference")
    
    // Geographic terms
    XCTAssertEqual(analysis.dictionary["ephrata"]?.forms["ephrata"], 1, "Should find Ephrathah reference")
    XCTAssertEqual(analysis.dictionary["silva"]?.forms["silvae"], 1, "Should find forest reference")
}

func testPsalm131Lines7and8() {
    let line7 = psalm131[6] // "Introibimus in tabernaculum ejus: adorabimus in loco ubi steterunt pedes ejus."
    let line8 = psalm131[7] // "Surge, Domine, in requiem tuam, tu et arca sanctificationis tuae."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("introeo", ["introibimus"], "enter"),
        ("tabernaculum", ["tabernaculum"], "tabernacle"),
        ("adoro", ["adorabimus"], "worship"),
        ("locus", ["loco"], "place"),
        ("sto", ["steterunt"], "stand"),
        ("pes", ["pedes"], "foot"),
        ("surgo", ["surge"], "arise"),
        ("requies", ["requiem"], "rest"),
        ("arca", ["arca"], "ark"),
        ("sanctificatio", ["sanctificationis"], "sanctification")
    ]
    
    if verbose {
        print("\nPSALM 131:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Temple Access: Communal worship declaration ('we will enter...we will worship')")
        print("2. Footstool Theology: Sacred space where God's feet stood")
        print("3. Ark Petition: Call for God to arise with His sanctified ark")
    }
    
    // Worship verbs
    XCTAssertEqual(analysis.dictionary["introeo"]?.forms["introibimus"], 1, "Should find future 'we will enter'")
    XCTAssertEqual(analysis.dictionary["adoro"]?.forms["adorabimus"], 1, "Should find future 'we will worship'")
    
    // Sacred space
    XCTAssertEqual(analysis.dictionary["pes"]?.forms["pedes"], 1, "Should find feet reference")
    XCTAssertEqual(analysis.dictionary["locus"]?.forms["loco"], 1, "Should find place reference")
    
    // Ark terminology
    XCTAssertEqual(analysis.dictionary["arca"]?.forms["arca"], 1, "Should find ark reference")
    XCTAssertEqual(analysis.dictionary["sanctificatio"]?.forms["sanctificationis"], 1, "Should find sanctification term")
    
    // Test imperative
    XCTAssertEqual(analysis.dictionary["surgo"]?.forms["surge"], 1, "Should find imperative 'arise'")
    
    // Test plural verbs
    let pluralVerbs = ["introibimus", "adorabimus", "steterunt"].reduce(0) {
        $0 + (analysis.dictionary["introeo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["adoro"]?.forms[$1] ?? 0)
        + (analysis.dictionary["sto"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(pluralVerbs, 3, "Should find all plural verb forms")
}
func testPsalm131Lines9and10() {
    let line9 = psalm131[8] // "Sacerdotes tui induantur justitiam: et sancti tui exsultent."
    let line10 = psalm131[9] // "Propter David servum tuum, non avertas faciem Christi tui."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("sacerdos", ["sacerdotes"], "priest"),
        ("induo", ["induantur"], "clothe"),
        ("justitia", ["justitiam"], "righteousness"),
        ("sanctus", ["sancti"], "holy"),
        ("exsulto", ["exsultent"], "rejoice"),
        ("propter", ["propter"], "for the sake of"),
        ("servus", ["servum"], "servant"),
        ("averto", ["avertas"], "turn away"),
        ("facies", ["faciem"], "face"),
        ("christus", ["christi"], "anoint")
    ]
    
    if verbose {
        print("\nPSALM 131:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Priestly Garments: Clothed in righteousness (induantur justitiam)")
        print("2. Davidic Intercession: Appeal based on David's service")
        print("3. Messianic Face: 'Christi tui' with facial imagery showing relational presence")
    }
    
    // Priestly assertions
    XCTAssertEqual(analysis.dictionary["sacerdos"]?.forms["sacerdotes"], 1, "Should find priests reference")
    XCTAssertEqual(analysis.dictionary["justitia"]?.forms["justitiam"], 1, "Should find righteousness reference")
    
    // Davidic/Messianic terms
    XCTAssertEqual(analysis.dictionary["christus"]?.forms["christi"], 1, "Should find Christ reference")
    XCTAssertEqual(analysis.dictionary["servus"]?.forms["servum"], 1, "Should find servant reference")
    
    // Test subjunctive verbs
    let subjunctiveVerbs = ["induantur", "exsultent", "avertas"].reduce(0) {
        $0 + (analysis.dictionary["induo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["exsulto"]?.forms[$1] ?? 0)
        + (analysis.dictionary["averta"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(subjunctiveVerbs, 3, "Should find all subjunctive verbs")
}

func testPsalm131Lines11and12() {
    let line11 = psalm131[10] // "Juravit Dominus David veritatem, et non frustrabitur eam: De fructu ventris tui ponam super sedem tuam."
    let line12 = psalm131[11] // "Si custodierint filii tui testamentum meum, et testimonia mea haec, quae docebo eos:"
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("juro", ["juravit"], "swear"),
        ("veritas", ["veritatem"], "truth"),
        ("frustror", ["frustrabitur"], "make void"),
        ("fructus", ["fructu"], "fruit"),
        ("venter", ["ventris"], "womb"),
        ("pono", ["ponam"], "place"),
        ("sedes", ["sedem"], "throne"),
        ("custodio", ["custodierint"], "keep"),
        ("testamentum", ["testamentum"], "covenant"),
        ("testimonium", ["testimonia"], "testimonies"),
        ("doceo", ["docebo"], "teach")
    ]
    
    if verbose {
        print("\nPSALM 131:11-12 ANALYSIS:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Unbreakable Oath: Divine sworn promise (juravit veritatem)")
        print("2. Dynastic Promise: 'fructu ventris' as lineage continuation")
        print("3. Conditional Covenant: 'Si custodierint' showing bilateral dimension")
    }
    
    // Covenant assertions
    XCTAssertEqual(analysis.dictionary["juro"]?.forms["juravit"], 1, "Should find oath verb")
    XCTAssertEqual(analysis.dictionary["testamentum"]?.forms["testamentum"], 1, "Should find covenant reference")
    
    // Lineage terms
    XCTAssertEqual(analysis.dictionary["fructus"]?.forms["fructu"], 1, "Should find fruit reference")
    XCTAssertEqual(analysis.dictionary["venter"]?.forms["ventris"], 1, "Should find womb reference")
    
    // Test future verbs
    let futureVerbs = ["ponam", "docebo"].reduce(0) {
        $0 + (analysis.dictionary["pono"]?.forms[$1] ?? 0)
        + (analysis.dictionary["doceo"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(futureVerbs, 2, "Should find both future tense verbs")
}

func testPsalm131Lines13and14() {
    let line13 = psalm131[12] // "Et filii eorum usque in saeculum, sedebunt super sedem tuam."
    let line14 = psalm131[13] // "Quoniam elegit Dominus Sion: elegit eam in habitationem sibi."
    let combinedText = line13 + " " + line14
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("filius", ["filii"], "son"),
        ("saeculum", ["saeculum"], "age"),
        ("sedeo", ["sedebunt"], "sit"),
        ("sedes", ["sedem"], "throne"),
        ("eligo", ["elegit"], "choose"),
        ("Sion", ["sion"], "Zion"),
        ("habitatio", ["habitationem"], "dwelling")
    ]
    
    if verbose {
        print("\nPSALM 131:13-14 ANALYSIS:")
        print("13: \"\(line13)\"")
        print("14: \"\(line14)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Eternal Dynasty: Perpetual throne occupation (usque in saeculum)")
        print("2. Zion Theology: Double election of Jerusalem")
        print("3. Divine Sovereignty: Active choosing (elegit...elegit)")
    }
    
    // Dynastic terms
    XCTAssertEqual(analysis.dictionary["filius"]?.forms["filii"], 1, "Should find sons reference")
    XCTAssertEqual(analysis.dictionary["sedes"]?.forms["sedem"], 1, "Should find throne reference")
    
    // Zion election
    XCTAssertEqual(analysis.dictionary["eligo"]?.forms["elegit"], 2, "Should find double 'chose'")
    XCTAssertEqual(analysis.dictionary["sion"]?.forms["sion"], 1, "Should find Zion reference")
    
    // Test temporal marker
    XCTAssertEqual(analysis.dictionary["saeculum"]?.forms["saeculum"], 1, "Should find 'forever' term")
}

func testPsalm131Lines15and16() {
    let line15 = psalm131[14] // "Haec requies mea in saeculum saeculi: hic habitabo, quoniam elegi eam."
    let line16 = psalm131[15] // "Viduam ejus benedicens benedicam: pauperes ejus saturabo panibus."
    let combinedText = line15 + " " + line16
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("requies", ["requies"], "rest"),
        ("saeculum", ["saeculum", "saeculi"], "age"),
        ("habito", ["habitabo"], "dwell"),
        ("eligo", ["elegi"], "choose"),
        ("vidua", ["viduam"], "widow"),
        ("benedico", ["benedicens", "benedicam"], "bless"),
        ("pauper", ["pauperes"], "poor"),
        ("saturo", ["saturabo"], "satisfy"),
        ("panis", ["panibus"], "bread")
    ]
    
    if verbose {
        print("\nPSALM 131:15-16 ANALYSIS:")
        print("15: \"\(line15)\"")
        print("16: \"\(line16)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Eternal Dwelling: 'in saeculum saeculi' (forever and ever)")
        print("2. Social Justice: Care for widows and poor")
        print("3. Concrete Provision: Bread satisfaction imagery")
    }
    
    // Eternal dwelling
    XCTAssertEqual(analysis.dictionary["requies"]?.forms["requies"], 1, "Should find rest reference")
    XCTAssertEqual(analysis.dictionary["habito"]?.forms["habitabo"], 1, "Should find dwell verb")
    
    // Social concern
    XCTAssertEqual(analysis.dictionary["vidua"]?.forms["viduam"], 1, "Should find widow reference")
    XCTAssertEqual(analysis.dictionary["pauper"]?.forms["pauperes"], 1, "Should find poor reference")
    
    // Test double blessing
    let blessingForms = ["benedicens", "benedicam"].reduce(0) {
        $0 + (analysis.dictionary["benedico"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(blessingForms, 2, "Should find both blessing forms")
}

func testPsalm131Lines17to19() {
    let line17 = psalm131[16] // "Viduam ejus benedicens benedicam: pauperes ejus saturabo panibus."
    let line18 = psalm131[17] // "Sacerdotes ejus induam salutari: et sancti ejus exsultatione exsultabunt."
    let line19 = psalm131[18] // "Illuc producam cornu David: paravi lucernam Christo meo."
    let combinedText = line17 + " " + line18 + " " + line19
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("vidua", ["viduam"], "widow"),
        ("benedico", ["benedicens", "benedicam"], "bless"),
        ("pauper", ["pauperes"], "poor"),
        ("saturo", ["saturabo"], "satisfy"),
        ("panis", ["panibus"], "bread"),
        ("sacerdos", ["sacerdotes"], "priest"),
        ("induo", ["induam"], "clothe"),
        ("salutare", ["salutari"], "salvation"),
        ("sanctus", ["sancti"], "holy"),
        ("exsultatio", ["exsultatione"], "joy"),
        ("produco", ["producam"], "bring forth"),
        ("cornu", ["cornu"], "horn"),
        ("David", ["david"], "David"),
        ("paro", ["paravi"], "prepare"),
        ("lucerna", ["lucernam"], "lamp"),
        ("Christus", ["christo"], "Christ")
    ]
    
    if verbose {
        print("\nPSALM 131:17-19 ANALYSIS:")
        print("17: \"\(line17)\"")
        print("18: \"\(line18)\"")
        print("19: \"\(line19)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Social Justice: Care for widows and poor")
        print("2. Priestly Blessing: Clothed in salvation garments")
        print("3. Messianic Promise: David's horn and Christ's lamp")
    }
    
    // Social concern
    XCTAssertEqual(analysis.dictionary["vidua"]?.forms["viduam"], 1, "Should find widow reference")
    XCTAssertEqual(analysis.dictionary["pauper"]?.forms["pauperes"], 1, "Should find poor reference")
    
    // Priestly imagery
    XCTAssertEqual(analysis.dictionary["sacerdos"]?.forms["sacerdotes"], 1, "Should find priests reference")
    XCTAssertEqual(analysis.dictionary["salutare"]?.forms["salutari"], 1, "Should find salvation reference")
    
    // Messianic terms
    XCTAssertEqual(analysis.dictionary["christus"]?.forms["christo"], 1, "Should find Christ reference")
    XCTAssertEqual(analysis.dictionary["lucerna"]?.forms["lucernam"], 1, "Should find lamp reference")
}
}