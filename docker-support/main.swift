// docker-support/main.swift
import Foundation
import LiturgicalService
import PsalmService
import HoursService

// Direct top-level code
let service = LiturgicalService()
let psalm_service = PsalmService.shared
let hours_service = HoursService.shared

let date: Date
if CommandLine.arguments.count > 1, 
   let inputDate = parseDate(CommandLine.arguments[1]) {
    date = inputDate
} else {
    date = Date()
}

// 2. Get and print liturgical info

print(service.getLiturgicalInfo(for: date))

// Safely get the psalm
guard let psalmAleph = psalm_service.getPsalm(number: 118, section: "Aleph") else {
    print("Psalm 118 Aleph not found")
    exit(1)
}

// Print with formatting
print("""
=== Psalm 118:Aleph ===
\(psalmAleph.text.joined(separator: "\n"))
""")


/*
let psalmKeys = service.getPsalmsForPrime(for: date)

print("Psalms: \(psalmKeys)")
 for key in psalmKeys {
    let psalmText = service.getPsalmText(for: key)  
    print(psalmText)
    
}
*/
// Helper function to parse date strings
func parseDate(_ string: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" // ISO format
    formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
    return formatter.date(from: string)
}