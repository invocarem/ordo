import XCTest

@testable import LatinService

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
        /* 6 */ "Faciens misericordias Dominus, et iudicium omnibus injuriam patientibus.",
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
        (1, ["benedico", "anima", "dominus", "omnia", "intra", "nomen", "sanctus"]),
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
        (12, ["quantus", "dista", "ortus", "occidens", "longe", "facio", "iniquitas"]),
        (13, ["misereor", "pater", "filius", "dominus", "timeo"]),
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
            ("figmentum", ["figmentum"], "clay form"),  // Psalm 102:14 (Creation metaphor)
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
            ("potens", ["potentes"], "mighty one"),  // Psalm 102:20 (Angelic attribute)
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
}
