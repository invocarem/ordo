import XCTest

@testable import LatinService

class Psalm50Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 50, category: "")

    // MARK: - Test Data Properties
    private let psalm50 = [
        "Miserere mei, Deus, secundum magnam misericordiam tuam;",
        "et secundum multitudinem miserationum tuarum, dele iniquitatem meam.",
        "Amplius lava me ab iniquitate mea, et a peccato meo munda me.",
        "Quoniam iniquitatem meam ego cognosco, et peccatum meum contra me est semper.",
        "Tibi soli peccavi, et malum coram te feci; ut iustificeris in sermonibus tuis, et vincas cum iudicaris.",
        "Ecce enim in iniquitatibus conceptus sum, et in peccatis concepit me mater mea.",
        "Ecce enim veritatem dilexisti; incerta et occulta sapientiae tuae manifestasti mihi.",
        "Asperges me hyssopo, et mundabor; lavabis me, et super nivem dealbabor.",
        "Auditui meo dabis gaudium et laetitiam, et exsultabunt ossa humiliata.",
        "Averte faciem tuam a peccatis meis, et omnes iniquitates meas dele.",
        "Cor mundum crea in me, Deus, et spiritum rectum innova in visceribus meis.",
        "Ne proicias me a facie tua, et spiritum sanctum tuum ne auferas a me.",
        "Redde mihi laetitiam salutaris tui, et spiritu principali confirma me.",
        "Docebo iniquos vias tuas, et impii ad te convertentur.",
        "Libera me de sanguinibus, Deus, Deus salutis meae, et exsultabit lingua mea iustitiam tuam.",
        "Domine, labia mea aperies, et os meum annuntiabit laudem tuam.",
        "Quoniam si voluisses sacrificium, dedissem utique; holocaustis non delectaberis.",
        "Sacrificium Deo spiritus contribulatus; cor contritum et humiliatum, Deus, non despicies.",
        "Benigne fac, Domine, in bona voluntate tua Sion, ut aedificentur muri Ierusalem.",
        "Tunc acceptabis sacrificium iustitiae, oblationes et holocausta; tunc imponent super altare tuum vitulos.",
    ]

    private let englishText = [
        "Have mercy on me, O God, according to thy great mercy;",
        "and according to the multitude of thy tender mercies, blot out my iniquity.",
        "Wash me yet more from my iniquity, and cleanse me from my sin.",
        "For I know my iniquity, and my sin is always before me.",
        "To thee only have I sinned, and have done evil before thee; that thou mayst be justified in thy words, and mayst overcome when thou art judged.",
        "For behold, I was conceived in iniquities, and in sins did my mother conceive me.",
        "For behold, thou hast loved truth; the uncertain and hidden things of thy wisdom thou hast made manifest to me.",
        "Thou shalt sprinkle me with hyssop, and I shall be cleansed; thou shalt wash me, and I shall be made whiter than snow.",
        "To my hearing thou shalt give joy and gladness, and the bones that have been humbled shall rejoice.",
        "Turn away thy face from my sins, and blot out all my iniquities.",
        "Create a clean heart in me, O God, and renew a right spirit within my bowels.",
        "Cast me not away from thy face, and take not thy holy spirit from me.",
        "Restore unto me the joy of thy salvation, and strengthen me with a perfect spirit.",
        "I will teach the unjust thy ways, and the wicked shall be converted to thee.",
        "Deliver me from blood, O God, thou God of my salvation, and my tongue shall extol thy justice.",
        "O Lord, thou wilt open my lips, and my mouth shall declare thy praise.",
        "For if thou hadst desired sacrifice, I would indeed have given it; with burnt offerings thou wilt not be delighted.",
        "A sacrifice to God is an afflicted spirit; a contrite and humbled heart, O God, thou wilt not despise.",
        "Deal favourably, O Lord, in thy good will with Sion, that the walls of Jerusalem may be built up.",
        "Then shalt thou accept the sacrifice of justice, oblations and whole burnt offerings; then shall they lay calves upon thy altar.",
    ]

    private let lineKeyLemmas = [
        (1, ["misereor", "deus", "secundum", "magnus", "misericordia"]),
        (2, ["secundum", "multitudo", "miseratio", "deleo", "iniquitas"]),
        (3, ["amplius", "lavo", "iniquitas", "peccatum", "mundo"]),
        (4, ["quoniam", "iniquitas", "cognosco", "peccatum", "contra", "semper"]),
        (
            5,
            ["solus", "pecco", "malum", "coram", "facio", "iustifico", "sermo", "vinco", "iudico"]
        ),
        (6, ["ecce", "iniquitas", "concipio", "peccatum", "mater"]),
        (7, ["ecce", "veritas", "diligo", "incertus", "occultus", "sapientia", "manifesto"]),
        (8, ["aspergo", "hyssopus", "mundo", "lavo", "super", "nix", "dealbo"]),
        (9, ["auditus", "do", "gaudium", "laetitia", "exsulto", "os", "humilio"]),
        (10, ["averto", "facies", "peccatum", "omnis", "iniquitas", "deleo"]),
        (11, ["cor", "mundus", "creo", "deus", "spiritus", "rectus", "innovo", "viscus"]),
        (12, ["proicio", "facies", "spiritus", "sanctus", "aufero"]),
        (13, ["reddo", "laetitia", "salutaris", "spiritus", "principalis", "confirmo"]),
        (14, ["doceo", "iniquus", "via", "impius", "converto"]),
        (15, ["libero", "sanguis", "deus", "salus", "exsulto", "lingua", "iustitia"]),
        (16, ["dominus", "labium", "aperio", "os", "annuntio", "laus"]),
        (17, ["quoniam", "volo", "sacrificium", "do", "holocaustum", "delector"]),
        (
            18,
            [
                "sacrificium", "deus", "spiritus", "contribulo", "cor", "contero", "humilio",
                "despicio",
            ]
        ),
        (
            19,
            [
                "benignus", "facio", "dominus", "bonus", "voluntas", "sion", "aedifico", "murus",
                "ierusalem",
            ]
        ),
        (
            20,
            [
                "tunc", "accipio", "sacrificium", "iustitia", "oblatio", "holocaustum", "impono",
                "super", "altare", "vitulus",
            ]
        ),
    ]

    private let structuralThemes = [
        (
            "Appeal → Mercy",
            "Pleading for forgiveness based on God's abundant compassion",
            ["misereor", "miseratio", "deleo", "iniquitas"],
            1,
            2,
            "The psalmist begs for mercy according to God's great compassion, asking for his iniquity to be blotted out according to the multitude of God's tender mercies.",
            "Augustine sees this as the fundamental posture of the penitent soul—appealing not to human merit but to the infinite depths of divine mercy for cleansing."
        ),
        (
            "Purification → Knowledge",
            "Seeking thorough cleansing accompanied by acknowledgment of sin",
            ["lavo", "mundo", "cognosco", "peccatum", "contra"],
            3,
            4,
            "The psalmist asks to be washed thoroughly from iniquity and made clean from sin, while acknowledging his transgressions which are ever before him.",
            "For Augustine, the prayer for cleansing is coupled with the self-knowledge that recognizes sin as a constant reality, requiring ongoing divine purification."
        ),
        (
            "Confession → Justification",
            "Admitting sin against God alone so He may be justified in His words",
            ["solus", "pecco", "coram", "iustifico", "iudico"],
            5,
            6,
            "The psalmist confesses he has sinned against God alone and done evil in His sight, so that God may be justified in His words and prevail when judged.",
            "Augustine interprets this as acknowledging that all sin is ultimately against God, and His judgment is always righteous, even when condemning human failure."
        ),
        (
            "Truth → Revelation",
            "God's love for truth and revelation of hidden wisdom",
            ["veritas", "diligo", "occultus", "sapientia", "manifesto"],
            7,
            8,
            "God loves truth and has made known to the psalmist the hidden and secret things of His wisdom, leading to purification with hyssop and washing.",
            "Augustine sees this as God revealing the deep mysteries of redemption through Christ, symbolized by the hyssop of purification that makes whiter than snow."
        ),
        (
            "Joy → Restoration",
            "Petition for joy and gladness to restore humbled bones",
            ["auditus", "gaudium", "laetitia", "exsulto", "humilio"],
            9,
            10,
            "The psalmist asks God to make him hear joy and gladness so his humbled bones may rejoice, while begging God to turn His face from his sins.",
            "Augustine interprets the humbled bones as the deepest parts of human nature crushed by sin, now asking for the joy that only divine forgiveness can restore."
        ),
        (
            "Creation → Renewal",
            "Pleading for a clean heart and renewal of a right spirit",
            ["creo", "cor", "mundus", "innovo", "spiritus", "rectus"],
            11,
            12,
            "The psalmist asks God to create a clean heart within him and renew a right spirit, begging not to be cast away from God's presence nor have His Holy Spirit taken away.",
            "Augustine sees this as the pinnacle of the penitential prayer—asking not merely for forgiveness but for total inner transformation through the Holy Spirit's work."
        ),
        (
            "Salvation → Confirmation",
            "Restoration of salvific joy and strengthening by the Spirit",
            ["reddo", "salutaris", "spiritus", "principalis", "confirmo"],
            13,
            14,
            "The psalmist asks for the return of the joy of God's salvation and to be upheld by a willing spirit, vowing to teach transgressors God's ways so sinners will convert.",
            "For Augustine, the 'spiritus principalis' refers to the Holy Spirit who confirms and strengthens the redeemed soul to become an instrument for others' conversion."
        ),
        (
            "Deliverance → Proclamation",
            "Freedom from bloodguilt leading to proclamation of righteousness",
            ["libero", "sanguis", "exsulto", "lingua", "iustitia", "annuntio"],
            15,
            16,
            "The psalmist asks deliverance from bloodguilt so his tongue may joyfully declare God's righteousness, and for the Lord to open his lips to proclaim praise.",
            "Augustine interprets the bloodguilt as the debt of sin, and the opened lips as the mouth empowered by grace to proclaim God's praise rather than human boasting."
        ),
        (
            "Sacrifice → Contrition",
            "True sacrifice as a broken spirit rather than ritual offerings",
            ["sacrificium", "holocaustum", "contribulo", "contero", "despicio"],
            17,
            18,
            "God does not desire ritual sacrifice but a contrite spirit—a heart that is broken and humbled, which He will not despise.",
            "Augustine sees this as the fulfillment of all sacrifice in Christ's once-for-all offering, now reflected in the believer's contrite heart rather than external rituals."
        ),
        (
            "Restoration → Acceptance",
            "Prayer for Zion's restoration leading to accepted sacrifices",
            ["benignus", "voluntas", "aedifico", "accipio", "oblatio", "impono"],
            19,
            20,
            "The psalmist asks God to show favor to Zion and rebuild Jerusalem's walls, so He may accept righteous sacrifices and offerings upon His altar.",
            "Augustine interprets this as the prayer for the heavenly Jerusalem—the Church—to be built up, where spiritual sacrifices offered in righteousness are accepted by God."
        ),
    ]

    private let conceptualThemes = [
        (
            "Repentance",
            "Acknowledgment of sin and guilt",
            ["peccatum", "iniquitas", "cognosco", "contra", "concipio"],
            ThemeCategory.virtue,
            1...6
        ),
        (
            "Purification",
            "Cleansing and washing from sin",
            ["lavo", "mundo", "aspergo", "dealbo", "mundus"],
            ThemeCategory.divine,
            1...11
        ),
        (
            "Mercy",
            "Appeals to God's compassion",
            ["misereor", "misericordia", "miseratio", "secundum"],
            ThemeCategory.divine,
            1...2
        ),
        (
            "Transformation",
            "Inner renewal and creation",
            ["creo", "innovo", "cor", "spiritus", "rectus", "confirmo"],
            ThemeCategory.divine,
            11...13
        ),
        (
            "Sacrifice",
            "True spiritual offerings",
            ["sacrificium", "holocaustum", "oblatio", "contribulo", "contero", "humilio"],
            ThemeCategory.worship,
            17...20
        ),
        (
            "Restoration",
            "Return of joy and salvation",
            ["gaudium", "laetitia", "exsulto", "salutaris", "reddo", "annuntio"],
            ThemeCategory.divine,
            9...16
        ),
        (
            "Divine Presence",
            "Relationship with God",
            ["facies", "spiritus", "sanctus", "principalis", "averto", "proicio"],
            ThemeCategory.divine,
            10...13
        ),
    ]

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Test Methods

    func testTotalVerses() {
        let expectedVerseCount = 20
        XCTAssertEqual(
            psalm50.count, expectedVerseCount, "Psalm 50 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 50 English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm50.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm50,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm50,
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
            text: psalm50,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm50_texts.json"
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
            psalmText: psalm50,
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
            psalmText: psalm50,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testSavePsalm50Themes() {
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
            filename: "output_psalm50_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
