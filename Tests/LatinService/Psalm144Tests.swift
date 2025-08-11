import XCTest
@testable import LatinService

class Psalm144ATests: XCTestCase {
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

    // MARK: - Test Data (Psalm 144A)
    let id = PsalmIdentity(number: 144, category: "A")
    let psalm144A = [
        "Exaltabo te, Deus meus, rex meus: et benedicam nomini tuo in saeculum, et in saeculum saeculi.",
        "Per singulos dies benedicam tibi: et laudabo nomen tuum in saeculum, et in saeculum saeculi.",
        "Magnus Dominus, et laudabilis nimis: et magnitudinis eius non est finis.",
        "Generatio et generatio laudabit opera tua: et potentiam tuam pronuntiabunt.",
        "Magnificentiam gloriae sanctitatis tuae loquentur: et mirabilia tua narrabunt.",
        "Et virtutem terribilium tuorum dicent: et magnitudinem tuam narrabunt.",
        "Memoriam abundantiae suavitatis tuae eructabunt: et iustitia tua exsultabunt.",
        "Miserator, et misericors Dominus: patiens, et multum misericors.",
        "Suavis Dominus universis: et miserationes eius super omnia opera eius."
    ]
    
    // MARK: - Grouped Line Tests
    
    func testPsalm144ALines1and2() {
        let line1 = psalm144A[0] // "Exaltabo te, Deus meus, rex meus: et benedicam nomini tuo in saeculum, et in saeculum saeculi."
        let line2 = psalm144A[1] // "Per singulos dies benedicam tibi: et laudabo nomen tuum in saeculum, et in saeculum saeculi."
        let combinedText = line1 + " " + line2
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 1)
        
