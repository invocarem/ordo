import XCTest
@testable import LatinService

class PsalmDegreesTests: XCTestCase {
    let verbose : Bool = true
    private var latinService: LatinService!
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    let identity = PsalmIdentity(number: 119, category: nil)
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
        
        let analysis = latinService.analyzePsalm(identity, text: psalm119)
        
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
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
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
        
        let identity = PsalmIdentity(number: 120, category: nil)
        let analysis = latinService.analyzePsalm(identity, text: psalm120)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [
            ("levo", ["levavi"], "lift"),
            ("auxilium", ["auxilium"], "help"),
            ("commotio", ["commotionem"], "stumbling"),
            ("dormito", ["dormitet", "dormitabit"], "slumber"),
            ("ureo", ["uret"], "burn"),
            ("introitus", ["introitum"], "entrance"),
            ("dexter", ["dexteram"], "right"),
            ("exitus", ["exitum"], "exit"),
            ("saeculum", ["saeculum"], "eternity")
        ]
        
        print("\n=== ACTUAL Words in Psalm 120 ===")
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
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
        let identity = PsalmIdentity(number: 121, category: nil)
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
        
        let analysis = latinService.analyzePsalm(identity, text: psalm121)
        
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
        if(verbose) {
            print("=== ACTUAL Words in Psalm 121 ===")
        }
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
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
        
        let id = PsalmIdentity(number: 127, category: nil)
        let analysis = latinService.analyzePsalm(id, text: psalm122)
        
        // ===== 1. Verify ACTUAL words in this psalm =====
        let confirmedWords = [            
            ("ancilla", ["ancillae"], "handmaid"),
            ("dominus", ["dominae"], "mistress"),
            ("misereri", ["misereatur", "miserere"], "have mercy"),
            ("repleo", ["repleti", "repleta"], "fill"),                        
            ("abundo", ["abundantibus"], "abound")
        ]
        
