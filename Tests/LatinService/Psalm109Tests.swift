import XCTest
@testable import LatinService 

class Psalm109Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true // Set to false to reduce test output
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    override func tearDown() {
        latinService = nil
        super.tearDown()
    }
     
    let identity = PsalmIdentity(number: 109, category: nil)
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing confirmed lemma: \(lemma)")
                continue
            }
            
            // Verify translation
            XCTAssertTrue(entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                         "Incorrect translation for \(lemma): expected '\(translation)', got '\(entry.translation ?? "nil")'")
            
            for form in forms {
                let count = entry.forms[form] ?? 0
                if self.verbose {
                    print("\(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
                XCTAssertGreaterThan(count, 0, "Confirmed word '\(form)' (\(lemma)) missing in analysis")
            }
        }
    }

    func testAnalyzePsalm109() {
        let psalm109 = [
            "Dixit Dominus Domino meo: Sede a dextris meis, donec ponam inimicos tuos scabellum pedum tuorum.",
            "Virgam virtutis tuae emittet Dominus ex Sion: dominare in medio inimicorum tuorum.",
            "Tecum principium in die virtutis tuae in splendoribus sanctorum: ex utero ante luciferum genui te.",
            "Juravit Dominus, et non poenitebit eum: Tu es sacerdos in aeternum secundum ordinem Melchisedech.",
            "Dominus a dextris tuis; confregit in die irae suae reges.",
            "Judicabit in nationibus, implebit ruinas; conquassabit capita in terra multorum.",
            "De torrente in via bibet; propterea exaltabit caput."
        ]
        
        let analysis = latinService.analyzePsalm(identity, text: psalm109)
       
       let confirmedWords = [
            // Key nouns
            ("dominus", ["dominus", "domino"], "lord"),
            ("inimicus", ["inimicos", "inimicorum"], "enemy"),
            ("virtus", ["virtutis"], "strength"),
            ("pes", ["pedum"], "foot"),
            ("scabellum", ["scabellum"], "footstool"),
            ("sacerdos", ["sacerdos"], "priest"),
            ("dies", ["die"], "day"),
            ("ira", ["irae"], "wrath"),
            ("rex", ["reges"], "king"),
            ("caput", ["capita", "caput"], "head"),
            ("terra", ["terra"], "earth"),
            ("via", ["via"], "way"),
            ("torrens", ["torrente"], "torrent"),
            
            // Key verbs
            ("dico", ["dixit"], "say"),
            ("juro", ["juravit"], "swear"),
            ("emitto", ["emittet"], "send"),
            ("dominor", ["dominare"], "rule"),
            ("gigno", ["genui"], "beget"),
            ("confringo", ["confregit"], "shatter"),
            ("judico", ["judicabit"], "judge"),
            ("impleo", ["implebit"], "fill"),
            ("conquasso", ["conquassabit"], "shake"),
            ("bibo", ["bibet"], "drink"),
            ("exalto", ["exaltabit"], "exalt"),
            
            // Adjectives and pronouns
            ("tuus", ["tuos", "tuae", "tuis", "tuorum"], "your"),
            ("meus", ["meo", "meis"], "my"),
            ("suus", ["suae"], "her"),
            ("multus", ["multorum"], "many"),
            ("sanctus", ["sanctorum"], "holy"),
            ("aeternus", ["aeternum"], "eternal"),
            
            // Prepositions and conjunctions
            ("in", ["in"], "in"),
            ("a", ["a"], "from"),
            ("ex", ["ex"], "out of"),
            ("de", ["de"], "from, about"),
            ("ante", ["ante"], "before"),
            ("secundum", ["secundum"], "according to"),
            ("et", ["et"], "and"),
            ("donec", ["donec"], "until"),
            ("propterea", ["propterea"], "therefore"),
            
            // Other important words
            ("principium", ["principium"], "beginning"),
            ("splendor", ["splendoribus"], "brightness"),
            ("uterus", ["utero"], "womb"),
            ("lucifer", ["luciferum"], "morning star"),
            ("ordo", ["ordinem"], "order"),
            ("ruina", ["ruinas"], "ruin"),
            ("medium", ["medio"], "middle"),
            ("natio", ["nationibus"], "nation")
        ]

        if self.verbose {
            let totalForms = confirmedWords.reduce(0) { $0 + $1.1.count }
            print("\n=== Confirmed Words in Psalm 109 ===")
            print("Testing \(confirmedWords.count) lemmas with \(totalForms) forms")
        }
        verifyWordsInAnalysis(analysis, confirmedWords: confirmedWords)
                
        
        // ===== 3. Verify specific word counts and forms =====
        // Dominus forms
        if let dominusInfo = analysis.dictionary["dominus"] {
            XCTAssertEqual(dominusInfo.count, 5, "4x 'dominus' + 1x 'domino'")
            XCTAssertEqual(dominusInfo.forms["dominus"], 4, "Nominative count")
            XCTAssertEqual(dominusInfo.forms["domino"], 1, "Dative count")
        }
        
        // Preposition 'in'
        if let inInfo = analysis.dictionary["in"] {
            XCTAssertEqual(inInfo.count, 8, "Should appear 8 times")
            XCTAssertEqual(inInfo.entity?.partOfSpeech?.rawValue, "preposition", "Should be preposition")
        }
        
        // Conjunction 'et'
        if let etInfo = analysis.dictionary["et"] {
            XCTAssertEqual(etInfo.count, 1, "Should appear once")
            XCTAssertEqual(etInfo.entity?.partOfSpeech?.rawValue, "conjunction", "Should be conjunction")
        }
        
        // Virtus forms
        if let virtusInfo = analysis.dictionary["virtus"] {
            XCTAssertEqual(virtusInfo.count, 2, "Two genitive occurrences")
            XCTAssertEqual(virtusInfo.forms["virtutis"], 2, "Two genitive forms")
        }
        
        // Proper noun handling
        if let melchisedechInfo = analysis.dictionary["melchisedech"] {
            XCTAssertNil(melchisedechInfo.entity, "Proper nouns shouldn't have entity info")
        }
        
        // ===== 4. Debug output =====
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'emitto' forms:", analysis.dictionary["emittet"]?.forms ?? [:])
            print("'dominus' forms:", analysis.dictionary["dominus"]?.forms ?? [:])
            print("'inimicus' forms:", analysis.dictionary["inimicus"]?.forms ?? [:])
            print("'virtus' forms:", analysis.dictionary["virtus"]?.forms ?? [:])
            print("'pes' forms:", analysis.dictionary["pes"]?.forms ?? [:])
            print("'scabellum' forms:", analysis.dictionary["scabellum"]?.forms ?? [:])
            print("'juro' forms:", analysis.dictionary["juro"]?.forms ?? [:])
            print("'sacerdos' forms:", analysis.dictionary["sacerdos"]?.forms ?? [:])
            print("'a' forms:", analysis.dictionary["a"]?.forms ?? [:])
            print("'tuus' forms:", analysis.dictionary["tuus"]?.forms ?? [:])
        }
    }
}