// docker-support/main.swift
import Foundation
import LiturgicalService
import PsalmService
import HoursService
import PsalmProgressTracker

enum PsalmError: Error {
    case invalidNumberFormat(String)
    case versesNotFound(Int)
}

// MARK: - Main Execution

let tracker = PsalmProgressTracker(savePath: "/app/data/psalm_progress.json")

let service = LiturgicalService()
let psalm_service = PsalmService.shared
let hours_service = HoursService.shared
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

// Parse arguments
let date: Date
let hourType: String  // "prime" (default) or "compline"

if CommandLine.arguments.count > 1 {
    // Check if first argument is a date or hour type
    if let inputDate = parseDate(CommandLine.arguments[1]) {
        date = inputDate
        hourType = CommandLine.arguments.indices.contains(2) ? CommandLine.arguments[2].lowercased() : "prime"
    } else {
        // First argument is hour type (e.g., "compline")
        hourType = CommandLine.arguments[1].lowercased()
        date = CommandLine.arguments.indices.contains(2) ? parseDate(CommandLine.arguments[2]) ?? Date() : Date()
    }
} else {
    // Default to today's Prime
    date = Date()
    hourType = "prime"
}

// Validate hour type
guard ["matins", "lauds", "prime", "terce", "sext", "none", "vespers", "compline"].contains(hourType) else {
    print("Error: Invalid hour type. Use 'prime' or 'compline'")
    exit(1)
}

// Get and print liturgical info
let info = service.getLiturgicalInfo(for: date)
print(info)

guard let weekday_info = extractWeekday(from: info) else {
    print("Could not determine weekday from LiturgicalInfo")
    fatalError()
}

if let hour = HoursService.shared.getHour(for: hourType) {
    print ("Hour: \(hourType)")
    printHourIntro(hour: hour)

    let weekday = weekday_info
    guard let psalms = getPsalmsForWeekday(weekday, hour: hour) else {
        print("No psalms found for \(weekday)")
        exit(1)
    }

    print("Psalms for \(weekday):")
    for psalm in psalms {
        printPsalm(psalm, using: psalm_service)
        guard let psalmNumber = Int(psalm.number) else {
            throw PsalmError.invalidNumberFormat(psalm.number)
        }
        tracker.markPsalm(number: psalmNumber, section: psalm.category)
    }

    if !hour.capitulum.isEmpty {
        print("\n📖 Capitulum:")
        print("  \(hour.capitulum)")
    }

    // Print versicles with proper formatting
 if let verses = hour.versicle?.compactMap({ $0 }), !verses.isEmpty {
    print("\n🕊️ Versicle:")
    verses.forEach { verse in
        print("  \(verse)")
    }
}
    if !hour.oratio.isEmpty {
    print("\n🙏 Oratio:")
    // Split at "Per Christum" if present
    if let perChristumRange = hour.oratio.range(of: "Per Christum") {
        let mainPrayer = hour.oratio[..<perChristumRange.lowerBound]
        let conclusion = hour.oratio[perChristumRange.lowerBound...]
        
        // Print main prayer with sentence formatting
        let sentences = mainPrayer.components(separatedBy: ". ").filter { !$0.isEmpty }
        for (index, sentence) in sentences.enumerated() {
            let formatted = index < sentences.count - 1 ? "\(sentence)." : sentence
            print("  \(formatted)")
        }
        
        // Print conclusion with special formatting
        print("  \(conclusion)".trimmingCharacters(in: .whitespacesAndNewlines))
    } else {
        // Fallback if "Per Christum" isn't found
        print("  \(hour.oratio)")
    }

    let overall = tracker.overallProgress()
    print("Overall: \(overall.completed)/\(overall.total)") // ex: "3/180"

    let weekly = tracker.weeklyProgress()
    print("This week: \(weekly.completed) completed, \(weekly.newlyRead) read")

    print(tracker.completedPsalmsReport())
    print("\n=== Overall ===\n")
    print(tracker.fullProgressReport())

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
    
    // Check for format like "29 Mar 2025 is Saturday after the 3rd Sunday of Lent"
    if let isIndex = components.firstIndex(of: "is"), 
       isIndex + 1 < components.count,
       let afterIndex = components.firstIndex(of: "after"),
       afterIndex > isIndex + 1 
    {
        return components[isIndex + 1].capitalized
    }
    // Check for format like "30 Mar 2025 is the 4th Sunday of Lent"
    else if let isIndex = components.firstIndex(of: "is"), 
            isIndex + 1 < components.count,
            components[isIndex + 1] == "the" 
    {
        // Check if the description contains "Sunday"
        let description = Array(components[isIndex + 2..<components.count]).joined(separator: " ")
        if description.lowercased().contains("sunday") {
            return "Sunday"
        } else {
            return description
        }
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
   if let hymn = hour.hymn, !hymn.isEmpty {
    print("\n🎶 Hymn:")
    switch hymn {
    case .lines(let hymnLines):
        hymnLines.forEach { print("  \($0)") }
        
    case .structured(let hymnData):
        print("  \(hymnData.defaultText)")
        if let seasonal = hymnData.seasons?.values.first {
            print("  (Seasonal variant: \(seasonal))")
        }
    }
}
    

    // Only add extra space if we printed something
    if !hour.introit.isEmpty || !(hour.hymn?.isEmpty ?? true) {
        print()
    }
}


func getPsalmsForWeekday(_ weekday: String, hour: Hour) -> [PsalmUsage]? {
    var psalms = [PsalmUsage]()
    
    // Add default psalms first (for Lauds, these are 66, 50, 117, 62)
    if let defaultPsalms = hour.psalms.default {
        psalms.append(contentsOf: defaultPsalms)
    }
    
    // Add weekday-specific psalms
    switch weekday.lowercased() {
    case "sunday": 
        if let sundayPsalms = hour.psalms.sunday {
            psalms.append(contentsOf: sundayPsalms)
        }
    case "monday": 
        if let mondayPsalms = hour.psalms.monday {
            psalms.append(contentsOf: mondayPsalms)
        }
    case "tuesday": 
        if let tuesdayPsalms = hour.psalms.tuesday {
            psalms.append(contentsOf: tuesdayPsalms)
        }
    case "wednesday": 
        if let wednesdayPsalms = hour.psalms.wednesday {
            psalms.append(contentsOf: wednesdayPsalms)
        }
    case "thursday": 
        if let thursdayPsalms = hour.psalms.thursday {
            psalms.append(contentsOf: thursdayPsalms)
        }
    case "friday": 
        if let fridayPsalms = hour.psalms.friday {
            psalms.append(contentsOf: fridayPsalms)
        }
    case "saturday": 
        if let saturdayPsalms = hour.psalms.saturday {
            psalms.append(contentsOf: saturdayPsalms)
        }
    default: 
        break
    }
    
    return psalms.isEmpty ? nil : psalms
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
        
        let psalmSections = service.getPsalms(number: psalmNumber)
        
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