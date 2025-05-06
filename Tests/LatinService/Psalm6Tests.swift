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
    
    // MARK: - Test Cases
    
    func testPenitentialVocabulary() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let penitentialTerms = [
            ("misereor", ["miserere"], "have mercy"),
            ("fletus", ["fletus"], "weeping"),
            ("lacrima", ["lacrimis"], "tears"),
            ("gemitus", ["gemitu"], "groaning"),
            ("infernus", ["inferno"], "hell")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: penitentialTerms)
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
            ("convertere", ["convertere"], "turn back"), // Deponent imperative
            ("discedo", ["discedite"], "depart"), // Plural imperative
            ("eripio", ["eripe"], "rescue")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: commands)
    }
    
    func testBodyPartMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm6)
        
        let bodilyTerms = [
            ("os", ["ossa"], "bones"),
            ("oculus", ["oculus"], "eye"),
            ("animus", ["anima"], "soul")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodilyTerms)
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