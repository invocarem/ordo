@testable import LatinService
import XCTest

class Psalm78Tests: XCTestCase {
  private let utilities = PsalmTestUtilities.self

  private let verbose = true

  override func setUp() {
    super.setUp()
  }

  let id = PsalmIdentity(number: 78, category: nil)
  private let expectedVerseCount = 15

  // MARK: - Test Data

  private let text = [
    "Deus, venerunt gentes in hereditatem tuam: polluerunt templum sanctum tuum: posuerunt Ierusalem in pomorum custodiam.",
    "Posuerunt morticina servorum tuorum, escas volatilibus caeli: carnes sanctorum tuorum, bestiis terrae.",
    "Effuderunt sanguinem ipsorum tamquam aquam in circuitu Ierusalem: et non erat qui sepeliret.",
    "Facti sumus opprobrium vicinis nostris: subsannatio et illusio his, qui in circuitu nostro sunt.",
    "Usquequo Domine irasceris in finem: accendetur velut ignis zelus tuus?",
    "Effunde iram tuam in gentes, quae te non noverunt: et in regna quae nomen tuum non invocaverunt.",
    "Quia comederunt Iacob: et locum eius desolaverunt.",
    "Ne memineris iniquitatum nostrarum antiquarum: cito anticipent nos misericordiae tuae, quia pauperes facti sumus nimis.",
    "adiuva nos, Deus salutaris noster: propter gloriam nominis tui, Domine, libera nos: et propitius esto peccatis nostris, propter nomen tuum.",
    "Ne forte dicant in gentibus: Ubi est Deus eorum? et innotescat in nationibus coram oculis nostris:",
    "Ultio sanguinis servorum tuorum, qui effusus est. Introeat in conspectu tuo gemitus compeditorum:",
    "Secundum magnitudinem brachii tui, posside filios mortificatorum.",
    "Et redde vicinis nostris septuplum in sinu eorum: improperium ipsorum, quod exprobraverunt tibi, Domine.",
    "Nos autem populus tuus, et oves pascuae tuae, confitebimur tibi in saeculum:",
    "In generationem et generationem annuntiabimus laudem tuam.",
  ]

  private let englishText = [
    "O God, the heathens are come into thy inheritance: they have defiled thy holy temple: they have made Jerusalem as a place to keep fruit.",
    "They have given the dead bodies of thy servants to be meat for the fowls of the air: the flesh of thy saints for the beasts of the earth.",
    "They have poured out their blood as water, round about Jerusalem: and there was none to bury them.",
    "We are become a reproach to our neighbours: a scorn and derision to them that are round about us.",
    "How long, O Lord, wilt thou be angry for ever: shall thy zeal be kindled like a fire?",
    "Pour out thy wrath upon the nations that have not known thee: and upon the kingdoms that have not called upon thy name.",
    "Because they have devoured Jacob: and have laid waste his place.",
    "Remember not our former iniquities: let thy mercies speedily prevent us, for we are become exceeding poor.",
    "Help us, O God, our saviour: and for the glory of thy name, O Lord, deliver us: and forgive us our sins for thy name's sake.",
    "Lest they should say among the Gentiles: Where is their God? And let there be known among the nations before our eyes,",
    "By the vengeance of the blood of thy servants which hath been shed. Let the sighing of the prisoners come in before thee:",
    "According to the greatness of thy arm, take possession of the children of them that have been put to death.",
    "And render to our neighbours sevenfold in their bosom: the reproach wherewith they have reproached thee, O Lord.",
    "But we thy people, and the sheep of thy pasture, will give thanks to thee for ever:",
    "We will shew forth thy praise, unto generation and generation.",
  ]

