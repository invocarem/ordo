import XCTest
@testable import LatinService

class Psalm16Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm16 = [
        "Exaudi, Domine, justitiam meam; intende deprecationem meam.",
        "Auribus percipe orationem meam, non in labiis dolosis.",
        "De vultu tuo judicium meum prodeat; oculi tui videant aequitatem.",
        "Probasti cor meum, et visitasti nocte; igne me examinasti, et non est inventa in me iniquitas.",
        "Ut non loquatur os meum opera hominum; propter verba labiorum tuorum ego custodivi vias duras.",
        "Perfice gressus meos in semitis tuis, ut non moveantur vestigia mea.",
        "Ego clamavi, quoniam exaudisti me, Deus; inclina aurem tuam mihi, et exaudi verba mea.",
        "Mirifica misericordias tuas, qui salvos facis sperantes in te.",
        "A resistentibus dexterae tuae custodi me, ut pupillam oculi.",
        "Sub umbra alarum tuarum protege me,",
        "a facie impiorum qui me afflixerunt.",
        "Inimici mei animam meum circumdederunt; adipem suum concluserunt, os eorum locutum est superbiam.",
        "Projicientes me nunc circumdederunt me; oculos suos statuerunt declinare in terram.",
        "Susceperunt me sicut leo paratus ad praedam, et sicut catulus leonis habitans in abditis.",
        "Exsurge, Domine, praeveni eos, et supplanta eos.",
        "Eripe animam meam ab impio, frameam tuam ab inimicis manus tuae.",
        "Domine, a paucis de terra divide eos in vita eorum; de absconditis tuis adimpletus est venter eorum.",
        "Saturati sunt filiis, et dimiserunt reliquias suas parvulis suis.",
        "Ego autem in justitia apparebo conspectui tuo; satiabor cum apparuerit gloria tua."
    ]
    
    // MARK: - Test Cases
