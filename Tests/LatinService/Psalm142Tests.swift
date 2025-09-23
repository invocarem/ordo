import XCTest
@testable import LatinService

class Psalm142Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    private let minimumLemmasPerTheme = 3
    let id = PsalmIdentity(number: 142, category: "")
    
    // MARK: - Test Data Properties
    private let psalm142 = [
        "Domine, exaudi orationem meam: auribus percipe obsecrationem meam in veritate tua: exaudi me in tua iustitia.",
        "Et non intres in iudicium cum servo tuo: quia non iustificabitur in conspectu tuo omnis vivens.",
        "Quia persecutus est inimicus animam meam: humiliavit in terra vitam meam.",
        "Collocavit me in obscuris sicut mortuos saeculi: et anxiatus est super me spiritus meus, in me turbatum est cor meum.",
        "Memor fui dierum antiquorum, meditatus sum in omnibus operibus tuis: in factis manuum tuarum meditabar.",
        "Expandi manus meas ad te: anima mea sicut terra sine aqua tibi.",
        "Velociter exaudi me, Domine: defecit spiritus meus.",
        "Non avertas faciem tuam a me: et similis ero descendentibus in lacum.",
        "Auditam fac mihi mane misericordiam tuam: quia in te speravi.",
        "Notum fac mihi viam, in qua ambulem: quia ad te levavi animam meam.",
        "Eripe me de inimicis meis, Domine, ad te confugi: doce me facere voluntatem tuam, quia Deus meus es tu.",
        "Spiritus tuus bonus deducet me in terram rectam: propter nomen tuum, Domine, vivificabis me, in aequitate tua.",
        "Educes de tribulatione animam meam: et in misericordia tua disperdes inimicos meos.",
        "Et perdes omnes qui tribulant animam meam, quoniam ego servus tuus sum."
    ]
    
    private let englishText = [
        "Hear, O Lord, my prayer: give ear to my supplication in thy truth: hear me in thy justice.",
        "And enter not into judgment with thy servant: for in thy sight no man living shall be justified.",
        "For the enemy hath persecuted my soul: he hath brought down my life to the earth.",
        "He hath made me to dwell in darkness as those that have been dead of old: and my spirit is in anguish within me, my heart within me is troubled.",
        "I remembered the days of old, I meditated on all thy works: I mused upon the works of thy hands.",
        "I stretched forth my hands to thee: my soul is as earth without water unto thee.",
        "Hear me speedily, O Lord: my spirit hath fainted away.",
        "Turn not away thy face from me: lest I be like unto them that go down into the pit.",
        "Cause me to hear thy mercy in the morning: for in thee have I hoped.",
        "Make the way known to me, wherein I should walk: for I have lifted up my soul to thee.",
        "Deliver me from my enemies, O Lord, to thee have I fled: teach me to do thy will, for thou art my God.",
        "Thy good spirit shall lead me into the right land: for thy name's sake, O Lord, thou wilt quicken me in thy justice.",
        "Thou wilt bring my soul out of trouble: and in thy mercy thou wilt destroy my enemies.",
        "And thou wilt cut off all them that afflict my soul: for I am thy servant."
    ]
    
    private let lineKeyLemmas = [
        (1, ["dominus", "exaudio", "oratio", "auris", "percipio", "obsecratio", "veritas", "iustitia"]),
        (2, ["intro", "iudicium", "servus", "iustifico", "conspectus", "vivo"]),
        (3, ["persequor", "inimicus", "anima", "humilio", "terra", "vita"]),
        (4, ["colloco", "obscurus", "mortuus", "saeculum", "anxio", "spiritus", "turbo", "cor"]),
        (5, ["memor", "dies", "antiquus", "meditor", "opus", "facio", "manus"]),
        (6, ["expando", "manus", "anima", "terra", "aqua"]),
        (7, ["velox", "exaudio", "dominus", "deficio", "spiritus"]),
        (8, ["averto", "facies", "similis", "descendo", "lacus"]),
        (9, ["audio", "mane", "misericordia", "spero"]),
        (10, ["notus", "via", "ambulo", "levo", "anima"]),
        (11, ["eripio", "inimicus", "dominus", "confugio", "doceo", "facio", "voluntas", "deus"]),
        (12, ["spiritus", "bonus", "deduco", "terra", "rectus", "nomen", "vivifico", "aequitas"]),
        (13, ["educo", "tribulatio", "anima", "misericordia", "disperdo", "inimicus"]),
        (14, ["perdo", "tribulo", "anima", "servus"])
    ]
    
    private let structuralThemes = [
        (
            "Petition → Justice",
            "Appeal to God's truth and justice in hearing prayer",
            ["exaudio", "oratio", "veritas", "iustitia", "intro", "iudicium", "servus", "iustifico", "conspectus", "vivo"],
            1,
            2,
            "The psalmist begins with a plea for God to hear his prayer in truth and justice, acknowledging that no one is justified before God's judgment.",
            "Augustine sees this as the soul's recognition of its own unworthiness and complete dependence on God's mercy rather than human righteousness. The appeal to divine truth and justice shows the believer's trust in God's perfect judgment."
        ),
        (
            "Persecution → Desolation",
            "Enemy oppression leading to spiritual darkness and distress",
            ["persequor", "inimicus", "anima", "humilio", "terra", "vita", "colloco", "obscurus", "mortuus", "saeculum", "anxio", "spiritus", "turbo", "cor"],
            3,
            4,
            "The psalmist describes the enemy's persecution that has brought humiliation and spiritual darkness, causing anguish and trouble in his heart.",
            "Augustine interprets this as the soul's experience of spiritual death and separation from God, where the enemy (sin/devil) seeks to destroy the spiritual life through oppression and darkness."
        ),
        (
            "Remembrance → Thirst",
            "Remembering God's works while experiencing spiritual dryness",
            ["memor", "dies", "antiquus", "meditor", "opus", "facio", "manus", "expando", "terra", "aqua"],
            5,
            6,
            "The psalmist recalls God's past works while expressing intense spiritual thirst like parched land, stretching out his hands in supplication.",
            "Augustine sees this as the soul's meditation on God's providence while experiencing the dryness of spiritual desert, longing for the living water of grace through prayer and remembrance."
        ),
        (
            "Urgency → Desperation",
            "Immediate need for God's presence to avoid destruction",
            ["velox", "exaudio", "dominus", "deficio", "spiritus", "averto", "facies", "similis", "descendo", "lacus"],
            7,
            8,
            "The psalmist urgently pleads for help as his spirit fails, fearing abandonment that would lead to the pit of destruction.",
            "Augustine emphasizes the soul's desperate need for God's immediate help to avoid spiritual death and descent into hell, showing the urgency of divine intervention."
        ),
        (
            "Hope → Guidance",
            "Trust in God's mercy leading to prayer for direction",
            ["audio", "mane", "misericordia", "spero", "notus", "via", "ambulo", "levo", "anima"],
            9,
            10,
            "The psalmist expresses hope in God's morning mercy and asks for guidance in the right path, lifting up his soul to God.",
            "Augustine interprets this as the soul's morning prayer for enlightenment, seeking the way of truth after the night of tribulation through trust in divine mercy."
        ),
        (
            "Refuge → Spirit",
            "Taking refuge in God and the guidance of the Holy Spirit",
            ["eripio", "inimicus", "dominus", "confugio", "doceo", "facio", "voluntas", "deus", "spiritus", "bonus", "deduco", "terra", "rectus", "nomen", "vivifico", "aequitas"],
            11,
            12,
            "The psalmist flees to God for deliverance, asks to be taught God's will, and trusts in the Holy Spirit's guidance to lead him to the right land.",
            "Augustine sees this as the soul's complete surrender to God's will, recognizing that true deliverance comes through obedience to divine instruction and the guidance of the Holy Spirit."
        ),
        (
            "Deliverance → Vindication",
            "God's liberation from trouble and destruction of enemies",
            ["educo", "tribulatio", "anima", "misericordia", "disperdo", "inimicus", "perdo", "tribulo", "servus"],
            13,
            14,
            "The psalmist trusts God to deliver from tribulation and destroy all who trouble his soul, affirming his servant status before God.",
            "Augustine emphasizes God's power to revive the soul and destroy spiritual enemies through His mercy, culminating in the soul's affirmation of its servitude to God."
        )
    ];

    private let conceptualThemes = [
        (
            "Divine Justice",
            "God's righteous judgment and fairness",
            ["iustitia", "iudicium", "iustifico", "aequitas"],
            ThemeCategory.divine,
            1...14
        ),
        (
            "Divine Mercy",
            "God's compassionate love and forgiveness",
            ["misericordia", "exaudio", "percipio", "audio", "spero"],
            ThemeCategory.divine,
            1...14
        ),
        (
            "Divine Guidance",
            "God's direction and teaching through the Spirit",
            ["via", "doceo", "deduco", "spiritus", "bonus", "notus", "ambulo"],
            ThemeCategory.divine,
            1...14
        ),
        (
            "Human Dependence",
            "Recognition of human need for God",
            ["servus", "confugio", "levo", "expando", "intro", "conspectus"],
            ThemeCategory.virtue,
            1...14
        ),
        (
            "Spiritual Thirst",
            "Longing for God's presence and grace",
            ["anima", "terra", "aqua", "deficio", "velox"],
            ThemeCategory.virtue,
            1...14
        ),
        (
            "Enemy Oppression",
            "Persecution by adversaries and spiritual enemies",
            ["inimicus", "persequor", "tribulo", "disperdo", "perdo", "humilio"],
            ThemeCategory.sin,
            1...14
        ),
        (
            "Spiritual Desolation",
            "Experience of darkness, distress and abandonment",
            ["obscurus", "mortuus", "anxio", "turbo", "lacus", "averto", "descendo"],
            ThemeCategory.sin,
            1...14
        ),
        (
            "Divine Deliverance",
            "God's rescue and liberation from trouble",
            ["eripio", "educo", "vivifico", "nomen"],
            ThemeCategory.divine,
            1...14
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
            psalm142.count, 14, "Psalm 142 should have 14 verses"
        )
        XCTAssertEqual(
            englishText.count, 14,
            "Psalm 142 English text should have 14 verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm142.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm142,
            "Normalized Latin text should match expected classical forms"
        )
    }
    
    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm142,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm142_texts.json"
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
            filename: "output_psalm142_themes.json"
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
            psalmText: psalm142,
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
            psalmText: psalm142,
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
            psalmText: psalm142,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }
}