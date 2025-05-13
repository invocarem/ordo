import XCTest
@testable import LatinService
class Psalm21Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm21 = [
        "Deus, Deus meus, respice in me: quare me dereliquisti? longe a salute mea verba delictorum meorum.",
        "Deus meus, clamabo per diem, et non exaudies; et nocte, et non ad insipientiam mihi.",
        "Tu autem in sancto habitas, laus Israel.",
        "In te speraverunt patres nostri; speraverunt, et liberasti eos.",
        "Ad te clamaverunt, et salvi facti sunt; in te speraverunt, et non sunt confusi.",
        "Ego autem sum vermis et non homo; opprobrium hominum et abjectio plebis.",
        "Omnes videntes me deriserunt me; locuti sunt labiis, et moverunt caput.",
        "Speravit in Domino, eripiat eum; salvum faciat eum, quoniam vult eum.",
        "Quoniam tu es qui extraxisti me de ventre, spes mea ab uberibus matris meae.",
        "In te projectus sum ex utero; de ventre matris meae Deus meus es tu.",
        "Ne discesseris a me, quoniam tribulatio proxima est, quoniam non est qui adjuvet.",
        "Circumdederunt me vituli multi; tauri pingues obsederunt me.",
        "Aperuerunt super me os suum, sicut leo rapiens et rugiens.",
        "Sicut aqua effusus sum, et dispersa sunt omnia ossa mea; factum est cor meum tamquam cera liquescens in medio ventris mei.",
        "Aruit tamquam testa virtus mea, et lingua mea adhaesit faucibus meis; et in pulverem mortis deduxisti me.",
        "Quoniam circumdederunt me canes multi; concilium malignantium obsedit me.",
        "Foderunt manus meas et pedes meos; dinumeraverunt omnia ossa mea.",
        "Ipsi vero consideraverunt et conspexerunt me; diviserunt sibi vestimenta mea, et super vestem meam miserunt sortem.",
        "Tu autem, Domine, ne elongaveris auxilium tuum a me; ad defensionem meam conspice.",
        "Erue a framea animam meam, et de manu canis unicam meam.",
        "Salva me ex ore leonis, et a cornibus unicornium humilitatem meam.",
        "Narrabo nomen tuum fratribus meis; in medio ecclesiae laudabo te.",
        "Qui timetis Dominum, laudate eum; universum semen Jacob, glorificate eum.",
        "Timeat eum omne semen Israel, quoniam non sprevit neque despexit deprecationem pauperis; nec avertit faciem suam a me, et cum clamarem ad eum, exaudivit me.",
        "Apud te laus mea in ecclesia magna; vota mea reddam in conspectu timentium eum.",
        "Edent pauperes, et saturabuntur; et laudabunt Dominum qui requirunt eum: vivent corda eorum in saeculum saeculi.",
        "Reminiscentur et convertentur ad Dominum universi fines terrae; et adorabunt in conspectu ejus universae familiae gentium.",
        "Quoniam Domini est regnum; et ipse dominabitur gentium.",
        "Manducaverunt et adoraverunt omnes pingues terrae; in conspectu ejus cadent omnes qui descendunt in terram.",
        "Et anima mea illi vivet; et semen meum serviet ipsi.",
        "Annuntiabitur Domino generatio ventura; et annuntiabunt justitiam ejus populo qui nascetur, quem fecit Dominus."
    ]
    
    // MARK: - Test Cases
    
    // 1. Test Christological Suffering Vocabulary (vv.1–21)
    func testSufferingTerms() {
        let analysis = latinService.analyzePsalm(text: psalm21)
        
        let sufferingTerms = [
            ("derelinquo", ["dereliquisti"], "forsake"),         // "Why have you forsaken me?" (v.1)
            ("vermis", ["vermis"], "worm"),                     // "I am a worm, not a man" (v.6)
            ("opprobrium", ["opprobrium"], "scorn"),            // Scorn of men (v.6)
            ("fodio", ["Foderunt"], "pierce"),                  // "They pierced my hands/feet" (v.17)
            ("os", ["ossa", "os"], "bone"),              // Bones out of joint (v.14), mouth of lions (v.13)
            ("cera", ["cera"], "wax"),                          // "Heart melted like wax" (v.14)
            ("testa", ["testa"], "potsherd"),                   // "Strength dried like pottery" (v.15)
            ("sors", ["sortem"], "lot")                         // Casting lots for garments (v.18)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sufferingTerms)
    }
    
    // 2. Test Animal Imagery (Enemies as Beasts)
    func testAnimalMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm21)
        
        let animalTerms = [
            ("vitulus", ["vituli"], "calf"),                    // "Many bulls surround me" (v.12)
            ("taurus", ["tauri"], "bull"),                      // "Fat bulls encircle me" (v.12)
            ("leo", ["leo", "leonis"], "lion"),                 // Lion's mouth (v.13, v.21)
            ("canis", ["canes", "canis"], "dog"),               // "Dogs surround me" (v.16, v.20)
            ("unicornis", ["unicornium"], "unicorn")            // "Horns of unicorns" (v.21)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: animalTerms)
    }
    
    // 3. Test Redemptive Shift (vv.22–31)
    func testRedemptionTerms() {
        let analysis = latinService.analyzePsalm(text: psalm21)
        
        let redemptionTerms = [
            ("ecclesia", ["ecclesiae", "ecclesia"], "assembly"), // Praise in the assembly (v.22, v.25)
            ("laudo", ["laudabo", "laudate"], "praise"),     // "I will praise you" (v.22, v.23)
            ("semen", ["semen", "semen"], "offspring"),         // "All descendants of Jacob" (v.23, v.30)
            ("adoro", ["adorabunt"], "worship"),                // "All families will worship" (v.27)
            ("regnum", ["regnum"], "kingdom")                   // "The kingdom is the Lord's" (v.28)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: redemptionTerms)
    }
    
    
    
    // 5. Test Explicit Christological Fulfillment
   
     func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm21)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'tribulor' forms:", analysis.dictionary["tribulor"]?.forms ?? [:])
            print("'laudo' forms:", analysis.dictionary["laudo"]?.forms ?? [:])
            print("'perdo' forms:", analysis.dictionary["perdo"]?.forms ?? [:])
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    // MARK: - Helper (Same case-insensitive version as before)
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        let caseInsensitiveDict = Dictionary(uniqueKeysWithValues: 
            analysis.dictionary.map { ($0.key.lowercased(), $0.value) }
        )
        
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = caseInsensitiveDict[lemma.lowercased()] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Case-insensitive translation check
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Case-insensitive form check
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