// MARK: - Grouped Line Tests
func testPsalm16Lines1and2() {
    let line1 = psalm16[0] // "Exaudi, Domine, justitiam meam; intende deprecationem meam."
    let line2 = psalm16[1] // "Auribus percipe orationem meam, non in labiis dolosis."
    let combinedText = line1 + " " + line2
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("exaudio", ["exaudi"], "hear"),
        ("dominus", ["domine"], "Lord"),
        ("justitia", ["justitiam"], "justice"),
        ("intendo", ["intende"], "attend"),
        ("deprecatio", ["deprecationem"], "supplication"),
        ("auris", ["auribus"], "ear"),
        ("percipio", ["percipe"], "perceive"),
        ("oratio", ["orationem"], "prayer"),
        ("labium", ["labiis"], "lip"),
        ("dolosus", ["dolosis"], "deceitful")
    ]
    
    if verbose {
        print("\nPSALM 16:1-2 ANALYSIS:")
        print("1: \"\(line1)\"")
        print("2: \"\(line2)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Judicial Appeal: 'justitiam meam' (my justice)")
        print("2. Sincere Prayer: 'non in labiis dolosis' (not with deceitful lips)")
        print("3. Divine Attention: 'Exaudi...intende...percipe' (hear...attend...perceive)")
    }
    
    // Judicial prayer assertions
    XCTAssertEqual(analysis.dictionary["justitia"]?.forms["justitiam"], 1, "Should find justice reference")
    XCTAssertEqual(analysis.dictionary["oratio"]?.forms["orationem"], 1, "Should detect prayer reference")
    
    // Negative declaration
    XCTAssertEqual(analysis.dictionary["dolosus"]?.forms["dolosis"], 1, "Should find deceit negation")
    
    // Test hearing terminology
    let hearingVerbs = ["exaudi", "intende", "percipe"].reduce(0) {
        $0 + (analysis.dictionary["exaudio"]?.forms[$1] ?? 0)
        + (analysis.dictionary["intendo"]?.forms[$1] ?? 0)
        + (analysis.dictionary["percipio"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(hearingVerbs, 3, "Should find all hearing-related verbs")
}

func testPsalm16Lines3and4() {
    let line3 = psalm16[2] // "De vultu tuo judicium meum prodeat; oculi tui videant aequitatem."
    let line4 = psalm16[3] // "Probasti cor meum, et visitasti nocte; igne me examinasti, et non est inventa in me iniquitas."
    let combinedText = line3 + " " + line4
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("vultus", ["vultu"], "face"),
        ("judicium", ["judicium"], "judgment"),
        ("prodeo", ["prodeat"], "come forth"),
        ("oculus", ["oculi"], "eye"),
        ("video", ["videant"], "see"),
        ("aequitas", ["aequitatem"], "equity"),
        ("probo", ["probasti"], "test"),
        ("cor", ["cor"], "heart"),
        ("visito", ["visitasti"], "visit"),
        ("nox", ["nocte"], "night"),
        ("ignis", ["igne"], "fire"),
        ("examino", ["examinasti"], "examine"),
        ("iniquitas", ["iniquitas"], "iniquity")
    ]
    
    if verbose {
        print("\nPSALM 16:3-4 ANALYSIS:")
        print("3: \"\(line3)\"")
        print("4: \"\(line4)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Scrutiny: 'Probasti...examinasti' (You have tested...examined)")
        print("2. Nightly Examination: 'visitasti nocte' (visited by night)")
        print("3. Righteousness Proven: 'non est inventa in me iniquitas' (no iniquity found in me)")
    }
    
    // Divine examination assertions
    XCTAssertEqual(analysis.dictionary["probo"]?.forms["probasti"], 1, "Should find testing verb")
    XCTAssertEqual(analysis.dictionary["examino"]?.forms["examinasti"], 1, "Should detect examination")
    
    // Negative declaration
    XCTAssertEqual(analysis.dictionary["iniquitas"]?.forms["iniquitas"], 1, "Should find iniquity negation")
    
    // Test judicial terms
    let judicialTerms = ["judicium", "aequitas"].reduce(0) { accumulator, lemma in
        accumulator + (analysis.dictionary[lemma]?.forms.values.reduce(0, +) ?? 0)
    } 
    XCTAssertEqual(judicialTerms, 2, "Should find both judgment and equity terms")
}

func testPsalm16Lines5and6() {
    let line5 = psalm16[4] // "Ut non loquatur os meum opera hominum; propter verba labiorum tuorum ego custodivi vias duras."
    let line6 = psalm16[5] // "Perfice gressus meos in semitis tuis, ut non moveantur vestigia mea."
    let combinedText = line5 + " " + line6
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("loquor", ["loquatur"], "speak"),
        ("os", ["os"], "mouth"),
        ("opus", ["opera"], "work"),
        ("homo", ["hominum"], "men"),
        ("verbum", ["verba"], "words"),
        ("custodio", ["custodivi"], "keep"),
        ("via", ["vias"], "ways"),
        ("durus", ["duras"], "hard"),
        ("perficio", ["perfice"], "perfect"),
        ("gressus", ["gressus"], "steps"),
        ("semita", ["semitis"], "paths"),
        ("moveo", ["moveantur"], "be moved"),
        ("vestigium", ["vestigia"], "footsteps")
    ]
    
    if verbose {
        print("\nPSALM 16:5-6 ANALYSIS:")
        print("5: \"\(line5)\"")
        print("6: \"\(line6)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Speech Control: 'non loquatur os meum' (may my mouth not speak)")
        print("2. Obedience: 'custodivi vias duras' (I have kept hard paths)")
        print("3. Guided Walk: 'Perfice gressus meos' (Make perfect my steps)")
    }
    
    // Negative declaration
    XCTAssertEqual(analysis.dictionary["loquor"]?.forms["loquatur"], 1, "Should find negative speech verb")
    
    // Path imagery
    XCTAssertEqual(analysis.dictionary["via"]?.forms["vias"], 1, "Should find ways reference")
    XCTAssertEqual(analysis.dictionary["semita"]?.forms["semitis"], 1, "Should detect paths reference")
    
    // Test obedience terminology
    let obedienceTerms = ["custodivi", "perfice"].reduce(0) {
        $0 + (analysis.dictionary["custodio"]?.forms[$1] ?? 0)
        + (analysis.dictionary["perficio"]?.forms[$1] ?? 0)
    }
    XCTAssertEqual(obedienceTerms, 2, "Should find both keeping and perfecting verbs")
}

