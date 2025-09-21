import XCTest
@testable import LatinService

class Psalm17ATests: XCTestCase {
    private let verbose = true
    
    // MARK: - Test Data
    let id = PsalmIdentity(number: 17, category: "A")
    private let expectedVerseCount = 27
    
    private let text = [
    /* 1 */ "Diligo te, Domine, fortitudo mea; Dominus firmamentum meum, et refugium meum, et liberator meus.",
    /* 2 */ "Deus meus, adiutor meus, et sperabo in eum;",
    /* 3 */ "protector meus, et cornu salutis meae, et susceptor meus.",
    /* 4 */ "Laudans invocabo Dominum, et ab inimicis meis salvus ero.",
    /* 5 */ "Circumdederunt me dolores mortis, et torrentes iniquitatis conturbaverunt me.",
    /* 6 */ "Dolores inferni circumdederunt me, praeoccupaverunt me laquei mortis.",
    /* 7 */ "In tribulatione mea invocavi Dominum, et ad Deum meum clamavi;",
    /* 8 */ "Et exaudivit de templo sancto suo vocem meam, et clamor meus in conspectu eius introivit in aures eius.",
    /* 9 */ "Commota est, et contremuit terra; fundamenta montium conturbata sunt, et commota sunt, quoniam iratus est eis.",
    /* 10 */ "Ascendit fumus in ira eius, et ignis a facie eius exarsit; carbones succensi sunt ab eo.",
    /* 11 */ "Inclinavit caelos, et descendit, et caligo sub pedibus eius.",
    /* 12 */ "Et ascendit super cherubim, et volavit; volavit super pennas ventorum.",
    /* 13 */ "Et posuit tenebras latibulum suum; in circuitu eius tabernaculum eius, tenebrosa aqua in nubibus aeris.",
    /* 14 */ "Prae fulgore in conspectu eius nubes transierunt, grando et carbones ignis.",
    /* 15 */ "Et intonuit de caelo Dominus, et Altissimus dedit vocem suam: grandinem et carbones ignis.",
    /* 16 */ "Et misit sagittas suas, et dissipavit eos; fulgura multiplicavit, et conturbavit eos.",
    /* 17 */ "Et apparuerunt fontes aquarum, et revelata sunt fundamenta orbis terrarum",
    /* 18 */ "Ab increpatione tua, Domine, ab inspiratione spiritus irae tuae.",
    /* 19 */ "Misit de summo, et accepit me; assumpsit me de aquis multis.",
    /* 20 */ "Eripuit me de inimico meo potentissimo, et ab his qui oderunt me: quoniam confortati sunt super me.",
    /* 21 */ "Praevenerunt me in die afflictionis meae, et factus est Dominus protector meus.",
    /* 22 */ "Et eduxit me in latitudinem; salvum me fecit, quoniam voluit me.",
    /* 23 */ "Et retribuet mihi Dominus secundum iustitiam meam, et secundum puritatem manuum mearum retribuet mihi.",
    /* 24 */ "Quia custodivi vias Domini, nec impie gessi a Deo meo.",
    /* 25 */ "Quoniam omnia iudicia eius in conspectu meo, et iustitias eius non repuli a me.",
    /* 26 */ "Et ero immaculatus cum eo, et observabo me ab iniquitate mea.",
     /* 27 */ "Et retribuet mihi Dominus secundum iustitiam meam, et secundum puritatem manuum mearum in conspectu oculorum eius."
]
    
