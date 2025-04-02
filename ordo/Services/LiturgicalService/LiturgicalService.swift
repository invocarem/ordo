//
//  LiturgicalService.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-24.
//

import Foundation

public class LiturgicalService {
    private let calendar: Calendar
    private let officeData: OfficeData
    public let psalterService: PsalterService
    public init(calendar: Calendar = .current) {
        self.calendar = calendar
        do {
            self.officeData = try BundleChecker.loadJSON(forResource: "office", as: OfficeData.self)
            self.psalterService = PsalterService(officeData: officeData, calendar: calendar)
        } catch {
            fatalError("Failed to load office data: \(error)")
        }
    }
    
    // MARK: - Public Interface
    
    public func getLiturgicalInfo(for date: Date) -> LiturgicalDay {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let weekday = calendar.component(.weekday, from: date)
        let weekdayName = calendar.weekdaySymbols[weekday - 1]
        
        // Check for fixed-date feasts first
        if let feast = getSanctoralFeast(for: dateComponents) {
            return LiturgicalDay(
                date: date,
                season: getSeason(for: date),
                feast: feast,
                weekday: weekdayName,
                isVigil: false,
                isSunday: weekday == 1
            )
        }
        
        // Check temporal cycle feasts
        if let temporalFeast = getTemporalFeast(for: date) {
            return LiturgicalDay(
                date: date,
                season: getSeason(for: date),
                feast: temporalFeast,
                weekday: weekdayName,
                isVigil: false,
                isSunday: weekday == 1
            )
        }
        
        // Ordinary day
        return LiturgicalDay(
            date: date,
            season: getSeason(for: date),
            feast: nil,
            weekday: weekdayName,
            isVigil: false,
            isSunday: weekday == 1
        )
    }
    private let verbose : Bool = true


    private func getSeason(for date: Date) -> LiturgicalSeason {
    let normalizedDate = calendar.startOfDay(for: date)
    let year = calendar.component(.year, from: date)
    
    // Get all key dates first
    let adventStart = getNormalizedAdventStart(year: year)
    let christmas = getNormalizedChristmas(year: year)
    let epiphany = getNormalizedEpiphany(year: year, forChristmasSeason: true)
    let lentStart = getNormalizedLentStart(year: year)
    let easter = getNormalizedEaster(year: year)
    let pentecost = easter.flatMap { getNormalizedPentecost(easter: $0) }

    if verbose {
        print("\n=== Liturgical Date Calculations ===")
        print("Advent Start: \(adventStart?.description ?? "nil")")
        print("Christmas: \(christmas?.description ?? "nil")")
        print("Epiphany: \(epiphany?.description ?? "nil")")
        print("Lent Start: \(lentStart?.description ?? "nil")")
        print("Easter: \(easter?.description ?? "nil")")
        print("Pentecost: \(pentecost?.description ?? "nil")")
        print("Current Date: \(normalizedDate)")
        print("=================================\n")
    }

    // 1. First check for Christmas season (Dec 25-Jan 5)
    if let christmas = christmas,
       let epiphany = epiphany,
       normalizedDate >= christmas && normalizedDate <= epiphany {
        if verbose { print("Season: Christmas (Dec 25-Jan 6)") }
        return .christmas
    }

    // 2. Check other seasons
    guard let adventStart = adventStart,
          let christmas = christmas,
          let lentStart = lentStart,
          let easter = easter,
          let pentecost = pentecost else {
        if verbose { print("Season: Defaulting to Ordinary Time (Post-Pentecost)") }
        return .ordinaryTime(.postPentecost)
    }
    
    if normalizedDate >= adventStart && normalizedDate < christmas {
        if verbose { print("Season: Advent (until Christmas)") }
        return .advent
    } else if normalizedDate >= lentStart && normalizedDate < easter {
        if verbose { print("Season: Lent (until Easter)") }
        return .lent
    } else if normalizedDate >= easter && normalizedDate <= pentecost {
        if verbose { print("Season: Pascha (Easter to Pentecost)") }
        return .pascha
    } else {
        if verbose { print("Season: Ordinary Time (Post-Pentecost)") }
        return .ordinaryTime(.postPentecost)
    }
}
 
   
    
