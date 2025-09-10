@testable import LatinService
import XCTest

class Psalm3Tests: XCTestCase {
    private let utilities = PsalmTestUtilities.self
    private let verbose = true

    override func setUp() {
        super.setUp()
    }

    let id = PsalmIdentity(number: 3, category: nil)

    // MARK: - Test Data

    private let psalm3 = [
        "Domine, quid multiplicati sunt qui tribulant me? multi insurgunt adversum me.",
        "Multi dicunt animae meae: Non est salus ipsi in Deo eius.",
        "Tu autem, Domine, susceptor meus es, gloria mea, et exaltans caput meum.",
        "Voce mea ad Dominum clamavi, et exaudivit me de monte sancto suo.",
        "Ego dormivi et soporatus sum; exsurrexi, quia Dominus suscepit me.",
        "Non timebo milia populi circumdantis me: exsurge, Domine; salvum me fac, Deus meus.",
        "Quoniam tu percussisti omnes adversantes mihi sine causa; dentes peccatorum contrivisti.",
        "Domini est salus; et super populum tuum benedictio tua.",
    ]

    private let lineKeyLemmas = [
        (1, ["dominus", "multiplico", "tribulo", "insurgo", "adversus"]),
        (2, ["multus", "dico", "anima", "salus", "deus"]),
        (3, ["dominus", "susceptor", "gloria", "exalto", "caput"]),
        (4, ["vox", "dominus", "clamo", "exaudio", "mons", "sanctus"]),
        (5, ["dormio", "soporor", "exsurgo", "dominus", "suscipio"]),
        (6, ["timeo", "mille", "populus", "circumdo", "exsurgo", "dominus", "salvus", "facio", "deus"]),
        (7, ["percutio", "adversus", "causa", "dens", "peccator", "contero"]),
        (8, ["dominus", "salus", "populus", "benedictio"]),
    ]

    private let structuralThemes = [
        (
            "Oppression → Multiplication",
            "The overwhelming multiplication of adversaries and troublers",
            ["multiplico", "tribulo", "insurgo", "adversus", "dico", "anima"],
            1,
            2,
            "The psalmist laments the many who trouble him and rise against him, with many saying to his soul that there is no salvation in his God.",
            "Augustine sees this as representing both physical persecutors and spiritual temptations that multiply against the soul. The taunt 'no salvation' reflects the enemy's attempt to destroy faith in God's deliverance."
        ),
        (
            "Declaration → Exaltation",
            "Affirmation of God as protector, glory, and lifter of the head",
            ["susceptor", "exalto", "caput", "vox", "clamo", "exaudio"],
            3,
            4,
            "Despite the opposition, the psalmist declares the Lord as his protector, his glory, and the one who lifts his head. He cries out and is heard from God's holy mountain.",
            "For Augustine, God as 'susceptor' signifies both shield and sustainer. The exalted head represents restored dignity and hope. The holy mountain symbolizes God's heavenly throne and unchanging nature."
        ),
        (
            "Rest → Confidence",
            "Sleeping and waking in God's care, leading to fearless confidence",
            ["dormio", "soporor", "suscipio", "timeo", "circumdo"],
            5,
            6,
            "The psalmist sleeps and wakes in God's care, arising because the Lord sustains him. He fears no thousands of people surrounding him and calls on God to arise and save him.",
            "Augustine interprets this sleep as both physical rest and spiritual peace in God's protection. The fearless awakening demonstrates complete trust in divine sustenance amid overwhelming opposition."
        ),
        (
            "Deliverance → Benediction",
            "God's striking of adversaries and bestowal of salvation and blessing",
            ["percutio", "adversus", "contero", "dens", "salus", "benedictio"],
            7,
            8,
            "The Lord has struck all who oppose without cause and shattered the teeth of sinners. Salvation belongs to the Lord, and His blessing is upon His people.",
            "Augustine sees the shattered teeth as rendering malicious speech powerless. The final declaration affirms that salvation is God's sovereign work, and His blessing rests on those who belong to Him."
        ),
    ]

    private let conceptualThemes = [
        (
            "Divine Protection",
            "God as shield and sustainer",
            ["susceptor", "suscipio", "exalto", "circumdo"],
            ThemeCategory.divine,
            3 ... 6
        ),
        (
            "Opposition and Enemies",
            "Adversaries and trouble from opponents",
            ["tribulo", "insurgo", "adversus", "peccator", "multiplico"],
            .opposition,
            1 ... 2
        ),
        (
            "Trust in God",
            "Lack of fear through faith in God",
            ["timeo", "confido"],
            .virtue,
            6 ... 6
        ),
        (
            "Prayer and Divine Response",
            "Crying out to God and His answer",
            ["clamo", "exaudio", "vox"],
            .worship,
            4 ... 4
        ),
        (
            "Divine Salvation",
            "God's deliverance and blessing",
            ["salus", "salvus", "benedictio"],
            .divine,
            7 ... 8
        ),
        (
            "Divine Justice",
            "God's judgment against adversaries",
            ["percutio", "contero"],
            .justice,
            7 ... 7
        ),
    ]

    // MARK: - Line by Line Key Lemmas Test

    func testPsalm3LineByLineKeyLemmas() {
        utilities.testLineByLineKeyLemmas(
            psalmText: psalm3,
            lineKeyLemmas: lineKeyLemmas,
            psalmId: id,
            verbose: verbose
        )
    }

    func testPsalm3StructuralThemes() {
        utilities.testStructuralThemes(
            psalmText: psalm3,
            structuralThemes: structuralThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testPsalm3ConceptualThemes() {
        utilities.testConceptualThemes(
            psalmText: psalm3,
            conceptualThemes: conceptualThemes,
            psalmId: id,
            verbose: verbose
        )
    }

    func testSavePsalm3Themes() {
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
            filename: "output_psalm3_themes.json"
        )

        if success {
            print("✅ Complete themes JSON created successfully")
        } else {
            print("⚠️ Could not save complete themes file:")
            print(jsonString)
        }
    }
}
