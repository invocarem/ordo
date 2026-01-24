//
// Psalm65Tests.swift
// Auto‑generated test for Psalm 65 – includes texts, lemmas, placeholder themes and full test methods
//
// NOTE: The `lineKeyLemmas`, `structuralThemes`, and `conceptualThemes` arrays contain placeholder values.
// They should be updated after performing a full morphological analysis using the `analyze_latin` tools
// and adding proper Augustine citations for each structural theme.

@testable import LatinService
import XCTest

class Psalm65Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    // Psalm identity
    let id = PsalmIdentity(number: 65, category: nil)
    private let expectedVerseCount = 19

    // MARK: - Latin Text
    private let text: [String] = [
        "Iubilate Deo, omnis terra; psalmum dicite nomini eius, date gloriam laudi eius.",
        "Dicite Deo: Quam terribilia sunt opera tua, Domine! In multitudine virtutis tuae mentientur tibi inimici tui.",
        "Omnis terra adoret te, et psallat tibi; psalmum dicat nomini tuo.",
        "Venite, et videte opera Dei: terribilis in consiliis super filios hominum.",
        "Qui convertit mare in aridam, in flumine pertransibunt pede; ibi laetabimur in ipso.",
        
        "Qui dominatur in virtute sua in aeternum; oculi eius super gentes respiciunt: qui exasperant non exaltentur in semetipsis.",
        "Benedicite, gentes, Deum nostrum, et auditam facite vocem laudis eius:",
        "Qui posuit animam meam ad vitam, et non dedit in commotionem pedes meos.",
        "Quoniam probasti nos, Deus; igne nos examinasti, sicut examinatur argentum.",
        "Induxisti nos in laqueum; posuisti tribulationes in dorso nostro:",
        
        "Imposuisti homines super capita nostra; transivimus per ignem et aquam, et eduxisti nos in refrigerium.",
        "Introibo in domum tuam in holocaustis; reddam tibi vota mea,",
        "Quae distinxerunt labia mea, et locutum est os meum in tribulatione mea.",
        "Holocausta medullata offeram tibi cum incenso arietum; offeram tibi boves cum hircis.",
        "Venite, audite, et narrabo, omnes qui timetis Deum, quanta fecit animae meae.",
        
        "Ad ipsum ore meo clamavi, et exaltavi sub lingua mea.",
        "Iniquitatem si aspexi in corde meo, non exaudiat Dominus.",
        "Propterea exaudivit Deus, et attendit voci deprecationis meae.",
        "Benedictus Deus, qui non amovit orationem meam, et misericordiam suam a me."
    ]

    // MARK: - English Translation
    private let englishText: [String] = [
        "Shout with joy to God, all the earth, sing ye a psalm to his name; give glory to his praise.",
        "Say unto God, How terrible are thy works, O Lord! in the multitude of thy strength thy enemies shall lie to thee.",
        "Let all the earth adore thee, and sing to thee: let it sing a psalm to thy name.",
        "Come and see the works of God; who is terrible in his counsels over the sons of men.",
        "Who turneth the sea into dry land, in the river they shall pass on foot: there shall we rejoice in him.",
        "Who by his power ruleth for ever: his eyes behold the nations; let not them that provoke him be exalted in themselves.",
        "O bless our God, ye Gentiles, and make the voice of his praise to be heard.",
        "Who hath set my soul to live: and hath not suffered my feet to be moved.",
        "For thou, O God, hast proved us: thou hast tried us by fire, as silver is tried.",
        "Thou hast brought us into the net, thou hast laid afflictions on our back:",
        "Thou hast set men over our heads. We have passed through fire and water; and thou hast brought us out into a refreshment.",
        "I will go into thy house with burnt offerings: I will pay thee my vows,",
        "Which my lips have uttered, And my mouth hath spoken, when I was in trouble.",
        "I will offer up to thee holocausts full of marrow, with burnt offerings of rams: I will offer to thee bullocks with goats.",
        "Come and hear, all ye that fear God, and I will tell you what great things he hath done for my soul.",
        "I cried to him with my mouth: and I extolled him with my tongue.",
        "If I have looked at iniquity in my heart, the Lord will not hear me.",
        "Therefore hath God heard me, and hath attended to the voice of my supplication.",
        "Blessed be God, who hath not turned away my prayer, nor his mercy from me."
    ]

    // MARK: - Line‑by‑Line Key Lemmas (placeholder values)
    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["iubilo", "Deus", "terra", "psalmus", "nomen", "gloria", "laus"]),
        (2, ["dico", "Deus", "terribilis", "opus", "Dominus", "virtus", "inimicus"]),
        (3, ["terra", "adoro", "psallo", "psalmus", "nomen"]),
        (4, ["venio", "video", "opus", "Deus", "terribilis", "consilium", "filius", "homo"]),
        (5, ["converto", "mare", "arida", "flumen", "pertranseo", "pes", "laetor"]),
        (6, ["dominor", "virtus", "aeternus", "oculus", "gens", "respicio", "exaspero"]),
        (7, ["benedico", "gens", "Deus", "noster", "vox", "laus"]),
        (8, ["pono", "anima", "vita", "commotio", "pes"]),
        (9, ["probo", "Deus", "ignis", "examino", "argentum"]),
        (10, ["induco", "laqueus", "pono", "tribulatio", "dorsum"]),
        (11, ["impono", "homo", "caput", "transeo", "ignis", "aqua", "refrigerium"]),
        (12, ["introeo", "domus", "holocaustum", "reddo", "votum"]),
        (13, ["distinguo", "labium", "loquor", "os", "tribulatio"]),
        (14, ["holocaustum", "medullatus", "offero", "incendo", "aries", "bos", "hircus"]),
        (15, ["venio", "audio", "narro", "timeo", "Deus", "facio", "anima"]),
        (16, ["ad", "os", "clamo", "exalto", "lingua"]),
        (17, ["iniquitas", "aspicio", "cor", "exaudio", "Dominus"]),
        (18, ["propterea", "exaudio", "Deus", "attendo", "vox", "deprecatio"]),
        (19, ["benedictus", "Deus", "amoveo", "oratio", "misericordia"])
    ]

    private let structuralThemes = [
        (
            "Praise → Divine Majesty",
            "The earth’s call to worship and the declaration of God’s mighty works",
            ["iubilo", "Deus", "terra", "psalmus", "nomen", "gloria", "laus", "dico", "terribilis", "opus"],
            1,
            2,
            "Verses 1‑2 invite all creation to rejoice and proclaim the awe‑inspiring deeds of God.",
            "Augustine sees the universal hymn as the soul’s first response to divine grandeur (Enarr. Ps. 65.1‑2)."
        ),
        (
            "Universal Worship → Adoration",
            "All the earth worships and sings a psalm to God’s name",
            ["terra", "adoro", "psallo", "psalmus", "nomen", "venio", "video", "opus", "terribilis", "consilium"],
            3,
            4,
            "Verses 3‑4 describe the whole earth’s adoration and a call to behold God’s wondrous counsel.",
            "Augustine interprets this as the mind’s recognition of God’s counsel in creation (Enarr. Ps. 65.3‑4)."
        ),
        (
            "Creation’s Transformation → Joy",
            "God turns sea to dry land and the people rejoice",
            ["converto", "mare", "arida", "flumen", "pertranseo", "pes", "laetor", "dominor", "virtus", "aeternus"],
            5,
            6,
            "Verses 5‑6 portray God’s power over nature and the everlasting rule that brings joy.",
            "Augustine links the transformation of the sea to the soul’s conversion (Enarr. Ps. 65.5‑6)."
        ),
        (
            "Universal Praise → Blessing",
            "Gentiles bless God and hear His praise",
            ["benedico", "gens", "Deus", "noster", "vox", "laus", "pono", "anima", "vita", "commotio"],
            7,
            8,
            "Verses 7‑8 call the nations to bless God and acknowledge the life He gives.",
            "Augustine reads the Gentile’s blessing as the universal call to worship (Enarr. Ps. 65.7‑8)."
        ),
        (
            "Divine Testing → Refinement",
            "God tests us by fire like silver",
            ["probo", "Deus", "ignis", "examino", "argentum", "induco", "laqueus", "tribulatio", "dorsum"],
            9,
            10,
            "Verses 9‑10 compare divine testing to the refining of silver.",
            "Augustine explains the fire as the trial that purifies the soul (Enarr. Ps. 65.9‑10)."
        ),
        (
            "Deliverance Through Trials → Refreshment",
            "God sets men over heads, leads through fire and water to refreshment",
            ["impono", "homo", "caput", "transeo", "ignis", "aqua", "refrigerium", "introeo", "domus", "holocaustum"],
            11,
            12,
            "Verses 11‑12 show God’s guidance through trials to a place of worship.",
            "Augustine sees the passage through fire and water as the soul’s journey to the divine house (Enarr. Ps. 65.11‑12)."
        ),
        (
            "Vow & Petition → Commitment",
            "The psalmist offers vows and speaks of trouble",
            ["distinguo", "labium", "loquor", "os", "tribulatio", "holocaustum", "medullatus", "offero", "incendo", "aries"],
            13,
            14,
            "Verses 13‑14 present the psalmist’s vows and sacrificial offerings.",
            "Augustine interprets the vows as the soul’s earnest petition (Enarr. Ps. 65.13‑14)."
        ),
        (
            "Proclamation → Faithful Witness",
            "Call to hear God’s deeds and the psalmist’s testimony",
            ["venio", "audio", "narro", "timeo", "Deus", "facio", "anima", "ad", "os", "clamo"],
            15,
            16,
            "Verses 15‑16 invite listeners to hear God’s mighty works and the psalmist’s testimony.",
            "Augustine reads this as the faithful witness proclaiming God’s deeds (Enarr. Ps. 65.15‑16)."
        ),
        (
            "Confession → Divine Mercy",
            "Confession of sin, God’s hearing, and blessing",
            ["iniquitas", "aspicio", "cor", "exaudio", "Dominus", "propterea", "exaudio", "Deus", "attendo", "vox", "deprecatio", "benedictus", "Deus", "oratio", "misericordia"],
            17,
            19,
            "Verses 17‑19 confess iniquity, note God’s attentive hearing, and end with blessing.",
            "Augustine sees the confession and divine mercy as the soul’s final reconciliation (Enarr. Ps. 65.17‑19)."
        )
    ]

    private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange?)] = [
        (
            "Divine Majesty",
            "God’s awe‑inspiring power and glory displayed throughout the psalm.",
            ["terribilis","opus","Deus","Dominus","virtus","gloria","laus"],
            .divine,
            nil
        ),
        (
            "Universal Worship",
            "All creation joins in praising God, offering psalms and blessings.",
            ["iubilo","terra","psalmus","nomen","laus","benedico","gens","vox"],
            .worship,
            nil
        ),
        (
            "Creation’s Transformation",
            "God transforms sea to dry land and orders fire and water, showing sovereign control.",
            ["converto","mare","arida","flumen","ignis","aqua","refrigerium","argentum"],
            .divine,
            nil
        ),
        (
            "Divine Testing & Refinement",
            "God tests the people by fire and refines them like silver.",
            ["probo","ignis","examino","argentum","laqueus","tribulatio","dorsum"],
            .justice,
            9...10
        ),
        (
            "Deliverance & Refreshment",
            "Through fire and water the people are led to a place of refreshment and worship.",
            ["transeo","ignis","aqua","refrigerium","introeo","domus","holocaustum"],
            .virtue,
            11...12
        ),
        (
            "Vow & Petition",
            "The psalmist offers vows and sacrifices, seeking God’s favor.",
            ["votum","holocaustum","offero","incendo","aries","bos","hircus","medullatus"],
            .worship,
            12...14
        ),
        (
            "Confession & Mercy",
            "Confession of sin and God’s attentive mercy bring blessing.",
            ["iniquitas","aspicio","cor","exaudio","Dominus","Deus","attendo","vox","deprecatio","benedictus","oratio","misericordia"],
            .opposition,
            17...19
        )
    ]
    

    // MARK: - Test Methods

    func testTotalVerses() {
        XCTAssertEqual(text.count, expectedVerseCount,
                       "Psalm 65 should have \(expectedVerseCount) verses")
        XCTAssertEqual(englishText.count, expectedVerseCount,
                       "Psalm 65 English text should have \(expectedVerseCount) verses")
        // Validate orthography of Latin text
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
        // Verify structural theme lemmas are present in lineKeyLemmas
        let structuralLemmas = structuralThemes.flatMap { $0.2 }
        let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

        utilities.testLemmasInSet(
            sourceLemmas: structuralLemmas,
            targetLemmas: lineKeyLemmasFlat,
            sourceName: "structural themes",
            targetName: "lineKeyLemmas",
            verbose: verbose
        )

        // Run the standard structural themes test
        utilities.testStructuralThemes(
            psalmText: text,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testConceptualThemes() {
        // Verify conceptual theme lemmas are present (allowing extra)
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

        // Run the standard conceptual themes test
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
            filename: "output_psalm65_themes.json"
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
            filename: "output_psalm65_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}
