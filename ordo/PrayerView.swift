import SwiftUI
struct PrayerView: View {
    let date: Date
    let liturgicalInfo: String
    let hour: Hour?
    
    let hourName: String  // Explicit hour name
    
    let weekday: String
    let psalmService: PsalmService
    
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
                    if !hour.hymn.isEmpty {
                        PrayerSectionView(title: "🎶 Hymn", content: getHymnContent(hymn: hour.hymn))
                    }
                    
                    // Display Psalms - updated logic
                    if let psalms = getPsalms(hour: hour) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text(psalmSectionTitle(hour: hour))
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            ForEach(psalms.indices, id: \.self) { index in
                                let psalm = psalms[index]
                                PsalmView(psalm: psalm, psalmService: psalmService)
                                    .id("\(psalm.id)-\(index)")  // Add index as fallback
                            }
                           
                        }
                    }
                    if !hour.capitulum.isEmpty {
                        PrayerSectionView(title: "📖 Capitulum", content: [hour.capitulum])
                    }
                    if !hour.versicle.isEmpty {
                        PrayerSectionView(title: "🕊️ Versicles", content: hour.versicle.map { $0 ?? "" }) // Replace nil with ""
                    }
                    if !hour.oratio.isEmpty {
                        PrayerSectionView(title: "🙏 Oratio", content: [hour.oratio])
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
            return [data.defaultText]
        }
    }

    
    // New helper methods
    private func getPsalms(hour: Hour) -> [PsalmUsage]? {
        if hour.psalms.default != nil {
            return hour.psalms.default
        } else {
            return getPsalmsForWeekday(weekday, hour: hour)
        }
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
   
    func getPsalmsForWeekday(_ weekday: String, hour: Hour) -> [PsalmUsage]? {
        switch weekday.lowercased() {
        case "sunday": return hour.psalms.sunday ?? []
        case "monday": return hour.psalms.monday ?? []
        case "tuesday": return hour.psalms.tuesday ?? []
        case "wednesday": return hour.psalms.wednesday  ?? []
        case "thursday": return hour.psalms.thursday ?? []
        case "friday": return hour.psalms.friday ?? []
        case "saturday": return hour.psalms.saturday ?? []
        default: return nil
        }
    }
    
}


struct PrayerSectionView: View {
    let title: String
    let content: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 2)
            
            ForEach(content, id: \.self) { line in
                Text(line)
                    .fixedSize(horizontal: false, vertical: true) // Allow text to wrap
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Match width to PsalmView
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
