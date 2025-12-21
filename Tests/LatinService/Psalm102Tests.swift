@testable import LatinService
import XCTest

class Psalm102Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    let verbose = true

    let id = PsalmIdentity(number: 102, category: nil)
    private let expectedVerseCount = 22
    // MARK: - Test Data
    let text = [
        /* 1 */ "Benedic, anima mea, Domino, et omnia quae intra me sunt nomini sancto eius.",
        /* 2 */ "Benedic, anima mea, Domino, et noli oblivisci omnes retributiones eius.",
        /* 3 */ "Qui propitiatur omnibus iniquitatibus tuis, qui sanat omnes infirmitates tuas.",
        /* 4 */
        "Qui redimit de interitu vitam tuam, qui coronat te in misericordia et miserationibus.",
        /* 5 */ "Qui replet in bonis desiderium tuum; renovabitur ut aquilae iuventus tua.",
        /* 6 */ "Faciens misericordias Dominus, et iudicium omnibus iniuriam patientibus.",
        /* 7 */ "Notas fecit vias suas Moysi, filiis Israel voluntates suas.",
        /* 8 */ "Miserator et misericors Dominus, longanimis et multum misericors.",
        /* 9 */ "Non in perpetuum irascetur, neque in aeternum comminabitur.",
        /* 10 */
        "Non secundum peccata nostra fecit nobis, neque secundum iniquitates nostras retribuit nobis.",
        /* 11 */
        "Quoniam secundum altitudinem caeli a terra, corroboravit misericordiam suam super timentes se.",
        /* 12 */ "Quantum distat ortus ab occidente, longe fecit a nobis iniquitates nostras.",
        /* 13 */
        "Quomodo miseretur pater filiorum, misertus est Dominus timentibus se. Quoniam ipse cognovit figmentum nostrum; ",
        /* 14 */
        "recordatus est quia pulvis sumus. Homo, sicut foenum dies eius, tamquam flos agri sic efflorebit.",
        /* 15 */
        "Quoniam spiritus pertransibit in illo, et non subsistet, et non cognoscet amplius locum suum.",
        /* 16 */ "Misericordia autem Domini ab aeterno, et usque in aeternum super timentes eum.",
        /* 17 */ "Et iustitia illius in filios filiorum, his qui servant testamentum eius,",
        /* 18 */ "et memores sunt mandatorum ipsius ad faciendum ea.",
        /* 19 */ "Dominus in caelo paravit sedem suam, et regnum ipsius omnibus dominabitur.",
        /* 20 */
        "Benedicite Domino, omnes angeli eius, potentes virtute, facientes verbum illius, ad audiendam vocem sermonum eius.",
        /* 21 */
        "Benedicite Domino, omnes virtutes eius, ministri eius, qui facitis voluntatem eius.",
        /* 22 */
        "Benedicite Domino, omnia opera eius, in omni loco dominationis eius. Benedic, anima mea, Domino.",
    ]

    private let englishText = [
        "Bless the Lord, O my soul, and all that is within me, bless his holy name.",
        "Bless the Lord, O my soul, and forget not all his benefits.",
        "Who forgiveth all thine iniquities; who healeth all thy diseases.",
        "Who redeemeth thy life from destruction; who crowneth thee with lovingkindness and tender mercies.",
        "Who satisfieth thy mouth with good things; so that thy youth is renewed like the eagle's.",
        "The Lord executeth righteousness and judgment for all that are oppressed.",
        "He made known his ways unto Moses, his acts unto the children of Israel.",
        "The Lord is merciful and gracious, slow to anger, and plenteous in mercy.",
        "He will not always chide: neither will he keep his anger for ever.",
        "He hath not dealt with us after our sins; nor rewarded us according to our iniquities.",
        "For as the heaven is high above the earth, so great is his mercy toward them that fear him.",
        "As far as the east is from the west, so far hath he removed our transgressions from us.",
        "Like as a father pitieth his children, so the Lord pitieth them that fear him.",
        "For he knoweth our frame; he remembereth that we are dust.",
        "As for man, his days are as grass: as a flower of the field, so he flourisheth.",
        "For the wind passeth over it, and it is gone; and the place thereof shall know it no more.",
        "But the mercy of the Lord is from everlasting to everlasting upon them that fear him, and his righteousness unto children's children;",
        "To such as keep his covenant, and to those that remember his commandments to do them.",
        "The Lord hath prepared his throne in the heavens; and his kingdom ruleth over all.",
        "Bless the Lord, ye his angels, that excel in strength, that do his commandments, hearkening unto the voice of his word.",
        "Bless ye the Lord, all ye his hosts; ye ministers of his, that do his pleasure.",
        "Bless the Lord, all his works in all places of his dominion: bless the Lord, O my soul.",
    ]

    private let lineKeyLemmas: [(Int, [String])] = [
        (1, ["benedico", "anima", "dominus", "omnis", "intra", "nomen", "sanctus"]),
        (2, ["benedico", "anima", "dominus", "obliviscor", "retributio"]),
        (3, ["propitior", "iniquitas", "sano", "infirmitas"]),
        (4, ["redimo", "interitus", "vita", "corono", "misericordia", "miseratio"]),
        (5, ["repleo", "bonus", "desiderium", "renovo", "aquila", "iuventus"]),
        (6, ["facio", "misericordia", "dominus", "iudicium", "iniuria", "patior"]),
        (7, ["notus", "facio", "via", "moyses", "filius", "israel", "voluntas"]),
        (8, ["miserator", "misericors", "dominus", "longanimis", "multus"]),
        (9, ["perpetuus", "irascor", "aeternus", "comminor"]),
        (10, ["secundum", "peccatum", "facio", "iniquitas", "retribuo"]),
        (11, ["altitudo", "caelum", "terra", "corroboro", "misericordia", "timeo"]),
        (12, ["quantus", "disto", "ortus", "occidens", "longe", "facio", "iniquitas"]),
        (13, ["misereor", "pater", "filius", "dominus", "timeo", "figmentum"]),
        (
            14,
            [
                "recordor", "pulvis", "sum", "homo", "sicut", "foenum", "dies", "is", "tamquam",
                "flos", "ager", "effloreo",
            ]
        ),
        (15, ["spiritus", "pertransio", "subsisto", "cognosco", "locus"]),
        (16, ["misericordia", "dominus", "aeternus", "timeo"]),
        (17, ["iustitia", "filius", "servo", "testamentum"]),
        (18, ["memor", "mandatum", "facio"]),
        (19, ["dominus", "caelum", "paro", "sedes", "regnum", "dominor"]),
        (
            20,
            [
                "benedico", "dominus", "angelus", "potens", "virtus", "facio", "verbum", "audio",
                "vox", "sermo",
            ]
        ),
        (21, ["benedico", "dominus", "virtus", "minister", "facio", "voluntas"]),
        (
            22,
            ["benedico", "dominus", "opus", "locus", "dominatio", "benedico", "anima", "dominus"]
        ),
    ]

   // MARK: - Structural Themes
