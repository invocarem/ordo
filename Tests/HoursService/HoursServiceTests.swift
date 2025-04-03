import XCTest

@testable import HoursService

final class HoursServiceTests: XCTestCase {
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
    
    }

   func testComplinePsalms() {
    // 1. Get the Compline hour
    guard let compline = hoursService.getHour(for: "compline") else {
        XCTFail("Compline hour should exist in the service")
        return
    }
    
    // 2. Verify the default psalms
    guard let defaultPsalms = compline.psalms.default else {
        XCTFail("Compline should have default psalms")
        return
    }
    
    // 3. Check the expected psalms (4, 90, 133) from horas.json
    let expectedPsalmNumbers = ["4", "90", "133"]
    let actualPsalmNumbers = defaultPsalms.map { $0.number }
    
    XCTAssertEqual(actualPsalmNumbers, expectedPsalmNumbers,
                 "Compline default psalms should be 4, 90, 133. Got: \(actualPsalmNumbers)")
}


    func testNonePsalmsOnApril2_2025() {
       // 1. Define test inputs - Wednesday should use default psalms
    let weekday = "wednesday"  // April 2, 2025 is a Wednesday
    let hourKey = "none"
    let season = "lent"
    
    // 2. Fetch the psalms
    guard let psalms = hoursService.getPsalmsForWeekday(weekday, 
                                                  hourKey: hourKey, 
                                                  season: season) else {
        XCTFail("Failed to get psalms for None on Wednesday")
        return
    }
    
    // 3. Verify the expected psalm numbers (should use default psalms)
    let expectedPsalmNumbers = ["125", "126", "127"]
    let actualPsalmNumbers = psalms.map { $0.number }
    
    XCTAssertEqual(actualPsalmNumbers, expectedPsalmNumbers,
                 "Incorrect psalms for None on Wednesday. Expected: \(expectedPsalmNumbers), Got: \(actualPsalmNumbers)")

                      // expected for sunday
                      //let expectedPsalmsNone1 = ["118 (caph)", "118 (lamed)", "118 (mem)"]
    }

    func testSextPsalmsOnSunday() {
    // Given
    let weekday = "sunday"
    let hourKey = "sext"
    let season = "lent"
    
    // When
    guard let psalms = hoursService.getPsalmsForWeekday(weekday, 
                                            hourKey: hourKey, 
                                            season: season) else {
        XCTFail("Failed to get psalms for Sext on Sunday")
        return
    }
    
    // Then
    let expectedPsalms = [
        PsalmUsage(number: "118", category: "heth"),
        PsalmUsage(number: "118", category: "teth"),
        PsalmUsage(number: "118", category: "iod")
    ]
    
    // More detailed assertion
    XCTAssertEqual(psalms.count, expectedPsalms.count, 
                 "Incorrect number of psalms. Expected: \(expectedPsalms.count), Got: \(psalms.count)")
    
    for (index, (actual, expected)) in zip(psalms, expectedPsalms).enumerated() {
        XCTAssertEqual(actual.number, expected.number,
                     "Psalm \(index + 1) number mismatch. Expected: \(expected.number), Got: \(actual.number)")
        XCTAssertEqual(actual.category, expected.category,
                     "Psalm \(index + 1) category mismatch. Expected: \(expected.category ?? "nil"), Got: \(actual.category ?? "nil")")
    }
}

func testMatinsPsalmsInWinter() {
    // Given
    let weekday = "sunday"  // Sunday has the most psalms in the office
    let hourKey = "matins"
    let season = "winter"
    
    // When
    guard let psalms = hoursService.getPsalmsForWeekday(weekday, 
                                            hourKey: hourKey, 
                                            season: season) else {
        XCTFail("Failed to get psalms for Matins in winter")
        return
    }
    
    // Debug output
    if(verbose) {
        print("Actual psalms for Sunday Matins in Winter:")
        psalms.forEach {
            if let category = $0.category {
                print("Psalm \($0.number) - Category: \(category)")
            } else {
                print("Psalm \($0.number)")
            }
        }
    }
    
    // Then
    // 1. Verify we have 12 psalms for Sunday Matins in winter
    XCTAssertEqual(psalms.count, 12, 
                 "Sunday Matins in winter should have 12 psalms. Got: \(psalms.count)")




    }

    func testCanticleSundayMatinsInSummer() {
    let hour = HoursService.shared.getHour(for: "matins")
    let canticle = hour?.canticle
    
    // Verify canticle exists
    XCTAssertNotNil(canticle)
    
    // Verify number of verses
    XCTAssertEqual(canticle?.verses?.count, 3) // Should have 3 canticle verses (RB 11)
    
    // Verify content of verses
    XCTAssertEqual(canticle?.verses?[0], "Benedicite, omnia opera Domini, Domino...")
    XCTAssertEqual(canticle?.verses?[1], "Benedicite, angeli Domini, Domino...") 
    XCTAssertEqual(canticle?.verses?[2], "Laudate Dominum de caelis")
}

    func testSundayMatinsInSummer() {
    // Given
    let weekday = "sunday"
    let hourKey = "matins"
    let season = "summer"
    
    // When
    guard let psalms = hoursService.getPsalmsForWeekday(weekday, 
                                             hourKey: hourKey, 
                                             season: season) else {
        XCTFail("Sunday Matins in summer should exist")
        return
    }
    
    // Then
    // 1. Verify 12 psalms for the night office
    XCTAssertEqual(psalms.count, 12, 
                 "Sunday Matins in summer should have 12 psalms according to RB 10. Got: \(psalms.count)")


                     
    

}
}

