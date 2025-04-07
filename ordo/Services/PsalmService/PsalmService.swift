import Foundation

public struct Psalm: Codable {
    public let number: Int
    public let section: String?     // Optional (e.g., "A", "Aleph")
    public let title: String?
    public let text: [String]       // Array of verses
    public let englishText: [String]?
    public let verified: Bool?
}

public class PsalmService {
    public static let shared = PsalmService()
    private var psalms: [Psalm] = []
    
    private init() {
        loadPsalms()
    }
    
    private func loadPsalms() {
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
            if let url = bundle.url(forResource: "psalms", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoded = try JSONDecoder().decode([String: [Psalm]].self, from: data)
                    if let psalmArray = decoded["psalms"] {
                        psalms = psalmArray
                        return
                    }
                } catch {
                    print("Error loading or decoding psalms: \(error)")
                }
            }
        }
        print("Failed to load psalms from all bundles")
    }
    
    // Get by number (and optional section)
    public func getPsalm(number: Int, section: String? = nil) -> Psalm? {
 if let section = section {
        return psalms.first { 
            $0.number == number && 
            $0.section?.caseInsensitiveCompare(section) == .orderedSame
        }
    } else {
        return psalms.first { $0.number == number }
    }
    }
    
    // Get all sections of a psalm number
    public func getPsalms(number: Int) -> [Psalm] {
        return psalms.filter { $0.number == number }
    }
    
    // Get all psalms
    public func getAllPsalms() -> [Psalm] {
        return psalms
    }
    public func getEnglishText(number: Int, section: String? = nil) -> [String]? {
          guard let psalm = getPsalm(number: number, section: section) else { return nil }
          return psalm.englishText
      }
      
    
    // Get formatted text (joined verses)
    public func getFormattedText(number: Int, section: String? = nil) -> String? {
        guard let psalm = getPsalm(number: number, section: section) else { return nil }
        return psalm.text.joined(separator: "\n")
    }
    public func getTotalPsalmCount() -> Int {
        return psalms.count
    }
    
    // Count how many psalms are verified
    public func getVerifiedPsalmCount() -> Int {
        return psalms.filter { $0.verified == true }.count
    }
}

