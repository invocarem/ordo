import XCTest
@testable import LatinService

class Psalm122Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 122, section: nil)
    
    // MARK: - Test Data
    let psalm122 = [
        "Ad te levavi oculos meos, qui habitas in caelis.",
        "Ecce sicut oculi servorum in manibus dominorum suorum,",
        "sicut oculi ancillae in manibus dominae suae: ita oculi nostri ad Dominum Deum nostrum, donec misereatur nostri.",
        "Miserere nostri, Domine, miserere nostri, quia multum repleti sumus despectione;",
        "quia multum repleta est anima nostra opprobrium abundantibus et despectio superbis."
    ]
    
    // MARK: - Line Tests
    
    func testPsalm122Line1() {
        let line = psalm122[0]
        let analysis = latinService.analyzePsalm(id, text: line, startingLineNumber: 1)
        
        let testLemmas = [
            ("ad", ["ad"], "to"),
            ("tu", ["te"], "you"),
            ("levo", ["levavi"], "lift"),
            ("oculus", ["oculos"], "eye"),
            ("meus", ["meos"], "my"),
            ("habito", ["habitas"], "dwell"),
            ("caelum", ["caelis"], "heaven")
        ]
        
        let expectedThemes = [
            "Prayer Posture": [
                ("levo", "Physical gesture of prayer"),
                ("oculus", "Eye contact with God")
            ],
            "Divine Dwelling": [
                ("habito", "God's heavenly residence"),
                ("caelum", "Heavenly realm")
            ]
        ]
        
        if verbose {
            print("\nPSALM 122:1 ANALYSIS:")
            print("1: \"\(line)\"")
            
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
    
    func testPsalm122Lines2and3() {
        let line2 = psalm122[1]
        let line3 = psalm122[2]
        let combinedText = line2 + " " + line3
        latinService.configureDebugging(target: "noster")
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 2)
        
        let testLemmas = [
            ("ecce", ["ecce"], "behold"),
            ("sicut", ["sicut", "sicut"], "as"),
            ("oculus", ["oculi", "oculi", "oculi"], "eye"),
            ("servus", ["servorum"], "servant"),
            ("manus", ["manibus", "manibus", "manibus"], "hand"),
            ("dominus", ["dominorum", "dominum"], "lord"),
            ("ancilla", ["ancillae"], "maidservant"),
            ("domina", ["dominae"], "mistress"),
            ("noster", ["nostri", "nostrum", "nostra"], "our"),
            ("deus", ["deum"], "God"),
            ("donec", ["donec"], "until"),
            ("misereor", ["misereatur"], "have mercy")
        ]
        
        let expectedThemes = [
            "Servant Imagery": [
                ("servus", "Dependent relationship"),
                ("ancilla", "Submissive posture")
            ],
            "Divine Gaze": [
                ("oculus", "Focus on God"),
                ("manus", "Metaphor of divine care")
            ],
            "Covenant Relationship": [
                ("noster", "Communal identity"),
                ("deus", "Divine partner")
            ]
        ]
        
        if verbose {
            print("\nPSALM 122:2-3 ANALYSIS:")
            print("2: \"\(line2)\"")
            print("3: \"\(line3)\"")
            
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
        latinService.configureDebugging(target: "")
    }
    
    func testPsalm122Lines4and5() {
        let line4 = psalm122[3]
        let line5 = psalm122[4]
        let combinedText = line4 + " " + line5
        let analysis = latinService.analyzePsalm(id, text: combinedText, startingLineNumber: 4)
        
        let testLemmas = [
            ("misereor", ["miserere", "miserere"], "have mercy"),
            ("dominus", ["domine"], "Lord"),
            ("multus", ["multum", "multum"], "much"),
            ("repleo", ["repleti", "repleta"], "fill"),
            ("despectio", ["despectione", "despectio"], "contempt"),
            ("anima", ["anima"], "soul"),
            ("opprobrium", ["opprobrium"], "reproach"),
            ("abundo", ["abundantibus"], "abound"),
            ("superbus", ["superbis"], "proud")
        ]
        
        let expectedThemes = [
            "Petition for Mercy": [
                ("misereor", "Double plea for mercy"),
                ("dominus", "Addressed to Yahweh")
            ],
            "Human Condition": [
                ("repleo", "Filled with distress"),
                ("opprobrium", "Experience of shame")
            ],
            "Social Conflict": [
                ("superbus", "Opposition from the proud"),
                ("abundo", "Abundance of reproach")
            ]
        ]
        
        if verbose {
            print("\nPSALM 122:4-5 ANALYSIS:")
            print("4: \"\(line4)\"")
            print("5: \"\(line5)\"")
            
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
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
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