    // MARK: - Date Calculations
    
    private func getNormalizedAdventStart(year: Int) -> Date? {
        guard let christmas = getNormalizedChristmas(year: year) else { return nil }
        let weekday = calendar.component(.weekday, from: christmas)
        let daysToSubtract = (weekday - 1) + 7 * 3 // 3 full weeks plus days to previous Sunday
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: christmas)
            .map { calendar.startOfDay(for: $0) }
    }
    
    private func getNormalizedChristmas(year: Int) -> Date? {
        guard let components = officeData.christmasDateComponents else {
            assertionFailure("Christmas date configuration missing in office.json")
            return nil
        }
        return calendar.date(from: DateComponents(
            year: year,
            month: components.month,
            day: components.day
        )).map { calendar.startOfDay(for: $0) }
    }
    
    private func getNormalizedEpiphany(year: Int, forChristmasSeason: Bool = false) -> Date? {
        guard let components = officeData.epiphanyDateComponents else {
            assertionFailure("Epiphany date configuration missing in office.json")
            return nil
        }
        let targetYear = forChristmasSeason ? year + 1: year
        return calendar.date(from: DateComponents(
            year: targetYear,
            month: components.month,
            day: components.day
        )).map { calendar.startOfDay(for: $0) }
    }
    
    private func getNormalizedLentStart(year: Int) -> Date? {
        guard let easter = getNormalizedEaster(year: year) else { return nil }
        return calendar.date(byAdding: .day, value: -42, to: easter)
            .map { calendar.startOfDay(for: $0) }
    }
    
    private func getNormalizedEaster(year: Int) -> Date? {
        // (Keep your existing Easter calculation logic)
        let a = year % 19
        let b = year / 100
        let c = year % 100
        let d = b / 4
        let e = b % 4
        let f = (b + 8) / 25
        let g = (b - f + 1) / 3
        let h = (19 * a + b - d - g + 15) % 30
        let i = c / 4
        let k = c % 4
        let l = (32 + 2 * e + 2 * i - h - k) % 7
        let m = (a + 11 * h + 22 * l) / 451
        let month = (h + l - 7 * m + 114) / 31
        let day = ((h + l - 7 * m + 114) % 31) + 1
        
        return calendar.date(from: DateComponents(
            year: year,
            month: month,
            day: day
        )).map { calendar.startOfDay(for: $0) }
    }
    
    private func getNormalizedPentecost(easter: Date) -> Date? {
        calendar.date(byAdding: .day, value: 49, to: easter)
            .map { calendar.startOfDay(for: $0) }
    }
    
    // MARK: - Feast Determination (unchanged)
    private func getSanctoralFeast(for dateComponents: DateComponents) -> Feast? {
        guard let month = dateComponents.month, let day = dateComponents.day else { return nil }
        let key = String(format: "%02d-%02d", month, day)
        
        return officeData.sanctoral_cycle[key].map {
            Feast(
                name: $0.name,
                type: $0.type,
                rank: $0.rank ?? "Minor",
                notes: $0.notes ?? ""
            )
        }
    }
    
    private func getTemporalFeast(for date: Date) -> Feast? {
        let year = calendar.component(.year, from: date)
        


        if let christmas = getNormalizedChristmas(year: year),
           calendar.isDate(date, inSameDayAs: christmas),
           let feastData = officeData.temporal_cycle.christmas.first(where: { $0.value.name.lowercased().contains("nativity") })?.value {
            return Feast(
                name: feastData.name,
                type: feastData.type,
                rank: "Solemnity",
                notes: feastData.notes ?? ""
            )
        }
        
        if let epiphany = getNormalizedEpiphany(year: year),
           calendar.isDate(date, inSameDayAs: epiphany),
           let feastData = officeData.temporal_cycle.christmas.first(where: { $0.value.name.lowercased().contains("epiphany") })?.value {
            return Feast(
                name: feastData.name,
                type: feastData.type,
                rank: "Solemnity",
                notes: feastData.notes ?? ""
            )
        }


        if let easter = getNormalizedEaster(year: year),
            calendar.isDate(date, inSameDayAs: easter) {
                return Feast(
                name: officeData.temporal_cycle.pascha.easter.name,
                type: "resurrection",
                rank: "Solemnity",
                notes: officeData.temporal_cycle.pascha.easter.notes ?? ""
            )
         }

        // Check Pentecost
        if  let easter = getNormalizedEaster(year: year),
            let pentecost = getNormalizedPentecost(easter: easter),
            calendar.isDate(date, inSameDayAs: pentecost) {
                return Feast(
                name: officeData.temporal_cycle.pascha.pentecost.name,
                type: "pentecost",
                rank: "Solemnity",
                notes: officeData.temporal_cycle.pascha.pentecost.notes ?? ""
            )
        }
    
        
        
        return nil
    }
}

