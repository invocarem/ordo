// Tests/LatinService/Psalm101Tests.swift
import XCTest
@testable import LatinService

class Psalm101Tests: XCTestCase {
    // MARK: - Service & Helpers
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    // --------------------------------------------------------------------
    // Psalm identity & data
    // --------------------------------------------------------------------
    let id = PsalmIdentity(number: 101, category: nil)
    private let expectedVerseCount = 29

    private let text = [
        "Domine, exaudi orationem meam, et clamor meus ad te veniat.",
        "Ne avertas faciem tuam a me; in quacumque die tribulor, inclina ad me aurem tuam.",
        "In quacumque die invocavero te, velociter exaudi me.",
        "Quia defecerunt sicut fumus dies mei, et ossa mea sicut cremium aruerunt.",
        /* 5 */ "Percussus sum ut foenum, et aruit cor meum, quia oblitus sum comedere panem meum.",
        "A voce gemitus mei adhaesit os meum carni meae.",
        "Similis factus sum pellicano solitudinis; factus sum sicut nycticorax in domicilio.",
        "Vigilavi, et factus sum sicut passer solitarius in tecto.",
        "Tota die exprobrabant mihi inimici mei; et qui laudabant me adversum me iurabant.",
        /* 10 */ "Quia cinerem tamquam panem manducabam, et potum meum cum fletu miscebam.",
        "A facie irae et indignationis tuae, quia elevans allisisti me.",
        "Dies mei sicut umbra declinaverunt, et ego sicut foenum arui.",
        "Tu autem, Domine, in aeternum permanes, et memoriale tuum in generationem et generationem.",
        "Tu exsurgens misereberis Sion, quia tempus miserendi eius, quia venit tempus.",
        /* 15 */ "Quoniam placuerunt servis tuis lapides eius, et terrae eius miserebuntur.",
        "Et timebunt gentes nomen tuum, Domine, et omnes reges terrae gloriam tuam.",
        "Quia aedificavit Dominus Sion, et videbitur in gloria sua.",
        "Respexit in orationem humilium, et non sprevit precem eorum.",
        "Scribantur haec in generatione altera, et populus qui creabitur laudabit Dominum.",
        /* 20 */ "Quia prospexit de excelso sancto suo; Dominus de caelo in terram aspexit,",
        "ut audiret gemitus compeditorum, ut solveret filios interemptorum,",
        "ut annuntient in Sion nomen Domini, et laudem eius in Ierusalem,",
        "in conveniendo populos in unum, et reges ut serviant Domino.",
        "Respondit ei in via virtutis suae: Paucitatem dierum meorum nuntia mihi.",
        /* 25 */ "Ne revoces me in dimidio dierum meorum; in generationem et generationem anni tui.",
        "Initio tu, Domine, terram fundasti, et opera manuum tuarum sunt caeli.",
        "Ipsi peribunt, tu autem permanes; et omnes sicut vestimentum veterascent,",
        "et sicut opertorium mutabis eos, et mutabuntur. Tu autem idem ipse es, et anni tui non deficient.",
        "Filii servorum tuorum habitabunt, et semen eorum in saeculum dirigetur."
    ]

