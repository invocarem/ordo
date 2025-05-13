import XCTest
@testable import LatinService

class Psalm20Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm20 = [
        "Domine, in virtute tua laetabitur rex, et super salutare tuum exsultabit vehementer.",
        "Desiderium cordis ejus tribuisti ei, et voluntatem labiorum ejus non fraudasti eum.",
        "Quoniam praevenisti eum in benedictionibus dulcedinis; posuisti in capite ejus coronam de lapide pretioso.",
        "Vitam petiit a te, et tribuisti ei longitudinem dierum in saeculum saeculi.",
        "Magna est gloria ejus in salutari tuo; gloriam et magnum decorem impones super eum.",
        "Quoniam dabis eum in benedictionem in saeculum saeculi; laetificabis eum in gaudio cum vultu tuo.",
        "Quoniam rex sperat in Domino, et in misericordia Altissimi non commovebitur.",
        "Inveniatur manus tua omnibus inimicis tuis; dextera tua inveniat omnes qui te oderunt.",
        "Pones eos ut clibanum ignis in tempore vultus tui; Dominus in ira sua conturbabit eos, et devorabit eos ignis.",
        "Fructum eorum de terra perdes, et semen eorum a filiis hominum.",
        "Quoniam declinaverunt in te mala; cogitaverunt consilia quae non potuerunt stabilire.",
        "Quoniam pones eos dorsum; in reliquiis tuis praeparabis vultum eorum.",
        "Exaltare, Domine, in virtute tua; cantabimus et psallemus virtutes tuas."
    ]
    
    // MARK: - Test Cases
    
    // 1. Test Royal Vocabulary
    func testRoyalTerms() {
        let analysis = latinService.analyzePsalm(text: psalm20)
        
        let royalTerms = [
            ("rex", ["rex", "rex"], "king"),                     // King (v.1, v.7)
            ("corona", ["coronam"], "crown"),                    // Crown of precious stone (v.3)
            ("gloria", ["gloria", "gloriam"], "glory"),           // Glory (v.5)
            ("decor", ["decorem"], "splendor"),                   // Majesty (v.5)
            ("altissimus", ["Altissimi"], "Most High")            // Divine title (v.7)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: royalTerms)
    }
    
    // 2. Test Divine Favor Motifs
    func testDivineFavor() {
        let analysis = latinService.analyzePsalm(text: psalm20)
        
        let favorTerms = [
            ("tribuo", ["tribuisti", "tribuisti"], "grant"),      // Granted desires (v.2, v.4)
            ("praevenio", ["praevenisti"], "anticipate"),         // "You met him" (v.3)
            ("laetifico", ["laetificabis"], "gladden"),           // "You will fill with joy" (v.6)
            ("benedictio", ["benedictionibus", "benedictionem"], "blessing"), // Blessings (v.3, v.6)
            ("dulcedo", ["dulcedinis"], "sweetness")             // "Blessings of sweetness" (v.3)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: favorTerms)
    }
    
    // 3. Test Militaristic Judgment
    func testJudgmentTerms() {
        let analysis = latinService.analyzePsalm(text: psalm20)
        
        let judgmentTerms = [
            ("clibanus", ["clibanum"], "furnace"),               // "Oven of fire" (v.9)
            ("devoro", ["devorabit"], "devour"),                 // Fire devouring (v.9)
            ("perdo", ["perdes"], "destroy"),                    // Destroy fruit/enemies (v.10)
            ("dextera", ["dextera"], "right hand"),              // God's victorious hand (v.8)
            ("dorsum", ["dorsum"], "back")                       // Enemies turned back (v.12)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
    }
    
    // 4. Test Eschatological Promises
    func testEternalPromises() {
        let analysis = latinService.analyzePsalm(text: psalm20)
        
        let eternalTerms = [
            ("saeculum", ["saeculum", "saeculi", "saeculi"], "age"), // Eternal duration (v.4, v.6)
            ("longitudo", ["longitudinem"], "length"),            // "Length of days" (v.4)
            ("semen", ["semen"], "offspring"),                    // Cutting off enemy lineage (v.10)
            ("stabilio", ["stabilire"], "establish"),             // Failed enemy plans (v.11)
            ("exalto", ["Exaltare"], "exalt")                     // God exalted (v.13)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: eternalTerms)
    }
    
    // 5. Test Structural Movement (Favor → Judgment → Praise)
    func testStructuralThemes() {
        let favorVerses = Array(psalm20[0..<7])  // v.1-7: Divine favor
        let judgmentVerses = Array(psalm20[7..<12]) // v.8-12: Judgment
        let praiseVerses = Array(psalm20[12..<13]) // v.13: Doxology
        
        // Verify thematic keywords in each section
        XCTAssertTrue(favorVerses.contains { $0.contains("coronam") }, "Favor section missing crown imagery")
        XCTAssertTrue(judgmentVerses.contains { $0.contains("clibanum") }, "Judgment section missing furnace")
        XCTAssertTrue(praiseVerses.contains { $0.contains("cantabimus") }, "Praise section missing singing")
        
        if verbose {
            print("\n=== Structural Analysis ===")
            print("Favor Verses (1-7):", favorVerses.joined(separator: " | "))
            print("\nJudgment Verses (8-12):", judgmentVerses.joined(separator: " | "))
            print("\nPraise Verse (13):", praiseVerses.first!)
        }
    }
    
    // MARK: - Helper
    
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm20)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'tribulor' forms:", analysis.dictionary["tribulor"]?.forms ?? [:])
            print("'solitudo' forms:", analysis.dictionary["solitudo"]?.forms ?? [:])
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