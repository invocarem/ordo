//
//  Untitled.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-30.
//
import SwiftUI
struct ProgressDetailView: View {
    @ObservedObject var tracker: PsalmProgressTracker
    
    // Optional: Add filtering controls
    @State private var searchText = ""
    @State private var timeRange: TimeRange = .week
    
    enum TimeRange: String, CaseIterable {
        case week = "This Week"
        case month = "This Month"
        case all = "All Time"
    }
    
    var filteredPsalms: [PsalmProgress] {
        let calendar = Calendar.current
        let now = Date()
        
        return tracker.progress.filter { progress in
            // Filter by search text
            let matchesSearch = searchText.isEmpty ||
                "Psalm \(progress.number)".contains(searchText)
            
            // Filter by time range
            let matchesTimeRange: Bool = {
                switch timeRange {
                case .week:
                    return calendar.isDate(progress.dateRead, equalTo: now, toGranularity: .weekOfYear)
                case .month:
                    return calendar.isDate(progress.dateRead, equalTo: now, toGranularity: .month)
                case .all:
                    return true
                }
            }()
            
            return matchesSearch && matchesTimeRange
        }.sorted { $0.dateRead > $1.dateRead } // Newest first
    }
    
    var body: some View {
        List {
            // Time range picker
            Picker("Time Range", selection: $timeRange) {
                ForEach(TimeRange.allCases, id: \.self) { range in
                    Text(range.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .listRowSeparator(.hidden)
            
            // Search bar
            SearchBar(text: $searchText)
                .listRowSeparator(.hidden)
            
            // Data sections
            ForEach(groupedPsalms, id: \.key) { date, psalms in
                Section(header: Text(date.formatted(date: .abbreviated, time: .omitted))) {
                    ForEach(psalms, id: \.number) { progress in
                        HStack {
                            Text("Psalm \(progress.number)")
                            Spacer()
                            Text(progress.dateRead.formatted(date: .omitted, time: .shortened))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Reading History")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.grouped)
    }
    
    // Group psalms by date
    private var groupedPsalms: [(key: Date, value: [PsalmProgress])] {
        let grouped = Dictionary(grouping: filteredPsalms) { progress in
            Calendar.current.startOfDay(for: progress.dateRead)
        }
        return grouped.sorted { $0.key > $1.key }
    }
}

// Helper view for search
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search psalms...", text: $text)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }
}
