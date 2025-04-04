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
    override class func setUp() {
       super.setUp()
       print("✅ Test class initialized")
    }
    private var calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal
    }()
    func testDecember1_2024() throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2024-12-01"))

        let service = TestHelper.getLiturgicalService()
        let liturgicalDay = service.getLiturgicalInfo(for: date)

        // Verify season (1st Sunday of Advent)
        XCTAssertEqual(liturgicalDay.season.description, "Advent")

        // Verify no feast (no sanctoral feast for 12-01 in 6th c.)
        XCTAssertNil(liturgicalDay.feast)

        // Verify weekday (Sunday)
        XCTAssertEqual(liturgicalDay.weekday, "Sunday")
        XCTAssertTrue(liturgicalDay.isSunday)

        // Advent-specific checks
        if case .advent = liturgicalDay.season {
            // Optional: Add Advent-specific checks (e.g., penitential character)
            XCTAssertTrue(true)
        } else {
            XCTFail("Should be Advent")
        }
    }
    func testEaster2025() throws {
        let service = TestHelper.getLiturgicalService()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // Use UTC to avoid timezone issues
        
        // Create date in UTC
        let date = try XCTUnwrap(formatter.date(from: "2025-04-20 12"))
        
        // Get liturgical info
        let liturgicalDay = service.getLiturgicalInfo(for: date)

        // Debug output
        print("Testing date: \(date)")
        print("Season detected: \(liturgicalDay.season.description)")
        
        // Verify season
        XCTAssertEqual(liturgicalDay.season.description, "Pascha", 
                    "Easter Sunday should be in Pascha season")
        
        // Verify feast details
        guard let feast = liturgicalDay.feast else {
            XCTFail("Easter should have a feast")
            return
        }
        
        XCTAssertEqual(feast.name, "Resurrection of the Lord")
        XCTAssertEqual(feast.type, "resurrection")
        XCTAssertEqual(feast.rank, "Solemnity")
        
        // Verify weekday (April 20, 2025 is a Sunday)
        let weekday = Calendar.current.component(.weekday, from: date)
        XCTAssertEqual(weekday, 1, "Easter should fall on a Sunday")
        XCTAssertTrue(liturgicalDay.isSunday)
        
        // Additional Pascha season verification
        if case .pascha = liturgicalDay.season {
            XCTAssertTrue(true) // Confirm correct season
        } else {
            XCTFail("Should be in Pascha season")
        }
    }
 
    
    func testChristmas2025() throws {
        let service = TestHelper.getLiturgicalService()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2025-12-25"))
        let liturgicalDay = service.getLiturgicalInfo(for: date)

        print("Testing date: \(date)")
        print("Season detected: \(liturgicalDay.season.description)")

        XCTAssertEqual(liturgicalDay.season.description, "Christmas")
        XCTAssertNotNil(liturgicalDay.feast)        
        XCTAssertEqual(liturgicalDay.feast?.name, "Nativity of the Lord")
        XCTAssertEqual(liturgicalDay.feast?.type, "nativity")
        XCTAssertEqual(liturgicalDay.feast?.rank, "Solemnity")
    }
    func testMarch24_2025() throws {
        // 2025-03-24 should be a weekday in Lent with no feast
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2025-03-24"))
        let service = TestHelper.getLiturgicalService()

        let liturgicalDay = service.getLiturgicalInfo(for: date)
    
        // Verify season
        XCTAssertEqual(liturgicalDay.season.description, "Lent")
    
        // Verify no feast (no sanctoral feast for this date in 6th century)
        XCTAssertNil(liturgicalDay.feast)
        
        // Verify weekday (Monday in 2025)
        let expectedWeekday = Calendar.current.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
        
        XCTAssertEqual(liturgicalDay.weekday, expectedWeekday) 
        XCTAssertFalse(liturgicalDay.isSunday)
        
        // Additional checks for Lenten characteristics
        if case .lent = liturgicalDay.season {
            // You could add more Lent-specific checks here if needed
            XCTAssertTrue(true) // Just confirming we're in the lent case
        } else {
            XCTFail("Should be in Lent")
        }

        
       
    }
   
     func testMarch23_2025() throws {
        // 2025-03-23 should be a weekday in Lent with no feast
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: "2025-03-23"))
        let service = TestHelper.getLiturgicalService()

        let liturgicalDay = service.getLiturgicalInfo(for: date)
    
        // Verify season
        XCTAssertEqual(liturgicalDay.season.description, "Lent")
    
        // Verify no feast (no sanctoral feast for this date in 6th century)
        XCTAssertNil(liturgicalDay.feast)
        
        XCTAssertTrue(liturgicalDay.isSunday)
        
        // Additional checks for Lenten characteristics
        if case .lent = liturgicalDay.season {
            // You could add more Lent-specific checks here if needed
            XCTAssertTrue(true) // Just confirming we're in the lent case
        } else {
            XCTFail("Should be in Lent")
        }

        
    }
   
  
}
    

