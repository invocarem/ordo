import XCTest
@testable import LatinService

class Psalm9ATests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 9A)
    let psalm9A = [
        "Confitebor tibi, Domine, in toto corde meo; narrabo omnia mirabilia tua.",
        "Laetabor et exsultabo in te; psallam nomini tuo, Altissime.",
        "In convertendo inimicum meum retrorsum, infirmabuntur, et peribunt a facie tua.",
        "Quoniam fecisti judicium meum et causam meum; sedisti super thronum, qui judicas justitiam.",
        "Increpasti gentes, et periit impius; nomen eorum delesti in aeternum, et in saeculum saeculi.",
        "Inimici defecerunt frameae in finem: et civitates destruxisti; periit memoria eorum cum sonitu.",
        "Et Dominus in aeternum permanet; paravit in judicio thronum suum.",
        "Et ipse judicabit orbem terrae in aequitate; judicabit populos in justitia.",
        "Et factus est Dominus refugium pauperi; adjutor in opportunitatibus, in tribulatione.",
        "Et sperent in te qui noverunt nomen tuum; quoniam non dereliquisti quaerentes te, Domine.",
        "Psallite Domino, qui habitat in Sion; annuntiate inter gentes studia ejus:",
        "Quoniam requirens sanguinem eorum recordatus est; non est oblitus clamorem pauperum.",
        "Miserere mei, Domine; vide humilitatem meam de inimicis meis,",
        "Qui exaltas me de portis mortis, ut annuntiem omnes laudationes tuas in portis filiae Sion.",
        "Exsultabo in salutari tuo; infixae sunt gentes in interitu quem fecerunt; in laqueo isto quem absconderunt comprehensus est pes eorum.",
        "Cognoscitur Dominus judicia faciens; in operibus manuum suarum comprehensus est peccator.",
        "Convertantur peccatores in infernum, omnes gentes quae obliviscuntur Deum.",
        "Quoniam non in finem oblivio erit pauperis; patientia pauperum non peribit in finem."
    ]
    
    // MARK: - Test Cases
    
    func testPraiseVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm9A)
        
        let praiseTerms = [
            ("confiteor", ["confitebor"], "confess"), // v.1
            ("narro", ["narrabo"], "declare"), // v.1
            ("laetor", ["laetabor"], "rejoice"), // v.2
            ("exsulto", ["exsultabo", "exsultabo"], "exult"), // v.2, v.14
            ("psallo", ["psallam", "psallite"], "praise") // v.2, v.11
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: praiseTerms)
    }
    
    func testDivineJustice() {
        let analysis = latinService.analyzePsalm(text: psalm9A)
        
        let justiceTerms = [
            ("judicium", ["judicium", "judicio", "judicia"], "judgment"), // v.4, v.7, v.16
            ("justus", ["justitiam", "justitia"], "justice"), // v.4, v.8
            ("aequitas", ["aequitate"], "equity"), // v.8
            ("requiro", ["requirens"], "seek") // v.12
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
    }
    
    func testEnemyFate() {
        let analysis = latinService.analyzePsalm(text: psalm9A)
        
        let enemyTerms = [
            ("inimicus", ["inimicum", "inimici", "inimicis"], "enemy"), // v.3, v.6, v.13
            ("impius", ["impius"], "wicked"), // v.5
            ("peccator", ["peccator", "peccatores"], "sinner"), // v.16, v.17
            ("pereo", ["peribunt", "periit", "peribit"], "perish") // v.3, v.5, v.18
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    
    func testDivineProtection() {
        let analysis = latinService.analyzePsalm(text: psalm9A)
        
        let protectionTerms = [
            ("refugium", ["refugium"], "refuge"), // v.9
            ("adjutor", ["adjutor"], "helper"), // v.9
            ("salutor", ["salutari"], "greet"), // v.14
            ("exalto", ["exaltas"], "raise up") // v.13
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testEternalNature() {
        let analysis = latinService.analyzePsalm(text: psalm9A)
        
        let eternalTerms = [
            ("aeternus", ["aeternum", "aeternum"], "forever"), // v.5, v.7
            ("saeculum", ["saeculum"], "age"), // v.5
            ("permaneo", ["permanet"], "endure"), // v.7
            ("finis", ["finem", "finem"], "end") // v.6, v.18
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: eternalTerms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
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

class Psalm9BTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 9B)
    let psalm9B = [
        "Exsurge, Domine, non praevaleat homo; judicentur gentes in conspectu tuo.",
        "Constitue, Domine, legislatorem super eos, ut sciant gentes quoniam homines sunt.",
        "Ut quid, Domine, recessisti longe, despicis in opportunitatibus, in tribulatione?",
        "Dum superbit impius, incenditur pauper; comprehenduntur in consiliis quibus cogitant.",
        "Quoniam laudatur peccator in desideriis animae suae, et iniquus benedicitur.",
        "Exacerbavit Dominum peccator, secundum multitudinem irae suae non quaeret:",
        "Non est Deus in conspectu eius; inquinatae sunt viae illius in omni tempore.",
        "Auferuntur judicia tua a facie eius; omnium inimicorum suorum dominabitur.",
        "Dixit enim in corde suo: Non movebor a generatione in generationem sine malo.",
        "Cujus maledictione os plenum est, et amaritudine, et dolo; sub lingua ejus labor et dolor.",
        "Sedet in insidiis cum divitibus in occultis, ut interficiat innocentem;",
        "Oculi ejus in pauperem respiciunt; insidiatur in abscondito, quasi leo in spelunca sua.",
        "Insidiatur ut rapiat pauperem; rapere pauperem dum attrahit eum.",
        "In laqueo suo humiliabit eum; inclinabit se, et cadet cum dominatus fuerit pauperum.",
        "Dixit enim in corde suo: Oblitus est Deus, avertit faciem suam ne videat in finem.",
        "Exsurge, Domine Deus, exaltetur manus tua; ne obliviscaris pauperum.",
        "Propter quid irritavit impius Deum? dixit enim in corde suo: Non requiret.",
        "Vides quoniam tu laborem et dolorem consideras, ut tradas eos in manus tuas.",
        "Tibi derelictus est pauper; orphano tu eris adjutor.",
        "Contere brachium peccatoris et maligni; quaeretur peccatum illius, et non invenietur.",
        "Dominus regnabit in aeternum, et in saeculum saeculi; peribitis, gentes, de terra illius.",
        "Desiderium pauperum exaudivit Dominus; praeparationem cordis eorum audivit auris tua,",
        "Judicare pupillo et humili, ut non apponat ultra magnificare se homo super terram."
    ]
    
    // MARK: - Test Cases
    
    func testDivineIntervention() {
        let analysis = latinService.analyzePsalm(text: psalm9B)
        
        let interventionTerms = [
            ("exsurgo", ["exsurge", "exsurge"], "arise"), // v.1, v.16
            ("judico", ["judicentur"], "judge"), // v.1
            ("constituo", ["constitue"], "appoint"), // v.2
            ("contero", ["contere"], "crush") // v.20
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: interventionTerms)
    }
    
    func testWickedCharacteristics() {
        let analysis = latinService.analyzePsalm(text: psalm9B)
        
        let wickedTerms = [
            ("impius", ["impius", "impius"], "wicked"), // v.4, v.17
            ("peccator", ["peccator", "peccatoris"], "sinner"), // v.5, v.20
            ("iniquus", ["iniquus"], "unjust"), // v.5
            ("dolus", ["dolo"], "deceit"), // v.10
            ("insidia", ["insidiis" ], "ambush"), // v.11, v.12, v.13
            ("insidior", ["insidiatur", "insidiatur"], "ambush") // v.12, v.13
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: wickedTerms)
    }
    
    func testPoorAndOppressed() {
        let analysis = latinService.analyzePsalm(text: psalm9B)
        
        let poorTerms = [
            ("pauper", ["pauper", "pauperem", "pauperum", "pauperum"], "poor"), // v.4, v.12, v.14, v.16
            ("innocens", ["innocentem"], "innocent"), // v.11
            ("pupillus", ["pupillo"], "orphan"), // v.23
            ("humilis", ["humili"], "humble") // v.23
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: poorTerms)
    }
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm9B)
        
        let attributeTerms = [
            ("legislator", ["legislatorem"], "lawgiver"), // v.2
            ("regno", ["regnabit"], "reign"), // v.21
            ("judico", ["judicare"], "judge"), // v.23
            ("obliviscor", ["obliviscaris"], "forget") // v.16 (negative)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: attributeTerms)
    }
    
    func testEschatologicalHope() {
        let analysis = latinService.analyzePsalm(text: psalm9B)
        
        let hopeTerms = [
            ("aeternus", ["aeternum"], "forever"), // v.21
            ("saeculum", ["saeculum"], "age"), // v.21
            ("pereo", ["peribitis"], "perish"), // v.21
            ("exaudio", ["exaudivit"], "hear") // v.22
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
            
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
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