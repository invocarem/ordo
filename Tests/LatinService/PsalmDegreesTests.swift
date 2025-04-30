import XCTest
@testable import LatinService

class PsalmDegreesTests: XCTestCase {
    private var latinService: LatinService!
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
    
    func testAnalyzePsalm119() {
        let psalm119 = [
            "Ad Dominum cum tribularer clamavi, et exaudivit me.",
            "Domine, libera anima mea a labiis iniquis, et a lingua dolosa.",
            "Quid detur tibi, aut quid apponatur tibi ad linguam dolosam?",
            "Sagittae potentis acutae, cum carbonibus desolatoriis.",
            "Heu mihi, quia incolatus meus prolongatus est: habitavi cum habitantibus Cedar.",
            "Multum incola fuit anima mea cum his qui oderunt pacem.",
            "Ego pacem quaerebam: et cum loquerer illis, impugnabant me gratis."
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm119)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [
            ("clamo", ["clamavi"], "cry out"),
            ("dolosus", ["dolosa", "dolosam"], "deceitful"),
            ("sagitta", ["sagittae"], "arrow"),
            ("acutus", ["acutae"], "sharp"),
            ("carbo", ["carbonibus"], "coal"),
            ("desolatorius", ["desolatoriis"], "desolating"),
            ("incolatus", ["incolatus"], "sojourning"),
            ("quaero", ["quaerebam"], "seek")
        ]
        
        print("\n=== ACTUAL Words in Psalm 119 ===")
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
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
        // Perfect indicative "clamavi" (appears once)
        if let clamoEntry = analysis.dictionary["clamo"] {
            let clamaviCount = clamoEntry.forms["clamavi"] ?? 0
            XCTAssertEqual(clamaviCount, 1, 
                         "Expected exactly 1 occurrence of 'clamavi'")
        }
        
        // Perfect indicative "exaudivit" (appears once)
        if let exaudioEntry = analysis.dictionary["exaudio"] {
            let exaudivitCount = exaudioEntry.forms["exaudivit"] ?? 0
            XCTAssertEqual(exaudivitCount, 1, 
                         "Expected exactly 1 occurrence of 'exaudivit'")
        }
        
        // Ablative plural "iniquis" (appears once)
        if let iniquusEntry = analysis.dictionary["iniquus"] {
            let iniquisCount = iniquusEntry.forms["iniquis"] ?? 0
            XCTAssertEqual(iniquisCount, 1, 
                         "Expected exactly 1 occurrence of 'iniquis'")
        }
        
        // Ablative "dolosa" and accusative "dolosam" (one each)
        if let dolosusEntry = analysis.dictionary["dolosus"] {
            let dolosaCount = dolosusEntry.forms["dolosa"] ?? 0
            XCTAssertEqual(dolosaCount, 1, 
                         "Expected exactly 1 occurrence of 'dolosa'")
            let dolosamCount = dolosusEntry.forms["dolosam"] ?? 0
            XCTAssertEqual(dolosamCount, 1, 
                         "Expected exactly 1 occurrence of 'dolosam'")
        }
        
        // Nominative plural "sagittae" (appears once)
        if let sagittaEntry = analysis.dictionary["sagitta"] {
            let sagittaeCount = sagittaEntry.forms["sagittae"] ?? 0
            XCTAssertEqual(sagittaeCount, 1, 
                         "Expected exactly 1 occurrence of 'sagittae'")
        }
        
        // Nominative plural "acutae" (appears once)
        if let acutusEntry = analysis.dictionary["acutus"] {
            let acutaeCount = acutusEntry.forms["acutae"] ?? 0
            XCTAssertEqual(acutaeCount, 1, 
                         "Expected exactly 1 occurrence of 'acutae'")
        }
        
        // Ablative plural "carbonibus" (appears once)
        if let carboEntry = analysis.dictionary["carbo"] {
            let carbonibusCount = carboEntry.forms["carbonibus"] ?? 0
            XCTAssertEqual(carbonibusCount, 1, 
                         "Expected exactly 1 occurrence of 'carbonibus'")
        }
        
        // Ablative plural "desolatoriis" (appears once)
        if let desolatoriusEntry = analysis.dictionary["desolatorius"] {
            let desolatoriisCount = desolatoriusEntry.forms["desolatoriis"] ?? 0
            XCTAssertEqual(desolatoriisCount, 1, 
                         "Expected exactly 1 occurrence of 'desolatoriis'")
        }
        
        // Nominative "incolatus" (appears once)
        if let incolatusEntry = analysis.dictionary["incolatus"] {
            let incolatusCount = incolatusEntry.forms["incolatus"] ?? 0
            XCTAssertEqual(incolatusCount, 1, 
                         "Expected exactly 1 occurrence of 'incolatus'")
        }
        
        // Imperfect indicative "quaerebam" (appears once)
        if let quaeroEntry = analysis.dictionary["quaero"] {
            let quaerebamCount = quaeroEntry.forms["quaerebam"] ?? 0
            XCTAssertEqual(quaerebamCount, 1, 
                         "Expected exactly 1 occurrence of 'quaerebam'")
        }
        
        // ===== 3. Debug output =====
        let verbose = false // Set to false to suppress debug output
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'clamo' forms:", analysis.dictionary["clamo"]?.forms ?? [:])
            print("'exaudio' forms:", analysis.dictionary["exaudio"]?.forms ?? [:])
            print("'iniquus' forms:", analysis.dictionary["iniquus"]?.forms ?? [:])
            print("'dolosus' forms:", analysis.dictionary["dolosus"]?.forms ?? [:])
            print("'sagitta' forms:", analysis.dictionary["sagitta"]?.forms ?? [:])
            print("'acutus' forms:", analysis.dictionary["acutus"]?.forms ?? [:])
            print("'carbo' forms:", analysis.dictionary["carbo"]?.forms ?? [:])
            print("'desolatorius' forms:", analysis.dictionary["desolatorius"]?.forms ?? [:])
            print("'incolatus' forms:", analysis.dictionary["incolatus"]?.forms ?? [:])
            print("'quaero' forms:", analysis.dictionary["quaero"]?.forms ?? [:])
        }
    }

    
    func testAnalyzePsalm120() {
        let psalm120 = [
            "Levavi oculos meos in montes, unde veniet auxilium mihi.",
            "Auxilium meum a Domino, qui fecit caelum et terram.",
            "Non det in commotionem pedem tuum, neque dormitet qui custodit te.",
            "Ecce non dormitabit neque dormiet, qui custodit Israel.",
            "Dominus custodit te; Dominus protectio tua super manum dexteram tuam.",
            "Per diem sol non uret te, neque luna per noctem.",
            "Dominus custodit te ab omni malo; custodiat animam tuam Dominus.",
            "Dominus custodiat introitum tuum et exitum tuum, ex hoc nunc et usque in saeculum"
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm120)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [
            ("levo", ["levavi"], "lift"),
            ("auxilium", ["auxilium"], "help"),
            ("commotio", ["commotionem"], "stumbling"),
            ("dormito", ["dormitet", "dormitabit"], "slumber"),
            ("ureo", ["uret"], "burn"),
            ("introitus", ["introitum"], "entrance"),
            ("exitus", ["exitum"], "exit"),
            ("saeculum", ["saeculum"], "eternity")
        ]
        
        print("\n=== ACTUAL Words in Psalm 120 ===")
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
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
        // Perfect indicative "levavi" (appears once)
        if let levoEntry = analysis.dictionary["levo"] {
            let levaviCount = levoEntry.forms["levavi"] ?? 0
            XCTAssertEqual(levaviCount, 1, 
                         "Expected exactly 1 occurrence of 'levavi'")
        }
        
        // Nominative "auxilium" (appears twice)
        if let auxiliumEntry = analysis.dictionary["auxilium"] {
            let auxiliumCount = auxiliumEntry.forms["auxilium"] ?? 0
            XCTAssertEqual(auxiliumCount, 2, 
                         "Expected exactly 2 occurrences of 'auxilium'")
        }
        
        // Accusative "commotionem" (appears once)
        if let commotioEntry = analysis.dictionary["commotio"] {
            let commotionemCount = commotioEntry.forms["commotionem"] ?? 0
            XCTAssertEqual(commotionemCount, 1, 
                         "Expected exactly 1 occurrence of 'commotionem'")
        }
        
        // Present subjunctive "dormitet" and future indicative "dormitabit" (one each)
        if let dormitoEntry = analysis.dictionary["dormito"] {
            let dormitetCount = dormitoEntry.forms["dormitet"] ?? 0
            XCTAssertEqual(dormitetCount, 1, 
                         "Expected exactly 1 occurrence of 'dormitet'")
            let dormitabitCount = dormitoEntry.forms["dormitabit"] ?? 0
            XCTAssertEqual(dormitabitCount, 1, 
                         "Expected exactly 1 occurrence of 'dormitabit'")
        }
        
        // Present indicative "custodit" (appears four times), present subjunctive "custodiat" (appears twice)
        if let custodioEntry = analysis.dictionary["custodio"] {
            let custoditCount = custodioEntry.forms["custodit"] ?? 0
            XCTAssertEqual(custoditCount, 4, 
                         "Expected exactly 4 occurrences of 'custodit'")
            let custodiatCount = custodioEntry.forms["custodiat"] ?? 0
            XCTAssertEqual(custodiatCount, 2, 
                         "Expected exactly 2 occurrences of 'custodiat'")
        }
        
        // Nominative "protectio" (appears once)
        if let protectioEntry = analysis.dictionary["protectio"] {
            let protectioCount = protectioEntry.forms["protectio"] ?? 0
            XCTAssertEqual(protectioCount, 1, 
                         "Expected exactly 1 occurrence of 'protectio'")
        }
        
        // Future indicative "uret" (appears once)
        if let ureoEntry = analysis.dictionary["ureo"] {
            let uretCount = ureoEntry.forms["uret"] ?? 0
            XCTAssertEqual(uretCount, 1, 
                         "Expected exactly 1 occurrence of 'uret'")
        }
        
        // Accusative "introitum" (appears once)
        if let introitusEntry = analysis.dictionary["introitus"] {
            let introitumCount = introitusEntry.forms["introitum"] ?? 0
            XCTAssertEqual(introitumCount, 1, 
                         "Expected exactly 1 occurrence of 'introitum'")
        }
        
        // Accusative "exitum" (appears once)
        if let exitusEntry = analysis.dictionary["exitus"] {
            let exitumCount = exitusEntry.forms["exitum"] ?? 0
            XCTAssertEqual(exitumCount, 1, 
                         "Expected exactly 1 occurrence of 'exitum'")
        }
        
        // Accusative "saeculum" (appears once)
        if let saeculumEntry = analysis.dictionary["saeculum"] {
            let saeculumCount = saeculumEntry.forms["saeculum"] ?? 0
            XCTAssertEqual(saeculumCount, 1, 
                         "Expected exactly 1 occurrence of 'saeculum'")
        }
        
        // ===== 3. Debug output =====
        let verbose = true // Set to false to suppress debug output
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'levo' forms:", analysis.dictionary["levo"]?.forms ?? [:])
            print("'auxilium' forms:", analysis.dictionary["auxilium"]?.forms ?? [:])
            print("'commotio' forms:", analysis.dictionary["commotio"]?.forms ?? [:])
            print("'dormito' forms:", analysis.dictionary["dormito"]?.forms ?? [:])
            print("'custodio' forms:", analysis.dictionary["custodio"]?.forms ?? [:])
            print("'protectio' forms:", analysis.dictionary["protectio"]?.forms ?? [:])
            print("'ureo' forms:", analysis.dictionary["ureo"]?.forms ?? [:])
            print("'introitus' forms:", analysis.dictionary["introitus"]?.forms ?? [:])
            print("'exitus' forms:", analysis.dictionary["exitus"]?.forms ?? [:])
            print("'saeculum' forms:", analysis.dictionary["saeculum"]?.forms ?? [:])
        }
    }
    
    func testAnalyzePsalm121() {
        let psalm121 = [
            "Laetatus sum in his quae dicta sunt mihi: In domum Domini ibimus.",
            "Stantes erant pedes nostri in atriis tuis, Jerusalem.",
            "Jerusalem, quae aedificatur ut civitas, cujus participatio ejus in idipsum.",
            "Illuc enim ascenderunt tribus, tribus Domini, testimonium Israel, ad confitendum nomini Domini.",
            "Quia illic sederunt sedes in judicio, sedes super domum David.",
            "Rogate quae ad pacem sunt Jerusalem, et abundantia diligentibus te.",
            "Fiat pax in virtute tua, et abundantia in turribus tuis.",
            "Propter fratres meos et proximos meos, loquebar pacem de te.",
            "Propter domum Domini Dei nostri, quaesivi bona tibi."
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm121)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [
            ("laetor", ["laetatus"], "rejoice"),
            ("atrium", ["atriis"], "court"),
            ("aedifico", ["aedificatur"], "build"),
            ("participatio", ["participatio"], "unity"),
            ("ascendo", ["ascenderunt"], "ascend"),
            ("confiteor", ["confitendum"], "praise"),
            ("sedes", ["sedes"], "throne"),
            ("rogo", ["rogate"], "pray"),
            ("abundantia", ["abundantia"], "abundance"),
            ("loquor", ["loquebar"], "speak")
        ]
        
        print("\n=== ACTUAL Words in Psalm 121 ===")
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
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
        // Perfect participle "laetatus" (appears once)
        if let laetorEntry = analysis.dictionary["laetor"] {
            let laetatusCount = laetorEntry.forms["laetatus"] ?? 0
            XCTAssertEqual(laetatusCount, 1, 
                         "Expected exactly 1 occurrence of 'laetatus'")
        }
        
        // Ablative plural "atriis" (appears once)
        if let atriumEntry = analysis.dictionary["atrium"] {
            let atriisCount = atriumEntry.forms["atriis"] ?? 0
            XCTAssertEqual(atriisCount, 1, 
                         "Expected exactly 1 occurrence of 'atriis'")
        }
        
        // Present passive "aedificatur" (appears once)
        if let aedificoEntry = analysis.dictionary["aedifico"] {
            let aedificaturCount = aedificoEntry.forms["aedificatur"] ?? 0
            XCTAssertEqual(aedificaturCount, 1, 
                         "Expected exactly 1 occurrence of 'aedificatur'")
        }
        
        // Nominative "participatio" (appears once)
        if let participatioEntry = analysis.dictionary["participatio"] {
            let participatioCount = participatioEntry.forms["participatio"] ?? 0
            XCTAssertEqual(participatioCount, 1, 
                         "Expected exactly 1 occurrence of 'participatio'")
        }
        
        // Perfect indicative "ascenderunt" (appears once)
        if let ascendoEntry = analysis.dictionary["ascendo"] {
            let ascenderuntCount = ascendoEntry.forms["ascenderunt"] ?? 0
            XCTAssertEqual(ascenderuntCount, 1, 
                         "Expected exactly 1 occurrence of 'ascenderunt'")
        }
        
        // Gerundive "confitendum" (appears once)
        if let confiteorEntry = analysis.dictionary["confiteor"] {
            let confitendumCount = confiteorEntry.forms["confitendum"] ?? 0
            XCTAssertEqual(confitendumCount, 1, 
                         "Expected exactly 1 occurrence of 'confitendum'")
        }
        
        // Nominative plural "sedes" (appears twice)
        if let sedesEntry = analysis.dictionary["sedes"] {
            let sedesCount = sedesEntry.forms["sedes"] ?? 0
            XCTAssertEqual(sedesCount, 2, 
                         "Expected exactly 2 occurrences of 'sedes'")
        }
        
        // Imperative "rogate" (appears once)
        if let rogoEntry = analysis.dictionary["rogo"] {
            let rogateCount = rogoEntry.forms["rogate"] ?? 0
            XCTAssertEqual(rogateCount, 1, 
                         "Expected exactly 1 occurrence of 'rogate'")
        }
        
        // Nominative "abundantia" (appears twice)
        if let abundantiaEntry = analysis.dictionary["abundantia"] {
            let abundantiaCount = abundantiaEntry.forms["abundantia"] ?? 0
            XCTAssertEqual(abundantiaCount, 2, 
                         "Expected exactly 2 occurrences of 'abundantia'")
        }
        
        // Imperfect indicative "loquebar" (appears once)
        if let loquorEntry = analysis.dictionary["loquor"] {
            let loquebarCount = loquorEntry.forms["loquebar"] ?? 0
            XCTAssertEqual(loquebarCount, 1, 
                         "Expected exactly 1 occurrence of 'loquebar'")
        }
        
        // ===== 3. Debug output =====
        let verbose = true // Set to false to suppress debug output
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'laetor' forms:", analysis.dictionary["laetor"]?.forms ?? [:])
            print("'atrium' forms:", analysis.dictionary["atrium"]?.forms ?? [:])
            print("'aedifico' forms:", analysis.dictionary["aedifico"]?.forms ?? [:])
            print("'participatio' forms:", analysis.dictionary["participatio"]?.forms ?? [:])
            print("'ascendo' forms:", analysis.dictionary["ascendo"]?.forms ?? [:])
            print("'confiteor' forms:", analysis.dictionary["confiteor"]?.forms ?? [:])
            print("'sedes' forms:", analysis.dictionary["sedes"]?.forms ?? [:])
            print("'rogo' forms:", analysis.dictionary["rogo"]?.forms ?? [:])
            print("'abundantia' forms:", analysis.dictionary["abundantia"]?.forms ?? [:])
            print("'loquor' forms:", analysis.dictionary["loquor"]?.forms ?? [:])
        }
    }
    
    func testAnalyzePsalm122() {
        let psalm122 = [
            "Ad te levavi oculos meos, qui habitas in caelis.",
            "Ecce sicut oculi servorum in manibus dominorum suorum,",
            "sicut oculi ancillae in manibus dominae suae: ita oculi nostri ad Dominum Deum nostrum, donec misereatur nostri.",
            "Miserere nostri, Domine, miserere nostri, quia multum repleti sumus despectione;",
            "quia multum repleta est anima nostra opprobrium abundantibus et despectio superbis."
        ]
        
        let analysis = latinService.analyzePsalm(text: psalm122)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [            
            ("ancilla", ["ancillae"], "handmaid"),
            ("domina", ["dominae"], "mistress"),
            ("misereri", ["misereatur", "miserere"], "have mercy"),
            ("repleo", ["repleti", "repleta"], "fill"),                        
            ("abundo", ["abundantibus"], "abound")
        ]
        
        print("\n=== ACTUAL Words in Psalm 122 ===")
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
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
        // Perfect indicative "levavi" (appears once)
        if let levoEntry = analysis.dictionary["levo"] {
            let levaviCount = levoEntry.forms["levavi"] ?? 0
            XCTAssertEqual(levaviCount, 1, 
                         "Expected exactly 1 occurrence of 'levavi'")
        }
        
        // Genitive singular "ancillae" (appears once)
        if let ancillaEntry = analysis.dictionary["ancilla"] {
            let ancillaeCount = ancillaEntry.forms["ancillae"] ?? 0
            XCTAssertEqual(ancillaeCount, 1, 
                         "Expected exactly 1 occurrence of 'ancillae'")
        }
        
        // Genitive singular "dominae" (appears once)
        if let dominaEntry = analysis.dictionary["domina"] {
            let dominaeCount = dominaEntry.forms["dominae"] ?? 0
            XCTAssertEqual(dominaeCount, 1, 
                         "Expected exactly 1 occurrence of 'dominae'")
        }
        
        // Present subjunctive "misereatur" (appears once), imperative "miserere" (appears twice)
        if let miserereEntry = analysis.dictionary["miserere"] {
            let misereaturCount = miserereEntry.forms["misereatur"] ?? 0
            XCTAssertEqual(misereaturCount, 1, 
                         "Expected exactly 1 occurrence of 'misereatur'")
            let miserereCount = miserereEntry.forms["miserere"] ?? 0
            XCTAssertEqual(miserereCount, 2, 
                         "Expected exactly 2 occurrences of 'miserere'")
        }
        
        // Perfect participle "repleti" (appears once), "repleta" (appears once)
        if let repleoEntry = analysis.dictionary["repleo"] {
            let repletiCount = repleoEntry.forms["repleti"] ?? 0
            XCTAssertEqual(repletiCount, 1, 
                         "Expected exactly 1 occurrence of 'repleti'")
            let repletaCount = repleoEntry.forms["repleta"] ?? 0
            XCTAssertEqual(repletaCount, 1, 
                         "Expected exactly 1 occurrence of 'repleta'")
        }
        
        // Ablative "despectione" (appears once), nominative "despectio" (appears once)
        if let despectioEntry = analysis.dictionary["despectio"] {
            let despectioneCount = despectioEntry.forms["despectione"] ?? 0
            XCTAssertEqual(despectioneCount, 1, 
                         "Expected exactly 1 occurrence of 'despectione'")
            let despectioCount = despectioEntry.forms["despectio"] ?? 0
            XCTAssertEqual(despectioCount, 1, 
                         "Expected exactly 1 occurrence of 'despectio'")
        }
        
        // Nominative "opprobrium" (appears once)
        if let opprobriumEntry = analysis.dictionary["opprobrium"] {
            let opprobriumCount = opprobriumEntry.forms["opprobrium"] ?? 0
            XCTAssertEqual(opprobriumCount, 1, 
                         "Expected exactly 1 occurrence of 'opprobrium'")
        }
        
        // Present participle, dative plural "abundantibus" (appears once)
        if let abundoEntry = analysis.dictionary["abundo"] {
            let abundantibusCount = abundoEntry.forms["abundantibus"] ?? 0
            XCTAssertEqual(abundantibusCount, 1, 
                         "Expected exactly 1 occurrence of 'abundantibus'")
        }
        
        // ===== 3. Debug output =====
        let verbose = true // Set to false to suppress debug output
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'levo' forms:", analysis.dictionary["levo"]?.forms ?? [:])
            print("'ancilla' forms:", analysis.dictionary["ancilla"]?.forms ?? [:])
            print("'domina' forms:", analysis.dictionary["domina"]?.forms ?? [:])
            print("'miserere' forms:", analysis.dictionary["miserere"]?.forms ?? [:])
            print("'repleo' forms:", analysis.dictionary["repleo"]?.forms ?? [:])
            print("'despectio' forms:", analysis.dictionary["despectio"]?.forms ?? [:])
            print("'opprobrium' forms:", analysis.dictionary["opprobrium"]?.forms ?? [:])
            print("'abundo' forms:", analysis.dictionary["abundo"]?.forms ?? [:])
        }
    }
}