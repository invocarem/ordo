import Foundation
public struct LiturgicalRule<T: Codable>: Codable {
    public let `default`: T
    public let feasts: [String: T]?
    public let seasons: [String: T]?
    public let weekdays: [String: T]?  // Keys like "monday", "tuesday", etc.
    
    public func getText(
        for feast: String? = nil,
        season: String? = nil,
        weekday: String? = nil
    ) -> T {
        // Check feast first (highest priority)
        if let feast = feast, let feastText = feasts?[feast] {
            return feastText
        }
        
        // Then check season
        if let season = season, let seasonText = seasons?[season] {
            return seasonText
        }
        
        // Then check weekday
        if let weekday = weekday?.lowercased(), 
           let weekdayText = weekdays?[weekday] {
            return weekdayText
        }
        
        // Fall back to default
        return `default`
    }
}

// Typealiases for specific uses
public typealias Capitulum = LiturgicalRule<String>
public typealias Oratio = LiturgicalRule<String>
public typealias AntiphonRule = LiturgicalRule<String>  // Could replace AntiphonRules
public typealias Dismissal = LiturgicalRule<String>

// Updated Hour struct
public struct Hour: Codable {
    public let introit: [String]
    public let hymn: HymnUnion?
    public let capitulum: Capitulum
    public let versicle: [String?]?
    public let oratio: Oratio
    public let canticle: Canticle?
    public let antiphons: AntiphonRule?  // Now using the new type
    public let psalms: PsalmRules
    public let magnificat: Magnificat?
    public let benedictus: Benedictus?
    public let dismissal: Dismissal?
}

public enum HymnUnion: Codable {
    case lines([String])       // For plain text (6th-century)
    case structured(HymnData)  // For later traditions
    
    public struct HymnData: Codable {
        public let `default`: String
        public let seasons: [String: String]?
        public let feasts: [String: String]?

         private enum CodingKeys: String, CodingKey {
            case `default` = "default"
            case seasons
            case feasts
        }
    }
    
    // Custom decoding to handle both formats
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let lines = try? container.decode([String].self) {
            self = .lines(lines)
        } else {
            let data = try container.decode(HymnData.self)
            self = .structured(data)
        }
    }
    public var isEmpty: Bool {
        switch self {
        case .lines(let array): return array.isEmpty
        case .structured: return false
        }
    }
}

public struct Canticle: Codable {
    public let number: String
    public let title: String?
    public let source: String?
    public let antiphon: String?
    public let verses: [String?]? 
}
// for six century no need this
public struct Magnificat: Codable {
    public let antiphon: String  // The framing antiphon text
    public let text: String      // Fixed Latin text of Luke 1:46-55
    
    // For seasonal variations (Advent, Lent, etc.)
    public let seasonalAntiphons: [String: String]?
    
    // Default implementation for the standard text
    public static let standard = Magnificat(
        antiphon: "Deposuit potentes de sede",
        text: "Magnificat anima mea Dominum...", // Full Latin text here
        seasonalAntiphons: [
            "Advent": "Ecce ancilla Domini",
            "Lent": "Misericordias Domini"
        ]
    )
}
public struct Benedictus: Codable {
    public let antiphon: String?
    public let text: String
    public let gloria: String?
}

public struct AntiphonRules: Codable {
    public let `default`: String
    public let seasons: [String: String]?
    public let feasts: [String: String]?
}
public struct SeasonPsalmGroups: Codable {
    public let sunday: [PsalmUsage]
    public let weekday: [PsalmUsage]?
    public let monday: [PsalmUsage]?
    public let tuesday: [PsalmUsage]?
    public let wednesday: [PsalmUsage]?
    public let thursday: [PsalmUsage]?
    public let friday: [PsalmUsage]?
    public let saturday: [PsalmUsage]?
    
    private enum CodingKeys: String, CodingKey {
        case sunday, weekday, monday,tuesday,wednesday,thursday,friday,saturday
    }
}
public struct PsalmRules: Codable {
    public let notes: String? 
    public let prefix: [PsalmUsage]?  // Add this line
    public let seasons: [String: SeasonPsalmGroups]?
    public let weekdays: [String: [PsalmUsage]]?
    public let `default`: [PsalmUsage]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        var prefixArray: [PsalmUsage]?
        var seasonsDict = [String: SeasonPsalmGroups]()
        var weekdaysDict = [String: [PsalmUsage]]()
        var defaultArray: [PsalmUsage]?
        var notesValue: String?

        for key in container.allKeys {
            let keyString = key.stringValue
            if keyString == "prefix" {
                prefixArray = try container.decode([PsalmUsage].self, forKey: key)
            } else if keyString == "notes" {
                notesValue = try container.decode(String.self, forKey: key)
            }
            else if keyString == "default" {
                defaultArray = try container.decode([PsalmUsage].self, forKey: key)
            } else if ["winter", "summer"].contains(keyString) {
                let seasonGroup = try container.decode(SeasonPsalmGroups.self, forKey: key)
                seasonsDict[keyString] = seasonGroup
            } else if ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"].contains(keyString) {
                let psalms = try container.decode([PsalmUsage].self, forKey: key)
                weekdaysDict[keyString] = psalms
            } else {
                throw DecodingError.dataCorruptedError(forKey: key, in: container, debugDescription: "Unexpected key \(keyString)")
            }
        }
        prefix = prefixArray
        seasons = seasonsDict.isEmpty ? nil : seasonsDict
        weekdays = weekdaysDict.isEmpty ? nil : weekdaysDict
        `default` = defaultArray
        notes = notesValue ?? ""
    }
    
    private struct DynamicCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
}

