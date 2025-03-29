// docker-support/main.swift
import Foundation
import HoursService
import LiturgicalService
import PsalmService

enum PsalmError: Error {
    case invalidNumberFormat(String)
    case versesNotFound(Int)
}

// MARK: - Main Execution

let service = LiturgicalService()
let psalm_service = PsalmService.shared
let hours_service = HoursService.shared

let date: Date
if CommandLine.arguments.count > 1,
    let inputDate = parseDate(CommandLine.arguments[1])
{
    date = inputDate
} else {
    date = Date()
}

// Get and print liturgical info
let info = service.getLiturgicalInfo(for: date)
print(info)

guard let weekday_info = extractWeekday(from: info) else {
    print("Could not determine weekday from LiturgicalInfo")
    fatalError()
}

if let hour = HoursService.shared.getHour(for: "prime") {
    printHourIntro(hour: hour)

    let weekday = weekday_info
    guard let psalms = getPsalmsForWeekday(weekday, hour: hour) else {
        print("No psalms found for \(weekday)")
        exit(1)
    }

    print("Psalms for \(weekday):")
    for psalm in psalms {
        printPsalm(psalm, using: psalm_service)
    }

    if !hour.capitulum.isEmpty {
        print("\n📖 Capitulum:")
        print("  \(hour.capitulum)")
    }

    // Print versicles with proper formatting
    if !hour.versicle.compactMap({ $0 }).isEmpty {
        print("\n🕊️ Versicle:")
        hour.versicle.forEach {
            if let verse = $0 {
                print(verse.starts(with: "℣") ? "  \(verse)" : "  \(verse)")
            }
        }
    }

} else {
    print("Prime hour not found")
}

// MARK: - Helper Functions

func parseDate(_ string: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.date(from: string)
}

func extractWeekday(from liturgicalInfo: String) -> String? {
    let components = liturgicalInfo.components(separatedBy: .whitespaces)
    if let isIndex = components.firstIndex(of: "is"),
        let afterIndex = components.firstIndex(of: "after"),
        isIndex + 1 < afterIndex
    {
        return components[isIndex + 1].capitalized
    }
    return nil
}

func printHourIntro(hour: Hour) {
    // Print Introit if it exists
    if !hour.introit.isEmpty {
        print("\n🎵 Introit:")
        hour.introit.forEach { print("  \($0)") }
    }

    // Print Hymn if it exists
    if !hour.hymn.isEmpty {
        print("\n🎶 Hymn:")
        hour.hymn.forEach { print("  \($0)") }
    }

    // Only add extra space if we printed something
    if !hour.introit.isEmpty || !hour.hymn.isEmpty {
        print()
    }
}

func getPsalmsForWeekday(_ weekday: String, hour: Hour) -> [PsalmUsage]? {
    switch weekday.lowercased() {
    case "sunday": return hour.psalms.sunday
    case "monday": return hour.psalms.monday
    case "tuesday": return hour.psalms.tuesday
    case "wednesday": return hour.psalms.wednesday
    case "thursday": return hour.psalms.thursday
    case "friday": return hour.psalms.friday
    case "saturday": return hour.psalms.saturday
    default: return nil
    }
}
func printPsalm(_ psalm: PsalmUsage, using service: PsalmService) {
    // Print psalm header with better spacing
    var headerParts = [String]()
    headerParts.append("Psalm \(psalm.number)")
    
    if let category = psalm.category, !category.isEmpty {
        headerParts.append("(\(category))")
    }
    
    if let startVerse = psalm.startVerse, startVerse != 1 {
        headerParts.append("starting at verse \(startVerse)")
    }
    
    if let verses = psalm.verses {
        headerParts.append("specific verses: \(verses)")
    }
    
    print("\n" + headerParts.joined(separator: " "))
    
    // Print psalm content with better formatting
    do {
        let section = psalm.category
        guard let psalmNumber = Int(psalm.number) else {
            throw PsalmError.invalidNumberFormat(psalm.number)
        }

        // Print section header with emoji
        let sectionHeader: String
        if section?.isEmpty ?? true {
            sectionHeader = "📖 Psalm \(psalmNumber)"
        } else {
            sectionHeader = "📖 Psalm \(psalmNumber) | Section: \(section!)"
        }
        print(sectionHeader)
        print(String(repeating: "─", count: sectionHeader.count))  // Divider line
        
        let psalmSections = try service.getPsalms(number: psalmNumber)
        
        if psalmSections.isEmpty {
            throw PsalmError.versesNotFound(psalmNumber)
        }
        
        let versesToPrint: [String]
        if psalmSections.count == 1 {
            versesToPrint = psalmSections.first?.text ?? []
        } else {
            guard let section = section,
                  let psalmSection = psalmSections.first(where: { $0.section == section }) 
            else {
                throw PsalmError.versesNotFound(psalmNumber)
            }
            versesToPrint = psalmSection.text
        }
        
        // Print verses with proper spacing
        versesToPrint.forEach { verse in
            let trimmedVerse = verse.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimmedVerse.isEmpty {
                print("  \(trimmedVerse)")  // Indent each verse
            }
        }
        
    } catch PsalmError.invalidNumberFormat(let number) {
        print("\n⚠️ Invalid psalm number format: '\(number)'")
    } catch PsalmError.versesNotFound(let number) {
        print("\n❌ No verses found for Psalm \(number)")
    } catch {
        print("\n⛔ Error: \(error.localizedDescription)")
    }
    
    print()  // Extra new line after each psalm
}