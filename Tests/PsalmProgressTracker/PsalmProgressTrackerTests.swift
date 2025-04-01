import XCTest
@testable import PsalmProgressTracker
@testable import PsalmService // For test data

final class PsalmProgressTrackerTests: XCTestCase {
    var tracker: PsalmProgressTracker!
    var psalmService: PsalmService!
    
    override func setUp() {
        // Use temporary file for tests
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test_progress.json")
        tracker = PsalmProgressTracker(savePath: tempURL.path)
            
        psalmService = PsalmService.shared // Or initialize mock
    }
    
    
    // MARK: - Integration Tests
    func testTrackingRealPsalms() throws {
        tracker.resetProgress()
        
        // 1. Get a real psalm from PsalmService
        let psalm23 = try XCTUnwrap(psalmService.getPsalm(number: 23))
        
        // 2. Verify initial state
        XCTAssertFalse(tracker.isRead(number: psalm23.number))
        
        // 3. Mark as read
        tracker.markAsRead(number: psalm23.number)
        
        XCTAssertEqual(tracker.progress.count, 1)
        XCTAssertEqual(tracker.progress.first?.number, psalm23.number)
    }
    
    func testWeeklyProgressWithRealData() {
        // Simulate reading psalms 23, 95 this week
        tracker.markAsRead(number: 23)
        tracker.markAsRead(number: 95)
        
        let progress = tracker.weeklyProgress()
        XCTAssertEqual(progress.completed, 2) // Both marked as completed
        XCTAssertEqual(progress.newlyRead, 2) // Both read this week
    }
    
    // MARK: - Edge Cases
    func testNonExistentPsalmNumber() {
        let invalidNumber = 9999
        XCTAssertFalse(tracker.isRead(number: invalidNumber))
        
        // Should safely handle non-existent psalms
        tracker.markAsRead(number: invalidNumber)
        XCTAssertTrue(tracker.isRead(number: invalidNumber))
    }
    func testSectionPsalm118Tracking() {
        let psalmNumber = 118
        tracker.markPsalm(number: psalmNumber, section: "aleph", completed: true)
        tracker.markPsalm(number: psalmNumber, section: "beth", completed: false)
    
        XCTAssertTrue(tracker.isRead(number: psalmNumber, section: "aleph"))
        XCTAssertFalse(tracker.isRead(number: psalmNumber, section: "beth"))
    }
}