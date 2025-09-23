import XCTest
@testable import LatinService

class Psalm89Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 89, category: "")
    
    // MARK: - Test Data Properties
    private let psalm89 = [
        "Domine, refugium factus es nobis a generatione et progenie.",
        "Priusquam montes fierent, aut formaretur terra et orbis: a saeculo et usque in saeculum tu es, Deus.",
        "Ne avertas hominem in humilitatem: et dixisti: Convertimini, filii hominum.",
        "Quoniam mille anni ante oculos tuos, tamquam dies hesterna quae praeteriit:",
        "Et custodia in nocte. Quae pro nihilo habentur, eorum anni erunt.",
        "Mane sicut herba transeat; mane floreat, et transeat: vespere decidat, induret, et arescat.",
        "Quia defecimus in ira tua, et in furore tuo turbati sumus.",
        "Posuisti iniquitates nostras in conspectu tuo: saeculum nostrum in illuminatione vultus tui.",
        "Quoniam omnes dies nostri defecerunt: et in ira tua defecimus.",
        "Anni nostri sicut aranea meditabuntur. Dies annorum nostrorum in ipsis septuaginta anni.",
        "Si autem in potentatibus octoginta anni: et amplius eorum labor et dolor.",
        "Quoniam supervenit mansuetudo, et corripiemur.",
        "Quis novit potestatem irae tuae? et prae timore tuo iram tuam dinumerare?",
        "Dextera tua sic notam fac: et eruditos corde in sapientia.",
        "Convertere, Domine, usquequo? et deprecabilis esto super servos tuos.",
        "Repleti sumus mane misericordia tua: et exsultavimus, et delectati sumus omnibus diebus nostris.",
        "Laetati sumus pro diebus quibus nos humiliasti: annis quibus vidimus mala.",
        "Respice in servos tuos, et in opera tua: et dirige filios eorum.",
        "Et sit splendor Domini Dei nostri super nos: et opera manuum nostrarum dirige super nos; et opus manuum nostrarum dirige."
    ]
    
    private let englishText = [
        "Lord, thou hast been our refuge from generation to generation.",
        "Before the mountains were made, or the earth and the world was formed; from eternity and to eternity thou art God.",
        "Turn not man away to be brought low: and thou hast said: Be converted, O ye sons of men.",
        "For a thousand years in thy sight are as yesterday, which is past:",
        "And as a watch in the night. Things that are counted nothing, shall their years be.",
        "In the morning man shall grow up like grass; in the morning he shall flourish and pass away: in the evening he shall fall, grow dry, and wither.",
        "For in thy wrath we have fainted away: and are troubled in thy indignation.",
        "Thou hast set our iniquities before thy eyes: our life in the light of thy countenance.",
        "For all our days are spent; and in thy wrath we have fainted away.",
        "Our years shall be considered as a spider. The days of our years in them are threescore and ten years.",
        "But if in the strong they be fourscore years: and what is more of them is toil and sorrow.",
        "For mildness is come upon us: and we shall be corrected.",
        "Who knoweth the power of thy anger, and for thy fear can number thy wrath?",
        "So make thy right hand known: and men learned in heart, in wisdom.",
        "Return, O Lord, how long? and be entreated in favour of thy servants.",
        "We are filled in the morning with thy mercy: and we have rejoiced, and are delighted all our days.",
        "We have rejoiced for the days in which thou hast humbled us: for the years in which we have seen evils.",
        "Look upon thy servants and upon their works: and direct their children.",
        "And let the brightness of the Lord our God be upon us: and direct thou the works of our hands over us; yea, the work of our hands do thou direct."
    ]
    
    private let lineKeyLemmas = [
        (1, ["dominus", "refugium", "facio", "generatio", "progenies"]),
        (2, ["priusquam", "mons", "formo", "terra", "orbis", "saeculum", "deus"]),
        (3, ["averto", "homo", "humilitas", "dico", "converto", "filius"]),
        (4, ["mille", "annus", "oculus", "dies", "hesternus", "praetereo"]),
        (5, ["custodia", "nox", "nihil", "annus"]),
        (6, ["mane", "herba", "transeo", "floreo", "vesper", "decido", "induro", "aresco"]),
        (7, ["deficio", "ira", "furor", "turbo"]),
        (8, ["pono", "iniquitas", "conspectus", "illuminatio", "vultus"]),
        (9, ["dies", "deficio", "ira"]),
        (10, ["annus", "aranea", "meditor", "septuaginta"]),
        (11, ["potentatus", "octoginta", "labor", "dolor"]),
        (12, ["mansuetudo", "corripio"]),
        (13, ["potestas", "ira", "timor", "dinumero"]),
        (14, ["dextera", "nota", "erudio", "cor", "sapientia"]),
        (15, ["converto", "dominus", "usquequo", "deprecabilis", "servus"]),
        (16, ["repleo", "mane", "misericordia", "exsulto", "delecto", "dies"]),
        (17, ["laetor", "dies", "humilio", "annus", "malus"]),
        (18, ["respicio", "servus", "opus", "dirigo", "filius"]),
        (19, ["splendor", "dominus", "deus", "opus", "manus", "dirigo"])
    ]
    
    private let structuralThemes = [
        (
            "Divine Refuge → Eternal God",
            "God as refuge through generations and His eternal nature from before creation",
            ["refugium", "generatio", "progenies", "mons", "formo", "terra", "orbis", "saeculum"],
            1,
            2,
            "The psalmist declares that God has been their refuge from generation to generation, and acknowledges God's eternal existence from before the mountains were made and the earth was formed.",
            "Augustine sees this as establishing God's unchanging nature and His role as the ultimate protector. The refuge through generations shows God's faithfulness to His people across time, while His pre-existence before creation demonstrates His transcendence over all temporal things."
        ),
        (
            "Divine Command → Temporal Perspective",
            "God's call for human conversion and His perspective on time as fleeting",
            ["averto", "humilitas", "converto", "mille", "oculus", "dies", "hesternus", "praetereo"],
            3,
            4,
            "God calls humanity to conversion and not to be turned away in humiliation, while the psalmist acknowledges that a thousand years in God's sight are like yesterday that has passed.",
            "For Augustine, this represents the contrast between divine eternity and human temporality. God's call to conversion shows His desire for human transformation, while the temporal imagery demonstrates how brief human existence appears from the divine perspective."
        ),
        (
            "Night Watch → Grass Metaphor",
            "Human years counted as nothing contrasted with the fleeting nature of grass",
            ["custodia", "nox", "nihil", "annus", "mane", "herba", "transeo", "floreo", "vesper", "decido", "induro", "aresco"],
            5,
            6,
            "Human years are counted as nothing, like a watch in the night, and like grass that flourishes in the morning and withers in the evening, falling, hardening, and drying up.",
            "Augustine sees this as the soul's recognition of human temporality. The night watch metaphor shows the brevity of human years, while the grass imagery demonstrates the ephemeral nature of human life from flourishing to withering."
        ),
        (
            "Divine Wrath → Divine Light",
            "Human experience of divine wrath contrasted with life in the light of God's countenance",
            ["deficio", "ira", "furor", "turbo", "pono", "iniquitas", "conspectus", "illuminatio", "vultus"],
            7,
            8,
            "The psalmist has fainted away in God's wrath and is troubled in His fury, while God has set human iniquities before His eyes and human life is lived in the light of His countenance.",
            "Augustine sees this as the tension between divine judgment and divine grace. The experience of divine wrath shows God's response to human sinfulness, while the light of His countenance represents the grace that sustains human life despite iniquity."
        ),
        (
            "Spent Days → Spider's Web",
            "Human days spent in divine wrath contrasted with years like a spider's web",
            ["dies", "deficio", "ira", "annus", "aranea", "meditor", "septuaginta"],
            9,
            10,
            "All human days are spent and they faint away in God's wrath, and human years are considered like a spider's web, with typical lifespan being seventy years.",
            "Augustine sees this as the soul's recognition of human mortality and divine judgment. The spent days show the exhaustion of human life under divine wrath, while the spider's web metaphor demonstrates the fragility and brevity of human existence."
        ),
        (
            "Human Strength → Divine Discipline",
            "The limitations of human strength contrasted with divine mildness and correction",
            ["potentatus", "octoginta", "labor", "dolor", "mansuetudo", "corripio"],
            11,
            12,
            "Even if in strength they be eighty years, and what is more of them is toil and sorrow, but divine mildness comes upon them and they shall be corrected.",
            "Augustine sees this as the soul's recognition of human limitations contrasted with divine pedagogy. Even exceptional human strength is limited and involves suffering, while divine mildness represents God's gentle correction that brings wisdom through discipline."
        ),
        (
            "Divine Power → Divine Instruction",
            "The incomprehensible power of God's wrath contrasted with His teaching through His right hand",
            ["potestas", "ira", "timor", "dinumero", "dextera", "nota", "erudio", "cor", "sapientia"],
            13,
            14,
            "No one knows the power of God's anger or can number His wrath, yet the psalmist asks God to make His right hand known and teach wisdom to those learned in heart.",
            "Augustine sees this as the soul's recognition of divine transcendence combined with confident petition for instruction. The incomprehensibility of God's wrath shows His majesty, while the request for divine teaching demonstrates the believer's trust in divine wisdom."
        ),
        (
            "Human Petition → Divine Mercy",
            "Human plea for divine return contrasted with God's morning mercy and joy",
            ["converto", "dominus", "usquequo", "deprecabilis", "servus", "repleo", "mane", "misericordia", "exsulto", "delecto", "dies"],
            15,
            16,
            "The psalmist pleads for God to return and be entreated in favor of His servants, and declares they are filled in the morning with God's mercy and rejoice all their days.",
            "For Augustine, this represents the soul's urgent petition for divine return combined with joyful recognition of divine mercy. The plea for divine return shows dependence on God's favor, while the morning mercy demonstrates daily renewal and spiritual joy."
        ),
        (
            "Joy in Suffering → Divine Favor",
            "Rejoicing in days of humiliation and petition for divine attention to human works",
            ["laetor", "dies", "humilio", "annus", "malus", "respicio", "servus", "opus", "dirigo", "filius"],
            17,
            18,
            "The psalmist rejoices for the days in which God humbled them and for the years in which they saw evils, and asks God to look upon His servants and their works and direct their children.",
            "Augustine sees this as the soul's mature understanding of divine discipline leading to joy, combined with petition for divine blessing on human labor. The joy in suffering shows spiritual growth, while the request for divine attention demonstrates dependence on God's favor for human endeavors."
        ),
        (
            "Final Petition",
            "The final plea for divine blessing on all human endeavors",
            ["splendor", "dominus", "deus", "opus", "manus", "dirigo"],
            19,
            19,
            "The psalmist concludes with a final request that the brightness of the Lord God be upon them and that He direct the works of their hands.",
            "Augustine sees this final verse as the soul's ultimate submission to divine guidance. The brightness of the Lord represents divine favor and illumination, while the direction of works shows complete dependence on God's will in all human activity."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Eternity",
            "References to God's eternal nature and transcendence over time",
            ["saeculum", "priusquam", "mons", "formo", "terra", "orbis", "mille", "oculus"],
            ThemeCategory.divine,
            1...19
        ),
        (
            "Human Mortality",
            "Themes of human transience and mortality",
            ["herba", "transeo", "floreo", "decido", "aresco", "aranea", "septuaginta", "octoginta", "labor", "dolor"],
            ThemeCategory.sin,
            1...19
        ),
        (
            "Divine Judgment",
            "God's wrath and judgment on human sinfulness",
            ["ira", "furor", "turbo", "iniquitas", "deficio", "pono", "conspectus"],
            ThemeCategory.divine,
            1...19
        ),
        (
            "Divine Mercy",
            "God's compassion and gentle discipline",
            ["mansuetudo", "corripio", "misericordia", "repleo", "deprecabilis", "splendor"],
            ThemeCategory.divine,
            1...19
        ),
        (
            "Time and Temporality",
            "References to time, days, years, and temporal concepts",
            ["dies", "annus", "mane", "vesper", "custodia", "nox", "hesternus", "praetereo"],
            ThemeCategory.virtue,
            1...19
        ),
        (
            "Human Petition",
            "Prayers and petitions to God for mercy and guidance",
            ["converto", "usquequo", "respicio", "dirigo", "nota", "erudio", "sapientia"],
            ThemeCategory.virtue,
            1...19
        ),
        (
            "Divine Instruction",
            "God's teaching and wisdom imparted to humanity",
            ["erudio", "sapientia", "cor", "dextera", "nota", "dirigo"],
            ThemeCategory.divine,
            1...19
        )
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Cases
    
    func testTotalVerses() {
        XCTAssertEqual(
            psalm89.count, 19, "Psalm 89 should have 19 verses"
        )
        XCTAssertEqual(
            englishText.count, 19,
            "Psalm 89 English text should have 19 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm89.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm89,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm89,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm89_texts.json"
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
            filename: "output_psalm89_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
    
    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm89,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
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
            psalmText: psalm89,
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
            psalmText: psalm89,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}
