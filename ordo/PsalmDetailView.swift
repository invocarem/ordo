//
//  PsalmDetailView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-02.
//
import SwiftUI
struct PsalmDetailView: View {
    let number: Int
    let section: String?
    let psalmService: PsalmService
    @ObservedObject var tracker: PsalmObservableTracker
    
    @State private var psalmContent: [String] = []
    @State private var errorMessage: String?
    @State private var isCompleted: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Header with completion toggle
                //HStack {
                //    Text(psalmHeader)
                //        .font(.headline)
                //    Spacer()
                //    Button(action: toggleCompletion) {
                //        Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                //            .foregroundColor(isCompleted ? .green : .gray)
                //            .imageScale(.large)
                //    }
                //    .buttonStyle(.plain)
                //}
                //.padding(.horizontal)
                
                // Content using PrayerSectionView
                if let errorMessage = errorMessage {
                    PrayerSectionView(
                        title: "Error",
                        content: [errorMessage]
                    )
                    .foregroundColor(.red)
                } else if !psalmContent.isEmpty {
                    PrayerSectionView(
                        title: "Psalm \(number) \(section ?? "")",
                        content: psalmContent,
                        showToggle: true,
                        isCompleted: $isCompleted
                    )
                    .padding(.top, 0)
                } else {
                    PrayerSectionView(
                        title: "Loading",
                        content: ["Loading psalm content..."]
                    )
                }
            }
            .padding()
        }
        .onAppear {
            loadPsalmContent()
            loadCompletionState()
        }
    }
    
    private var psalmHeader: String {
        var header = "Psalm \(number)"
        if let section = section {
            header += " (\(section))"
        }
        return header
    }
    
    private func loadPsalmContent() {
        do {
            let psalmSections = psalmService.getPsalms(number: number)
            
            if psalmSections.isEmpty {
                throw PsalmError.versesNotFound(number)
            }
            
            if let section = section {
                guard let psalmSection = psalmSections.first(where: { $0.section?.lowercased() == section.lowercased() }) else {
                    throw PsalmError.versesNotFound(number)
                }
                psalmContent = psalmSection.text
            } else {
                psalmContent = psalmSections.first?.text ?? []
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func toggleCompletion() {
        isCompleted.toggle()
        tracker.markPsalm(
            number: number,
            section: section,
            completed: isCompleted
        )
    }
    
    private func loadCompletionState() {
        if let progress = tracker.getProgress(number: number, section: section) {
            isCompleted = progress.isCompleted
        }
    }
}
