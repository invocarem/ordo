// Tests/LatinService/Psalm67BTests.swift
import XCTest

@testable import LatinService

class Psalm67BTests: XCTestCase {
    private let verbose = true

    // MARK: - Test Data
    let id = PsalmIdentity(number: 67, category: "B")
    private let expectedVerseCount = 18

    private let text = [
    /* 1 */ "Benedictus Dominus die quotidie; prosperum iter faciet nobis Deus salutarium nostrorum.",
    /* 2 */ "Deus noster, Deus salvos faciendi; et Domini Domini exitus mortis.",
    /* 3 */ "Verumtamen Deus confringet capita inimicorum suorum, verticem capilli perambulantium in delictis suis.",
    /* 4 */ "Dixit Dominus: Ex Basan convertam, convertam in profundum maris.",
    /* 5 */ "Ut intingatur pes tuus in sanguine; lingua canum tuorum ex inimicis ab ipso.",
    /* 6 */ "Viderunt ingressus tuos, Deus, ingressus Dei mei, regis mei, qui est in sancto.",
    /* 7 */ "Praevenerunt principes conjuncti psallentibus, in medio juvencularum tympanistriarum.",
    /* 8 */ "In ecclesiis benedicite Deo Domino, de fontibus Israel.",
    /* 9 */ "Ibi Benjamin adolescentulus, in mentis excessu; ", 
            "principes Juda, duces eorum; principes Zabulon, principes Nephthali.",
    /* 10 */ "Manda, Deus, virtuti tuae; confirma hoc, Deus, quod operatus es in nobis.",
    /* 11 */ "A templo tuo in Ierusalem, tibi offerent reges munera.",
    /* 12 */ "Increpa feras arundinis; congregatio taurorum in vaccis populorum, ut excludantur qui probati sunt argento;",
            " Dissipa gentes quae bella volunt. Venient legati ex Aegypto; Aethiopia praeveniet manus eius Deo.",
    /* 14 */ "Regna terrae, cantate Deo; psallite Domino.",
    /* 15 */ "Psallite Deo, qui ascendit super caelum caeli ad orientem; ",
            "ecce dabit voci suae vocem virtutis. Date gloriam Deo super Israel; magnificentia eius et virtus eius in nubibus.",
    /* 17 */ "Mirabilis Deus in sanctis suis; Deus Israel, ipse dabit virtutem et fortitudinem plebi suae; benedictus Deus."
]

    private let englishText = [
        "Blessed be the Lord day by day; the God of our salvation will make our journey prosperous to us.",
        "Our God is the God of salvation; and of the Lord, of the Lord are the issues from death.",
        "But God shall break the heads of his enemies, the hairy crown of them that walk on in their sins.",
        "The Lord said: I will turn them from Basan, I will turn them into the depth of the sea.",
        "That thy foot may be dipped in the blood of thy enemies; the tongue of thy dogs be red with the same.",
        "They have seen thy goings, O God, the goings of my God, of my king who is in his sanctuary.",
        "Princes went before joined with singers, in the midst of young damsels playing on timbrels.",
        "In the churches bless ye God the Lord, from the fountains of Israel.",
        "There is little Benjamin in a rapture; the princes of Juda are their leaders; the princes of Zabulon, the princes of Nephthali.",
        "Command thy strength, O God; confirm, O God, what thou hast wrought in us.",
        "From thy temple in Jerusalem, kings shall offer presents to thee.",
        "Rebuke the wild beasts of the reeds; the herd of bulls with the kine of the people, who seek to exclude them who are tried with silver; scatter thou the nations that delight in wars.",
        "Ambassadors shall come out of Egypt; Ethiopia shall soon stretch out her hands to God.",
        "Sing to God, ye kingdoms of the earth; sing ye to the Lord.",
        "Sing ye to God who mounteth above the heaven of heavens to the east; behold he will give to his voice the voice of power.",
        "Give ye glory to God over Israel; his magnificence and his power is in the clouds.",
        "God is wonderful in his saints; the God of Israel is he who will give power and strength to his people; blessed be God."
    ]

    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["benedico", "dominus", "dies", "quotidianus", "prosperus", "iter", "facio", "deus", "salutarius"]),
        (2, ["deus", "salus", "facio", "dominus", "exitus", "mors"]),
        (3, ["deus", "confringo", "caput", "inimicus", "vertex", "capillus", "perambulo", "delictum"]),
        (4, ["dico", "dominus", "Basan", "converto", "profundus", "mare"]),
        (5, ["intingo", "pes", "sanguis", "lingua", "canis", "inimicus"]),
        (6, ["video", "ingressus", "deus", "rex", "sanctus"]),
        (7, ["praevenio", "princeps", "conjungo", "psallo", "juvenculus", "tympanisterium"]),
        (8, ["ecclesia", "benedico", "deus", "fons", "Israel"]),
        (9, ["Benjamin", "adolescentulus", "mentis", "excessus", "princeps", "Iuda", "Zabulon", "Nephthali"]),
        (10, ["mandato", "virtus", "confirmo", "opus"]),
        (11, ["templum", "Ierusalem", "rex", "munus"]),
        (12, ["increpo", "fera", "arundinis", "congregatio", "taurus", "vacca", "populus", "excludo", "probo", "argentum", "dissipo", "gens", "bellum"]),
        (13, ["venio", "legatus", "Aegyptus", "Aethiopia", "praevenio", "manus", "deus"]),
        (14, ["regnum", "terra", "canto", "deus", "psallo", "dominus"]),
        (15, ["psallo", "deus", "ascendo", "caelum", "oriens", "vox", "virtus"]),
        (16, ["do", "gloria", "deus", "Israel", "magnificentia", "nubes"]),
        (17, ["mirabilis", "sanctus", "deus", "Israel", "virtus", "fortitudo", "plebs", "benedico", "deus"])
    ]