  private let lineKeyLemmas = [
    (1, ["deus", "venio", "gens", "hereditas", "polluo", "templum", "sanctus", "pono", "ierusalem", "pomum", "custodia"]),
    (2, ["pono", "morticinum", "servus", "esca", "volatilis", "caelum", "caro", "sanctus", "bestia", "terra"]),
    (3, ["effundo", "sanguis", "aqua", "circuitus", "ierusalem", "sepelio"]),
    (4, ["fio", "opprobrium", "vicinus", "subsannatio", "illusio", "circuitus"]),
    (5, ["usquequo", "dominus", "irascor", "finis", "accendo", "ignis", "zelus"]),
    (6, ["effundo", "ira", "gens", "nosco", "regnum", "nomen", "invoco"]),
    (7, ["comedo", "iacob", "locus", "desolo"]),
    (8, ["memini", "iniquitas", "antiquus", "cito", "anticipo", "misericordia", "pauper", "nimis"]),
    (9, ["adiuvo", "deus", "salutaris", "gloria", "nomen", "dominus", "libero", "propitius", "peccatum", "nomen"]),
    (10, ["forte", "dico", "gens", "deus", "innotesco", "natio", "oculus"]),
    (11, ["ultio", "sanguis", "servus", "effundo", "introeo", "conspectus", "gemitus", "compes"]),
    (12, ["secundum", "magnitudo", "brachium", "possideo", "filius", "mortifico"]),
    (13, ["reddo", "vicinus", "septuplus", "sinus", "improperium", "exprobro", "dominus"]),
    (14, ["populus", "ovis", "pascuum", "confiteor", "saeculum"]),
    (15, ["generatio", "annuntio", "laus"]),
  ]

  private let structuralThemes = [
    (
      "Desecration → Defilement",
      "From temple pollution to corpse desecration",
      ["polluo", "templum", "sanctus", "pono", "ierusalem", "morticinum", "servus", "esca", "volatilis", "caro", "bestia"],
      1,
      2,
      "The enemies have defiled God's holy temple and made Jerusalem desolate, then treated the dead bodies of God's servants as food for birds and beasts.",
      "Augustine sees this as the complete inversion of sacred order - the temple becomes a place of death rather than life, and the bodies of God's servants become carrion. This represents the ultimate desecration of what should be holy (Enarr. Ps. 78.1-2)."
    ),
    (
      "Bloodshed → Shame",
      "From blood poured out to national humiliation",
      ["effundo", "sanguis", "aqua", "circuitu", "sepelio", "opprobrium", "subsannatio", "illusio"],
      3,
      4,
      "The blood of God's servants is poured out like water around Jerusalem with no one to bury them, making the people a reproach to their neighbors.",
      "Augustine interprets the blood like water as a reversal of the life-giving water of baptism and the temple rituals. The shame comes from being unable to properly bury the dead, showing the complete breakdown of social and religious order (Enarr. Ps. 78.3-4)."
    ),
    (
      "Divine Wrath → Judgment",
      "From God's burning anger to call for vengeance on nations",
      ["irascor", "zelus", "ignis", "effundo", "ira", "gens", "nosco", "regnum", "nomen", "invoco"],
      5,
      6,
      "The people ask how long God's anger will burn, then call for Him to pour out His wrath on the nations that don't know Him.",
      "Augustine sees this as the people's recognition that only God's intervention can restore justice. The fire of God's zeal represents His passionate love for His people, and the call for judgment shows their faith in divine retribution (Enarr. Ps. 78.5-6)."
    ),
    (
      "Devastation → Repentance",
      "From Jacob's destruction to plea for mercy",
      ["comedo", "iacob", "locus", "desolo", "memini", "iniquitas", "antiquus", "misericordia", "anticipo", "pauper"],
      7,
      8,
      "The enemies have devoured Jacob and laid waste his place, but the people now plead for God not to remember their former iniquities and to show mercy.",
      "Augustine interprets this as the people's recognition that their suffering is both external (enemy destruction) and internal (their own sin). The plea for mercy shows their repentance and understanding that only God's grace can restore them (Enarr. Ps. 78.7-8)."
    ),
    (
      "Deliverance → Vindication",
      "From plea for help to call for divine retribution",
      ["adiuvo", "salutaris", "gloria", "libero", "propitius", "peccatum", "forte", "dico", "gens", "deus", "innotesco"],
      9,
      10,
      "The people ask for God's help and deliverance, then express concern that the nations might say 'Where is their God?'",
      "Augustine sees this as the people's faith that God will not only deliver them but also vindicate His name before the nations. Their concern about God's reputation shows their understanding of His glory and their role in manifesting it (Enarr. Ps. 78.9-10)."
    ),
    (
      "Vengeance → Justice",
      "From call for blood vengeance to promise of divine retribution",
      ["ultio", "sanguis", "servus", "effundo", "introeo", "conspectus", "gemitus", "compeditor", "secundum", "magnitudo", "brachium", "possideo", "filius", "mortifico"],
      11,
      12,
      "The people call for vengeance for the blood of God's servants and ask that the sighing of prisoners come before God, then ask Him to take possession of the children of the slain according to His great arm.",
      "Augustine interprets this as the people's faith in God's complete justice. The call for vengeance is not personal revenge but divine retribution, and the reference to God's great arm shows their trust in His power to execute perfect judgment (Enarr. Ps. 78.11-12)."
    ),
    (
      "Retribution → Praise",
      "From sevenfold repayment to eternal thanksgiving",
      ["reddo", "vicinus", "septuplus", "sinus", "improperium", "exprobro", "populus", "ovis", "pascuum", "confiteor", "saeculum", "generatio", "annuntio", "laus"],
      13,
      15,
      "The people ask God to render sevenfold the reproach to their neighbors, then affirm their identity as God's flock and promise eternal praise to all generations.",
      "Augustine sees this as the complete resolution - divine justice is executed through sevenfold retribution (perfect justice), and the people respond with eternal praise, showing that their suffering has deepened their relationship with God and their commitment to His glory (Enarr. Ps. 78.13-15)."
    ),
  ]

