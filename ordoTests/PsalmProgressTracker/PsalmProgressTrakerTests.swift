import XCTest
@testable import PsalmProgressTracker
@testable import PsalmService // For test data

final class PsalmProgressTrackerTests: XCTestCase {
    var tracker: PsalmProgressTracker!
    var psalmService: PsalmService!
    
    override func setUp() {
        tracker = PsalmProgressTracker()
        psalmService = PsalmService.shared // Or initialize mock
    }
    
    // MARK: - Integration Tests
    func testTrackingRealPsalms() throws {
        // 1. Get a real psalm from PsalmService
        let psalm23 = try XCTUnwrap(psalmService.getPsalm(number: 23))
        
        // 2. Verify initial state
        XCTAssertFalse(tracker.isRead(psalm23.number))
        
        // 3. Mark as read
        tracker.markAsRead(psalm23.number)
        
        // 4. Verify tracking
        XCTAssertTrue(tracker.isRead(psalm23.number))
        XCTAssertEqual(tracker.weeklyProgress().read, [23])
    }
    
    func testWeeklyProgressWithRealData() {
        // Simulate reading psalms 23, 95 this week
        tracker.markAsRead(23)
        tracker.markAsRead(95)
        
        let progress = tracker.weeklyProgress()
        XCTAssertEqual(progress.read.sorted(), [23, 95])
    }
    
    // MARK: - Edge Cases
    func testNonExistentPsalmNumber() {
        let invalidNumber = 9999
        XCTAssertFalse(tracker.isRead(invalidNumber))
        
        // Should safely handle non-existent psalms
        tracker.markAsRead(invalidNumber)
        XCTAssertTrue(tracker.isRead(invalidNumber))
    }
}