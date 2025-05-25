import XCTest
@testable import LatinService 

class Psalm91Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = false // Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }

    let id = PsalmIdentity(number: 91, category: nil)

    private let psalm91 = [
        "Bonum est confiteri Domino, et psallere nomini tuo, Altissime.",
        "Ad annuntiandum mane misericordiam tuam, et veritatem tuam per noctem,",
        "In decachordo, psalterio, cum cantico in cithara.",
        "Quia delectasti me, Domine, in factura tua; et in operibus manuum tuarum exsultabo.",
        "Quam magnificata sunt opera tua, Domine! Nimis profundae factae sunt cogitationes tuae.",
        "Vir insipiens non cognoscet, et stultus non intelliget haec.",
        "Cum exorti fuerint peccatores sicut fenum, et apparuerint omnes qui operantur iniquitatem; ut intereant in saeculum saeculi.",
        "Tu autem Altissimus in aeternum, Domine.",
        "Quoniam ecce inimici tui, Domine, quoniam ecce inimici tui peribunt; et dispergentur omnes qui operantur iniquitatem.",
        "Et exaltabitur sicut unicornis cornu meum, et senectus mea in misericordia uberi.",
        "Et despexit oculus meus inimicos meos, et in insurgentibus in me malignantibus audiet auris mea.",
        "Justus ut palma florebit; sicut cedrus Libani multiplicabitur.",
        "Plantati in domo Domini, in atriis Dei nostri florebunt.",
        "Adhuc multiplicabuntur in senecta uberi, et bene patientes erunt:",
        "Ut annuntient quoniam rectus Dominus Deus noster, et non est iniquitas in eo."
    ]
    
    // MARK: - Theme Tests
    func testPsalm91Themes() {
        let analysis = latinService.analyzePsalm(id, text: psalm91)
        
        let allThemes = [
            ("Divine Praise", ["confiteor", "psallo", "exsulto", "magnifico", "delecto"]),
            ("Musical Worship", ["decachordum", "psalterium", "canticum", "cithara"]),
            ("Divine Protection", ["altissimus", "unicornis", "despicio", "insurgo"]),
            ("Righteous Flourishing", ["justus", "palma", "cedrus", "floreo", "multiplico"]),
            ("Divine Justice", ["iniquitas", "pereo", "dispergo", "intereo"]),
            ("Wisdom Contrast", ["insipiens", "stultus", "cognosco", "intelligo"]),
            ("Eternal Nature of God", ["aeternum", "saeculum", "profundus", "cogitatio"]),
            ("Temple Imagery", ["domus", "atrium", "planto", "senecta"]),
            
            // Augustine themes
            ("Augustine: True Worship", ["confiteor", "psallo", "rectus", "iniquitas"]),
            ("Augustine: Temporal vs Eternal", ["fenum", "aeternum", "saeculum", "altissimus"]),
            ("Augustine: Righteous Growth", ["palma", "cedrus", "floreo", "multiplico"]),
            ("Augustine: Divine Sovereignty", ["dominus", "deus", "justus", "iniquitas"])
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
    
    func testPsalm91Lines1and2() {
        let line1 = psalm91[0] // "Bonum est confiteri Domino, et psallere nomini tuo, Altissime."
        let line2 = psalm91[1] // "Ad annuntiandum mane misericordiam tuam, et veritatem tuam per noctem,"
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("bonus", ["bonum"], "good"),
            ("confiteor", ["confiteri"], "praise"),
            ("dominus", ["domino"], "lord"),
            ("psallo", ["psallere"], "sing psalms"),
            ("nomen", ["nomini"], "name"),
            ("altissimus", ["altissime"], "most high"),
            ("annuntio", ["annuntiandum"], "declare"),
            ("mane", ["mane"], "morning"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("veritas", ["veritatem"], "truth"),
            ("nox", ["noctem"], "night")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Praise": [
                ("confiteor", "Continuous praise"),
                ("psallo", "Musical worship")
            ],
            "Daily Devotion": [
                ("mane", "Morning declaration"),
                ("nox", "Nightly remembrance")
            ],
            "Divine Attributes": [
                ("altissimus", "Transcendence"),
                ("misericordia", "Compassion")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:1-2 ANALYSIS:")
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
    
    func testPsalm91Lines3and4() {
        let line3 = psalm91[2] // "In decachordo, psalterio, cum cantico in cithara."
        let line4 = psalm91[3] // "Quia delectasti me, Domine, in factura tua; et in operibus manuum tuarum exsultabo."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("decachordum", ["decachordo"], "ten-stringed instrument"),
            ("psalterium", ["psalterio"], "psaltery"),
            ("canticum", ["cantico"], "song"),
            ("cithara", ["cithara"], "harp"),
            ("delecto", ["delectasti"], "delight"),
            ("factura", ["factura"], "creation"),
            ("opus", ["operibus"], "work"),
            ("manus", ["manuum"], "hand"),
            ("exsulto", ["exsultabo"], "rejoice")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Musical Worship": [
                ("decachordum", "Variety of instruments"),
                ("cithara", "Stringed accompaniment")
            ],
            "Joy in Creation": [
                ("factura", "Divine handiwork"),
                ("exsulto", "Joyful response")
            ],
            "Divine-Human Relationship": [
                ("delecto", "Divine pleasure"),
                ("manus", "Personal creation")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:3-4 ANALYSIS:")
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
    
    func testPsalm91Lines5and6() {
        let line5 = psalm91[4] // "Quam magnificata sunt opera tua, Domine! Nimis profundae factae sunt cogitationes tuae."
        let line6 = psalm91[5] // "Vir insipiens non cognoscet, et stultus non intelliget haec."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("magnifico", ["magnificata"], "magnify"),
            ("profundus", ["profundae"], "deep"),
            ("cogitatio", ["cogitationes"], "thought"),
            ("vir", ["vir"], "man"),
            ("insipiens", ["insipiens"], "foolish"),
            ("cognosco", ["cognoscet"], "know"),
            ("stultus", ["stultus"], "fool"),
            ("intelligo", ["intelliget"], "understand")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Wisdom": [
                ("profundus", "Depth of thought"),
                ("cogitatio", "Divine reasoning")
            ],
            "Wisdom Contrast": [
                ("insipiens", "Lack of understanding"),
                ("stultus", "Moral foolishness")
            ],
            "Augustine: Human Limitations": [
                ("cognosco", "Limited perception"),
                ("intelligo", "Need for divine illumination")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:5-6 ANALYSIS:")
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
    
    func testPsalm91Lines7and8() {
        let line7 = psalm91[6] // "Cum exorti fuerint peccatores sicut fenum, et apparuerint omnes qui operantur iniquitatem; ut intereant in saeculum saeculi."
        let line8 = psalm91[7] // "Tu autem Altissimus in aeternum, Domine."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("exorior", ["exorti"], "arise"),
            ("peccator", ["peccatores"], "sinner"),
            ("fenum", ["fenum"], "grass"),
            ("appareo", ["apparuerint"], "appear"),
            ("iniquitas", ["iniquitatem"], "wickedness"),
            ("intereo", ["intereant"], "perish"),
            ("saeculum", ["saeculum"], "age"),
            ("altissimus", ["altissimus"], "most high"),
            ("aeternum", ["aeternum"], "eternity")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Temporal vs Eternal": [
                ("fenum", "Temporal nature of wicked"),
                ("aeternum", "Eternal nature of God")
            ],
            "Divine Justice": [
                ("intereo", "Final judgment"),
                ("iniquitas", "Moral failure")
            ],
            "Augustine: Divine Transcendence": [
                ("altissimus", "Sovereignty over time"),
                ("saeculum", "Contrast with eternity")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:7-8 ANALYSIS:")
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
    
    func testPsalm91Lines9and10() {
        let line9 = psalm91[8] // "Quoniam ecce inimici tui, Domine, quoniam ecce inimici tui peribunt; et dispergentur omnes qui operantur iniquitatem."
        let line10 = psalm91[9] // "Et exaltabitur sicut unicornis cornu meum, et senectus mea in misericordia uberi."
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("inimicus", ["inimici"], "enemy"),
            ("pereo", ["peribunt"], "perish"),
            ("dispergo", ["dispergentur"], "scatter"),
            ("exalto", ["exaltabitur"], "exalt"),
            ("unicornis", ["unicornis"], "unicorn"),
            ("cornu", ["cornu"], "horn"),
            ("senectus", ["senectus"], "old age"),
            ("misericordia", ["misericordia"], "mercy"),
            ("uber", ["uberi"], "abundant")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Protection": [
                ("unicornis", "Symbol of strength"),
                ("cornu", "Power metaphor")
            ],
            "Justice and Mercy": [
                ("pereo", "Fate of enemies"),
                ("misericordia", "Blessing for faithful")
            ],
            "Augustine: Two Destinies": [
                ("dispergo", "Scattering of wicked"),
                ("uber", "Abundance for righteous")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:9-10 ANALYSIS:")
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
    
    func testPsalm91Lines11and12() {
        let line11 = psalm91[10] // "Et despexit oculus meus inimicos meos, et in insurgentibus in me malignantibus audiet auris mea."
        let line12 = psalm91[11] // "Justus ut palma florebit; sicut cedrus Libani multiplicabitur."
        let combinedText = line11 + " " + line12
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 11)
        
        // Lemma verification
        let testLemmas = [
            ("despicio", ["despexit"], "look down"),
            ("oculus", ["oculus"], "eye"),
            ("insurgo", ["insurgentibus"], "rise up"),
            ("malignus", ["malignantibus"], "evil"),
            ("auris", ["auris"], "ear"),
            ("justus", ["justus"], "righteous"),
            ("palma", ["palma"], "palm"),
            ("floreo", ["florebit"], "flourish"),
            ("cedrus", ["cedrus"], "cedar"),
            ("Libanus", ["Libani"], "Lebanon"),
            ("multiplico", ["multiplicabitur"], "multiply")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Righteous Security": [
                ("despicio", "Confidence before enemies"),
                ("insurgo", "Opposition overcome")
            ],
            "Floral Imagery": [
                ("palma", "Symbol of victory"),
                ("cedrus", "Strength and longevity")
            ],
            "Augustine: Righteous Growth": [
                ("floreo", "Spiritual vitality"),
                ("multiplico", "Divine blessing")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:11-12 ANALYSIS:")
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
    
    func testPsalm91Lines13and14() {
        let line13 = psalm91[12] // "Plantati in domo Domini, in atriis Dei nostri florebunt."
        let line14 = psalm91[13] // "Adhuc multiplicabuntur in senecta uberi, et bene patientes erunt:"
        let combinedText = line13 + " " + line14
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 13)
        
        // Lemma verification
        let testLemmas = [
            ("planto", ["plantati"], "planted"),
            ("domus", ["domo"], "house"),
            ("atrium", ["atriis"], "courtyard"),
            ("floreo", ["florebunt"], "flourish"),
            ("multiplico", ["multiplicabuntur"], "multiply"),
            ("senectus", ["senecta"], "old age"),
            ("uber", ["uberi"], "abundant"),
            ("patiens", ["patientes"], "enduring")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Temple Imagery": [
                ("domus", "House of God"),
                ("atrium", "Sacred space")
            ],
            "Longevity": [
                ("senectus", "Advanced age"),
                ("uber", "Abundant life")
            ],
            "Augustine: Spiritual Growth": [
                ("planto", "Rooted in God"),
                ("patiens", "Steadfastness")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:13-14 ANALYSIS:")
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
    
    func testPsalm91Line15() {
        let line15 = psalm91[14] // "Ut annuntient quoniam rectus Dominus Deus noster, et non est iniquitas in eo."
        let analysis = latinService.analyzePsalm(id, text: line15, startingLineNumber: 15)
        
        // Lemma verification
        let testLemmas = [
            ("annuntio", ["annuntient"], "declare"),
            ("rectus", ["rectus"], "upright"),
            ("dominus", ["dominus"], "lord"),
            ("deus", ["deus"], "god"),
            ("iniquitas", ["iniquitas"], "injustice")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Justice": [
                ("rectus", "Moral perfection"),
                ("iniquitas", "Absence of evil")
            ],
            "Proclamation": [
                ("annuntio", "Declaration of truth"),
                ("deus", "Nature of God")
            ]
        ]
        
        if verbose {
            print("\nPSALM 91:15 ANALYSIS:")
            print("15: \"\(line15)\"")
            
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