// MARK: - Data Models

public struct LiturgicalDay  {
    public let date: Date
    public let season: LiturgicalSeason
    public let feast: Feast?
    public let weekday: String
    public let isVigil: Bool
    public let isSunday: Bool
    public init(date: Date, season: LiturgicalSeason, feast: Feast?, weekday: String, isVigil: Bool, isSunday: Bool) {
        self.date = date
        self.season = season
        self.feast = feast
        self.weekday = weekday
        self.isVigil = isVigil
        self.isSunday = isSunday
    }
}

public enum LiturgicalSeason {
    case advent
    case christmas
    case lent
    case pascha
    case ordinaryTime(OrdinaryTimePeriod)
    
    public enum OrdinaryTimePeriod {
        case postEpiphany
        case postPentecost
    }
    public var description: String {
            switch self {
            case .advent: return "Advent"
            case .christmas: return "Christmas"
            case .lent: return "Lent"
            case .pascha: return "Pascha"
            case .ordinaryTime(let period):
                switch period {
                case .postEpiphany: return "Ordinary Time (Post-Epiphany)"
                case .postPentecost: return "Ordinary Time (Post-Pentecost)"
                }
            }
        }
}

public struct Feast {
    public let name: String
    public let type: String
    public let rank: String
    public let notes: String
    
    public init(name: String, type: String, rank: String, notes: String) {
        self.name = name
        self.type = type
        self.rank = rank
        self.notes = notes
    }
}


 
// MARK: - JSON Decoding

public struct OfficeData: Codable {
    let description: String
    let temporal_cycle: TemporalCycle
    let sanctoral_cycle: [String: SanctoralFeast]
    let seasons: [String: SeasonData]
    let notes: OfficeNotes
    let psalter: Psalter
      
   

    // MARK: - Psalter Structure
    public struct Psalter: Codable {
        public let hours: Hours
        
        public struct Hours: Codable {
            public let matins: Matins
            public let lauds: Lauds
            public let prime: HourRule
            public let terce: HourRule
            public let sext: HourRule
            public let none: HourRule
            public let vespers: HourRule
            public let compline: HourRule
            
            // Matins structure
            public struct Matins: Codable {
                public let winter: SeasonPsalms
                public let summer: SeasonPsalms
                
                public struct SeasonPsalms: Codable {
                    public let sunday: [String]
                    public let weekday: [String]
                }
            }
            
            // Lauds structure
            public struct Lauds: Codable {
                public let sunday: [String]
                public let weekday: WeekdayPsalms
                public let notes: LaudsNotes?
                
                public struct WeekdayPsalms: Codable {
                    public let winter: [String]
                    public let summer: [String]
                }
                
                public struct LaudsNotes: Codable {
                    public let canticles: String?
                    public let alleluia: String?
                }
            }
            
