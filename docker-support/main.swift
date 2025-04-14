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
let season = info.benedictineSeason.description.lowercased()
guard let weekday_info = extractWeekday(from: info) else {
    print("Could not determine weekday from LiturgicalInfo")
    fatalError()
}

if let hour = HoursService.shared.getHour(for: hourType) {
    print ("Hour: \(hourType)")
    printHourIntro(hour: hour, liturgicalInfo: info)

    let weekday = weekday_info
    guard let psalms = HoursService.shared.getPsalmsForWeekday(weekday: weekday, hourKey: hourType, season: season) else {
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

    printPrayers(hour: hour, liturgicalInfo: info)
    print("\n=== Progress ===\n")

    let overall = tracker.overallProgress()
    print("Overall: \(overall.completed)/\(overall.total)") // ex: "3/180"

    let weekly = tracker.weeklyProgress()
    print("This week: \(weekly.completed) completed, \(weekly.newlyRead) read")

    print(tracker.completedPsalmsReport())
    print("\n=== Overall ===\n")
    print(tracker.fullProgressReport())

}

else {
    print("Prime hour not found")
}

// MARK: - Helper Functions

func parseDate(_ string: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.date(from: string)
}
// Option 1: Modify the function to accept LiturgicalDay
func extractWeekday(from liturgicalInfo: LiturgicalDay) -> String? {
    return liturgicalInfo.weekday
}
func extractWeekdayold(from liturgicalInfo: String) -> String? {
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

func printHourIntro(hour: Hour, liturgicalInfo: LiturgicalDay) {
    // Print Introit if it exists
    if !hour.introit.isEmpty {
        print("\n🎵 Introit:")
        hour.introit.forEach { print("  \($0)") }
    }

    // Print Hymn if it exists
   if let hymn = hour.hymn {
        print("\n🎶 Hymn:")
        let hymnText = hymn.getAppropriateText(for: liturgicalInfo)
        hymnText.forEach { print("  \($0)") }
        
    }
}



func printPsalm(_ psalm: PsalmUsage, using service: PsalmService) {
    // Print psalm header with better spacing
    var headerParts = [String]()
    headerParts.append("Psalm \(psalm.number)")
    
    if let category = psalm.category, !category.isEmpty {
        headerParts.append("(\(category))")
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

func printPrayers(hour: Hour, liturgicalInfo: LiturgicalDay) {
    // Print Capitulum
    print("\n📖 Capitulum:")
    let capitulumText = hour.capitulum.getAppropriateText(for: liturgicalInfo)
   
    print("  \(capitulumText)")
    
    // Print Versicle if it exists
    if let versicles = hour.versicle?.getAppropriateText(for: liturgicalInfo) {
        print("\n🕯️ Versicle:")
        versicles.forEach { print("  \($0)") }
    }
    
    // Print Oratio
    print("\n🙏 Oratio:")
    let oratioText = hour.oratio.getAppropriateText(for: liturgicalInfo)
    // Split into sentences for better readability
    oratioText.forEach {
        print("  \($0)\($0.hasSuffix(".") ? "" : ".")")
    }
    
    print() // Add final newline
}

extension LiturgicalText {
    func getAppropriateText(for liturgicalInfo: LiturgicalDay) -> [String] {
        switch self {
        case .simple(let lines):
            return lines
            
        case .structured(let data):
            if let feastName = liturgicalInfo.feast?.name.lowercased() {
                print ("feastname \(feastName)")
                if let feastText = data.feasts?[feastName] {
                    
                    return feastText
                }
            }
            
            
            let seasonKey: String
            switch liturgicalInfo.season {
                case .advent: seasonKey = "advent"
                case .lent: seasonKey = "lent"
                case .pascha: seasonKey = "pascha"
                case .christmas: seasonKey = "christmas"
                case .ordinaryTime: seasonKey = "ordinary"
            }
                
            if let seasonText = data.seasons?[seasonKey] {
                return seasonText
            }
            
            // Fall back to default
            return data.default
        }
    }
}
