import XCTest
import Foundation
@testable import PsalmProgressTracker
@testable import HoursService
#if canImport(ordo)
@testable import ordo  // Used in Xcode
#else
import LiturgicalService
// (Docker will use the module's original name, e.g., LiturgicalService)
#endif



final class DailyPsalmsProgressTests: XCTestCase {
    var hoursService: HoursService!    
    let verbose :Bool = false
    var tracker: PsalmProgressTracker!
    // Replaces init() for setup
    override func setUp() {
        super.setUp()
        hoursService = HoursService.shared        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test_progress.json")
        tracker = PsalmProgressTracker(savePath: tempURL.path) 
    }

    // Cleanup after each test
    override func tearDown() {
        hoursService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testMondayDuringLent() throws {
        // Arrange
        let dateString = "2025-03-24"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: dateString))
        
        let liturgicalService = TestHelper.getLiturgicalService()
        let liturgicalDay = liturgicalService.getLiturgicalInfo(for: date)
        let winter_or_summer = liturgicalDay.benedictineSeason.description
        // Verify we're in Lent
        XCTAssertEqual(liturgicalDay.season.description, "Lent", "Should be a Lenten weekday")
        
        // Define all canonical hours to test
        let canonicalHours = [
            ("matins", "winter", nil),
            ("lauds", "winter", nil),
            ("prime", winter_or_summer, 3),
            ("terce", winter_or_summer, 3),
            ("sext", "lent", 3),
            ("none", "lent", 3),
            ("vespers", "lent", 4),
            ("compline", "lent", nil)
        ]
        
        var totalPsalms = 0
        var allPsalms: [PsalmUsage] = []
        
        // Act & Assert for each canonical hour
        for (hourKey, season, expectedCount) in canonicalHours {
            guard let psalms = hoursService.getPsalmsForWeekday(
                weekday: liturgicalDay.weekday,
                hourKey: hourKey,
                season: season
            ) else {
                XCTFail("Failed to get psalms for \(hourKey)")
                continue
            }
            
            if let expected = expectedCount {
                XCTAssertEqual(psalms.count, expected, "\(hourKey) psalm count mismatch")
            }
            
            totalPsalms += psalms.count
            allPsalms.append(contentsOf: psalms)
            
            print("\n=== \(hourKey.uppercased()) ===")
            debugPsalms(psalms: psalms)
        }
        
        // Assert total psalms for the day
        print("\n=== SUMMARY ===")
        print("Total psalms prayed: \(totalPsalms)")
        debugPsalms(psalms: allPsalms)
        allPsalms.forEach { psalm in
            guard let number = Int(psalm.number) else {
                XCTFail("Failed to get psalm number")
                return
            }
            tracker.markPsalm(number: number, section: psalm.category, completed: false)
        }
        
        // Verify no duplicate psalms within the same day (if your tradition requires this)
        let psalmIdentifiers = allPsalms.map { psalm -> String in
            if let category = psalm.category {
                return "\(psalm.number)-\(category)"
            }
            return "\(psalm.number)"
        }
        let uniquePsalms = Set(psalmIdentifiers)        
        XCTAssertEqual(uniquePsalms.count, allPsalms.count, "There should be no duplicate psalms in a single day")
        
        // Additional verification for specific psalms expected during Lent
        XCTAssertTrue(allPsalms.contains { Int($0.number) == 50 }, "Psalm 50 (Miserere) should be included during Lent")

        let incompleted = tracker.getIncompletedPsalms()
        XCTAssertTrue(incompleted.count >= 40, "incompleted psalms")
    }


    func testMondayDuringEaster() throws {
        // Arrange
        let dateString = "2025-04-21"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = try XCTUnwrap(formatter.date(from: dateString))
        
        let liturgicalService = TestHelper.getLiturgicalService()
        let liturgicalDay = liturgicalService.getLiturgicalInfo(for: date)
        let winter_or_summer = liturgicalDay.benedictineSeason.description

        // Verify we're in Lent
        XCTAssertEqual(liturgicalDay.season.description, "Pascha", "Should be a Easter weekday")
        
        // Define all canonical hours to test
        let canonicalHours = [
            ("matins", winter_or_summer, nil),
            ("lauds", winter_or_summer, nil),
            ("prime", winter_or_summer, 3),
            ("terce", winter_or_summer, 3),
            ("sext", winter_or_summer, 3),
            ("none", winter_or_summer, 3),
            ("vespers", winter_or_summer, 4),
            ("compline", winter_or_summer, nil)
        ]
        
        var totalPsalms = 0
        var allPsalms: [PsalmUsage] = []
        
        // Act & Assert for each canonical hour
        for (hourKey, season, expectedCount) in canonicalHours {
            guard let psalms = hoursService.getPsalmsForWeekday(
                weekday: liturgicalDay.weekday,
                hourKey: hourKey,
                season: season
            ) else {
                XCTFail("Failed to get psalms for \(hourKey)")
                continue
            }
            
            if let expected = expectedCount {
                XCTAssertEqual(psalms.count, expected, "\(hourKey) psalm count mismatch")
            }
            
            totalPsalms += psalms.count
            allPsalms.append(contentsOf: psalms)
            
            print("\n=== \(hourKey.uppercased()) ===")
            debugPsalms(psalms: psalms)
        }
        
        // Assert total psalms for the day
        print("\n=== SUMMARY ===")
        print("Total psalms prayed: \(totalPsalms)")
        debugPsalms(psalms: allPsalms)
        allPsalms.forEach { psalm in
            guard let number = Int(psalm.number) else {
                XCTFail("Failed to get psalm number")
                return
            }
            tracker.markPsalm(number: number, section: psalm.category, completed: false)
        }
        
        // Verify no duplicate psalms within the same day (if your tradition requires this)
        let psalmIdentifiers = allPsalms.map { psalm -> String in
            if let category = psalm.category {
                return "\(psalm.number)-\(category)"
            }
            return "\(psalm.number)"
        }
        let uniquePsalms = Set(psalmIdentifiers)        
        XCTAssertEqual(uniquePsalms.count, allPsalms.count, "There should be no duplicate psalms in a single day")
        
        // Additional verification for specific psalms expected during Lent
        XCTAssertTrue(allPsalms.contains { Int($0.number) == 50 }, "Psalm 50 (Miserere) should be included during Lent")

        let incompleted = tracker.getIncompletedPsalms()
    }

    private func debugPsalms(psalms: [PsalmUsage]) {
        if verbose {
            psalms.forEach { psalm in
                if let category = psalm.category {
                    print("Psalm \(psalm.number) - \(category)")
                } else {
                    print("Psalm \(psalm.number)")
                }
            }
        }
    }

 
    
}
