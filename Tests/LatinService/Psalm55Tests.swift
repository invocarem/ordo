import XCTest

@testable import LatinService

final class Psalm55Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    let id = PsalmIdentity(number: 55, category: nil)
    private let expectedVerseCount = 13

    private let text: [String] = [
        "Miserere mei, Deus, quoniam conculcavit me homo; tota die impugnans tribulavit me.",
        "Conculcaverunt me inimici mei tota die; quoniam multi bellantes adversum me.",
        "Ab altitudine diei timebo; ego vero in te sperabo.",
        "In Deo laudabo sermones meos, in Deo speravi; non timebo quid faciat mihi caro.",
        "Tota die verba mea execrabantur; adversum me omnia cogitata eorum in malum.",
        "Inhabitabunt, et abscondent; ipsi calcaneum meum observabunt.",
        "Sicut sustinuerunt animam meam, pro nihilo salvos facies illos; in ira populos confringes.",
        "Deus, vitam meam annuntiavi tibi; posuisti lacrimas meas in conspectu tuo.",
        "Sicut et in promissione tua: tunc convertentur inimici mei retrorsum;",
        "In quacumque die invocavero te: ecce cognovi quoniam Deus meus es.",
        "In Deo laudabo verbum, in Domino laudabo sermonem; in Deo speravi, non timebo quid faciat mihi homo.",
        "In me sunt, Deus, vota tua, quae reddam, laudationes tibi;",
        "Quoniam eripuisti animam meam de morte, et pedes meos de lapsu, ut placeam coram Deo in lumine viventium."
    ]

    private let englishText: [String] = [
        "Have mercy on me, O God, for man hath trodden me under foot; all the day long he hath afflicted me fighting against me.",
        "My enemies have trodden on me all the day long; for they are many that make war against me.",
        "From the height of the day I shall fear; but I will trust in thee.",
        "In God I will praise my words, in God I have hoped; I will not fear what flesh can do unto me.",
        "All the day long they detested my words; all their thoughts were against me unto evil.",
        "They will dwell and hide themselves; they will watch my heel.",
        "As they have waited for my soul, for nothing shalt thou save them; in thy wrath thou shalt break the people in pieces.",
        "O God, I have declared to thee my life; thou hast set my tears in thy sight.",
        "As also in thy promise: then shall my enemies be turned back;",
        "In what day soever I shall call upon thee: behold I know that thou art my God.",
        "In God will I praise the word, in the Lord will I praise his speech; in God have I hoped, I will not fear what man can do unto me.",
        "In me, O God, are vows to thee, which I will pay, praises to thee;",
        "Because thou hast delivered my soul from death, and my feet from falling, that I may please in the sight of God, in the light of the living."
    ]

    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["misereor", "conculco", "homo", "impugno", "tribulo"]),
        (2, ["conculco", "inimicus", "bello"]),
        (3, ["altitudo", "timeo", "spero"]),
        (4, ["laudo", "sermo", "spero", "timeo", "caro"]),
        (5, ["execror", "verbum", "cogito", "malus"]),
        (6, ["inhabito", "abscondo", "calcaneum", "observo"]),
        (7, ["sustinero", "anima", "salvo", "ira", "populus", "confringo"]),
        (8, ["vita", "annuntio", "lacrima", "conspectus"]),
        (9, ["promissio", "convertor", "inimicus", "retrorsum"]),
        (10, ["invoco", "cognosco", "deus"]),
        (11, ["laudo", "verbum", "dominus", "spero", "timeo", "homo"]),
        (12, ["votum", "reddo", "laudatio"]),
        (13, ["eripio", "anima", "mors", "pes", "lapsus", "placeo", "lumen", "vivo"])
    ]

    private let structuralThemes: [(String, String, [String], Int, Int, String, String)] = [
        (
            "Mercy → Oppression",
            "From plea for mercy to the harsh reality of being trodden down",
            ["misereor", "conculco", "homo", "impugno", "tribulo", "inimicus", "bello"],
            1,
            2,
            "The psalmist cries for mercy as he is crushed by enemies who constantly attack and afflict him. This sets up the central conflict of the psalm.",
            "Augustine observes that the cry for mercy is the first act of the soul turned toward God, even amid overwhelming oppression — a sign of hope, not despair (Enarr. Ps. 55.1)."
        ),
        (
            "Height → Trust",
            "From fear of human height to anchoring hope in God",
            ["altitudo", "timeo", "spero", "laudo", "caro"],
            3,
            4,
            "The psalmist shifts from trembling at human power and lofty threats to placing unwavering trust in God's protection, even when flesh seeks to harm.",
            "Augustine teaches that true fear is not of man's height but of God's absence — to hope in Him is to transcend all terror (Enarr. Ps. 55.3)."
        ),
        (
            "Plot → Deliverance",
            "From hidden plots of enemies to divine intervention and eternal life",
            ["execror", "cogito", "malus", "inhabito", "calcaneus", "sustinero", "anima", "salvo", "confringo", "lacrima", "conspectus", "invoco", "cognosco", "eripio", "lumen", "vivens"],
            5,
            13,
            "The enemies plot, lie in wait, and watch for the psalmist's fall, but God hears his cries, records his tears, and delivers him from death into the light of life.",
            "Augustine sees this as the soul's journey from despair to revelation: when the wicked seem triumphant, God's justice unfolds — He sees, hears, and redeems those who call upon Him (Enarr. Ps. 55.13)."
        )
    ]

    private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = [
        (
            "Divine Sovereignty",
            "God's authority and intimate knowledge",
            ["cognosco", "invoco", "deus"],
            .divine,
            nil as ClosedRange<Int>?
        ),
        (
            "Divine Justice",
            "God's wrath against the wicked and deliverance of the just",
            ["confringo", "ira", "salvo", "inimicus"],
            .justice,
            5 ... 13
        ),
        (
            "Life vs. Death",
            "From the shadow of death to the light of eternal life",
            ["vita", "lux", "vivens", "mors"],
            .virtue,
            13 ... 13
        ),
        (
            "Divine Remembrance",
            "God records tears and hears the cry of the afflicted",
            ["lacrima", "conspectus", "annuntio"],
            .divine,
            8 ... 8
        ),
        (
            "Righteous Response",
            "The psalmist's praise, trust, and vows as acts of faith",
            ["laudo", "spero", "votum", "reddo"],
            .worship,
            4 ... 4
        ),
        (
            "Spiritual Opposition",
            "Enemies plotting with malice and hidden intent",
            ["cogito", "malus", "execror", "inhabito"],
            .opposition,
            5 ... 6
        )
    ]

    func testTotalVerses() {
        XCTAssertEqual(text.count, expectedVerseCount, "Psalm 55 should have \(expectedVerseCount) verses")
        XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 55 English text should have \(expectedVerseCount) verses")
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(normalized, text, "Normalized Latin text should match expected classical forms")
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
        let structuralLemmas = structuralThemes.flatMap { $0.2 }
        let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }
        utilities.testLemmasInSet(
            sourceLemmas: structuralLemmas,
            targetLemmas: lineKeyLemmasFlat,
            sourceName: "structural themes",
            targetName: "lineKeyLemmas",
            verbose: verbose
        )
        utilities.testStructuralThemes(
            psalmText: text,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
        let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }
        utilities.testLemmasInSet(
            sourceLemmas: conceptualLemmas,
            targetLemmas: lineKeyLemmasFlat,
            sourceName: "conceptual themes",
            targetName: "lineKeyLemmas",
            verbose: verbose,
            failOnMissing: false
        )
        utilities.testConceptualThemes(
            psalmText: text,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testSaveThemes() {
        guard let jsonString = utilities.generateCompleteThemesJSONString(
            psalmNumber: id.number,
            conceptualThemes: conceptualThemes,
            structuralThemes: structuralThemes
        ) else {
            XCTFail("Failed to generate complete themes JSON")
            return
        }
        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm55_themes.json"
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
            filename: "output_psalm55_texts.json"
        )
        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}