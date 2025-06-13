import XCTest
@testable import LatinService

class Psalm17BTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 17, category: "b")
    // MARK: - Test Data
    let psalm17B = [
        "Cum sancto sanctus eris, et cum viro innocente innocens eris,",
        "et cum electo electus eris, et cum perverso perverteris.",
        "Quoniam tu populum humilem salvum facies, et oculos superborum humiliabis.",
        "Quoniam tu illuminas lucernam meam, Domine; Deus meus, illumina tenebras meas.",
        "Quoniam in te eripiar a tentatione, et in Deo meo transgrediar murum.",
        "Deus meus, impolluta via ejus; eloquia Domini igne examinata;",
        "protector est omnium sperantium in se.",
        "Quoniam quis Deus praeter Dominum? aut quis Deus praeter Deum nostrum?",
        "Deus qui praecinxit me virtute, et posuit immaculatam viam meam;",
        "qui perfecit pedes meos tamquam cervorum, et super excelsa statuens me;",
        "qui docet manus meas ad praelium, et posuisti arcum aereum brachia mea.",
        "Et dedisti mihi protectionem salutis tuae, et dextera tua suscepit me:",
        "et disciplina tua correxit me in finem, et disciplina tua ipsa me docebit.",
        "Dilatasti gressus meos subtus me, et non sunt infirmata vestigia mea.",
        "Persequar inimicos meos, et comprehendam illos; et non convertar donec deficiant.",
        "Conteram illos, nec poterunt stare; cadent subtus pedes meos.",
        "Et praecinxisti me virtute ad bellum; supplantasti insurgentes in me subtus me.",
        "Et inimicos meos dedisti mihi dorsum, et odientes me disperdidisti.",
        "Clamaverunt, nec erat qui salvos faceret; ad Dominum, nec exaudivit eos.",
        "Et comminuam eos ut pulverem ante faciem venti; ut lutum platearum delebo eos.",
        "Eripies me de contradictionibus populi; constitues me in caput gentium.",
        "Populus quem non cognovi servivit mihi; in auditu auris obedivit mihi.",
        "Filii alieni mentiti sunt mihi, filii alieni inveterati sunt,",
        "et claudicaverunt a semitis suis.",
        "Vivit Dominus, et benedictus Deus meus, et exaltetur Deus salutis meae.",
        "Deus qui dat vindictas mihi, et subjicit populos sub me,",
        "liberator meus de inimicis meis iracundis. Et ab insurgentibus in me exaltabis me;",
        "a viro iniquo eripies me.",
        "Propterea confitebor tibi in nationibus, Domine, et nomini tuo psalmum cantabo:",
        "magnificans salutes regis ejus, et faciens misericordiam christo suo David, et semini ejus usque in saeculum."
    ]
    
    // MARK: - Test Cases
// MARK: - Grouped Line Tests for Psalm 17B
func testPsalm17BLines1and2() {
    let line1 = psalm17B[0] // "Cum sancto sanctus eris, et cum viro innocente innocens eris,"
    let line2 = psalm17B[1] // "et cum electo electus eris, et cum perverso perverteris."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("sanctus", ["sancto", "sanctus"], "holy"),
        ("vir", ["viro"], "man"),
        ("innocens", ["innocente", "innocens"], "blameless"),
        ("electus", ["electo", "electus"], "chosen"),
        ("perversus", ["perverso"], "twisted"),
        ("perverto", ["perverteris"], "overturn")
    ]
   let expectedThemes = [
        "Divine Reciprocity": [
            ("sanctus", "God mirrors holiness with the holy"),
            ("innocens", "God mirrors innocence with the innocent"),
            ("electus", "God mirrors election with the chosen")
        ],
        "Divine Justice": [
            ("perversus", "God opposes the twisted"),
            ("perverto", "God overturns the perverse")
        ]
    ]

    if verbose {
        print("\nPSALM 17B:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    if verbose {
        print("\nTHEMATIC ELEMENTS:")
        expectedThemes.forEach { theme, elements in
            print("\(theme):")
            elements.forEach { lemma, description in
                print("  - \(lemma): \(description)")
            }
        }
    }

}

