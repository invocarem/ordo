import XCTest
@testable import LatinService

class Psalm89Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let id = PsalmIdentity(number: 89, category: nil)
    let psalm89 = [
         "Domine, refugium factus es nobis a generatione et progenie.",
                "Priusquam montes fierent, aut formaretur terra et orbis: a saeculo et usque in saeculum tu es, Deus.",
                "Ne avertas hominem in humilitatem: et dixisti: Convertimini, filii hominum.",
                "Quoniam mille anni ante oculos tuos, tamquam dies hesterna quae praeteriit: et custodia in nocte.",
                "Quae pro nihilo habentur, eorum anni erunt.",
                "Mane sicut herba transeat; mane floreat, et transeat: vespere decidat, induret, et arescat.",
                "Quia defecimus in ira tua, et in furore tuo turbati sumus.",
                "Posuisti iniquitates nostras in conspectu tuo: saeculum nostrum in illuminatione vultus tui.",
                "Quoniam omnes dies nostri defecerunt: et in ira tua defecimus. Anni nostri sicut aranea meditabuntur.",
                "Dies annorum nostrorum in ipsis septuaginta anni. Si autem in potentatibus octoginta anni: et amplius eorum labor et dolor.",
                "Quoniam supervenit mansuetudo, et corripiemur.",
                "Quis novit potestatem irae tuae? et prae timore tuo iram tuam dinumerare?",
                "Dextera tua sic notam fac: et eruditos corde in sapientia.",
                "Convertere, Domine, usquequo? et deprecabilis esto super servos tuos.",
                "Repleti sumus mane misericordia tua: et exsultavimus, et delectati sumus omnibus diebus nostris.",
                "Laetati sumus pro diebus quibus nos humiliasti: annis quibus vidimus mala.",
                "Respice in servos tuos, et in opera tua: et dirige filios eorum.",
                "Et sit splendor Domini Dei nostri super nos: et opera manuum nostrarum dirige super nos: et opus manuum nostrarum dirige."        
    ]
    
    // MARK: - Test Cases
    // MARK: - Grouped Line Tests for Psalm 89
