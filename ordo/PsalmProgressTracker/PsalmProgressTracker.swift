import Foundation

public struct PsalmProgress: Codable, Identifiable, CustomStringConvertible  {
    public var id: String
    
    public let number: Int
    public let section: String?     // Optional (e.g., "A", "Aleph")
    public var dateRead: Date
    public var isCompleted: Bool
    
    public init(number: Int, section: String? = nil, dateRead: Date = Date(), isCompleted: Bool = true) {
        self.number = number
        self.section = section
        self.dateRead = dateRead
        self.isCompleted = isCompleted
        if let section = section, !section.isEmpty {
                   self.id = "\(number)-\(section)"
               } else {
                   self.id = "\(number)"
               }
    }
    public var description: String {
        let sectionDisplay = section != nil ? " \(section!)" : ""
        let status = isCompleted ? "✓" : "✗"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return "Psalm \(number)\(sectionDisplay): \(status) (\(formatter.string(from: dateRead)))"
    }
    // Helper to match a psalm by number and section
    func matches(number: Int, section: String?) -> Bool {
        return self.number == number && self.section == section
    }
}

public final class PsalmProgressTracker {
    private let saveURL: URL
    private let totalPsalmCount: Int
    public private(set) var progress: [PsalmProgress] = [] {
        didSet {
            saveProgress()
        }
    }
    
    public init(savePath: String? = nil, totalPsalmCount: Int = 180) {
        let path = savePath ?? "psalm_progress.json"
        self.saveURL = URL(fileURLWithPath: path)
        self.totalPsalmCount = totalPsalmCount
        loadProgress()
    }
    
    // MARK: - Public Methods
    public func isRead(number: Int, section: String? = nil) -> Bool {
        return getProgress(number: number, section: section)?.isCompleted ?? false
    }

    public func markAsRead(number: Int, section: String? = nil) {
        markPsalm(number: number, section: section, completed: true)
    }

    public func resetProgress() {
        progress = []
    }
    
    /// Marks a psalm as completed or not completed
    public func markPsalm(number: Int, section: String? = nil, completed: Bool = true) {
        if let index = progress.firstIndex(where: { $0.matches(number: number, section: section) }) {
            progress[index].isCompleted = completed
            progress[index].dateRead = Date() // Update read date when marking
        } else {
            progress.append(PsalmProgress(
                number: number,
                section: section,
                isCompleted: completed
            ))
        }
    }
    
    /// Gets progress for a specific psalm
    public func getProgress(number: Int, section: String? = nil) -> PsalmProgress? {
        return progress.first { $0.matches(number: number, section: section) }
    }

    public func overallProgress() -> (completed: Int, total: Int) {
        let completedCount = progress.filter { $0.isCompleted }.count
        return (completedCount, totalPsalmCount)
    }
        
     public func weeklyProgress() -> (completed: Int, newlyRead: Int) {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents(
            [.yearForWeekOfYear, .weekOfYear], 
            from: Date()
        ))!
        
        let weeklyPsalms = progress.filter { $0.dateRead >= startOfWeek }
        let newlyRead = weeklyPsalms.count
        let completed = weeklyPsalms.filter { $0.isCompleted }.count
        
        return (completed, newlyRead)
    }
  
     /// Returns formatted string with all completed psalms
    public func completedPsalmsReport() -> String {
        let completed = progress
            .filter { $0.isCompleted }
            .sorted { $0.number < $1.number || ($0.number == $1.number && ($0.section ?? "") < ($1.section ?? "")) }
        
        guard !completed.isEmpty else {
            return "No psalms completed yet"
        }
        
        var report = ["COMPLETED PSALMS:"]
        report += completed.map { $0.description }
        report.append("Total: \(completed.count)/\(totalPsalmCount)")
        return report.joined(separator: "\n")
    }
    public func getCompletedPsalms() -> [PsalmProgress] {
        return progress
                .filter { $0.isCompleted }
                .sorted {
                    $0.number < $1.number ||
                    ($0.number == $1.number && ($0.section ?? "") < ($1.section ?? ""))
                }
          
        }
    
    public func getIncompletedPsams() ->[PsalmProgress] {
       return progress
            .filter { !$0.isCompleted }
            .sorted { $0.number < $1.number || ($0.number == $1.number && ($0.section ?? "") < ($1.section ?? "")) }
        
    }
    /// Returns formatted string with all incomplete psalms
    public func incompletePsalmsReport() -> String {
        let incomplete = progress
            .filter { !$0.isCompleted }
            .sorted { $0.number < $1.number || ($0.number == $1.number && ($0.section ?? "") < ($1.section ?? "")) }
        
        guard !incomplete.isEmpty else {
            return "All tracked psalms are completed!"
        }
        
        var report = ["INCOMPLETE PSALMS:"]
        report += incomplete.map { $0.description }
        return report.joined(separator: "\n")
    }

    public func fullProgressReport() -> String {
        let completedCount = progress.filter { $0.isCompleted }.count
        let completionPercentage = Double(completedCount) / Double(totalPsalmCount) * 100
        
        let report = [
            "PROGRESS SUMMARY",
            "---------------",
            "Completed: \(completedCount)/\(totalPsalmCount)",
            String(format: "Completion: %.1f%%", completionPercentage),
            "",
            completedPsalmsReport(),
            "",
            incompletePsalmsReport()
        ]
        
        return report.joined(separator: "\n")
    }
    
    
    // MARK: - Private Methods
    private func loadProgress() {
        guard FileManager.default.fileExists(atPath: saveURL.path) else { return }
        do {
            let data = try Data(contentsOf: saveURL)
            progress = try JSONDecoder().decode([PsalmProgress].self, from: data)
        } catch {
            print("Failed to load progress: \(error.localizedDescription)")
        }
    }
    
    private func saveProgress() {
        do {
            let data = try JSONEncoder().encode(progress)
            try FileManager.default.createDirectory(
                at: saveURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            try data.write(to: saveURL, options: .atomic)
        } catch {
            print("Failed to save progress: \(error.localizedDescription)")
        }
    }
}
