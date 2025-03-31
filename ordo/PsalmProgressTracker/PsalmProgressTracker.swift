import Foundation

public struct PsalmProgress: Codable {
    public let number: Int
    public let dateRead: Date
    public var isCompleted: Bool
    
    public init(number: Int, dateRead: Date = Date(), isCompleted: Bool = true) {
        self.number = number
        self.dateRead = dateRead
        self.isCompleted = isCompleted
    }
}

public final class PsalmProgressTracker : ObservableObject {
    private let saveURL: URL
    public private(set) var progress: [PsalmProgress] = [] {
        didSet {
            saveProgress() // Auto-save when progress changes
        }
    }
    
    public init(savePath: String? = nil) {
        self.saveURL = URL(fileURLWithPath: savePath ?? "psalm_progress.json")
        loadProgress()
    }
    
    // MARK: - Public Methods
    public func markPsalm(_ number: Int, completed: Bool = true) {
        if let index = progress.firstIndex(where: { $0.number == number }) {
            progress[index].isCompleted = completed
        } else {
            progress.append(PsalmProgress(number: number, isCompleted: completed))
        }
    }
    
    public func weeklyProgress() -> (total: Int, completed: Int) {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents(
            [.yearForWeekOfYear, .weekOfYear], 
            from: Date()
        ))!
        
        let weeklyPsalms = progress.filter { $0.dateRead >= startOfWeek }
        return (weeklyPsalms.count, weeklyPsalms.filter { $0.isCompleted }.count)
    }
    
    // MARK: - Private Methods
    private func loadProgress() {
        guard let data = try? Data(contentsOf: saveURL) else { return }
        progress = (try? JSONDecoder().decode([PsalmProgress].self, from: data)) ?? []
    }
    private func saveProgress() {
        do {
            let data = try JSONEncoder().encode(progress)
            try data.write(to: saveURL)
        } catch {
            print("Failed to save progress: \(error.localizedDescription)")
        }
    }
    
 
}
