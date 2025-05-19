import XCTest
@testable import LatinService

class Psalm118PeTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let identity = PsalmIdentity(number: 118, section: "pe")
    // MARK: - Test Data (Psalm 118:129-136 "Pe" section)
    let psalm118Pe = [
        "Mirabilia testimonia tua, ideo scrutata est ea anima mea.",
        "Declaratio sermonum tuorum illuminat, et intellectum dat parvulis.",
        "Os meum aperui et attraxi spiritum, quia mandata tua desiderabam.",
        "Aspice in me et miserere mei, secundum judicium diligentium nomen tuum.",
        "Gressus meos dirige secundum eloquium tuum, et non dominetur mei omnis iniquitas.",
        "Redime me a calumniis hominum, ut custodiam mandata tua.",
        "Faciem tuam illumina super servum tuum, et doce me justificationes tuas.",
        "Exitius aquae deduxerunt oculi mei, quia non custodierunt legem tuam."
    ]
    
    // MARK: - Test Cases
    
    func testDivineRevelationTerms() {
        let analysis = latinService.analyzePsalm(identity,text: psalm118Pe)
        
        let revelationTerms = [
            ("testimonium", ["testimonia"], "testimony"), // v.129
            ("declaratio", ["declaratio"], "declaration"), // v.130
            ("sermo", ["sermonum"], "word"), // v.130
            ("eloquium", ["eloquium"], "expression") // v.133
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: revelationTerms)
    }
    
    func testPetitionVerbs() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Pe)
        
        let petitions = [
            ("aspicio", ["aspice"], "look upon"), // v.132
            ("dirigo", ["dirige"], "direct"), // v.133
            ("redimo", ["redime"], "redeem"), // v.134
            ("illumino", ["illumina"], "shine"), // v.135
            ("doceo", ["doce"], "teach") // v.135
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: petitions)
    }
    
    func testSpiritualFaculties() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Pe)
        
        let faculties = [
            ("animus", ["anima"], "soul"), // v.129
            ("intellectus", ["intellectum"], "understanding"), // v.130
            ("os", ["os"], "mouth"), // v.131
            ("spiritus", ["spiritum"], "spirit"), // v.131
            ("oculus", ["oculi"], "eye") // v.136
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: faculties)
    }
    
    func testTorahLanguage() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Pe)
        
        let lawTerms = [
            ("mandatum", ["mandata", "mandata"], "commandment"), // v.131, v.134
            ("justificatio", ["justificationes"], "ordinance"), // v.135
            ("lex", ["legem"], "law") // v.136
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lawTerms)
    }
    
    func testEmotionalExpressions() {
        let analysis = latinService.analyzePsalm(identity, text: psalm118Pe)
        
        let emotions = [
            ("desidero", ["desiderabam"], "long for"), // v.131
            ("misereor", ["miserere"], "mercy"), // v.132
            ("exitus", ["exitius"], "streams"), // v.136 (tears)
            ("scrutor", ["scrutata"], "search") // v.129
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: emotions)
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