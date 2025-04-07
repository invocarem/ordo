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
    @State private var psalmEnglishContent: [String]? = []
    
    // Alternative initializer for PsalmUsage
       init(psalm: PsalmUsage, psalmService: PsalmService, tracker: PsalmObservableTracker) {
           self.number = Int(psalm.number) ?? 0
           self.section = psalm.category
           self.psalmService = psalmService
           self.tracker = tracker
       }
       
       // Original initializer
       init(number: Int, section: String?, psalmService: PsalmService, tracker: PsalmObservableTracker) {
           self.number = number
           self.section = section
           self.psalmService = psalmService
           self.tracker = tracker
       }
    
    var body: some View {
            VStack(spacing: 16) {
               
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
                        contentB: psalmEnglishContent,
                        showToggle: true,
                        isCompleted: $isCompleted,
                        onToggle: { newValue in
                            tracker.markPsalm(number: number, section: section, completed: newValue)
                        }
                    )
                    .debugPrint("number: \(number) section: \(section ?? "")")
                } else {
                    PrayerSectionView(
                        title: "Loading",
                        content: ["Loading psalm content..."]
                    )
                }
            }
            .frame(alignment: .leading)
            .padding(.horizontal)
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
                psalmEnglishContent = psalmSection.englishText
                psalmContent = psalmSection.text
                
            } else {
                psalmEnglishContent = psalmSections.first?.englishText ?? []
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
