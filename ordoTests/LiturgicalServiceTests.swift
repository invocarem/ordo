import Testing
import Foundation

@testable import LiturgicalService

@Test 
func testVerification() throws {
    #expect(1 == 2, "TESTS ARE RUNNING! (This is an intentional failure)")
}

@Test 
func easterDateCalculation() throws {
    let service = LiturgicalService()
    let date = try #require(service.getEaster(year: 2024))
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    #expect(formatter.string(from: date) == "2024-03-31")
}

@Test 
func christmasDayLabel() throws {
    let service = LiturgicalService()
    let date = try #require(DateFormatter().date(from: "2023-12-25"))
    #expect(service.getLiturgicalInfo(for: date).contains("Christmas Day"))
}

@Test 
func AshWedDayLabel() throws {
    let service = LiturgicalService()
    let date = try #require(DateFormatter().date(from: "2025-03-05"))
    #expect(service.getLiturgicalInfo(for: date).contains("Ash Wednesday"))
}