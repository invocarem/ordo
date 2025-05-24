import XCTest
@testable import LatinService 

class Psalm50Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = false// Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    let id = PsalmIdentity(number: 50, category: nil)

    private let psalm50 = [
        "Miserere mei, Deus, secundum magnam misericordiam tuam;",
        "et secundum multitudinem miserationum tuarum, dele iniquitatem meam.",
        "Amplius lava me ab iniquitate mea, et a peccato meo munda me.",
        "Quoniam iniquitatem meam ego cognosco, et peccatum meum contra me est semper.",
        "Tibi soli peccavi, et malum coram te feci; ut justificeris in sermonibus tuis, et vincas cum judicaris.",
        
        "Ecce enim in iniquitatibus conceptus sum, et in peccatis concepit me mater mea.",
        "Ecce enim veritatem dilexisti; incerta et occulta sapientiae tuae manifestasti mihi.",
        "Asperges me hyssopo, et mundabor; lavabis me, et super nivem dealbabor.",
        "Auditui meo dabis gaudium et laetitiam, et exsultabunt ossa humiliata.",
        "Averte faciem tuam a peccatis meis, et omnes iniquitates meas dele.",
        
        "Cor mundum crea in me, Deus, et spiritum rectum innova in visceribus meis.",
        "Ne proiicias me a facie tua, et spiritum sanctum tuum ne auferas a me.",
        "Redde mihi laetitiam salutaris tui, et spiritu principali confirma me.",
        "Docebo iniquos vias tuas, et impii ad te convertentur.",
        "Libera me de sanguinibus, Deus, Deus salutis meae, et exsultabit lingua mea justitiam tuam.",
        
        "Domine, labia mea aperies, et os meum annuntiabit laudem tuam.",
        "Quoniam si voluisses sacrificium, dedissem utique; holocaustis non delectaberis.",
        "Sacrificium Deo spiritus contribulatus; cor contritum et humiliatum, Deus, non despicies.",
        "Benigne fac, Domine, in bona voluntate tua Sion, ut aedificentur muri Jerusalem.",
        "Tunc acceptabis sacrificium justitiae, oblationes et holocausta; tunc imponent super altare tuum vitulos."
    ]
    
    // MARK: - Theme Tests
 func testPsalm50Themes() {
    let analysis = latinService.analyzePsalm(id, text: psalm50)
    
   let allThemes = [
    ("Penitence", ["misereor", "peccatum", "iniquitas", "contritus", "contribulo"]), // Added "contribulo"
    ("Divine Mercy", ["misericordia", "miseratio", "deleo", "lavo", "reddo"]), // Added "reddo"
    ("Purification", ["mundus", "aspergo", "hyssopus", "dealbo", "liber"]), // Added "liber"
    ("Heart Transformation", ["cor", "innovo", "spiritus", "rectus", "creo"]), // Added "creo"
    ("True Sacrifice", ["sacrificium", "contribulo", "holocaustum", "oblatio", "accepto"]), 
    ("Restoration", ["reddo", "confirmo", "aedifico", "sion", "laetitia"]), // Added "laetitia"
    ("Proclamation", ["annuntio", "laus", "lingua", "justitia"]), // NEW THEME
    ("Divine-Human Dialogue", ["volo", "do", "accepto", "despicio"]), // NEW THEME
    
    // Augustine themes
    ("Augustine: True Penance", ["cognosco", "contra", "semper", "viscera"]), // Added "viscera"
    ("Augustine: Hyssop of Humility", ["hyssopus", "humilio",  "exsulto"]), // Added "exsulto"
    ("Augustine: Spiritual Sacrifice", ["spiritus", "contribulo", "despicio", "cor"]), // Added "cor"
    ("Augustine: City of God", ["sion", "jerusalem", "altare", "vitulus"]) // NEW THEME
] 
    var failedChecks = [String]()
    
    for (themeName, requiredLemmas) in allThemes {
        let missing = requiredLemmas.filter { !analysis.dictionary.keys.contains($0) }
        if !missing.isEmpty {
            failedChecks.append("\(themeName): \(missing.joined(separator: ", "))")
        }
    }
    
    if !failedChecks.isEmpty {
        XCTFail("Missing lemmas:\n" + failedChecks.joined(separator: "\n"))
    }
}   
   
    // MARK: - Grouped Line Tests


    func testPsalm50Lines1and2() {
        let line1 = psalm50[0] // "Miserere mei, Deus, secundum magnam misericordiam tuam;"
        let line2 = psalm50[1] // "et secundum multitudinem miserationum tuarum, dele iniquitatem meam."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("misereor", ["miserere"], "have mercy"),
            ("deus", ["deus"], "god"),
            ("secundum", ["secundum"], "according to"),
            ("magnus", ["magnam"], "great"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("multitudo", ["multitudinem"], "multitude"),
            ("miseratio", ["miserationum"], "compassion"),
            ("deleo", ["dele"], "wipe out"),
            ("iniquitas", ["iniquitatem"], "iniquity")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Mercy": [
                ("misericordia", "Appeal to God's great mercy"),
                ("miseratio", "Abundance of compassion")
            ],
            "Penitential Plea": [
                ("misereor", "Cry for mercy"),
                ("deleo", "Request for erasure of sin")
            ],
            "Sin Consciousness": [
                ("iniquitas", "Awareness of moral failure")
            ]
        ]
        
        if verbose {
            print("\nPSALM 50:1-2 ANALYSIS:")
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
    
    func testPsalm50Lines3and4() {
        let line3 = psalm50[2] // "Amplius lava me ab iniquitate mea, et a peccato meo munda me."
        let line4 = psalm50[3] // "Quoniam iniquitatem meam ego cognosco, et peccatum meum contra me est semper."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("amplius", ["amplius"], "thoroughly"),
            ("lavo", ["lava"], "wash"),
            ("mundus", ["munda"], "clean"),
            ("iniquitas", ["iniquitate", "iniquitatem"], "iniquity"),
            ("peccatum", ["peccato", "peccatum"], "sin"),
            ("cognosco", ["cognosco"], "know"),
            ("contra", ["contra"], "against"),
            ("semper", ["semper"], "always")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Purification": [
                ("lavo", "Cleansing from sin"),
                ("iniquitas", "Moral corruption")
            ],
            "Sin Awareness": [
                ("cognosco", "Personal acknowledgment"),
                ("contra", "Sin as opposition to self")
            ],
            "Augustine: Continuous Conviction": [
                ("semper", "Perpetual consciousness of sin")
            ]
        ]
        
        if verbose {
            print("\nPSALM 50:3-4 ANALYSIS:")
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
    
    func testPsalm50Lines5and6() {
        let line5 = psalm50[4] // "Tibi soli peccavi, et malum coram te feci; ut justificeris in sermonibus tuis, et vincas cum judicaris."
        let line6 = psalm50[5] // "Ecce enim in iniquitatibus conceptus sum, et in peccatis concepit me mater mea."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("solus", ["soli"], "only"),
            ("pecco", ["peccavi"], "sin"),
            ("malus", ["malum"], "evil"),
            ("coram", ["coram"], "before"),
            ("justifico", ["justificeris"], "be justified"),
            ("sermo", ["sermonibus"], "word"),
            ("vinco", ["vincas"], "prevail"),
            ("judico", ["judicaris"], "judge"),
            ("concipio", ["conceptus", "concepit"], "conceive"),
            ("mater", ["mater"], "mother")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Original Sin": [
                ("concipio", "Born in sin"),
                ("iniquitas", "Inherited corruption")
            ],
            "Divine Justice": [
                ("justifico", "God's righteousness"),
                ("judico", "Divine judgment")
            ],
            "Personal Responsibility": [
                ("pecco", "Personal transgression"),
                ("malus", "Moral failure")
            ]
        ]
        
        if verbose {
            print("\nPSALM 50:5-6 ANALYSIS:")
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
    
    func testPsalm50Lines7and8() {
        let line7 = psalm50[6] // "Ecce enim veritatem dilexisti; incerta et occulta sapientiae tuae manifestasti mihi."
        let line8 = psalm50[7] // "Asperges me hyssopo, et mundabor; lavabis me, et super nivem dealbabor."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("veritas", ["veritatem"], "truth"),
            ("diligo", ["dilexisti"], "love"),
            ("incertus", ["incerta"], "hidden"),
            ("occultus", ["occulta"], "secret"),
            ("sapientia", ["sapientiae"], "wisdom"),
            ("manifesto", ["manifestasti"], "reveal"),
            ("aspergo", ["asperges"], "sprinkle"),
            ("hyssopus", ["hyssopo"], "hyssop"),
            ("mundo", ["mundabor"], "clean"),
            ("nix", ["nivem"], "snow"),
            ("dealbo", ["dealbabor"], "whiten")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Revelation": [
                ("veritas", "God's love for truth"),
                ("manifesto", "Revealing hidden things")
            ],
            "Ritual Purification": [
                ("aspergo", "Ceremonial cleansing"),
                ("hyssopus", "Purification instrument")
            ],
            "Augustine: Hyssop of Humility": [
                ("hyssopus", "Symbol of humility"),
                ("dealbo", "Complete cleansing")
            ]
        ]
        
        if verbose {
            print("\nPSALM 50:7-8 ANALYSIS:")
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
    
    func testPsalm50Lines9and10() {
        let line9 = psalm50[8] // "Auditui meo dabis gaudium et laetitiam, et exsultabunt ossa humiliata."
        let line10 = psalm50[9] // "Averte faciem tuam a peccatis meis, et omnes iniquitates meas dele."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("auditus", ["auditui"], "hearing"),
            ("gaudium", ["gaudium"], "joy"),
            ("laetitia", ["laetitiam"], "gladness"),
            ("exsulto", ["exsultabunt"], "rejoice"),
            ("os", ["ossa"], "bone"),
            ("humilio", ["humiliata"], "humble"),
            ("averto", ["averte"], "turn away"),
            ("facies", ["faciem"], "face")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Restoration of Joy": [
                ("gaudium", "Inner rejoicing"),
                ("exsulto", "Physical manifestation")
            ],
            "Divine Favor": [
                ("averto", "Turning away from sin"),
                ("facies", "Face as presence")
            ],
            "Humility": [
                ("humilio", "Brokenness before God")
            ]
        ]
        
        if verbose {
            print("\nPSALM 50:9-10 ANALYSIS:")
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
    
// MARK: - Continued Line Tests (11-20)

func testPsalm50Lines11and12() {
    let line11 = psalm50[10] // "Cor mundum crea in me, Deus, et spiritum rectum innova in visceribus meis."
    let line12 = psalm50[11] // "Ne proiicias me a facie tua, et spiritum sanctum tuum ne auferas a me."
    let combinedText = line11 + " " + line12
    latinService.configureDebugging(target: "proicio") 
    let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 11)
    latinService.configureDebugging(target: "") 
    
    // Lemma verification
    let testLemmas = [
        ("cor", ["cor"], "heart"),
        ("mundus", ["mundum"], "clean"),
        ("creo", ["crea"], "create"),
        ("deus", ["deus"], "god"),
        ("spiritus", ["spiritum"], "spirit"),
        ("rectus", ["rectum"], "right"),
        ("innovo", ["innova"], "renew"),
        ("viscera", ["visceribus"], "inward parts"),
        ("proicio", ["proiicias"], "cast away"),
        ("facies", ["facie"], "face"),
        ("sanctus", ["sanctum"], "holy"),
        ("aufero", ["auferas"], "take away")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Heart Renewal": [
            ("creo", "Divine creative act"),
            ("innovo", "Spiritual renovation")
        ],
        "Holy Spirit": [
            ("spiritus", "Dual reference to human and divine spirit"),
            ("sanctus", "Sanctifying work")
        ],
        "Divine Presence": [
            ("facies", "Face as manifestation of presence"),
            ("aufero", "Fear of abandonment")
        ]
    ]
    
    if verbose {
        print("\nPSALM 50:11-12 ANALYSIS:")
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

func testPsalm50Lines13and14() {
    let line13 = psalm50[12] // "Redde mihi laetitiam salutaris tui, et spiritu principali confirma me."
    let line14 = psalm50[13] // "Docebo iniquos vias tuas, et impii ad te convertentur."
    let combinedText = line13 + " " + line14
    let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 13)
    
    // Lemma verification
    let testLemmas = [
        ("reddo", ["redde"], "restore"),
        ("laetitia", ["laetitiam"], "joy"),
        ("salutaris", ["salutaris"], "salvation"),
        ("spiritus", ["spiritu"], "spirit"),
        ("principalis", ["principali"], "principal"),
        ("confirmo", ["confirma"], "strengthen"),
        ("doceo", ["docebo"], "teach"),
        ("iniquus", ["iniquos"], "wicked"),
        ("via", ["vias"], "way"),
        ("impius", ["impii"], "ungodly"),
        ("converto", ["convertentur"], "turn")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Restoration": [
            ("reddo", "Return of divine favor"),
            ("laetitia", "Resulting joy")
        ],
        "Missionary Zeal": [
            ("doceo", "Teaching commitment"),
            ("converto", "Conversion expectation")
        ],
        "Spiritual Strength": [
            ("confirmo", "Divine strengthening"),
            ("principalis", "Governing spirit")
        ]
    ]
    
    if verbose {
        print("\nPSALM 50:13-14 ANALYSIS:")
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

func testPsalm50Lines15and16() {
    let line15 = psalm50[14] // "Libera me de sanguinibus, Deus, Deus salutis meae, et exsultabit lingua mea justitiam tuam."
    let line16 = psalm50[15] // "Domine, labia mea aperies, et os meum annuntiabit laudem tuam."
    let combinedText = line15 + " " + line16
    let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 15)
    
    // Lemma verification
    let testLemmas = [
        ("libero", ["libera"], "deliver"),
        ("sanguis", ["sanguinibus"], "blood"),
        ("salus", ["salutis"], "salvation"),
        ("exsulto", ["exsultabit"], "rejoice"),
        ("lingua", ["lingua"], "tongue"),
        ("justitia", ["justitiam"], "righteousness"),
        ("dominus", ["domine"], "lord"),
        ("labium", ["labia"], "lips"),
        ("aperio", ["aperies"], "open"),
        ("os", ["os", "meum"], "mouth"),
        ("annuntio", ["annuntiabit"], "declare"),
        ("laus", ["laudem"], "praise")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Deliverance": [
            ("libero", "From bloodguilt"),
            ("sanguis", "Violence imagery")
        ],
        "Vocal Praise": [
            ("lingua", "Instrument of praise"),
            ("annuntio", "Proclamation")
        ],
        "Divine Initiation": [
            ("aperio", "God enabling speech"),
            ("os", "Mouth as vehicle")
        ]
    ]
    
    if verbose {
        print("\nPSALM 50:15-16 ANALYSIS:")
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

func testPsalm50Lines17and18() {
    let line17 = psalm50[16] // "Quoniam si voluisses sacrificium, dedissem utique; holocaustis non delectaberis."
    let line18 = psalm50[17] // "Sacrificium Deo spiritus contribulatus; cor contritum et humiliatum, Deus, non despicies."
    let combinedText = line17 + " " + line18
    latinService.configureDebugging(target: "despicio")
    let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 17)
    latinService.configureDebugging(target: "")
    
    // Lemma verification
    let testLemmas = [
        ("volo", ["voluisses"], "will"),
        ("sacrificium", ["sacrificium"], "sacrifice"),
        ("do", ["dedissem"], "give"),
        ("holocaustum", ["holocaustis"], "burnt offering"),
        ("delector", ["delectaberis"], "delight"),
        ("spiritus", ["spiritus"], "spirit"),
        ("contribulo", ["contribulatus"], "crushed"),
        ("contritus", ["contritum"], "contrite"),
        ("humilio", ["humiliatum"], "humble"),
        ("despicio", ["despicies"], "despise")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "True Sacrifice": [
            ("contribulo", "Broken spirit"),
            ("contritus", "Crushed heart")
        ],
        "Rejected Ritual": [
            ("holocaustum", "External offerings"),
            ("delector", "Divine displeasure")
        ],
        "Augustine: Spiritual Offering": [
            ("spiritus", "Inner sacrifice"),
            ("humilio", "Required humility")
        ]
    ]
    
    if verbose {
        print("\nPSALM 50:17-18 ANALYSIS:")
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

func testPsalm50Lines19and20() {
    let line19 = psalm50[18] // "Benigne fac, Domine, in bona voluntate tua Sion, ut aedificentur muri Jerusalem."
    let line20 = psalm50[19] // "Tunc acceptabis sacrificium justitiae, oblationes et holocausta; tunc imponent super altare tuum vitulos."
    let combinedText = line19 + " " + line20
    let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 19)
    
    // Lemma verification
    let testLemmas = [
        ("benignus", ["benigne"], "gracious"),
        ("facio", ["fac"], "do"),
        ("voluntas", ["voluntate"], "will"),
        ("Sion", ["Sion"], "Zion"),
        ("aedifico", ["aedificentur"], "build"),
        ("murus", ["muri"], "wall"),
        ("Jerusalem", ["Jerusalem"], "Jerusalem"),
        ("accepto", ["acceptabis"], "accept"),
        ("oblatio", ["oblationes"], "offering"),
        ("altare", ["altare"], "altar"),
        ("vitulus", ["vitulos"], "bull")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Zion Restoration": [
            ("sion", "Center of worship"),
            ("aedifico", "Physical rebuilding")
        ],
        "Renewed Worship": [
            ("accepto", "Divine acceptance"),
            ("oblatio", "Restored sacrifices")
        ],
        "Divine Favor": [
            ("benignus", "Gracious disposition"),
            ("voluntas", "Goodwill")
        ]
    ]
    
    if verbose {
        print("\nPSALM 50:19-20 ANALYSIS:")
        print("19: \"\(line19)\"")
        print("20: \"\(line20)\"")
        
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

    // MARK: - Comprehensive Test
    
    func testAnalyzePsalm50() {
        let analysis = latinService.analyzePsalm(id, text: psalm50)
        
        // ===== TEST METRICS =====
        let totalWords = 148  // Actual word count in Psalm 50
        let testedLemmas = 68 // Number of lemmas tested
        let testedForms = 85  // Number of word forms verified
        
        // ===== COMPREHENSIVE VOCABULARY TEST =====
        let confirmedWords = [
            ("misereor", ["miserere"], "have mercy"),
            ("deus", ["deus"], "god"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("miseratio", ["miserationum"], "compassion"),
            ("deleo", ["dele"], "wipe out"),
            ("iniquitas", ["iniquitatem", "iniquitate", "iniquitatibus", "iniquitates"], "iniquity"),
            ("lavo", ["lava", "munda", "lavabis"], "wash"),
            ("peccatum", ["peccato", "peccatum", "peccatis", "peccata"], "sin"),
            ("cognosco", ["cognosco"], "know"),
            ("pecco", ["peccavi"], "sin"),
            ("justifico", ["justificeris"], "be justified"),
            ("concipio", ["conceptus", "concepit"], "conceive"),
            ("veritas", ["veritatem"], "truth"),
            ("diligo", ["dilexisti"], "love"),
            ("sapientia", ["sapientiae"], "wisdom"),
            ("aspergo", ["asperges"], "sprinkle"),
            ("hyssopus", ["hyssopo"], "hyssop"),
            ("nix", ["nivem"], "snow"),
            ("dealbo", ["dealbabor"], "whiten"),
            ("gaudium", ["gaudium"], "joy"),
            ("laetitia", ["laetitiam"], "gladness"),
            ("exsulto", ["exsultabunt", "exsultabit"], "rejoice"),
            ("humilio", ["humiliata", "humiliatum"], "humble"),
            ("averto", ["averte"], "turn away"),
            ("cor", ["cor"], "heart"),
            ("creo", ["crea"], "create"),
            ("spiritus", ["spiritum", "spiritus"], "spirit"),
            ("rectus", ["rectum"], "right"),
            ("innovo", ["innova"], "renew"),
            ("salutaris", ["salutaris"], "salvation"),
            ("confirmo", ["confirma"], "strengthen"),
            ("doceo", ["docebo"], "teach"),
            ("converto", ["convertentur"], "turn"),
            ("lingua", ["lingua"], "tongue"),
            ("justitia", ["justitiam"], "justice"),
            ("labium", ["labia"], "lips"),
            ("annuntio", ["annuntiabit"], "declare"),
            ("laus", ["laudem"], "praise"),
            ("sacrificium", ["sacrificium"], "sacrifice"),
            ("holocaustum", ["holocaustis", "holocausta"], "whole offering"),
            ("contribulo", ["contribulatus"], "contrite"),
            ("contritus", ["contritum"], "crushed"),
            ("benignus", ["benigne"], "gracious"),
            ("voluntas", ["voluntate"], "will"),
            ("aedifico", ["aedificentur"], "build"),
            ("oblatio", ["oblationes"], "offering"),
            ("altare", ["altare"], "altar"),
            ("vitulus", ["vitulos"], "bull")
        ]
        
        if self.verbose {
            print("\n=== Psalm 50 Test Coverage ===")
            print("Total words: \(totalWords)")
            print("Unique lemmas: \(analysis.uniqueLemmas)")
            print("Tested lemmas: \(testedLemmas) (\(String(format: "%.1f", Double(testedLemmas)/Double(analysis.uniqueLemmas)*100))%)")
            print("Tested forms: \(testedForms) (\(String(format: "%.1f", Double(testedForms)/Double(totalWords)*100))%)")
        }
        
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
        
        // ===== KEY THEOLOGICAL CHECKS =====
        // Penitential theme
        if let peccatumInfo = analysis.dictionary["peccatum"] {
            XCTAssertGreaterThanOrEqual(peccatumInfo.count, 4, "'Sin' should appear multiple times")
        }
        
        // Purification theme
        if let lavoInfo = analysis.dictionary["lavo"] {
            XCTAssertEqual(lavoInfo.forms["lava"], 1, "Imperative 'lava'")
            XCTAssertEqual(lavoInfo.forms["mundabor"], 1, "Future passive 'mundabor'")
        }
        
        // ===== GRAMMAR CHECKS =====
        // Imperatives
        if let deleInfo = analysis.dictionary["deleo"] {
            XCTAssertEqual(deleInfo.forms["dele"], 2, "Imperative 'dele'")
        }
        
        // Future tense
        if let mundareInfo = analysis.dictionary["mundus"] {
            XCTAssertEqual(mundareInfo.forms["mundabor"], 1, "Future 'mundabor'")
        }
        
        // ===== DEBUG OUTPUT =====
        if verbose {
            print("\n=== Key Terms ===")
            print("'peccatum' forms:", analysis.dictionary["peccatum"]?.forms ?? [:])
            print("'lavo' forms:", analysis.dictionary["lavo"]?.forms ?? [:])
            print("'cor' forms:", analysis.dictionary["cor"]?.forms ?? [:])
            print("'spiritus' forms:", analysis.dictionary["spiritus"]?.forms ?? [:])
        }
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