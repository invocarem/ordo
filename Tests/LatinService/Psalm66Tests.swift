import XCTest

@testable import LatinService

class Psalm66Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self

    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    let id = PsalmIdentity(number: 66, category: nil)
    private let expectedVerseCount = 6

    // MARK: - Test Data

    private let text = [
        "Deus misereatur nostri, et benedicat nobis; illuminet vultum suum super nos, et misereatur nostri.",
        "Ut cognoscamus in terra viam tuam, in omnibus gentibus salutare tuum.",
        "Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.",
        "Laetentur et exsultent gentes, quoniam iudicas populos in aequitate, et gentes in terra dirigis.",
        "Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.Terra dedit fructum suum;",
        "Benedicat nos Deus, Deus noster. Benedicat nos Deus; et metuant eum omnes fines terrae.",
    ]

    private let englishText = [
        "May God have mercy on us, and bless us: may he cause the light of his countenance to shine upon us, and may he have mercy on us.",
        "That we may know thy way upon earth, thy salvation in all nations.",
        "Let people confess to thee, O God: let all people give glory to thee.",
        "Let the nations be glad and rejoice: for thou judgest the people with justice, and directest the nations upon earth.",
        "Let people confess to thee, O God: let all people give glory to thee. The earth hath yielded her fruit.",
        "May God, our God, bless us, may God bless us: and all the ends of the earth fear him.",
    ]

    private let lineKeyLemmas = [
        (1, ["deus", "misereor", "benedico", "illumino", "vultus", "super", "nos"]),
        (2, ["cognosco", "terra", "via", "tuus", "omnis", "gens", "salutare"]),
        (3, ["confiteor", "tu", "populus", "deus", "omnis"]),
        (4, ["laetor", "exsulto", "gens", "quoniam", "iudico", "populus", "aequitas", "dirigo"]),
        (5, ["confiteor", "tu", "populus", "deus", "omnis", "terra", "do", "fructus"]),
        (6, ["benedico", "nos", "deus", "noster", "metuo", "is", "omnis", "finis", "terra"]),
    ]

    private let structuralThemes = [
        (
            "Divine Blessing → Universal Recognition",
            "From God's mercy and blessing to worldwide acknowledgment of salvation",
            ["misereor", "benedico", "illumino", "cognosco", "salutare", "omnis", "gens"],
            1,
            2,
            "The psalm opens with a prayer for divine blessing and mercy, then expands to show how this blessing leads to universal recognition of God's way and salvation among all nations.",
            "Augustine sees this as the Church's prayer for divine illumination, where God's face shining upon us (illuminet vultum suum) represents the light of truth that enables all nations to recognize the way of salvation. The progression from personal blessing to universal knowledge reflects the Church's mission to make God known to all peoples (Enarr. Ps. 66.1-2)."
        ),
        (
            "Universal Confession → Joyful Judgment",
            "From all peoples confessing to God to nations rejoicing in divine justice",
            ["confiteor", "populus", "omnis", "laetor", "exsulto", "iudico", "aequitas", "dirigo"],
            3,
            4,
            "All peoples are called to confess and give glory to God, leading to universal joy as nations recognize God's just judgment and guidance over all peoples.",
            "Augustine interprets this as the Church's universal confession of faith, where all nations come to acknowledge God's sovereignty. The joy and exultation arise from recognizing that God judges with equity (aequitate) and directs nations according to his righteous will. This reflects the Church's understanding that true joy comes from living under God's just governance (Enarr. Ps. 66.3-4)."
        ),
        (
            "Repeated Confession → Earthly Fruitfulness",
            "From continued universal praise to the earth yielding its fruit in response",
            ["confiteor", "populus", "omnis", "terra", "do", "fructus", "benedico", "metuo"],
            5,
            6,
            "The repeated call for universal confession leads to the earth's response of fruitfulness, culminating in divine blessing that causes all the ends of the earth to fear God.",
            "Augustine sees this as the Church's persistent prayer and confession leading to God's blessing of creation itself. The earth giving fruit (terra dedit fructum suum) symbolizes the Church's spiritual fruitfulness when nations turn to God. The fear of God at the ends of the earth represents the universal reverence that comes from recognizing divine sovereignty over all creation (Enarr. Ps. 66.5-6)."
        ),
    ]

    private let conceptualThemes = [
        (
            "Divine Sovereignty",
            "God's authority and power over all creation",
            ["deus", "iudico", "dirigo", "metuo"],
            ThemeCategory.divine,
            nil as ClosedRange<Int>?
        ),
        (
            "Universal Worship",
            "All nations and peoples praising God",
            ["confiteor", "populus", "omnis", "gens", "laetor", "exsulto"],
            .worship,
            3...5
        ),
        (
            "Divine Blessing",
            "God's mercy, blessing, and illumination",
            ["misereor", "benedico", "illumino", "salutare"],
            .worship,
            1...2
        ),
        (
            "Divine Justice",
            "God's righteous judgment and guidance",
            ["iudico", "aequitas", "dirigo"],
            .justice,
            4...4
        ),
        (
            "Earthly Fruitfulness",
            "The earth's response to divine blessing",
            ["terra", "fructus", "do", "finis"],
            .divine,
            5...6
        ),
        (
            "Universal Recognition",
            "All nations acknowledging God's way",
            ["cognosco", "via", "omnis", "gens", "salutare"],
            .divine,
            2...2
        ),
    ]

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 66 should have \(expectedVerseCount) verses")
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 66 English text should have \(expectedVerseCount) verses")
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
        utilities.testStructuralThemes(
            psalmText: text,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
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
            filename: "output_psalm66_themes.json"
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
            filename: "output_psalm66_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}
