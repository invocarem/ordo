import SwiftUI
struct PrayerView: View {
    let date: Date
    let liturgicalInfo: String
    let hour: Hour?
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
                        PrayerSectionView(title: "🎶 Hymn", content: hour.hymn)
                    }
                    
                    // Display Psalms
                    if let psalms = getPsalmsForWeekday(weekday, hour: hour) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("📖 Psalms for \(weekday)")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            ForEach(psalms, id: \.number) { psalm in
                                PsalmView(psalm: psalm, psalmService: psalmService)
                            }
                        }
                    }
                    
                    // Display Capitulum if it exists
                    if !hour.capitulum.isEmpty {
                        PrayerSectionView(title: "📖 Capitulum", content: [hour.capitulum])
                    }
                    
                    // Display Versicles if they exist
                    if !hour.versicle.compactMap({ $0 }).isEmpty {
                        PrayerSectionView(title: "🕊️ Versicle", content: hour.versicle.compactMap { $0 })
                    }
                    
                    // Display Oratio if it exists
                    if !hour.oratio.isEmpty {
                        PrayerSectionView(title: "🙏 Oratio", content: [hour.oratio])
                    }
                } else {
                    Text("Prime hour not found")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Prime Hour")
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    private func getPsalmsForWeekday(_ weekday: String, hour: Hour) -> [PsalmUsage]? {
        switch weekday.lowercased() {
        case "sunday": return hour.psalms.sunday
        case "monday": return hour.psalms.monday
        case "tuesday": return hour.psalms.tuesday
        case "wednesday": return hour.psalms.wednesday
        case "thursday": return hour.psalms.thursday
        case "friday": return hour.psalms.friday
        case "saturday": return hour.psalms.saturday
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