func testPsalm16Lines7and8() {
    let line7 = psalm16[6] // "Ego clamavi, quoniam exaudisti me, Deus; inclina aurem tuam mihi, et exaudi verba mea."
    let line8 = psalm16[7] // "Mirifica misericordias tuas, qui salvos facis sperantes in te."
    let combinedText = line7 + " " + line8
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("clamo", ["clamavi"], "cry out"),
        ("exaudio", ["exaudisti", "exaudi"], "hear"),
        ("deus", ["deus"], "God"),
        ("inclino", ["inclina"], "incline"),
        ("auris", ["aurem"], "ear"),
        ("verbum", ["verba"], "words"),
        ("mirifico", ["mirifica"], "show wonderful"),
        ("misericordia", ["misericordias"], "mercies"),
        ("salvus", ["salvos"], "save"),
        ("facio", ["facis"], "make"),
        ("spero", ["sperantes"], "hope")
    ]
    
    if verbose {
        print("\nPSALM 16:7-8 ANALYSIS:")
        print("7: \"\(line7)\"")
        print("8: \"\(line8)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Answered Prayer: 'exaudisti me' (you heard me)")
        print("2. Divine Attention: 'inclina aurem tuam' (incline your ear)")
        print("3. Merciful Salvation: 'salvos facis sperantes in te' (you save those hoping in you)")
    }
    
    // Prayer assertions
    XCTAssertEqual(analysis.dictionary["exaudio"]?.forms["exaudisti"], 1, "Should find past hearing")
    XCTAssertEqual(analysis.dictionary["exaudio"]?.forms["exaudi"], 1, "Should find present hearing request")
    
    // Mercy terminology
    XCTAssertEqual(analysis.dictionary["misericordia"]?.forms["misericordias"], 1, "Should find mercies reference")
    XCTAssertEqual(analysis.dictionary["spero"]?.forms["sperantes"], 1, "Should detect hoping participle")
    
    // Test body part metaphor
    let earReference = analysis.dictionary["auris"]?.forms["aurem"] ?? 0
    XCTAssertEqual(earReference, 1, "Should find ear reference")
}

func testPsalm16Lines9and10() {
    let line9 = psalm16[8] // "A resistentibus dexterae tuae custodi me, ut pupillam oculi."
    let line10 = psalm16[9] // "Sub umbra alarum tuarum protege me,"
    let combinedText = line9 + " " + line10
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("resisto", ["resistentibus"], "resist"),  // Changed from "resistens" to "resisto"
        ("dexter", ["dexterae"], "right hand"),
        ("custodio", ["custodi"], "guard"),
        ("pupilla", ["pupillam"], "pupil"),
        ("oculus", ["oculi"], "eye"),
        ("umbra", ["umbra"], "shadow"),
        ("ala", ["alarum"], "wing"),
        ("protego", ["protege"], "protect")
    ]
    
    if verbose {
        print("\nPSALM 16:9-10 ANALYSIS:")
        print("9: \"\(line9)\"")
        print("10: \"\(line10)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Divine Protection: 'custodi me...protege me' (guard me...protect me)")
        print("2. Precious Care: 'ut pupillam oculi' (like the apple of the eye)")
        print("3. Shelter Imagery: 'Sub umbra alarum tuarum' (under shadow of your wings)")
    }
    
    // Protection assertions
    XCTAssertEqual(analysis.dictionary["custodio"]?.forms["custodi"], 1, "Should find guarding verb")
    XCTAssertEqual(analysis.dictionary["protego"]?.forms["protege"], 1, "Should detect protection verb")
    
    // Body metaphor
    XCTAssertEqual(analysis.dictionary["pupilla"]?.forms["pupillam"], 1, "Should find pupil reference")
    
    // Wing imagery
    XCTAssertEqual(analysis.dictionary["ala"]?.forms["alarum"], 1, "Should find wings reference")
}

