// Updated ProgressSummaryView.swift
import SwiftUI

struct ProgressSummaryView: View {
    let psalmService: PsalmService
    private let hoursService = HoursService.shared
    @ObservedObject var tracker: PsalmObservableTracker
    @State private var selectedPsalm: PsalmProgress?
    let liturgicalDay: LiturgicalDay?
    @State private var dayPsalms: [PsalmUsage] = [] // Hour key to psalms mapping
    @State private var showResetConfirmation = false
     @State private var weeklyIncompletePsalms: [PsalmUsage] = []
    
    var body: some View {
        let overall = tracker.overallProgress()
        let completionPercentage = Double(overall.completed) / Double(overall.total) * 100
        let completedPsalms = tracker.getCompletedPsalms()
        let incompletePsalms = tracker.getIncompletedPsalms()
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                   
                    if !dayPsalms.isEmpty {
                        PsalmsOfDayView(
                            psalms: dayPsalms,
                            tracker: tracker,
                            onSelect: { selectedPsalm = $0 },
                            title: "Psalms of the Day"
                        )
                    }
                   
                    // Weekly Incomplete Psalms Section
                    if !weeklyIncompletePsalms.isEmpty {
                        PsalmsOfDayView(
                            psalms: weeklyIncompletePsalms,
                            tracker: tracker,
                            onSelect: { selectedPsalm = $0 },
                            title: "Weekly Incomplete Psalms"
                        )
                    }
                            
                    // Weekly Progress Section
                    Text("Weekly Progress")
                        .font(.headline)
                    
                    // Overall Progress Card
                    overallProgressCard(completed: overall.completed, total: overall.total, percentage: completionPercentage)
                    
                    
                    
                    
                    resetButtonSection()
                    
                }
                .padding()
            }
            .navigationTitle("Psalm Progress")
            .sheet(item: $selectedPsalm) { psalm in
                NavigationStack {
                    StandalonePsalmView(
                           psalm: PsalmUsage(number: "\(psalm.number)", category: psalm.section),
                           psalmService: psalmService
                       )
                       .environmentObject(tracker)
                       
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                selectedPsalm = nil
                            }
                        }
                    }
                }
            }
            .onAppear {
                loadDayPsalms()
                print ("load weekly incomplete psalms...")
                loadWeeklyIncompletePsalms()
            }
            
        }
    }
    private func resetButtonSection() -> some View {
        VStack {
            Divider()
                .padding(.vertical, 8)
            
            Button {
                showResetConfirmation = true
            } label: {
                Label("Reset Progress", systemImage: "arrow.clockwise")
                    .foregroundColor(Color(uiColor: .systemTeal)) // Soft blue-green
                    .font(.subheadline.weight(.medium))
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(uiColor: .systemTeal).opacity(0.1))
                    )
            }
            .buttonStyle(.plain)
            .confirmationDialog(
                "Reset Progress?",
                isPresented: $showResetConfirmation,
                actions: {
                    // 1. Reset Button (your teal color)
                           Button("Reset") {
                               tracker.resetProgress()
                           }
                           
                           // 2. Cancel Button (will be gray automatically)
                           Button("Cancel", role: .cancel) {}
                },
                message: {
                    Text("Your completed psalms will be cleared.")
                }
            )
        }
    }
    
    private func overallProgressCard(completed: Int, total: Int, percentage: Double) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Overall Completion")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.1f%%", percentage))
                    .font(.headline.monospacedDigit())
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: Double(completed), total: Double(total))
                .progressViewStyle(.linear)
            
            HStack {
                Text("\(completed) completed")
                Spacer()
                Text("\(total - completed) remaining")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
    
    private func psalmsSection(title: String, count: Int, psalms: [PsalmProgress], color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text("\(count)")
                    .foregroundColor(.secondary)
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 8) {
                ForEach(psalms) { psalm in
                    Button {
                                       selectedPsalm = psalm
                                   } label: {
                                       VStack(spacing: 2) {
                                           Text("\(psalm.number)")
                                               .font(.subheadline.weight(.medium))
                                           if let section = psalm.section {
                                                               Text(section)
                                                                   .font(.caption2.weight(.bold))
                                                           }
                                       }
                                       .frame(width: 60, height: 40)
                                       .background(color.opacity(0.2))
                                       .cornerRadius(6)
                                   }
                                   .buttonStyle(.plain)
                                   .debugPrint(psalm)
                  
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
     private func loadDayPsalms() {
        guard let liturgicalDay = liturgicalDay else { return }
        
        let canonicalHours = [
            ("matins", liturgicalDay.benedictineSeason.description),
            ("lauds", liturgicalDay.benedictineSeason.description),
            ("prime", liturgicalDay.benedictineSeason.description),
            ("terce", liturgicalDay.benedictineSeason.description),
            ("sext", liturgicalDay.benedictineSeason.description),
            ("none", liturgicalDay.benedictineSeason.description),
            ("vespers", liturgicalDay.benedictineSeason.description),
            ("compline", liturgicalDay.benedictineSeason.description)
        ]
         var allPsalms: [PsalmUsage] = []
       
        
        for (hourKey, season) in canonicalHours {
            print ("hourKey: \(hourKey) benedictineSeason: \(season) liturgicalDay.weekday: \(liturgicalDay.weekday)")
            if let psalms = hoursService.getPsalmsForWeekday(
                weekday: liturgicalDay.weekday,
                hourKey: hourKey,
                season: season
            ) {
                allPsalms.append(contentsOf: psalms)
                
            }
        }
        
         dayPsalms = allPsalms
    }
    private func loadWeeklyIncompletePsalms() {
        guard let currentDay = liturgicalDay else { return }
        
        let currentWeekday = currentDay.weekday // This is a string like "Sunday", "Monday", etc.
        
        var weeklyIncomplete: [PsalmUsage] = []
        
        // Define weekday names in order (Sunday to Saturday)
        let weekdayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        
        // Find the index of the current weekday
        guard let currentWeekdayIndex = weekdayNames.firstIndex(of: currentWeekday) else {
            return // Exit if currentWeekday is invalid
        }
        
        // Iterate over days from Sunday (0) to currentWeekday
        for day in 0...currentWeekdayIndex {
            let weekdayName = weekdayNames[day] // Get the weekday name for this day
            
            let canonicalHours = [
                ("matins", currentDay.benedictineSeason.description),
                ("lauds", currentDay.benedictineSeason.description),
                ("prime", currentDay.benedictineSeason.description),
                ("terce", currentDay.benedictineSeason.description),
                ("sext", currentDay.benedictineSeason.description),
                ("none", currentDay.benedictineSeason.description),
                ("vespers", currentDay.benedictineSeason.description),
                ("compline", currentDay.benedictineSeason.description)
            ]
            
            for (hourKey, season) in canonicalHours {
                if let psalms = hoursService.getPsalmsForWeekday(
                    weekday: weekdayName,
                    hourKey: hourKey,
                    season: season
                ) {
                    for psalm in psalms {
                        let isCompleted = tracker.getProgress(
                            number: Int(psalm.number)!,
                            section: psalm.category
                        )?.isCompleted ?? false
                        
                        if !isCompleted && !weeklyIncomplete.contains(where: { $0.uniqueID == psalm.uniqueID }) {
                            weeklyIncomplete.append(psalm)
                        }
                    }
                    
                }
            }
        }
        
        weeklyIncompletePsalms = weeklyIncomplete.sorted {
                Int($0.number) ?? 0 < Int($1.number) ?? 0
            }
    }
   
        
        
    
    
    

    
    
    

   
    
}

// Helper extension for error handling
extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
