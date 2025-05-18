//
//  PsalmAnalysisView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-30.
//

//
//  PsalmAnalysisSectionView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-25.
//
//
//  PsalmAnalysisSectionView.swift
//  ordo
//

import SwiftUI

struct PsalmAnalysisSelectionView: View {
    // MARK: - Dependencies
    let latinService: LatinService
    let psalmService: PsalmService
    let hoursService = HoursService.shared
    let liturgicalDay: LiturgicalDay?
    let hourKey: String?
    
    // MARK: - State
    @State private var psalms: [String: [String]] = [:]
    @State private var availablePsalms: [PsalmUsage] = []
    @State private var selectedPsalm: PsalmUsage?
    @State private var isLoading = true
    @State private var currentAnalysis: PsalmAnalysisResult?
        
    
    // MARK: - Constants
    private let psalmUsages: [PsalmUsage] = [
        PsalmUsage(number: "118", category: "aleph"),
        PsalmUsage(number: "4"),
        PsalmUsage(number: "90"),
        PsalmUsage(number: "133"),
        PsalmUsage(number: "17", category: "B"),
        PsalmUsage(number: "109"),
        PsalmUsage(number: "66")
    ]
    
    // MARK: - Initialization
    init(latinService: LatinService,
         psalmService: PsalmService,
         liturgicalDay: LiturgicalDay?,
         hourKey: String?) {
        self.latinService = latinService
        self.psalmService = psalmService
        self.liturgicalDay = liturgicalDay
        self.hourKey = hourKey
    }
    
    // MARK: - Main View
    var body: some View {
            Group {
                if isLoading {
                    loadingView
                } else {
                    contentView
                }
            }
            .navigationTitle(navigationTitle)
            .task { await loadData() }
        }
        
        private var contentView: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    hourHeader
                    psalmGrid
                    analysisView
                }
                .padding(.vertical)
            }
        }
    
    
    // MARK: - Subviews
    private var loadingView: some View {
        ProgressView()
    }
    
    
    
    private var hourHeader: some View {
        Group {
            if let hourKey = hourKey {
                Text(hourKey.capitalized)
                    .font(.title2.bold())
                    .padding(.horizontal)
            }
        }
    }
    
    private var psalmGrid: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 80)),
                     GridItem(.adaptive(minimum: 80))],
            spacing: 12
        ) {
            ForEach(availablePsalms) { psalm in
                PsalmGridItem(
                    psalm: psalm,
                    isLoading: psalms[psalm.id] == nil,
                    isSelected: selectedPsalm?.id == psalm.id
                ) {
                    withAnimation {
                        togglePsalmSelection(psalm)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var analysisView: some View {
            if let selectedPsalm = selectedPsalm,
               let psalmText = psalms[selectedPsalm.id] {
                // Create a new analysis when the psalm changes
                let analysis = latinService.analyzePsalm(text: psalmText.joined(separator: " "))
                
                LinePairAnalysisView(
                    latinService: latinService,
                    psalmText: psalmText,
                    psalmTitle: selectedPsalm.displayTitle
                )
                .padding(.horizontal)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .id(selectedPsalm.id) // This forces SwiftUI to recreate the view when the ID changes
            }
        }
   
    
    private var navigationTitle: String {
        hourKey != nil ? "\(hourKey!.capitalized) Analysis" : "Psalm Analysis"
    }
    
    // MARK: - Helper Methods
    private func togglePsalmSelection(_ psalm: PsalmUsage) {
        if selectedPsalm?.id == psalm.id {
            selectedPsalm = nil
        } else {
            selectedPsalm = psalm
        }
    }
    
    // MARK: - Data Loading
    private func loadData() async {
        await loadAvailablePsalms()
        await loadPsalmTexts()
        isLoading = false
    }
    
    private func loadAvailablePsalms() async {
        if let hourKey = hourKey, let liturgicalDay = liturgicalDay {
            await loadHourPsalms(hourKey: hourKey, liturgicalDay: liturgicalDay)
        } else {
            availablePsalms = psalmUsages
        }
    }
    
    private func loadHourPsalms(hourKey: String, liturgicalDay: LiturgicalDay) async {
        if let hourPsalms = hoursService.getPsalmsForWeekday(
            weekday: liturgicalDay.weekday,
            hourKey: hourKey,
            season: liturgicalDay.benedictineSeason.description
        ) {
            availablePsalms = hourPsalms
        } else {
            availablePsalms = psalmUsages
        }
    }
    
    private func loadPsalmTexts() async {
        psalms = [:]
        
        for usage in availablePsalms {
            guard let number = Int(usage.number) else { continue }
            
            if let psalm = psalmService.getPsalm(number: number, section: usage.category) {
                psalms[usage.id] = psalm.text
            }
        }
    }
}

// MARK: - Grid Item View
struct PsalmGridItem: View {
    let psalm: PsalmUsage
    let isLoading: Bool
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                if isLoading {
                    ProgressView()
                        .frame(height: 20)
                } else {
                    Text(psalm.number)
                        .font(.headline)
                }
                
                if let category = psalm.category {
                    Text(category)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .padding(8)
            .background(background)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private var background: Color {
        isSelected ? Color.accentColor.opacity(0.2) : Color(.secondarySystemBackground)
    }
    
    private var borderColor: Color {
        isSelected ? .accentColor : Color(.separator)
    }
}


// Helper view for statistics
struct StatView: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .bold()
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// Helper view for sections
struct LatinSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 12) {
                content
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

// Word row view
struct WordRow: View {
    let lemma: String
    let info: PsalmAnalysisResult.LemmaInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(lemma).bold()
                if let translation = info.translation {
                    Text(translation)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Text("\(info.count)×")
                .font(.headline)
        }
    }
}
   
                  
                           
                      
    
  
   


// Extension for display formatting
extension PsalmUsage {
    var displayTitle: String {
        if let category = category {
            return "Psalm \(number) (\(category))"
        }
        return "Psalm \(number)"
    }
}