  private let conceptualThemes = [
    (
      "Divine Sovereignty",
      "God's ultimate authority over all nations and His chosen people",
      ["deus", "dominus", "gloria", "nomen", "brachium", "magnitudo"],
      ThemeCategory.divine,
      nil as ClosedRange<Int>?
    ),
    (
      "Divine Justice",
      "God's righteous judgment and retribution",
      ["ultio", "reddo", "septuplus", "improperium", "exprobro", "ira", "zelus", "ignis"],
      .justice,
      6 ... 13
    ),
    (
      "Righteous Worship",
      "The people's commitment to praise and thanksgiving",
      ["confiteor", "laus", "annuntio", "generatio", "saeculum"],
      .worship,
      14 ... 15
    ),
    (
      "Virtuous Faith",
      "The people's trust in God's deliverance and mercy",
      ["adiuvo", "salutaris", "libero", "propitius", "misericordia", "anticipo"],
      .virtue,
      8 ... 9
    ),
    (
      "Sinful Rebellion",
      "The people's acknowledgment of their former iniquities",
      ["iniquitas", "antiquus", "peccatum", "memini"],
      .sin,
      8 ... 9
    ),
    (
      "Spiritual Conflict",
      "The struggle between God's people and the nations",
      ["gens", "regnum", "nosco", "invoco", "comedo", "desolo"],
      .conflict,
      6 ... 7
    ),
    (
      "Worldly Opposition",
      "The nations' defilement and destruction of God's inheritance",
      ["polluo", "templum", "sanctus", "morticinum", "effundo", "sanguis", "opprobrium", "subsannatio", "illusio"],
      .opposition,
      1 ... 4
    ),
  ]

  func testTotalVerses() {
    XCTAssertEqual(text.count, expectedVerseCount, "Psalm 78 should have \(expectedVerseCount) verses")
    XCTAssertEqual(englishText.count, expectedVerseCount, "Psalm 78 English text should have \(expectedVerseCount) verses")
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

  func testStructuralThemes() {
    utilities.testStructuralThemes(
      psalmText: text,
      structuralThemes: structuralThemes,
      psalmId: id,
      verbose: verbose
    )
  }

  func testConceptualThemes() {
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
      filename: "output_psalm78_themes.json"
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
      filename: "output_psalm78_texts.json"
    )

    if success {
      print("✅ Complete texts JSON created successfully")
    } else {
      print("⚠️ Could not save complete texts file:")
      print(jsonString)
    }
  }
}
