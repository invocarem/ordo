import XCTest
@testable import LatinService

class Psalm9ATests: XCTestCase {
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

    // MARK: - Test Data (Psalm 9A)
    let id = PsalmIdentity(number: 9, section: "A")
    let psalm9A = [
        "Confitebor tibi, Domine, in toto corde meo; narrabo omnia mirabilia tua.",
        "Laetabor et exsultabo in te; psallam nomini tuo, Altissime.",
        "In convertendo inimicum meum retrorsum, infirmabuntur, et peribunt a facie tua.",
        "Quoniam fecisti judicium meum et causam meum; sedisti super thronum, qui judicas justitiam.",
        "Increpasti gentes, et periit impius; nomen eorum delesti in aeternum, et in saeculum saeculi.",
        "Inimici defecerunt frameae in finem: et civitates destruxisti; periit memoria eorum cum sonitu.",
        "Et Dominus in aeternum permanet; paravit in judicio thronum suum.",
        "Et ipse judicabit orbem terrae in aequitate; judicabit populos in justitia.",
        "Et factus est Dominus refugium pauperi; adjutor in opportunitatibus, in tribulatione.",
        "Et sperent in te qui noverunt nomen tuum; quoniam non dereliquisti quaerentes te, Domine.",
        "Psallite Domino, qui habitat in Sion; annuntiate inter gentes studia ejus:",
        "Quoniam requirens sanguinem eorum recordatus est; non est oblitus clamorem pauperum.",
        "Miserere mei, Domine; vide humilitatem meam de inimicis meis,",
        "Qui exaltas me de portis mortis, ut annuntiem omnes laudationes tuas in portis filiae Sion.",
        "Exsultabo in salutari tuo; infixae sunt gentes in interitu quem fecerunt; in laqueo isto quem absconderunt comprehensus est pes eorum.",
        "Cognoscitur Dominus judicia faciens; in operibus manuum suarum comprehensus est peccator.",
        "Convertantur peccatores in infernum, omnes gentes quae obliviscuntur Deum.",
        "Quoniam non in finem oblivio erit pauperis; patientia pauperum non peribit in finem."
    ]
    
    // MARK: - Grouped Line Tests
    
