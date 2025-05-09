import XCTest
@testable import LatinService

class Psalm16Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm16 = [
        "Exaudi, Domine, justitiam meam; intende deprecationem meam.",
        "Auribus percipe orationem meam, non in labiis dolosis.",
        "De vultu tuo judicium meum prodeat; oculi tui videant aequitatem.",
        "Probasti cor meum, et visitasti nocte; igne me examinasti, et non est inventa in me iniquitas.",
        "Ut non loquatur os meum opera hominum; propter verba labiorum tuorum ego custodivi vias duras.",
        "Perfice gressus meos in semitis tuis, ut non moveantur vestigia mea.",
        "Ego clamavi, quoniam exaudisti me, Deus; inclina aurem tuam mihi, et exaudi verba mea.",
        "Mirifica misericordias tuas, qui salvos facis sperantes in te.",
        "A resistentibus dexterae tuae custodi me, ut pupillam oculi.",
        "Sub umbra alarum tuarum protege me,",
        "a facie impiorum qui me afflixerunt.",
        "Inimici mei animam meum circumdederunt; adipem suum concluserunt, os eorum locutum est superbiam.",
        "Projicientes me nunc circumdederunt me; oculos suos statuerunt declinare in terram.",
        "Susceperunt me sicut leo paratus ad praedam, et sicut catulus leonis habitans in abditis.",
        "Exsurge, Domine, praeveni eos, et supplanta eos.",
        "Eripe animam meam ab impio, frameam tuam ab inimicis manus tuae.",
        "Domine, a paucis de terra divide eos in vita eorum; de absconditis tuis adimpletus est venter eorum.",
        "Saturati sunt filiis, et dimiserunt reliquias suas parvulis suis.",
        "Ego autem in justitia apparebo conspectui tuo; satiabor cum apparuerit gloria tua."
    ]
    
    // MARK: - Test Cases
    
    func testJudicialPetition() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let legalTerms = [
            ("justitia", ["justitiam"], "justice"),
            ("judicium", ["judicium"], "judgment"),
            ("aequitas", ["aequitatem"], "equity"),
            ("probo", ["Probasti"], "test"),
            ("iniquitas", ["iniquitas"], "injustice")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: legalTerms)
    }
    
    func testDivineProtection() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let protectionTerms = [
            ("pupilla", ["pupillam"], "apple [of eye]"),
            ("ala", ["alarum"], "wing"),
            ("framea", ["frameam"], "sword"),
            ("custodio", ["custodivi", "custodi"], "guard"),
            ("protego", ["protege"], "protect")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testLionImagery() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let lionTerms = [
            ("leo", ["leo", "leonis"], "lion"),
            ("catulus", ["catulus"], "cub"),
            ("praeda", ["praedam"], "prey"),
            ("abditus", ["abditis"], "hidden place"),
            ("supplanto", ["supplanta"], "trip up")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lionTerms)
    }
    
    func testBodyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let bodyTerms = [
            ("adeps", ["adipem"], "fat"), // Symbolizing prosperity
            ("venter", ["venter"], "belly"),
            ("oculus", ["oculi", "oculos"], "eye"),
            ("auris", ["Auribus", "aurem"], "ear"),
            ("labium", ["labiis", "labiorum"], "lip")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    
    func testEschatologicalHope() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let hopeTerms = [
            ("gloria", ["gloria"], "glory"),
            ("satiabor", ["satiabor"], "be satisfied"),
            ("appareo", ["apparebo", "apparuerit"], "appear"),
            ("absconditum", ["absconditis"], "hidden treasures"),
            ("reliquiae", ["reliquias"], "remnants")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: hopeTerms)
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