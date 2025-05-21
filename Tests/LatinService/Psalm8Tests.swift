import XCTest
@testable import LatinService

class Psalm8Tests: XCTestCase {
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

    let id = PsalmIdentity(number: 8, section: nil)
    
    // MARK: - Test Data
    let psalm8 = [
        "Domine, Dominus noster, quam admirabile est nomen tuum in universa terra!",
        "Quoniam elevata est magnificentia tua super caelos.",
        "Ex ore infantium et lactentium perfecisti laudem propter inimicos tuos: ut destruas inimicum et ultorem.",
        "Quoniam videbo caelos tuos, opera digitorum tuorum: lunam et stellas quae tu fundasti.",
        "Quid est homo quod memor es ejus? aut filius hominis, quoniam visitas eum?",
        "Minuisti eum paulo minus ab angelis: gloria et honore coronasti eum.",
        "Et constituisti eum super opera manuum tuarum: omnia subjecisti sub pedibus ejus.",
        "Oves et boves universas: insuper et pecora campi.",
        "Volucres caeli, et pisces maris: qui perambulant semitas maris.",
        "Domine, Dominus noster: quam admirabile est nomen tuum in universa terra!"
    ]
    
    // MARK: - Grouped Line Tests
    
    func testPsalm8Lines1and2() {
        let line1 = psalm8[0] // "Domine, Dominus noster, quam admirabile est nomen tuum in universa terra!"
        let line2 = psalm8[1] // "Quoniam elevata est magnificentia tua super caelos."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("dominus", ["domine", "dominus"], "Lord"),
            ("noster", ["noster"], "our"),
            ("admirabilis", ["admirabile"], "admirable"),
            ("nomen", ["nomen"], "name"),
            ("universus", ["universa"], "all"),
            ("terra", ["terra"], "earth"),
            ("quoniam", ["quoniam"], "for"),
            ("elevo", ["elevata"], "lift up"),
            ("magnificentia", ["magnificentia"], "majesty"),
            ("caelum", ["caelos"], "heaven")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Majesty": [
                ("dominus", "Address to the Lord"),
                ("magnificentia", "Expression of God's greatness")
            ],
            "Cosmic Praise": [
                ("caelum", "Heavenly scope"),
                ("terra", "Earthly scope")
            ],
            "Wonder and Awe": [
                ("admirabilis", "Sense of wonder"),
                ("elevo", "Exaltation theme")
            ]
        ]
        
        if verbose {
            print("\nPSALM 8:1-2 ANALYSIS:")
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
    
    func testPsalm8Lines3and4() {
        let line3 = psalm8[2] // "Ex ore infantium et lactentium perfecisti laudem propter inimicos tuos: ut destruas inimicum et ultorem."
        let line4 = psalm8[3] // "Quoniam videbo caelos tuos, opera digitorum tuorum: lunam et stellas quae tu fundasti."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("os", ["ore"], "mouth"),
            ("infans", ["infantium"], "infant"),
            ("lactens", ["lactentium"], "nursing"),
            ("perficio", ["perfecisti"], "perfect"),
            ("laus", ["laudem"], "praise"),
            ("inimicus", ["inimicos", "inimicum"], "enemy"),
            ("ultor", ["ultorem"], "avenger"),
            ("video", ["videbo"], "see"),
            ("opus", ["opera"], "work"),
            ("digitus", ["digitorum"], "finger"),
            ("luna", ["lunam"], "moon"),
            ("stella", ["stellas"], "star"),
            ("fundo", ["fundasti"], "establish")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Perfect Praise": [
                ("perficio", "Completion of praise"),
                ("laus", "Nature of worship")
            ],
            "Divine Creation": [
                ("opus", "God's handiwork"),
                ("fundo", "Establishment of cosmos")
            ],
            "Celestial Order": [
                ("luna", "Lunar reference"),
                ("stella", "Stellar reference")
            ]
        ]
        
        if verbose {
            print("\nPSALM 8:3-4 ANALYSIS:")
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
    
    func testPsalm8Lines5and6() {
        let line5 = psalm8[4] // "Quid est homo quod memor es ejus? aut filius hominis, quoniam visitas eum?"
        let line6 = psalm8[5] // "Minuisti eum paulo minus ab angelis: gloria et honore coronasti eum."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("homo", ["homo"], "man"),
            ("memor", ["memor"], "mindful"),
            ("filius", ["filius"], "son"),
            ("visito", ["visitas"], "visit"),
            ("minuo", ["minuisti"], "diminish"),
            ("angelus", ["angelis"], "angel"),
            ("gloria", ["gloria"], "glory"),
            ("honor", ["honore"], "honor"),
            ("corono", ["coronasti"], "crown")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Human Dignity": [
                ("homo", "Humanity's status"),
                ("filius", "Representative humanity")
            ],
            "Divine Attention": [
                ("memor", "God's remembrance"),
                ("visito", "Divine visitation")
            ],
            "Exaltation": [
                ("corono", "Crowning honor"),
                ("gloria", "Bestowed glory")
            ]
        ]
        
        if verbose {
            print("\nPSALM 8:5-6 ANALYSIS:")
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
    
    func testPsalm8Lines7and8() {
        let line7 = psalm8[6] // "Et constituisti eum super opera manuum tuarum: omnia subjecisti sub pedibus ejus."
        let line8 = psalm8[7] // "Oves et boves universas: insuper et pecora campi."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("constituo", ["constituisti"], "establish"),
            ("opus", ["opera"], "work"),
            ("manus", ["manuum"], "hand"),
            ("subjicio", ["subjecisti"], "subject"),
            ("pes", ["pedibus"], "foot"),
            ("ovis", ["oves"], "sheep"),
            ("bos", ["boves"], "ox"),
            ("pecus", ["pecora"], "cattle"),
            ("campus", ["campi"], "field")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Human Dominion": [
                ("constituo", "Appointment to rule"),
                ("subjicio", "Subjugation of creation")
            ],
            "Created Order": [
                ("opus", "Divine handiwork"),
                ("manus", "God's creative work")
            ],
            "Agricultural Blessing": [
                ("ovis", "Sheep as provision"),
                ("bos", "Oxen as wealth")
            ]
        ]
        
        if verbose {
            print("\nPSALM 8:7-8 ANALYSIS:")
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
    
    func testPsalm8Lines9and10() {
        let line9 = psalm8[8] // "Volucres caeli, et pisces maris: qui perambulant semitas maris."
        let line10 = psalm8[9] // "Domine, Dominus noster: quam admirabile est nomen tuum in universa terra!"
        let combinedText = line9 + " " + line10
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("volucris", ["volucres"], "bird"),
            ("caelum", ["caeli"], "heaven"),
            ("piscis", ["pisces"], "fish"),
            ("mare", ["maris"], "sea"),
            ("perambulo", ["perambulant"], "traverse"),
            ("semita", ["semitas"], "path"),
            ("dominus", ["domine", "dominus"], "Lord"),
            ("noster", ["noster"], "our"),
            ("admirabilis", ["admirabile"], "admirable"),
            ("nomen", ["nomen"], "name"),
            ("universus", ["universa"], "all"),
            ("terra", ["terra"], "earth")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Natural World": [
                ("volucris", "Avian life"),
                ("piscis", "Marine life")
            ],
            "Divine Sovereignty": [
                ("dominus", "Recognition of lordship"),
                ("noster", "Covenant relationship")
            ],
            "Inclusive Praise": [
                ("universus", "All-encompassing scope"),
                ("terra", "Earthly dimension")
            ]
        ]
        
        if verbose {
            print("\nPSALM 8:9-10 ANALYSIS:")
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