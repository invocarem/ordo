import Foundation

public class PsalmService {
    public static let shared = PsalmService()
    private var psalms: [String: String] = [:]
    
    private init() {
        loadPsalms()
    }
    
    private func loadPsalms() {

        let bundlesToCheck = [
            Bundle.module,          // For SwiftPM resources
            Bundle(for: Self.self), // For test targets
            Bundle.main            // For production
        ]
        
        for bundle in bundlesToCheck {
            if let url = bundle.url(forResource: "psalms", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    psalms = try JSONDecoder().decode([String: String].self, from: data)
                    return
                } catch {
                    print("Found psalms.json but failed to load: \(error)")
                }
            }
        }
        
        
       
    }
    
    public func getPsalmText(for key: String) -> String? {
        return psalms[key]
    }
    
    public func getPsalmTexts(for keys: [String]) -> [String] {
        return keys.compactMap { psalms[$0] }
    }
}