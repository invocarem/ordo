import XCTest
import Foundation

@testable import HoursService
#if canImport(ordo)
@testable import ordo  // Used in Xcode
#else
import LiturgicalService
// (Docker will use the module's original name, e.g., LiturgicalService)
#endif

final class TestHelper {
    static func getLiturgicalService() -> LiturgicalService {
        #if canImport(ordo)
            return LiturgicalService() // From @testable import ordo
        #else
            return LiturgicalService() // From import LiturgicalService
        #endif
    }
}

final class DailyPrayerFlowTests: XCTestCase {
    var hoursService: HoursService!    
    let verbose :Bool = false
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

    func testPrayPrimeSteps() throws {
         // 2025-03-24 should be a weekday in Lent with no feast
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2025-03-24"))
        let service = TestHelper.getLiturgicalService()

        let liturgicalDay = service.getLiturgicalInfo(for: date)
          
        XCTAssertEqual(liturgicalDay.season.description, "Lent")
    }

}