        print("\n=== ACTUAL Words in Psalm 122 ===")
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
        
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
        if let miserereEntry = analysis.dictionary["misereri"] {
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
       
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'levo' forms:", analysis.dictionary["levo"]?.forms ?? [:])
            print("'ancilla' forms:", analysis.dictionary["ancilla"]?.forms ?? [:])
            print("'domina' forms:", analysis.dictionary["domina"]?.forms ?? [:])
            print("'misereri' forms:", analysis.dictionary["misereri"]?.forms ?? [:])
            print("'repleo' forms:", analysis.dictionary["repleo"]?.forms ?? [:])
            print("'despectio' forms:", analysis.dictionary["despectio"]?.forms ?? [:])
            print("'opprobrium' forms:", analysis.dictionary["opprobrium"]?.forms ?? [:])
            print("'abundo' forms:", analysis.dictionary["abundo"]?.forms ?? [:])
        }
    }

    func testAnalyzePsalm123() {
    let psalm123 = [
        "Nisi quia Dominus erat in nobis, dicat nunc Israel;",
        "nisi quia Dominus erat in nobis, cum exsurgerent homines in nos,",
        "forsitan vivos deglutissent nos.",
        "Cum irasceretur furor eorum in nos, forsitan aqua absorbuisset nos.",
        "Torrentem pertransivit anima nostra; forsitan pertransisset anima nostra aquam intolerabilem.",
        "Benedictus Dominus, qui non dedit nos in captionem dentibus eorum.",
        "Anima nostra sicut passer erepta est de laqueo venantium;",
        "laqueus contritus est, et nos liberati sumus.",
        "Adjutorium nostrum in nomine Domini, qui fecit caelum et terram."
    ]
    let id = PsalmIdentity(number: 127, category: nil)
    
    let analysis = latinService.analyzePsalm(id, text: psalm123)
    
    // Key words to verify
    let confirmedWords = [
        ("deglutio", ["deglutissent"], "swallow"),
        ("absorbeo", ["absorbuisset"], "overwhelm"),
        ("pertranso", ["pertransivit", "pertransisset"], "pass through"),
        ("eripio", ["erepta"], "rescue"),
        ("contundo", ["contritus"], "break")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // Specific form checks
    XCTAssertEqual(analysis.dictionary["deglutio"]?.forms["deglutissent"], 1)
    XCTAssertEqual(analysis.dictionary["absorbeo"]?.forms["absorbuisset"], 1)
    XCTAssertEqual(analysis.dictionary["eripio"]?.forms["erepta"], 1)
}

func testAnalyzePsalm124() {
    let psalm124 = [
        "Qui confidunt in Domino, sicut mons Sion: non commovebitur in aeternum, qui habitat in Jerusalem.",
        "Montes in circuitu ejus, et Dominus in circuitu populi sui, ex hoc nunc et usque in saeculum.",
        "Quia non relinquet Dominus virgam peccatorum super sortem justorum, ut non extendant justi ad iniquitatem manus suas.",
        "Benefac, Domine, bonis, et rectis corde.",
        "Declinantes autem in obligationes, adducet Dominus cum operantibus iniquitatem. Pax super Israel!"
    ]
    let id = PsalmIdentity(number: 124, category: nil)
    
    let analysis = latinService.analyzePsalm(id, text: psalm124)
    
    let confirmedWords = [
        ("confido", ["confidunt"], "trust"),
        ("commoveo", ["commovebitur"], "move"),
        ("relinquo", ["relinquet"], "leave"),
        ("extendo", ["extendant"], "stretch"),
        ("benefacio", ["benefac"], "do good")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // Check repeated words
    XCTAssertGreaterThan(analysis.dictionary["circuitus"]?.forms["circuitu"] ?? 0, 1)
    XCTAssertEqual(analysis.dictionary["mons"]?.forms["mons"], 1)
}

func testAnalyzePsalm125() {
    let psalm125 = [
        "In convertendo Dominus captivitatem Sion: facti sumus sicut consolati.",
        "Tunc repletum est gaudio os nostrum: et lingua nostra exsultatione.",
        "Tunc dicent inter gentes: Magnificavit Dominus facere cum eis.",
        "Magnificavit Dominus facere nobiscum: facti sumus lætantes.",
        "Converte, Domine, captivitatem nostram: sicut torrens in austro.",
        "Qui seminant in lacrimis: in exsultatione metent.",
        "Euntes ibant et flebant: mittentes semina sua.",
        "Venientes autem venient cum exsultatione: portantes manipulos suos."
    ]
    
    let id = PsalmIdentity(number: 127, category: nil)
    let analysis = latinService.analyzePsalm(id, text: psalm125)
    
    let confirmedWords = [
        ("converto", ["convertendo", "converte"], "turn"),
        ("consolor", ["consolati"], "comfort"),
        ("exsultatio", ["exsultatione"], "rejoice"),
        ("magnifico", ["magnificavit"], "magnify"),
        ("sero", ["seminant"], "sow")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // Check agricultural metaphors
    XCTAssertEqual(analysis.dictionary["sero"]?.forms["seminant"], 1)
    XCTAssertEqual(analysis.dictionary["meto"]?.forms["metent"], 1)
    XCTAssertEqual(analysis.dictionary["manipulus"]?.forms["manipulos"], 1)
}

func testAnalyzePsalm126() {
    let psalm126 = [
        "Nisi Dominus ædificaverit domum: in vanum laboraverunt qui ædificant eam.",
        "Nisi Dominus custodierit civitatem: frustra vigilat qui custodit eam.",
        "Vanum est vobis ante lucem surgere: surgite postquam sederitis, qui manducatis panem doloris.",
        "Cum dederit dilectis suis somnum: ecce haereditas Domini, filii; merces, fructus ventris.",
        "Sicut sagittæ in manu potentis: ita filii excussorum.",
        "Beatus vir qui implevit desiderium suum ex ipsis: non confundetur cum loquetur inimicis suis in porta."
    ]
    
    let id = PsalmIdentity(number: 127, category: nil)
    let analysis = latinService.analyzePsalm(id, text: psalm126)
    
    let confirmedWords = [
        ("aedifico", ["aedificaverit", "aedificant"], "build"),
        ("custodio", ["custodierit", "custodit"], "guard"),
        ("vanus", ["vanum", "vanum"], "vain"),
        ("surgo", ["surgere", "surgite"], "rise"),
        ("sagitta", ["sagittae"], "arrow")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // Check conditional clauses
    XCTAssertEqual(analysis.dictionary["nisi"]?.count, 2)
}
func testAnalyzePsalm127() {
    let psalm127 = [
        "Beati omnes qui timent Dominum, qui ambulant in viis ejus.",
        "Labores fructuum tuorum manducabis; beatus es, et bene tibi erit.",
        "Uxor tua sicut vitis abundans in lateribus domus tuae; filii tui sicut novellae olivarum in circuitu mensae tuae.",
        "Ecce sic benedicetur homo qui timet Dominum.",
        "Benedicat tibi Dominus ex Sion, et videas bona Jerusalem omnibus diebus vitae tuae.",
        "Et videas filios filiorum tuorum. Pax super Israel!"
    ]
    let id = PsalmIdentity(number: 127, category: nil)
    
    let analysis = latinService.analyzePsalm(id, text: psalm127)
    
    // ===== 1. Verify all words and translations =====
    let confirmedWords = [
        ("beatus", ["beati", "beatus"], "blessed"),
        ("timeo", ["timent", "timet"], "fear"),
        ("ambulo", ["ambulant"], "walk"),
        ("vitis", ["vitis"], "vine"),
        ("oliva", ["olivarum"], "olive"),
        ("uxor", ["uxor"], "wife"),
        ("filius", ["filii", "filios", "filiorum"], "son"),
        ("domus", ["domus"], "house"),
        ("benedico", ["benedicetur", "benedicat"], "bless"),
        ("video", ["videas"], "see"),
        ("bonus", ["bona"], "good")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 2. Verify exact form counts =====
    // Family-related terms
    XCTAssertEqual(analysis.dictionary["uxor"]?.forms["uxor"], 1)
    XCTAssertEqual(analysis.dictionary["filius"]?.forms["filii"], 1)    // v.3
    XCTAssertEqual(analysis.dictionary["filius"]?.forms["filios"], 1)   // v.6
    XCTAssertEqual(analysis.dictionary["filius"]?.forms["filiorum"], 1) // v.6
    
    // Verb forms
    XCTAssertEqual(analysis.dictionary["benedico"]?.forms["benedicetur"], 1) // v.4
    XCTAssertEqual(analysis.dictionary["benedico"]?.forms["benedicat"], 1)   // v.5
    XCTAssertEqual(analysis.dictionary["video"]?.forms["videas"], 2)         // v.5,6
    
    // ===== 3. Verify overall statistics =====
   
    
    // ===== 4. Debug output =====
    if verbose {
        print("\n=== Key Word Forms ===")
        print("FAMILY:")
        print("filii:", analysis.dictionary["filius"]?.forms["filii"] ?? 0)
        print("filios:", analysis.dictionary["filius"]?.forms["filios"] ?? 0)
        print("filiorum:", analysis.dictionary["filius"]?.forms["filiorum"] ?? 0)
        print("uxor:", analysis.dictionary["uxor"]?.forms["uxor"] ?? 0)
        
        print("\nVERBS:")
        print("benedicetur:", analysis.dictionary["benedico"]?.forms["benedicetur"] ?? 0)
        print("benedicat:", analysis.dictionary["benedico"]?.forms["benedicat"] ?? 0)
        print("videas:", analysis.dictionary["video"]?.forms["videas"] ?? 0)
        
        print("\nTOTALS:")
        print("Words:", analysis.totalWords)
        print("Unique lemmas:", analysis.uniqueLemmas)
    }
}
func testAnalyzePsalm128() {
    let psalm128 = [
        "Saepe expugnaverunt me a juventute mea, dicat nunc Israel;",
        "saepe expugnaverunt me a juventute mea, etenim non potuerunt mihi.",
        "Supra dorsum meum fabricaverunt peccatores; prolongaverunt iniquitatem suam.",
        "Dominus justus concidit cervices peccatorum.",
        "Confundantur et convertantur retrorsum omnes qui oderunt Sion.",
        "Fiant sicut foenum tectorum, quod priusquam evellatur exaruit,",
        "de quo non implevit manum suam qui metit, et sinum suum qui manipulos colligit.",
        "Et non dixerunt qui praeteribant: Benedictio Domini super vos; benediximus vobis in nomine Domini."
    ]
    
    let id = PsalmIdentity(number: 128, category: nil)
    let analysis = latinService.analyzePsalm(id, text: psalm128)
    
    // ===== 1. Verify all words and translations =====
    let confirmedWords = [
        ("expugno", ["expugnaverunt"], "attack"),
        ("juventus", ["juventute"], "youth"),
        ("dorsum", ["dorsum"], "back"),
        ("fabricor", ["fabricaverunt"], "plot"),
        ("peccator", ["peccatores", "peccatorum"], "sinner"),
        ("prolongo", ["prolongaverunt"], "prolong"),
        ("iniquitas", ["iniquitatem"], "iniquity"),
        ("concido", ["concidit"], "cut down"),
        ("cervix", ["cervices"], "neck"),
        ("confundo", ["confundantur"], "confound"),
        ("converto", ["convertantur"], "turn"),
        ("retrorsum", ["retrorsum"], "backward"),
        ("odium", ["oderunt"], "hate"),
        ("foenum", ["foenum"], "hay"),
        ("tectum", ["tectorum"], "roof"),
        ("meto", ["metit"], "reap"),
        ("colligo", ["colligit"], "gather"),
        ("benedico", ["benediximus"], "bless")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 2. Verify exact form counts =====
    // Key verb forms
    XCTAssertEqual(analysis.dictionary["expugno"]?.forms["expugnaverunt"], 2) // v.1,2
    XCTAssertEqual(analysis.dictionary["fabricor"]?.forms["fabricaverunt"], 1) // v.3
    XCTAssertEqual(analysis.dictionary["benedico"]?.forms["benediximus"], 1) // v.8
    
    // Noun forms
    XCTAssertEqual(analysis.dictionary["peccator"]?.forms["peccatores"], 1) // v.3
    XCTAssertEqual(analysis.dictionary["peccator"]?.forms["peccatorum"], 1) // v.4
    
    // ===== 3. Verify overall statistics =====
    print("Actual word count:", analysis.totalWords) // Check console to update expected
    print("Actual unique lemmas:", analysis.uniqueLemmas)
    // XCTAssertEqual(analysis.totalWords, 89) // Update after seeing actual
    // XCTAssertEqual(analysis.uniqueLemmas, 42) // Update after seeing actual
    
    // ===== 4. Debug output =====
    if verbose {
        print("\n=== Key Word Forms ===")
        print("VERBS:")
        print("expugnaverunt:", analysis.dictionary["expugno"]?.forms["expugnaverunt"] ?? 0)
        print("fabricaverunt:", analysis.dictionary["fabricor"]?.forms["fabricaverunt"] ?? 0)
        print("benediximus:", analysis.dictionary["benedico"]?.forms["benediximus"] ?? 0)
        
        print("\nNOUNS:")
        print("peccatores:", analysis.dictionary["peccator"]?.forms["peccatores"] ?? 0)
        print("peccatorum:", analysis.dictionary["peccator"]?.forms["peccatorum"] ?? 0)
        print("cervices:", analysis.dictionary["cervix"]?.forms["cervices"] ?? 0)
        
        print("\nTOTALS:")
        print("Words:", analysis.totalWords)
        print("Unique lemmas:", analysis.uniqueLemmas)
    }
}

func testAnalyzePsalm129() {
    let psalm129 = [
        "De profundis clamavi ad te, Domine;",
        "Domine, exaudi vocem meam. Fiant aures tuae intendentes in vocem deprecationis meae.",
        "Si iniquitates observaveris, Domine, Domine, quis sustinebit?",
        "Quia apud te propitiatio est, et propter legem tuam sustinui te, Domine.",
        "Sustinuit anima mea in verbo ejus; speravit anima mea in Domino.",
        "A custodia matutina usque ad noctem, speret Israel in Domino.",
        "Quia apud Dominum misericordia, et copiosa apud eum redemptio.",
        "Et ipse redimet Israel ex omnibus iniquitatibus ejus."
    ]

    let id = PsalmIdentity(number: 129, category: nil)
    
    let analysis = latinService.analyzePsalm(id, text: psalm129)
    
    // ===== 1. Verify all words and translations =====
    let confirmedWords = [
        ("profundum", ["profundis"], "depth"),
        ("clamo", ["clamavi"], "cry out"),
        ("exaudio", ["exaudi"], "hear"),
        ("deprecatio", ["deprecationis"], "supplication"),
        ("iniquitas", ["iniquitates"], "iniquity"),
        ("propitiatio", ["propitiatio"], "forgiveness"),
        ("sustineo", ["sustinebit", "sustinui", "sustinuit"], "endure"),
        ("spero", ["speravit", "speret"], "hope"),
        ("custodia", ["custodia"], "watch"),
        ("misericordia", ["misericordia"], "mercy"),
        ("redemptio", ["redemptio", ], "redemption")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 2. Verify exact form counts =====
    // Key verb forms
    XCTAssertEqual(analysis.dictionary["clamo"]?.forms["clamavi"], 1) // v.1
    XCTAssertEqual(analysis.dictionary["spero"]?.forms["speret"], 1)  // v.6
    
    // Repeated words
    XCTAssertEqual(analysis.dictionary["dominus"]?.count ?? 0, 5) // All occurrences
    
    // ===== 3. Debug output =====
    if verbose {
        print("\n=== Key Word Forms ===")
        print("VERBS:")
        print("clamavi:", analysis.dictionary["clamo"]?.forms["clamavi"] ?? 0)
        print("speret:", analysis.dictionary["spero"]?.forms["speret"] ?? 0)
        
        print("\nNOUNS:")
        print("profundis:", analysis.dictionary["profundum"]?.forms["profundis"] ?? 0)
        print("redemptio:", analysis.dictionary["redemptio"]?.forms["redemptio"] ?? 0)
        
        print("\nTOTALS:")
        print("Words:", analysis.totalWords)
        print("Unique lemmas:", analysis.uniqueLemmas)
    }
}

func testAnalyzePsalm130() {
    let psalm130 = [
        "Domine, non est exaltatum cor meum, neque elati sunt oculi mei; neque ambulavi in magnis, neque in mirabilibus super me.",
        "Si non humiliter sentiebam, sed exaltavi animam meam; sicut ablactatus est super matre sua, ita retributio in anima mea.",
        "Speret Israel in Domino, ex hoc nunc et usque in saeculum."
    ]
    let id = PsalmIdentity(number: 130, category: nil) 
    let analysis = latinService.analyzePsalm(id, text: psalm130)
    
    let confirmedWords = [
        ("exalto", ["exaltatum", "exaltavi"], "exalt"),
        ("humiliter", ["humiliter"], "humbly"),
        ("ablacto", ["ablactatus"], "wean"),
        ("retributio", ["retributio"], "reward"),
        ("spero", ["speret"], "hope")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // Check humility theme   
    XCTAssertEqual(analysis.dictionary["magnus"]?.count, 1)
}

func testAnalyzePsalm131() {
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
    
    let id = PsalmIdentity(number: 131, category: nil)
    let analysis = latinService.analyzePsalm(id, text: psalm131)
    
    let confirmedWords = [        
        ("memini", ["memento"], "remember"),        
        ("votum", ["votum"], "vow"),
        ("tabernaculum", ["tabernaculum"], "tabernacle"),
        ("sanctificatio", ["sanctificationis"], "sanctification")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
   
}

func testAnalyzePsalm132() {
    let id = PsalmIdentity(number: 132, category: nil)
    let psalm132 = [
        "Ecce quam bonum, et quam jucundum habitare fratres in unum.",
        "Sicut unguentum in capite, quod descendit in barbam, barbam Aaron,",
        "Quod descendit in oram vestimenti ejus: sicut ros Hermon, qui descendit in montem Sion.",
        "Quoniam illic mandavit Dominus benedictionem, et vitam usque in saeculum."
    ]
    
    let analysis = latinService.analyzePsalm(id, text: psalm132)
    
    let confirmedWords = [
        ("jucundus", ["jucundum"], "pleasant"),
        ("unguentum", ["unguentum"], "ointment"),
        ("ros", ["ros"], "dew"),
        ("benedictio", ["benedictionem"], "blessing"),
        ("mando", ["mandavit"], "command")
    ]
    if self.verbose {
            print("\n=== Confirmed Words in Psalm 132 ===")
        }
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // Check imagery
    XCTAssertEqual(analysis.dictionary["descendo"]?.count, 3)
    XCTAssertEqual(analysis.dictionary["frater"]?.count, 1)

     if self.verbose {
        print("\n=== Psalm 132 Analysis ===")
        print("Total words:", analysis.totalWords)
        print("Unique lemmas:", analysis.uniqueLemmas)
       
        confirmedWords.forEach { lemma, forms, _ in
            if let entry = analysis.dictionary[lemma] {
                print("\(lemma.padding(toLength: 15, withPad: " ", startingAt: 0)) forms: \(entry.forms), translation: \((entry.translation ?? "none").padding(toLength: 25, withPad: " ", startingAt: 0))")
            }
        }
        print("'descendo' forms:", analysis.dictionary["descendo"]?.forms ?? [:])
    }
}


 

func testAnalyzePsalm133() {
    let id = PsalmIdentity(number: 133, category: nil)
    let psalm133 = [
        "Ecce nunc benedicite Dominum, omnes servi Domini:",
        "Qui statis in domo Domini, in atriis domus Dei nostri.",
        "In noctibus extollite manus vestras in sancta, et benedicite Dominum.",
        "Benedicat te Dominus ex Sion, qui fecit caelum et terram."
    ]
    
    let analysis = latinService.analyzePsalm(id, text: psalm133)
    
    // ===== 1. Verify ACTUAL words in this psalm =====
    let confirmedWords = [
        ("benedico", ["benedicite", "benedicat"], "bless"),
        ("atrium", ["atriis"], "court"),
        ("extollo", ["extollite"], "lift"),
        ("sanctus", ["sancta"], "holy")
    ]

     
    if self.verbose {
        print("\n=== Confirmed Words in Psalm 133 ===")
    }
    verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
    
    // ===== 2. Verify grammatical forms =====
    // Imperative plural "benedicite" (appears twice)
    if let benedicoEntry = analysis.dictionary["benedico"] {
        let benediciteCount = benedicoEntry.forms["benedicite"] ?? 0
        XCTAssertEqual(benediciteCount, 2, 
                      "Expected exactly 2 occurrences of 'benedicite'")
        
        // Present subjunctive "benedicat" (appears once)
        let benedicatCount = benedicoEntry.forms["benedicat"] ?? 0
        XCTAssertEqual(benedicatCount, 1, 
                      "Expected exactly 1 occurrence of 'benedicat'")
    }
    
    // Ablative plural "atriis" (appears once)
    if let atriumEntry = analysis.dictionary["atrium"] {
        let atriisCount = atriumEntry.forms["atriis"] ?? 0
        XCTAssertEqual(atriisCount, 1, 
                      "Expected exactly 1 occurrence of 'atriis'")
    }
    
    // Imperative plural "extollite" (appears once)
    if let extolloEntry = analysis.dictionary["extollo"] {
        let extolliteCount = extolloEntry.forms["extollite"] ?? 0
        XCTAssertEqual(extolliteCount, 1, 
                      "Expected exactly 1 occurrence of 'extollite'")
    }
    
    // Ablative plural "noctibus" (appears once)
    if let noxEntry = analysis.dictionary["nox"] {
        let noctibusCount = noxEntry.forms["noctibus"] ?? 0
        XCTAssertEqual(noctibusCount, 1, 
                      "Expected exactly 1 occurrence of 'noctibus'")
    }
    
    // ===== 3. Debug output =====
    if verbose {
        print("\n=== Full Analysis ===")
        print("Total words:", analysis.totalWords)
        print("Unique lemmas:", analysis.uniqueLemmas)
        print("'benedico' forms:", analysis.dictionary["benedico"]?.forms ?? [:])
        print("'atrium' forms:", analysis.dictionary["atrium"]?.forms ?? [:])
        print("'extollo' forms:", analysis.dictionary["extollo"]?.forms ?? [:])
        print("'nox' forms:", analysis.dictionary["nox"]?.forms ?? [:])
        print("'sanctus' forms:", analysis.dictionary["sanctus"]?.forms ?? [:])
        print("'dominus' forms:", analysis.dictionary["dominus"]?.forms ?? [:])
        print("'domus' forms:", analysis.dictionary["domus"]?.forms ?? [:])
        print("'manus' forms:", analysis.dictionary["manus"]?.forms ?? [:])
        print("'sion' forms:", analysis.dictionary["sion"]?.forms ?? [:])
        print("'caelus' forms:", analysis.dictionary["caelus"]?.forms ?? [:])
    }
    
   
}
}