    private let englishText = [
        /* 1 */ "I will love thee, O Lord, my strength; The Lord is my firmament, my refuge, and my deliverer.",
        /* 2 */ "My God is my helper, and in him will I put my trust;",
        /* 3 */ "My protector, and the horn of my salvation, and my support.",
        /* 4 */ "Praising I will call upon the Lord, and I shall be saved from my enemies.",
        /* 5 */ "The sorrows of death surrounded me, and the torrents of iniquity troubled me.",
        /* 6 */ "The sorrows of hell encompassed me, and the snares of death prevented me.",
        /* 7 */ "In my affliction I called upon the Lord, and I cried to my God;",
        /* 8 */ "And he heard my voice from his holy temple, and my cry before him came into his ears.",
        /* 9 */ "The earth shook and trembled; the foundations of the mountains were troubled, and were moved, because he was angry with them.",
        /* 10 */ "There went up a smoke in his wrath, and a fire flamed from his face; coals were kindled by it.",
        /* 11 */ "He bowed the heavens, and came down, and darkness was under his feet.",
        /* 12 */ "And he ascended upon the cherubim, and he flew; he flew upon the wings of the winds.",
        /* 13 */ "And he made darkness his covert; his pavilion round about him, dark waters in the clouds of the air.",
        /* 14 */ "At the brightness before him the clouds passed, hail and coals of fire.",
        /* 15 */ "And the Lord thundered from heaven, and the Highest gave his voice: hail and coals of fire.",
        /* 16 */ "And he sent forth his arrows, and he scattered them; he multiplied lightnings, and troubled them.",
        /* 17 */ "Then the fountains of waters appeared, and the foundations of the world were discovered",
        /* 18 */ "At thy rebuke, O Lord, at the blast of the spirit of thy wrath.",
        /* 19 */ "He sent from on high, and took me; and received me out of many waters.",
        /* 20 */ "He delivered me from my strongest enemy, and from them that hated me: for they were too strong for me.",
        /* 21 */ "They prevented me in the day of my affliction, and the Lord became my protector.",
        /* 22 */ "And he brought me forth into a large place; he saved me, because he was well pleased with me.",
        /* 23 */ "And the Lord will reward me according to my justice, and according to the cleanness of my hands shall he render unto me.",
        /* 24 */ "Because I have kept the ways of the Lord, and have not done wickedly against my God.",
        /* 25 */ "For all his judgments are in my sight, and his justices I have not put away from me.",
        /* 26 */ "And I shall be spotless with him, and shall keep myself from my iniquity.",
        /* 27 */ "And the Lord will reward me according to my justice, and according to the cleanness of my hands in the sight of his eyes."
    ]
    
    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["diligo", "dominus", "fortitudo", "firmamentum", "refugium", "liberator"]),
        (2, ["deus", "adiutor", "spero"]),
        (3, ["protector", "cornu", "salus", "susceptor"]),
        (4, ["laudo", "invoco", "dominus", "salvus", "inimicus"]),
        (5, ["circumdo", "dolor", "mors", "torrens", "iniquitas", "conturbo"]),
        (6, ["dolor", "infernus", "circumdo", "praeoccupo", "laqueus", "mors"]),
        (7, ["tribulatio", "invoco", "dominus", "clamo", "deus"]),
        (8, ["exaudio", "templum", "sanctus", "vox", "clamor", "conspectus", "auris"]),
        (9, ["commoveo", "contremisco", "terra", "fundamentum", "mons", "conturbo", "iratus"]),
        (10, ["ascendo", "fumus", "ira", "ignis", "facies", "exardesco", "carbo", "succendo"]),
        (11, ["inclino", "caelum", "descendo", "caligo", "pes"]),
        (12, ["ascendo", "cherubim", "volo", "penna", "ventus"]),
        (13, ["pono", "tenebrae", "latibulum", "circuitus", "tabernaculum", "aqua", "nubes", "aer"]),
        (14, ["prae", "fulgor", "conspectus", "nubes", "transeo", "grando", "carbo", "ignis"]),
        (15, ["intono", "caelum", "dominus", "altissimus", "do", "vox", "grando", "carbo", "ignis"]),
        (16, ["mitto", "sagitta", "dissipo", "fulgur", "multiplico", "conturbo"]),
        (17, ["appareo", "fons", "aqua", "revelo", "fundamentum", "orbis", "terra"]),
        (18, ["increpatio", "dominus", "inspiratio", "spiritus", "ira"]),
        (19, ["mitto", "summus", "accipio", "assumo", "aqua", "multus"]),
        (20, ["eripio", "inimicus", "potens", "odi", "conforto", "super"]),
        (21, ["praevenio", "dies", "afflictio", "facio", "dominus", "protector"]),
        (22, ["educo", "latitudo", "salvus", "facio", "volo"]),
        (23, ["retribuo", "dominus", "iustitia", "puritas", "manus"]),
        (24, ["custodio", "via", "dominus", "impius", "gero", "deus"]),
        (25, ["omnis", "iudicium", "conspectus", "iustitia", "repello"]),
        (26, ["immaculatus", "observo", "iniquitas"]),
        (27, ["retribuo", "dominus", "iustitia", "puritas", "manus", "conspectus", "oculus"])
    ]
    
    private let structuralThemes = [
        (
            "Love → Hope",
            "Personal devotion to God expanding into future trust",
            ["diligo", "dominus", "fortitudo", "firmamentum", "refugium", "liberator", "deus", "adiutor", "spero"],
            1,
            2,
            "The opening establishes personal devotion through possessive pronouns (mea/meum)",
            "The psalmist's intimate relationship with God is established through the personal declaration 'Diligo te' (I love you), followed by three powerful metaphors of divine protection: firmament (support), refuge (shelter), and liberator (deliverer). The second verse expands this with additional divine titles including helper and future hope."
        ),
        (
            "Protection → Praise",
            "Six roles of God declared in rapid succession leading to worship and salvation",
            ["protector", "cornu", "salus", "susceptor", "laudo", "invoco", "dominus", "salvus", "inimicus"],
            3,
            4,
            "Includes future hope ('sperabo') and salvation metaphor ('cornu salutis')",
            "The psalmist expands the divine relationship through six distinct titles, culminating in the future tense 'sperabo in eum' (I will hope in him), showing trust that extends beyond present circumstances. The fourth verse shows praise and invocation leading to salvation from enemies."
        ),
        (
            "Praise → Peril",
            "Worship maintained despite surrounding mortal danger",
            ["laudo", "invoco", "dolor", "torrens", "conturbo", "infernus", "praeoccupo", "laqueus", "mors"],
            5,
            6,
            "Future safety promised ('salvus ero') while surrounded by death's pains",
            "The psalmist maintains worship ('Laudans invocabo') even while describing the surrounding dangers of death's pains and torrents of iniquity, demonstrating faith that transcends circumstances. The sixth verse intensifies the imagery with hell's sorrows and death's snares."
        ),
        (
            "Cry → Response",
            "Desperate prayer answered by divine hearing",
            ["tribulatio", "invoco", "dominus", "clamo", "deus", "exaudio", "templum", "sanctus", "vox", "clamor", "conspectus", "auris"],
            7,
            8,
            "Three passive perfects show death's total claim, answered by one active perfect (clamavi)",
            "The psalmist describes being completely surrounded by death's snares through three passive perfect verbs, but responds with the active perfect 'clamavi' (I cried), showing that prayer breaks through even the most desperate circumstances. God hears from His holy temple."
        ),
        (
            "Hearing → Shaking",
            "Divine attention causing cosmic reaction",
            ["exaudio", "commoveo", "contremisco", "terra", "fundamentum", "mons", "conturbo", "iratus", "ascendo", "fumus", "ira", "ignis", "facies", "exardesco", "carbo", "succendo"],
            9,
            10,
            "Earth shakes when God's ear is attentive to human cries",
            "The divine response to the psalmist's cry causes the earth to shake and mountains to tremble, demonstrating that God's attention to human prayer has cosmic consequences. The tenth verse shows divine wrath manifested through smoke and fire."
        ),
        (
            "Descent → Flight",
            "God bending heaven to intervene and fly to rescue",
            ["inclino", "caelum", "descendo", "caligo", "pes", "ascendo", "cherubim", "volo", "penna", "ventus"],
            11,
            12,
            "Darkness under feet contrasts with earlier fire imagery",
            "God bends the heavens and descends with darkness under His feet, showing His willingness to come down from His exalted position to intervene in human affairs. The twelfth verse shows His swift flight on cherubim and wind's wings."
        ),
        (
            "Hiddenness → Storm",
            "God's mysterious presence manifesting as storm artillery",
            ["pono", "tenebrae", "latibulum", "circuitus", "tabernaculum", "aqua", "nubes", "aer", "prae", "fulgor", "conspectus", "nubes", "transeo", "grando", "carbo", "ignis"],
            13,
            14,
            "Double 'volavit' emphasizes swift movement to rescue",
            "God makes darkness His hiding place and tabernacle, showing both His swift mobility and mysterious presence. The fourteenth verse shows storm elements - hail and coals of fire - passing before His brightness."
        ),
        (
            "Thunder → Warfare",
            "Heavenly voice leading to divine weapons against enemies",
            ["intono", "caelum", "dominus", "altissimus", "do", "vox", "grando", "carbo", "ignis", "mitto", "sagitta", "dissipo", "fulgur", "multiplico", "conturbo"],
            15,
            16,
            "Classic theophany elements signaling God's judicial presence",
            "God thunders from heaven and the Highest gives His voice with hail and coals of fire. The sixteenth verse shows God sending forth arrows and multiplying lightnings to scatter and trouble enemies."
        ),
        (
            "Revelation → Rebuke",
            "Creation's foundations revealed through divine rebuke",
            ["appareo", "fons", "aqua", "revelo", "fundamentum", "orbis", "terra", "increpatio", "dominus", "inspiratio", "spiritus", "ira"],
            17,
            18,
            "Projectiles scatter enemies while revealing creation's foundations",
            "The fountains of waters appear and the foundations of the world are revealed at God's rebuke and the blast of the spirit of His wrath, showing the cosmic scope of divine intervention."
        ),
        (
            "Sending → Rescuing",
            "Divine dispatch leading to rescue from waters and enemies",
            ["mitto", "summus", "accipio", "assumo", "aqua", "multus", "eripio", "inimicus", "potens", "odi", "conforto", "super"],
            19,
            20,
            "From many waters to broad place - spatial salvation imagery",
            "God sends from on high and takes the psalmist, receiving him from many waters. The twentieth verse shows deliverance from the most powerful enemy and those who hate, who were too strong."
        ),
        (
            "Prevention → Protection",
            "Enemy prevention overcome by divine protection and freedom",
            ["praevenio", "dies", "afflictio", "facio", "dominus", "protector", "educo", "latitudo", "salvus", "facio", "volo"],
            21,
            22,
            "From many waters to broad place - spatial salvation imagery",
            "The enemies prevented the psalmist in the day of affliction, but the Lord became his protector. The twenty-second verse shows God bringing him forth into a broad place and saving him because He was well pleased."
        ),
        (
            "Reward → Righteousness",
            "Divine reward based on human righteousness and obedience",
            ["retribuo", "dominus", "iustitia", "puritas", "manus", "custodio", "via", "dominus", "impius", "gero", "deus"],
            23,
            24,
            "Double 'retribuet' frames ethical section closing the psalm",
            "The Lord will reward according to justice and the cleanness of hands. The twenty-fourth verse shows the psalmist's commitment to keeping the ways of the Lord and not acting wickedly against God."
        ),
        (
            "Judgment → Immaculacy",
            "Divine judgment leading to spotless righteousness and final reward",
            ["omnis", "iudicium", "conspectus", "iustitia", "repello", "immaculatus", "observo", "iniquitas", "retribuo", "dominus", "iustitia", "puritas", "manus", "conspectus", "oculus"],
            25,
            27,
            "Complete ethical framework closing the psalm",
            "All God's judgments are in sight and His justices are not rejected. The psalmist will be spotless and keep himself from iniquity. The final verse repeats the reward promise according to justice and purity in the sight of God's eyes."
        )
    ]
    
    private let conceptualThemes = [
        (
            "Divine Protection",
            "God as the ultimate source of strength, refuge, and deliverance",
            ["diligo", "firmamentum", "refugium", "liberator"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Six Divine Roles",
            "Six distinct roles of God declared in rapid succession",
            ["deus", "adiutor", "protector", "cornu", "salus", "susceptor"],
            ThemeCategory.divine,
            2...3
        ),
        (
            "Personal Devotion",
            "The psalmist's intimate relationship with God through love and trust",
            ["diligo", "spero", "laudo", "invoco"],
            ThemeCategory.virtue,
            1...6
        ),
        (
            "Mortal Peril",
            "The reality of death's threat and the psalmist's desperate cry for help",
            ["dolor", "mors", "infernus", "laqueus", "circumdo", "conturbo"],
            ThemeCategory.virtue,
            5...8
        ),
        (
            "Divine Theophany",
            "God's manifestation through cosmic signs and elemental forces",
            ["exaudio", "commoveo", "fumus", "ignis", "intono", "grando", "sagitta"],
            ThemeCategory.divine,
            9...22
        ),
        (
            "Cosmic Intervention",
            "God's descent from heaven to intervene in human affairs",
            ["inclino", "caelum", "descendo", "cherubim", "volo"],
            ThemeCategory.divine,
            12...16
        ),
        (
            "Divine Warfare",
            "God's use of elemental forces as weapons against enemies",
            ["fumus", "ignis", "grando", "carbo", "sagitta", "fulgur"],
            ThemeCategory.divine,
            11...22
        ),
        (
            "Personal Salvation",
            "The psalmist's individual experience of divine rescue and deliverance",
            ["eripio", "inimicus", "potens", "latitudo", "salvus"],
            ThemeCategory.virtue,
            19...22
        ),
        (
            "Covenant Justice",
            "The reciprocal relationship between divine reward and human righteousness",
            ["retribuo", "iustitia", "puritas", "immaculatus", "custodio"],
            ThemeCategory.virtue,
            23...27
        ),
        (
            "Divine Omnipresence",
            "God's presence in all places and circumstances, from heaven to hell",
            ["ascendo", "caelum", "descendo", "infernus", "mare", "extremus"],
            ThemeCategory.divine,
            7...9
        ),
        (
            "Worship in Crisis",
            "Maintaining praise and prayer even in the midst of mortal danger",
            ["laudo", "invoco", "clamo", "exaudio"],
            ThemeCategory.worship,
            4...9
        )
    ]
    
    // MARK: - Test Cases
    
    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 17A should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 17A English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            text,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: text,
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
            text: text,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm17A_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }

    
    func testStructuralThemes() {
        let utilities = PsalmTestUtilities.self

        // First, verify that all structural theme lemmas are in lineKeyLemmas
        let structuralLemmas = structuralThemes.flatMap { $0.2 }
        let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

        utilities.testLemmasInSet(
            sourceLemmas: structuralLemmas,
            targetLemmas: lineKeyLemmasFlat,
            sourceName: "structural themes",
            targetName: "lineKeyLemmas",
            verbose: verbose
        )

        // Then run the standard structural themes test
        utilities.testStructuralThemes(
            psalmText: text,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }
    
    func testConceptualThemes() {
        let utilities = PsalmTestUtilities.self

        // First, verify that conceptual theme lemmas are in lineKeyLemmas
        let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
        let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

        utilities.testLemmasInSet(
            sourceLemmas: conceptualLemmas,
            targetLemmas: lineKeyLemmasFlat,
            sourceName: "conceptual themes",
            targetName: "lineKeyLemmas",
            verbose: verbose
        )

        // Then run the standard conceptual themes test
        utilities.testConceptualThemes(
            psalmText: text,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
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
            filename: "output_psalm17A_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}