    private let englishText = [
        "Hear, O Lord, my prayer: and let my cry come to thee.",
        "Turn not away thy face from me; in the day when I am in trouble, incline thy ear to me.",
        "In what day soever I shall call upon thee, hear me speedily.",
        "For my days are vanished like smoke: and my bones are grown dry like fuel for the fire.",
        "I am smitten as grass, and my heart is withered: because I forgot to eat my bread.",
        "Through the voice of my groaning, my bone hath cleaved to my flesh.",
        "I am become like to a pelican of the wilderness: I am like a night raven in the house.",
        "I have watched, and am become as a sparrow all alone on the housetop.",
        "All the day long my enemies reproached me; and they that praised me did swear against me.",
        "For I did eat ashes like bread, and mingled my drink with weeping.",
        "Because of thy anger and indignation: for having lifted me up thou hast cast me down.",
        "My days have declined like a shadow, and I am withered like grass.",
        "But thou, O Lord, endurest for ever: and thy memorial to all generations.",
        "Thou shalt arise and have mercy on Sion: for it is time to have mercy on it, for the time is come.",
        "For the stones thereof have pleased thy servants; and they shall have pity on the earth thereof.",
        "And the Gentiles shall fear thy name, O Lord, and all the kings of the earth thy glory.",
        "For the Lord hath built up Sion: and he shall be seen in his glory.",
        "He hath had regard to the prayer of the humble: and he hath not despised their petition.",
        "Let these things be written unto another generation: and the people that shall be created shall praise the Lord.",
        "Because he hath looked forth from his high sanctuary; from heaven the Lord hath looked upon the earth.",
        "That he might hear the groans of them that are in fetters; that he might release the children of the slain.",
        "That they may declare the name of the Lord in Sion; and his praise in Jerusalem;",
        "When the people assemble together, and kings, to serve the Lord.",
        "He answered him in the way of his strength: Declare unto me the fewness of my days.",
        "Call me not away in the midst of my days: thy years are unto generation and generation.",
        "In the beginning, O Lord, thou foundedst the earth: and the heavens are the works of thy hands.",
        "They shall perish but thou remainest; and all of them shall grow old like a garment:",
        "And as a vesture thou shalt change them, and they shall be changed. But thou art always the selfsame, and thy years shall not fail.",
        "The children of thy servants shall continue; and their seed shall be directed for ever."
    ]

    // --------------------------------------------------------------------
    // Key lemmas – only significant words (no function words)
    // --------------------------------------------------------------------
   private let lineKeyLemmas = [
    (1, ["exaudio", "oratio", "clamor", "dominus", "venio"]),
    (2, ["averto", "facies", "tribulor", "inclino", "auris"]),
    (3, ["invoco", "exaudio", "velox" , "quacumque", "dies"]),
    (4, ["deficio", "fumus", "dies", "cremium", "os", "areo"]),
    (5, ["percutio", "foenum", "areo", "cor", "obliviscor", "comedo", "panis"]),
    (6, ["gemitus", "adhaereo", "os", "caro"]),
    (7, ["similis", "pellicanus", "solitudo", "nycticorax", "domicilium"]),
    (8, ["vigilo", "passer", "solitarius", "tectum"]),
    (9, ["exprobro", "inimicus", "laudo", "iuro"]),
    (10, ["cinis", "panis", "manduco", "potus", "fletus", "misceo"]),
    (11, ["ira", "indignatio", "elevo", "allido"]),
    (12, ["dies", "umbra", "declino", "foenum", "areo"]),
    (13, ["aeternus", "permaneo", "memorialis", "generatio"]),
    (14, ["exsurgo", "misereor", "sion", "tempus", "venio"]),
    (15, ["lapis", "servus", "terra", "misereor", "placeo"]),
    (16, ["timeo", "nomen", "dominus", "rex", "gloria", "gens", "terra"]),
    (17, ["aedifico", "sion", "gloria", "video"]),
    (18, ["respicio", "oratio", "humilis", "sperno"]),
    (19, ["scribo", "generatio", "alter", "creo", "laudo", "dominus"]),
    (20, ["prospicio", "excelsus", "sanctus", "dominus", "aspicio"]),
    (21, ["gemitus", "compeditus", "interemptus"]),
    (22, ["annuntio", "nomen", "dominus", "sion", "laudo", "ierusalem"]),
    (23, ["convenio", "populus", "rex", "servio", "dominus"]),
    (24, ["respondeo", "via", "virtus", "paucitas", "dies"]),
    (25, ["revoco", "dimidium", "dies", "annus"]),
    (26, ["initium", "dominus", "terra", "opera", "manus"]),
    (27, ["pereo", "vestimentum", "veterasco"]),
    (28, ["opertorium", "muto", "idem", "ipse", "annus", "deficio"]),
    (29, ["filius", "servus", "semen", "saeculum", "dirigo"])
]

