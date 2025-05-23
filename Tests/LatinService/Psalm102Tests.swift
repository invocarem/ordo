import XCTest
@testable import LatinService

class Psalm102Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    let id = PsalmIdentity(number: 102, category: nil)
    // MARK: - Test Data
    let psalm102 = [
           "Benedic, anima mea, Domino, et omnia quae intra me sunt nomini sancto ejus.",
                "Benedic, anima mea, Domino, et noli oblivisci omnes retributiones ejus.",
                "Qui propitiatur omnibus iniquitatibus tuis, qui sanat omnes infirmitates tuas.",
                "Qui redimit de interitu vitam tuam, qui coronat te in misericordia et miserationibus.",
                "Qui replet in bonis desiderium tuum; renovabitur ut aquilae juventus tua.",
                "Faciens misericordias Dominus, et judicium omnibus injuriam patientibus.",
                "Notas fecit vias suas Moysi, filiis Israel voluntates suas.",
                "Miserator et misericors Dominus, longanimis et multum misericors.",
                "Non in perpetuum irascetur, neque in aeternum comminabitur.",
                "Non secundum peccata nostra fecit nobis, neque secundum iniquitates nostras retribuit nobis.",
                "Quoniam secundum altitudinem caeli a terra, corroboravit misericordiam suam super timentes se.",
                "Quantum distat ortus ab occidente, longe fecit a nobis iniquitates nostras.",
                "Quomodo miseretur pater filiorum, misertus est Dominus timentibus se.",
                "Quoniam ipse cognovit figmentum nostrum; recordatus est quia pulvis sumus.",
                "Homo, sicut foenum dies ejus, tamquam flos agri sic efflorebit.",
                "Quoniam spiritus pertransibit in illo, et non subsistet, et non cognoscet amplius locum suum.",
                "Misericordia autem Domini ab aeterno, et usque in aeternum super timentes eum.",
                "Et justitia illius in filios filiorum, his qui servant testamentum ejus,",
                "et memores sunt mandatorum ipsius ad faciendum ea.",
                "Dominus in caelo paravit sedem suam, et regnum ipsius omnibus dominabitur.",
                "Benedicite Domino, omnes angeli ejus, potentes virtute, facientes verbum illius,",
                "ad audiendam vocem sermonum ejus.",
                "Benedicite Domino, omnes virtutes ejus, ministri ejus, qui facitis voluntatem ejus.",
                "Benedicite Domino, omnia opera ejus, in omni loco dominationis ejus.",
                "Benedic, anima mea, Domino."
    ]
    
    // MARK: - Test Cases
    
    // 1. Divine Mercy Terminology (Rare Forms)
    func testDivineMercyTerms() {
        let analysis = latinService.analyzePsalm(id, text: psalm102)
        
        let mercyTerms = [
            ("propitior", ["propitiatur"], "appease"), // Psalm 102:3 (Deponent)
            ("longanimis", ["longanimis"], "long-suffering"), // Psalm 102:8 (Hapax in Psalms)
            ("corono", ["coronat"], "crown"), // Psalm 102:4 (Specific divine action)
            ("miserator", ["miserator"], "compassionate"), // Psalm 102:8 (Rare synonym)
            ("comminor", ["comminabitur"], "threaten") // Psalm 102:9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: mercyTerms)
    }
    
    // 2. Human Frailty Metaphors
    func testFrailtyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm102)
        
        let frailtyTerms = [
            ("figmentum", ["figmentum"], "clay form"), // Psalm 102:14 (Creation metaphor)
            ("effloreo", ["efflorebit"], "fade"), // Psalm 102:15 (Unique floral verb)
            ("pertransio", ["pertransibit"], "pass through"), // Psalm 102:16 (Transience)
            ("pulvis", ["pulvis"], "dust"), // Psalm 102:14
            ("subsisto", ["subsistet"], "endure") // Psalm 102:16 (Negated)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: frailtyTerms)
    }
    
    // 3. Cosmic-Scale Language
    func testCosmicScaleTerms() {
        let analysis = latinService.analyzePsalm(id, text: psalm102)
        
        let cosmicTerms = [
            ("altitudo", ["altitudinem"], "height"), // Psalm 102:11 (Heaven-earth comparison)
            ("ortus", ["ortus"], "sunrise"), // Psalm 102:12 (Cardinal direction)
            ("occidens", ["occidente"], "west"), // Psalm 102:12
            ("corroboro", ["corroboravit"], "strengthen"), // Psalm 102:11 (Divine action)
            ("dominatio", ["dominationis"], "dominion") // Psalm 102:22
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: cosmicTerms)
    }
    
    // 4. Angelic Hierarchy Terms
    func testAngelicTerms() {
        let analysis = latinService.analyzePsalm(id, text: psalm102)
        
        let angelicTerms = [
            ("potens", ["potentes"], "mighty one"), // Psalm 102:20 (Angelic attribute)
            ("minister", ["ministri"], "servant"), // Psalm 102:21
            ("virtus", ["virtutes"], "heavenly host"), // Psalm 102:21 (≠ "virtue")
            ("sedes", ["sedem"], "throne"), // Psalm 102:19
            ("testamentum", ["testamentum"], "covenant") // Psalm 102:18
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: angelicTerms)
    }
    
    // 5. Renewal Verbs (Unique Forms)
    func testRenewalVerbs() {
        let analysis = latinService.analyzePsalm(id, text: psalm102)
        
        let renewalTerms = [
            ("renovo", ["renovabitur"], "renew"), // Psalm 102:5 (Eagle metaphor)
            ("redimo", ["redimit"], "redeem"), // Psalm 102:4
            ("sano", ["sanat"], "heal"), // Psalm 102:3
            ("retribuo", ["retribuit"], "repay"), // Psalm 102:10
            ("recordor", ["recordatus"], "remember") // Psalm 102:14 (Deponent)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: renewalTerms)
    }
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(id, text: psalm102)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'corono' forms:", analysis.dictionary["corono"]?.forms ?? [:])
            print("'humilis' forms:", analysis.dictionary["humilis"]?.forms ?? [:])
            print("'propitior' forms:", analysis.dictionary["propitior"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }

    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Form verification (case-insensitive)
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
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}