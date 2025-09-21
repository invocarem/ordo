import XCTest
@testable import LatinService

class Psalm17BTests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    let id = PsalmIdentity(number: 17, category: "b")

    let psalm17B = [
    /* 1 */ "Cum sancto sanctus eris, et cum viro innocente innocens eris,",
    /* 2 */ "et cum electo electus eris, et cum perverso perverteris.",
    /* 3 */ "Quoniam tu populum humilem salvum facies, et oculos superborum humiliabis.",
    /* 4 */ "Quoniam tu illuminas lucernam meam, Domine; Deus meus, illumina tenebras meas.",
    /* 5 */ "Quoniam in te eripiar a tentatione, et in Deo meo transgrediar murum.",
    /* 6 */ "Deus meus, impolluta via eius; eloquia Domini igne examinata;",
    /* 7 */ "Quoniam quis Deus praeter Dominum? aut quis Deus praeter Deum nostrum?",
    /* 8 */ "Deus qui praecinxit me virtute, et posuit immaculatam viam meam;",
    /* 9 */ "qui perfecit pedes meos tamquam cervorum, et super excelsa statuens me;",
    /* 10 */ "qui docet manus meas ad praelium, et posuisti arcum aereum brachia mea.",
    /* 11 */ "Et dedisti mihi protectionem salutis tuae, et dextera tua suscepit me:",
    /* 12 */ "et disciplina tua correxit me in finem, et disciplina tua ipsa me docebit.",
    /* 13 */ "Dilatasti gressus meos subtus me, et non sunt infirmata vestigia mea.",
    /* 14 */ "Persequar inimicos meos, et comprehendam illos; et non convertar donec deficiant.",
    /* 15 */ "Confringam illos, nec poterunt stare; cadent subtus pedes meos.",
    /* 16 */ "Et praecinxisti me virtute ad bellum; supplantasti insurgentes in me subtus me.",
    /* 17 */ "Et inimicos meos dedisti mihi dorsum, et odientes me disperdidisti.",
    /* 18 */ "Clamaverunt, nec erat qui salvos faceret; ad Dominum, nec exaudivit eos.",
    /* 19 */ "Et comminuam eos ut pulverem ante faciem venti; ut lutum platearum delebo eos.",
    /* 20 */ "Eripies me de contradictionibus populi; constitues me in caput gentium.",
    /* 21 */ "Populus quem non cognovi servivit mihi; in auditu auris obedivit mihi.",
    /* 22 */ "Filii alieni mentiti sunt mihi, filii alieni inveterati sunt,",
    /* 23 */ "Vivit Dominus, et benedictus Deus meus, et exaltetur Deus salutis meae.",
    /* 24 */ "Deus qui dat vindictas mihi, et subicit populos sub me,",
    /* 25 */ "Et ab insurgentibus in me exaltabis me; a viro iniquo eripies me.",
    /* 26 */ "Propterea confitebor tibi in nationibus, Domine, et nomini tuo psalmum cantabo:",
    /* 27 */ "magnificans salutes regis eius, et faciens misericordiam christo suo David, et semini eius usque in saeculum."
];

    private let englishText = [
        /* 1 */ "With the holy thou wilt be holy, and with the innocent man thou wilt be innocent,",
        /* 2 */ "And with the elect thou wilt be elect, and with the perverse thou wilt be perverted.",
        /* 3 */ "For thou wilt save the humble people; but wilt bring down the eyes of the proud.",
        /* 4 */ "For thou lightest my lamp, O Lord: O my God, enlighten my darkness.",
        /* 5 */ "For by thee I shall be delivered from temptation; and through my God I shall go over a wall.",
        /* 6 */ "As for my God, his way is undefiled: the words of the Lord are fire-tried:",
        /* 7 */ "For who is God but the Lord? or who is God but our God?",
        /* 8 */ "God, who hath girt me with strength; and made my way blameless.",
        /* 9 */ "Who hath made my feet like the feet of harts: and who setteth me upon high places.",
        /* 10 */ "Who teacheth my hands to war: and thou hast made my arms like a brazen bow.",
        /* 11 */ "And thou hast given me the protection of thy salvation: and thy right hand hath received me:",
        /* 12 */ "And thy discipline hath corrected me unto the end: and thy discipline, the same shall teach me.",
        /* 13 */ "Thou hast enlarged my steps under me; and my feet are not weakened.",
        /* 14 */ "I will pursue after my enemies, and overtake them: and I will not turn again till they are consumed.",
        /* 15 */ "I will break them, and they shall not be able to stand: they shall fall under my feet.",
        /* 16 */ "And thou hast girded me with strength unto battle; and hast subdued under me them that rose up against me.",
        /* 17 */ "And thou hast made my enemies turn their back upon me, and hast destroyed them that hated me.",
        /* 18 */ "They cried, but there was none to save them, to the Lord: but he heard them not.",
        /* 19 */ "And I shall beat them as small as the dust before the wind; I shall bring them to nought, like the dirt in the streets.",
        /* 20 */ "Thou wilt deliver me from the contradictions of the people; thou wilt make me head of the Gentiles.",
        /* 21 */ "A people which I knew not, hath served me: at the hearing of the ear they have obeyed me.",
        /* 22 */ "The children that are strangers have lied to me, strange children have faded away, and have halted from their paths.",
        /* 23 */ "The Lord liveth, and blessed be my God, and let the God of my salvation be exalted:",
        /* 24 */ "O God, who avengest me, and subduest the people under me, my deliverer from my enemies:",
        /* 25 */ "And thou wilt lift me up above them that rise up against me: from the unjust man thou wilt deliver me.",
        /* 26 */ "Therefore will I give glory to thee, O Lord, among the Gentiles, and sing to thy name:",
        /* 27 */ "Magnifying the salvation of his king, and shewing mercy to David his anointed, and to his seed for ever."
    ];

    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["sanctus", "vir", "innocens"]),
        (2, ["electus", "perversus", "perverto"]),
        (3, ["humilis", "salvus", "oculus", "superbus", "humilio"]),
        (4, ["illumino", "lucerna", "dominus", "deus", "tenebrae"]),
        (5, ["eripio", "tentatio", "transgredior", "murus"]),
        (6, ["deus", "impollutus", "via", "eloquium", "ignis", "examino"]),
        (7, ["quis", "deus", "dominus", "noster"]),
        (8, ["deus", "praecingo", "virtus", "pono", "immaculatus", "via"]),
        (9, ["perficio", "pes", "cervus", "excelsum", "statuo"]),
        (10, ["doceo", "manus", "praelium", "pono", "arcus", "aereus", "brachium"]),
        (11, ["protego", "salus", "dexter", "suscipio"]),
        (12, ["disciplina", "corrigo", "finis", "doceo"]),
        (13, ["dilato", "gressus", "infirmo", "vestigium"]),
        (14, ["persequor", "inimicus", "comprehendo", "converto", "deficio"]),
        (15, ["confringo", "possum", "stare", "cado", "pes"]),
        (16, ["praecingo", "virtus", "bellum", "supplanto", "insurgo"]),
        (17, ["inimicus", "dorsum", "odium", "disperdo"]),
        (18, ["clamo", "salvus", "dominus", "exaudio"]),
        (19, ["comminuo", "pulvis", "facies", "ventus", "lutum", "platea", "deleo"]),
        (20, ["eripio", "contradictio", "populus", "constituo", "caput", "gens"]),
        (21, ["populus", "cognosco", "servio", "auditus", "auris", "obedio"]),
        (22, ["filius", "alienus", "mentior", "invetero"]),
        (23, ["vivo", "dominus", "benedico", "deus", "exalto", "salus"]),
        (24, ["deus", "vindicta", "subicio", "populus"]),
        (25, ["insurgo", "exalto", "vir", "iniquus", "eripio"]),
        (26, ["confiteor", "natio", "dominus", "nomen", "psalmus", "canto"]),
        (27, ["magnifico", "salus", "rex", "misericordia", "christus", "david", "semen", "saeculum"])
    ];

    private let structuralThemes = [
        (
            "Sanctity → Corruption",
            "God's dealings reflect the heart: holy with the holy, twisted with the perverse.",
            ["sanctus", "innocens", "electus", "perversus"],
            1,
            2,
            "The divine mirror shows both purity and distortion: God appears to each as their own heart allows.",
            "Augustine sees this as God's justice: He seems merciful to the humble and severe to the proud. Christ Himself reveals this duality—grace for the penitent, judgment for the hardened."
        ),
        (
            "Humility → Light",
            "The lowly are saved and the proud humbled, as God turns darkness to light.",
            ["humilis", "salvus", "superbus", "illumino"],
            3,
            4,
            "God overturns human pride and makes His light shine in the believer's obscurity.",
            "Augustine teaches that Christ humbled Himself to exalt the lowly, and illuminates believers by removing their blindness, while the proud stumble in darkness."
        ),
        (
            "Trial → Victory",
            "God delivers from temptation and empowers to scale walls.",
            ["eripio", "tentatio", "transgredior", "murus"],
            5,
            6,
            "Strength in God turns weakness into triumph over obstacles.",
            "For Augustine, the 'wall' is the Law that condemns; in Christ, the faithful scale it, overcoming temptation through grace."
        ),
        (
            "Unique God → Strength",
            "No God but the Lord, who grants strength and integrity of way.",
            ["praecingo", "virtus", "pono", "via"],
            7,
            8,
            "The psalmist contrasts God with all pretenders: only the Lord is God. This confession leads into a personal testimony of empowerment, as God girds with strength and establishes a straight path.",
            "Augustine affirms that Christ alone is the true God and protector. His Word, tested like fire, secures the believer's path."
        ),
        (
            "Sure-footed → Battle-ready",
            "God grants deer-like stability and trains hands for war.",
            ["cervus", "statuo", "doceo", "praelium", "arcus"],
            9,
            10,
            "Spiritual agility and strength prepare the just for struggle.",
            "Augustine sees the swift feet as missionary zeal, and the trained hands as spiritual warfare against sin and unbelief."
        ),
        (
            "Protection → Discipline",
            "Salvation's shield and fatherly correction secure the way.",
            ["protectio", "salus", "dextera", "disciplina"],
            11,
            12,
            "Mercy protects, discipline refines: both come from the same hand.",
            "Augustine interprets God's discipline as sanctifying correction, making the believer steadfast in Christ, whose mercy shields and whose teaching trains."
        ),
        (
            "Pursuit → Defeat",
            "The psalmist's enemies are chased, crushed, and unable to stand.",
            ["dilato", "vestigium", "persequor", "confringo"],
            13,
            14,
            "Divine empowerment ensures that opposition collapses beneath the faithful.",
            "Augustine applies this to Christ's conquest of sin and the devil, pursued and crushed by His passion and resurrection."
        ),
        (
            "Armed → Overthrown",
            "God arms for war and causes foes to collapse beneath His servant.",
            ["praecingo", "virtus", "supplanto", "disperdo"],
            15,
            16,
            "Victory flows not from self, but from God's enabling strength.",
            "For Augustine, this arming is Christ equipping His Church, so that the faithful trample spiritual enemies underfoot."
        ),
        (
            "Cry → Silence",
            "Enemies cry out but find no salvation, silenced before the Lord.",
            ["clamor", "salvo", "dominus", "exaudio"],
            17,
            18,
            "The contrast: God hears His servant, but not the wicked who rebel.",
            "Augustine contrasts Christ's cry—heard by the Father—with the wicked's cry, ignored because it lacks faith and repentance."
        ),
        (
            "Dust → Exaltation",
            "Enemies reduced to dust, while the psalmist is set over nations.",
            ["comminuo", "pulvis", "delebo", "gens"],
            19,
            20,
            "The humbled foe and the exalted servant both reveal God's justice.",
            "Augustine sees the pulverized enemies as demons scattered, while Christ is exalted as head of the nations."
        ),
        (
            "Obedient Nations → Failing Strangers",
            "From unexpected peoples submitting in obedience to foreign sons faltering in deceit.",
            ["servio", "auditus", "oboedio", "alienus", "claudico"],
            21,
            22,
            "A new people, formerly unknown, hear and obey, while alien sons prove false and stumble from their paths.",
            "Augustine interprets the 'people not known' as the Gentiles, who obeyed at the hearing of the Gospel, while 'foreign sons' represent hypocrites and heretics, who feign faith but collapse in pride."
        ),
        (
            "Living God → Deliverer",
            "Praise to the living God who subdues nations and rescues from enemies.",
            ["vivo", "dominus", "salus", "vindicta", "libero"],
            23,
            24,
            "The psalmist's song is grounded in the living, acting God.",
            "Augustine emphasizes that Christ lives forever, granting vindication to His Body, the Church, against persecutors."
        ),
        (
            "Praise → Covenant Mercy",
            "Thanksgiving among nations, proclaiming God's mercy to His anointed forever.",
            ["confiteor", "psalmus", "misericordia", "christus", "semen"],
            25,
            27,
            "Gratitude extends outward to the nations and forward to David's seed.",
            "Augustine sees this fulfilled in Christ, the true David, whose mercy extends to all nations and whose covenant endures in His eternal seed."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Reciprocity",
            "God's response mirrors the heart: holy with the holy, perverse with the perverse",
            ["sanctus", "innocens", "electus", "perversus", "perverto"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Social Reversal",
            "The humble are exalted and the proud are humbled through divine justice",
            ["humilis", "salvus", "superbus", "humilio", "illumino", "lucerna", "tenebrae"],
            ThemeCategory.justice,
            3...4
        ),
        (
            "Divine Empowerment",
            "God's strength enables victory over trials and obstacles",
            ["eripio", "tentatio", "transgredior", "murus", "praecingo", "virtus", "pono", "via"],
            ThemeCategory.divine,
            5...8
        ),
        (
            "Spiritual Warfare",
            "God's training and equipping for battle against spiritual enemies",
            ["doceo", "praelium", "arcus", "aereus", "cervus", "statuo", "excelsum"],
            ThemeCategory.divine,
            9...10
        ),
        (
            "Divine Discipline",
            "God's protective care through correction and guidance",
            ["protego", "salus", "dextera", "suscipio", "disciplina", "corrigo", "finis"],
            ThemeCategory.divine,
            11...12
        ),
        (
            "Victory Over Enemies",
            "Divine empowerment leading to complete victory over opposition",
            ["dilato", "vestigium", "persequor", "confringo", "cado", "pes", "supplanto", "disperdo"],
            ThemeCategory.virtue,
            13...18
        ),
        (
            "Divine Exaltation",
            "God's raising up of the faithful and destruction of enemies",
            ["comminuo", "pulvis", "ventus", "lutum", "deleo", "gens", "caput", "constituo"],
            ThemeCategory.divine,
            19...20
        ),
        (
            "Gentile Mission",
            "The spread of God's kingdom to unknown peoples and the failure of false believers",
            ["populus", "cognosco", "servio", "auditus", "oboedio", "alienus", "mentior", "invetero"],
            ThemeCategory.virtue,
            21...22
        ),
        (
            "Divine Sovereignty",
            "God as the living, acting Lord who subdues nations and delivers His people",
            ["vivo", "dominus", "benedico", "exalto", "salus", "vindicta", "subicio", "populus"],
            ThemeCategory.divine,
            23...24
        ),
        (
            "Covenant Faithfulness",
            "God's mercy to His anointed and the eternal nature of His covenant",
            ["insurgo", "exalto", "vir", "iniquus", "eripio", "confiteor", "natio", "psalmus", "misericordia", "christus", "semen", "saeculum"],
            ThemeCategory.divine,
            25...27
        ),
        (
            "Divine Justice",
            "The contrast between God's treatment of the righteous and the wicked",
            ["salvus", "humilio", "eripio", "persequor", "confringo", "comminuo", "pulvis", "vindicta"],
            ThemeCategory.justice,
            1...27
        ),
        (
            "Spiritual Transformation",
            "God's work of changing weakness into strength and darkness into light",
            ["illumino", "tenebrae", "eripio", "tentatio", "transgredior", "praecingo", "virtus", "doceo", "praelium"],
            ThemeCategory.virtue,
            3...10
        )
    ];

    // MARK: - Test Data
   
    // MARK: - Test Cases

    func testTotalVerses() {
        XCTAssertEqual(
            psalm17B.count, 27, "Psalm 17B should have 27 verses"
        )
        XCTAssertEqual(
            englishText.count, 27,
            "Psalm 17B English text should have 27 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm17B.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm17B,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm17B,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm17B,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm17B_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
    
    func testSaveThemes() {
        let utilities = PsalmTestUtilities.self
        guard
            let jsonString = utilities.generateCompleteThemesJSONString(
                psalmNumber: id.number,
                category: id.category ?? "",
                conceptualThemes: conceptualThemes,
                structuralThemes: structuralThemes
            )
        else {
            XCTFail("Failed to generate complete themes JSON")
            return
        }

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm17B_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
    
    // MARK: - Test Cases
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            
            print("'noster' forms:", analysis.dictionary["noster"]?.forms ?? [:])
            

            
        }
        XCTAssertLessThan(
            analysis.totalWords, 
            analysis.uniqueLemmas * 2,
            "totalWords should be less than uniqueLemmas * 2 (was \(analysis.totalWords) vs \(analysis.uniqueLemmas * 2))"
        )
    }

    func testBodyParts() {
    let analysis = latinService.analyzePsalm(text: psalm17B)
    
    let bodyParts = [
        ("pes", ["pedes", "pedibus"], "foot"),
        ("manus", ["manus"], "hand"),
        ("brachium", ["brachia"], "arm"),
        ("oculus", ["oculos"], "eye"),
        ("dorsum", ["dorsum"], "back")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: bodyParts)
}

func testNatureImagery() {
    let analysis = latinService.analyzePsalm(text: psalm17B)
    
    let natureTerms = [
        ("pulvis", ["pulverem"], "dust"),
        ("ventus", ["venti"], "wind"),
        ("lutum", ["lutum"], "mud"),
        ("murus", ["murum"], "wall"),
        ("excelsum", ["excelsa"], "heights")
    ]
    
    verifyWordsInAnalysis(analysis, confirmedWords: natureTerms)
}
func testMilitaryVicotoryReferences() {
    let analysis = latinService.analyzePsalm(text: psalm17B)
    let militaryTerms = [
    ("praecingo", ["praecinxit", "praecinxisti"], "gird"), // Should be "praecingo" (3rd conj)
    ("praelium", ["praelium"], "battle"),               // Correct (2nd neuter)
    ("arcus", ["arcum"], "bow"),                        // Correct (4th masc)
    ("supplanto", ["supplantasti"], "tripping"),        // Should be "supplanto" (1st conj)
    ("vindicta", ["vindictas"], "vengeance")            // Correct (1st fem)
]
    
    
    verifyWordsInAnalysis(analysis, confirmedWords: militaryTerms)

    let victoryTerms = [
    ("contero", ["Conteram"], "crush"),                 // Correct (3rd conj)
    ("comminuo", ["comminuam"], "pulverize"),           // Correct (3rd conj)
    ("deleo", ["delebo"], "wipe out"),                  // Correct (2nd conj)
    ("persequor", ["persequar"], "pursue"),             // Correct (deponent)
    ("subicio", ["subicit"], "subdue")                 // Should be "subicio" (3rd conj)
]
   verifyWordsInAnalysis(analysis, confirmedWords: victoryTerms)
}
    
    func testDivineReciprocity() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        
        let reciprocityTerms = [
            ("sanctus", ["sancto", "sanctus"], "holy"),
            ("innocens", ["innocente", "innocens"], "blameless"),
            ("perversus", ["perverso"], "twisted"),
            ("electus", ["electo", "electus"], "chosen"),
            ("humilis", ["humilem"], "humble")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: reciprocityTerms)
    }
    
   
    
    func testCovenantalLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        
        let covenantTerms = [
            ("christus", ["christo"], "anointed"),
            ("semen", ["semini"], "seed"),
            ("saeculum", ["saeculum"], "age"),
            ("misericordia", ["misericordiam"], "mercy"),
            ("confiteor", ["confitebor"], "praise")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: covenantTerms)
    }
    
    func testPhysiologicalMetaphors() {
        let analysis = latinService.analyzePsalm(text: psalm17B)
        
        let bodyTerms = [
            ("cervus", ["cervorum"], "deer"),
            ("vestigium", ["vestigia"], "footstep"),
            ("claudico", ["claudicaverunt"], "limp"),
            ("dextera", ["dextera"], "right hand"),
            ("auris", ["auris"], "ear"),
            ("auditus", ["auditu"], "hearing")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: bodyTerms)
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
    private func verifyThematicElements(analysis: PsalmAnalysisResult, expectedThemes: [String: [(lemma: String, description: String)]]) {
    for (theme, elements) in expectedThemes {
        for (lemma, description) in elements {
            guard analysis.dictionary[lemma] != nil else {
                XCTFail("Missing lemma for theme verification: \(lemma) (theme: \(theme))")
                continue
            }
            
            if verbose {
                print("VERIFIED THEME: \(theme) - \(lemma) (\(description))")
            }
        }
    }
}
}