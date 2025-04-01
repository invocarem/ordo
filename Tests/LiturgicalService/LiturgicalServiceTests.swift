import XCTest
import Foundation
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

final class LiturgicalServiceTests: XCTestCase {
    
    func testEasterDateCalculation() throws {
        let service = TestHelper.getLiturgicalService()
        let date = try XCTUnwrap(service.getEaster(year: 2024))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        XCTAssertEqual(formatter.string(from: date), "2024-03-31")
    }
    
    func testChristmasDayLabel() throws {
        let service = LiturgicalService()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2023-12-25"))
        
        XCTAssertTrue(service.getLiturgicalInfo(for: date).contains("Christmas Day"))
    }
    
    func testAshWednesdayDayLabel() throws {
        let service = LiturgicalService()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2025-03-05"))
        XCTAssertTrue(service.getLiturgicalInfo(for: date).contains("Ash Wednesday"))
    }
}