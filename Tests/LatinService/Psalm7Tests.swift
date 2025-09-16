import XCTest

@testable import LatinService

class Psalm7Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    let id = PsalmIdentity(number: 7, category: "")
    private let expectedVerseCount = 18

    // MARK: - Test Data Properties

    private let psalm7 = [
        "Domine Deus meus, in te speravi; salvum me fac ex omnibus persequentibus me, et libera me.",
        "Nequando rapiat ut leo animam meam, dum non est qui redimat, neque qui salvum faciat.",
        "Domine Deus meus, si feci istud, si est iniquitas in manibus meis,",
        "Si reddidi retribuentibus mihi mala, decidam merito ab inimicis meis inanis.",
        "Persequatur inimicus animam meam, et comprehendat, et conculcet in terra vitam meam, et gloriam meam in pulverem deducat.",
        "Exsurge, Domine, in ira tua; exaltare in finibus inimicorum meorum.",
        "Et exsurge, Domine Deus meus, in praecepto quod mandasti; et synagoga populorum circumdabit te.",
        "Et propter hanc in altum regredere; Dominus iudicat populos.",
        "Iudica me, Domine, secundum iustitiam meam, et secundum innocentiam meam super me.",
        "Consumetur nequitia peccatorum, et diriges iustum, scrutans corda et renes, Deus.",
        "Iustum adiutorium meum a Domino, qui salvos facit rectos corde.",
        "Deus iudex iustus, fortis, et patiens; numquid irascitur per singulos dies?",
        "Nisi conversi fueritis, gladium suum vibrabit; arcum suum tetendit, et paravit illum.",
        "Et in eo paravit vasa mortis; sagittas suas ardentibus effecit.",
        "Ecce parturiit iniustitiam, concepit dolorem, et peperit iniquitatem.",
        "Lacum aperuit, et effodit eum, et incidit in foveam quam fecit.",
        "Convertetur dolor eius in caput eius, et in verticem ipsius iniquitas eius descendet.",
        "Confitebor Domino secundum iustitiam eius, et psallam nomini Domini altissimi.",
    ]

    private let englishText = [
        "O Lord my God, in thee have I put my trust: save me from all them that persecute me, and deliver me.",
        "Lest at any time he seize upon my soul like a lion, while there is no one to redeem me, nor to save.",
        "O Lord my God, if I have done this thing, if there be iniquity in my hands:",
        "If I have rendered to them that repaid me evils, let me deservedly fall empty before my enemies.",
        "Let the enemy pursue my soul, and take it, and tread down my life on the earth, and bring down my glory to the dust.",
        "Rise up, O Lord, in thy wrath: and be thou exalted in the borders of my enemies.",
        "And arise, O Lord my God, in the precept which thou hast commanded: and a congregation of people shall surround thee.",
        "And for their sakes return thou on high: the Lord judgeth the people.",
        "Judge me, O Lord, according to my justice, and according to my innocence in me.",
        "The wickedness of sinners shall be consumed, and thou shalt direct the just: O God, who searchest the hearts and reins.",
        "My just help is from the Lord: who saveth the upright of heart.",
        "God is a just judge, strong and patient: is he angry every day?",
        "Except ye be converted, he will brandish his sword: he hath bent his bow, and made it ready.",
        "And in it he hath prepared the instruments of death: he hath made ready his arrows for them that burn.",
        "Behold he hath been in labour with injustice: he hath conceived sorrow, and brought forth iniquity.",
        "He hath opened a pit and dug it: and he is fallen into the hole he made.",
        "His sorrow shall be turned on his own head: and his iniquity shall come down upon his crown.",
        "I will give glory to the Lord according to his justice: and will sing to the name of the Lord the most high.",
    ]

    private let lineKeyLemmas = [
        (1, ["spero", "salvus", "omnis", "persequor", "libero"]),
        (2, ["nequando", "rapio", "leo", "anima", "dum", "redimo", "salvus"]),
        (3, ["facio", "iste", "iniquitas", "manus"]),
        (4, ["reddo", "retribuo", "malus", "decido", "mereor", "inimicus", "inanis"]),
        (
            5,
            [
                "persequor", "inimicus", "anima", "comprehendo", "conculco", "terra", "vita",
                "gloria", "pulvis", "deduco",
            ]
        ),
        (6, ["exsurgo", "ira", "exalto", "finis", "inimicus"]),
        (7, ["exsurgo", "praeceptum", "mando", "synagoga", "populus", "circumdo"]),
        (8, ["propter", "hic", "altus", "regredior", "iudico", "populus"]),
        (9, ["iudico", "secundum", "iustitia", "secundum", "innocentia", "super"]),
        (10, ["consumo", "nequitia", "peccator", "dirigo", "iustus", "scrutor", "ren"]),
        (11, ["iustus", "adiutorium", "salvus", "rectus"]),
        (12, ["iudex", "iustus", "fortis", "patiens", "irascor", "singulus", "dies"]),
        (13, ["nisi", "converto", "gladius", "vibro", "arcus", "tendo", "paro"]),
        (14, ["paro", "vas", "mors", "sagitta", "ardeo", "efficio"]),
        (15, ["ecce", "parturio", "iniustitia", "concipio", "dolor", "pario", "iniquitas"]),
        (16, ["lacus", "aperio", "effodio", "incido", "fovea", "facio"]),
        (17, ["converto", "dolor", "caput", "vertex", "iniquitas", "descendo"]),
        (18, ["confiteor", "secundum", "iustitia", "psallo", "nomen", "altissimus"]),
    ]

    private let structuralThemes = [
        (
            "Threat → Refuge",
            "From violent pursuit to trusting in divine protection",
            ["leo", "rapio", "spero", "libero"],
            1,
            2,
            "The psalmist likens persecutors to a lion ready to seize its prey. In response, he entrusts himself to God as the only liberator.",
            "Augustine interprets the lion as the devil or violent adversaries. Safety lies only in the Lord, who receives those fleeing in faith (Enarr. Ps. 7.1–2)."
        ),
        (
            "Integrity → Collapse",
            "If unjust, the psalmist accepts shameful defeat",
            ["reddo", "retribuo", "decido", "inanis"],
            3,
            4,
            "The psalmist offers himself to God's judgment: if guilty of betrayal, let him fall empty-handed into enemy hands.",
            "For Augustine, this is not pride but holy fear: a willingness to be judged shows the integrity of the just. To fall 'inanis' is to lose all fruit of life apart from God (Enarr. Ps. 7.3–4)."
        ),
        (
            "Capture → Dust",
            "From pursuit to utter humiliation",
            ["persequor", "comprehendo", "conculco", "pulvis"],
            5,
            6,
            "If guilty, let the enemy overtake and trample him, reducing his glory to dust.",
            "Augustine sees dust as the destiny of the proud soul abandoned to itself: the fall of human glory without God's defense (Enarr. Ps. 7.5–6)."
        ),
        (
            "Judgment → Ascent",
            "From divine summons to enthronement above all peoples",
            ["exsurgo", "mandatum", "synagoga", "iudico"],
            7,
            8,
            "The Lord rises to judge among assembled nations, taking His seat on high.",
            "Augustine reads this as Christ exalted after the resurrection, gathering peoples into His Church and judging with justice (Enarr. Ps. 7.7–8)."
        ),
        (
            "Innocence → Discernment",
            "From appeal to justice to God's searching judgment",
            ["iustitia", "innocentia", "scrutor", "renes"],
            9,
            10,
            "The psalmist asks to be judged by his innocence, yet acknowledges God searches even the heart and reins.",
            "For Augustine, this penetrates deeper than outward acts: God weighs interior motives, revealing true justice (Enarr. Ps. 7.9–10)."
        ),
        (
            "Righteousness → Warning",
            "From God's help for the upright to warning the impenitent",
            ["iustus", "adiutorium", "patiens", "converto"],
            11,
            12,
            "God is patient and aids the upright, but warns that His forbearance has limits.",
            "Augustine urges conversion while time remains: God's patience is meant to lead sinners back, not excuse them forever (Enarr. Ps. 7.11–12)."
        ),
        (
            "Preparation → Execution",
            "From preparation of weapons to fiery judgment",
            ["paro", "vibro", "sagitta", "ardens"],
            13,
            14,
            "God bends the bow and readies burning arrows, images of judgment.",
            "Augustine interprets these arrows spiritually: divine words pierce sinners, igniting repentance rather than mere destruction (Enarr. Ps. 7.13–14)."
        ),
        (
            "Conception → Iniquity",
            "From conceiving sin to its birth in injustice",
            ["parturio", "concipio", "iniquitas", "dolor"],
            15,
            16,
            "The wicked conceive trouble and give birth to iniquity, only to fall into their own pit.",
            "Augustine sees in this the paradox of the cross: by plotting Christ's death, the devil trapped himself in the pit he dug (Enarr. Ps. 7.15–16)."
        ),
        (
            "Retribution → Praise",
            "From downfall of the wicked to exaltation of divine justice",
            ["convertor", "iniquitas", "confiteor", "psallo"],
            17,
            18,
            "The sinner's violence recoils upon his own head, while the psalmist gives thanks in song.",
            "Augustine highlights the contrast: the wicked are ensnared in their own works, but the just respond with praise of God's unchanging righteousness (Enarr. Ps. 7.17–18)."
        ),
    ]

    private let conceptualThemes = [
        (
            "Divine Protection",
            "Appeal to God for salvation and deliverance",
            ["spero", "salvus", "libero", "redimo", "adiutorium"],
            ThemeCategory.divine,
            nil as ClosedRange<Int>?
        ),
        (
            "Divine Authority",
            "God's sovereignty, majesty, and commands",
            ["altissimus", "praeceptum", "mando", "regredior"],
            .divine,
            nil as ClosedRange<Int>?
        ),
        (
            "Judicial Process",
            "Legal and judicial aspects of God's judgment",
            ["iudico", "iustitia", "iudex", "scrutor", "mereor", "retribuo", "decido"],
            .justice,
            nil as ClosedRange<Int>?
        ),
        (
            "Human Innocence",
            "Declaration of righteousness before God",
            ["innocentia", "iustus", "rectus", "super"],
            .virtue,
            nil as ClosedRange<Int>?
        ),
        (
            "Divine Wrath",
            "God's violent judgment against enemies",
            ["ira", "gladius", "arcus", "sagitta", "mors", "conculco", "vibro", "ardeo"],
            .justice,
            nil as ClosedRange<Int>?
        ),
        (
            "Sin's Consequences",
            "Natural results of wrongdoing",
            [
                "iniquitas", "peccator", "nequitia", "dolor", "descendo", "parturio",
                "concipio", "pario",
            ],
            .sin,
            nil as ClosedRange<Int>?
        ),
        (
            "Enemy Opposition",
            "Adversaries and persecutors",
            ["inimicus", "persequor", "malus", "comprehendo", "rapio"],
            .opposition,
            nil as ClosedRange<Int>?
        ),
        (
            "Worship Response",
            "Human praise and acknowledgment",
            ["confiteor", "psallo", "nomen", "exalto"],
            .worship,
            nil as ClosedRange<Int>?
        ),
    ]

    func testTotalVerses() {
        XCTAssertEqual(
            psalm7.count, expectedVerseCount, "Psalm 7 should have \(expectedVerseCount) verses")
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 7 English text should have \(expectedVerseCount) verses")
        // Also validate the orthography of the text for analysis consistency
        let normalized = psalm7.map { PsalmTestUtilities.validateLatinText($0) }
        XCTAssertEqual(
            normalized,
            psalm7,
            "Normalized Latin text should match expected classical forms"
        )
    }

    func testLineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm7,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testStructuralThemes() {
        utilities.testStructuralThemes(
            psalmText: psalm7,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        utilities.testConceptualThemes(
            psalmText: psalm7,
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
            filename: "output_psalm7_themes.json"
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
            text: psalm7,
            englishText: englishText
        )

        let success = utilities.saveToFile(
            content: jsonString,
            filename: "output_psalm7_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}