    func testPsalm9ALines1and2() {
        let line1 = psalm9A[0] // "Confitebor tibi, Domine, in toto corde meo; narrabo omnia mirabilia tua."
        let line2 = psalm9A[1] // "Laetabor et exsultabo in te; psallam nomini tuo, Altissime."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("confiteor", ["confitebor"], "confess"),
            ("dominus", ["domine"], "Lord"),
            ("cor", ["corde"], "heart"),
            ("narro", ["narrabo"], "declare"),
            ("mirabilis", ["mirabilia"], "wonderful"),
            ("laetor", ["laetabor"], "rejoice"),
            ("exsulto", ["exsultabo"], "exult"),
            ("psallo", ["psallam"], "sing praise"),
            ("nomen", ["nomini"], "name"),
            ("altissimus", ["altissime"], "Most High")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Personal Praise": [
                ("confiteor", "Individual confession"),
                ("narro", "Personal testimony")
            ],
            "Joyful Worship": [
                ("laetor", "Expression of joy"),
                ("exsulto", "Exuberant praise")
            ],
            "Divine Attributes": [
                ("altissimus", "God's supremacy"),
                ("mirabilis", "Wonderful works")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:1-2 ANALYSIS:")
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
    
    func testPsalm9ALines3and4() {
        let line3 = psalm9A[2] // "In convertendo inimicum meum retrorsum, infirmabuntur, et peribunt a facie tua."
        let line4 = psalm9A[3] // "Quoniam fecisti judicium meum et causam meum; sedisti super thronum, qui judicas justitiam."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("inimicus", ["inimicum"], "enemy"),
            ("retrorsum", ["retrorsum"], "backward"),
            ("infirmo", ["infirmabuntur"], "weaken"),
            ("pereo", ["peribunt"], "perish"),
            ("facies", ["facie"], "face"),
            ("facio", ["fecisti"], "do"),
            ("judicium", ["judicium"], "judgment"),
            ("causa", ["causam"], "cause"),
            ("sedeo", ["sedisti"], "sit"),
            ("thronus", ["thronum"], "throne"),
            ("justus", ["justitiam"], "justice")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Judgment": [
                ("judicium", "Legal vindication"),
                ("thronus", "Judicial authority")
            ],
            "Enemy Defeat": [
                ("inimicus", "Opposition identified"),
                ("pereo", "Final destruction")
            ],
            "Royal Imagery": [
                ("sedeo", "Kingly posture"),
                ("justus", "Righteous rule")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:3-4 ANALYSIS:")
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
    
    func testPsalm9ALines5and6() {
        let line5 = psalm9A[4] // "Increpasti gentes, et periit impius; nomen eorum delesti in aeternum, et in saeculum saeculi."
        let line6 = psalm9A[5] // "Inimici defecerunt frameae in finem: et civitates destruxisti; periit memoria eorum cum sonitu."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("increpo", ["increpasti"], "rebuke"),
            ("gens", ["gentes"], "nation"),
            ("impius", ["impius"], "wicked"),
            ("deleo", ["delesti"], "destroy"),
            ("aeternus", ["aeternum"], "eternal"),
            ("saeculum", ["saeculum"], "age"),
            ("inimicus", ["inimici"], "enemy"),
            ("framea", ["frameae"], "sword"),
            ("finis", ["finem"], "end"),
            ("civitas", ["civitates"], "city"),
            ("memoria", ["memoria"], "memory"),
            ("sonitus", ["sonitu"], "sound")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Rebuke": [
                ("increpo", "Authoritative correction"),
                ("deleo", "Complete eradication")
            ],
            "Final Destruction": [
                ("aeternus", "Permanent consequences"),
                ("finis", "Definitive ending")
            ],
            "Historical Judgment": [
                ("civitas", "Urban centers judged"),
                ("memoria", "Oblivion of the wicked")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:5-6 ANALYSIS:")
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
    
    func testPsalm9ALines7and8() {
        let line7 = psalm9A[6] // "Et Dominus in aeternum permanet; paravit in judicio thronum suum."
        let line8 = psalm9A[7] // "Et ipse judicabit orbem terrae in aequitate; judicabit populos in justitia."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("dominus", ["dominus"], "Lord"),
            ("permaneo", ["permanet"], "endure"),
            ("paro", ["paravit"], "prepare"),
            ("judicium", ["judicio"], "judgment"),
            ("thronus", ["thronum"], "throne"),
            ("judico", ["judicabit", "judicabit"], "judge"),
            ("orbis", ["orbem"], "world"),
            ("terra", ["terrae"], "earth"),
            ("aequitas", ["aequitate"], "equity"),
            ("populus", ["populos"], "people"),
            ("justus", ["justitia"], "justice")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Eternal Sovereignty": [
                ("permaneo", "Unchanging nature"),
                ("thronus", "Eternal reign")
            ],
            "Universal Justice": [
                ("orbis", "Global scope"),
                ("aequitas", "Fairness standard")
            ],
            "Righteous Rule": [
                ("judico", "Judicial function"),
                ("justus", "Moral foundation")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:7-8 ANALYSIS:")
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
    
    func testPsalm9ALines9and10() {
        let line9 = psalm9A[8] // "Et factus est Dominus refugium pauperi; adjutor in opportunitatibus, in tribulatione."
        let line10 = psalm9A[9] // "Et sperent in te qui noverunt nomen tuum; quoniam non dereliquisti quaerentes te, Domine."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("refugium", ["refugium"], "refuge"),
            ("pauper", ["pauperi"], "poor"),
            ("adjutor", ["adjutor"], "helper"),
            ("opportunitas", ["opportunitatibus"], "opportunity"),
            ("tribulatio", ["tribulatione"], "tribulation"),
            ("spero", ["sperent"], "hope"),
            ("nosco", ["noverunt"], "know"),
            ("nomen", ["nomen", "nomen"], "name"),
            ("derelinquo", ["dereliquisti"], "forsake"),
            ("quaero", ["quaerentes"], "seek")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Protection": [
                ("refugium", "Shelter imagery"),
                ("adjutor", "Active assistance")
            ],
            "Faithful Relationship": [
                ("spero", "Confident trust"),
                ("derelinquo", "Divine faithfulness")
            ],
            "Covenant Knowledge": [
                ("nosco", "Personal acquaintance"),
                ("nomen", "Representative identity")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:9-10 ANALYSIS:")
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
        func testPsalm9ALines11and12() {
        let line11 = psalm9A[10] // "Psallite Domino, qui habitat in Sion; annuntiate inter gentes studia ejus:"
        let line12 = psalm9A[11] // "Quoniam requirens sanguinem eorum recordatus est; non est oblitus clamorem pauperum."
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 11)
        
        // Lemma verification
        let testLemmas = [
            ("psallo", ["psallite"], "sing praise"),
            ("dominus", ["domino"], "Lord"),
            ("habito", ["habitat"], "dwell"),
            ("Sion", ["sion"], "Zion"),
            ("annuntio", ["annuntiate"], "declare"),
            ("gens", ["gentes"], "nation"),
            ("studium", ["studia"], "pursuit"),
            ("requiro", ["requirens"], "require"),
            ("sanguis", ["sanguinem"], "blood"),
            ("recordor", ["recordatus"], "remember"),
            ("obliviscor", ["oblitus"], "forget"),
            ("clamor", ["clamorem"], "cry"),
            ("pauper", ["pauperum"], "poor")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Universal Proclamation": [
                ("annuntio", "Global declaration"),
                ("gens", "International scope")
            ],
            "Divine Remembrance": [
                ("recordor", "Active recollection"),
                ("obliviscor", "Negation of forgetfulness")
            ],
            "Justice for the Oppressed": [
                ("sanguis", "Violence remembered"),
                ("pauper", "Focus on the vulnerable")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:11-12 ANALYSIS:")
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
    
    func testPsalm9ALines13and14() {
        let line13 = psalm9A[12] // "Miserere mei, Domine; vide humilitatem meam de inimicis meis,"
        let line14 = psalm9A[13] // "Qui exaltas me de portis mortis, ut annuntiem omnes laudationes tuas in portis filiae Sion."
        let combinedText = line13 + " " + line14
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 13)
        
        // Lemma verification
        let testLemmas = [
            ("misereor", ["miserere"], "have mercy"),
            ("dominus", ["domine"], "Lord"),
            ("video", ["vide"], "see"),
            ("humilitas", ["humilitatem"], "affliction"),
            ("inimicus", ["inimicis"], "enemy"),
            ("exalto", ["exaltas"], "lift up"),
            ("porta", ["portis", "portis"], "gate"),
            ("mors", ["mortis"], "death"),
            ("annuntio", ["annuntiem"], "declare"),
            ("laudatio", ["laudationes"], "praise"),
            ("filia", ["filiae"], "daughter")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Personal Petition": [
                ("misereor", "Cry for mercy"),
                ("video", "Request for divine attention")
            ],
            "Resurrection Imagery": [
                ("exalto", "Dramatic deliverance"),
                ("porta", "Threshold symbolism")
            ],
            "Redemptive Purpose": [
                ("annuntio", "Declarative response"),
                ("laudatio", "Public thanksgiving")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:13-14 ANALYSIS:")
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
    
    func testPsalm9ALines15and16() {
        let line15 = psalm9A[14] // "Exsultabo in salutari tuo; infixae sunt gentes in interitu quem fecerunt; in laqueo isto quem absconderunt comprehensus est pes eorum."
        let line16 = psalm9A[15] // "Cognoscitur Dominus judicia faciens; in operibus manuum suarum comprehensus est peccator."
        let combinedText = line15 + " " + line16
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 15)
        
        // Lemma verification
        let testLemmas = [
            ("exsulto", ["exsultabo"], "exult"),
            ("salutaris", ["salutari"], "salvation"),
            ("infigo", ["infixae"], "pierce"),
            ("gens", ["gentes"], "nation"),
           
            ("laqueus", ["laqueo"], "snare"),
            ("abscondo", ["absconderunt"], "hide"),
            ("comprehendo", ["comprehensus", "comprehensus"], "seize"),
            ("pes", ["pes"], "foot"),
            ("cognosco", ["cognoscitur"], "know"),
            ("judicium", ["judicia"], "judgment"),
            ("opus", ["operibus"], "work"),
            ("manus", ["manuum"], "hand"),
            ("peccator", ["peccator"], "sinner")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Poetic Justice": [
                ("laqueus", "Ensnarement reversed"),
                ("pes", "Literal stumbling")
            ],
            "Divine Self-Revelation": [
                ("cognosco", "God making Himself known"),
                ("judicium", "Through judicial acts")
            ],
            "Moral Causality": [
                ("interitus", "Self-inflicted ruin"),
                ("opus", "Deeds recoiling")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:15-16 ANALYSIS:")
            print("15: \"\(line15)\"")
            print("16: \"\(line16)\"")
            
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
    
    func testPsalm9ALines17and18() {
        let line17 = psalm9A[16] // "Convertantur peccatores in infernum, omnes gentes quae obliviscuntur Deum."
        let line18 = psalm9A[17] // "Quoniam non in finem oblivio erit pauperis; patientia pauperum non peribit in finem."
        let combinedText = line17 + " " + line18
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 17)
        
        // Lemma verification
        let testLemmas = [
            ("converto", ["convertantur"], "turn"),
            ("peccator", ["peccatores"], "sinner"),
            ("infernus", ["infernum"], "hell"),
            ("gens", ["gentes"], "nations"),
            ("obliviscor", ["obliviscuntur" ], "forget"),
            ("deus", ["deum"], "God"),
            ("finis", ["finem", "finem"], "end"),
            ("pauper", ["pauperis", "pauperum"], "poor"),
            ("patientia", ["patientia"], "endurance"),
            ("pereo", ["peribit"], "perish")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Final Judgment": [
                ("infernus", "Eternal destination"),
                ("peccator", "Unrepentant sinners")
            ],
            "Divine Memory": [
                ("obliviscor", "Contrast: forgetful people vs remembering God"),
                ("pauper", "God's special concern")
            ],
            "Eschatological Hope": [
                ("finis", "Temporal limitation"),
                ("patientia", "Ultimate vindication")
            ]
        ]
        
        if verbose {
            print("\nPSALM 9A:17-18 ANALYSIS:")
            print("17: \"\(line17)\"")
            print("18: \"\(line18)\"")
            
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


class Psalm9BTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 9B)
    let id = PsalmIdentity(number: 9, section: "B")
    let psalm9B = [
        "Exsurge, Domine, non praevaleat homo; judicentur gentes in conspectu tuo.",
        "Constitue, Domine, legislatorem super eos, ut sciant gentes quoniam homines sunt.",
        "Ut quid, Domine, recessisti longe, despicis in opportunitatibus, in tribulatione?",
        "Dum superbit impius, incenditur pauper; comprehenduntur in consiliis quibus cogitant.",
        "Quoniam laudatur peccator in desideriis animae suae, et iniquus benedicitur.",
        "Exacerbavit Dominum peccator, secundum multitudinem irae suae non quaeret:",
        "Non est Deus in conspectu eius; inquinatae sunt viae illius in omni tempore.",
        "Auferuntur judicia tua a facie eius; omnium inimicorum suorum dominabitur.",
        "Dixit enim in corde suo: Non movebor a generatione in generationem sine malo.",
        "Cujus maledictione os plenum est, et amaritudine, et dolo; sub lingua ejus labor et dolor.",
        "Sedet in insidiis cum divitibus in occultis, ut interficiat innocentem;",
        "Oculi ejus in pauperem respiciunt; insidiatur in abscondito, quasi leo in spelunca sua.",
        "Insidiatur ut rapiat pauperem; rapere pauperem dum attrahit eum.",
        "In laqueo suo humiliabit eum; inclinabit se, et cadet cum dominatus fuerit pauperum.",
        "Dixit enim in corde suo: Oblitus est Deus, avertit faciem suam ne videat in finem.",
        "Exsurge, Domine Deus, exaltetur manus tua; ne obliviscaris pauperum.",
        "Propter quid irritavit impius Deum? dixit enim in corde suo: Non requiret.",
        "Vides quoniam tu laborem et dolorem consideras, ut tradas eos in manus tuas.",
        "Tibi derelictus est pauper; orphano tu eris adjutor.",
        "Contere brachium peccatoris et maligni; quaeretur peccatum illius, et non invenietur.",
        "Dominus regnabit in aeternum, et in saeculum saeculi; peribitis, gentes, de terra illius.",
        "Desiderium pauperum exaudivit Dominus; praeparationem cordis eorum audivit auris tua,",
        "Judicare pupillo et humili, ut non apponat ultra magnificare se homo super terram."
    ]
    
    // MARK: - Test Cases
    
    func testDivineIntervention() {
        let analysis = latinService.analyzePsalm(id, text: psalm9B)
        
        let interventionTerms = [
            ("exsurgo", ["exsurge", "exsurge"], "arise"), // v.1, v.16
            ("judico", ["judicentur"], "judge"), // v.1
            ("constituo", ["constitue"], "appoint"), // v.2
            ("contero", ["contere"], "crush") // v.20
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: interventionTerms)
    }
    
    func testWickedCharacteristics() {
        let analysis = latinService.analyzePsalm(id,text: psalm9B)
        
        let wickedTerms = [
            ("impius", ["impius", "impius"], "wicked"), // v.4, v.17
            ("peccator", ["peccator", "peccatoris"], "sinner"), // v.5, v.20
            ("iniquus", ["iniquus"], "unjust"), // v.5
            ("dolus", ["dolo"], "deceit"), // v.10
            ("insidia", ["insidiis" ], "ambush"), // v.11, v.12, v.13
            ("insidior", ["insidiatur", "insidiatur"], "ambush") // v.12, v.13
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: wickedTerms)
    }
    
    func testPoorAndOppressed() {
        let analysis = latinService.analyzePsalm(id, text: psalm9B)
        
        let poorTerms = [
            ("pauper", ["pauper", "pauperem", "pauperum", "pauperum"], "poor"), // v.4, v.12, v.14, v.16
            ("innocens", ["innocentem"], "innocent"), // v.11
            ("pupillus", ["pupillo"], "orphan"), // v.23
            ("humilis", ["humili"], "humble") // v.23
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: poorTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(id, text: psalm9B)
        
        let attributeTerms = [
            ("legislator", ["legislatorem"], "lawgiver"), // v.2
            ("regno", ["regnabit"], "reign"), // v.21
            ("judico", ["judicare"], "judge"), // v.23
            ("obliviscor", ["obliviscaris"], "forget") // v.16 (negative)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: attributeTerms)
    }
    
    func testEschatologicalHope() {
        let analysis = latinService.analyzePsalm(id, text: psalm9B)
        
        let hopeTerms = [
            ("aeternus", ["aeternum"], "forever"), // v.21
            ("saeculum", ["saeculum"], "age"), // v.21
            ("pereo", ["peribitis"], "perish"), // v.21
            ("exaudio", ["exaudivit"], "hear") // v.22
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: hopeTerms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}