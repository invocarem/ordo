import XCTest

@testable import LatinService

class Psalm94Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self

    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    let id = PsalmIdentity(number: 94, category: "")
    private let expectedVerseCount = 11

    // MARK: - Test Data

    private let text = [
        "Venite, exsultemus Domino; iubilemus Deo salutari nostro.",
        "Praeveniamus faciem eius in confessione, et in psalmis iubilemus ei.",
        "Quoniam Deus magnus Dominus, et rex magnus super omnes deos.",
        "Quia in manu eius sunt omnes fines terrae, et altitudines montium ipsius sunt.",
        "Quoniam ipsius est mare, et ipse fecit illud, et aridam fundaverunt manus eius.",
        "Venite, adoremus, et procidamus ante Deum; ploremus coram Domino qui fecit nos.",
        "Quia ipse est Dominus Deus noster, et nos populus pascuae eius, et oves manus eius.",
        "Hodie si vocem eius audieritis, nolite obdurare corda vestra,",
        "sicut in exacerbatione secundum diem tentationis in deserto, ubi tentaverunt me patres vestri, probaverunt et viderunt opera mea.",
        "Quadraginta annis offensus fui generationi illi, et dixi: Semper hi errant corde.",
        "Et isti non cognoverunt vias meas: ut iuravi in ira mea: Si introibunt in requiem meam.",
    ]

    private let englishText = [
        "Come let us praise the Lord with joy; let us joyfully sing to God our saviour.",
        "Let us come before his presence with thanksgiving; and make a joyful noise to him with psalms.",
        "For the Lord is a great God, and a great King above all gods.",
        "For in his hand are all the ends of the earth, and the heights of the mountains are his.",
        "For the sea is his, and he made it, and his hands formed the dry land.",
        "Come let us adore and fall down, and weep before the Lord that made us.",
        "For he is the Lord our God, and we are the people of his pasture and the sheep of his hand.",
        "Today if you shall hear his voice, harden not your hearts,",
        "As in the provocation, according to the day of temptation in the wilderness, where your fathers tempted me; they proved me, and saw my works.",
        "Forty years long was I offended with that generation, and I said: These always err in heart.",
        "And these men have not known my ways; so I swore in my wrath that they shall not enter into my rest.",
    ]

    private let lineKeyLemmas = [
        (1, ["venio", "exsulto", "dominus", "iubilo", "deus", "salutaris"]),
        (2, ["praevenio", "facies", "confessio", "psalmus", "iubilo"]),
        (3, ["deus", "magnus", "dominus", "rex", "magnus", "super", "omnis", "deus"]),
        (4, ["manus", "omnis", "finis", "terra", "altitudo", "mons", "ipse"]),
        (5, ["mare", "ipse", "facio", "aridus", "fundo", "manus"]),
        (6, ["venio", "adoro", "procido", "ante", "deus", "ploro", "coram", "dominus", "facio"]),
        (7, ["ipse", "dominus", "deus", "populus", "pascuum", "ovis", "manus"]),
        (8, ["hodie", "vox", "audio", "obduro", "cor", "vester"]),
        (
            9,
            [
                "exacerbatio", "secundum", "dies", "tentatio", "desertum", "tento", "pater",
                "probo", "video", "opus",
            ]
        ),
        (10, ["quadraginta", "annus", "offendo", "generatio", "dico", "semper", "erro", "cor"]),
        (11, ["cognosco", "via", "iuro", "ira", "introeo", "requies"]),
    ]

    private let structuralThemes = [
        (
            "Call to Worship",
            "Invitation to praise and worship with joy",
            ["venio", "exsulto", "iubilo", "praevenio", "confessio", "psalmus"],
            1,
            2,
            "The psalm opens with a double invitation to come and rejoice in the Lord, to praise him with thanksgiving and psalms.",
            "Augustine sees this as the fundamental call to worship that begins all liturgical celebration. The repeated 'Venite' emphasizes the communal nature of worship (Enarr. Ps. 94.1-2)."
        ),
        (
            "Divine Greatness",
            "God's supremacy over all creation and gods",
            [
                "deus", "magnus", "dominus", "rex", "super", "deus", "manus", "finis", "terra",
                "altitudo", "mons",
            ],
            3,
            4,
            "The psalmist declares God's greatness as Lord and King above all gods, and his sovereignty over all the earth and mountains.",
            "Augustine emphasizes that God's greatness is not merely comparative but absolute. He is King over all other powers, both spiritual and temporal (Enarr. Ps. 94.3-4)."
        ),
        (
            "Creation and Ownership",
            "God as creator and owner of all creation",
            ["mare", "ipse", "facio", "aridus", "fundo", "manus"],
            5,
            5,
            "The psalm describes God's ownership of the sea and his creation of the dry land, emphasizing his role as creator.",
            "Augustine sees this as establishing God's absolute ownership of creation. The sea and dry land represent the totality of the earth's surface (Enarr. Ps. 94.5)."
        ),
        (
            "Worship and Relationship",
            "Physical worship and the shepherd-flock relationship",
            [
                "venio", "adoro", "procido", "ploro", "dominus", "deus", "populus", "pascuum",
                "ovis",
            ],
            6,
            7,
            "The psalm calls for physical worship (adoration, prostration, weeping) and describes the relationship between God and his people as shepherd and flock.",
            "Augustine interprets the physical acts of worship as expressions of humility and recognition of God's majesty. The shepherd imagery emphasizes God's care and protection (Enarr. Ps. 94.6-7)."
        ),
        (
            "Warning and Historical Lesson",
            "Warning against hardening hearts with reference to wilderness experience",
            [
                "hodie", "vox", "audio", "obduro", "cor", "exacerbatio", "tentatio", "desertum",
                "tento", "probo",
            ],
            8,
            9,
            "The psalm warns against hardening hearts and references the historical provocation in the wilderness where the fathers tempted and tested God.",
            "Augustine sees this as a crucial warning for all generations. The wilderness experience serves as a negative example of disobedience and lack of faith (Enarr. Ps. 94.8-9)."
        ),
        (
            "Divine Judgment",
            "God's response to disobedience and unbelief",
            [
                "quadraginta", "annus", "offendo", "generatio", "erro", "cor", "cognosco", "via",
                "iuro", "ira", "requies",
            ],
            10,
            11,
            "The psalm concludes with God's judgment on the disobedient generation and his oath that they would not enter his rest.",
            "Augustine emphasizes that God's judgment is both just and merciful. The forty years represent a full period of testing, and the denial of rest shows the consequences of persistent unbelief (Enarr. Ps. 94.10-11)."
        ),
    ]

    private let conceptualThemes = [
        (
            "Joyful Worship",
            "Praise and rejoicing in the Lord",
            ["venio", "exsulto", "iubilo", "praevenio", "confessio", "psalmus", "adoro"],
            ThemeCategory.worship,
            nil as ClosedRange<Int>?
        ),
        (
            "Divine Supremacy",
            "God's greatness and kingship over all",
            ["deus", "magnus", "dominus", "rex", "super", "deus"],
            .divine,
            3...3
        ),
        (
            "Creation and Sovereignty",
            "God's ownership and creation of the world",
            ["manus", "finis", "terra", "altitudo", "mons", "mare", "facio", "aridus", "fundo"],
            .divine,
            4...5
        ),
        (
            "Physical Worship",
            "Bodily expressions of reverence",
            ["procido", "ploro", "coram"],
            .worship,
            6...6
        ),
        (
            "Shepherd Imagery",
            "God's care for his people",
            ["populus", "pascuum", "ovis", "manus"],
            .divine,
            7...7
        ),
        (
            "Warning and Obedience",
            "Call to listen and not harden hearts",
            ["hodie", "vox", "audio", "obduro", "cor"],
            .virtue,
            8...8
        ),
        (
            "Historical Memory",
            "Reference to wilderness experience",
            ["exacerbatio", "tentatio", "desertum", "tento", "probo", "pater"],
            .sin,
            9...9
        ),
        (
            "Divine Judgment",
            "God's response to disobedience",
            [
                "quadraginta", "annus", "offendo", "generatio", "erro", "cognosco", "via", "iuro",
                "ira", "requies",
            ],
            .justice,
            10...11
        ),
    ]

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 94 should have \(expectedVerseCount) verses")
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 94 English text should have \(expectedVerseCount) verses")
        // Also validate the orthography of the text for analysis consistency
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            text,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testLineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: text,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testStructuralThemes() {
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
        // First, verify that conceptual theme lemmas are in lineKeyLemmas
        let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
        let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

        utilities.testLemmasInSet(
            sourceLemmas: conceptualLemmas,
            targetLemmas: lineKeyLemmasFlat,
            sourceName: "conceptual themes",
            targetName: "lineKeyLemmas",
            verbose: verbose,
            failOnMissing: false  // Conceptual themes may have additional imagery lemmas
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
        guard
            let jsonString = utilities.generateCompleteThemesJSONString(
                psalmNumber: id.number,
                conceptualThemes: conceptualThemes,
                structuralThemes: structuralThemes
            )
        else {
            XCTFail("Failed to generate complete themes JSON")
            return
        }

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm94_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }

    func testSaveTexts() {
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: text,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm94_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}