    // --------------------------------------------------------------------
    // Structural themes – pairs of verses (1‑2, 3‑4, …)
    // --------------------------------------------------------------------
    private let structuralThemes = [
        (
            "Prayer → Mercy",
            "The psalmist cries out and God’s merciful response",
            ["exaudio", "oratio", "dominus", "misereor"],
            1,
            2,
            "The psalmist implores the Lord, who hears and promises mercy, establishing the central lament‑hope pattern.",
            "Augustine reads this as the soul’s plea to a just God who answers with compassion (Enarr. Ps. 101.1‑2)."
        ),
        (
            "Suffering → Decay",
            "Physical and spiritual decline contrasted with divine constancy",
            ["percutio", "foenum", "areo", "cor", "obliviscor", "panis"],
            5,
            6,
            "The psalmist describes personal ruin—grass‑like, withered heart—mirroring the psalm’s dark imagery.",
            "Augustine interprets the withering as a warning of the consequences of sin (Enarr. Ps. 101.5‑6)."
        ),
        (
            "Divine Judgment",
            "God’s judgment against the wicked and promise of restoration",
            ["exprobro", "inimicus", "laudo", "adversus", "interemptus"],
            9,
            10,
            "Enemies mock while the psalmist notes the fate of the wicked, yet God’s justice looms.",
            "Augustine sees the mockery as a foil to divine justice, emphasizing the need for repentance (Enarr. Ps. 101.9‑10)."
        ),
        (
            "Divine Sovereignty",
            "God’s eternal reign versus human frailty",
            ["aeternum", "permaneo", "memorialis", "generatio"],
            13,
            14,
            "The Lord’s everlasting nature stands opposite to human transience.",
            "Augustine stresses the contrast between divine eternity and human mortality (Enarr. Ps. 101.13‑14)."
        ),
        (
            "Hope & Restoration",
            "Future hope for the faithful and the people of Sion",
            ["sion", "exsurgo", "misereor", "sion"],
            13,
            15,
            "God’s compassion for Sion offers a future restoration for the faithful.",
            "Augustine interprets the promise to Sion as a typology of the Church’s ultimate restoration (Enarr. Ps. 101.13‑15)."
        ),
        (
            "Final Victory",
            "God’s ultimate triumph over death and decay",
            ["muto"],
            27,
            28,
            "The psalmist warns that all will change, but God remains unchanged.",
            "Augustine reads the transformation of the world as a call to trust in God’s unchanging nature (Enarr. Ps. 101.27‑28)."
        )
    ]

    // --------------------------------------------------------------------
    // Conceptual themes – overarching ideas
    // --------------------------------------------------------------------
    private let conceptualThemes = [
        (
            "Divine Mercy",
            "God’s compassion and forgiveness",
            ["misereor", "exaudio", "oratio", "misereor"],
            ThemeCategory.worship,
            1 ... 2
        ),
        (
            "Human Frailty",
            "Physical decay and spiritual emptiness",
            ["foenum", "areo", "cor", "obliviscor", "panis"],
            .sin,
            5 ... 6
        ),
        (
            "Divine Judgment",
            "God’s justice against the wicked",
            ["exprobro", "inimicus", "laudo", "adversus", "interemptus"],
            .justice,
            9 ... 10
        ),
        (
            "Eternal Sovereignty",
            "God’s unchanging nature",
            ["aeternum", "permaneo", "memorialis", "generatio"],
            .divine,
            13 ... 14
        ),
        (
            "Hope for Sion",
            "Future restoration of the faithful",
            ["sion", "exsurgo", "misereor", "sion"],
            .virtue,
            13 ... 15
        ),
        (
            "Worldly Transience",
            "Human mortality and decay",
            ["muto"],
            .sin,
            27 ... 28
        )
    ]

    // --------------------------------------------------------------------
    // MARK: - Test Cases
    // --------------------------------------------------------------------
    func testTotalVerses() {
        XCTAssertEqual(text.count, expectedVerseCount,
                       "Psalm 101 should have \(expectedVerseCount) verses")
        XCTAssertEqual(englishText.count, expectedVerseCount,
                       "Psalm 101 English text should have \(expectedVerseCount) verses")
        // Validate orthography
        let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(normalized, text,
                       "Normalized Latin text should match expected classical forms")
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
        // Verify structural theme lemmas exist in lineKeyLemmas
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
        // Verify conceptual theme lemmas exist in lineKeyLemmas (non‑fatal)
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

   
    func testSaveTexts() {
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: text,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm101_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }

    func testSaveThemes() {
        // Generate the complete themes JSON for Psalm 101
        guard let jsonString = utilities.generateCompleteThemesJSONString(
            psalmNumber: id.number,
            conceptualThemes: conceptualThemes,
            structuralThemes: structuralThemes
        ) else {
            XCTFail("Failed to generate complete themes JSON for Psalm 101")
            return
        }

        // Attempt to write the JSON to a file in the test output directory
        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm101_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}