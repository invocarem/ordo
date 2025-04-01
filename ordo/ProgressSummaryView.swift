//
//  ProgressSummaryView.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-30.
//
import SwiftUI
struct ProgressSummaryView: View {
    let psalmService: PsalmService
    @ObservedObject var tracker: PsalmObservableTracker
    
    var body: some View {
        let overall = tracker.overallProgress()
        let completionPercentage = Double(overall.completed) / Double(overall.total) * 100
        VStack(alignment: .leading, spacing: 8) {
            Text("Weekly Progress")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Overall Completion")
                        .font(.headline)
                    Spacer()
                    Text(String(format: "%.1f%%", completionPercentage))
                        .font(.headline.monospacedDigit())
                        .foregroundColor(.secondary)
                }
                
                ProgressView(value: Double(overall.completed),
                           total: Double(overall.total))
                    .progressViewStyle(.linear)
                
                HStack {
                    Text("\(overall.completed) completed")
                    Spacer()
                    Text("\(overall.total - overall.completed) remaining")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

              
