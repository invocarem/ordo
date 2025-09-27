import XCTest

@testable import LatinService

class Psalm18Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true
    let id = PsalmIdentity(number: 18, category: "")

    // MARK: - Test Data Properties

    private let expectedVerseCount = 16
    private let text = [
        "Caeli enarrant gloriam Dei, et opera manuum eius annuntiat firmamentum.",
        "Dies diei eructat verbum, et nox nocti indicat scientiam.",
        "Non sunt loquelae, neque sermones, quorum non audiantur voces eorum.",
        "In omnem terram exivit sonus eorum, et in fines orbis terrae verba eorum.",
        "In sole posuit tabernaculum suum; et ipse tamquam sponsus procedens de thalamo suo,", /* 5 */
        "exsultavit ut gigas ad currendam viam. A summo caelo egressio eius, ",
        "et occursus eius usque ad summum eius; nec est qui se abscondat a calore eius.",
        "Lex Domini immaculata, convertens animas; testimonium Domini fidele, sapientiam praestans parvulis.",
        "iustitiae Domini rectae, laetificantes corda; praeceptum Domini lucidum, illuminans oculos.",
        "Timor Domini sanctus, permanens in saeculum saeculi; iudicia Domini vera, iustificata in semetipsa.",
        "Desiderabilia super aurum et lapidem pretiosum multum; et dulciora super mel et favum.",
        "Etenim servus tuus custodit ea, in custodiendis illis retributio multa.",
        "Delicta quis intelligit? ab occultis meis munda me; et ab alienis parce servo tuo.",
        "Si mei non fuerint dominati, tunc immaculatus ero, et emundabor a delicto maximo.",
        "Et erunt ut complaceant eloquia oris mei, et meditatio cordis mei in conspectu tuo semper,",
        "Domine, adiutor meus, et redemptor meus.",
    ]

    private let englishText = [
        "The heavens shew forth the glory of God, and the firmament declareth the work of his hands.",
        "Day to day uttereth speech, and night to night sheweth knowledge.",
        "There are no speeches nor languages, where their voices are not heard.",
        "Their sound hath gone forth into all the earth, and their words unto the ends of the world.",
        "He hath set his tabernacle in the sun; and he as a bridegroom coming out of his bridechamber,",
        "Hath rejoiced as a giant to run the way. His going out is from the end of heaven, ",
        "and his circuit even to the end thereof; and there is no one that can hide himself from his heat.",
        "The law of the Lord is unspotted, converting souls; the testimony of the Lord is faithful, giving wisdom to little ones.",
        "The justices of the Lord are right, rejoicing hearts; the commandment of the Lord is lightsome, enlightening the eyes.",
        "The fear of the Lord is holy, enduring for ever and ever; the judgments of the Lord are true, justified in themselves.",
        "More to be desired than gold and many precious stones; and sweeter than honey and the honeycomb.",
        "For thy servant keepeth them, and in keeping them there is a great reward.",
        "Who can understand sins? from my secret ones cleanse me, O Lord; and from those of others spare thy servant.",
        "If they shall have no dominion over me, then shall I be without spot, and I shall be cleansed from the greatest sin.",
        "And the words of my mouth shall be such as may please, and the meditation of my heart always in thy sight,",
        "O Lord, my helper and my redeemer.",
    ]

    private let lineKeyLemmas = [
        (1, ["caelum", "enarro", "gloria", "deus", "opus", "manus", "annuntio", "firmamentum"]),
        (2, ["dies", "eructo", "verbum", "nox", "indico", "scientia"]),
        (3, ["loquela", "sermo", "audio", "vox"]),
        (4, ["terra", "exeo", "sonus", "finis", "orbis", "verbum"]),
        (5, ["sol", "pono", "tabernaculum", "sponsus", "procedo", "thalamus"]),
        (6, ["exsulto", "gigas", "curro", "via", "summus", "caelum", "egressio"]),
        (7, ["occursus", "abscondo", "calor"]),
        (
            8,
            [
                "lex", "dominus", "immaculatus", "converto", "anima", "testimonium", "fidelis",
                "sapientia", "praesto", "parvulus",
            ]
        ),
        (
            9,
            [
                "iustitia", "dominus", "rectus", "laetifico", "cor", "praeceptum", "lucidus",
                "illumino", "oculus",
            ]
        ),
        (
            10,
            [
                "timor", "dominus", "sanctus", "permaneo", "saeculum", "iudicium", "verus",
                "iustifico",
            ]
        ),
        (11, ["desiderabilis", "aurum", "lapis", "pretiosus", "dulcis", "mel", "favus"]),
        (12, ["servus", "custodio", "retributio"]),
        (13, ["delictum", "intelligo", "occultus", "mundus", "alienus", "parco", "servus"]),
        (
            14,
            [
                "dominor", "immaculatus", "emundo", "delictum", "maximus",
            ]
        ),
        (15, ["complaceo", "eloquium", "os", "meditatio", "cor", "conspectus", "semper"]),
        (16, ["adiutor", "redemptor"]),
    ]

    private let structuralThemes = [
        (
            "Cosmic Declaration → Universal Reach",
            "The heavens declaring God's glory and the universal proclamation of His word",
            ["caelum", "enarro", "gloria", "firmamentum", "terra", "orbis", "verbum"],
            1,
            4,
            "The heavens declare God's glory and the firmament shows His works, with day and night proclaiming knowledge, and this message going forth to all the earth and ends of the world.",
            "Augustine sees this as the universal witness of creation to God's majesty, with the natural order itself proclaiming divine truth through its very existence and operation."
        ),
        (
            "Solar Majesty → Divine Power",
            "The sun as God's tabernacle and His powerful movement through creation",
            [
                "sol", "tabernaculum", "sponsus", "procedo", "exsulto", "gigas", "curro",
                "egressio", "calor",
            ],
            5,
            6,
            "God has set His tabernacle in the sun, proceeding like a bridegroom and rejoicing as a giant to run, with His going out from heaven and no one able to hide from His heat.",
            "For Augustine, the sun represents Christ as the light of the world, with His powerful movement through creation demonstrating divine sovereignty and the impossibility of escaping His presence."
        ),
        (
            "Divine Law → Spiritual Illumination",
            "The perfect law of the Lord that converts souls and gives wisdom",
            [
                "lex", "dominus", "immaculatus", "converto", "testimonium", "fidelis", "sapientia",
                "iustitia", "praeceptum", "lucidus", "illumino",
            ],
            7,
            9,
            "The law of the Lord is unspotted and converts souls, His testimony is faithful and gives wisdom, His justices are right and rejoice hearts, His commandment is lightsome and enlightens eyes, and His fear is holy and enduring.",
            "Augustine sees this as the complete revelation of divine truth through the law, which not only instructs but transforms the soul and illuminates the mind with spiritual understanding."
        ),
        (
            "Precious Value → Servant's Reward",
            "The surpassing value of God's law and the reward for keeping it",
            [
                "desiderabilis", "aurum", "lapis", "pretiosus", "dulcis", "mel", "favus", "servus",
                "custodio", "retributio",
            ],
            10,
            11,
            "God's law is more desirable than gold and precious stones, sweeter than honey and honeycomb, and the servant who keeps it receives great reward.",
            "For Augustine, this represents the incomparable value of divine wisdom compared to earthly treasures, and the spiritual reward that comes from faithful obedience to God's commands."
        ),
        (
            "Sin Recognition → Divine Cleansing",
            "The acknowledgment of sin and plea for divine purification",
            [
                "delictum", "intelligo", "occultus", "mundus", "alienus", "parco", "dominor",
                "emundo",
            ],
            12,
            13,
            "Who can understand sins? Cleanse me from my secret ones and spare me from others' sins. If they don't rule over me, I will be spotless and cleansed from the greatest sin.",
            "Augustine sees this as the soul's recognition of its need for divine mercy, both for known and unknown sins, and the plea for complete purification from all defilement."
        ),
        (
            "Pleasing Words → Divine Relationship",
            "The desire for acceptable speech and meditation before God",
            [
                "complaceo", "eloquium", "os", "meditatio", "cor", "conspectus", "adiutor",
                "redemptor",
            ],
            14,
            14,
            "May the words of my mouth and meditation of my heart be pleasing in Your sight, O Lord, my helper and redeemer.",
            "For Augustine, this represents the soul's final aspiration to complete communion with God through purified speech and thought, acknowledging Him as both helper and redeemer."
        ),
    ]

    private let conceptualThemes = [
        (
            "Cosmic Imagery",
            "References to heavenly bodies and cosmic phenomena",
            ["caelum", "firmamentum", "sol", "orbis", "summus", "egressio"],
            ThemeCategory.divine,
            1...6
        ),
        (
            "Divine Attributes",
            "Qualities and characteristics of God",
            [
                "gloria", "dominus", "immaculatus", "fidelis", "sanctus", "verus", "adiutor",
                "redemptor",
            ],
            ThemeCategory.divine,
            1...14
        ),
        (
            "Law and Wisdom",
            "Divine law, commandments, and wisdom",
            ["lex", "testimonium", "sapientia", "iustitia", "praeceptum", "timor", "iudicium"],
            ThemeCategory.divine,
            7...9
        ),
        (
            "Sensory Imagery",
            "References to physical senses and sensations",
            ["calor", "dulcis", "mel", "favus", "lucidus", "illumino"],
            ThemeCategory.virtue,
            6...10
        ),
        (
            "Human Response",
            "Human actions and responses to God",
            ["servus", "custodio", "meditatio", "complaceo", "intelligo", "mundus", "emundo"],
            ThemeCategory.virtue,
            11...14
        ),
        (
            "Purification Language",
            "Terms related to cleansing and purification",
            ["immaculatus", "mundus", "emundo", "delictum", "occultus", "alienus"],
            ThemeCategory.virtue,
            7...13
        ),
        (
            "Movement and Action",
            "Verbs describing movement and physical actions",
            ["enarro", "eructo", "indico", "exeo", "procedo", "exsulto", "curro", "abscondo"],
            ThemeCategory.virtue,
            1...6
        ),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
    }
    // MARK: - Test Cases

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 18 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 18 English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            text,
            "Normalized Latin text should match expected classical forms"
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
            filename: "output_psalm18_texts.json"
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
            filename: "output_psalm18_themes.json"
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
            psalmText: text,
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
}
