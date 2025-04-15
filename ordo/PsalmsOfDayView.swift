//
//  PsalmsOfDayView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-10.
//

import SwiftUI

struct PsalmsOfDayView: View {
    let psalms: [PsalmUsage]
    @ObservedObject var tracker: PsalmObservableTracker
    let onSelect: (PsalmProgress) -> Void
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            psalmGridView
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
    
    private var headerView: some View {
        Text(title)
            .font(.headline)
    }
    
    private var psalmGridView: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 8) {
            ForEach(psalms, id: \.uniqueID) { psalm in
                PsalmButton(
                    number: psalm.number,
                    section: psalm.category,
                    isCompleted: tracker.isRead(number: Int(psalm.number) ?? 0, section: psalm.category)
                ) {
                    onSelect(
                        PsalmProgress(
                            number: Int(psalm.number) ?? 0,
                            section: psalm.category,
                            dateRead: Date(),
                            isCompleted: tracker.isRead(number: Int(psalm.number) ?? 0, section: psalm.category)
                        )
                    )
                }
            }
        }
    }
}
struct PsalmButton: View {
    let number: String
    let section: String?  // Uses 'section' to match PsalmProgress
    let isCompleted: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(number)
                    .font(.subheadline.weight(.medium))
                
                if let section = section {
                    Text(section)
                        .font(.caption2.weight(.bold))
                }
            }
            .frame(width: 60, height: 40)
            .background(isCompleted ? .green.opacity(0.2) : .blue.opacity(0.2))
            .cornerRadius(6)
        }
        .buttonStyle(.plain)
    }
}

// Add this extension to PsalmUsage for unique identification
extension PsalmUsage {
    var uniqueID: String {
        category != nil ? "\(number)-\(category!)" : number
    }
}
