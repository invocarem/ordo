import XCTest
@testable import LatinService

class Psalm6Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm6 = [
        "Domine, ne in furore tuo arguas me, neque in ira tua corripias me.",
        "Miserere mei, Domine, quoniam infirmus sum; sana me, Domine, quoniam conturbata sunt ossa mea.",
        "Et anima mea turbata est valde; sed tu, Domine, usquequo?",
        "Convertere, Domine, et eripe animam meam; salvum me fac propter misericordiam tuam.",
        "Quoniam non est in morte qui memor sit tui; in inferno autem quis confitebitur tibi?",
        "Laboravi in gemitu meo, lavabo per singulas noctes lectum meum; lacrimis meis stratum meum rigabo.",
        "Turbatus est a furore oculus meus; inveteravi inter omnes inimicos meos.",
        "Discedite a me, omnes qui operamini iniquitatem, quoniam exaudivit Dominus vocem fletus mei.",
        "Exaudivit Dominus deprecationem meam; Dominus orationem meam suscepit.",
        "Erubescant et conturbentur vehementer omnes inimici mei; convertantur et erubescant valde velociter."
    ]
    func testUnlemmatizedWords() {
    let analysis = latinService.analyzePsalm(text: psalm6)
    
    // Print words with only 1 occurrence (likely not lemmatized)
    let unlemmatized = analysis.dictionary.filter { $0.value.forms.count == 1 }
    print("\n=== Unlemmatized Words ===")
    unlemmatized.forEach { lemma, entry in
        print("Lemma: \(lemma) → Form: \(entry.forms.keys.first!)")
    }
    
    // Print frequency of high-count words
    print("\n=== High-Frequency Forms ===")
    let forms = psalm6.flatMap { $0.components(separatedBy: .whitespaces) }
    let frequencyDict = Dictionary(grouping: forms, by: { $0.lowercased() })
        .mapValues { $0.count }
        .sorted { $0.value > $1.value }
    
    frequencyDict.prefix(10).forEach { word, count in
        print("\(word): \(count)x")
    }
}
    // MARK: - Test Cases
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            print("'gemitus' forms:", analysis.dictionary["gemitus"]?.forms ?? [:])
            print("'rigo' forms:", analysis.dictionary["rigo"]?.forms ?? [:])
            print("'fio' forms:", analysis.dictionary["fio"]?.forms ?? [:])
            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    func testPenitentialVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let penitentialTerms = [
            ("misereor", ["miserere"], "have mercy"),
            ("fletus", ["fletus"], "weeping"),
            ("lacrima", ["lacrimis"], "tear"),
            ("gemitus", ["gemitu"], "groaning"),
            ("infernus", ["inferno"], "hell")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: penitentialTerms)
    }
    func testConturboForms() {
    let analysis = latinService.analyzePsalm(text: psalm6)
    verifyWordsInAnalysis(
        analysis,
        confirmedWords: [("conturbo", ["conturbata", "conturbentur"], "trouble")]
    )
}

func testTurboForms() {
    let analysis = latinService.analyzePsalm(text: psalm6)
    verifyWordsInAnalysis(
        analysis,
        confirmedWords: [("turbo", ["turbata", "turbatus"], "disturb")]
    )
}
    func testUniqueVerbForms() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let rareVerbs = [
            ("invetero", ["inveteravi"], "grow old"), // Hapax legomenon
            ("rigo", ["rigabo"], "drench"),
            ("erubesco", ["erubescant"], "ashamed"),
            ("confiteor", ["confitebitur"], "confess")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: rareVerbs)
    }
    
    func testImperatives() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let commands = [
            ("converto", ["convertere"], "turn back"), // Deponent imperative
            ("discedo", ["discedite"], "depart"), // Plural imperative
            ("eripio", ["eripe"], "rescue")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: commands)
    }
    func testImperativesAndDeponents() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let imperatives = [
            ("arguo", ["arguas"], "rebuke"),
            ("converto", ["convertere"], "turn back"),
            ("eripio", ["eripe"], "deliver"),
            ("exaudio", ["exaudivit"], "hear"),
            ("suscipio", ["suscepit"], "receive")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: imperatives)
    }
    
    func testBodyPartMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let bodilyTerms = [
            ("os", ["ossa"], "bone"),
            ("oculus", ["oculus"], "eye"),
            ("animus", ["anima"], "soul")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodilyTerms)
    }
 func testRemainingVerbLemmas() {
    let analysis = latinService.analyzePsalm(text: psalm6)
    
    let untestedVerbs = [
        ("arguo", ["arguas"], "rebuke"),      // Ps 6:1 ("ne in furore tuo arguas me")
        ("corripio", ["corripias"], "rerrect"), // Ps 6:1 ("neque in ira tua corripias me")
        ("sano", ["sana"], "heal"),          // Ps 6:2 ("sana me, Domine")
        ("laboro", ["laboravi"], "labor"),    // Ps 6:6 ("Laboravi in gemitu meo")
        ("lavo", ["lavabo"], "wash"),        // Ps 6:6 ("lavabo per singulas noctes lectum meum")       
         ("fio", ["fiet"], "become"),
         ("memor", ["memor"], "mindful"),  // Ps 6:5 ("non est in morte qui memor sit tui")
        ("velox", ["velociter"], "swift") 
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: untestedVerbs)
}   
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation match
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "Translation mismatch for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify form existence
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            XCTAssertTrue(
                missingForms.isEmpty,
                "\(lemma) missing forms: \(missingForms.joined(separator: ", "))"
            )
            
            if verbose {
                print("\n\(lemma.uppercased()) (\"\(translation)\")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count)x")
                }
            }
        }
    }
}