import Testing
import Foundation
#if canImport(ordo)
  @testable import ordo  // Used in Xcode
#else
  import LiturgicalService
  // (Docker will use the module's original name, e.g., LiturgicalService)
#endif

struct TestHelper {
    static func getLiturgicalService() -> LiturgicalService {
        #if canImport(ordo)
            return LiturgicalService() // From @testable import ordo
        #else
            return LiturgicalService() // From import LiturgicalService
        #endif
    }
}

//T @testable import ordo

@Test 
func testVerification() throws {
    #expect(1 == 2, "TESTS ARE RUNNING! (This is an intentional failure)")
}

@Test 
func easterDateCalculation() throws {
    let service = TestHelper.getLiturgicalService()
    let date = try #require(service.getEaster(year: 2024))
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    #expect(formatter.string(from: date) == "2024-03-31")
}

@Test 
func christmasDayLabel() throws {
    let service = LiturgicalService()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let date = try #require(formatter.date(from: "2023-12-25"))
    
    #expect(service.getLiturgicalInfo(for: date).contains("Christmas Day"))
}

@Test 
func AshWedDayLabel() throws {
    let service = LiturgicalService()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let date = try #require(formatter.date(from: "2025-03-05"))
    #expect(service.getLiturgicalInfo(for: date).contains("Ash Wednesday"))
}
