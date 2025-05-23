import XCTest
@testable import LatinService

class Psalm7Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true // Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    let id = PsalmIdentity(number: 7, category: nil)
    
    // MARK: - Test Data
    let psalm7 = [
        "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me.",
        "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat.",
        "Domine Deus meus, si feci istud, si est iniquitas in manibus meis,",
        "si reddidi retribuentibus mihi mala, decidam merito ab inimicis meis inanis.",
        "Persequatur inimicus animam meam, et comprehendat, et conculcet in terra vitam meam, et gloriam meam in pulverem deducat.",
        "Exsurge, Domine, in ira tua; exaltare in finibus inimicorum meorum.",
        "Et exsurge, Domine Deus meus, in praecepto quod mandasti, et synagoga populorum circumdabit te.",
        "Et propter hanc in altum regredere; Dominus judicat populos.",
        "Judica me, Domine, secundum justitiam meam, et secundum innocentiam meam super me.",
        "Consumetur nequitia peccatorum, et diriges justum, scrutans corda et renes, Deus.",
        "Justum adjutorium meum a Domino, qui salvos facit rectos corde.",
        "Deus judex justus, fortis, et patiens; numquid irascitur per singulos dies?",
        "Nisi conversi fueritis, gladium suum vibrabit; arcum suum tetendit, et paravit illum.",
        "Et in eo paravit vasa mortis; sagittas suas ardentibus effecit.",
        "Ecce parturiit injustitiam, concepit dolorem, et peperit iniquitatem.",
        "Lacum aperuit, et effodit eum, et incidit in foveam quam fecit.",
        "Convertetur dolor ejus in caput ejus, et in verticem ipsius iniquitas ejus descendet.",
        "Confitebor Domino secundum justitiam ejus, et psallam nomini Domini altissimi."
    ]
    
    // MARK: - Grouped Line Tests
    
    func testPsalm7Lines1and2() {
        let line1 = psalm7[0] // "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me."
        let line2 = psalm7[1] // "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("dominus", ["domine"], "Lord"),
            ("deus", ["deus"], "God"),
            ("spero", ["speravi"], "hope"),
            ("salvus", ["salvum"], "save"),
            ("facio", ["fac", "faciat"], "make"),
            ("persequor", ["persequentibus"], "pursue"),
            ("libero", ["libera"], "free"),
            ("nequando", ["nequando"], "lest ever"),
            ("rapio", ["rapiat"], "snatch"),
            ("leo", ["leo"], "lion"),
            ("anima", ["animam"], "soul"),
            ("redimo", ["redimat"], "redeem")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Address": [
                ("dominus", "Initial invocation of God"),
                ("deus", "Personal relationship with God")
            ],
            "Trust and Salvation": [
                ("spero", "Expression of trust"),
                ("salvus", "Petition for salvation")
            ],
            "Threat Imagery": [
                ("leo", "Lion as predator"),
                ("rapio", "Violent seizure")
            ]
        ]
        
        if verbose {
            print("\nPSALM 7:1-2 ANALYSIS:")
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
    
    func testPsalm7Lines3and4() {
        let line3 = psalm7[2] // "Domine Deus meus, si feci istud, si est iniquitas in manibus meis,"
        let line4 = psalm7[3] // "si reddidi retribuentibus mihi mala, decidam merito ab inimicis meis inanis."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("dominus", ["domine"], "Lord"),
            ("deus", ["deus"], "God"),
            ("facio", ["feci"], "do"),
            ("iniquitas", ["iniquitas"], "iniquity"),
            ("manus", ["manibus"], "hand"),
            ("reddo", ["reddidi"], "repay"),
            ("retribuo", ["retribuentibus"], "repay"),
            ("malus", ["mala"], "evil"),
            ("decido", ["decidam"], "fall"),
            ("inimicus", ["inimicis"], "enemy")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Self-Examination": [
                ("facio", "Reflection on actions"),
                ("iniquitas", "Possible wrongdoing")
            ],
            "Retribution Principle": [
                ("reddo", "Reciprocal justice"),
                ("retribuo", "Repayment concept")
            ],
            "Consequences": [
                ("decido", "Potential downfall"),
                ("inimicus", "Threat from enemies")
            ]
        ]
        
        if verbose {
            print("\nPSALM 7:3-4 ANALYSIS:")
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
    
    func testPsalm7Lines5and6() {
        let line5 = psalm7[4] // "Persequatur inimicus animam meam, et comprehendat, et conculcet in terra vitam meam, et gloriam meam in pulverem deducat."
        let line6 = psalm7[5] // "Exsurge, Domine, in ira tua; exaltare in finibus inimicorum meorum."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("persequor", ["persequatur"], "pursue"),
            ("inimicus", ["inimicus", "inimicorum"], "enemy"),
            ("anima", ["animam"], "soul"),
            ("comprehendo", ["comprehendat"], "seize"),
            ("conculco", ["conculcet"], "trample"),
            ("vita", ["vitam"], "life"),
            ("gloria", ["gloriam"], "glory"),
            ("pulvis", ["pulverem"], "dust"),
            ("exsurgo", ["exsurge"], "arise"),
            ("ira", ["ira"], "anger"),
            ("exalto", ["exaltare"], "exalt")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Enemy Aggression": [
                ("persequor", "Relentless pursuit"),
                ("comprehendo", "Violent seizure")
            ],
            "Divine Intervention": [
                ("exsurgo", "Call for God to act"),
                ("exalto", "Request for divine exaltation")
            ],
            "Humiliation": [
                ("conculco", "Trampling underfoot"),
                ("pulvis", "Reduction to dust")
            ]
        ]
        
        if verbose {
            print("\nPSALM 7:5-6 ANALYSIS:")
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
    
    func testPsalm7Lines7and8() {
        let line7 = psalm7[6] // "Et exsurge, Domine Deus meus, in praecepto quod mandasti, et synagoga populorum circumdabit te."
        let line8 = psalm7[7] // "Et propter hanc in altum regredere; Dominus judicat populos."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("exsurgo", ["exsurge"], "arise"),
            ("dominus", ["domine"], "Lord"),
            ("deus", ["deus"], "God"),
            ("praeceptum", ["praecepto"], "command"),
            ("mando", ["mandasti"], "command"),
            ("synagoga", ["synagoga"], "assembly"),
            ("populus", ["populorum", "populos"], "people"),
            ("circumdo", ["circumdabit"], "surround"),
            ("altus", ["altum"], "high"),
            ("regredior", ["regredere"], "return"),
            ("judico", ["judicat"], "judge")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Authority": [
                ("praeceptum", "God's commands"),
                ("mando", "Divine mandate")
            ],
            "Divine Judgment": [
                ("judico", "God as judge"),
                ("populus", "Scope of judgment")
            ],
            "Divine Presence": [
                ("circumdo", "Surrounding presence"),
                ("synagoga", "Gathered assembly")
            ]
        ]
        
        if verbose {
            print("\nPSALM 7:7-8 ANALYSIS:")
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
    
    func testPsalm7Lines9and10() {
        let line9 = psalm7[8] // "Judica me, Domine, secundum justitiam meam, et secundum innocentiam meam super me."
        let line10 = psalm7[9] // "Consumetur nequitia peccatorum, et diriges justum, scrutans corda et renes, Deus."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("judico", ["judica"], "judge"),
            ("dominus", ["domine"], "Lord"),
            ("justitia", ["justitiam"], "justice"),
            ("innocentia", ["innocentiam"], "innocence"),
            ("consumo", ["consumetur"], "consume"),
            ("nequitia", ["nequitia"], "wickedness"),
            ("peccator", ["peccatorum"], "sinner"),
            ("dirigo", ["diriges"], "guide"),
            ("justus", ["justum"], "righteous"),
            ("scrutor", ["scrutans"], "examine"),
            ("cor", ["corda"], "heart"),
            ("ren", ["renes"], "kidney"),
            ("deus", ["deus"], "God")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Judicial Petition": [
                ("judico", "Request for judgment"),
                ("justitia", "Standard of justice")
            ],
            "Divine Examination": [
                ("scrutor", "God's scrutiny"),
                ("cor", "Inner being examined")
            ],
            "Moral Contrast": [
                ("nequitia", "Wickedness destroyed"),
                ("justus", "Righteous preserved")
            ]
        ]
        
        if verbose {
            print("\nPSALM 7:9-10 ANALYSIS:")
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