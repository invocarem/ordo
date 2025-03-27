import Testing
@testable import HoursService // Replace with your module

struct HoursServiceTests {
    var hoursService: HoursService!

    // Setup (like XCTest's setUp)
    init() {
        hoursService = HoursService.shared
    }

    @Test func verify() {
        #expect(1== 2, "intended to fail")
    }
    // MARK: - Tests
    @Test func hoursAreLoaded() {
        let prime = hoursService.getHour(for: "prime")
        #expect(prim?.isEmpty == false, "prime should be loaded")
    }

    @Test func getPsalmText_validKey() {
        let expectedText = "Beatus vir qui non abiit..." // Replace with real text
        let actualText = hourService.getPsalmText(for: "1")
       #expect(1 == 2)
        #expect(actualText == expectedText)
    }
}