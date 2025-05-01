import XCTest
@testable import LatinService

class Psalm89Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm89 = [
         "Domine, refugium factus es nobis a generatione et progenie.",
                "Priusquam montes fierent, aut formaretur terra et orbis: a saeculo et usque in saeculum tu es, Deus.",
                "Ne avertas hominem in humilitatem: et dixisti: Convertimini, filii hominum.",
                "Quoniam mille anni ante oculos tuos, tamquam dies hesterna quae praeteriit: et custodia in nocte.",
                "Quae pro nihilo habentur, eorum anni erunt.",
                "Mane sicut herba transeat; mane floreat, et transeat: vespere decidat, induret, et arescat.",
                "Quia defecimus in ira tua, et in furore tuo turbati sumus.",
                "Posuisti iniquitates nostras in conspectu tuo: saeculum nostrum in illuminatione vultus tui.",
                "Quoniam omnes dies nostri defecerunt: et in ira tua defecimus. Anni nostri sicut aranea meditabuntur.",
                "Dies annorum nostrorum in ipsis septuaginta anni. Si autem in potentatibus octoginta anni: et amplius eorum labor et dolor.",
                "Quoniam supervenit mansuetudo, et corripiemur.",
                "Quis novit potestatem irae tuae? et prae timore tuo iram tuam dinumerare?",
                "Dextera tua sic notam fac: et eruditos corde in sapientia.",
                "Convertere, Domine, usquequo? et deprecabilis esto super servos tuos.",
                "Repleti sumus mane misericordia tua: et exsultavimus, et delectati sumus omnibus diebus nostris.",
                "Laetati sumus pro diebus quibus nos humiliasti: annis quibus vidimus mala.",
                "Respice in servos tuos, et in opera tua: et dirige filios eorum.",
                "Et sit splendor Domini Dei nostri super nos: et opera manuum nostrarum dirige super nos: et opus manuum nostrarum dirige."        
    ]
    
    // MARK: - Test Cases
    
    func testTemporalVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm89)
        
        let timeTerms = [
            ("saeculum", ["saeculum", "saeculo"], "age"),
            ("generatio", ["generatione"], "generation"),
            ("progenies", ["progenie"], "offspring"),
            ("mille", ["mille"], "thousand"),
            ("custodia", ["custodia"], "watch")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: timeTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm89)
        
        let divineTerms = [
            ("refugium", ["refugium"], "refuge"),
            ("mansuetudo", ["mansuetudo"], "gentleness"),
            ("splendor", ["splendor"], "brightness"),
            ("dextera", ["dextera"], "right hand"),
            ("illuminatio", ["illuminatione"], "light")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: divineTerms)
    }
    
    func testMortalityMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm89)
        
        let mortalTerms = [
            ("herba", ["herba"], "grass"),
            ("aranea", ["aranea"], "spider's web"),
            ("floreo", ["floreat"], "to bloom")
          
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: mortalTerms)
    }
    
    func testStructuralVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm89)
        
        let keyVerbs = [
            ("formo", ["formaretur"], "form"),
            ("deficio", ["defecimus", "defecerunt"], "fail"),
            ("dinumero", ["dinumerare"], "reckon"),
            ("dirigo", ["dirige"], "direct")
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