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
    
    func testGetPsalms_multipleSections() {
        let psalm9Sections = psalmService.getPsalms(number: 9)
        XCTAssertEqual(psalm9Sections.count, 2, "Psalm 9 should have A and B sections")
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