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
        guard let prime = prime else {
            XCTFail("Prime hour is nil")
            return
        }
        // Test the structure of the returned Hour object
        XCTAssertFalse(prime.introit.isEmpty)
        // I want hymn to be empty for prime
        XCTAssertTrue(prime.hymn?.isEmpty ?? true)

        // Test Capitulum
        XCTAssertFalse(prime.capitulum.default.isEmpty, "Default capitulum should not be empty")
        XCTAssertNotNil(prime.capitulum.feasts?["pascha"], "Easter capitulum should exist")

        // Test Oratio
        XCTAssertFalse(prime.oratio.default.isEmpty, "Default oratio should not be empty")
        XCTAssertNotNil(prime.oratio.feasts?["pascha"], "Easter oratio should exist")
    
        
        XCTAssertNotNil(prime.psalms.sunday, "Sunday psalms should exist")
        XCTAssertFalse(prime.psalms.sunday!.isEmpty, "Sunday psalms should not be empty")
    }

    func testHoursCompline() {
         let compline = hoursService.getHour(for: "compline")
        XCTAssertNotNil(compline, "Compline hour should exist")
        guard let compline = compline else {
            XCTFail("Compline hour is nil")
            return
        }
        XCTAssertNotNil(compline.psalms.default, "Default psalms should exist")

        guard let firstPsalm = compline.psalms.default?.first else {
            XCTFail("Default psalms array is empty")
            return
        }
    
        // Verify the first psalm is Psalm 4
        XCTAssertEqual(firstPsalm.number, "4", "First psalm of Compline should be Psalm 4")
   
    }
}