func testPsalm16Lines11and12() {
    let line11 = psalm16[10] // "a facie impiorum qui me afflixerunt."
    let line12 = psalm16[11] // "Inimici mei animam meum circumdederunt; adipem suum concluserunt, os eorum locutum est superbiam."
    let combinedText = line11 + " " + line12
    let analysis = latinService.analyzePsalm(text: combinedText)
    
    let testLemmas = [
        ("facies", ["facie"], "face"),
        ("impius", ["impiorum"], "wicked"),
        ("affligo", ["afflixerunt"], "afflict"),
        ("inimicus", ["inimici"], "enemy"),
        ("anima", ["animam"], "soul"),
        ("circumdo", ["circumdederunt"], "surround"),
        ("adeps", ["adipem"], "fat"),
        ("concludo", ["concluserunt"], "close up"),
        ("os", ["os"], "mouth"),
        ("loquor", ["locutum"], "speak"),
        ("superbia", ["superbiam"], "pride")
    ]
    
    if verbose {
        print("\nPSALM 16:11-12 ANALYSIS:")
        print("11: \"\(line11)\"")
        print("12: \"\(line12)\"")
        
        print("\nLEMMA VERIFICATION:")
        testLemmas.forEach { lemma, forms, translation in
            let found = analysis.dictionary[lemma] != nil
            print("- \(lemma.padding(toLength: 12, withPad: " ", startingAt: 0)): \(found ? "✅" : "❌") \(translation)")
        }
        
        print("\nKEY THEMES:")
        print("1. Enemy Threat: 'impiorum...inimici mei' (wicked...my enemies)")
        print("2. Surrounding Danger: 'circumdederunt...concluserunt' (surrounded...closed in)")
        print("3. Arrogant Speech: 'locutum est superbiam' (spoke pride)")
    }
    
    // Enemy assertions
    XCTAssertEqual(analysis.dictionary["inimicus"]?.forms["inimici"], 1, "Should find enemy reference")
    XCTAssertEqual(analysis.dictionary["impius"]?.forms["impiorum"], 1, "Should detect wicked reference")
    
    // Surrounding danger
    XCTAssertEqual(analysis.dictionary["circumdo"]?.forms["circumdederunt"], 1, "Should find surrounding verb")
    
    // Speech analysis
    XCTAssertEqual(analysis.dictionary["superbia"]?.forms["superbiam"], 1, "Should find pride reference")
}

    
    func testJudicialPetition() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let legalTerms = [
            ("justitia", ["justitiam"], "justice"),
            ("judicium", ["judicium"], "judgment"),
            ("aequitas", ["aequitatem"], "equity"),
            ("probo", ["Probasti"], "test"),
            ("iniquitas", ["iniquitas"], "injustice")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: legalTerms)
    }
    
    func testDivineProtection() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let protectionTerms = [
            ("pupilla", ["pupillam"], "apple [of eye]"),
            ("ala", ["alarum"], "wing"),
            ("framea", ["frameam"], "sword"),
            ("custodio", ["custodivi", "custodi"], "guard"),
            ("protego", ["protege"], "protect")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: protectionTerms)
    }
    
    func testLionImagery() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let lionTerms = [
            ("leo", ["leo", "leonis"], "lion"),
            ("catulus", ["catulus"], "cub"),
            ("praeda", ["praedam"], "prey"),
            ("abditus", ["abditis"], "hidden place"),
            ("supplanto", ["supplanta"], "trip up")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lionTerms)
    }
    
    func testBodyMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let bodyTerms = [
            ("adeps", ["adipem"], "fat"), // Symbolizing prosperity
            ("venter", ["venter"], "belly"),
            ("oculus", ["oculi", "oculos"], "eye"),
            ("auris", ["Auribus", "aurem"], "ear"),
            ("labium", ["labiis", "labiorum"], "lip")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
    }
    
    func testEschatologicalHope() {
        let analysis = latinService.analyzePsalm(text: psalm16)
        
        let hopeTerms = [
            ("gloria", ["gloria"], "glory"),
            ("satiabor", ["satiabor"], "be satisfied"),
            ("appareo", ["apparebo", "apparuerit"], "appear"),
            ("absconditum", ["absconditis"], "hidden treasures"),
            ("reliquiae", ["reliquias"], "remnants")
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