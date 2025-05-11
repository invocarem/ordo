import XCTest
@testable import LatinService

class Psalm101Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Same as before)
     let psalm101 = [
        "Domine, exaudi orationem meam, et clamor meus ad te veniat.",
        "Ne avertas faciem tuam a me; in quacumque die tribulor, inclina ad me aurem tuam.",
        "In quacumque die invocavero te, velociter exaudi me.",
        "Quia defecerunt sicut fumus dies mei, et ossa mea sicut cremium aruerunt.",
        "Percussus sum ut foenum, et aruit cor meum, quia oblitus sum comedere panem meum.",
        "A voce gemitus mei adhaesit os meum carni meae.",
        "Similis factus sum pellicano solitudinis; factus sum sicut nycticorax in domicilio.",
        "Vigilavi, et factus sum sicut passer solitarius in tecto.",
        "Tota die exprobrabant mihi inimici mei; et qui laudabant me adversum me jurabant.",
        "Quia cinerem tamquam panem manducabam, et potum meum cum fletu miscebam.",
        "A facie irae et indignationis tuae, quia elevans allisisti me.",
        "Dies mei sicut umbra declinaverunt, et ego sicut foenum arui.",
        "Tu autem, Domine, in aeternum permanes, et memoriale tuum in generationem et generationem.",
        "Tu exsurgens misereberis Sion, quia tempus miserendi ejus, quia venit tempus.",
        "Quoniam placuerunt servis tuis lapides ejus, et terrae ejus miserebuntur.",
        "Et timebunt gentes nomen tuum, Domine, et omnes reges terrae gloriam tuam.",
        "Quia aedificavit Dominus Sion, et videbitur in gloria sua.",
        "Respexit in orationem humilium, et non sprevit precem eorum.",
        "Scribantur haec in generatione altera, et populus qui creabitur laudabit Dominum.",
        "Quia prospexit de excelso sancto suo; Dominus de caelo in terram aspexit,",
        "ut audiret gemitus compeditorum, ut solveret filios interemptorum,",
        "ut annuntient in Sion nomen Domini, et laudem ejus in Jerusalem,",
        "in conveniendo populos in unum, et reges ut serviant Domino.",
        "Respondit ei in via virtutis suae: Paucitatem dierum meorum nuntia mihi.",
        "Ne revoces me in dimidio dierum meorum; in generationem et generationem anni tui.",
        "Initio tu, Domine, terram fundasti, et opera manuum tuarum sunt caeli.",
        "Ipsi peribunt, tu autem permanes; et omnes sicut vestimentum veterascent,",
        "et sicut opertorium mutabis eos, et mutabuntur.",
        "Tu autem idem ipse es, et anni tui non deficient.",
        "Filii servorum tuorum habitabunt, et semen eorum in saeculum dirigetur."
    ]
    // MARK: - Test Cases
    
    // 1. Test Rare Lament Vocabulary
    func testRareLamentTerms() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let rareLamentTerms = [
            ("cremium", ["cremium"], "burning trash"),  // Hapax legomenon (Psalm 101:4)
            ("nycticorax", ["nycticorax"], "night owl"), // Rare animal metaphor (Psalm 101:7)
            ("pellicanus", ["pellicano"], "pelican"),    // Solitude metaphor (Psalm 101:7)
            ("adhaereo", ["adhaesit"], "cling"),        // "My bones cling to my flesh" (Psalm 101:6)
            ("operorium", ["opertorium"], "covering")    // Metaphor for transience (Psalm 101:27)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareLamentTerms)
    }
    
    // 2. Test Divine Judgment Terms
    func testDivineJudgmentTerms() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let judgmentTerms = [
            ("allido", ["allisisti"], "shatter"),        // "You lifted me up and cast me down" (Psalm 101:11)
            ("exprobro", ["exprobrabant"], "taunt"),     // Enemies mocking (Psalm 101:9)
            ("interimo", ["interemptorum"], "destroy"),  // "To free those doomed to die" (Psalm 101:21)
            ("compeditus", ["compeditorum"], "shackled"), // "Groans of the prisoners" (Psalm 101:21)
            ("veterasco", ["veterascent"], "grow old")   // Creation's decay (Psalm 101:27)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    // 3. Test Rare Restoration Verbs
    func testRareRestorationVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let restorationTerms = [
            ("prospicio", ["prospexit"], "look down"),  // God gazing from heaven (Psalm 101:20)
            ("dirigo", ["dirigetur"], "establish"),     // "Their offspring will be established" (Psalm 101:29)
            ("respicio", ["Respexit"], "consider"),       // God heeding prayer (Psalm 101:18)
            ("annuntio", ["annuntient"], "proclaim"),   // Proclaiming God's name (Psalm 101:22)
            ("convenio", ["conveniendo"], "assemble")    // Gathering nations (Psalm 101:23)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: restorationTerms)
    }
    
    // 4. Test Obscure Body/Famine Terms
    func testObscureBodyTerms() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        
        let bodyTerms = [
            ("fumus", ["fumus"], "smoke"),             // "My days vanish like smoke" (Psalm 101:4)
            ("foenum", ["foenum", "foenum"], "hay"),    // Withering metaphor (Psalm 101:5, 12)
            ("os", ["os"], "bone, mouth"),         // Dual meaning (Psalm 101:6, 6)
            ("potus", ["potum"], "drink"),              // "Mingled my drink with tears" (Psalm 101:10)
            ("venter", ["ventris"], "womb")             // "Fruit of the womb" (Psalm 101:14)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm101)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'dirigo' forms:", analysis.dictionary["dirigo"]?.forms ?? [:])
            print("'humilis' forms:", analysis.dictionary["humilis"]?.forms ?? [:])
            print("'spero' forms:", analysis.dictionary["spero"]?.forms ?? [:])
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