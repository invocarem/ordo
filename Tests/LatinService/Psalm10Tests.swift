import XCTest
@testable import LatinService

class Psalm10Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm10 = [
        "In Domino confido; quomodo dicitis animae meae: Transvola in montem sicut passer?",
        "Quoniam ecce peccatores intenderunt arcum, paraverunt sagittas suas in pharetra, ut sagittent in obscuro rectos corde.",
        "Quoniam quae perfecisti, destruxerunt: justus autem quid fecit?",
        "Dominus in templo sancto suo; Dominus in caelo sedes ejus.",
        "Oculi ejus in pauperem respiciunt; palpebrae ejus interrogant filios hominum.",
        "Dominus interrogat justum et impium; qui autem diligit iniquitatem, odit animam suam.",
        "Pluet super peccatores laqueos; ignis, et sulphur, et spiritus procellarum pars calicis eorum.",
        "Quoniam justus Dominus, et justitias dilexit; aequitatem vidit vultus ejus."
    ]
    
    // MARK: - Test Cases
    
   
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let divineTerms = [
            ("dominus", ["domino", "dominus"], "lord"),
            ("templum", ["templo"], "temple"),
            ("caelum", ["caelo"], "heaven"),
            ("oculus", ["Oculi"], "eye"),
            ("vultus", ["vultus"], "face")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testHumanConditions() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let humanTerms = [
            ("pauper", ["pauperem"], "poor"),
            ("animus", ["animae", "animam"], "soul"),
            ("homo", ["hominum"], "man"),
            ("cor", ["corde"], "heart"),
            ("peccator", ["peccatores"], "sinner")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: humanTerms)
    }
    
   
    
    func testKeyVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let keyVerbs = [
            ("confido", ["confido"], "trust"),
            ("interrogo", ["interrogant", "interrogat"], "examine"),
            ("diligo", ["dilexit", "diligit"], "love"),
            ("perficio", ["perfecisti"], "complete"),
            ("destruo", ["destruxerunt"], "destroy"),
            ("pluo", ["Pluet"], "rain")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
    }

    // MARK: - Test Cases
        
    func testDistinctiveImagery() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let imageTerms = [
            ("passer", ["passer"], "sparrow"),
            ("transvolo", ["Transvola"], "fly away"),
            ("obscurus", ["obscuro"], "darkness"),
            ("procella", ["procellarum"], "tempest"),
            ("calix", ["calicis"], "cup")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: imageTerms)
    }

    func testDivineJusticeVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let justiceTerms = [
            ("justitia", ["justitias"], "justice"),
            ("aequitas", ["aequitatem"], "equity"),
            ("iniquitas", ["iniquitatem"], "iniquity"),
            ("odium", ["odit"], "hate")  // From "odit animam suam"
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
    }

    func testViolenceImagery() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let violenceTerms = [
             ("arcus", ["arcum"], "bow"),
            ("sagitta", ["sagittas", "sagittent"], "arrow"),
            ("pharetra", ["pharetra"], "quiver"),
            ("laqueus", ["laqueos"], "snare"),
            ("sulfur", ["sulphur"], "brimstone")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: violenceTerms)
    }

    func testDivineExamination() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let examinationTerms = [
            ("respiro", ["respiciunt"], "look upon"),
            ("interrogo", ["interrogant", "interrogat"], "examine"),
            ("video", ["vidit"], "see"),
            ("palpebra", ["palpebrae"], "eyelid")  // Significant anthropomorphism
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: examinationTerms)
    }

    func testKeyThematicVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm10)
        
        let keyVerbs = [
            ("confido", ["confido"], "trust"),  // Opening declaration
            ("perficio", ["perfecisti"], "complete"),
            ("destruo", ["destruxerunt"], "destroy"),
            ("diligo", ["dilexit"], "love"),   // "justitias dilexit"
            ("pluo", ["Pluet"], "rain")        // Judgment imagery
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: keyVerbs)
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