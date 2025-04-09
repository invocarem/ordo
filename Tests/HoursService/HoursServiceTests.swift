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
    func testPrimePsalmsForAllDays() {
        let testCases: [(weekday: String, expected: [PsalmUsage])] = [
            ("sunday", [
                PsalmUsage(number: "118", category: "aleph"),
                PsalmUsage(number: "118", category: "beth"),
                PsalmUsage(number: "118", category: "gimel"),
                PsalmUsage(number: "118", category: "daleth")
            ]),
            ("monday", [
                PsalmUsage(number: "1", category: ""),
                PsalmUsage(number: "2", category: ""),
                PsalmUsage(number: "6", category: "")
            ]),
            ("tuesday", [
                PsalmUsage(number: "7", category: ""),
                PsalmUsage(number: "8", category: ""),
                PsalmUsage(number: "9", category: "A")
            ]),
            ("wednesday", [
                PsalmUsage(number: "9", category: "B"),
                PsalmUsage(number: "10", category: ""),
                PsalmUsage(number: "11", category: "")
            ]),
            ("thursday", [
                PsalmUsage(number: "12", category: ""),
                PsalmUsage(number: "13", category: ""),
                PsalmUsage(number: "14", category: "")
            ]),
            ("friday", [
                PsalmUsage(number: "15", category: ""),
                PsalmUsage(number: "16", category: ""),
                PsalmUsage(number: "17", category: "A")
            ]),
            ("saturday", [
                PsalmUsage(number: "17", category: "B"),
                PsalmUsage(number: "18", category: ""),
                PsalmUsage(number: "19", category: "")
            ])
        ]
        
        for testCase in testCases {
            guard let psalms = hoursService.getPsalmsForWeekday(weekday: testCase.weekday, 
                                            hourKey: "prime", 
                                            season: "lent") else {
                XCTFail("Failed to get psalms for Prime on \(testCase.weekday)")
                continue
            }
            
            XCTAssertEqual(psalms.count, testCase.expected.count,
                        "Psalm count mismatch for \(testCase.weekday)")
            
            for (index, psalm) in psalms.enumerated() {
                XCTAssertEqual(psalm.number, testCase.expected[index].number,
                            "Number mismatch for \(testCase.weekday) at index \(index)")
                XCTAssertEqual(psalm.category ?? "", testCase.expected[index].category,
                            "Category mismatch for \(testCase.weekday) at index \(index)")
            }
        }
    }
    func testPsalm118_18Sections() {
        let expectedSectionIdentifiers = [
            "Aleph", "Beth", "Gimel", "Daleth", "He", "Vau", "Zain", "Heth",
            "Teth", "Jod", "Caph", "Lamed", "Mem", "Nun", "Samech", "Ain",
            "Pe", "Sade", "Coph", "Res", "Sin", "Thau"
        ]
        let numbers = ["118", "118", "118"]
        // Expected sections by hour and day
        let expectedSectionsSunday = [
            // Sunday
            "terce": Array(expectedSectionIdentifiers[4..<7]),  // Heth, Teth, Jod
            "sext": Array(expectedSectionIdentifiers[7..<10]),   
            "none": Array(expectedSectionIdentifiers[10..<13]),  
        ]
        let expectedSectionsMonday = [
            // Monday
            "terce": Array(expectedSectionIdentifiers[13..<16]), 
            "sext": Array(expectedSectionIdentifiers[16..<19]),  
            "none": Array(expectedSectionIdentifiers[19..<22])  
        ]
       // Test Sunday
        for hour in ["terce", "sext", "none"] {
            let expected = expectedSectionsSunday[hour]!
            verifyPsalmSections(weekday: "sunday", 
                            hourKey: hour,
                            expectedNumbers: numbers,
                            expectedCategories: expected)
        }
        
        // Test Monday
        for hour in ["terce", "sext", "none"] {
            let expected = expectedSectionsMonday[hour]!
            verifyPsalmSections(weekday: "monday",
                            hourKey: hour,
                            expectedNumbers: numbers,
                            expectedCategories: expected)
        }
    }
    func testTuesdayPsalmsOfDegrees() {
    // Define expected psalms for each hour
    let expectedPsalms = [
        "terce": (numbers: ["119", "120", "121"], categories: ["", "", ""]),
        "sext": (numbers: ["122", "123", "124"], categories: ["", "", ""]),
        "none": (numbers: ["125", "126", "127"], categories: ["", "", ""]),
        "vespers": (numbers: ["128", "129", "130", "131", "132"], categories: ["", "", "", "", ""])
    ]
    
    // Test each hour
    for hour in ["terce", "sext", "none", "vespers"] {
        let expected = expectedPsalms[hour]!
        verifyPsalmSections(
            weekday: "tuesday",
            hourKey: hour,
            expectedNumbers: expected.numbers,
            expectedCategories: expected.categories
        )
    }
}


