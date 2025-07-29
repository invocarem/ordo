import XCTest
@testable import LatinService

class Psalm148Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm148 = [
        "Laudate Dominum de caelis: laudate eum in excelsis.",
        "Laudate eum, omnes angeli eius: laudate eum, omnes virtutes eius.",
        "Laudate eum, sol et luna: laudate eum, omnia astra et lumen.",
        "Laudate eum, caeli caelorum: et aquae omnes, quae super caelos sunt, laudent nomen Domini.",
        "Quia ipse dixit, et facta sunt: ipse mandavit, et creata sunt.",
        "Statuit ea in aeternum, et in saeculum saeculi: praeceptum posuit, et non praeteribit.",
        "Laudate Dominum de terra, dracones, et omnia abyssorum:",
        "Ignis, grando, nix, glacies, spiritus procellarum: quae faciunt verbum eius:",
        "Montes, et omnes colles: ligna fructifera, et omnes cedri:",
        "Bestiae, et universa pecora: serpentes, et volucres pennatae:",
        "Reges terrae, et omnes populi: principes, et omnes iudices terrae:",
        "Iuvenes, et virgines: senes cum iunioribus laudent nomen Domini:",
        "Quia exaltatum est nomen eius solius: confessio eius super caelum et terram.",
        "Et exaltabit cornu populi sui: hymnus omnibus sanctis eius, filiis Israel, populo appropinquanti sibi."
    ]
    let id = PsalmIdentity(number: 148, category: "Universal Praise")
    
    // MARK: - Test Cases
    
    func testThemeLemmas() {
        let analysis = latinService.analyzePsalm(id, text: psalm148)
        
        // Theme 1: Heavens → Hosts
        let heavensTerms = [
            ("caelum", ["caelis", "caelos", "caelorum"], "heaven"),
            ("excelsum", ["excelsis"], "height"),
            ("angelus", ["angeli"], "angel"),
            ("virtus", ["virtutes"], "power")
        ]
        
        // Theme 2: Luminaries → Waters Above
        let luminariesTerms = [
            ("sol", ["sol"], "sun"),
            ("luna", ["luna"], "moon"),
            ("astrum", ["astra"], "star"),
            ("aqua", ["aquae"], "water")
        ]
        
        // Theme 3: Command → Creation
        let commandTerms = [
            ("dico", ["dixit"], "speak"),
            ("creo", ["creata"], "create"),
            ("praeceptum", ["praeceptum"], "command")
        ]
        
        // Theme 4: Depths → Storms
        let depthsTerms = [
            ("draco", ["dracones"], "dragon"),
            ("abyssus", ["abyssorum"], "abyss"),
            ("spiritus", ["spiritus"], "spirit"),
            ("verbum", ["verbum"], "word")
        ]
        
        // Theme 5: Mountains → Beasts
        let mountainsTerms = [
            ("mons", ["Montes"], "mountain"),
            ("cedrus", ["cedri"], "cedar"),
            ("bestia", ["bestiae"], "beast"),
            ("serpens", ["serpentes"], "serpent")
        ]
        
        // Theme 6: Rulers → Youth
        let rulersTerms = [
            ("rex", ["Reges"], "king"),
            ("iudex", ["iudices"], "judge"),
            ("iuvenis", ["iuvenes"], "young"),
            ("iunior", ["iunioribus"], "young"),
            ("senex", ["senes"], "old")
        ]
        
        // Theme 7: Name → People
        let nameTerms = [
            ("nomen", ["nomen", "nomen"], "name"),
            ("confessio", ["confessio"], "confession"),
            ("cornu", ["cornu"], "horn"),
            ("populus", ["populi", "populo"], "people")
        ]
        
        // Verify each theme group
        verifyWordsInAnalysis(analysis, confirmedWords: heavensTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: luminariesTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: commandTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: depthsTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: mountainsTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: rulersTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: nameTerms)
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

class Psalm149Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm149 = [
        "Cantate Domino canticum novum: laus eius in ecclesia sanctorum.",
        "Laetetur Israel in eo qui fecit eum: et filii Sion exsultent in rege suo.",
        "Laudent nomen eius in choro: in tympano, et psalterio psallant ei.",
        "Quia beneplacitum est Domino in populo suo: et exaltabit mansuetos in salutem.",
        "Exsultabunt sancti in gloria: laetabuntur in cubilibus suis.",
        "Exaltationes Dei in gutture eorum: et gladii ancipites in manibus eorum:",
        "Ad faciendam vindictam in nationibus: increpationes in populis.",
        "Ad alligandos reges eorum in compedibus: et nobiles eorum in manicis ferreis.",
        "Ut faciant in eis iudicium conscriptum: gloria haec est omnibus sanctis eius."
    ]
    let id = PsalmIdentity(number: 149, category: nil)
    
    // MARK: - Test Cases
    
    func testThemeLemmas() {
        let analysis = latinService.analyzePsalm(id, text: psalm149)
        
        // Theme 1: New Song → Holy Assembly
        let newSongTerms = [
            ("canticum", ["canticum"], "song"),
            ("novus", ["novum"], "new"),
            ("ecclesia", ["ecclesia"], "assembly"),
            ("laetor", ["Laetetur", "laetabuntur"], "rejoice"),
            ("exsulto", ["exsultent", "exsultabunt"], "rejoice")
        ]
        
        // Theme 2: Dance → Favor
        let danceTerms = [
            ("chorus", ["choro"], "dance"),
            ("tympanum", ["tympano"], "tambourine"),
            ("psalterium", ["psalterio"], "psaltery"),
            ("beneplacitum", ["beneplacitum"], "pleasure"),
            ("mansuetus", ["mansuetos"], "meek")
        ]
        
        // Theme 3: Rest → Exaltation
        let restTerms = [
            ("gloria", ["gloria"], "glory"),
            ("cubile", ["cubilibus"], "bed"),
            ("guttur", ["gutture"], "throat"),
            ("exaltatio", ["exaltationes"], "exaltation"),
            ("gladius", ["gladii"], "sword"),
            ("anceps", ["ancipites"], "two-edged")
        ]
        
        // Theme 4: Judgment → Dominion
        let judgmentTerms = [
            ("vindicta", ["vindictam"], "vengeance"),
            ("increpatio", ["increpationes"], "rebuke"),
            ("natio", ["nationibus"], "nation"),
            ("populus", ["populis", "populo"], "people"),
            ("rex", ["reges"], "king"),
            ("compedes", ["compedibus"], "fetters"),
            ("manicae", ["manicis"], "chain")
        ]
        
        // Theme 5: Written Judgment → Shared Glory
        let writtenJudgmentTerms = [
            ("iudicium", ["iudicium"], "judgment"),
            ("conscriptus", ["conscriptum"], "written"),
            ("gloria", ["gloria"], "glory"),
            ("sanctus", ["sanctis", "sancti"], "holy")
        ]
        
        // Verify each theme group
        verifyWordsInAnalysis(analysis, confirmedWords: newSongTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: danceTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: restTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: judgmentTerms)
        verifyWordsInAnalysis(analysis, confirmedWords: writtenJudgmentTerms)
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