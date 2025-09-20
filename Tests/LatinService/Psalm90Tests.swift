@testable import LatinService
import XCTest

class Psalm90Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 90, category: "")

    // MARK: - Test Data Properties

    private let psalm90 = [
        "Qui habitat in adiutorio Altissimi, in protectione Dei caeli commorabitur.",
        "Dicet Domino: Susceptor meus es tu, et refugium meum; Deus meus, sperabo in eum.",
        "Quoniam ipse liberavit me de laqueo venantium, et a verbo aspero.",
        "Scapulis suis obumbrabit tibi, et sub pennis eius sperabis.",
        "Scuto circumdabit te veritas eius; non timebis a timore nocturno,",
        "A sagitta volante per diem, a negotio perambulante in tenebris, ab incursu et daemonio meridiano.",
        "Cadent a latere tuo mille, et decem milia a dextris tuis; ad te autem non appropinquabit.",
        "Verumtamen oculis tuis considerabis, et retributionem peccatorum videbis.",
        "Quoniam tu es, Domine, spes mea; Altissimum posuisti refugium tuum.",
        "Non accedet ad te malum, et flagellum non appropinquabit tabernaculo tuo.",
        "Quoniam angelis suis mandavit de te, ut custodiant te in omnibus viis tuis.",
        "In manibus portabunt te, ne forte offendas ad lapidem pedem tuum.",
        "Super aspidem et basiliscum ambulabis, et conculcabis leonem et draconem.",
        "Quoniam in me speravit, liberabo eum; protegam eum quoniam cognovit nomen meum.",
        "Clamabit ad me, et ego exaudiam eum; cum ipso sum in tribulatione, eripiam eum et glorificabo eum.",
        "Longitudine dierum replebo eum, et ostendam illi salutare meum.",
    ]

    private let englishText = [
        "He that dwelleth in the aid of the most High, shall abide under the protection of the God of Jacob.",
        "He shall say to the Lord: Thou art my protector, and my refuge: my God, in him will I trust.",
        "For he hath delivered me from the snare of the hunters: and from the sharp word.",
        "He will overshadow thee with his shoulders: and under his wings thou shalt trust.",
        "His truth shall compass thee with a shield: thou shalt not be afraid of the terror of the night.",
        "Of the arrow that flieth in the day, of the business that walketh about in the dark: of invasion, or of the noonday devil.",
        "A thousand shall fall at thy side, and ten thousand at thy right hand: but it shall not come nigh thee.",
        "But thou shalt consider with thy eyes: and shalt see the reward of the wicked.",
        "Because thou, O Lord, art my hope: thou hast made the most High thy refuge.",
        "There shall no evil come to thee: nor shall the scourge come near thy dwelling.",
        "For he hath given his angels charge over thee; to keep thee in all thy ways.",
        "In their hands they shall bear thee up: lest thou dash thy foot against a stone.",
        "Thou shalt walk upon the asp and the basilisk: and thou shalt trample under foot the lion and the dragon.",
        "Because he hoped in me I will deliver him: I will protect him because he hath known my name.",
        "He shall cry to me, and I will hear him: I am with him in tribulation, I will deliver him, and I will glorify him.",
        "I will fill him with length of days; and I will shew him my salvation.",
    ]

    private let lineKeyLemmas = [
        (1, ["habito", "adiutorium", "altissimus", "protectio", "deus", "caelum", "commoror"]),
        (2, ["dico", "dominus", "susceptor", "refugium", "deus", "spero"]),
        (3, ["quoniam", "ipse", "libero", "laqueus", "venor", "verbum", "asper"]),
        (4, ["scapula", "obumbro", "penna", "spero"]),
        (5, ["scutum", "circumdo", "veritas", "timeo", "timor", "nocturnus"]),
        (6, ["sagitta", "volo", "dies", "negotium", "perambulo", "tenebrae", "incursus", "daemonium", "meridianus"]),
        (7, ["cado", "latus", "mille", "decem",  "dexter", "appropinquo"]),
        (8, ["verumtamen", "oculus", "considero", "retributio", "peccatum", "video"]),
        (9, ["quoniam", "dominus", "spes", "altissimus", "pono", "refugium"]),
        (10, ["accedo", "malum", "flagellum", "appropinquo", "tabernaculum"]),
        (11, ["quoniam", "angelus", "mando", "custodio", "omnis", "via"]),
        (12, ["manus", "porto", "offendo", "lapis", "pes"]),
        (13, ["aspis", "basiliscus", "ambulo", "conculco", "leo", "draco"]),
        (14, ["quoniam", "spero", "libero", "protego", "cognosco", "nomen"]),
        (15, ["clamo", "exaudio", "cum", "ipse", "sum", "tribulatio", "eripio", "glorifico"]),
        (16, ["longitudo", "dies", "repleo", "ostendo", "salutare"]),
    ]

    private let structuralThemes = [
        (
            "Dwelling → Protection",
            "Abiding in God's help and finding shelter in the divine presence",
            ["habito", "adiutorium", "altissimus", "protectio", "commoror"],
            1,
            2,
            "Whoever dwells in the help of the Most High abides under God's heavenly protection, declaring the Lord as their refuge and place of hope.",
            "Augustine sees this as the soul making its home in God's grace, finding eternal security in divine protection rather than earthly shelters."
        ),
        (
            "Deliverance → Covering",
            "Rescue from hidden traps and shelter under God's protective wings",
            ["libero", "laqueus", "venor", "obumbro", "penna"],
            3,
            4,
            "God delivers from the hunter's snare and harsh word, covering with His shoulders and providing shelter under His wings where we find hope.",
            "For Augustine, the hunter's snare represents hidden temptations, while God's wings signify the protective presence of the Holy Spirit."
        ),
        (
            "Shield → Fearlessness",
            "Divine truth as protection against nocturnal fears and daily dangers",
            ["scutum", "veritas", "timeo", "timor", "nocturnus", "sagitta"],
            5,
            6,
            "God's truth surrounds like a shield, providing fearlessness against night terror, flying arrows, and dangers that walk in darkness.",
            "Augustine interprets God's truth as the ultimate protection against both physical dangers and spiritual attacks that come in darkness."
        ),
        (
            "Preservation → Observation",
            "Divine preservation amidst widespread falling and observation of justice",
            ["cado", "mille", "appropinquo", "considero", "retributio", "peccatum"],
            7,
            8,
            "Though thousands fall at your side, evil shall not approach you, and your eyes will behold the just reward of sinners.",
            "Augustine sees this as God's particular preservation of the righteous amidst general destruction, granting them understanding of divine justice."
        ),
        (
            "Refuge → Immunity",
            "God as ultimate refuge providing immunity from evil and plague",
            ["spes", "refugium", "accedo", "malum", "flagellum", "tabernaculum"],
            9,
            10,
            "Making the Most High your refuge ensures no evil shall befall you nor plague approach your dwelling, for the Lord is your hope.",
            "Augustine interprets this as the spiritual immunity granted to those who truly make God their dwelling place and source of hope."
        ),
        (
            "Guardianship → Guidance",
            "Angelic protection in all ways and prevention from stumbling",
            ["angelus", "mando", "custodio", "manus", "porto", "offendo"],
            11,
            12,
            "God commands His angels to guard you in all your ways, bearing you in their hands lest you strike your foot against a stone.",
            "Augustine sees the angelic guardianship as God's providential care through spiritual beings, ensuring safe passage through life's journey."
        ),
        (
            "Dominion → Protection",
            "Authority over dangerous creatures through divine empowerment",
            ["aspis", "basiliscus", "conculco", "leo", "draco", "protego"],
            13,
            14,
            "You will tread upon venomous serpents and crush the lion and dragon underfoot, for God protects those who know His name.",
            "Augustine interprets the dangerous creatures as symbols of demonic powers conquered through Christ's authority given to the faithful."
        ),
        (
            "Response → Glorification",
            "Divine answer in trouble leading to deliverance and ultimate glorification",
            ["clamo", "exaudio", "eripio", "glorifico", "longitudo", "salutare"],
            15,
            16,
            "When they call, God answers; He is with them in trouble, delivering and glorifying them, filling them with long life and showing His salvation.",
            "Augustine sees this as God's faithful response to prayer, resulting not only in temporal deliverance but eternal glorification and revelation of Christ, our salvation."
        ),
    ]

    private let conceptualThemes = [
        (
            "Divine Refuge",
            "God as shelter and safe haven",
            ["refugium", "adiutorium", "susceptor", "commoror", "tabernaculum"],
            ThemeCategory.divine,
            1...10
        ),
        (
            "Hope and Trust",
            "Confidence and expectation in God",
            ["spero", "spes", "considero"],
            ThemeCategory.virtue,
            1...9
        ),
        (
            "Spiritual Warfare",
            "Threats, traps, and spiritual enemies",
            ["laqueus", "daemonium", "malum", "incursus", "aspis", "basiliscus", "leo", "draco"],
            ThemeCategory.conflict,
            3...14
        ),
        (
            "Divine Protection",
            "God's covering and defense",
            ["scutum", "obumbro", "circumdo", "protego", "custodio", "porto"],
            ThemeCategory.divine,
            1...14
        ),
        (
            "Deliverance and Salvation",
            "Rescue and salvation from danger",
            ["libero", "eripio", "salutare", "timeo", "appropinquo"],
            ThemeCategory.divine,
            3...16
        ),
        (
            "Divine Response",
            "God's answering and presence",
            ["exaudio", "clamo", "ostendo", "glorifico", "video"],
            ThemeCategory.divine,
            8...16
        ),
    ]

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    // MARK: - Test Methods

    func testTotalVerses() {
        let expectedVerseCount = 16
        XCTAssertEqual(
            psalm90.count, expectedVerseCount, "Psalm 90 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 90 English text should have \(expectedVerseCount) verses"
        )
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm90.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm90,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testLineByLineKeyLemmas() {
        let utilities = PsalmTestUtilities.self
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm90,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testStructuralThemes() {
        let utilities = PsalmTestUtilities.self
        utilities.testStructuralThemes(
            psalmText: psalm90,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        let utilities = PsalmTestUtilities.self
        utilities.testConceptualThemes(
            psalmText: psalm90,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testSaveTexts() {
        let utilities = PsalmTestUtilities.self
        let jsonString = utilities.generatePsalmTextsJSONString(
            psalmNumber: id.number,
            category: id.category ?? "",
            text: psalm90,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm90_texts.json"
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
            filename: "output_psalm90_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
