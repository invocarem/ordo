
import XCTest
@testable import HoursService

final class HoursServiceTests: XCTestCase {
    var hoursService: HoursService!

    // Replaces init() for setup
    override func setUp() {
        super.setUp()
        hoursService = HoursService.shared
    }

    // Cleanup after each test
    override func tearDown() {
        hoursService = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func testVerify() {
        XCTAssertEqual(1, 2, "intended to fail")
    }
    
    func testHoursAreLoaded() {
        let prime = hoursService.getHour(for: "prime")
        XCTAssertNotNil(prime, "Prime hour should exist")
        
        // Test the structure of the returned Hour object
        XCTAssertFalse(prime!.introit.isEmpty)
        XCTAssertFalse(prime!.hymn.isEmpty)
        XCTAssertFalse(prime!.chapter.isEmpty)
        XCTAssertFalse(prime!.closing.isEmpty)
        
        // Test psalm rules structure
        XCTAssertFalse(prime!.psalms.sunday.isEmpty, "sunday of psalms should exist")        
    }
    
}