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

    // MARK: - Structural Themes (placeholder – to be filled later)
    private let structuralThemes = [
    (
      "Divine Worship → Prayer Response",
      "The psalmist's call to worship and God's response to prayer",
      ["hymnus", "votum", "exaudio", "oratio", "sanctus", "templum"],
      1,
      6,
      "The psalmist declares that hymns and vows are fitting for God in Zion and Jerusalem, then calls for God to hear his prayer as all flesh comes to Him, and describes the blessed dwelling in God's holy temple.",
      "Augustine sees this as the soul's recognition that true worship requires both external praise and internal prayer, leading to blessed communion with God in His holy dwelling."
    )]
  
    // MARK: - Conceptual Themes (placeholder values)
    private let conceptualThemes: [(String, String, [String], ThemeCategory, ClosedRange<Int>?)] = []

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
