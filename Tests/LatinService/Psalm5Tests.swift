import XCTest
@testable import LatinService

class Psalm5Tests: XCTestCase {
    private var latinService: LatinService!
    let id = PsalmIdentity(number: 5, section: nil)
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm5 = [
        "Verba mea auribus percipe, Domine, intellige clamorem meum.",
        "Intende voci orationis meae, Rex meus et Deus meus.",
        "Quoniam ad te orabo, Domine; mane exaudies vocem meam.",
        "Mane astabo tibi et videbo, quoniam non Deus volens iniquitatem tu es.",
        "Neque habitabit iuxta te malignus, neque permanebunt impii ante oculos tuos.",
        "Odisti omnes qui operantur iniquitatem; perdes omnes qui loquuntur mendacium.",
        "Virum sanguinum et dolosum abominabitur Dominus.",
        "Ego autem in multitudine misericordiae tuae introibo in domum tuam;",
        "adorabo ad templum sanctum tuum in timore tuo.",
        "Domine, deduc me in iustitia tua; propter inimicos meos dirige in conspectu tuo viam meam.",
        "Quoniam non est in ore eorum veritas; cor eorum vanum est.",
        "Sepulchrum patens est guttur eorum; linguis suis dolose agebant, judica illos, Deus.",
        "Decidant a cogitationibus suis; secundum multitudinem impietatum eorum expelle eos,",
        "quoniam irritaverunt te, Domine.",
        "Et laetentur omnes qui sperant in te; in aeternum exultabunt, et habitabis in eis.",
        "Et gloriabuntur in te omnes qui diligunt nomen tuum,",
        "quoniam tu benedices iusto, Domine; quasi scuto bonae voluntatis coronasti nos."
    ]
    
    // MARK: - Thematic Test Cases
    
    // 1. Morning Prayer Theme
    func testMorningPrayerTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm5)
        
        let morningTerms = [
            ("mane", ["mane", "mane"], "morning"), // v.3,4
            ("astabo", ["astabo"], "stand ready"), // v.4
            ("oratio", ["orationis"], "prayer"), // v.2
            ("exaudio", ["exaudies"], "hear") // v.3
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: morningTerms)
        
        
    }
    
    // 2. Divine Justice Theme
    func testDivineJusticeTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm5)
        
        let justiceTerms = [
            ("iniquitas", ["iniquitatem", "iniquitatem"], "wickedness"), // v.4,6
            ("impius", ["impii", "impietatum"], "wicked"), // v.5,13
            ("mendacium", ["mendacium"], "lie"), // v.6
            ("judico", ["judica"], "judge"), // v.12
            ("justus", ["justitia"], "justice") // v.10
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
        
        
    }
    
    // 3. Sanctuary Theme
    func testSanctuaryTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm5)
        
        let sanctuaryTerms = [
            ("domus", ["domum", "domum"], "house"), // v.8,10
            ("templum", ["templum"], "temple"), // v.9
            ("intro", ["introibo"], "enter"), // v.8
            ("adoro", ["adorabo"], "worship") // v.9
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sanctuaryTerms)
    }
    
    // 4. Enemies and Protection
    func testEnemiesTheme() {
        let analysis = latinService.analyzePsalm(text: psalm5)
        
        let enemyTerms = [
            ("inimicus", ["inimicos"], "enemy"), // v.10
            ("sanguis", ["sanguinum"], "bloodthirsty"), // v.7
            ("dolus", ["dolosum", "dolose"], "deceit"), // v.7,12
            ("vanus", ["vanum"], "empty"), // v.11
            ("sepulchrum", ["Sepulchrum"], "grave") // v.12
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    
    // 5. Divine Protection Theme
    func testProtectionTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm5)
        
        let protectionTerms = [
            ("scutum", ["scuto"], "shield"), // v.17
            ("deduco", ["deduc"], "lead"), // v.10
            ("dirigo", ["dirige"], "direct"), // v.10
            ("corono", ["coronasti"], "crown") // v.17
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    // 6. Joy and Blessing Theme
    func testJoyTheme() {
        let analysis = latinService.analyzePsalm(id, text: psalm5)
        
        let joyTerms = [
            ("laetitia", ["laetentur"], "rejoice"), // v.14
            ("exsulto", ["exultabunt"], "exult"), // v.14
            ("glorior", ["gloriabuntur"], "glory"), // v.16
            ("benedico", ["benedices"], "bless"), // v.17
            ("spero", ["sperant"], "hope") // v.14
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: joyTerms)
        
        
    }
    
    // MARK: - Helper Methods
    
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, 
                                     confirmedWords: [(lemma: String, 
                                                     forms: [String], 
                                                     translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain through translation
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
                print("  Forms found: \(entry.forms.keys.filter { forms.map { $0.lowercased() }.contains($0) }.count)/\(forms.count)")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
    
   
}