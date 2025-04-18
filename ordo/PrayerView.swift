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
            
                //Text("Prayer for \(formattedDate)")
                //    .font(.title)
                //    .padding(.bottom)
                
                if let hour = hour {
                    // Display Introit if it exists
                    if !hour.introit.isEmpty {
                        PrayerSectionView(title: "🎵 Introit", content: hour.introit)
                            .padding(.bottom)
                            
                    }
                    // Display Hymn if it exists
                    
                    if let hymn = hour.hymn,  hourName != "Compline" {
                        let hymnText = hymn.getAppropriateText(for: liturgicalInfo)
                        if !hymnText.isEmpty {
                           PrayerSectionView(title: "🎶 Hymn", content: hymnText)
                               .padding(.bottom)
                        }
                    }
                    
                    // Display Psalms - updated logic
                    if let psalms = getPsalms(hour: hour) {
                        
                            ForEach(psalms) { psalm in
                                PsalmView(psalm: psalm, psalmService: psalmService)
                                    .environmentObject(observableTracker)
                                    //.debugPrint(psalm)
                                    .background(Color.gray.opacity(0.1))
                                    
                                    
                            }
                        
                    }
                    if let hymn = hour.hymn,  hourName == "Compline" {
                        let hymnText = hymn.getAppropriateText(for: liturgicalInfo)
                        if !hymnText.isEmpty {
                           PrayerSectionView(title: "🎶 Hymn", content: hymnText)
                               .padding(.bottom)
                        }
                    }
                   
                    
                    
                    let capitulumText = hour.capitulum.getAppropriateText(for: liturgicalInfo)
                    if !capitulumText.isEmpty {
                        PrayerSectionView(title: "📖 Capitulum", content: capitulumText)
                            .frame(alignment: .leading)
                            .padding(.bottom)
                    }
                    
                    if let versicleText = hour.versicle?.getAppropriateText(for: liturgicalInfo), !versicleText.isEmpty {
                        PrayerSectionView(title: "🕊️ Versicles", content: versicleText )
                            .frame(alignment: .leading)
                            .padding(.bottom)
                    }
                    let oratioText = hour.oratio.getAppropriateText(for: liturgicalInfo)
                        //.getText(for: feast, season: season.description , weekday: weekday)
                      
                    if !oratioText.isEmpty {
                        PrayerSectionView(title: "🙏 Oratio", content: oratioText)
                            .frame(alignment: .leading)
                            .padding(.bottom)
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
