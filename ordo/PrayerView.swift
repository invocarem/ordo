import SwiftUI
struct PrayerView: View {
    let date: Date
    let liturgicalInfo: LiturgicalDay
    let hour: Hour?
    
    let hourName: String  // Explicit hour name
    
    let weekday: String
    let psalmService: PsalmService
    
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
                            //Text(psalmSectionTitle(hour: hour))
                            //    .font(.headline)
                            //    .padding(.bottom, 4)
                            //if allPsalmsCompleted(psalms) {
                            //                                    Image(systemName: "checkmark.circle.fill")
                            //                                        .foregroundColor(.green)
                            //                                }
                            ForEach(psalms.indices, id: \.self) { index in
                                let psalm = psalms[index]
                                PsalmView(psalm: psalm, psalmService: psalmService)
                                    .environmentObject(observableTracker) // Pass the tracker
                                    .id("\(psalm.id)-\(index)")  // Add index as fallback
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
        var psalms = [PsalmUsage]()
        
        // Add default psalms first (for Lauds, these are 66, 50, 117, 62)
        if let defaultPsalms = hour.psalms.default {
            psalms.append(contentsOf: defaultPsalms)
        }
        
        // Add weekday-specific psalms
        switch weekday.lowercased() {
        case "sunday":
            if let sundayPsalms = hour.psalms.sunday {
                psalms.append(contentsOf: sundayPsalms)
            }
        case "monday":
            if let mondayPsalms = hour.psalms.monday {
                psalms.append(contentsOf: mondayPsalms)
            }
        case "tuesday":
            if let tuesdayPsalms = hour.psalms.tuesday {
                psalms.append(contentsOf: tuesdayPsalms)
            }
        case "wednesday":
            if let wednesdayPsalms = hour.psalms.wednesday {
                psalms.append(contentsOf: wednesdayPsalms)
            }
        case "thursday":
            if let thursdayPsalms = hour.psalms.thursday {
                psalms.append(contentsOf: thursdayPsalms)
            }
        case "friday":
            if let fridayPsalms = hour.psalms.friday {
                psalms.append(contentsOf: fridayPsalms)
            }
        case "saturday":
            if let saturdayPsalms = hour.psalms.saturday {
                psalms.append(contentsOf: saturdayPsalms)
            }
        default:
            break
        }
        
        return psalms.isEmpty ? nil : psalms
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
    var showToggle: Bool
    var isCompleted: Binding<Bool>?
    
    init(title: String, content: [String], showToggle: Bool = false, isCompleted: Binding<Bool>? = nil) {
        self.title = title
        self.content = content
        self.showToggle = showToggle
        self.isCompleted = isCompleted
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                
                if showToggle, let binding = isCompleted {
                    Spacer()
                    Toggle("", isOn: binding)
                        .labelsHidden()
                }
            }
            .padding(.bottom, 2)
            
            ForEach(content, id: \.self) { line in
                Text(line)
                    .fixedSize(horizontal: false, vertical: true)
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
}
