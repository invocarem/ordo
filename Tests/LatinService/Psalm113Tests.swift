@testable import LatinService
import XCTest

class Psalm113Tests: XCTestCase {
    private var latinService: LatinService!
    private let verbose = true
    let id = PsalmIdentity(number: 113, category: "exodus")

    // MARK: - Test Data Properties

    private let psalm113 = [
      "In exitu Israel de Aegypto, domus Iacob de populo barbaro,",
      "Facta est Iudaea sanctificatio eius, Israel potestas eius.",
      "Mare vidit et fugit; Iordanis conversus est retrorsum.",
      "Montes exsultaverunt ut arietes, et colles sicut agni ovium.",
      "Quid est tibi, mare, quod fugisti? et tu, Iordanis, quia conversus es retrorsum?",
      "Montes, exsultastis sicut arietes? et colles, sicut agni ovium?",
      "A facie Domini mota est terra, a facie Dei Iacob.",
      "Qui convertit petram in stagna aquarum, et rupem in fontes aquarum.",
      "Non nobis, Domine, non nobis: sed nomini tuo da gloriam.",
      "Super misericordia tua, et veritate tua: nequando dicant gentes: Ubi est Deus eorum?",
      "Deus autem noster in caelo: omnia quaecumque voluit, fecit.",
      "Simulacra gentium argentum et aurum, opera manuum hominum.",
      "Os habent, et non loquentur: oculos habent, et non videbunt.",
      "Aures habent, et non audient: nares habent, et non odorabunt.",
      "Manus habent, et non palpabunt: pedes habent, et non ambulabunt: non clamabunt in gutture suo.",
      "Similes illis fiant qui faciunt ea: et omnes qui confidunt in eis.",
      "Domus Israel speravit in Domino: adiutor eorum et protector eorum est.",
      "Domus Aaron speravit in Domino: adiutor eorum et protector eorum est.",
      "Qui timent Dominum, speraverunt in Domino: adiutor eorum et protector eorum est.",
      "Dominus memor fuit nostri: et benedixit nobis.",
      "Benedixit domui Israel: benedixit domui Aaron.",
      "Benedixit omnibus qui timent Dominum, pusillis cum maioribus.",
      "Adiiciat Dominus super vos: super vos, et super filios vestros.",
      "Benedicti vos a Domino, qui fecit caelum et terram.",
      "Caelum caeli Domino: terram autem dedit filiis hominum.",
      "Non mortui laudabunt te, Domine: neque omnes qui descendunt in infernum.",
      "Sed nos qui vivimus, benedicimus Domino, ex hoc nunc et usque in saeculum.",
    ]

    private let englishText = [
      "When Israel went out of Egypt, the house of Jacob from a barbarous people:",
      "Judea was made his sanctuary, Israel his dominion.",
      "The sea saw and fled: Jordan was turned back.",
      "The mountains skipped like rams, and the hills like the lambs of the flock.",
      "What ailed thee, O thou sea, that thou didst flee: and thou, O Jordan, that thou wast turned back?",
      "Ye mountains, that ye skipped like rams: and ye hills, like lambs of the flock?",
      "At the presence of the Lord the earth was moved, at the presence of the God of Jacob:",
      "Who turned the rock into pools of water, the sharp rock into fountains of waters.",
      "Not to us, O Lord, not to us; but to thy name give glory.",
      "For thy mercy, and for thy truth's sake: lest the gentiles should say, Where is their God?",
      "But our God is in heaven: he hath done all things whatsoever he would.",
      "The idols of the gentiles are silver and gold, the works of the hands of men.",
      "They have mouths, and speak not: they have eyes, and see not.",
      "They have ears, and hear not: they have noses, and smell not.",
      "They have hands, and feel not: they have feet, and walk not: neither shall they cry out through their throat.",
      "Let them that make them become like unto them: and all such as trust in them.",
      "The house of Israel hath hoped in the Lord: he is their helper and their protector.",
      "The house of Aaron hath hoped in the Lord: he is their helper and their protector.",
      "They that fear the Lord have hoped in the Lord: he is their helper and their protector.",
      "The Lord hath been mindful of us, and hath blessed us.",
      "He hath blessed the house of Israel: he hath blessed the house of Aaron.",
      "He hath blessed all that fear the Lord, both little and great.",
      "May the Lord add blessings upon you: upon you, and upon your children.",
      "Blessed are you of the Lord, who made heaven and earth.",
      "The heaven of heaven is the Lord's: but the earth he hath given to the children of men.",
      "The dead shall not praise thee, O Lord: nor any of them that go down into hell.",
      "But we that live bless the Lord: from this time now and for ever.",
    ]

