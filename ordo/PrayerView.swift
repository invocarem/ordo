import SwiftUI
struct PrayerView: View {
    let date: Date
    let liturgicalInfo: LiturgicalDay
    let hour: Hour?
    
    let hourName: String  // Explicit hour name
    
    let weekday: String
    let psalmService: PsalmService
    private let hoursService = HoursService.shared
    
    @EnvironmentObject private var observableTracker: PsalmObservableTracker
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Prayer for \(formattedDate)")
                    .font(.title)
                    .padding(.bottom)
                
                if let hour = hour {
                    // Display Introit if it exists
                    if !hour.introit.isEmpty {
                        PrayerSectionView(title: "🎵 Introit", content: hour.introit)
                    }
                    
                    // Display Hymn if it exists
                    if let hymn = hour.hymn, !hymn.isEmpty {
                        PrayerSectionView(title: "🎶 Hymn", content: getHymnContent(hymn: hymn))
                    }
                    
                    // Display Psalms - updated logic
                    if let psalms = getPsalms(hour: hour) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            ForEach(psalms) { psalm in
                                //print("\(psalm\)")
                                PsalmView(psalm: psalm, psalmService: psalmService)
                                    .environmentObject(observableTracker)
                                    .debugPrint(psalm)
                            }
                        }
                    }
                    let feast = liturgicalInfo.feast?.name
                    let season = liturgicalInfo.season
                    let weekday = liturgicalInfo.weekday
                    let capitulumText = hour.capitulum.getText(for: feast, season: season.description , weekday: weekday)
                      
                    if !capitulumText.isEmpty {
                        PrayerSectionView(title: "📖 Capitulum", content: [capitulumText])
                    }
                    if let versicle = hour.versicle, !versicle.isEmpty {
                        PrayerSectionView(title: "🕊️ Versicles", content: versicle.map { $0 ?? "" }) // Replace nil with ""
                    }
                    let oratioText = hour.oratio.getText(for: feast, season: season.description , weekday: weekday)
                      
                    if !oratioText.isEmpty {
                        PrayerSectionView(title: "🙏 Oratio", content: [oratioText])
                    }
                    
                } else {
                    Text("Hour not found")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(hourName) // Dynamic title
    }
    
    // Add this helper function to your PrayerView
    private func getHymnContent(hymn: HymnUnion) -> [String] {
        switch hymn {
        case .lines(let lines):
            return lines
        case .structured(let data):
            // Here you could add logic to check liturgicalInfo for seasons/feasts
            // and return the appropriate text
            return [data.default]
        }
    }

    
    // New helper methods
    private func getPsalms(hour: Hour) -> [PsalmUsage]? {
        print("⏳ Starting getPsalms for \(hourName) \(weekday)")
        
        return hoursService.getPsalmsForWeekday(weekday: weekday, hourKey: hourName.lowercased(), season: "winter")
            
        
    }
    
    private func psalmSectionTitle(hour: Hour) -> String {
        if hour.psalms.default != nil {
            return "📖 Psalms"
        } else {
            return "📖 Psalms for \(weekday)"
        }
    }
    
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
   

    private func allPsalmsCompleted(_ psalms: [PsalmUsage]) -> Bool {
           return psalms.allSatisfy { psalm in
               if let number = Int(psalm.number) {
                   return observableTracker.getProgress(number: number, section: psalm.category)?.isCompleted ?? false
               }
               return false
           }
       }
    
}
struct PrayerSectionView: View {
    let title: String
    let content: [String]
    let contentB: [String]?
    var showToggle: Bool
    var isCompleted: Binding<Bool>?
    var onToggle: ((Bool) -> Void)?
    
    @State private var expandedLines: Set<Int> = []
    
    init(title: String,
         content: [String],
         contentB: [String]? = nil,
         showToggle: Bool = false,
         isCompleted: Binding<Bool>? = nil,
         onToggle: ((Bool) -> Void)? = nil) {
        self.title = title
        self.content = content
        self.contentB = contentB
        self.showToggle = showToggle
        self.isCompleted = isCompleted
        self.onToggle = onToggle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with title and toggle
            headerView
            
            // Main content with tap-to-reveal functionality
            if let contentB = contentB {
                bilingualContentView(contentB: contentB)
            } else {
                simpleContentView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Text(title)
                .font(.headline)
            
            if showToggle, let binding = isCompleted {
                Spacer()
                Toggle("", isOn: binding)
                    .toggleStyle(CircleToggleStyle())
                    .labelsHidden()
                    .onChange(of: binding.wrappedValue) { oldValue, newValue in
                        onToggle?(newValue)
                    }
            }
        }
        .padding(.bottom, 2)
    }
    
    private var simpleContentView: some View {
        VStack(alignment: .leading) {
            ForEach(content, id: \.self) { line in
                Text(line)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private func bilingualContentView(contentB: [String]) -> some View {
        VStack(alignment: .leading) {
            ForEach(0..<content.count, id: \.self) { index in
                VStack(alignment: .leading) {
                    // Latin text (always shown)
                    Text(content[index])
                        .fontWeight(.medium) // Latin slightly bolder
                        .foregroundColor(.primary)
                        .onTapGesture {
                            withAnimation {
                                toggleLineExpansion(index)
                            }
                        }
                    
                    // English translation (shown when expanded)
                    if expandedLines.contains(index) {
                        Text(contentB[index])
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                            .transition(.opacity)
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func toggleLineExpansion(_ index: Int) {
        if expandedLines.contains(index) {
            expandedLines.remove(index)
        } else {
            expandedLines.insert(index)
        }
    }
}

// Your existing CircleToggleStyle remains the same
struct CircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .blue : .gray)
        }
        .buttonStyle(.plain)
    }
}



extension View {
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print("DEBUG:", value)
        #endif
        return self
    }
}