            public struct HourRule: Codable {
                public let sunday: [String]?
                public let monday: [String]?
                public let tuesday: [String]?
                public let wednesday: [String]?
                public let thursday: [String]?
                public let friday: [String]?
                public let saturday: [String]?
                public let weekday: [String]?
                public let `default`: [String]?
                public let notes: String?
              }
          
            
        }
    }

    public struct TemporalCycle: Codable {
        let advent: Advent
        let christmas: [String: ChristmasFeast]
        let lent: Lent
        let pascha: Pascha
        let ordinary_time: OrdinaryTime
        
        struct Advent: Codable {
            let start: String
            let character: String
            let notes: String
        }
        
        struct ChristmasFeast: Codable {
            let name: String
            let type: String
            let notes: String?
        }
        
        struct Lent: Codable {
            let start: String
            let fasting: String
            let holy_week: HolyWeek?
            let notes: String?
            
            struct HolyWeek: Codable {
                let palm_sunday: String
                let good_friday: String
            }
        }
        
        struct Pascha: Codable {
            let easter: Easter
            let pentecost: Pentecost
            
            struct Easter: Codable {
                let name: String
                let type: String
                let octave: String?
                let notes: String?
            }
            
            struct Pentecost: Codable {
                let name: String
                let type: String
                let notes: String?
            }
        }
        
        struct OrdinaryTime: Codable {
            let post_epiphany: Period
            let post_pentecost: Period
            
            struct Period: Codable {
                let start: String
                let end: String
                let notes: String
            }
        }
    }
    
    struct SanctoralFeast: Codable {
        let name: String
        let type: String
        let rank: String?
        let scripture: String?
        let notes: String?
    }
    
    struct SeasonData: Codable {
        let dates: String
        let matins: Matins
        let meals: Int?
        let vespers_time: String?
        let notes: String?
        
        struct Matins: Codable {
            let psalms: [[String]]?
            let readings: StringOrDict?
            let rising_time: String?
        }
    }
    
    struct OfficeNotes: Codable {
        let historical_accuracy: String
        let later_additions: LaterAdditions
        
        struct LaterAdditions: Codable {
            let warning: String
            let list: [String]
        }
    }

     var christmasDateComponents: DateComponents? {
        for (dateString, feast) in temporal_cycle.christmas {
            if feast.name.lowercased().contains("nativity") {
                return parseDateComponents(from: dateString)
            }
        }
        return nil
    }
    
    var epiphanyDateComponents: DateComponents? {
        for (dateString, feast) in temporal_cycle.christmas {
            if feast.name.lowercased().contains("epiphany") {
                return parseDateComponents(from: dateString)
            }
        }
        return nil
    }
    
    private func parseDateComponents(from dateString: String) -> DateComponents? {
        let parts = dateString.components(separatedBy: "-")
        guard parts.count == 2,
              let month = Int(parts[0]),
              let day = Int(parts[1]) else {
            return nil
        }
        return DateComponents(month: month, day: day)
    }
}

// Helper for flexible JSON decoding
public enum StringOrDict: Codable {
    case string(String)
    case dict([String: String])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let dict = try? container.decode([String: String].self) {
            self = .dict(dict)
        } else {
            throw DecodingError.typeMismatch(StringOrDict.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected string or dictionary"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str):
            try container.encode(str)
        case .dict(let dict):
            try container.encode(dict)
        }
    }
}
struct BundleChecker {
    static func url(forResource name: String,
                      withExtension ext: String?) -> URL? {
           #if SWIFT_PACKAGE
           return Bundle.module.url(forResource: name, withExtension: ext)
           #else
           return Bundle.main.url(forResource: name, withExtension: ext)
           #endif
       }
   
    
    static func loadJSON<T: Decodable>(forResource name: String,
                                     withExtension ext: String? = "json",
                                     as type: T.Type) throws -> T {
        guard let url = url(forResource: name, withExtension: ext) else {
            throw NSError(domain: "BundleChecker", code: 404,
                         userInfo: [NSLocalizedDescriptionKey: "Resource not found: \(name).\(ext ?? "")"])
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
}
