
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
        XCTAssertNotEqual(1, 2, "1 is not 2")
    }
    
    func testHoursAreLoaded() {
        let prime = hoursService.getHour(for: "prime")
        XCTAssertNotNil(prime, "Prime hour should exist")
        
        // Test the structure of the returned Hour object
        XCTAssertFalse(prime!.introit.isEmpty)
        XCTAssertFalse(prime!.hymn.isEmpty)
        XCTAssertFalse(prime!.capitulum.isEmpty)
        XCTAssertFalse(prime!.oratio.isEmpty)
        
        // Test psalm rules structure
        XCTAssertFalse(prime!.psalms.sunday.isEmpty, "sunday of psalms should exist")        
    }
    
}