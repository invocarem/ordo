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
    
    public init(calendar: Calendar = .current) {
        self.calendar = calendar
        do{
            self.officeData = try BundleChecker.loadJSON(forResource: "office", as: OfficeData.self)
        }catch {
            print("load office data failed")
            fatalError(error.localizedDescription)
            
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
        
        // Check temporal cycle (movable feasts)
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
    
    // MARK: - Season Determination
    
    private func getSeason(for date: Date) -> LiturgicalSeason {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let year = dateComponents.year ?? 0
        
        guard let adventStart = getAdventStart(year: year),
              let christmas = getChristmas(year: year),
              let epiphany = getEpiphany(year: year),
              let lentStart = getLentStart(year: year),
              let easter = getEaster(year: year),
              let pentecost = calendar.date(byAdding: .day, value: 49, to: easter) else {
            return .ordinaryTime(.postPentecost)
        }
        
        if date >= adventStart && date < christmas {
            return .advent
        } else if date >= christmas && date <= epiphany {
            return .christmas
        } else if date > epiphany && date < lentStart {
            return .ordinaryTime(.postEpiphany)
        } else if date >= lentStart && date < easter {
            return .lent
        } else if date >= easter && date <= pentecost {
            return .pascha
        } else {
            return .ordinaryTime(.postPentecost)
        }
    }
    
    // MARK: - Feast Determination
    
    private func getSanctoralFeast(for dateComponents: DateComponents) -> Feast? {
        guard let month = dateComponents.month, let day = dateComponents.day else { return nil }
        
        let monthStr = String(format: "%02d", month)
        let dayStr = String(format: "%02d", day)
        let key = "\(monthStr)-\(dayStr)"
        
        if let feastData = officeData.sanctoral_cycle[key] {
            return Feast(
                name: feastData.name,
                type: feastData.type,
                rank: feastData.rank ?? "Minor",
                notes: feastData.notes ?? ""
            )
        }
        
        return nil
    }
    
    private func getTemporalFeast(for date: Date) -> Feast? {
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let year = dateComponents.year ?? 0
        
        guard let christmas = getChristmas(year: year),
              let epiphany = getEpiphany(year: year),
              let easter = getEaster(year: year),
              let pentecost = calendar.date(byAdding: .day, value: 49, to: easter) else {
            return nil
        }
        
        // Check Christmas feasts
        if calendar.isDate(date, inSameDayAs: christmas) {
            return Feast(
                name: officeData.temporal_cycle.christmas["12-25"]?.name ?? "Nativity of the Lord",
                type: "nativity",
                rank: "Solemnity",
                notes: officeData.temporal_cycle.christmas["12-25"]?.notes ?? ""
            )
        }
        
        if calendar.isDate(date, inSameDayAs: epiphany) {
            return Feast(
                name: officeData.temporal_cycle.christmas["01-06"]?.name ?? "Epiphany",
                type: "theophany",
                rank: "Solemnity",
                notes: officeData.temporal_cycle.christmas["01-06"]?.notes ?? ""
            )
        }
        
        // Check Easter feasts
        if calendar.isDate(date, inSameDayAs: easter) {
            return Feast(
                name: officeData.temporal_cycle.pascha.easter.name,
                type: "resurrection",
                rank: "Solemnity",
                notes: officeData.temporal_cycle.pascha.easter.notes ?? ""
            )
        }
        
        if calendar.isDate(date, inSameDayAs: pentecost) {
            return Feast(
                name: officeData.temporal_cycle.pascha.pentecost.name,
                type: "pentecost",
                rank: "Solemnity",
                notes: officeData.temporal_cycle.pascha.pentecost.notes ?? ""
            )
        }
        
        return nil
    }
    
    // MARK: - Key Date Calculations (6th century version)
    
    private func getAdventStart(year: Int) -> Date? {
        // 4th Sunday before Christmas (6th century Roman practice)
        var components = DateComponents()
        components.year = year
        components.month = 12
        components.day = 25
        guard let christmas = calendar.date(from: components) else { return nil }
        
        let weekday = calendar.component(.weekday, from: christmas)
        let daysToSubtract = (weekday - 1) + 7 * 3 // 3 full weeks plus days to previous Sunday
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: christmas)
    }
    
    private func getChristmas(year: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = 12
        components.day = 25
        return calendar.date(from: components)
    }
    
    private func getEpiphany(year: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = 1
        components.day = 6
        return calendar.date(from: components)
    }
    
    private func getLentStart(year: Int) -> Date? {
        // Quadragesima Sunday (6 weeks before Easter, excluding Sundays)
        guard let easter = getEaster(year: year) else { return nil }
        return calendar.date(byAdding: .day, value: -42, to: easter) // 6 weeks * 7 days
    }
    
    private func getEaster(year: Int) -> Date? {
        // Using the same calculation as before (valid for both Julian and Gregorian)
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
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return calendar.date(from: components)
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
