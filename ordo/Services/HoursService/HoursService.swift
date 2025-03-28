import Foundation

public struct Hour: Codable {
    public let introit: [String]
    public let hymn: [String]
    public let capitulum: String
    public let versicle: [String?]
    public let oratio: String
    public let antiphons: AntiphonRules
    public let psalms: PsalmRules
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
    public let default: [PsalmUsage]?
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
        let bundlesToCheck = [
            Bundle.module,          // For SwiftPM resources
            Bundle(for: Self.self), // For test targets
            Bundle.main            // For production
        ]
        
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

