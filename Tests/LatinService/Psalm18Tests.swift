import XCTest
@testable import LatinService

class Psalm18Tests: XCTestCase {
    private var latinService: LatinService!
    let verbose = true
    
    override func setUp() {
        super.setUp()
        latinService = LatinService.shared
    }
    
    // MARK: - Test Data
    let psalm18 = [
        "Caeli enarrant gloriam Dei, et opera manuum ejus annuntiat firmamentum.",
        "Dies diei eructat verbum, et nox nocti indicat scientiam.",
        "Non sunt loquelae, neque sermones, quorum non audiantur voces eorum.",
        "In omnem terram exivit sonus eorum, et in fines orbis terrae verba eorum.",
        "In sole posuit tabernaculum suum; et ipse tamquam sponsus procedens de thalamo suo,",
        "exsultavit ut gigas ad currendam viam.",
        "A summo caelo egressio ejus, et occursus ejus usque ad summum ejus;",
        "nec est qui se abscondat a calore ejus.",
        "Lex Domini immaculata, convertens animas; testimonium Domini fidele, sapientiam praestans parvulis.",
        "Justitiae Domini rectae, laetificantes corda; praeceptum Domini lucidum, illuminans oculos.",
        "Timor Domini sanctus, permanens in saeculum saeculi; judicia Domini vera, justificata in semetipsa.",
        "Desiderabilia super aurum et lapidem pretiosum multum; et dulciora super mel et favum.",
        "Etenim servus tuus custodit ea, in custodiendis illis retributio multa.",
        "Delicta quis intelligit? ab occultis meis munda me;",
        "et ab alienis parce servo tuo. Si mei non fuerint dominati, tunc immaculatus ero,",
        "et emundabor a delicto maximo.",
        "Et erunt ut complaceant eloquia oris mei, et meditatio cordis mei in conspectu tuo semper,",
        "Domine, adjutor meus, et redemptor meus."
    ]
    
    // MARK: - Test Cases
    func testAnalysisSummary() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        if verbose {
            print("\n=== Full Analysis ===")
            print("Total words:", analysis.totalWords)
            print("Unique lemmas:", analysis.uniqueLemmas)
            print("'Domini' forms:", analysis.dictionary["Dominus"]?.forms ?? [:])
        }
        
        XCTAssertGreaterThan(analysis.totalWords, 100)
        XCTAssertGreaterThan(analysis.uniqueLemmas, 50)
    }
    
    func testCosmicImagery() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let cosmicTerms = [
            ("caelum", ["Caeli", "caelo", "caelum"], "heaven"),
            ("firmamentum", ["firmamentum"], "firmament"),
            ("sol", ["sole"], "sun"),
            ("orbis", ["orbis"], "world"),
            ("gigas", ["gigas"], "giant")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: cosmicTerms)
    }
    
    func testDivineRevelation() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let revelationTerms = [
            ("gloria", ["gloriam"], "glory"),
            ("verbum", ["verbum"], "word"),
            ("scientia", ["scientiam"], "knowledge"),
            ("testimonium", ["testimonium"], "testimony"),
            ("judicium", ["judicia"], "judgment")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: revelationTerms)
    }
    
    func testLawAndWisdom() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let lawTerms = [
            ("lex", ["Lex"], "law"),
            ("sapientia", ["sapientiam"], "wisdom"),
            ("justitia", ["Justitiae"], "justice"),
            ("praeceptum", ["praeceptum"], "precept"),
            ("timor", ["Timor"], "fear")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: lawTerms)
    }
    
    func testSensoryImagery() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let sensoryTerms = [
            ("calor", ["calore"], "heat"),
            ("dulcis", ["dulciora"], "sweet"),
            ("mel", ["mel"], "honey"),
            ("favus", ["favum"], "honeycomb"),
            ("lux", ["lucidum"], "light")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: sensoryTerms)
    }
    
    func testHumanResponse() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let responseTerms = [
            ("servus", ["servus", "servo"], "servant"),
            ("meditatio", ["meditatio"], "meditation"),
            ("cor", ["corda", "cordis"], "heart"),
            ("oculus", ["oculos"], "eye"),
            ("redemptor", ["redemptor"], "redeemer")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: responseTerms)
    }
    
    func testMovementVerbs() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let movementVerbs = [
            ("eructo", ["eructat"], "pour forth"),
            ("procedo", ["procedens"], "proceed"),
            ("exsulto", ["exsultavit"], "rejoice"),
            ("curro", ["currendam"], "run"),
            ("egredior", ["egressio"], "go out")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: movementVerbs)
    }
    
    func testPurificationLanguage() {
        let analysis = latinService.analyzePsalm(text: psalm18)
        
        let purificationTerms = [
            ("immaculatus", ["immaculata", "immaculatus"], "blameless"),
            ("emundo", ["emundabor"], "cleanse"),
            ("mundus", ["munda"], "clean"),
            ("delictum", ["Delicta", "delicto"], "sin"),
            ("occultus", ["occultis"], "hidden")
        ]
        
        verifyWordsInAnalysis(analysis, confirmedWords: purificationTerms)
    }
    
    // MARK: - Helper
    private func verifyWordsInAnalysis(_ analysis: PsalmAnalysisResult, confirmedWords: [(lemma: String, forms: [String], translation: String)]) {
        for (lemma, forms, translation) in confirmedWords {
            guard let entry = analysis.dictionary[lemma] else {
                XCTFail("Missing lemma: \(lemma)")
                continue
            }
            
            // Verify semantic domain
            XCTAssertTrue(
                entry.translation?.lowercased().contains(translation.lowercased()) ?? false,
                "\(lemma) should imply '\(translation)', got '\(entry.translation ?? "nil")'"
            )
            
            // Verify morphological coverage
            let missingForms = forms.filter { entry.forms[$0.lowercased()] == nil }
            if !missingForms.isEmpty {
                XCTFail("\(lemma) missing forms: \(missingForms.joined(separator: ", "))")
            }
            
            if verbose {
                print("\n\(lemma.uppercased())")
                print("  Translation: \(entry.translation ?? "?")")
                forms.forEach { form in
                    let count = entry.forms[form.lowercased()] ?? 0
                    print("  \(form.padding(toLength: 12, withPad: " ", startingAt: 0)) – \(count > 0 ? "✅" : "❌")")
                }
            }
        }
    }
}