// Each theme now covers exactly two consecutive verses (1‑2, 3‑4, …, 21‑22)
private let structuralThemes = [
    (
        "Invocation → Reminder",
        "The psalmist begins by calling the soul to bless God and then reminds it not to forget God's benefits",
        ["benedico", "anima", "dominus", "obliviscor", "retributio"],
        1,
        2,
        "The psalm opens with a double invocation to the soul to bless the Lord, establishing a pattern of praise that frames the entire psalm. The second line adds the crucial warning not to forget God's retributions (benefits), setting up the thematic contrast between human forgetfulness and divine faithfulness.",
        "Augustine notes that 'the soul must be reminded to bless God, for it is prone to forgetfulness' (Enarr. Ps. 102.1)."
    ),
    (
        "Forgiveness → Healing",
        "Divine pardon of sin followed by restoration of physical health",
        ["propitior", "iniquitas", "sano", "infirmitas"],
        3,
        4,
        "A sequence of divine actions: God forgives sins and heals diseases, then redeems life and crowns with mercy. The progression moves from spiritual restoration to physical renewal.",
        "Augustine sees this as God's remedy for the human condition: 'He forgives the soul's wounds and heals the body's infirmities, redeeming from death's grasp and crowning with mercy' (Enarr. Ps. 102.3‑4)."
    ),
    (
        "Satisfaction → Renewal",
        "Divine provision satisfies desire and renews youth like an eagle",
        ["repleo", "bonus", "desiderium", "renovo", "aquila", "iuventus"],
        5,
        6,
        "The promise of fulfilled desire is followed by the Lord’s execution of righteousness for the oppressed, showing how mercy leads to renewal.",
        "Augustine interprets the eagle’s renewal as a symbol of spiritual rebirth (Enarr. Ps. 102.5)."
    ),
    (
        "Revelation → Character",
        "God’s ways revealed to Moses and Israel, then His merciful character",
        ["notus", "facio", "via", "moyses", "filius", "israel", "voluntas",
         "miserator", "misericors", "longanimis", "multus"],
        7,
        8,
        "Historical revelation (to Moses and Israel) is followed by the eternal character of God—merciful, gracious, slow to anger.",
        "Augustine observes that 'God made His ways known to Moses, but His character is revealed to all who seek Him' (Enarr. Ps. 102.7‑8)."
    ),
    (
        "Restraint → Mercy I",
        "God’s restraint in anger and His non‑retribution",
        ["perpetuus", "irascor", "aeternus", "comminor", "secundum", "peccatum", "retribuo"],
        9,
        10,
        "What God does not do (hold perpetual anger, repay according to sin) highlights divine restraint.",
        "Augustine marvels at the contrast: 'God's anger is not like human anger; He does not repay as we do' (Enarr. Ps. 102.9‑10)."
    ),
    (
        "Cosmic Mercy",
        "Heaven‑earth comparison and removal of iniquities",
        ["altitudo", "caelum", "terra", "corroboro", "misericordia", "timeo",
         "quantus", "disto", "ortus", "occidens", "longe", "iniquitas"],
        11,
        12,
        "The cosmic scale of God’s mercy is illustrated by the height of heaven versus earth and the distance of east from west, showing how far He removes our sins.",
        "Augustine says the distance ‘cannot be measured’ (Enarr. Ps. 102.11‑12)."
    ),
    (
        "Fatherly Compassion → Human Frailty",
        "Divine paternal care contrasted with human mortality",
        ["misereor", "pater", "filius", "dominus", "timeo",
         "pulvis", "sum", "homo", "sicut", "foenum", "dies", "flos", "ager", "effloreo"],
        13,
        14,
        "Divine compassion is set against the fleeting nature of humanity (dust, grass, flower).",
        "Augustine writes: 'God remembers our frame because He made it; He knows we are dust, yet He pities us as a father pities his children' (Enarr. Ps. 102.13‑14)."
    ),
    (
        "Transience → Eternal Mercy",
        "Human impermanence versus everlasting divine mercy",
        ["spiritus", "pertransio", "subsisto", "cognosco", "locus",
         "misericordia", "dominus", "aeternus", "timeo"],
        15,
        16,
        "The wind passing over the grass is juxtaposed with the Lord’s mercy that endures forever, contrasting transience with eternity.",
        "Augustine contrasts the fleeting wind with the eternal mercy of the Lord (Enarr. Ps. 102.15‑16)."
    ),
    (
        "Righteousness → Covenant",
        "Divine justice extending to future generations and covenant obedience",
        ["iustitia", "filius", "servo", "testamentum", "memor", "mandatum", "facio"],
        17,
        18,
        "God’s righteousness reaches children’s children, and those who keep the covenant are remembered.",
        "Augustine notes that ‘His righteousness is a legacy for the faithful’ (Enarr. Ps. 102.17‑18)."
    ),
    (
        "Divine Sovereignty → Universal Praise I",
        "God’s heavenly throne and the call for angelic praise",
        ["dominus", "caelum", "paro", "sedes", "regnum", "dominor",
         "benedico", "angelus", "potens", "virtus", "facio", "verbum", "audio", "vox", "sermo"],
        19,
        20,
        "The prepared throne in heaven leads to angels who excel in strength and proclaim His word.",
        "Augustine sees this as the beginning of universal worship (Enarr. Ps. 102.19‑20)."
    ),
    (
        "Divine Sovereignty → Universal Praise II",
        "All creation joins the final blessing, ending as it began",
        ["benedico", "dominus", "virtus", "minister", "voluntas",
         "opus", "locus", "dominatio", "anima"],
        21,
        22,
        "Every host and work is called to bless the Lord, concluding with the personal benediction of the psalmist’s soul, mirroring the opening.",
        "Augustine concludes: 'The Lord who prepared His throne now calls every creature to bless Him, from the highest angel to the humblest soul' (Enarr. Ps. 102.21‑22)."
    ),
] 

    // MARK: - Conceptual Themes
    
