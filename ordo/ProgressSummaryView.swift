//
//  ProgressSummaryView.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-30.
//
import SwiftUI
struct ProgressSummaryView: View {
    let psalmService: PsalmService
    @ObservedObject var tracker: PsalmProgressTracker
    
    var body: some View {
        let weekly = tracker.weeklyProgress()
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Weekly Progress")
                .font(.headline)
            
            HStack {
                ProgressView(value: Double(weekly.completed),
                           total: Double(max(weekly.total, 1)))
                    .progressViewStyle(.linear)
                
                Text("\(weekly.completed)/\(weekly.total) psalms")
                    .font(.subheadline)
            }
            
            NavigationLink("View Details") {
                ProgressDetailView(tracker: tracker)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}