    private let lineKeyLemmas = [
      (1, ["exitus", "israel", "aegyptus", "domus", "iacob", "barbarus"]),
      (2, ["sum", "iudaea", "sanctificatio", "israel", "potestas", "facio"]),
      (3, ["mare", "fugio", "iordanes", "converto", "retrorsum"]),
      (4, ["mons", "exsulto", "aries", "collis", "agnus", "ovis"]),
      (5, ["mare", "fugio", "iordanes", "converto"]),
      (6, ["mons", "exsulto", "aries", "collis"]),
      (7, ["facies", "dominus", "moveo", "terra", "deus", "iacob"]),
      (8, ["converto", "petra", "stagnum", "aqua", "rupes", "fons"]),
      (9, ["dominus", "nomen", "gloria"]),
      (10, ["misericordia", "veritas", "nequando", "gens", "deus"]),
      (11, ["deus", "caelum", "volo", "facio", "omnis"]),
      (12, ["simulacrum", "gens", "argentum", "aurum", "opus", "manus", "homo"]),
      (13, ["os", "loquor", "oculus", "video"]),
      (14, ["auris", "audio", "naris", "odoror"]),
      (15, ["manus", "palpo", "pes", "ambulo", "guttur"]),
      (16, ["similis", "confido", "facio"]),
      (17, ["domus", "israel", "spero", "dominus", "adiutor", "protector"]),
      (18, ["domus", "aaron", "spero", "dominus", "adiutor", "protector"]),
      (19, ["timeo", "dominus", "spero", "adiutor", "protector"]),
      (20, ["dominus", "memor", "benedico"]),
      (21, ["benedico", "domus", "israel", "aaron"]),
      (22, ["benedico", "timeo", "dominus", "pusillus"]),
      (23, ["dominus", "super", "vos", "filius", "vester"]),
      (24, ["benedico", "dominus", "facio", "caelum", "terra"]),
      (25, ["caelum", "dominus", "terra", "do", "filius", "homo"]),
      (26, ["mortuus", "laudo", "dominus", "descendo", "infernus"]),
      (27, ["vivo", "benedico", "dominus", "saeculum"]),
    ]