private let structuralThemes = [
    (
        "Blessing → Salvation",
        "Daily blessing leading to divine salvation",
        ["benedico", "dominus", "prosperus", "iter", "deus", "salutarius"],
        1,
        2,
        "The opening establishes a daily blessing that leads to divine salvation",
        "Augustine would see this as the pattern of grace in the Christian life, where daily blessings are the means by which God draws us closer to ultimate salvation. The daily blessing is a reminder of God's constant presence and care, leading to a deeper trust in His salvific work."
    ),
    (
        "Divine Judgment → Victory",
        "God's judgment of enemies leading to victory",
        ["deus", "confringo", "caput", "inimicus", "dominus", "Basan", "profundus", "mare"],
        3,
        4,
        "God's judgment of enemies and their fate",
        "From Augustine's perspective, this represents the divine judgment against sin and evil. The breaking of heads symbolizes the defeat of sinful desires and the enemies of the soul. The turning into the depths of the sea represents the complete and final victory over evil, a theme Augustine explores in his writings on the City of God."
    ),
    (
        "Victory → Worship",
        "Divine victory leading to worship and celebration",
        ["intingo", "pes", "sanguis", "lingua", "canis", "video", "ingressus", "deus", "rex", "sanctus"],
        5,
        6,
        "The imagery of victory leading to worship",
        "Augustine would interpret this as the natural response of the soul to God's victory over evil. The imagery of feet dipped in blood and the tongue of dogs red with the same represents the complete defeat of sin. The vision of God's goings leads to worship, as the soul recognizes and responds to God's mighty acts of deliverance."
    ),
    (
        "Celebration → Unity",
        "Celebration of God's victory leading to unity among people",
        ["praevenio", "princeps", "conjungo", "psallo", "juvenculus", "tympanisterium", "ecclesia", "benedico", "deus", "fons", "Israel"],
        7,
        8,
        "The celebration of God's victory leading to unity",
        "Augustine sees this as the unity of the Church, the body of Christ. The celebration of God's victory brings people together in worship, symbolized by the princes going before joined with singers. This unity is a reflection of the unity of the Trinity and the communal nature of the Christian faith."
    ),
    (
        "Unity → Strength",
        "Unity among people leading to divine strength",
        ["Benjamin", "adolescentulus", "mentis", "excessus", "princeps", "Iuda", "Zabulon", "Nephthali", "mandato", "virtus", "confirmo", "opus"],
        9,
        10,
        "The unity among people leading to divine strength",
        "From Augustine's perspective, this represents the strength found in the unity of the Church. The mention of different tribes and leaders symbolizes the diversity within the unity of the body of Christ. The command to divine strength reflects the empowerment that comes from living in communion with God and with one another."
    ),
    (
        "Strength → Offering → Rebuke",
        "Divine strength leading to offerings from kings and divine rebuke of enemies",
        ["templum", "Ierusalem", "rex", "munus", "increpo", "fera", "arundinis", "congregatio", "taurus", "vacca", "populus", "excludo", "probo", "argentum", "dissipo", "gens", "bellum"],
        11,
        12,
        "The divine strength leading to offerings from kings and divine rebuke of enemies",
        "From Augustine's perspective, this represents the natural response of those who have experienced God's strength and salvation. The offerings from kings represent the gifts and talents that believers offer to God in gratitude for His blessings. The rebuke of enemies symbolizes the defeat of sin and evil, which is a natural consequence of living in righteousness."
    ),
    (
        "Rebuke → Praise",
        "Divine rebuke leading to praise from nations",
        ["venio", "legatus", "Aegyptus", "Aethiopia", "praevenio", "manus", "deus", "regnum", "terra", "canto", "deus", "psallo", "dominus"],
        13,
        14,
        "The divine rebuke leading to praise from nations",
        "Augustine sees this as the universal response to God's justice and mercy. The rebuke of enemies leads to praise from nations, symbolizing the spread of the Gospel and the recognition of God's sovereignty. The ambassadors coming from Egypt and Ethiopia represent the inclusion of all peoples in the body of Christ."
    ),
    (
        "Praise → Ascension → Glory",
        "Praise leading to God's ascension and power, and ultimately to His glory over Israel",
        ["psallo", "deus", "ascendo", "caelum", "oriens", "vox", "virtus", "do", "gloria", "Israel", "magnificentia", "nubes"],
        15,
        16,
        "The praise leading to God's ascension and power, and ultimately to His glory over Israel",
        "From Augustine's perspective, this represents the ascension of Christ and the manifestation of divine power. The praise of the faithful leads to a deeper understanding of God's glory and majesty. The ascension to the heaven of heavens symbolizes the exaltation of Christ and the hope of the believer's ultimate union with God. The glory over Israel symbolizes the fulfillment of God's promises to His people and the ultimate realization of His kingdom."
    ),
    (
        "Glory → Benediction",
        "Divine glory leading to final benediction",
        ["mirabilis", "sanctus", "deus", "Israel", "virtus", "fortitudo", "plebs", "benedico", "deus"],
        17,
        17,
        "The divine glory leading to final benediction",
        "From Augustine's perspective, this represents the ultimate blessing that comes from experiencing God's glory. The final benediction is a reminder of God's constant presence and care, leading to a deeper trust in His providence. The wonder of God in His saints reflects the transformative power of grace in the lives of believers."
    )
]
private let conceptualThemes = [
    (
        "Divine Blessing and Salvation",
        "The daily blessing of God as a source of prosperity and salvation, and God as the source of salvation and deliverance from death",
        ["benedico", "dominus", "dies", "quotidianus", "prosperus", "iter", "salutarius", "deus", "salus", "facio", "exitus", "mors"],
        ThemeCategory.divine,
        1...2
    ),
    (
        "Divine Judgment and Victory",
        "God's judgment and breaking of enemies, and God's victory over enemies and their fate",
        ["deus", "confringo", "caput", "inimicus", "vertex", "capillus", "delictum", "dominus", "Basan", "converto", "profundus", "mare"],
        ThemeCategory.divine,
        3...4
    ),
    (
        "Victory and Animal Imagery",
        "Imagery of victory with blood and dogs, and rebuke of wild beasts and scattering of nations",
        ["intingo", "pes", "sanguis", "lingua", "canis", "inimicus", "increpo", "fera", "arundinis", "congregatio", "taurus", "vacca", "populus", "excludo", "probo", "argentum", "dissipo", "gens", "bellum"],
        ThemeCategory.virtue,
        5...12
    ),
    (
        "Divine Presence and Worship",
        "The presence of God in His sanctuary, and celebration and worship with princes and singers",
        ["video", "ingressus", "deus", "rex", "sanctus", "praevenio", "princeps", "conjungo", "psallo", "juvenculus", "tympanisterium"],
        ThemeCategory.worship,
        6...7
    ),
    (
        "Tribal Unity and Royal Offerings",
        "Unity among different tribes and leaders, and offerings from kings to God's temple",
        ["Benjamin", "adolescentulus", "mentis", "excessus", "princeps", "Iuda", "Zabulon", "Nephthali", "templum", "Ierusalem", "rex", "munus"],
        ThemeCategory.virtue,
        9...11
    ),
    (
        "Global Praise and Divine Ascension",
        "Praise from nations and ambassadors, and God's ascension and manifestation of power and glory",
        ["venio", "legatus", "Aegyptus", "Aethiopia", "praevenio", "manus", "deus", "psallo", "ascendo", "caelum", "oriens", "vox", "virtus", "do", "gloria", "Israel", "magnificentia", "nubes"],
        ThemeCategory.worship,
        13...16
    ),
    (
        "Final Benediction",
        "Final benediction and divine blessing, representing the ultimate blessing and transformative power of grace",
        ["mirabilis", "sanctus", "deus", "Israel", "virtus", "fortitudo", "plebs", "benedico"],
        ThemeCategory.divine,
        17...17
    )
]


    // MARK: - Test Cases

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, 
                        "Psalm 67B should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 67B English text should have \(expectedVerseCount) verses"
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
            filename: "output_psalm67B_texts.json"
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
            filename: "output_psalm67B_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}