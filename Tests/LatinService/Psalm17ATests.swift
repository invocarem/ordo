import XCTest
@testable import LatinService

class Psalm17ATests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm17A = [
        "Diligo te, Domine, fortitudo mea;",
        "Dominus firmamentum meum, et refugium meum, et liberator meus.",
        "Deus meus, adjutor meus, et sperabo in eum;",
        "protector meus, et cornu salutis meae, et susceptor meus.",
        "Laudans invocabo Dominum, et ab inimicis meis salvus ero.",
        "Circumdederunt me dolores mortis, et torrentes iniquitatis conturbaverunt me.",
        "Dolores inferni circumdederunt me, praeoccupaverunt me laquei mortis.",
        "In tribulatione mea invocavi Dominum, et ad Deum meum clamavi;",
        "exaudivit de templo sancto suo vocem meam, et clamor meus in conspectu ejus introivit in aures ejus.",
        "Commota est, et contremuit terra; fundamenta montium conturbata sunt,",
        "et commota sunt, quoniam iratus est eis.",
        "Ascendit fumus in ira ejus, et ignis a facie ejus exarsit;",
        "carbones succensi sunt ab eo.",
        "Inclinavit coelos, et descendit, et caligo sub pedibus ejus.",
        "Et ascendit super cherubim, et volavit; volavit super pennas ventorum.",
        "Et posuit tenebras latibulum suum; in circuitu ejus tabernaculum ejus,",
        "tenebrosa aqua in nubibus aeris.",
        "Praefulgor ante eum nubes, grando et carbones ignis.",
        "Et intonuit de coelo Dominus, et Altissimus dedit vocem suam:",
        "grandinem et carbones ignis.",
        "Et misit sagittas suas, et dissipavit eos;",
        "fulgura multiplicavit, et conturbavit eos.",
        "Et apparuerunt fontes aquarum, et revelata sunt fundamenta orbis terrarum",
        "ab increpatione tua, Domine, ab inspiratione spiritus irae tuae.",
        "Misit de summo, et accepit me; assumpsit me de aquis multis.",
        "Eripuit me de inimico meo potentissimo, et ab his qui oderunt me:",
        "quoniam confortati sunt super me.",
        "Praevenerunt me in die afflictionis meae, et factus est Dominus protector meus.",
        "Et eduxit me in latitudinem; salvum me fecit, quoniam voluit me.",
        "Retribuet mihi Dominus secundum justitiam meam, et secundum puritatem manuum mearum retribuet mihi.",
        "Quia custodivi vias Domini, nec impie gessi a Deo meo.",
        "Quoniam omnia judicia ejus in conspectu meo, et justitias ejus non repuli a me.",
        "Et ero immaculatus cum eo, et observabo me ab iniquitate mea.",
        "Et retribuet mihi Dominus secundum justitiam meam, et secundum puritatem manuum mearum in conspectu oculorum ejus."
    ]
    
    // MARK: - Test Cases
    
    func testDivineWarfareImagery() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let warfareTerms = [
            ("sagitta", ["sagittas"], "arrow"),
            ("fulgur", ["fulgura"], "lightning"),
            ("tono", ["intonuit"], "thunder"),
            ("ignis", ["ignis"], "fire"),
            ("carbo", ["carbones"], "coals"),
            ("grando", ["grandinem", "grando"], "hail"),
            ("fumus", ["fumus"], "smoke")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: warfareTerms)
    }
    
    func testDivineProtectionTitles() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let protectionTerms = [
            ("firmamentum", ["firmamentum"], "fortress"),
            ("susceptor", ["susceptor"], "upholder"),
            ("cornu", ["cornu"], "horn"),
            ("latibulum", ["latibulum"], "hiding place"),
            ("tabernaculum", ["tabernaculum"], "tent")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testCosmicDisturbances() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let cosmicTerms = [
            ("contremo", ["contremuit"], "tremble"),
            ("inclino", ["Inclinavit"], "bow down"),
            ("caligo", ["caligo"], "darkness"),
            ("fundamentum", ["fundamenta", "fundamenta"], "foundation"),
            ("cherub", ["cherubim"], "cherubim")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: cosmicTerms)
    }
    
    func testDeliveranceVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let deliveranceTerms = [
            ("eripio", ["Eripuit"], "rescue"),
            ("assumo", ["assumpsit"], "take up"),
            ("educo", ["eduxit"], "lead out"),
            ("praevenio", ["Praevenerunt"], "confront"),
            ("retribuo", ["Retribuet", "retribuet"], "repay")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: deliveranceTerms)
    }
    
    func testPurityVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm17A)
        
        let purityTerms = [
            ("immaculatus", ["immaculatus"], "blameless"),
            ("puritas", ["puritatem"], "purity"),
            ("iniquitas", ["iniquitate", "iniquitatis"], "wickedness"),
            ("justitia", ["justitiam", "justitias"], "righteousness"),
            ("judicium", ["judicia"], "judgment")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: purityTerms)
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