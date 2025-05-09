import XCTest
@testable import PsalmService

final class PsalmServiceTests: XCTestCase {
    private var psalmService: PsalmService!
    
    override func setUp() {
        super.setUp()
        psalmService = PsalmService.shared
    }
    
    override func tearDown() {
        psalmService = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testPsalmsAreLoaded() {
        let allPsalms = psalmService.getAllPsalms()
        XCTAssertFalse(allPsalms.isEmpty, "Should have loaded psalms")
    }
    func testGetTotalPsalmCount() {
        let totalCount = psalmService.getTotalPsalmCount()        
        let verifiedCount = psalmService.getVerifiedPsalmCount()
        XCTAssertTrue(verifiedCount > 50, "verified  count large than 50 \(verifiedCount)")
        XCTAssertTrue(totalCount > 150, "total Count large than 150 \(totalCount)")
        
        
    }
    
    func testAllPsalmsVerseCountsAndVerification() {
        (1...150).forEach { number in
            let psalmSections = psalmService.getPsalms(number: number)
            
            guard !psalmSections.isEmpty else {
                XCTFail("Missing psalm \(number) - no entry found")
                return
            }
            
            psalmSections.forEach { psalm in
                let sectionInfo = psalm.section.map { " section \($0)" } ?? ""
                let psalmIdentifier = "Psalm \(number)\(sectionInfo)"
                
                // 1. Check verification status
                XCTAssertTrue(psalm.verified ?? false, "\(psalmIdentifier) should be verified")
                
                // 2. Check English text exists
                guard let englishText = psalm.englishText else {
                    XCTFail("\(psalmIdentifier) is missing English translation")
                    return
                }
                
                // 3. Check verse counts match
                XCTAssertEqual(psalm.text.count, englishText.count,
                            "\(psalmIdentifier) has mismatched verse counts (\(psalm.text.count) vs \(englishText.count))")
                
            }
        }
    }
    
 
    func testPsalm50VerseCountsMatch() {
        // Get Psalm 50
        let psalm50 = psalmService.getPsalm(number: 50)
        XCTAssertNotNil(psalm50, "Psalm 50 should exist")
        
        // Unwrap the optional properties
        guard let psalm = psalm50 else { return }
        guard let englishText = psalm.englishText else {
            XCTFail("Psalm 50 should have englishText")
            return
        }
        
        // Check that both arrays have the same count
        XCTAssertEqual(psalm.text.count, englishText.count, 
                    "Psalm 50 should have the same number of verses in text and englishText")
        
    
    
    }
 
    func testGetPsalm_validNumber() {
        let psalm1 = psalmService.getPsalm(number: 1)
        XCTAssertNotNil(psalm1, "Psalm 1 should exist")
        XCTAssertFalse(psalm1!.text.isEmpty, "Psalm 1 should have verses")
    }
    
    func testGetPsalm_withSection() {
        let psalm118Aleph = psalmService.getPsalm(number: 118, section: "Aleph")
        XCTAssertNotNil(psalm118Aleph, "Psalm 118 Aleph should exist")
        XCTAssertFalse(psalm118Aleph!.text.isEmpty, "Psalm 118 Aleph should have verses")
    }
    
    func testGetPsalm_invalidNumber() {
        let psalm999 = psalmService.getPsalm(number: 999)
        XCTAssertNil(psalm999, "Non-existent psalm should return nil")
    }
    
    func testGetPsalm_noSections() {
        let psalm15 = psalmService.getPsalm(number: 15)
        XCTAssertNotNil(psalm15, "Psalm 15 should no sections")
    }
     func testGetPsalms_multipleSections() {
        let psalm9Sections = psalmService.getPsalms(number: 9)
        XCTAssertEqual(psalm9Sections.count, 2, "Psalm 9 should have A and B sections")
    }
     func testGetPsalms_multipleSectionsPsalm17() {
        let psalm1Sections = psalmService.getPsalms(number: 1)
        XCTAssertEqual(psalm1Sections.count, 1, "Psalm 1 have one section")

        let psalm17Sections = psalmService.getPsalms(number: 17)
        XCTAssertEqual(psalm17Sections.count, 2, "Psalm 17 should have A and B sections")

        let sectionA = psalm17Sections.first { $0.section == "A" }
        let sectionB = psalm17Sections.first { $0.section == "B" }
    
        XCTAssertNotNil(sectionA, "Missing Psalm 17A")
        XCTAssertNotNil(sectionB, "Missing Psalm 17B")
        if let psalm17A = sectionA, let psalm17B = sectionB {        
            XCTAssertFalse(psalm17A.text.isEmpty, "Psalm 17A has empty text")
            XCTAssertFalse(psalm17B.text.isEmpty, "Psalm 17B has empty text")
        
            XCTAssertNotEqual(psalm17A.text.first, psalm17B.text.first,
                         "First verses should differ between sections")
                         
            // Print a few verses from each section
            print("\nSample from Psalm 17A:")
            psalm17A.text.prefix(3).forEach { print($0) }
        
            print("\nSample from Psalm 17B:")
            psalm17B.text.prefix(3).forEach { print($0) }           
        }
    }
    func testGetPsalms_multipleSectionsPsalm118() {
        let sections = psalmService.getPsalms(number: 118)
        
        // Test total number of sections (22)
        XCTAssertEqual(sections.count, 22, "Psalm 118 should have 22 sections (8 verses each)")
        
        // Test each section has exactly 8 verses
        for section in sections {
            XCTAssertEqual(section.text.count, 8, "Each section should have exactly 8 verses")
        }
        
        // Test section names (Douay-Rheims style)
        let expectedSectionIdentifiers = [
            "aleph", "beth", "gimel", "daleth", "He", "Vau", "Zain", "Heth",
            "Teth", "Jod", "Caph", "Lamed", "Mem", "Nun", "Samech", "Ain",
            "Pe", "Sade", "Coph", "Res", "Sin", "Thau"
        ]
        
        for (index, section) in sections.enumerated() {
            XCTAssertEqual(section.section?.lowercased() ?? "", expectedSectionIdentifiers[index].lowercased(), 
                        "Section \(index) should be \(expectedSectionIdentifiers[index])")
        }
    }

 
    func testGetPsalms_psalmsOfDegrees() {
        [119, 120, 128, 133].forEach { psalmNumber in
            let sections = psalmService.getPsalms(number: psalmNumber)
    
            // Basic checks
            XCTAssertGreaterThanOrEqual(sections.count, 1, "Psalm \(psalmNumber) should have at least 1 section")
    
    
            if let firstVerse = sections.first?.text.first {
                XCTAssertFalse(firstVerse.isEmpty, "Psalm \(psalmNumber) should have non-empty text")
            }
        }
    }   

 

    func testGetFormattedText_validPsalm() {
        let formattedText = psalmService.getFormattedText(number: 1)
        XCTAssertNotNil(formattedText)
        XCTAssertTrue(formattedText!.contains("\n"), "Formatted text should contain newlines")
    }
    
    func testGetAllPsalms_containsExpectedPsalms() {
        let allPsalms = psalmService.getAllPsalms()
        let psalmNumbers = allPsalms.map { $0.number }
        XCTAssertTrue(psalmNumbers.contains(1), "Should contain Psalm 1")
        XCTAssertTrue(psalmNumbers.contains(118), "Should contain Psalm 118")
    }
    
    // Performance test
    func testPerformanceGetPsalm() {
        measure {
            _ = psalmService.getPsalm(number: 1)
        }
    }
}