import Foundation

public struct Hour: Codable {
    public let introit: [String]
    public let hymn: HymnUnion
    public let capitulum: String
    public let versicle: [String?]
    public let oratio: String
    public let antiphons: AntiphonRules
    public let psalms: PsalmRules
    public let magnificat: Magnificat?
}
public enum HymnUnion: Codable {
    case lines([String])       // For plain text (6th-century)
    case structured(HymnData)  // For later traditions
    
    public struct HymnData: Codable {
        public let defaultText: String
        public let seasons: [String: String]?
        public let feasts: [String: String]?
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

public struct AntiphonRules: Codable {
    public let `default`: String
    public let seasons: [String: String]?
    public let feasts: [String: String]?
}
public struct PsalmRules: Codable {
    public let sunday: [PsalmUsage]?
    public let monday: [PsalmUsage]?
    public let tuesday: [PsalmUsage]?
    public let wednesday: [PsalmUsage]?
    public let thursday: [PsalmUsage]?
    public let friday: [PsalmUsage]?
    public let saturday: [PsalmUsage]?
    public let `default`: [PsalmUsage]?
}


public struct PsalmUsage: Codable {
    public let number: String
    public let category: String?
    public let antiphon: String?   // Defaults to nil if omitted, required for vespers
    public let startVerse: Int?     // Defaults to 1 if omitted
    public let verses: [Int]?       // If nil, assume all verses
    
    var id: String {
           "\(number)-\(category ?? "default")"
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
                    horas = try JSONDecoder().decode([String: Hour].self, from: data)
                    return
                } catch {
                    print("Found horas.json but failed to load: \(error)")
                }
            }
        }
        print("Error: horas.json not found in any bundle")
    }
   
    
    
    public func getHour(for key: String) -> Hour? {
        return horas[key]
    }
}

