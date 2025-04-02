// Updated ProgressSummaryView.swift
import SwiftUI

struct ProgressSummaryView: View {
    let psalmService: PsalmService
    @ObservedObject var tracker: PsalmObservableTracker
    @State private var selectedPsalm: PsalmProgress?
    
    var body: some View {
        let overall = tracker.overallProgress()
        let completionPercentage = Double(overall.completed) / Double(overall.total) * 100
        let completedPsalms = tracker.getCompletedPsalms()
        let incompletePsalms = tracker.getIncompletedPsalms()
        
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
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
                ForEach(psalms, id: \.number) { psalm in
                    Button {
                        selectedPsalm = psalm
                    } label: {
                        VStack {
                            Text("\(psalm.number)")
                                .font(.subheadline)
                            if let section = psalm.section {
                                Text(section)
                                    .font(.caption2)
                            }
                        }
                        .padding(6)
                        .background(color.opacity(0.2))
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

