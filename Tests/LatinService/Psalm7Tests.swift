import XCTest
@testable import LatinService

class Psalm7Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm7 = [
        "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me.",
        "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat.",
        "Domine Deus meus, si feci istud, si est iniquitas in manibus meis,",
        "si reddidi retribuentibus mihi mala, decidam merito ab inimicis meis inanis.",
        "Persequatur inimicus animam meam, et comprehendat, et conculcet in terra vitam meam, et gloriam meam in pulverem deducat.",
        "Exsurge, Domine, in ira tua; exaltare in finibus inimicorum meorum.",
        "Et exsurge, Domine Deus meus, in praecepto quod mandasti, et synagoga populorum circumdabit te.",
        "Et propter hanc in altum regredere; Dominus judicat populos.",
        "Judica me, Domine, secundum justitiam meam, et secundum innocentiam meam super me.",
        "Consumetur nequitia peccatorum, et diriges justum, scrutans corda et renes, Deus.",
        "Justum adjutorium meum a Domino, qui salvos facit rectos corde.",
        "Deus judex justus, fortis, et patiens; numquid irascitur per singulos dies?",
        "Nisi conversi fueritis, gladium suum vibrabit; arcum suum tetendit, et paravit illum.",
        "Et in eo paravit vasa mortis; sagittas suas ardentibus effecit.",
        "Ecce parturiit injustitiam, concepit dolorem, et peperit iniquitatem.",
        "Lacum aperuit, et effodit eum, et incidit in foveam quam fecit.",
        "Convertetur dolor ejus in caput ejus, et in verticem ipsius iniquitas ejus descendet.",
        "Confitebor Domino secundum justitiam ejus, et psallam nomini Domini altissimi."
    ]
    
    // MARK: - Thematic Test Cases
func testMissingWords() {
    let analysis = latinService.analyzePsalm(text: psalm7)
    
    let missingWords = [
        ("nequando", ["nequando"], "lest ever"),
        ("rapio", ["rapiat"], "seize"),
        ("aperio", ["aperuit"], "open"),
         ("effodio", ["effodit"], "dig"),
        ("vibro", ["vibrabit"], "brandish")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: missingWords)
}

    func testPoeticReversals() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        let reversalTerms = [
            ("converto", ["convertetur"], "turn back"),
            ("incido", ["incidit"], "fall"),
            ("parturio", ["parturiit"], "give birth"),
            ("fovea", ["foveam"], "pit"),
            ("lacus", ["lacum"], "pit")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: reversalTerms)
    }
    
    func testLegalTrialTheme() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let legalTerms = [
            ("judex", ["judex"], "judge"),
            ("judico", ["judicat", "judica"], "judge"),
            ("justus", ["justitiam", "justitiam"], "justice"),
        
            ("innocentia", ["innocentiam"], "innocence"),
            ("retribuere", ["retribuentibus"], "repay")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: legalTerms)
    }

   

    func testPurityAndDarkness() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        let purityTerms = [
            // Lemma      | Forms in Psalm 7          | Translation
            ("innocentia", ["innocentiam"],           "innocence"),  // v. 9
            ("scrutor",    ["scrutans"],              "examine"),   // v. 10
            ("iniquitas",  ["iniquitas", "iniquitatem"], "wickedness"), // v. 3, 15
            ("pulvis",     ["pulverem"],              "dust")        // v. 6
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: purityTerms)
    }

    
    func testViolentEnemyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let enemyTerms = [
            ("leo", ["leo"], "lion"),
            ("gladius", ["gladium"], "sword"),
            ("arcus", ["arcum"], "bow"),
            ("sagitta", ["sagittas"], "arrow"),
            ("conculco", ["conculcet"], "to trample"),
            ("persequor", ["persequentibus", "persequatur"], "to pursue")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    func testBoomerangJustice() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        // Test both the action and target vocabulary
        let boomerangTerms = [
            ("converto", ["convertetur"], "turn back"),
            ("caput", ["caput"], "head"),
            ("incido", ["incidit"], "fall upon")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: boomerangTerms)
    }
    
    func testPoeticJusticeMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let justiceTerms = [
            ("parturio", ["parturiit"], "to give birth"),
            ("concipio", ["concepit"], "to conceive"),
            ("pario", ["peperit"], "to bring forth"),
            ("fovea", ["foveam"], "pit"),
            ("lacus", ["lacum"], "pit")
           
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: justiceTerms)
    }
    
    func testDivineProtectionTheme() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        
        let protectionTerms = [
            ("spero", ["speravi"], "hope"),
            ("salvus", ["salvum", "salvos"], "save"),
            ("libero", ["libera"], "free"),
            ("redimo", ["redimat"], "redeem"),
            ("adjutorium", ["adjutorium"], "help"),
            ("exsurgo", ["exsurge", "exsurge"], "rise up")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm7)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'tribulor' forms:", analysis.dictionary["tribulor"]?.forms ?? [:])
            print("'solitudo' forms:", analysis.dictionary["solitudo"]?.forms ?? [:])
            print("'venter' forms:", analysis.dictionary["venter"]?.forms ?? [:])
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