        // Lemma verification
        let testLemmas = [
            ("exalto", ["exaltabo"], "exalt"),
            ("deus", ["deus"], "God"),
            ("rex", ["rex"], "king"),
            ("benedico", ["benedicam", "benedicam"], "bless"),
            ("nomen", ["nomini", "nomen"], "name"),
            ("saeculum", ["saeculum"], "age"),
            ("laudo", ["laudabo"], "praise")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Personal Praise": [
                ("exalto", "Individual exaltation"),
                ("benedico", "Personal blessing")
            ],
            "Eternal Worship": [
                ("saeculum", "Everlasting duration"),
                ("laudo", "Continuous praise")
            ],
            "Divine Kingship": [
                ("rex", "Royal authority"),
                ("deus", "Divine nature")
            ]
        ]
        
        if verbose {
            print("\nPSALM 144A:1-2 ANALYSIS:")
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
    
    func testPsalm144ALines3and4() {
        let line3 = psalm144A[2] // "Magnus Dominus, et laudabilis nimis: et magnitudinis eius non est finis."
        let line4 = psalm144A[3] // "Generatio et generatio laudabit opera tua: et potentiam tuam pronuntiabunt."
        let combinedText = line3 + " " + line4
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 3)
        
        // Lemma verification
        let testLemmas = [
            ("magnus", ["magnus"], "great"),
            ("dominus", ["dominus"], "Lord"),
            ("laudabilis", ["laudabilis"], "praiseworthy"),
            ("magnitudo", ["magnitudinis"], "greatness"),
            ("finis", ["finis"], "end"),
            ("generatio", ["generatio"], "generation"),
            ("opus", ["opera"], "work"),
            ("potentia", ["potentiam"], "power"),
            ("pronuntio", ["pronuntiabunt"], "declare")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Greatness": [
                ("magnus", "Essential greatness"),
                ("magnitudo", "Infinite quality")
            ],
            "Intergenerational Praise": [
                ("generatio", "Multiple generations"),
                ("laudabilis", "Praiseworthy nature")
            ],
            "Powerful Works": [
                ("opus", "Divine works"),
                ("potentia", "Manifested power")
            ]
        ]
        
        if verbose {
            print("\nPSALM 144A:3-4 ANALYSIS:")
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
    
    func testPsalm144ALines5and6() {
        let line5 = psalm144A[4] // "Magnificentiam gloriae sanctitatis tuae loquentur: et mirabilia tua narrabunt."
        let line6 = psalm144A[5] // "Et virtutem terribilium tuorum dicent: et magnitudinem tuam narrabunt."
        let combinedText = line5 + " " + line6
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 5)
        
        // Lemma verification
        let testLemmas = [
            ("magnificentia", ["magnificentiam"], "magnificence"),
            ("gloria", ["gloriae"], "glory"),
            ("sanctitas", ["sanctitatis"], "holiness"),
            ("loquor", ["loquentur"], "speak"),
            ("mirabilis", ["mirabilia"], "wonderful"),
            ("narro", ["narrabunt", "narrabunt"], "declare"),
            ("virtus", ["virtutem"], "power"),
            ("terribilis", ["terribilium"], "awesome"),
            ("magnitudo", ["magnitudinem"], "greatness")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Divine Splendor": [
                ("magnificentia", "Radiant majesty"),
                ("gloria", "Visible glory")
            ],
            "Holy Wonder": [
                ("sanctitas", "Sacred purity"),
                ("mirabilis", "Wonderful deeds")
            ],
            "Awesome Power": [
                ("virtus", "Divine strength"),
                ("terribilis", "Awe-inspiring nature")
            ]
        ]
        
        if verbose {
            print("\nPSALM 144A:5-6 ANALYSIS:")
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
    
    func testPsalm144ALines7and8() {
        let line7 = psalm144A[6] // "Memoriam abundantiae suavitatis tuae eructabunt: et iustitia tua exsultabunt."
        let line8 = psalm144A[7] // "Miserator, et misericors Dominus: patiens, et multum misericors."
        let combinedText = line7 + " " + line8
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 7)
        
        // Lemma verification
        let testLemmas = [
            ("memoria", ["memoriam"], "memory"),
            ("abundantia", ["abundantiae"], "abundance"),
            ("suavitas", ["suavitatis"], "sweetness"),
            ("eructo", ["eructabunt"], "pour forth"),
            ("iustitia", ["iustitia"], "justice"),
            ("exsulto", ["exsultabunt"], "rejoice"),
            ("miserator", ["miserator"], "merciful"),
            ("misericors", ["misericors", "misericors"], "merciful"),
            ("patiens", ["patiens"], "patient")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Abundant Goodness": [
                ("abundantia", "Overflowing quality"),
                ("suavitas", "Pleasant character")
            ],
            "Joyful Justice": [
                ("iustitia", "Righteousness"),
                ("exsulto", "Celebration")
            ],
            "Divine Compassion": [
                ("misericors", "Merciful nature"),
                ("patiens", "Patient character")
            ]
        ]
        
        if verbose {
            print("\nPSALM 144A:7-8 ANALYSIS:")
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
    
    func testPsalm144ALine9() {
        let line9 = psalm144A[8] // "Suavis Dominus universis: et miserationes eius super omnia opera eius."
        let analysis = latinService.analyzePsalm(id, text: line9, startingLineNumber: 9)
        
        // Lemma verification
        let testLemmas = [
            ("suavis", ["suavis"], "sweet"),
            ("dominus", ["dominus"], "Lord"),
            ("universus", ["universis"], "all"),
            ("miseratio", ["miserationes"], "compassion"),
            ("super", ["super"], "above"),
            ("omnis", ["omnia"], "all"),
            ("opus", ["opera"], "work")
        ]
        
        // Thematic analysis
        let expectedThemes = [
            "Universal Kindness": [
                ("suavis", "Pleasant nature"),
                ("universus", "All-encompassing")
            ],
            "Compassionate Sovereignty": [
                ("miseratio", "Tender mercies"),
                ("opus", "Creative works")
            ]
        ]
        
        if verbose {
            print("\nPSALM 144A:9 ANALYSIS:")
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