import XCTest
@testable import LatinService

class Psalm66Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm66 = [
        "Deus misereatur nostri, et benedicat nobis; illuminet vultum suum super nos, et misereatur nostri.",
        "Ut cognoscamus in terra viam tuam, in omnibus gentibus salutare tuum.",
        "Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.",
        "Laetentur et exsultent gentes, quoniam judicas populos in aequitate, et gentes in terra dirigis.",
        "Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.",
        "Terra dedit fructum suum; benedicat nos Deus, Deus noster.",
        "Benedicat nos Deus; et metuant eum omnes fines terrae."
    ]
    let id = PsalmIdentity(number: 66, category: nil) 
    // MARK: - Test Cases
     func testDivineFaceMetaphor() {
        let analysis = latinService.analyzePsalm(id, text: psalm66)
        
        let faceTerms = [
            ("vultus", ["vultum"], "face"),
            ("illumino", ["illuminet"], "shine"),
            ("super", ["super"], "upon")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: faceTerms)
        
        // Additional check for the full metaphorical phrase
        let containsFaceMetaphor = psalm66.contains { verse in
            verse.lowercased().contains("illuminet vultum suum super nos")
        }
        XCTAssertTrue(containsFaceMetaphor, "Missing 'shine your face upon us' metaphor")
    }
    
    func testAgriculturalMetaphors() {
        let analysis = latinService.analyzePsalm(id, text: psalm66)
        
        let agrarianTerms = [
            ("terra", ["terra", "terrae"], "earth"),
            ("fructus", ["fructum"], "fruit"),
            ("finis", ["fines"], "end")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: agrarianTerms)
        
        // Test the personification metaphor
        let containsPersonification = psalm66.contains { verse in
            verse.lowercased().contains("terra dedit fructum suum")
        }
        XCTAssertTrue(containsPersonification, "Missing earth giving fruit personification")
    }
    
    func testLightAndGuidanceImagery() {
        let analysis = latinService.analyzePsalm(id, text: psalm66)
        
        let lightTerms = [
            ("via", ["viam"], "way"),
            ("dirigo", ["dirigis"], "guide"),
            ("salutare", ["salutare"], "salvation")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lightTerms)
    }
    
    func testUniversalWorshipHyperbole() {
        let analysis = latinService.analyzePsalm(id, text: psalm66)
        
        let universalTerms = [
            ("omnis", ["omnibus", "omnes"], "all"),
            ("gens", ["gentibus", "gentes"], "nation"),
            ("populus", ["populi", "populos"], "people"),
            ("finis", ["fines"], "end")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: universalTerms)
        
        // Test the hyperbolic expression
        let containsHyperbole = psalm66.contains { verse in
            verse.lowercased().contains("omnes fines terrae")
        }
        XCTAssertTrue(containsHyperbole, "Missing 'all the ends of the earth' hyperbole")
    }
    
    func testDivineBlessings() {
        let analysis = latinService.analyzePsalm(id, text: psalm66)
        
        let blessingTerms = [
            ("misereor", ["misereatur"], "have mercy"),
            ("benedico", ["benedicat"], "bless"),
            ("illumino", ["illuminet"], "illuminate"),
            ("salutare", ["salutare"], "salvation")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: blessingTerms)
    }
    
    func testUniversalRecognition() {
        let analysis = latinService.analyzePsalm(text: psalm66)
        
        let universalTerms = [
            ("gens", ["gentibus", "gentes"], "nation"),
            ("populus", ["populi", "populos"], "people"),
            ("terra", ["terra", "terrae"], "earth"),
            ("omnis", ["omnibus", "omnes"], "all")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: universalTerms)
    }
    
    func testJoyAndJudgment() {
        let analysis = latinService.analyzePsalm(text: psalm66)
        
        let joyTerms = [
            ("laetor", ["Laetentur"], "rejoice"),
            ("exsulto", ["exsultent"], "exult"),
            ("aequitas", ["aequitate"], "equity"),
            ("judico", ["judicas"], "judge")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: joyTerms)
    }
    
    func testEarthlyFruitfulness() {
        let analysis = latinService.analyzePsalm(text: psalm66)
        
        let fruitfulnessTerms = [
            ("fructus", ["fructum"], "fruit"),
            ("terra", ["terra", "terrae"], "earth"),
            ("dirigo", ["dirigis"], "guide"),
            ("metuo", ["metuant"], "fear")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: fruitfulnessTerms)
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
}