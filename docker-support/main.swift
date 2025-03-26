// docker-support/main.swift
import Foundation
import LiturgicalService

// Direct top-level code
let service = LiturgicalService()


let date: Date
if CommandLine.arguments.count > 1, 
   let inputDate = parseDate(CommandLine.arguments[1]) {
    date = inputDate
} else {
    date = Date()
}

// 2. Get and print liturgical info

print(service.getLiturgicalInfo(for: date))

let psalmKeys = service.getPsalmsForPrime(for: date)

print("Psalms: \(psalmKeys)")
 for key in psalmKeys {
    let psalmText = service.getPsalmText(for: key)  
    print(psalmText)
    
}

// Helper function to parse date strings
func parseDate(_ string: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd" // ISO format
    formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
    return formatter.date(from: string)
}