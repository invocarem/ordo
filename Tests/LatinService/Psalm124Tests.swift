import XCTest
@testable import LatinService

class Psalm124Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true

    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }

    let id = PsalmIdentity(number: 124, category: "")

    let psalm124 = [
        "Qui confidunt in Domino, sicut mons Sion: non commovebitur in aeternum, qui habitat in Jerusalem.",
        "Montes in circuitu ejus, et Dominus in circuitu populi sui, ex hoc nunc et usque in saeculum.",
        "Quia non relinquet Dominus virgam peccatorum super sortem justorum, ut non extendant justi ad iniquitatem manus suas.",
        "Benefac, Domine, bonis, et rectis corde.",
        "Declinantes autem in obligationes, adducet Dominus cum operantibus iniquitatem. Pax super Israel!"
    ]

    func testSteadfastTrust() {
        let text = psalm124[0]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 1)
        let terms = [
            ("confido", ["confidunt"], "trust"),
            ("commoveo", ["commovebitur"], "move"),
            ("mons", ["mons"], "mountain"),
            ("sion", ["sion"], "zion"),
            ("habito", ["habitat"], "dwell")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testProtectiveEncirclement() {
        let text = psalm124[1]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 2)
        let terms = [
            ("mons", ["montes"], "mountain"),
            ("circuitus", ["circuitu"], "surrouding"),
            ("populus", ["populi"], "people"),
            ("saeculum", ["saeculum"], "eternity")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testMoralSafeguard() {
        let text = psalm124[2]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 3)
        let terms = [
            ("relinquo", ["relinquet"], "leave"),
            ("virga", ["virgam"], "rod"),
            ("peccator", ["peccatorum"], "sinner"),
            ("justus", ["justorum", "justi"], "righteous"),
            ("iniquitas", ["iniquitatem"], "iniquity"),
            ("manus", ["manus"], "hand")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testPrayerForTheRighteous() {
        let text = psalm124[3]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 4)
        let terms = [
            ("benefacio", ["Benefac"], "do good"),
            ("bonus", ["bonis"], "good"),
            ("rectus", ["rectis"], "upright"),
            ("cor", ["corde"], "heart")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    func testJudgmentAndPeace() {
        let text = psalm124[4]
        let analysis = latinService.analyzePsalm(id, text: text, startingLineNumber: 5)
        let terms = [
            ("declino", ["Declinantes"], "turn aside"),
            ("obligatio", ["obligationes"], "bond"),
            ("adduco", ["adducet"], "lead"),
            ("opero", ["operantibus"], "do"),
            ("iniquitas", ["iniquitatem"], "iniquity"),
            ("pax", ["Pax"], "peace")
        ]
        verifyWordsInAnalysis(analysis, confirmedWords: terms)
    }

    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 15, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}
