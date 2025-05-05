import XCTest
@testable import LatinService

class Psalm118SadeTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data (Psalm 118:137-144 "Sade" section)
    let psalm118Sade = [
        "Justus es, Domine, et rectum judicium tuum.",
        "Mandasti justitiam testimonia tua, et veritatem tuam nimis.",
        "Tabescere me fecit zelus meus, quia obliti sunt verba tua inimici mei.",
        "Igne examinatum eloquium tuum vehementer, et servus tuus dilexit illud.",
        "Adolescentulus sum ego et contemptus; justificationes tuas non sum oblitus.",
        "Justitia tua justitia in aeternum, et lex tua veritas.",
        "Tribulatio et angustia invenerunt me; mandata tua meditatio mea est.",
        "Aeternum justum testimonium tuum; intellectum da mihi, et vivam."
    ]
    
    // MARK: - Test Cases
    func testAnalyzePsalm118Sade() {
    
    
    let analysis = latinService.analyzePsalm(text: psalm118Sade)
    
    // ===== 1. Core Statistics =====
    guard let justusEntry = analysis.dictionary["justus"] else {
        XCTFail("Missing 'justus' lemma")
        return
    }
     // 2. Check all expected forms
    let formsToCheck = [
        ("justus", 1),  // verse 137
        ("justum", 1),  // verse 144
        ("justitiam", 1) // verse 138
    ]
    
    print("\n=== Justus Forms ===")
    for (form, expectedCount) in formsToCheck {
        let count = justusEntry.forms[form] ?? 0
        print("\(form): \(count) \(count >= expectedCount ? "✅" : "❌")")
        XCTAssertGreaterThanOrEqual(count, expectedCount, 
                                  "Missing form '\(form)' for justus")
    }
    
    // 3. Debug output
    print("\nAll forms under 'justus':")
    justusEntry.forms.forEach { print("- \($0.key): \($0.value)") }

    // ===== 2. Sade-Theme Words (צ) =====
    let sadeWords = [
        
        ("justus", ["justus", "justum"], "righteous"),
        ("justus", ["justitia", "justitiam"], "justice"),
        

        ("judicium", ["judicium"], "judgment"),
        ("veritas", ["veritatem", "veritas"], "truth"),
        ("zelus", ["zelus"], "zeal"),
        ("ignis", ["igne"], "fire")
    ]
    
    for (lemma, forms, translation) in sadeWords {
        guard let entry = analysis.dictionary[lemma] else {
            XCTFail("Missing Sade-themed lemma: \(lemma)")
            continue
        }
        
        XCTAssertTrue(entry.translation?.contains(translation) != nil, "Incorrect translation for \(lemma)")
        
        for form in forms {
            print ("check: \(form) \(lemma) \(String(describing: entry.forms[form]))")
            XCTAssertGreaterThan(entry.forms[form] ?? 0, 0,
                              "Missing Sade form '\(form)' for \(lemma)")
        }
    }
    
    // ===== 3. Grammatical Highlights =====
    // A. Passive perfect "igne examinatum"
    if let examenEntry = analysis.dictionary["examino"] {
        XCTAssertGreaterThan(examenEntry.forms["examinatum"] ?? 0, 0,
                          "Should find perfect passive participle")
    }
    
    // B. Substantive adjective "justum testimonium"
    if let justusEntry = analysis.dictionary["justus"] {
        XCTAssertGreaterThan(justusEntry.forms["justum"] ?? 0, 0,
                          "Should find neuter accusative substantive")
    }
    
    // ===== 4. Verse-Specific Checks =====
    // Verse 137: "Justus es Domine..."
    if let sumEntry = analysis.dictionary["sum"] {
        XCTAssertGreaterThan(sumEntry.forms["es"] ?? 0, 0, "Should find 'es'")
    }
    
    // Verse 141: "Adolescentulus sum ego..."
    if let adolescoEntry = analysis.dictionary["adolescentulus"] {
        XCTAssertGreaterThan(adolescoEntry.count, 0, "Missing 'adolescentulus'")
    }
    
    // ===== 5. Debug Output =====
    print("\n=== Sade-Themed Lemmas ===")
    sadeWords.forEach { lemma, _, _ in
        if let entry = analysis.dictionary[lemma] {
            let formsWithCounts = entry.forms.filter { $0.value > 0 }
                .map { "\($0.key):\($0.value)" }
                .joined(separator: ", ")
            print("\(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)) – [\(formsWithCounts)]")
        }
    }
    
    print("\n=== Key Constructions ===")
    print("Passive participles:", analysis.dictionary["examino"]?.forms.filter { 
        $0.key.contains("tum") || $0.key.contains("sum")
    } ?? [:])
    
    print("Eternity references:",
          (analysis.dictionary["aeternus"]?.count ?? 0) + 
          (analysis.dictionary["aeternum"]?.count ?? 0))
}
    
    func testDivineAttributes() {
        let analysis = latinService.analyzePsalm(text: psalm118Sade)
        
        let attributes = [
            ("justus", ["justus", "justum"], "righteous"), // v.137, v.144
            ("judicium", ["judicium"], "judgment"), // v.137
            ("justus", ["justitiam", "justitia"], "justice"), // v.138, v.142
            ("veritas", ["veritatem", "veritas"], "truth") // v.138, v.142
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: attributes)
    }
    
    func testTorahDescriptions() {
        let analysis = latinService.analyzePsalm(text: psalm118Sade)
        
        let torahTerms = [
            ("testimonium", ["testimonia", "testimonium"], "testimony"), // v.138, v.144
            ("verbum", ["verba"], "word"), // v.139
            ("eloquium", ["eloquium"], "expression"), // v.140
            ("justificatio", ["justificationes"], "ordinance"), // v.141
            ("lex", ["lex"], "law"), // v.142
            ("mandatum", ["mandata"], "commandment") // v.143
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: torahTerms)
    }
    
    func testHumanCondition() {
        let analysis = latinService.analyzePsalm(text: psalm118Sade)
        
        let conditions = [
            ("zelus", ["zelus"], "zeal"), // v.139
            ("adolescentulus", ["adolescentulus"], "young man"), // v.141
            ("contemptus", ["contemptus"], "despised"), // v.141
            ("tribulatio", ["tribulatio"], "trouble"), // v.143
            ("angustia", ["angustia"], "distress") // v.143
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: conditions)
    }
    
    func testTransformativeVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm118Sade)
        
        let verbs = [
            ("tabesco", ["tabescere"], "waste away"), // v.139
            ("examino", ["examinatum"], "test"), // v.140
            ("diligo", ["dilexit"], "love"), // v.140
            ("obliviscor", ["obliti", "oblitus"], "forget"), // v.139, v.141
            ("meditor", ["meditatio"], "meditate") // v.143
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: verbs)
    }
    
    func testVitalPetitions() {
        let analysis = latinService.analyzePsalm(text: psalm118Sade)
        
        let petitions = [
            ("do", ["da"], "give"), // v.144
            ("vivo", ["vivam"], "live") // v.144
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: petitions)
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