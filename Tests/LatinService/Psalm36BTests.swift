import XCTest
@testable import LatinService

class Psalm36BTests: XCTestCase {
    private var latinService: LatinService!
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    
    func testAnalyzePsalm36B() {
        let psalm36B = [
            "Declina a malo, et fac bonum; et inhabita in saeculum saeculi.",
            "Quia Dominus amat judicium, et non derelinquet sanctos suos; in aeternum conservabuntur.",
            "Injusti punientur, et semen impiorum peribit.",
            "Justi autem haereditabunt terram, et inhabitabunt in saeculum saeculi super eam.",
            "Os justi meditabitur sapientiam, et lingua ejus loquetur judicium.",
            "Lex Dei ejus in corde ipsius; et non supplantabuntur gressus ejus.",
            "Considerat peccator justum, et quaerit mortificare eum.",
            "Dominus autem non derelinquet eum in manibus ejus, nec damnabit eum cum judicabitur illi.",
            "Exspecta Dominum, et custodi viam ejus; et exaltabit te ut haereditate capias terram: cum perierint peccatores, videbis.",
            "Vidi impium superexaltatum, et elevatum sicut cedros Libani.",
            "Et transivi, et ecce non erat; et quaesivi eum, et non est inventus locus ejus.",
            "Custodi innocentiam, et vide aequitatem, quoniam sunt reliquiae homini pacifico.",
            "Injusti autem disperibunt simul; reliquiae impiorum interibunt.",
            "Salus autem justorum a Domino; et protector eorum est in tempore tribulationis.",
            "Et adjuvabit eos Dominus, et liberabit eos; et eripiet eos a peccatoribus, et salvabit eos, quia speraverunt in eo."
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm36B)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [
            ("haeredito", ["haereditabunt", "haereditate"], "inherit"),
            ("supplanto", ["supplantabuntur"], "trip up"),
            ("mortifico", ["mortificare"], "put to death"),
            ("aequitas", ["aequitatem"], "equity"),
            ("reliquiae", ["reliquiae"], "remnants"),
            ("cedrus", ["cedros"], "cedar"),
            ("meditor", ["meditabitur"], "meditate"),
            ("loquor", ["loquetur"], "speak"),
            ("sapientia", ["sapientiam"], "wisdom"),
            ("judicium", ["judicium"], "judgment"),
            ("exspecto", ["exspecta"], "wait"),
            ("custodio", ["custodi"], "guard"),
            ("superexalto", ["superexaltatum"], "exalt exceedingly"),
            ("elevo", ["elevatum"], "lift up"),
            ("pacificus", ["pacifico"], "peaceful"),
            ("tribulatio", ["tribulationis"], "tribulation"),
            ("eripio", ["eripiet"], "rescue"),
            ("salus", ["salus"], "salvation"),
            ("damno", ["damnabit"], "condemn"),
            ("judico", ["judicabitur"], "judge") ,
            ("injustus", ["injusti"], "unjust")
        ]
        
        print("\n=== ACTUAL Words in Psalm 36 (B) ===")
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }

            
            XCTAssertTrue(entry.translation?.contains(translation) ?? false,
                         "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'")
            for form in forms {
                let count = entry.forms[form] ?? 0
                print("\(form): \(count > 0 ? "✅" : "❌")")
                XCTAssertGreaterThan(count, 0, 
                                   "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
        
        // ===== 2. Verify grammatical forms =====
        // Future indicative "haereditabunt" (appears once) and ablative "haereditate" (appears once)
        if let haereditoEntry = analysis.dictionary["haeredito"] {
            let haereditabuntCount = haereditoEntry.forms["haereditabunt"] ?? 0
            XCTAssertEqual(haereditabuntCount, 1, 
                         "Expected exactly 1 occurrence of 'haereditabunt'")
            let haereditateCount = haereditoEntry.forms["haereditate"] ?? 0
            XCTAssertEqual(haereditateCount, 1, 
                         "Expected exactly 1 occurrence of 'haereditate'")
        }
        
        // Future passive "supplantabuntur" (appears once)
        if let supplantoEntry = analysis.dictionary["supplanto"] {
            let supplantabunturCount = supplantoEntry.forms["supplantabuntur"] ?? 0
            XCTAssertEqual(supplantabunturCount, 1, 
                         "Expected exactly 1 occurrence of 'supplantabuntur'")
        }
        
        // Infinitive "mortificare" (appears once)
        if let mortificoEntry = analysis.dictionary["mortifico"] {
            let mortificareCount = mortificoEntry.forms["mortificare"] ?? 0
            XCTAssertEqual(mortificareCount, 1, 
                         "Expected exactly 1 occurrence of 'mortificare'")
        }
        
        // Accusative "aequitatem" (appears once)
        if let aequitasEntry = analysis.dictionary["aequitas"] {
            let aequitatemCount = aequitasEntry.forms["aequitatem"] ?? 0
            XCTAssertEqual(aequitatemCount, 1, 
                         "Expected exactly 1 occurrence of 'aequitatem'")
        }
        
        // Nominative plural "reliquiae" (appears twice)
        if let reliquiaeEntry = analysis.dictionary["reliquiae"] {
            let reliquiaeCount = reliquiaeEntry.forms["reliquiae"] ?? 0
            XCTAssertEqual(reliquiaeCount, 2, 
                         "Expected exactly 2 occurrences of 'reliquiae'")
        }
        
        // Accusative plural "cedros" (appears once)
        if let cedrusEntry = analysis.dictionary["cedrus"] {
            let cedrosCount = cedrusEntry.forms["cedros"] ?? 0
            XCTAssertEqual(cedrosCount, 1, 
                         "Expected exactly 1 occurrence of 'cedros'")
        }
        
        // Future indicative "meditabitur" (appears once)
        if let meditorEntry = analysis.dictionary["meditor"] {
            let meditabiturCount = meditorEntry.forms["meditabitur"] ?? 0
            XCTAssertEqual(meditabiturCount, 1, 
                         "Expected exactly 1 occurrence of 'meditabitur'")
        }
        
        // Future indicative "loquetur" (appears once)
        if let loquorEntry = analysis.dictionary["loquor"] {
            let loqueturCount = loquorEntry.forms["loquetur"] ?? 0
            XCTAssertEqual(loqueturCount, 1, 
                         "Expected exactly 1 occurrence of 'loquetur'")
        }
        
        // Accusative "sapientiam" (appears once)
        if let sapientiaEntry = analysis.dictionary["sapientia"] {
            let sapientiamCount = sapientiaEntry.forms["sapientiam"] ?? 0
            XCTAssertEqual(sapientiamCount, 1, 
                         "Expected exactly 1 occurrence of 'sapientiam'")
        }
        
        // Nominative/accusative "judicium" (appears 2 times)
        if let judiciumEntry = analysis.dictionary["judicium"] {
            let judiciumCount = judiciumEntry.forms["judicium"] ?? 0
            XCTAssertEqual(judiciumCount, 2, 
                         "Expected exactly 2 occurrences of 'judicium'")
        }
        
        // Imperative "exspecta" (appears once)
        if let exspectoEntry = analysis.dictionary["exspecto"] {
            let exspectaCount = exspectoEntry.forms["exspecta"] ?? 0
            XCTAssertEqual(exspectaCount, 1, 
                         "Expected exactly 1 occurrence of 'exspecta'")
        }
        
        // Imperative "custodi" (appears twice)
        if let custodioEntry = analysis.dictionary["custodio"] {
            let custodiCount = custodioEntry.forms["custodi"] ?? 0
            XCTAssertEqual(custodiCount, 2, 
                         "Expected exactly 2 occurrences of 'custodi'")
        }
        
        // Perfect participle "superexaltatum" (appears once)
        if let superexaltoEntry = analysis.dictionary["superexalto"] {
            let superexaltatumCount = superexaltoEntry.forms["superexaltatum"] ?? 0
            XCTAssertEqual(superexaltatumCount, 1, 
                         "Expected exactly 1 occurrence of 'superexaltatum'")
        }
        
        // Perfect participle "elevatum" (appears once)
        if let elevoEntry = analysis.dictionary["elevo"] {
            let elevatumCount = elevoEntry.forms["elevatum"] ?? 0
            XCTAssertEqual(elevatumCount, 1, 
                         "Expected exactly 1 occurrence of 'elevatum'")
        }
        
        // Dative "pacifico" (appears once)
        if let pacificusEntry = analysis.dictionary["pacificus"] {
            let pacificoCount = pacificusEntry.forms["pacifico"] ?? 0
            XCTAssertEqual(pacificoCount, 1, 
                         "Expected exactly 1 occurrence of 'pacifico'")
        }
        
        // Genitive "tribulationis" (appears once)
        if let tribulatioEntry = analysis.dictionary["tribulatio"] {
            let tribulationisCount = tribulatioEntry.forms["tribulationis"] ?? 0
            XCTAssertEqual(tribulationisCount, 1, 
                         "Expected exactly 1 occurrence of 'tribulationis'")
        }
        
        // Future indicative "eripiet" (appears once)
        if let eripioEntry = analysis.dictionary["eripio"] {
            let eripietCount = eripioEntry.forms["eripiet"] ?? 0
            XCTAssertEqual(eripietCount, 1, 
                         "Expected exactly 1 occurrence of 'eripiet'")
        }
        
        // Nominative "salus" (appears once)
        if let salusEntry = analysis.dictionary["salus"] {
            let salusCount = salusEntry.forms["salus"] ?? 0
            XCTAssertEqual(salusCount, 1, 
                         "Expected exactly 1 occurrence of 'salus'")
        }
        
        // Future indicative "damnabit" (appears once)
        if let damnoEntry = analysis.dictionary["damno"] {
            let damnabitCount = damnoEntry.forms["damnabit"] ?? 0
            XCTAssertEqual(damnabitCount, 1, 
                         "Expected exactly 1 occurrence of 'damnabit'")
        }
        
        // Nominative plural "injusti" (appears twice)
        if let injustusEntry = analysis.dictionary["injustus"] {
            let injustiCount = injustusEntry.forms["injusti"] ?? 0
            XCTAssertEqual(injustiCount, 2, 
                         "Expected exactly 2 occurrences of 'injusti'")
        }
        
        // ===== 3. Debug output =====
        let verbose = true // Set to false to suppress debug output
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'haeredito' forms:", analysis.dictionary["haeredito"]?.forms ?? [:])
            print("'supplanto' forms:", analysis.dictionary["supplanto"]?.forms ?? [:])
            print("'mortifico' forms:", analysis.dictionary["mortifico"]?.forms ?? [:])
            print("'aequitas' forms:", analysis.dictionary["aequitas"]?.forms ?? [:])
            print("'reliquiae' forms:", analysis.dictionary["reliquiae"]?.forms ?? [:])
            print("'cedrus' forms:", analysis.dictionary["cedrus"]?.forms ?? [:])
            print("'meditor' forms:", analysis.dictionary["meditor"]?.forms ?? [:])
            print("'loquor' forms:", analysis.dictionary["loquor"]?.forms ?? [:])
            print("'sapientia' forms:", analysis.dictionary["sapientia"]?.forms ?? [:])
            print("'judicium' forms:", analysis.dictionary["judicium"]?.forms ?? [:])
            print("'exspecto' forms:", analysis.dictionary["exspecto"]?.forms ?? [:])
            print("'custodio' forms:", analysis.dictionary["custodio"]?.forms ?? [:])
            print("'superexalto' forms:", analysis.dictionary["superexalto"]?.forms ?? [:])
            print("'elevo' forms:", analysis.dictionary["elevo"]?.forms ?? [:])
            print("'pacificus' forms:", analysis.dictionary["pacificus"]?.forms ?? [:])
            print("'tribulatio' forms:", analysis.dictionary["tribulatio"]?.forms ?? [:])
            print("'eripio' forms:", analysis.dictionary["eripio"]?.forms ?? [:])
            print("'salus' forms:", analysis.dictionary["salus"]?.forms ?? [:])
            print("'damno' forms:", analysis.dictionary["damno"]?.forms ?? [:])
            print("'injustus' forms:", analysis.dictionary["injustus"]?.forms ?? [:])
        }
    }
}