import SwiftUI
class PsalmTracker: ObservableObject {
    @Published private(set) var completedSections: [Int: Set<String>] = [:] // [PsalmNumber: Set<Section>]
    private let userDefaultsKey = "completedPsalmSections"
    
    // Check if entire psalm is completed
    func isPsalmCompleted(_ number: Int, totalSections: Int) -> Bool {
        guard let completed = completedSections[number] else { return false }
        return completed.count >= totalSections
    }
    
    // Toggle section completion
    func toggleSection(psalm number: Int, section: String) {
        if completedSections[number] == nil {
            completedSections[number] = []
        }
        
        if completedSections[number]?.contains(section) == true {
            completedSections[number]?.remove(section)
        } else {
            completedSections[number]?.insert(section)
        }
        saveProgress()
    }
    
    // Progress calculations
    var totalCompletedPsalms: Int {
        // Count psalms where all sections are completed
        return completedSections.reduce(0) { count, element in
            count + (isPsalmCompleted(element.key, totalSections: getTotalSections(for: element.key)) ? 1 : 0)
        }
    }
    
    private func getTotalSections(for psalmNumber: Int) -> Int {
        // You'll need to inject this from your service
        // For Psalm 119, this would return 22 (Aleph-Tav)
        let sections = PsalmService.shared.getPsalms(number: psalmNumber)
        return sections.count
    }
    
    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(completedSections) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadProgress() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([Int: Set<String>].self, from: data) {
            completedSections = decoded
        }
    }
}

struct PsalmTrackerView: View {
    let psalmService: PsalmService
    @StateObject private var tracker = PsalmTracker()
    @State private var selectedPsalmNumber = 119 // Default to 119 for demo
    @State private var psalmData: Psalm?
    
    var body: some View {
        NavigationView {
            VStack {
                // Progress Header
                progressHeader
                
                // Psalm Selection
                psalmSelector
                
                // Section Viewer
                if let psalm = psalmData {
                    SectionTrackerView(
                        psalm: psalm,
                        completedSections: tracker.completedSections[psalm.number] ?? [],
                        onToggleSection: { section in
                            tracker.toggleSection(psalm: psalm.number, section: section)
                        }
                    )
                }
                
                Spacer()
            }
            .navigationTitle("Psalm Tracker")
            .onAppear {
                loadPsalm(number: selectedPsalmNumber)
            }
        }
    }
    
    private var progressHeader: some View {
        VStack {
            Text("\(tracker.totalCompletedPsalms) of 150 Psalms Completed")
                .font(.headline)
            ProgressView(value: Double(tracker.totalCompletedPsalms), total: 150)
                .padding(.horizontal)
        }
    }
    
    private var psalmSelector: some View {
        Picker("Select Psalm", selection: $selectedPsalmNumber.onChange(loadPsalm)) {
            ForEach(1...150, id: \.self) { number in
                Text("Psalm \(number)").tag(number)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .padding()
    }
    
    private func loadPsalm(number: Int) {
        psalmData = psalmService.getPsalm(number: number)
    }
}

struct SectionTrackerView: View {
    let psalm: Psalm
    let completedSections: Set<String>
    let onToggleSection: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let sections = groupBySections() {
                    ForEach(sections, id: \.0) { section, verses in
                        SectionView(
                            title: section,
                            verses: verses,
                            isCompleted: completedSections.contains(section),
                            onToggle: { onToggleSection(section) }
                        )
                    }
                } else {
                    // For psalms without sections
                    SectionView(
                        title: "Psalm \(psalm.number)",
                        verses: psalm.text,
                        isCompleted: completedSections.contains("full"),
                        onToggle: { onToggleSection("full") }
                    )
                }
            }
            .padding()
        }
    }
    
    private func groupBySections() -> [(String, [String])]? {
        guard psalm.text.contains(where: { $0.hasPrefix("Section:") }) else {
            return nil
        }
        
        var sections = [(String, [String])]()
        var currentSection: String?
        var currentVerses = [String]()
        
        for verse in psalm.text {
            if verse.hasPrefix("Section:") {
                if let section = currentSection {
                    sections.append((section, currentVerses))
                }
                currentSection = verse.replacingOccurrences(of: "Section:", with: "").trimmingCharacters(in: .whitespaces)
                currentVerses = []
            } else {
                currentVerses.append(verse)
            }
        }
        
        if let section = currentSection {
            sections.append((section, currentVerses))
        }
        
        return sections.isEmpty ? nil : sections
    }
}

struct SectionView: View {
    let title: String
    let verses: [String]
    let isCompleted: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.accentColor) 
                Spacer()
                Button(action: onToggle) {
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isCompleted ? .green : .gray)
                }
            }
            
            ForEach(verses, id: \.self) { verse in
                Text(verse)
                    .padding(.vertical, 2)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .padding(.vertical, 4)
    }
}

// Helper extension for picker
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