func testPsalm17BLines3and4() {
    let line3 = psalm17B[2] // "Quoniam tu populum humilem salvum facies, et oculos superborum humiliabis."
    let line4 = psalm17B[3] // "Quoniam tu illuminas lucernam meam, Domine; Deus meus, illumina tenebras meas."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("humilis", ["humilem"], "humble"),
        ("salvus", ["salvum"], "safe"),
        ("oculus", ["oculos"], "eye"),
        ("superbus", ["superborum"], "proud"),
        ("humilio", ["humiliabis"], "humble"),
        ("illumino", ["illuminas", "illumina"], "light"),
        ("lucerna", ["lucernam"], "lamp"),
        ("tenebrae", ["tenebras"], "darkness")
    ]
    let expectedThemes = [
        "Divine Protection": [
            ("salvus", "God saves the humble"),
            ("humilio", "God humbles the proud")
        ],
        "Divine Illumination": [
            ("illumino", "God provides light"),
            ("lucerna", "God as source of guidance"),
            ("tenebrae", "Transformation of darkness")
        ],
        "Social Reversal": [
            ("humilis", "Elevation of the lowly"),
            ("superbus", "Humiliation of the proud")
        ]
    ]
    if verbose {
        print("\nPSALM 17B:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
    if verbose {
        print("\nTHEMATIC ELEMENTS:")
        expectedThemes.forEach { theme, elements in
            print("\(theme):")
            elements.forEach { lemma, description in
                print("  - \(lemma): \(description)")
            }
        }
    }
}

func testPsalm17BLines5and6() {
    let line5 = psalm17B[4] // "Quoniam in te eripiar a tentatione, et in Deo meo transgrediar murum."
    let line6 = psalm17B[5] // "Deus meus, impolluta via ejus; eloquia Domini igne examinata;"
    let combinedText = line5 + " " + line6
    latinService.configureDebugging(target: "transgredior")
    let analysis = latinService.analyzePsalm(text: combinedText)
    latinService.configureDebugging(target: "")
    
    let testLemmas = [
        ("eripio", ["eripiar"], "rescue"),
        ("tentatio", ["tentatione"], "temptation"),
        ("transgredior", ["transgrediar"], "cross over"),
        ("murus", ["murum"], "wall"),
        ("impollutus", ["impolluta"], "pure"),
        ("via", ["via"], "way"),
        ("eloquium", ["eloquia"], "word"),
        ("ignis", ["igne"], "fire"),
        ("examino", ["examinata"], "test")
    ]
    
    if verbose {
        print("\nPSALM 17B:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
}

func testPsalm17BLines7and8() {
    let line7 = psalm17B[6] // "protector est omnium sperantium in se."
    let line8 = psalm17B[7] // "Quoniam quis Deus praeter Dominum? aut quis Deus praeter Deum nostrum?"
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("protector", ["protector"], "protector"),
        ("omnis", ["omnium"], "all"),
        ("spero", ["sperantium"], "hope"),
        ("deus", ["deus", "deum"], "god"),
        ("dominus", ["dominum"], "lord"),
        ("noster", ["nostrum"], "our")
    ]
    
    if verbose {
        print("\nPSALM 17B:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
}

// MARK: - Additional Test Cases for Psalm 17B

func testPsalm17BLines9and10() {
    let line9 = psalm17B[8] // "Deus qui praecinxit me virtute, et posuit immaculatam viam meam;"
    let line10 = psalm17B[9] // "qui perfecit pedes meos tamquam cervorum, et super excelsa statuens me;"
    let combinedText = line9 + " " + line10

    latinService.configureDebugging(target: "perfecio")
    let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
    
    let testLemmas = [
        ("praecingo", ["praecinxit"], "gird"),
        ("virtus", ["virtute"], "strength"),
        ("pono", ["posuit"], "place"),
        ("immaculatus", ["immaculatam"], "spotless"),
        ("via", ["viam"], "way"),
        ("perficio", ["perfecit"], "perfect"),
        ("pes", ["pedes"], "foot"),
        ("cervus", ["cervorum"], "deer"),
        ("excelsum", ["excelsa"], "height"),
        ("statuo", ["statuens"], "set up")
    ]
    
    let expectedThemes = [
        "Divine Empowerment": [
            ("praecingo", "God girds with strength"),
            ("virtus", "Divine strength given to the faithful")
        ],
        "Divine Guidance": [
            ("immaculatus", "God provides a blameless path"),
            ("via", "God's way is perfect")
        ],
        "Transformation": [
            ("perficio", "God perfects human weakness"),
            ("cervus", "Given agility like a deer"),
            ("excelsum", "Elevated to high places")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:9-10 ANALYSIS:")
        //print("9: \"\(line9)\"")
        //print("10: \"\(line10)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm17BLines11and12() {
    let line11 = psalm17B[10] // "qui docet manus meas ad praelium, et posuisti arcum aereum brachia mea."
    let line12 = psalm17B[11] // "Et dedisti mihi protectionem salutis tuae, et dextera tua suscepit me:"
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("doceo", ["docet"], "teach"),
        ("manus", ["manus"], "hand"),
        ("praelium", ["praelium"], "battle"),
        ("pono", ["posuisti"], "place"),
        ("arcus", ["arcum"], "bow"),
        ("aereus", ["aereum"], "bronze"),
        ("brachium", ["brachia"], "arm"),
        ("protego", ["protectionem"], "protection"),
        ("salus", ["salutis"], "salvation"),
        ("dexter", ["dextera"], "right hand"),
        ("suscipio", ["suscepit"], "support")
    ]
    
    let expectedThemes = [
        "Divine Training": [
            ("doceo", "God teaches warfare"),
            ("praelium", "Preparation for spiritual battle")
        ],
        "Divine Armor": [
            ("arcus", "God provides weapons"),
            ("aereus", "Divine armor is strong")
        ],
        "Divine Support": [
            ("protego", "God's protective covering"),
            ("dexter", "God's right hand sustains")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:11-12 ANALYSIS:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm17BLines13and14() {
    let line13 = psalm17B[12] // "et disciplina tua correxit me in finem, et disciplina tua ipsa me docebit."
    let line14 = psalm17B[13] // "Dilatasti gressus meos subtus me, et non sunt infirmata vestigia mea."
    let combinedText = line13 + " " + line14
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("disciplina", ["disciplina"], "discipline"),
        ("corrigo", ["correxit"], "correct"),
        ("doceo", ["docebit"], "teach"),
        ("dilato", ["dilatasti"], "enlarge"),
        ("gressus", ["gressus"], "step"),
        ("infirmo", ["infirmata"], "weaken"),
        ("vestigium", ["vestigia"], "footstep")
    ]
    
    let expectedThemes = [
        "Divine Discipline": [
            ("disciplina", "God's correction is instructive"),
            ("corrigo", "God's discipline brings alignment")
        ],
        "Divine Empowerment": [
            ("dilato", "God enlarges capacity"),
            ("gressus", "Steadfastness in walking")
        ],
        "Stability": [
            ("infirmo", "Divine protection from weakness"),
            ("vestigium", "Firm footing in God's way")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:13-14 ANALYSIS:")
        print("13: \"\(line13)\"")
        print("14: \"\(line14)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm17BLines15to18() {
    let lines = [psalm17B[14], psalm17B[15], psalm17B[16], psalm17B[17]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("persequor", ["persequar"], "pursue"),
        ("inimicus", ["inimicos"], "enemy"),
        ("comprehendo", ["comprehendam"], "seize"),
        ("contero", ["conteram"], "crush"),
        ("cado", ["cadent"], "fall"),
        ("supplanto", ["supplantasti"], "trip up"),
        ("insurgo", ["insurgentes"], "rise up"),
        ("odium", ["odientes"], "hatred"),
        ("disperdo", ["disperdidisti"], "destroy")
    ]
    
    let expectedThemes = [
        "Divine Victory": [
            ("persequor", "Active pursuit of enemies"),
            ("comprehendo", "Complete victory over opposition")
        ],
        "Divine Judgment": [
            ("contero", "Total destruction of foes"),
            ("disperdo", "Final elimination of adversaries")
        ],
        "Divine Protection": [
            ("supplanto", "God undermines attackers"),
            ("insurgo", "Protection against uprising")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:15-18 ANALYSIS:")
        print("15-18: \"\(lines)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm17BLines19to22() {
    let lines = [psalm17B[18], psalm17B[19], psalm17B[20], psalm17B[21]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("clamo", ["clamaverunt"], "cry out"),
        ("salvus", ["salvos"], "save"),
        ("comminuo", ["comminuam"], "crush"),
        ("pulvis", ["pulverem"], "dust"),
        ("ventus", ["venti"], "wind"),
        ("lutum", ["lutum"], "mud"),
        ("platea", ["platearum"], "street"),
        ("contradictio", ["contradictionibus"], "opposition"),
        ("caput", ["caput"], "head"),
        ("gens", ["gentium"], "nation")
    ]
    
    let expectedThemes = [
        "Divine Sovereignty": [
            ("clamo", "Futility of crying to other gods"),
            ("salvus", "Exclusive salvation in Yahweh")
        ],
        "Divine Judgment": [
            ("comminuo", "Complete reduction of enemies"),
            ("pulvis", "Insignificance of God's foes")
        ],
        "Divine Exaltation": [
            ("caput", "Elevation to leadership"),
            ("gens", "Authority over nations")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:19-22 ANALYSIS:")
        print("19-22: \"\(lines)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm17BLines23to26() {
    let lines = [psalm17B[22], psalm17B[23], psalm17B[24], psalm17B[25]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("alienus", ["alieni"], "foreign"),
        ("mentior", ["mentiti"], "deceive"),
        ("invetero", ["inveterati"], "grow old"),
        ("claudico", ["claudicaverunt"], "limp"),
        ("semita", ["semitis"], "path"),
        ("vivo", ["vivit"], "live"),
        ("benedico", ["benedictus"], "bless"),
        ("exalto", ["exaltetur"], "exalt"),
        ("vindicta", ["vindictas"], "vengeance"),
        ("subicio", ["subjicit"], "subdue")
    ]
    
    let expectedThemes = [
        "False Allegiance": [
            ("alienus", "Foreigners' insincerity"),
            ("mentior", "Deceptive submission")
        ],
        "Divine Faithfulness": [
            ("vivo", "Yahweh's enduring life"),
            ("benedico", "God as source of blessing")
        ],
        "Divine Justice": [
            ("vindicta", "God executes justice"),
            ("subicio", "Divine subjugation of enemies")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:23-26 ANALYSIS:")
        print("23-26: \"\(lines)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

func testPsalm17BLines27to29() {
    let lines = [psalm17B[26], psalm17B[27], psalm17B[28], psalm17B[29]].joined(separator: " ")
    let analysis = latinService.analyzePsalm(text: lines)
    
    let testLemmas = [
        ("liberator", ["liberator"], "deliverer"),
        ("iracundus", ["iracundis"], "anger"),
        ("eripio", ["eripies"], "rescue"),
        ("iniquus", ["iniquo"], "unjust"),
        ("confiteor", ["confitebor"], "praise"),
        ("natio", ["nationibus"], "nation"),
        ("psalmus", ["psalmum"], "psalm"),
        ("magnifico", ["magnificans"], "magnify"),
        ("misericordia", ["misericordiam"], "mercy"),
        ("saeculum", ["saeculum"], "age")
    ]
    
    let expectedThemes = [
        "Divine Deliverance": [
            ("liberator", "God as ultimate rescuer"),
            ("eripio", "Salvation from wickedness")
        ],
        "Universal Praise": [
            ("confiteor", "Public thanksgiving"),
            ("natio", "Witness among the nations")
        ],
        "Covenant Faithfulness": [
            ("misericordia", "God's loyal love"),
            ("saeculum", "Everlasting covenant")
        ]
    ]
    
    if verbose {
        print("\nPSALM 17B:27-29 ANALYSIS:")
        print("27-29: \"\(lines)\"")
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            print("\(lemma) (\(translation)): \(forms.joined(separator: ", "))")
        }
    }
    
    verifyWordsInAnalysis(analysis, confirmedWords: testLemmas)
    verifyThematicElements(analysis: analysis, expectedThemes: expectedThemes)
}

      // MARK: - Test Cases
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            

            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }

    func testBodyParts() {
    let analysis = latinService.analyzePsalm(text: psalm17B)
    
    let bodyParts = [
        ("pes", ["pedes", "pedibus"], "foot"),
        ("manus", ["manus"], "hand"),
        ("brachium", ["brachia"], "arm"),
        ("oculus", ["oculos"], "eye"),
        ("dorsum", ["dorsum"], "back")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: bodyParts)
}

func testNatureImagery() {
    let analysis = latinService.analyzePsalm(text: psalm17B)
    
    let natureTerms = [
        ("pulvis", ["pulverem"], "dust"),
        ("ventus", ["venti"], "wind"),
        ("lutum", ["lutum"], "mud"),
        ("murus", ["murum"], "wall"),
        ("excelsum", ["excelsa"], "heights")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: natureTerms)
}
func testMilitaryVicotoryReferences() {
    let analysis = latinService.analyzePsalm(text: psalm17B)
    let militaryTerms = [
    ("praecingo", ["praecinxit", "praecinxisti"], "gird"), // Should be "praecingo" (3rd conj)
    ("praelium", ["praelium"], "battle"),               // Correct (2nd neuter)
    ("arcus", ["arcum"], "bow"),                        // Correct (4th masc)
    ("supplanto", ["supplantasti"], "tripping"),        // Should be "supplanto" (1st conj)
    ("vindicta", ["vindictas"], "vengeance")            // Correct (1st fem)
]
    
    
    verifyWordsInAnalysis(analysis, confirmedWords: militaryTerms)

    let victoryTerms = [
    ("contero", ["Conteram"], "crush"),                 // Correct (3rd conj)
    ("comminuo", ["comminuam"], "pulverize"),           // Correct (3rd conj)
    ("deleo", ["delebo"], "wipe out"),                  // Correct (2nd conj)
    ("persequor", ["persequar"], "pursue"),             // Correct (deponent)
    ("subicio", ["subjicit"], "subdue")                 // Should be "subicio" (3rd conj)
]
   verifyWordsInAnalysis(analysis, confirmedWords: victoryTerms)
}
    
    func testDivineReciprocity() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        
        let reciprocityTerms = [
            ("sanctus", ["sancto", "sanctus"], "holy"),
            ("innocens", ["innocente", "innocens"], "blameless"),
            ("perversus", ["perverso"], "twisted"),
            ("electus", ["electo", "electus"], "chosen"),
            ("humilis", ["humilem"], "humble")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: reciprocityTerms)
    }
    
   
    
    func testCovenantalLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        
        let covenantTerms = [
            ("christus", ["christo"], "anointed"),
            ("semen", ["semini"], "seed"),
            ("saeculum", ["saeculum"], "age"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("confiteor", ["confitebor"], "praise")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: covenantTerms)
    }
    
    func testPhysiologicalMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        
        let bodyTerms = [
            ("cervus", ["cervorum"], "deer"),
            ("vestigium", ["vestigia"], "footstep"),
            ("claudico", ["claudicaverunt"], "limp"),
            ("dextera", ["dextera"], "right hand"),
            ("auris", ["auris"], "ear"),
            ("auditus", ["auditu"], "hearing")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
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