func testVespersPsalms() {
    let expectedPsalms = [
        "sunday": ["109", "110", "111", "112"],
        "monday": ["113", "114", "115", "116", "128"],
        "wednesday": ["134", "135", "136", "137"],
        "thursday": ["138", "138", "139", "140"],
        "friday": ["141", "143", "143", "144"],
        "saturday": ["144", "145", "146", "147"]
    ]
    let expectedCategories = [
        "sunday": ["", "", "", ""],
        "monday": ["full", "", "", "", ""],
        "wednesday": ["", "", "", ""],
        "thursday": ["A", "B", "", ""],
        "friday": ["", "A", "B", "A"],
        "saturday": ["b", "", "", ""]
    ]
    
    for (weekday, expected) in expectedPsalms {
        verifyPsalmSections(
            weekday: weekday,
            hourKey: "vespers",
            expectedNumbers: expected,
            expectedCategories: expectedCategories[weekday] ?? []
        )
    }
}

    func testMondayLaudsPsalmsSummer() {
        let expectedPsalms = [ "66","50", "5", "42", "148", "149", "150"]    
        let season = "summer"
            guard let psalms = hoursService.getPsalmsForWeekday(weekday: "monday", 
                                            hourKey: "lauds", 
                                            season: season) else {
                XCTFail("Missing Monday Lauds psalms (\(season))")
                return
            }
            XCTAssertEqual(
                psalms.map { $0.number },
                expectedPsalms,
                "Monday Lauds psalms incorrect (\(season)). Got: \(psalms.map { $0.number })"
            )
        }
    
    func testMondayLaudsPsalmsWinter() {
        let expectedPsalms = ["66","50",  "62", "Canticle", "148", "149", "150"]    
        let season = "winter"
        guard let psalms = hoursService.getPsalmsForWeekday(weekday: "monday", 
                                        hourKey: "lauds", 
                                        season: season) else {
            XCTFail("Missing Monday Lauds psalms (\(season))")
            return
        }
        XCTAssertEqual(
            psalms.map { $0.number },
            expectedPsalms,
            "Monday Lauds psalms incorrect (\(season)). Got: \(psalms.map { $0.number })"
        )
    }
    func testFridayLauds() {
        // 1. Define the expected psalm sequence for Friday Lauds
        let expectedPsalms = ["66", "50", "75", "99", "148", "149", "150"]
        
        // 2. Test across all seasons (winter/summer/Lent/Easter)
        let seasons = ["winter", "summer"]
        
        for season in seasons {
            guard let psalms = hoursService.getPsalmsForWeekday(weekday: "friday", 
                                            hourKey: "lauds", 
                                            season: season) else {
                XCTFail("Failed to get Friday Lauds psalms for season: \(season)")
                continue
            }
            
            // 3. Verify the exact psalm sequence
            XCTAssertEqual(
                psalms.map { $0.number },
                expectedPsalms,
                """
                Incorrect Friday Lauds psalms (\(season)).
                Expected: \(expectedPsalms)
                Actual: \(psalms.map { $0.number })
                """
            )
            
            // 4. Explicitly confirm Psalm 75 is present
            XCTAssertTrue(
                psalms.contains { $0.number == "75" },
                "Psalm 75 missing in Friday Lauds (\(season))"
            )
            
        }
    }

    private func verifyPsalmSections(weekday: String, hourKey: String, expectedNumbers: [String], expectedCategories: [String]) {        
        guard let psalms = hoursService.getPsalmsForWeekday(weekday: weekday, hourKey: hourKey, season: "winter") else {
            XCTFail("Failed to get psalms for \(weekday) \(hourKey)")
            return
        }
        //print("\(psalms)")

        let actualNumbers = psalms.map { $0.number }
        XCTAssertEqual(actualNumbers, expectedNumbers,
                 "Psalm number mismatch for \(weekday) \(hourKey)")

        let actualCategories = psalms.compactMap { ($0.category ?? "").lowercased() }
        let expectedLowercased = expectedCategories.map { $0.lowercased() }
        
        XCTAssertEqual(actualCategories, expectedLowercased,
                    "Psalm category mismatch for \(weekday) \(hourKey)")
        
    }
    

   func testCompline() {
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
    guard let psalms = hoursService.getPsalmsForWeekday(weekday: weekday, 
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
    guard let psalms = hoursService.getPsalmsForWeekday(weekday: weekday, 
                                            hourKey: hourKey, 
                                            season: season) else {
        XCTFail("Failed to get psalms for Sext on Sunday")
        return
    }
    
    // Then
    let expectedPsalms = [
        PsalmUsage(number: "118", category: "heth"),
        PsalmUsage(number: "118", category: "teth"),
        PsalmUsage(number: "118", category: "jod")
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
    guard let psalms = hoursService.getPsalmsForWeekday(weekday: weekday, 
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
    func testSundaySummerLaud() {
        let psalms = hoursService.getPsalmsForWeekday(weekday: "sunday", hourKey: "lauds", season: "summer")
        let expectedNumbers = ["66", "50", "117", "62", "148", "149", "150"]
        XCTAssertEqual(psalms?.map { $0.number }, expectedNumbers)
    }

    func testWeekdaySummerMatin() {
        let psalms = hoursService.getPsalmsForWeekday(weekday: "tuesday", hourKey: "matins", season: "summer")
        let expectedNumbers = ["3", "94", "100", "62", "66", "5"]
        XCTAssertEqual(psalms?.map { $0.number }, expectedNumbers)
    }

    func testSundaySummerMatin() {
        let psalms = hoursService.getPsalmsForWeekday(weekday: "sunday", hourKey: "matins", season: "summer")
        let expectedNumbers = ["3", "94", "100", "62", "66", "5", "35", "42", "56", "6", "24", "25"]
        XCTAssertEqual(psalms?.map { $0.number }, expectedNumbers)
    }
    func testSundayWinterMatin() {
        let psalms = hoursService.getPsalmsForWeekday(weekday: "sunday", hourKey: "matins", season: "winter")        
        let expectedNumbers = ["3", "94", "100", "62", "5", "35", "42", "56", "6", "24", "25", "28"]
        XCTAssertEqual(psalms?.map { $0.number }, expectedNumbers)
    }

}