    private let structuralThemes = [
      (
        "Exodus → Sanctification",
        "Israel's departure from Egypt and Judah's consecration as God's domain",
        ["exitus", "aegyptus", "iacob", "barbarus", "sanctificatio", "potestas"],
        1,
        2,
        "The psalm opens with Israel's exodus from Egypt and the house of Jacob from a foreign people, then declares Judah God's sanctuary and Israel his dominion.",
        "Augustine reads the exodus as the soul's liberation from sin's bondage, with sanctified Judah as the Church set apart for God."
      ),
      (
        "Waters Flee → Hills Rejoice",
        "The sea and Jordan retreat while mountains and hills leap like flock animals",
        ["mare", "fugio", "iordanes", "converto", "mons", "exsulto", "aries", "collis"],
        3,
        4,
        "Creation itself responds to God: the sea flees, the Jordan turns back, and mountains and hills exult like rams and lambs.",
        "For Augustine, inanimate creation figures the conversion of the nations and the joy of the righteous at God's mighty deeds."
      ),
      (
        "Rhetorical Questions → Cosmic Submission",
        "The psalmist questions sea and Jordan, then mountains and hills, pressing creation's obedient wonder",
        ["mare", "fugio", "iordanes", "converto", "mons", "exsulto"],
        5,
        6,
        "Why did you flee, O sea, and turn back, O Jordan? Why did mountains and hills leap like lambs at the Lord's presence?",
        "Augustine sees these questions as awakening the soul to recognize that all creation bows before the Creator's word."
      ),
      (
        "Earth Trembles → Rock to Water",
        "The Lord's face moves the earth and transforms rock into springs",
        ["facies", "dominus", "moveo", "terra", "deus", "iacob", "converto", "petra", "stagnum", "fons"],
        7,
        8,
        "Before the Lord the earth quakes, and the God of Jacob turns rock into pools and cliffs into fountains.",
        "Augustine interprets the rock made water as grace flowing from Christ, the spiritual rock from which the faithful drink."
      ),
      (
        "Glory to God's Name → Mercy and Truth",
        "Refusal of self-glory and appeal to God's mercy lest the nations mock",
        ["dominus", "nomen", "gloria", "misericordia", "veritas", "gens", "deus"],
        9,
        10,
        "The faithful give glory not to themselves but to God's name, grounding that plea in his mercy and truth so the nations cannot ask where God is.",
        "Augustine teaches that true humility ascribes all honor to God, while mercy and truth silence the scoffing of unbelievers."
      ),
      (
        "Heavenly Sovereignty → Lifeless Idols",
        "The living God does all he wills in heaven, contrasted with silver and gold idols fashioned by hands",
        ["deus", "caelum", "volo", "facio", "simulacrum", "argentum", "aurum", "opus", "manus"],
        11,
        12,
        "Our God is in heaven and accomplishes his will, unlike the nations' idols of silver and gold, mere works of human hands.",
        "Augustine contrasts God's omnipotence with idols that have being only from human craft, exposing the folly of trusting creatures."
      ),
      (
        "Idol Senses: Speech and Sight",
        "Idols have mouths and eyes yet cannot speak or see",
        ["os", "loquor", "oculus", "video"],
        13,
        14,
        "Silver and gold idols possess mouths and eyes but neither speak nor see, exposing their lifelessness.",
        "Augustine sees in this the spiritual deadness of false worship: outward form without the inward life that true speech and vision require."
      ),
      (
        "Idol Senses: Hearing and Trust",
        "Idols cannot hear or smell; makers and trusters become like them",
        ["auris", "audio", "naris", "odoror", "similis", "confido", "manus", "palpo", "pes", "ambulo", "guttur"],
        15,
        16,
        "Idols lack hearing and smell, cannot feel or walk or cry out; those who make or trust them are made like them.",
        "Augustine warns that complete sensory impotence in the idol reflects the soul's fate when it abandons the living God for dead images."
      ),
      (
        "House of Israel → House of Aaron",
        "Both houses hope in the Lord as helper and protector",
        ["domus", "israel", "spero", "dominus", "adiutor", "protector", "aaron"],
        17,
        18,
        "The house of Israel and the house of Aaron each trust in the Lord, who is their helper and protector.",
        "Augustine reads the double confession as the union of the whole people with their priesthood in one hope placed in Christ the true protector."
      ),
      (
        "God-Fearers → Divine Remembrance",
        "Those who fear the Lord hope in him; the Lord remembers and blesses",
        ["timeo", "dominus", "spero", "adiutor", "protector", "memor", "benedico"],
        19,
        20,
        "All who fear the Lord hope in him as helper and protector, and the Lord remembers his own and blesses them.",
        "Augustine joins fear of the Lord with divine remembrance: reverent hope receives the blessing that flows from God's faithful memory of his people."
      ),
      (
        "Blessing the Houses → All Who Fear",
        "Blessing on Israel and Aaron, then on all who fear the Lord, small and great",
        ["benedico", "domus", "israel", "aaron", "timeo", "dominus", "pusillus"],
        21,
        22,
        "God blesses the houses of Israel and Aaron, then every soul that fears him, the least together with the greatest.",
        "Augustine sees an ascending wideness of mercy: from covenant lines to the entire company of the humble and the great who fear the Lord."
      ),
      (
        "Blessing on Posterity → Blessed by the Creator",
        "The Lord adds blessing upon his servants and their children; the blessed are blessed by heaven's Maker",
        ["dominus", "super", "vos", "filius", "vester", "benedico", "facio", "caelum", "terra"],
        23,
        24,
        "The Lord multiplies blessing on his people and their children, and those blessed are blessed by him who made heaven and earth.",
        "Augustine links fruitfulness in offspring to creation's Lord: every blessing descends from the Maker of the cosmos."
      ),
      (
        "Heaven and Earth → Silence of Sheol",
        "Heaven belongs to the Lord; the dead in the depths do not praise",
        ["caelum", "dominus", "terra", "do", "homo", "mortuus", "laudo", "descendo", "infernus"],
        25,
        26,
        "The heaven of heavens is the Lord's, yet the earth is given to the sons of men; the dead descend to silence and do not praise God.",
        "Augustine contrasts the Lord's exalted heaven with Sheol's silence, where no voice can rise to bless the name that the living must extol."
      ),
      (
        "Living Praise Forever",
        "We who live bless the Lord from now unto eternity",
        ["vivo", "benedico", "dominus", "saeculum"],
        27,
        27,
        "But we the living bless the Lord from this moment forever, completing the psalm's turn from idols and death to true endless praise.",
        "Augustine urges the Church to seize the present life as the time of praise, for only the living can bless God until glory makes that praise unending."
      ),
    ]