func testPsalm89Lines1and2() {
    let line1 = psalm89[0] // "Domine, refugium factus es nobis a generatione et progenie."
    let line2 = psalm89[1] // "Priusquam montes fierent, aut formaretur terra et orbis: a saeculo et usque in saeculum tu es, Deus."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("refugium", ["refugium"], "refuge"),
        ("generatio", ["generatione"], "generation"),
        ("progenies", ["progenie"], "offspring"),
        ("mons", ["montes"], "mountain"),
        ("formo", ["formaretur"], "form"),
        ("terra", ["terra"], "earth"),
        ("orbis", ["orbis"], "world"),
        ("saeculum", ["saeculo", "saeculum"], "age")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Eternity": [
            ("saeculum", "From everlasting to everlasting"),
            ("mons", "Pre-existence before creation")
        ],
        "Divine Protection": [
            ("refugium", "God as eternal refuge"),
            ("generatio", "Protection spanning generations")
        ],
        "Creation Imagery": [
            ("formo", "Formation of the earth"),
            ("orbis", "Cosmic scope of creation")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm89Lines3and4() {
    let line3 = psalm89[2] // "Ne avertas hominem in humilitatem: et dixisti: Convertimini, filii hominum."
    let line4 = psalm89[3] // "Quoniam mille anni ante oculos tuos, tamquam dies hesterna quae praeteriit: et custodia in nocte."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("averto", ["avertas"], "turn away"),
        ("humilitas", ["humilitatem"], "humility"),
        ("converto", ["convertimini"], "return"),
        ("mille", ["mille"], "thousand"),
        ("oculus", ["oculos"], "eye"),
        ("dies", ["dies"], "day"),
        ("hesternus", ["hesterna"], "yesterday"),
        ("praetereo", ["praeteriit"], "pass by"),
        ("custodia", ["custodia"], "watch")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Perspective": [
            ("mille", "A thousand years as one day"),
            ("oculus", "God's eternal viewpoint")
        ],
        "Human Condition": [
            ("humilitas", "Mortality and lowliness"),
            ("converto", "Call to repentance")
        ],
        "Temporal Imagery": [
            ("dies", "Ephemeral nature of time"),
            ("custodia", "Night watch as metaphor")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm89Lines5and6() {
    let line5 = psalm89[4] // "Quae pro nihilo habentur, eorum anni erunt."
    let line6 = psalm89[5] // "Mane sicut herba transeat; mane floreat, et transeat: vespere decidat, induret, et arescat."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("nihil", ["nihilo"], "nothing"),
        ("annus", ["anni"], "year"),
        ("mane", ["mane"], "morning"),
        ("herba", ["herba"], "grass"),
        ("transeo", ["transeat"], "pass away"),
        ("floreo", ["floreat"], "flourish"),
        ("vesper", ["vespere"], "evening"),
        ("decido", ["decidat"], "fall"),
        ("induro", ["induret"], "harden"),
        ("aresco", ["arescat"], "wither")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Human Transience": [
            ("herba", "Grass as mortality symbol"),
            ("transeo", "Brief existence")
        ],
        "Daily Cycle": [
            ("mane", "Morning flourishing"),
            ("vesper", "Evening decline")
        ],
        "Vanity Motif": [
            ("nihil", "Years counted as nothing"),
            ("floreo", "Temporary beauty")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

// ... (Additional tests for lines 7-8, 9-10, etc. following the same pattern)
func testPsalm89Lines7and8() {
    let line7 = psalm89[6] // "Quia defecimus in ira tua, et in furore tuo turbati sumus."
    let line8 = psalm89[7] // "Posuisti iniquitates nostras in conspectu tuo: saeculum nostrum in illuminatione vultus tui."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("deficio", ["defecimus"], "fail"),
        ("ira", ["ira"], "wrath"),
        ("furor", ["furore"], "fury"),
        ("turbo", ["turbati"], "disturb"),
        ("pono", ["posuisti"], "place"),
        ("iniquitas", ["iniquitates"], "iniquity"),
        ("conspectus", ["conspectu"], "sight"),
        ("illuminatio", ["illuminatione"], "light"),
        ("vultus", ["vultus"], "face")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Judgment": [
            ("ira", "Experiencing God's wrath"),
            ("furor", "Intensity of divine displeasure")
        ],
        "Human Frailty": [
            ("deficio", "Moral failure under pressure"),
            ("turbo", "Emotional disturbance")
        ],
        "Divine Light": [
            ("illuminatio", "Counterpoint to wrath"),
            ("vultus", "Face as source of grace")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm89Lines9and10() {
    let line9 = psalm89[8] // "Quoniam omnes dies nostri defecerunt: et in ira tua defecimus. Anni nostri sicut aranea meditabuntur."
    let line10 = psalm89[9] // "Dies annorum nostrorum in ipsis septuaginta anni. Si autem in potentatibus octoginta anni: et amplius eorum labor et dolor."
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("dies", ["dies"], "day"),
        ("deficio", ["defecerunt", "defecimus"], "fail"),
        ("ira", ["ira"], "wrath"),
        ("aranea", ["aranea"], "spider's web"),
        ("meditor", ["meditabuntur"], "meditate"),
        ("septuaginta", ["septuaginta"], "seventy"),
        ("potentatus", ["potentatibus"], "power"),
        ("octoginta", ["octoginta"], "eighty"),
        ("labor", ["labor"], "toil"),
        ("dolor", ["dolor"], "pain")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Mortality": [
            ("aranea", "Life's fragility like spiderweb"),
            ("septuaginta", "Biblical lifespan measure")
        ],
        "Suffering": [
            ("labor", "Inevitable toil"),
            ("dolor", "Existential pain")
        ],
        "Divine Perspective": [
            ("meditor", "Human years as fleeting thought"),
            ("potentatus", "Exceptional strength still limited")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm89Lines11and12() {
    let line11 = psalm89[10] // "Quoniam supervenit mansuetudo, et corripiemur."
    let line12 = psalm89[11] // "Quis novit potestatem irae tuae? et prae timore tuo iram tuam dinumerare?"
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("mansuetudo", ["mansuetudo"], "gentleness"),
        ("corripio", ["corripiemur"], "chastened"),
        ("potestas", ["potestatem"], "power"),
        ("ira", ["irae", "iram"], "wrath"),
        ("timor", ["timore"], "fear"),
        ("dinumero", ["dinumerare"], "calculate")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Paradox": [
            ("mansuetudo", "Unexpected gentleness"),
            ("ira", "Contrasting wrath")
        ],
        "Human Limitation": [
            ("dinumero", "Inability to quantify wrath"),
            ("timor", "Appropriate fear response")
        ],
        "Discipline": [
            ("corripio", "Chastening as correction"),
            ("potestas", "God's absolute authority")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:11-12 ANALYSIS:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm89Lines13and14() {
    let line13 = psalm89[12] // "Dextera tua sic notam fac: et eruditos corde in sapientia."
    let line14 = psalm89[13] // "Convertere, Domine, usquequo? et deprecabilis esto super servos tuos."
    let combinedText = line13 + " " + line14
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("dextera", ["dextera"], "right hand"),
        ("nota", ["notam"], "mark"),
        ("eruditus", ["eruditos"], "instruct"),
        ("cor", ["corde"], "heart"),
        ("sapientia", ["sapientia"], "wisdom"),
        ("converto", ["convertere"], "turn back"),
        ("usquequo", ["usquequo"], "how long"),
        ("deprecabilis", ["deprecabilis"], "appeasable"),
        ("servus", ["servos"], "servant")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Instruction": [
            ("erudio", "Heart education"),
            ("sapientia", "Wisdom as goal")
        ],
        "Petition": [
            ("usquequo", "Impatient plea"),
            ("deprecabilis", "Request for mercy")
        ],
        "Covenant Symbols": [
            ("dextera", "God's powerful hand"),
            ("nota", "Mark of ownership")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:13-14 ANALYSIS:")
        print("13: \"\(line13)\"")
        print("14: \"\(line14)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm89Lines15and16() {
    let line15 = psalm89[14] // "Repleti sumus mane misericordia tua: et exsultavimus, et delectati sumus omnibus diebus nostris."
    let line16 = psalm89[15] // "Laetati sumus pro diebus quibus nos humiliasti: annis quibus vidimus mala."
    let combinedText = line15 + " " + line16
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("repleo", ["repleti"], "fill"),
        ("mane", ["mane"], "morning"),
        ("misericordia", ["misericordia"], "mercy"),
        ("exsulto", ["exsultavimus"], "rejoice"),
        ("delector", ["delectati"], "delight"),
        ("laetor", ["laetati"], "glad"),
        ("humilio", ["humiliasti"], "humble"),
        ("malum", ["mala"], "evil")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Mercy": [
            ("misericordia", "Morning renewal metaphor"),
            ("repleo", "Fullness of grace")
        ],
        "Paradoxical Joy": [
            ("laetor", "Joy through suffering"),
            ("humilio", "Value in humbling")
        ],
        "Temporal Blessing": [
            ("mane", "Daily renewal"),
            ("malum", "Retrospective on trials")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:15-16 ANALYSIS:")
        print("15: \"\(line15)\"")
        print("16: \"\(line16)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}


func testPsalm89Lines17and18() {
    let line17 = psalm89[16] // "Respice in servos tuos, et in opera tua: et dirige filios eorum."
    let line18 = psalm89[17] // "Et sit splendor Domini Dei nostri super nos: et opera manuum nostrarum dirige super nos: et opus manuum nostrarum dirige."
    let combinedText = line17 + " " + line18
    let analysis = latinService.analyzePsalm(id, text: combinedText)
    
    // Lemma verification
    let testLemmas = [
        ("respicio", ["respice"], "look upon"),
        ("servus", ["servos"], "servant"),
        ("opus", ["opera", "opus"], "work"),
        ("dirigo", ["dirige"], "direct"),
        ("splendor", ["splendor"], "radiance"),
        ("manus", ["manuum"], "hand")
    ]
    
    // Thematic analysis
    let expectedThemes = [
        "Divine Favor": [
            ("splendor", "Request for God's radiance"),
            ("respicio", "Petition for attention")
        ],
        "Covenantal Blessing": [
            ("servus", "Servant relationship"),
            ("filus", "Generational blessing")
        ],
        "Human Labor": [
            ("opus", "Works under divine guidance"),
            ("manus", "Human effort directed by God")
        ]
    ]
    
    if verbose {
        print("\nPSALM 89:17-18 ANALYSIS:")
        print("17: \"\(line17)\"")
        print("18: \"\(line18)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
        
        print("\nTHEMATIC ANALYSIS:")
        for (theme, elements) in expectedThemes {
            print("\(theme.uppercased()):")
            elements.forEach { lemma, description in
                print("- \(lemma): \(description)")
            }
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}
    
    func testTemporalVocabulary() {
        let analysis = latinService.analyzePsalm(id, text: psalm89)
        
        let timeTerms = [
            ("saeculum", ["saeculum", "saeculo"], "age"),
            ("generatio", ["generatione"], "generation"),
            ("progenies", ["progenie"], "offspring"),
            ("mille", ["mille"], "thousand"),
            ("custodia", ["custodia"], "watch")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: timeTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(id, text: psalm89)
        
        let divineTerms = [
            ("refugium", ["refugium"], "refuge"),
            ("mansuetudo", ["mansuetudo"], "gentleness"),
            ("splendor", ["splendor"], "brightness"),
            ("dextera", ["dextera"], "right hand"),
            ("illuminatio", ["illuminatione"], "light")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testMortalityMetaphors() {
        let analysis = latinService.analyzePsalm(id, text: psalm89)
        
        let mortalTerms = [
            ("herba", ["herba"], "grass"),
            ("aranea", ["aranea"], "spider's web"),
            ("floreo", ["floreat"], "to bloom")
          
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: mortalTerms)
    }
    
    func testStructuralVerbs() {
        let analysis = latinService.analyzePsalm(id, text: psalm89)
        
        let keyVerbs = [
            ("formo", ["formaretur"], "form"),
            ("deficio", ["defecimus", "defecerunt"], "fail"),
            ("dinumero", ["dinumerare"], "reckon"),
            ("dirigo", ["dirige"], "direct")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                print("\n❌ MISSING LEMMA IN DICTIONARY: \(lemma)")
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage
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