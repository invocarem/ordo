import XCTest
@testable import LatinService

class Psalm123Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let id = PsalmIdentity(number: 123, category: nil)

    let psalm123 = [
        "Nisi quia Dominus erat in nobis, dicat nunc Israel;",
        "nisi quia Dominus erat in nobis, cum exsurgerent homines in nos,",
        "forsitan vivos deglutissent nos.",
        "Cum irasceretur furor eorum in nos, forsitan aqua absorbuisset nos.",
        "Torrentem pertransivit anima nostra; forsitan pertransisset anima nostra aquam intolerabilem.",
        "Benedictus Dominus, qui non dedit nos in captionem dentibus eorum.",
        "Anima nostra sicut passer erepta est de laqueo venantium;",
        "laqueus contritus est, et nos liberati sumus.",
        "Adjutorium nostrum in nomine Domini, qui fecit caelum et terram."
    ]

    // MARK: - Enhanced Tests
    
    func testVerbDicat() {
        latinService.configureDebugging(target: "dico")
        let analysis = latinService.analyzePsalm(id, text: psalm123[0])
        
        let dicoEntry = analysis.dictionary["dico"]
        XCTAssertNotNil(dicoEntry, "Lemma 'dico' should exist for 'dicat'")
        
        if let entity = dicoEntry?.entity {
            let result = entity.analyzeFormWithMeaning("dicat")
            XCTAssertTrue(
                result.contains("present") && result.contains("subjunctive"),
                "Expected present subjunctive, got: \(result)"
            )
            
            if verbose {
                print("\nDICO Analysis:")
                print("  Form 'dicat': \(result)")
            }
        } else {
            XCTFail("Entity for 'dico' not found")
        }
    }

    func testHumanThreats() {
        let text = psalm123[1] + " " + psalm123[2]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 2)
        let terms = [
            ("exsurgo", ["exsurgerent"], "rise up"),
            ("homo", ["homines"], "man"),
            ("deglutio", ["deglutissent"], "swallow"),
            ("vivus", ["vivos"], "alive")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testFloodAndWrath() {
        let text = psalm123[3] + " " + psalm123[4]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 4)
        let terms = [
            ("irascor", ["irasceretur"], "be angry"),
            ("furor", ["furor"], "fury"),
            ("aqua", ["aqua", "aquam"], "water"),
            ("absorbeo", ["absorbuisset"], "swallow up")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testSnareAndEscape() {
        let text = psalm123[6] + " " + psalm123[7]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 7)
        let terms = [
            ("passer", ["passer"], "sparrow"),
            ("ereptus", ["erepta"], "rescued"),
            ("laqueus", ["laqueo", "laqueus"], "snare"),
            ("venator", ["venantium"], "hunter"),
            ("contritus", ["contritus"], "broken"),
            ("libero", ["liberati"], "free")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testHelperAndCreator() {
        let text = psalm123[8]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 9)
        let terms = [
            ("adjutorium", ["Adjutorium"], "help"),
            ("nomen", ["nomine"], "name"),
            ("caelum", ["caelum"], "heaven"),
            ("terra", ["terram"], "earth")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testAugustineBrokenSnare() {
        let text = psalm123[6] + " " + psalm123[7]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 7)
        let terms = [
            ("laqueus", ["laqueus", "laqueo"], "snare"),
            ("contritus", ["contritus"], "broken"),
            ("libero", ["liberati"], "free"),
            ("passer", ["passer"], "sparrow")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    // MARK: - Enhanced Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, 
                                     confirmedWords: [(lemma: String, 
                                                     forms: [String], 
                                                     translation: String)]) {
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
            
            // NEW: Verify grammatical analysis for each form
            for form in forms {
                if let entity = entry.entity {
                    let result = entity.analyzeFormWithMeaning(form)
                    
                    XCTAssertTrue(
                        result.lowercased().contains(translation.lowercased()) ||
                        result.lowercased().contains("verb") ||
                        result.lowercased().contains("participle") ||
                        result.lowercased().contains("noun"),
                        """
                        For form '\(form)' of lemma '\(lemma)':
                        Expected analysis to contain '\(translation)' or grammatical info,
                        but got: \(result)
                        """
                    )
                    
                    if verbose {
                        print("  Analysis of '\(form)': \(result)")
                    }
                }
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