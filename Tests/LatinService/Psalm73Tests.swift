@testable import LatinService
import XCTest

class Psalm73Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self
  private let verbose = true
  let id = PsalmIdentity(number: 73, category: "")

  // MARK: - Test Data Properties

  private let expectedVerseCount = 24
  private let text = [
    "Ut quid, Deus, repulisti in finem? iratus est furor tuus super oves pascuae tuae?",
    "Memor esto congregationis tuae, quam possedisti ab initio.",
    "Redemisti virgam hereditatis tuae, mons Sion, in quo habitasti in eo.",
    "Leva manus tuas in superbias eorum in finem; quanta malignatus est inimicus in sancto!",
    "Et gloriati sunt qui oderunt te in medio solemnitatis tuae; posuerunt signa sua, signa.",

    "Et non cognoverunt sicut in exitu super summum; quasi in silva lignorum securibus.",
    "Exciderunt ianuas eius in idipsum; in securi et ascia deiecerunt eam.",
    "Incenderunt igni sanctuarium tuum; in terra polluerunt tabernaculum nominis tui.",
    "Dixerunt in corde suo cognatio eorum simul: Quiescere faciamus omnes dies festos Dei a terra.",
    "Signa nostra non vidimus; iam non est propheta, et nos non cognoscet amplius.",

    "Usquequo, Deus, improperabit inimicus? irritat adversarius nomen tuum in finem?",
    "Ut quid avertis manum tuam, et dexteram tuam de medio sinu tuo in finem?",
    "Deus autem Rex noster ante saecula, operatus est salutem in medio terrae.",
    "Tu confirmasti in virtute tua mare; contribulasti capita draconum in aquis.",
    "Tu confregisti capita draconis; dedisti eum escam populis Aethiopum.",

    "Tu dirupisti fontes et torrentes; tu siccasti fluvios Ethan.",
    "Tuus est dies, et tua est nox; tu fabricatus es auroram et solem.",
    "Tu fecisti omnes terminos terrae; aestatem et ver tu plasmasti ea.",
    "Memor esto huius, inimicus improperavit Domino, et populus insipiens incitavit nomen tuum.",
    "Ne tradas bestiis animas confitentes tibi, et animas pauperum tuorum ne obliviscaris in finem.",

    "Respice in testamentum tuum, quia repleti sunt qui obscurati sunt terrae, domibus iniquitatum.",
    "Ne avertatur humilis factus confusus; pauper et inops laudabunt nomen tuum.",
    "Exsurge, Deus, iudica causam tuam; memor esto improperiorum tuorum, eorum quae ab insipiente sunt tota die.",
    "Ne obliviscaris voces inimicorum tuorum; superbia eorum qui te oderunt ascendit semper.",
  ]

  private let englishText = [
    "Why, O God, hast thou cast us off unto the end? why is thy wrath enkindled against the sheep of thy pasture?",
    "Remember thy congregation, which thou hast possessed from the beginning.",
    "The rod of thy inheritance thou hast redeemed, this mount Sion, in which thou hast dwelt.",
    "Lift up thy hands against their pride unto the end; see how the enemy hath wrought wickedness in the sanctuary!",
    "And they that hate thee have made their boasts in the midst of thy solemnity; they have set up their signs for signs.",
    "And they knew not both in the going out and on the highest top; as with axes in a wood of trees.",
    "They have cut down at once the gates thereof; with axe and hatchet they have brought it down.",
    "They have set fire to thy sanctuary; they have defiled the dwelling place of thy name on the earth.",
    "Their kindred have said together in their heart: Let us make all the feast days of God to cease from the land.",
    "Our signs we have not seen; there is now no prophet, and he will know us no more.",
    "How long, O God, shall the enemy reproach? is the adversary to provoke thy name for ever?",
    "Why dost thou turn away thy hand, and thy right hand out of the midst of thy bosom for ever?",
    "But God is our king before ages, he hath wrought salvation in the midst of the earth.",
    "Thou by thy strength didst make the sea firm; thou didst crush the heads of the dragons in the waters.",
    "Thou hast broken the heads of the dragon; thou hast given him to be meat for the people of the Ethiopians.",
    "Thou hast broken up the fountains and the torrents; thou hast dried up the rivers of Ethan.",
    "Thine is the day, and thine is the night; thou hast made the morning light and the sun.",
    "Thou hast made all the borders of the earth; the summer and the spring were formed by thee.",
    "Be mindful of this, the enemy hath reproached the Lord, and a foolish people hath provoked thy name.",
    "Deliver not up to beasts the souls that confess to thee, and forget not to the end the souls of thy poor.",
    "Have regard to thy covenant, for they that are the obscure of the earth have been filled with dwellings of iniquity.",
    "Let not the humble be turned away with confusion; the poor and needy shall praise thy name.",
    "Arise, O God, judge thy own cause; remember thy reproaches, with which the foolish man hath reproached thee all the day.",
    "Forget not the voices of thy enemies; the pride of them that hate thee ascendeth continually.",
  ]

  private let lineKeyLemmas = [
    (1, ["ut", "quis", "deus", "repello", "finis", "iratus", "furor", "ovis", "pascuum"]),
    (2, ["memor", "congregatio", "possideo", "initium"]),
    (3, ["redimo", "virga", "hereditas", "mons", "sion", "habito"]),
    (4, ["levo", "manus", "superbia", "finis", "malignor", "inimicus", "sanctus"]),
    (5, ["glorior", "odi", "medius", "solemnitas", "pono", "signum"]),
    (6, ["cognosco", "exitus", "summus", "silva", "lignum", "securis"]),
    (7, ["excido", "ianua", "is", "idem", "securis", "ascia", "deicio"]),
    (8, ["incendo", "ignis", "sanctuarium", "terra", "polluo", "tabernaculum", "nomen"]),
    (9, ["dico", "cor", "cognatio", "simul", "quiesco", "facio", "dies", "festus", "deus", "terra"]),
    (10, ["signum", "video", "propheta", "cognosco", "amplius"]),
    (11, ["usquequo", "deus", "impropero", "inimicus", "irrito", "adversarius", "nomen", "finis"]),
    (12, ["ut", "averto", "manus", "dexter", "medius", "sinus", "finis"]),
    (13, ["deus", "rex", "ante", "saeculum", "operor", "salus", "medius", "terra"]),
    (14, ["confirmo", "virtus", "mare", "contribulo", "caput", "draco", "aqua"]),
    (15, ["confringo", "caput", "draco", "do", "esca", "populus", "aethiops"]),
    (16, ["dirumpo", "fons", "torrens", "sicco", "fluvius", "ethan"]),
    (17, ["dies", "nox", "fabricor", "aurora", "sol"]),
    (18, ["facio", "terminus", "terra", "aestas", "ver", "plasmatus"]),
    (19, ["memor", "inimicus", "impropero", "dominus", "populus", "insipiens", "incito", "nomen"]),
    (20, ["trado", "bestia", "anima", "confiteor", "anima", "pauper", "obliviscor", "finis"]),
    (21, ["respicio", "testamentum", "repleo", "obscuro", "terra", "domus", "iniquitas"]),
    (22, ["averto", "humilis", "facio", "confundo", "pauper", "inops", "laudo", "nomen"]),
    (23, ["exsurgo", "deus", "iudico", "causa", "memor", "improperium", "insipiens", "totus", "dies"]),
    (24, ["obliviscor", "vox", "inimicus", "superbia", "odi", "ascendo", "semper"]),
  ]

  private let structuralThemes = [
    (
      "Divine Rejection → Pastoral Concern",
      "The psalmist's lament over God's apparent rejection and concern for His flock",
      ["repello", "furor", "ovis", "pascuum", "memor", "congregatio"],
      1,
      2,
      "The psalmist questions why God has cast off His people and why His wrath burns against the sheep of His pasture, then pleads for God to remember His congregation which He has possessed from the beginning.",
      "Augustine sees this as the soul's cry of abandonment combined with faith in God's eternal covenant, where the believer questions divine providence while maintaining trust in God's ultimate faithfulness to His people."
    ),
    (
      "Sacred Inheritance → Divine Vengeance",
      "The redemption of Mount Zion and God's call to lift hands against the enemy's pride",
      ["redimo", "virga", "hereditas", "mons", "sion", "levo", "manus", "superbia"],
      3,
      4,
      "The psalmist recalls how God has redeemed the rod of His inheritance, Mount Zion where He dwelt, then calls on God to lift up His hands against the pride of the enemy who has wrought wickedness in the sanctuary.",
      "For Augustine, this represents the soul's recognition of God's past faithfulness to His chosen dwelling place and the call for divine justice against those who profane what is holy and sacred."
    ),
    (
      "Enemy Boasting → Sanctuary Destruction",
      "The enemy's boasting in God's solemnity and their destruction of the sanctuary gates",
      ["glorior", "odi", "solemnitas", "pono", "signum", "cognosco", "exitus", "summus", "silva", "lignum", "securis"],
      5,
      6,
      "The psalmist describes how those who hate God have boasted in the midst of His solemnity and set up their signs, then how they have cut down the gates of the sanctuary with axes and hatchets.",
      "Augustine sees this as the soul's recognition of the enemy's blasphemous triumph over sacred things and the systematic destruction of God's dwelling place, representing the desecration of divine worship."
    ),
    (
      "Sanctuary Destruction → Feast Abolition",
      "The burning of the sanctuary and the enemy's plan to abolish all feast days",
      ["excido", "ianua", "is", "idem", "securis", "ascia", "deicio", "incendo", "ignis", "sanctuarium", "terra", "polluo", "tabernaculum", "nomen"],
      7,
      8,
      "The psalmist describes how the enemy has set fire to God's sanctuary and defiled the tabernacle of His name, then how they have conspired to make all the feast days of God cease from the land.",
      "For Augustine, this represents the complete destruction of divine worship and the enemy's systematic attempt to eradicate all remembrance of God's holy days and sacred observances."
    ),
    (
      "Prophetic Silence → Divine Reproach",
      "The absence of prophets and signs, leading to questions about God's apparent silence",
      ["dico", "cor", "cognatio", "simul", "quiesco", "facio", "dies", "festus", "deus", "terra", "signum", "video", "propheta", "cognosco", "amplius"],
      9,
      10,
      "The psalmist laments that they have not seen their signs and there is no prophet, then questions how long the enemy will reproach God and provoke His name forever.",
      "Augustine sees this as the soul's experience of divine silence in times of crisis, where the absence of prophetic guidance and divine signs tests the believer's faith and raises questions about God's apparent abandonment."
    ),
    (
      "Divine Withdrawal → Eternal Kingship",
      "Questions about God's withdrawn hand contrasted with His eternal kingship and salvation",
      ["usquequo", "deus", "impropero", "inimicus", "irrito", "adversarius", "nomen", "finis", "ut", "averto", "manus", "dexter", "medius", "sinus", "finis"],
      11,
      12,
      "The psalmist questions why God turns away His hand and right hand from His bosom, then declares that God is their king before ages who has wrought salvation in the midst of the earth.",
      "For Augustine, this represents the tension between apparent divine withdrawal and the eternal reality of God's kingship, where faith must transcend present circumstances to trust in God's ultimate sovereignty and saving power."
    ),
    (
      "Cosmic Power → Dragon Defeat",
      "God's power over the sea and His defeat of the dragon, demonstrating His cosmic authority",
      ["deus", "rex", "ante", "saeculum", "operor", "salus", "medius", "terra", "confirmo", "virtus", "mare", "contribulo", "caput", "draco", "aqua"],
      13,
      14,
      "The psalmist describes how God has confirmed the sea by His strength and crushed the heads of dragons in the waters, then how He has broken the heads of the dragon and given him as food to the people of Ethiopia.",
      "Augustine sees this as the soul's recognition of God's absolute power over chaos and evil, where the defeat of the dragon represents Christ's victory over Satan and the forces of darkness that threaten God's creation."
    ),
    (
      "Natural Dominion → Temporal Control",
      "God's control over fountains, rivers, day, night, and the seasons of the earth",
      ["confringo", "caput", "draco", "do", "esca", "populus", "aethiops", "dirumpo", "fons", "torrens", "sicco", "fluvius", "ethan"],
      15,
      16,
      "The psalmist describes how God has broken up fountains and torrents and dried up the rivers of Ethan, then declares that the day and night belong to God who has made the morning light and the sun.",
      "For Augustine, this represents the soul's recognition of God's absolute sovereignty over all natural phenomena and temporal cycles, demonstrating His complete control over creation and the passage of time."
    ),
    (
      "Earthly Boundaries → Divine Remembrance",
      "God's creation of earthly boundaries and seasons, leading to remembrance of enemy reproach",
      ["dies", "nox", "fabricor", "aurora", "sol", "facio", "terminus", "terra", "aestas", "ver", "plasmatus"],
      17,
      18,
      "The psalmist describes how God has made all the borders of the earth and formed summer and spring, then calls for remembrance of how the enemy has reproached the Lord and a foolish people has provoked His name.",
      "For Augustine, this represents the soul's recognition of God's creative power over all earthly boundaries and seasons, contrasted with the need to remember how the wicked have blasphemed God's holy name."
    ),
    (
      "Soul Preservation → Covenant Remembrance",
      "Plea not to deliver souls to beasts and call to remember the covenant with the poor",
      ["trado", "bestia", "anima", "confiteor", "pauper", "obliviscor", "respicio", "testamentum", "repleo"],
      19,
      20,
      "The psalmist pleads that God not deliver the souls that confess to Him to beasts, and not forget the souls of His poor, then calls for God to look upon His covenant since those who are obscure of the earth have been filled with dwellings of iniquity.",
      "Augustine sees this as the soul's plea for divine protection of the faithful and remembrance of God's covenant promises, recognizing that the wicked have filled the earth with iniquity while the righteous suffer."
    ),
    (
      "Humble Praise → Divine Judgment",
      "The humble and poor praising God's name, leading to the call for divine judgment",
      ["obscuro", "domus", "iniquitas", "averto", "humilis", "confusus", "laudo", "exsurgo", "iudico"],
      21,
      22,
      "The psalmist describes how the obscure of the earth have been filled with dwellings of iniquity, then pleads that the humble not be turned away with confusion and that the poor and needy praise God's name, finally calling for God to arise and judge His cause, remembering the reproaches with which the foolish man has reproached Him all the day.",
      "For Augustine, this represents the soul's recognition of the contrast between the wicked who prosper and the righteous who suffer, leading to the ultimate plea for divine justice and vindication of God's holy name, where the believer places complete trust in God's justice to ultimately triumph over all the blasphemies and reproaches of the wicked."
    ),
    (
      "Final Judgment Call → Enemy Pride",
      "The psalmist's final call for God to arise and judge, remembering the reproaches of the foolish",
      ["exsurgo", "deus", "iudico", "causa", "memor", "improperium", "insipiens", "totus", "dies", "obliviscor", "vox", "inimicus", "superbia", "odi", "ascendo", "semper"],
      23,
      24,
      "The psalmist calls for God to arise and judge His own cause, remembering the reproaches with which the foolish man has reproached Him all the day, and pleads that God not forget the voices of His enemies whose pride ascends continually.",
      "Augustine sees this as the soul's ultimate cry for divine vindication, where the believer places complete trust in God's justice to ultimately triumph over all the blasphemies and reproaches of the wicked, recognizing that the enemy's pride continues to rise against God's holy name."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Wrath and Rejection",
      "References to God's anger, casting off, and apparent abandonment",
      ["repello", "furor", "iratus", "averto", "manus"],
      ThemeCategory.divine,
      1 ... 12
    ),
    (
      "Sacred Places and Worship",
      "References to sanctuary, tabernacle, Mount Zion, and sacred worship",
      ["sanctus", "sanctuarium", "tabernaculum", "mons", "sion", "solemnitas", "festus"],
      ThemeCategory.worship,
      3 ... 9
    ),
    (
      "Enemy Destruction and Blasphemy",
      "References to enemy actions, boasting, and destruction of sacred things",
      ["inimicus", "malignor", "glorior", "odi", "excindo", "incendo", "polluo", "impropero"],
      ThemeCategory.sin,
      4 ... 11
    ),
    (
      "Divine Power and Sovereignty",
      "References to God's cosmic power, kingship, and control over creation",
      ["deus", "rex", "virtus", "mare", "draco", "fons", "torrens", "dies", "nox", "terminus"],
      ThemeCategory.divine,
      13 ... 18
    ),
    (
      "Salvation and Redemption",
      "References to salvation, redemption, and divine deliverance",
      ["redimo", "salus", "operor", "confiteor", "testamentum"],
      ThemeCategory.divine,
      3 ... 21
    ),
    (
      "Poverty and Humility",
      "References to the poor, humble, and needy who trust in God",
      ["pauper", "humilis", "inops", "obscuro", "confusus"],
      ThemeCategory.virtue,
      20 ... 22
    ),
    (
      "Divine Judgment and Justice",
      "References to judgment, causes, and divine vindication",
      ["iudico", "causa", "memor", "improperium", "exsurgo", "obliviscor", "vox", "inimicus", "superbia", "odi", "ascendo", "semper"],
      ThemeCategory.divine,
      19 ... 24
    ),
    (
      "Prophetic and Divine Communication",
      "References to prophets, signs, and divine revelation",
      ["propheta", "signum", "video", "cognosco", "nomen"],
      ThemeCategory.divine,
      5 ... 11
    ),
  ]

  // MARK: - Setup

  override func setUp() {
    super.setUp()
  }

  // MARK: - Test Cases

  func testTotalVerses() {
    XCTAssertEqual(
      text.count, expectedVerseCount, "Psalm 73 should have \(expectedVerseCount) verses"
    )
    XCTAssertEqual(
      englishText.count, expectedVerseCount,
      "Psalm 73 English text should have \(expectedVerseCount) verses"
    )
    // Also validate the orthography of the text for analysis consistency
    let normalized = text.map { PsalmTestUtilities.validateLatinText($0) }
    XCTAssertEqual(
      normalized,
      text,
      "Normalized Latin text should match expected classical forms"
    )
  }

  func testSaveTexts() {
    let utilities = PsalmTestUtilities.self
    let jsonString = utilities.generatePsalmTextsJSONString(
      psalmNumber: id.number,
      category: id.category ?? "",
      text: text,
      englishText: englishText
    )

    let success = utilities.saveToFile(
      content: jsonString,
      filename: "output_psalm73_texts.json"
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
      filename: "output_psalm73_themes.json"
    )

    if success {
      print("✅ Complete themes JSON created successfully")
    } else {
      print("⚠️ Could not save complete themes file:")
      print(jsonString)
    }
  }

  func testLineByLineKeyLemmas() {
    let utilities = PsalmTestUtilities.self
    utilities.testLineByLineKeyLemmas(
      psalmText: text,
      lineKeyLemmas: lineKeyLemmas,
      psalmId: id,
      verbose: verbose
    )
  }

  func testStructuralThemes() {
    let utilities = PsalmTestUtilities.self

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
    let utilities = PsalmTestUtilities.self

    // First, verify that conceptual theme lemmas are in lineKeyLemmas
    let conceptualLemmas = conceptualThemes.flatMap { $0.2 }
    let lineKeyLemmasFlat = lineKeyLemmas.flatMap { $0.1 }

    utilities.testLemmasInSet(
      sourceLemmas: conceptualLemmas,
      targetLemmas: lineKeyLemmasFlat,
      sourceName: "conceptual themes",
      targetName: "lineKeyLemmas",
      verbose: verbose
    )

    // Then run the standard conceptual themes test
    utilities.testConceptualThemes(
      psalmText: text,
      conceptualThemes: conceptualThemes,
      psalmId: id,
      verbose: verbose
    )
  }
}