    private let conceptualThemes = [
      (
        "Exodus and Election",
        "Departure from Egypt and God's holy possession of his people",
        ["exitus", "aegyptus", "iacob", "israel", "iudaea", "sanctificatio", "potestas"],
        ThemeCategory.divine,
        1 ... 2
      ),
      (
        "Cosmic Theophany",
        "Creation's response to the Lord's presence",
        ["mare", "iordanes", "converto", "mons", "exsulto", "terra", "moveo", "petra", "fons"],
        ThemeCategory.divine,
        3 ... 8
      ),
      (
        "True Worship versus Idolatry",
        "Glory to God's name and the vanity of idols",
        ["gloria", "nomen", "misericordia", "veritas", "simulacrum", "argentum", "aurum", "confido"],
        ThemeCategory.worship,
        9 ... 16
      ),
      (
        "Hope in Divine Aid",
        "Trust in the Lord as helper and protector",
        ["spero", "adiutor", "protector", "domus", "timeo"],
        ThemeCategory.virtue,
        17 ... 19
      ),
      (
        "Covenant Blessing",
        "Remembrance, blessing, and fruitfulness",
        ["memor", "benedico", "dominus", "israel", "aaron", "filius", "vos"],
        ThemeCategory.divine,
        20 ... 23
      ),
      (
        "Creation and Praise",
        "Heaven and earth, mortality, and enduring praise",
        ["caelum", "terra", "facio", "mortuus", "infernus", "vivo", "saeculum", "laudo"],
        ThemeCategory.worship,
        24 ... 27
      ),
    ]

    // MARK: - Setup

    override func setUp() {
      super.setUp()
      latinService = LatinService.shared
    }

    // MARK: - Test Methods

    func testTotalVerses() {
      let expectedVerseCount = 27
      XCTAssertEqual(
        psalm113.count, expectedVerseCount, "Psalm 113 should have \(expectedVerseCount) verses"
      )
      XCTAssertEqual(
        englishText.count, expectedVerseCount,
        "Psalm 113 English text should have \(expectedVerseCount) verses"
      )
      let normalized = psalm113.map { PsalmTestUtilities.validateLatinText($0) }
      XCTAssertEqual(
        normalized,
        psalm113,
        "Normalized Latin text should match expected classical forms"
      )
    }

    func testLineByLineKeyLemmas() {
      let utilities = PsalmTestUtilities.self
      utilities.testLineByLineKeyLemmas(
        psalmText: psalm113,
        lineKeyLemmas: lineKeyLemmas,
        psalmId: id,
        verbose: verbose
      )
    }

    func testStructuralThemes() {
      let utilities = PsalmTestUtilities.self
      utilities.testStructuralThemes(
        psalmText: psalm113,
        structuralThemes: structuralThemes,
        psalmId: id,
        verbose: verbose
      )
    }

    func testConceptualThemes() {
      let utilities = PsalmTestUtilities.self
      utilities.testConceptualThemes(
        psalmText: psalm113,
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
        text: psalm113,
        englishText: englishText
      )

      let success = utilities.saveToFile(
        content: jsonString,
        filename: "output_psalm113_texts.json"
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
        filename: "output_psalm113_themes.json"
      )

      if success {
        print("✅ Complete themes JSON created successfully")
      } else {
        print("⚠️ Could not save complete themes file:")
        print(jsonString)
      }
    }
}
