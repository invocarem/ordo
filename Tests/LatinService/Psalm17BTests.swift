import XCTest
@testable import LatinService

class Psalm17BTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
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
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("eripio", ["eripiar"], "rescue"),
        ("tentatio", ["tentatione"], "temptation"),
        ("transgredior", ["transgrediar"], "pass over"),
        ("murus", ["murum"], "wall"),
        ("impollutus", ["impolluta"], "pure"),
        ("via", ["via"], "way"),
        ("eloquium", ["eloquia"], "words"),
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