import Foundation

public struct Hour: Codable {
    public let introit: String
    public let hymn: String
    public let chapter: String
    public let versicle: String?
    public let closing: String
    public let antiphons: AntiphonRules
    public let psalms: PsalmRules
}

public struct AntiphonRules: Codable {
    public let `default`: String
    public let seasons: [String: String]?
    public let feasts: [String: String]?
}

public struct PsalmRules: Codable {
    public let `default`: [String: [PsalmUsage]]  // Key: "sunday", "monday", etc.
    public let seasons: [String: [String: [PsalmUsage]]]?  // Key: "lent" → "sunday"
}

public struct PsalmUsage: Codable {
    public let number: String
    public let category: String?
    public let startVerse: Int?     // Defaults to 1 if omitted
    public let verses: [Int]?       // If nil, assume all verses
}

public final class HoursService {
    public static let shared = HoursService()
    private var horas: [String: Hour] = [:]
    
    private init() {
        loadHours()
    }
    
    private func loadHours() {
        guard let url = Bundle.main.url(forResource: "horas", withExtension: "json") else {
            fatalError("horas.json not found in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            horas = try JSONDecoder().decode([String: Hour].self, from: data)
        } catch {
            fatalError("Failed to load horas.json: \(error)")
        }
    }
    
    public func getHour(for key: String) -> Hour? {
        return horas[key]
    }
}

