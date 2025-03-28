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

let info = service.getLiturgicalInfo(for: date) 
print(info)

guard let weekday_info = extractWeekday(from: info) else {
    print ("could not determin weekday from LiturgicalInfo")
    fatalError()
}


if let hour = HoursService.shared.getHour(for: "prime") {
    print(hour.introit)
    print(hour.hymn)

    // Get today's weekday or specify one
    let weekday = weekday_info
    
    // Get the psalms for the specified day
    let psalms: [PsalmUsage]
    switch weekday.lowercased() {
    case "sunday": psalms = hour.psalms.sunday
    case "monday": psalms = hour.psalms.monday
    case "tuesday": psalms = hour.psalms.tuesday
    case "wednesday": psalms = hour.psalms.wednesday
    case "thursday": psalms = hour.psalms.thursday
    case "friday": psalms = hour.psalms.friday
    case "saturday": psalms = hour.psalms.saturday
    default: psalms = []
    }
    
    // Print each psalm
    for psalm in psalms {
        print("Psalm \(psalm.number)", terminator: "")
        
        if let category = psalm.category, !category.isEmpty {
            print(" (\(category))", terminator: "")
        }

        if let startVerse = psalm.startVerse, startVerse != 1 {
            print(" starting at verse \(startVerse)", terminator: "")
        }
        
        if let verses = psalm.verses {
            print(" specific verses: \(verses)", terminator: "")
        }


        do {
            let section = psalm.category ?? "default"  // Use "default" if category is nil
            guard let psalmNumber = Int(psalm.number) else {
               print("Invalid psalm number format: \(psalm.number)")
               continue  // or throw an error
            }
            if let psalmVerses = try psalm_service.getPsalm(number: psalmNumber, section: section) {
            
                // Print verses with proper indentation
                print(psalmVerses.text.joined(separator: "\n"))
            }
            else {
                print ("no verses for Psalm \(psalmNumber)")
            }
            
        } catch {
            print("Error retrieving verses for Psalm \(psalm.number): \(error.localizedDescription)")
        }
        
        print() // New line
    }


}  else {
    print("Prime hour not found")
}

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

func extractWeekday(from liturgicalInfo: String) -> String? {
    // Split the string by spaces and look for the weekday
    let components = liturgicalInfo.components(separatedBy: .whitespaces)
    
    // The weekday should be after "is" and before "after"
    if let isIndex = components.firstIndex(of: "is"),
       let afterIndex = components.firstIndex(of: "after"),
       isIndex + 1 < afterIndex {
        
        // Get the word after "is" (which should be the weekday)
        return components[isIndex + 1].capitalized
    }
    
    return nil
}