public struct PsalmUsage: Codable, Identifiable, Equatable {
    public let number: String
    public let category: String?
    public let id: String
    public init(number: String, category: String? = nil) {
        self.number = number
        self.category = category ?? ""
        
        if let section = category, !section.isEmpty {
            self.id = "\(number)-\(section)"
        } else {
            self.id = "\(number)"
        }
    }
    

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        let parts = value.components(separatedBy: " ")
        guard !parts.isEmpty else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Empty psalm string")
        }
        number = parts[0]
        category = parts.count > 1 ? parts[1...].joined(separator: " ") : nil
        
        
        if let section = category, !section.isEmpty {
            self.id = "\(number)-\(section)"
        } else {
            self.id = "\(number)"
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let category = category {
            try container.encode("\(number) \(category)")
        } else {
            try container.encode(number)
        }
    }
    public static func == (lhs: PsalmUsage, rhs: PsalmUsage) -> Bool {
        return lhs.number == rhs.number && lhs.category == rhs.category
    }
 
}


public final class HoursService {
    public static let shared = HoursService()
    private var horas: [String: Hour] = [:]
    
    private init() {
        loadHours()
        
    }
    private func loadHours() {
        let bundlesToCheck: [Bundle] = {
                #if SWIFT_PACKAGE
                // Docker/SwiftPM environment (uses Bundle.module)
                return [Bundle.module]
                #else
                // Xcode environment (uses Bundle.main or Bundle(for:))
                return [Bundle.main, Bundle(for: Self.self)]
                #endif
            }()
        
        for bundle in bundlesToCheck {
            if let url = bundle.url(forResource: "horas", withExtension: "json") { // Changed from "psalms" to "horas"
                do {
                    let data = try Data(contentsOf: url)

                    print("\(data)")
                    horas = try JSONDecoder().decode([String: Hour].self, from: data)
                    return
                } catch {
                    print("Found horas.json but failed to load: \(error)")
                }
            }
        }
        print("Error: horas.json not found in any bundle")
    }
   
    public  func  getPsalmsForWeekday(
        weekday:  String, 
        hourKey:  String,  //  e.g.,  "matins",  "lauds"
        season:  String?  =  nil  //  "winter",  "summer",  or  nil
    )  ->  [PsalmUsage]?  {
        guard  let  hour  =  horas[hourKey]  else  {  return  nil  }
        return  getPsalmsForWeekday(weekday: weekday,  hour:  hour,  season:  season)
    }
private func getPsalmsForWeekday(weekday: String, hour: Hour, season: String? = nil) -> [PsalmUsage]? {
    var psalms = [PsalmUsage]()
    let lowercaseWeekday = weekday.lowercased()

    if let prefixPsalms = hour.psalms.prefix {
        psalms.append(contentsOf: prefixPsalms)
    }
    // 1. First check for specific weekday psalms (e.g., "monday", "tuesday")
    if let weekdayPsalms = hour.psalms.weekdays?[lowercaseWeekday], !weekdayPsalms.isEmpty {
        return weekdayPsalms
    }

    // 2. Enhanced seasonal psalms check (for Matins/Lauds)
    if let season = season?.lowercased(), let seasonGroups = hour.psalms.seasons?[season] {
        // Try to find a direct match for the weekday (like "friday" in winter)
        let specificDayPsalms: [PsalmUsage]?
        
        switch lowercaseWeekday {
        case "sunday":
            specificDayPsalms = seasonGroups.sunday
        case "monday":
            specificDayPsalms = seasonGroups.monday
        case "tuesday":
            specificDayPsalms = seasonGroups.tuesday
        case "wednesday":
            specificDayPsalms = seasonGroups.wednesday
        case "thursday":
            specificDayPsalms = seasonGroups.thursday
        case "friday":
            specificDayPsalms = seasonGroups.friday
        case "saturday":
            specificDayPsalms = seasonGroups.saturday
        default:
            specificDayPsalms = seasonGroups.weekday
        }
        
        if let specificDayPsalms = specificDayPsalms {
            psalms.append(contentsOf: specificDayPsalms)
        } else if lowercaseWeekday != "sunday" {
            // Fall back to weekday structure only if it's not sunday
            if let weekdayPsalms = seasonGroups.weekday {
                psalms.append(contentsOf: weekdayPsalms)
            }
        }
    }

    // 3. Fall back to default if we still have nothing
    if psalms.isEmpty, let defaultPsalms = hour.psalms.default {
        psalms.append(contentsOf: defaultPsalms)
    }

    return psalms.isEmpty ? nil : psalms
}
    
    
    public func getHour(for key: String) -> Hour? {
        return horas[key]
    }
}


