// Updated ProgressSummaryView.swift
import SwiftUI

struct ProgressSummaryView: View {
    let psalmService: PsalmService
    private let hoursService = HoursService.shared
    @ObservedObject var tracker: PsalmObservableTracker
    @State private var selectedPsalm: PsalmProgress?
    let liturgicalDay: LiturgicalDay?
    @State private var dayPsalms: [String: [PsalmUsage]] = [:] // Hour key to psalms mapping

    var body: some View {
        let overall = tracker.overallProgress()
        let completionPercentage = Double(overall.completed) / Double(overall.total) * 100
        let completedPsalms = tracker.getCompletedPsalms()
        let incompletePsalms = tracker.getIncompletedPsalms()
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let liturgicalDay = liturgicalDay {
                                Text(liturgicalDay.weekday)
                                    .font(.caption)
                                    .padding(.top, 8)
                            }

                    if !dayPsalms.isEmpty {
                        psalmsOfTheDaySection()
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
                    PsalmDetailView(
                        number: psalm.number,
                        section: psalm.section,
                        psalmService: psalmService,
                        tracker: tracker
                    )
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
        
        var newDayPsalms: [String: [PsalmUsage]] = [:]
        
        for (hourKey, season) in canonicalHours {
            if let psalms = hoursService.getPsalmsForWeekday(
                weekday: liturgicalDay.weekday,
                hourKey: hourKey,
                season: season
            ) {
                newDayPsalms[hourKey] = psalms
            }
        }
        
        dayPsalms = newDayPsalms
    }
    
    private func psalmsOfTheDaySection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Psalms of the Day")
                .font(.headline)
            
            ForEach(dayPsalms.keys.sorted(), id: \.self) { hourKey in
                hourPsalmsSection(hourKey: hourKey)
            }
        }
    }

    private func hourPsalmsSection(hourKey: String) -> some View {
        Group {
            if let psalms = dayPsalms[hourKey], !psalms.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text(hourKey.capitalized)
                        .font(.subheadline.weight(.semibold))
                    
                    psalmGrid(psalms: psalms)
                }
                .padding()
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(8)
            }
        }
    }

    private func psalmGrid(psalms: [PsalmUsage]) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 8) {
            ForEach(psalms, id: \.number) { psalm in
                psalmButton(psalm: psalm)
            }
            .debugPrint(psalms)
        }
    }
    private func psalmButton(psalm: PsalmUsage) -> some View {
        // Attempt conversion
        if let psalmNumber = Int(psalm.number) {
            return AnyView(
                Button {
                    selectedPsalm = PsalmProgress(
                        number: psalmNumber,
                        section: psalm.category,
                        dateRead: Date(),
                        isCompleted: tracker.isRead(number: psalmNumber, section: psalm.category)
                    )
                } label: {
                    // ... same label view as above
                }
                .buttonStyle(.plain)
            )
        } else {
            return AnyView(
                Text("Invalid")
                    .frame(width: 60, height: 40)
                    .background(Color.red.opacity(0.2))
            )
        }
    }
    
    

    private func psalmBackground(psalm: PsalmUsage) -> some View {
        guard let number = Int(psalm.number) else {
               return Color.red.opacity(0.2) // Return a simple Color view for invalid case
           }
           
           return tracker.isRead(number: number, section: psalm.category) ?
               Color.green.opacity(0.2) :
               Color.blue.opacity(0.2)
    }
    
}

// Helper extension for error handling
extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
