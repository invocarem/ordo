import XCTest
@testable import LatinService

class Psalm138ATests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    // MARK: - Test Data (Psalm 138A)
    let id = PsalmIdentity(number: 138, category: "A")
    let psalm138A = [
        "Domine, probasti me, et cognovisti me: tu cognovisti sessionem meam, et resurrectionem meam.",
        "Intellexisti cogitationes meas de longe: semitam meam, et funiculum meum investigasti.",
        "Et omnes vias meas praevidisti: quia non est sermo in lingua mea.",
        "Ecce, Domine, tu cognovisti omnia, novissima et antiqua: tu formasti me, et posuisti super me manum tuam.",
        "Mirabilis facta est scientia tua ex me: confortata est, et non potero ad eam.",                    
        "Quo ibo a spiritu tuo? et quo a facie tua fugiam?",
        "Si ascendero in caelum, tu illic es: si descendero in infernum, ades.",
        "Si sumpsero pennas meas diluculo, et habitavero in extremis maris:",
        "Etenim illic manus tua deducet me: et tenebit me dextera tua."
    ]
    
    // MARK: - Grouped Line Tests
    
    func testPsalm138ALines1and2() {
        let line1 = psalm138A[0] // "Domine, probasti me, et cognovisti me: tu cognovisti sessionem meam, et resurrectionem meam."
        let line2 = psalm138A[1] // "Intellexisti cogitationes meas de longe: semitam meam, et funiculum meum investigasti."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("dominus", ["domine"], "Lord"),
            ("probo", ["probasti"], "test"),
            ("cognosco", ["cognovisti", "cognovisti"], "know"),
            ("sessio", ["sessionem"], "sitting"),
            ("resurrectio", ["resurrectionem"], "rising"),
            ("intellego", ["intellexisti"], "understand"),
            ("cogitatio", ["cogitationes"], "thought"),
            ("longus", ["longe"], "far"),
            ("semita", ["semitam"], "path"),
            ("funiculus", ["funiculum"], "cord"),
            ("investigo", ["investigasti"], "search")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Omniscience": [
                ("cognosco", "Complete knowledge"),
                ("intellego", "Deep understanding")
            ],
            "Human Experience": [
                ("sessio", "Daily activities"),
                ("resurrectio", "Life transitions")
            ],
            "Divine Scrutiny": [
                ("probo", "Testing examination"),
                ("investigo", "Thorough searching")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138A:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138ALines3and4() {
        let line3 = psalm138A[2] // "Et omnes vias meas praevidisti: quia non est sermo in lingua mea."
        let line4 = psalm138A[3] // "Ecce, Domine, tu cognovisti omnia, novissima et antiqua: tu formasti me, et posuisti super me manum tuam."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("via", ["vias"], "way"),
            ("praevideo", ["praevidisti"], "foresee"),
            ("sermo", ["sermo"], "word"),
            ("lingua", ["lingua"], "tongue"),
            ("ecce", ["ecce"], "behold"),
            ("omnis", ["omnia"], "all"),
            ("novissimus", ["novissima"], "last"),
            ("antiquus", ["antiqua"], "ancient"),
            ("formo", ["formasti"], "form"),
            ("pono", ["posuisti"], "place"),
            ("manus", ["manum"], "hand")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Foreknowledge": [
                ("praevideo", "Complete foresight"),
                ("via", "Life paths")
            ],
            "Creative Power": [
                ("formo", "Formative action"),
                ("pono", "Purposeful placement")
            ],
            "Temporal Knowledge": [
                ("novissimus", "Future events"),
                ("antiquus", "Ancient things")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138A:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138ALines5and6() {
        let line5 = psalm138A[4] // "Mirabilis facta est scientia tua ex me: confortata est, et non potero ad eam."
        let line6 = psalm138A[5] // "Quo ibo a spiritu tuo? et quo a facie tua fugiam?"
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("mirabilis", ["mirabilis"], "wonderful"),
            ("scientia", ["scientia"], "knowledge"),
            ("conforto", ["confortata"], "strengthen"),
            ("possum", ["potero"], "be able"),
            ("eo", ["ibo"], "go"),
            ("spiritus", ["spiritu"], "spirit"),
            ("facies", ["facie"], "face"),
            ("fugio", ["fugiam"], "flee")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Knowledge": [
                ("scientia", "God's understanding"),
                ("mirabilis", "Wonderful nature")
            ],
            "Divine Presence": [
                ("spiritus", "Omnipresent Spirit"),
                ("facies", "Divine countenance")
            ],
            "Human Limitation": [
                ("possum", "Inability to comprehend"),
                ("fugio", "Futility of escape")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138A:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138ALines7and8() {
        let line7 = psalm138A[6] // "Si ascendero in caelum, tu illic es: si descendero in infernum, ades."
        let line8 = psalm138A[7] // "Si sumpsero pennas meas diluculo, et habitavero in extremis maris:"
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("ascendo", ["ascendero"], "ascend"),
            ("caelum", ["caelum"], "heaven"),
            ("descendo", ["descendero"], "descend"),
            ("infernus", ["infernum"], "hell"),
            ("adsum", ["ades"], "be present"),
            ("sumo", ["sumpsero"], "take"),
            ("penna", ["pennas"], "wing"),
            ("diluculum", ["diluculo"], "dawn"),
            ("habito", ["habitavero"], "dwell"),
            ("extremus", ["extremis"], "uttermost"),
            ("mare", ["maris"], "sea")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Omnipresence": [
                ("adsum", "Constant presence"),
                ("caelum", "Heavenly realm")
            ],
            "Extreme Locations": [
                ("infernus", "Lowest depths"),
                ("extremus", "Farthest places")
            ],
            "Swift Movement": [
                ("penna", "Wings for speed"),
                ("diluculum", "Dawn's quickness")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138A:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138ALine9() {
        let line9 = psalm138A[8] // "Etenim illic manus tua deducet me: et tenebit me dextera tua."
        let analysis = latinService.analyzePsalm(id, text: line9, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("etenim", ["etenim"], "for indeed"),
            ("manus", ["manus"], "hand"),
            ("deduco", ["deducet"], "lead"),
            ("teneo", ["tenebit"], "hold"),
            ("dexter", ["dextera"], "right hand")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Guidance": [
                ("deduco", "Active leading"),
                ("manus", "Guiding hand")
            ],
            "Divine Protection": [
                ("teneo", "Secure holding"),
                ("dexter", "Strong hand")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138A:9 ANALYSIS:")
            print("9: \"\(line9)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    // MARK: - Helper Methods
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                print("\n❌ MISSING LEMMA IN DICTIONARY: \(lemma)")
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage (case-insensitive)
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
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
    
    private func verifyThematicElements(analysis: PsalmAnalysisResult, expectedThemes: [String: [(lemma: String, description: String)]]) {
        for (theme, elements) in expectedThemes {
            for (lemma, description) in elements {
                guard analysis.dictionary[lemma] != nil else {
                    XCTFail("Missing lemma for theme verification: \(lemma) (theme: \(theme))")
                    continue
                }
                
                if verbose {
                    print("VERIFIED THEME: \(theme) - \(lemma) (\(description))")
                }
            }
        }
    }
}

class Psalm138BTests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    // MARK: - Test Data (Psalm 138B)
    let id = PsalmIdentity(number: 138, category: "B")
    let psalm138B = [
        "Et dixi: Forsitan tenebrae conculcabunt me: et nox illuminatio mea in deliciis meis.",
        "Quia tenebrae non obscurabuntur a te, et nox sicut dies illuminabitur: sicut tenebrae ejus, ita et lumen ejus.",
        "Quia tu possedisti renes meos: suscepisti me de utero matris meae.",
        "Confitebor tibi, quia terribiliter magnificatus es: mirabilia opera tua, et anima mea cognoscit nimis.",
        "Non est occultatum os meum a te, quod fecisti in occulto: et substantia mea in inferioribus terrae.",
        "Imperfectum meum viderunt oculi tui, et in libro tuo omnia scribentur: dies formabuntur, et nemo in eis.",
        "Mihi autem nimis honorati sunt amici tui, Deus: nimis confortatus est principatus eorum.",
        "Dinumerabo eos, et super arenam multiplicabuntur: exsurrexi, et adhuc sum tecum.",
        "Si occideris, Deus, peccatores: viri sanguinum, declinate a me.",
        "Quia dicitis in cogitatione: Accipient in vanitate civitates tuas.",
        "Nonne qui oderunt te, Domine, oderam? et super inimicos tuos tabescebam?",
        "Perfecto odio oderam illos: inimici facti sunt mihi.",
        "Proba me, Deus, et scito cor meum: interroga me, et cognosce semitas meas.",
        "Et vide si via iniquitatis in me est: et deduc me in via aeterna."
    ]
    
    // MARK: - Grouped Line Tests
    
    func testPsalm138BLines1and2() {
        let line1 = psalm138B[0] // "Et dixi: Forsitan tenebrae conculcabunt me: et nox illuminatio mea in deliciis meis."
        let line2 = psalm138B[1] // "Quia tenebrae non obscurabuntur a te, et nox sicut dies illuminabitur: sicut tenebrae ejus, ita et lumen ejus."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("dico", ["dixi"], "say"),
            ("forsitan", ["forsitan"], "perhaps"),
            ("tenebrae", ["tenebrae", "tenebrae"], "darkness"),
            ("conculco", ["conculcabunt"], "trample"),
            ("nox", ["nox", "nox"], "night"),
            ("illuminatio", ["illuminatio", "illuminabitur"], "light"),
            ("obscuro", ["obscurabuntur"], "darken"),
            ("dies", ["dies"], "day"),
            ("lumen", ["lumen"], "light")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Illumination": [
                ("illuminatio", "Transforming light"),
                ("lumen", "Divine radiance")
            ],
            "Darkness Transformed": [
                ("tenebrae", "Darkness overcome"),
                ("nox", "Night as day")
            ],
            "Divine Protection": [
                ("conculco", "Negation of harm"),
                ("obscuro", "Light preserved")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:1-2 ANALYSIS:")
            print("1: \"\(line1)\"")
            print("2: \"\(line2)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138BLines3and4() {
        let line3 = psalm138B[2] // "Quia tu possedisti renes meos: suscepisti me de utero matris meae."
        let line4 = psalm138B[3] // "Confitebor tibi, quia terribiliter magnificatus es: mirabilia opera tua, et anima mea cognoscit nimis."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("possideo", ["possedisti"], "possess"),
            ("ren", ["renes"], "kidney"),
            ("suscipio", ["suscepisti"], "receive"),
            ("uterus", ["utero"], "womb"),
            ("mater", ["matris"], "mother"),
            ("confiteor", ["confitebor"], "praise"),
            ("terribilis", ["terribiliter"], "awesomely"),
            ("magnifico", ["magnificatus"], "magnify"),
            ("mirabilis", ["mirabilia"], "wonderful"),
            ("opus", ["opera"], "work"),
            ("anima", ["anima"], "soul"),
            ("cognosco", ["cognoscit"], "know")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Formation": [
                ("possideo", "Ownership of being"),
                ("suscipio", "Receiving at birth")
            ],
            "Awe and Wonder": [
                ("terribilis", "Awesome power"),
                ("mirabilis", "Wonderful works")
            ],
            "Personal Response": [
                ("confiteor", "Praise response"),
                ("cognosco", "Personal knowledge")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:3-4 ANALYSIS:")
            print("3: \"\(line3)\"")
            print("4: \"\(line4)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138BLines5and6() {
        let line5 = psalm138B[4] // "Non est occultatum os meum a te, quod fecisti in occulto: et substantia mea in inferioribus terrae."
        let line6 = psalm138B[5] // "Imperfectum meum viderunt oculi tui, et in libro tuo omnia scribentur: dies formabuntur, et nemo in eis."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("occulto", ["occultatum", "occulto"], "hidden"),
            ("os", ["os"], "mouth"),
            ("facio", ["fecisti"], "make"),
            ("substantia", ["substantia"], "substance"),
            ("inferior", ["inferioribus"], "lower"),
            ("terra", ["terrae"], "earth"),
            ("imperfectus", ["imperfectum"], "unformed"),
            ("oculus", ["oculi"], "eye"),
            ("liber", ["libro"], "book"),
            ("scribo", ["scribentur"], "write"),
            ("dies", ["dies"], "day"),
            ("formo", ["formabuntur"], "form")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Knowledge": [
                ("occulto", "Hidden things revealed"),
                ("oculus", "Divine sight")
            ],
            "Creative Sovereignty": [
                ("formo", "Formation of days"),
                ("imperfectus", "Unformed state")
            ],
            "Divine Record": [
                ("liber", "Book of life"),
                ("scribo", "Recording actions")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:5-6 ANALYSIS:")
            print("5: \"\(line5)\"")
            print("6: \"\(line6)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138BLines7and8() {
        let line7 = psalm138B[6] // "Mihi autem nimis honorati sunt amici tui, Deus: nimis confortatus est principatus eorum."
        let line8 = psalm138B[7] // "Dinumerabo eos, et super arenam multiplicabuntur: exsurrexi, et adhuc sum tecum."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("honoro", ["honorati"], "honor"),
            ("amicus", ["amici"], "friend"),
            ("deus", ["deus"], "God"),
            ("conforto", ["confortatus"], "strengthen"),
            ("principatus", ["principatus"], "rule"),
            ("dinumero", ["dinumerabo"], "count"),
            ("arena", ["arenam"], "sand"),
            ("multiplico", ["multiplicabuntur"], "multiply"),
            ("exsurgo", ["exsurrexi"], "rise"),
            ("adhuc", ["adhuc"], "still"),
            ("sum", ["sum"], "be")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Friendship": [
                ("amicus", "God's friends"),
                ("honoro", "Honored status")
            ],
            "Abundant Blessing": [
                ("multiplico", "Multiplication"),
                ("arena", "Sand as measure")
            ],
            "Constant Presence": [
                ("exsurgo", "Resurrection imagery"),
                ("adhuc", "Continuing presence")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:7-8 ANALYSIS:")
            print("7: \"\(line7)\"")
            print("8: \"\(line8)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138BLines9and10() {
        let line9 = psalm138B[8] // "Si occideris, Deus, peccatores: viri sanguinum, declinate a me."
        let line10 = psalm138B[9] // "Quia dicitis in cogitatione: Accipient in vanitate civitates tuas."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("occido", ["occideris"], "kill"),
            ("peccator", ["peccatores"], "sinner"),
            ("vir", ["viri"], "man"),
            ("sanguis", ["sanguinum"], "blood"),
            ("declino", ["declinate"], "turn away"),
            ("dico", ["dicitis"], "say"),
            ("cogitatio", ["cogitatione"], "thought"),
            ("accipio", ["accient"], "receive"),
            ("vanitas", ["vanitate"], "vanity"),
            ("civitas", ["civitates"], "city")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Judgment": [
                ("occido", "Destruction of wicked"),
                ("peccator", "Sinners identified")
            ],
            "Violent Men": [
                ("sanguis", "Bloody men"),
                ("vir", "Violent individuals")
            ],
            "False Claims": [
                ("vanitas", "Empty boasts"),
                ("civitas", "Cities as prize")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:9-10 ANALYSIS:")
            print("9: \"\(line9)\"")
            print("10: \"\(line10)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138BLines11and12() {
        let line11 = psalm138B[10] // "Nonne qui oderunt te, Domine, oderam? et super inimicos tuos tabescebam?"
        let line12 = psalm138B[11] // "Perfecto odio oderam illos: inimici facti sunt mihi."
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 11)
        
        // Lemma verification
        let testLemmas = [
            ("odi", ["oderunt", "oderam", "oderam"], "hate"),
            ("dominus", ["domine"], "Lord"),
            ("inimicus", ["inimicos", "inimici"], "enemy"),
            ("tabesco", ["tabescebam"], "waste away"),
            ("perfectus", ["perfecto"], "perfect"),
            ("facio", ["facti"], "make")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Righteous Hatred": [
                ("odi", "Hatred of evil"),
                ("perfectus", "Complete rejection")
            ],
            "Identification with God": [
                ("inimicus", "Shared enemies"),
                ("tabesco", "Emotional response")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:11-12 ANALYSIS:")
            print("11: \"\(line11)\"")
            print("12: \"\(line12)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    func testPsalm138BLines13and14() {
        let line13 = psalm138B[12] // "Proba me, Deus, et scito cor meum: interroga me, et cognosce semitas meas."
        let line14 = psalm138B[13] // "Et vide si via iniquitatis in me est: et deduc me in via aeterna."
        let combinedText = line13 + " " + line14
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 13)
        
        // Lemma verification
        let testLemmas = [
            ("probo", ["proba"], "test"),
            ("deus", ["deus"], "God"),
            ("scio", ["scito"], "know"),
            ("cor", ["cor"], "heart"),
            ("interrogo", ["interroga"], "examine"),
            ("cognosco", ["cognosce"], "know"),
            ("semita", ["semitas"], "path"),
            ("video", ["vide"], "see"),
            ("via", ["via", "via"], "way"),
            ("iniquitas", ["iniquitatis"], "wickedness"),
            ("deduco", ["deduc"], "lead"),
            ("aeternus", ["aeterna"], "eternal")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Examination": [
                ("probo", "Request for testing"),
                ("interrogo", "Divine inquiry")
            ],
            "Heart Knowledge": [
                ("cor", "Inner being"),
                ("scio", "Deep knowing")
            ],
            "Eternal Guidance": [
                ("deduco", "Divine leading"),
                ("aeternus", "Everlasting way")
            ]
        ]
        
        if verbose {
            print("\nPSALM 138B:13-14 ANALYSIS:")
            print("13: \"\(line13)\"")
            print("14: \"\(line14)\"")
            
            print("\nLEMMA VERIFICATION:")
            testLemmas.forEach { lemma, forms, translation in
                print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
            }
            
            print("\nDETECTED THEMES:")
            analysis.themes.forEach { theme in
                print("Theme name:\(theme.name): \(theme.supportingLemmas.joined(separator: ", "))")
            }
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
        verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    }
    
    // MARK: - Helper Methods
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                print("\n❌ MISSING LEMMA IN DICTIONARY: \(lemma)")
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage (case-insensitive)
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
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
    
    private func verifyThematicElements(analysis: PsalmAnalysisResult, expectedThemes: [String: [(lemma: String, description: String)]]) {
        for (theme, elements) in expectedThemes {
            for (lemma, description) in elements {
                guard analysis.dictionary[lemma] != nil else {
                    XCTFail("Missing lemma for theme verification: \(lemma) (theme: \(theme))")
                    continue
                }
                
                if verbose {
                    print("VERIFIED THEME: \(theme) - \(lemma) (\(description))")
                }
            }
        }
    }
}
 