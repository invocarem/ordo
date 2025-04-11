// Updated ProgressSummaryView.swift
import SwiftUI

struct ProgressSummaryView: View {
    let psalmService: PsalmService
    private let hoursService = HoursService.shared
    @ObservedObject var tracker: PsalmObservableTracker
    @State private var selectedPsalm: PsalmProgress?
    let liturgicalDay: LiturgicalDay?
    @State private var dayPsalms: [PsalmUsage] = [] // Hour key to psalms mapping

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
                            onSelect: { selectedPsalm = $0 }
                        )
                    }

                            
                    // Weekly Progress Section
                    Text("Weekly Progress")
                        .font(.headline)
                    
                    // Overall Progress Card
                    overallProgressCard(completed: overall.completed, total: overall.total, percentage: completionPercentage)
                    
                    // Completed Psalms Section
                    if !completedPsalms.isEmpty {
                        psalmsSection(
                            title: "Completed Psalms",
                            count: completedPsalms.count,
                            psalms: completedPsalms,
                            color: .blue
                        )
                    }
                    
                    // Incomplete Psalms Section
                    if !incompletePsalms.isEmpty {
                        psalmsSection(
                            title: "Incomplete Psalms",
                            count: incompletePsalms.count,
                            psalms: incompletePsalms,
                            color: .gray
                        )
                    }
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
            }
            
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
            ("sext", liturgicalDay.season.description),
            ("none", liturgicalDay.season.description),
            ("vespers", liturgicalDay.season.description),
            ("compline", liturgicalDay.season.description)
        ]
         var allPsalms: [PsalmUsage] = []
       
        
        for (hourKey, season) in canonicalHours {
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
    
    
    

    
    
    

   
    
}

// Helper extension for error handling
extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