private let conceptualThemes = [
    (
        "Divine Mercy",
        "God's compassionate nature toward sinners and the afflicted",
        ["misericordia", "miseratio", "propitior", "redimo", "sano", "corono", "renovo"],
        ThemeCategory.divine,
        3 ... 5
    ),
    (
        "Human Frailty",
        "The transient, mortal nature of human beings",
        ["pulvis", "sum", "homo", "foenum", "dies", "flos", "ager", "effloreo", "spiritus", "pertransio", "subsisto", "cognosco", "locus", "figmentum"],
        ThemeCategory.sin,
        13 ... 15
    ),
    (
        "Divine Justice",
        "God's righteous judgment and fair treatment of the oppressed",
        ["iudicium", "iniuria", "patior", "retribuo", "peccatum", "iniquitas", "comminor", "irascor"],
        ThemeCategory.justice,
        6 ... 10
    ),
    (
        "Eternal Covenant",
        "God's everlasting promises and faithfulness to those who keep His commandments",
        ["aeternus", "testamentum", "servo", "mandatum", "memor", "iustitia", "filius"],
        ThemeCategory.divine,
        16 ... 18
    ),
    (
        "Cosmic Sovereignty",
        "God's supreme rule over all creation from heaven to earth",
        ["dominus", "caelum", "paro", "sedes", "regnum", "dominor", "potens", "virtus", "verbum", "vox", "sermo", "voluntas", "opus", "dominatio"],
        ThemeCategory.divine,
        19 ... 22
    ),
    (
        "Divine Knowledge",
        "God's intimate awareness and remembrance of human nature",
        ["cognosco", "recordor", "figmentum", "pulvis", "sum"],
        ThemeCategory.divine,
        13 ... 14
    ),
    (
        "Praise and Worship",
        "The call to bless and honor God from all creation",
        ["benedico", "anima", "dominus", "nomen", "sanctus"],
        ThemeCategory.worship,
        1 ... 2
    ),
    (
        "Divine Revelation",
        "God making His ways and will known to humanity",
        ["notus", "facio", "via", "moyses", "filius", "israel", "voluntas"],
        ThemeCategory.divine,
        7 ... 8
    ),
    (
        "Divine Restraint",
        "God's deliberate withholding of anger and punishment",
        ["perpetuus", "irascor", "aeternus", "comminor", "secundum", "peccatum", "iniquitas"],
        ThemeCategory.divine,
        9 ... 10
    ),
    (
        "Divine Distance from Sin",
        "God's removal of sin as far as the east is from the west",
        ["quantus", "disto", "ortus", "occidens", "longe", "facio", "iniquitas"],
        ThemeCategory.divine,
        11 ... 12
    ),
    (
        "Fatherly Compassion",
        "God's paternal care for those who fear Him",
        ["misereor", "pater", "filius", "dominus", "timeo"],
        ThemeCategory.divine,
        13 ... 13
    )
    ]
    // MARK: - Test Cases

    func testTotalVerses() {
        XCTAssertEqual(
            text.count, expectedVerseCount, "Psalm 102 should have \(expectedVerseCount) verses"
        )
        XCTAssertEqual(
            englishText.count, expectedVerseCount,
            "Psalm 102 English text should have \(expectedVerseCount) verses"
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
        utilities.testLineByLineKeyLemmas(
            psalmText: text,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    // 1. Divine Mercy Terminology (Rare Forms)
    func testDivineMercyTerms() {
        let mercyTerms = [
            ("propitior", ["propitiatur"], "appease"),  // Psalm 102:3 (Deponent)
            ("longanimis", ["longanimis"], "long-suffering"),  // Psalm 102:8 (Hapax in Psalms)
            ("corono", ["coronat"], "crown"),  // Psalm 102:4 (Specific divine action)
            ("miserator", ["miserator"], "compassionate"),  // Psalm 102:8 (Rare synonym)
            ("comminor", ["comminabitur"], "threaten"),  // Psalm 102:9
        ]

        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: mercyTerms,
            verbose: verbose
        )
    }

    // 2. Human Frailty Metaphors
    func testFrailtyMetaphors() {
        let frailtyTerms = [
            ("figmentum", ["figmentum"], "image"),  // Psalm 102:14 (Creation metaphor)
            ("effloreo", ["efflorebit"], "fade"),  // Psalm 102:15 (Unique floral verb)
            ("pertransio", ["pertransibit"], "pass through"),  // Psalm 102:16 (Transience)
            ("pulvis", ["pulvis"], "dust"),  // Psalm 102:14
            ("subsisto", ["subsistet"], "endure"),  // Psalm 102:16 (Negated)
        ]

        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: frailtyTerms,
            verbose: verbose
        )
    }

    // 3. Cosmic-Scale Language
    func testCosmicScaleTerms() {
        let cosmicTerms = [
            ("altitudo", ["altitudinem"], "height"),  // Psalm 102:11 (Heaven-earth comparison)
            ("ortus", ["ortus"], "sunrise"),  // Psalm 102:12 (Cardinal direction)
            ("occidens", ["occidente"], "west"),  // Psalm 102:12
            ("corroboro", ["corroboravit"], "strengthen"),  // Psalm 102:11 (Divine action)
            ("dominatio", ["dominationis"], "dominion"),  // Psalm 102:22
        ]

        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: cosmicTerms,
            verbose: verbose
        )
    }

    // 4. Angelic Hierarchy Terms
    func testAngelicTerms() {
        let angelicTerms = [
            ("potens", ["potentes"], "mighty"),  // Psalm 102:20 (Angelic attribute)
            ("minister", ["ministri"], "servant"),  // Psalm 102:21
            ("virtus", ["virtutes"], "heavenly host"),  // Psalm 102:21 (≠ "virtue")
            ("sedes", ["sedem"], "throne"),  // Psalm 102:19
            ("testamentum", ["testamentum"], "covenant"),  // Psalm 102:18
        ]

        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: angelicTerms,
            verbose: verbose
        )
    }

    // 5. Renewal Verbs (Unique Forms)
    func testRenewalVerbs() {
        let renewalTerms = [
            ("renovo", ["renovabitur"], "renew"),  // Psalm 102:5 (Eagle metaphor)
            ("redimo", ["redimit"], "redeem"),  // Psalm 102:4
            ("sano", ["sanat"], "heal"),  // Psalm 102:3
            ("retribuo", ["retribuit"], "repay"),  // Psalm 102:10
            ("recordor", ["recordatus"], "remember"),  // Psalm 102:14 (Deponent)
        ]

        utilities.testTerms(
            psalmText: text,
            psalmId: id,
            terms: renewalTerms,
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
            failOnMissing: false // Conceptual themes may have additional imagery lemmas
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
            filename: "output_psalm102_themes.json"
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
            filename: "output_psalm102_texts.json"
        )

        if success {
            print("✅ Complete texts JSON created successfully")
        } else {
            print("⚠️ Could not save complete texts file:")
            print(jsonString)
        }
    }
}