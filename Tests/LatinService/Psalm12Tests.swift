import XCTest
@testable import LatinService

class Psalm12Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 12, category:  nil)
    // MARK: - Test Data (Psalm 12)
    let psalm12 = [
        "Usquequo, Domine, oblivisceris me in finem? usquequo avertis faciem tuam a me?",
        "Quandiu ponam consilia in anima mea, dolorem in corde meo per diem?",
        "Usquequo exaltabitur inimicus meus super me?",
        "Respice, et exaudi me, Domine Deus meus. Illumina oculos meos, ne umquam obdormiam in morte;",
        "Nequando dicat inimicus meus: Praevalui adversus eum. Qui tribulant me, exsultabunt si motus fuero;",
        "Ego autem in misericordia tua speravi. Exsultabit cor meum in salutari tuo; cantabo Domino qui bona tribuit mihi, et psallam nomini Domini altissimi."
    ]

    private let englishText = [
        "How long, O Lord, wilt thou forget me unto the end? how long dost thou turn away thy face from me?",
        "How long shall I take counsel in my soul, sorrow in my heart all the day?",
        "How long shall my enemy be exalted over me?",
        "Consider, and hear me, O Lord my God. Enlighten my eyes, lest I sleep the sleep of death;",
        "Lest at any time my enemy say: I have prevailed against him. They that trouble me will rejoice when I am moved;",
        "But I have trusted in thy mercy. My heart shall rejoice in thy salvation: I will sing to the Lord, who giveth me good things: yea I will sing to the name of the Lord the most high."
    ]

    // MARK: - Test Methods

    func testTotalVerses() {
        let expectedVerseCount = 6
        XCTAssertEqual(
            psalm12.count, expectedVerseCount, "Psalm 12 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 12 English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm12.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm12,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm12,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm12_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }

    // MARK: - Theme Tests
func testAllThemes() {
    let analysis = latinService.analyzePsalm(id, text: psalm12)
    
    // All themes from your JSON
    let allThemes = [
        ("Lament in Suffering", ["usquequo", "obliviscor", "dolor"]),
        ("Divine Hiddenness", ["averto", "facies"]),
        ("Enemy Threat", ["exalto", "inimicus", "praevaleo"]),
        ("Petition for Help", ["respicio", "exaudio", "illumino"]),
        ("Trust Transition", ["misericordia", "spero"]),
        ("Promise of Praise", ["exsulto", "cano", "psallo"])
    ]
    
    var failedChecks = [String]()
    
    for (themeName, requiredLemmas) in allThemes {
        let missing = requiredLemmas.filter { !analysis.dictionary.keys.contains($0) }
        if !missing.isEmpty {
            failedChecks.append("\(themeName): \(missing.joined(separator: ", "))")
        }
    }
    
    if !failedChecks.isEmpty {
        XCTFail("Missing lemmas:\n" + failedChecks.joined(separator: "\n"))
    }
}


func testThemeLineCoverage() {
    let analysis = latinService.analyzePsalm(id, text: psalm12)
    
    // Verify every line has at least one theme
    psalm12.enumerated().forEach { lineIndex, lineText in
        let lineNumber = lineIndex + 1
        let lineThemes = analysis.themes.compactMap { theme in
            theme.lineRange?.contains(lineNumber) == true ? theme : nil
        }
        
        XCTAssertFalse(
            lineThemes.isEmpty,
            "Line \(lineNumber) has no associated themes: '\(lineText)'"
        )
        
        if verbose && !lineThemes.isEmpty {
            print("\nLine \(lineNumber) themes:")
            lineThemes.forEach { print("- \($0.name) (lines \($0.lineRange?.description ?? "nil"))") }
        }
    }
}

func testThemeLemmaPresence() {
    let analysis = latinService.analyzePsalm(id, text: psalm12)
    
    // First build a set of all lemmas that exist in the analysis
    let existingLemmas = Set(analysis.dictionary.keys)
    
    for theme in analysis.themes {
        // Verify all supporting lemmas exist in the dictionary
        let missingLemmas = theme.supportingLemmas.filter { !existingLemmas.contains($0) }
        XCTAssertTrue(
            missingLemmas.isEmpty,
            "Theme '\(theme.name)' references missing lemmas: \(missingLemmas.joined(separator: ", "))"
        )
        
        // If we have line ranges, do additional verification
        if let lineRange = theme.lineRange {
            // For this simple test, we'll just confirm the lemmas exist
            // More advanced line-based verification would require modifying PsalmAnalysisResult
            // to include word-to-line mapping information
            if verbose {
                print("\nTheme '\(theme.name)' (lines \(lineRange)) has lemmas:")
                theme.supportingLemmas.forEach { print("- \($0)") }
            }
        }
    }
}


   
    // MARK: - Test Cases
    func testAnalysis() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'pono' forms:", analysis.dictionary["pono"]?.forms ?? [:])
            print("'exsulto' forms:", analysis.dictionary["exsulto"]?.forms ?? [:])
            print("'respicio' forms:", analysis.dictionary["respicio"]?.forms ?? [:])
            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }
    
    func testLamentVerbs() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let lamentTerms = [
            ("obliviscor", ["oblivisceris"], "forget"), // v.1
            ("averto", ["avertis"], "turn away"), // v.1
            ("pono", ["ponam"], "place"), // v.2
            ("respiro", ["respice"], "look"), // v.4
            ("exaudio", ["exaudi"], "hear") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lamentTerms)
    }
    
    func testTemporalExpressions() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let timeTerms = [
            ("usquequo", ["usquequo", "usquequo", "usquequo"], "how long"), // v.1 (2x), v.3
            ("quandiu", ["quandiu"], "how long"), // v.2
            ("per", ["per"], "through"), // v.2
            ("umquam", ["umquam"], "ever") // v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: timeTerms)
    }
    
    func testEnemyLanguage() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let enemyTerms = [
            ("inimicus", ["inimicus", "inimicus"], "enemy"), // v.3, v.5
            ("praevaleo", ["praevalui"], "prevail"), // v.5
            ("tribulo", ["tribulant"], "afflict"), // v.5
            ("exsulto", ["exsultabunt"], "rejoice") // v.5 (enemy's joy)
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: enemyTerms)
    }
    
    func testSpiritualFaculties() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let facultyTerms = [
            ("animus", ["anima"], "soul"), // v.2
            ("cor", ["corde", "cor"], "heart"), // v.2, v.6
            ("oculus", ["oculos"], "eye"), // v.4
            ("vultus", ["faciem", "faciem"], "face") // v.1, v.4
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: facultyTerms)
    }
    
    func testHopeTransition() {
        let analysis = latinService.analyzePsalm(id, text: psalm12)
        
        let hopeTerms = [
            ("misericordia", ["misericordia"], "mercy"), // v.6
            ("salutaris", ["salutari"], "salvation"), // v.6
            ("canto", ["cantabo"], "sing"), // v.6
            ("psallo", ["psallam"], "sing praises"), // v.6
            ("spero", ["speravi"], "hope") // v.6
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