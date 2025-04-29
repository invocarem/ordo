//
//  PsalmAnalysisSectionView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-25.
//
import SwiftUI
struct PsalmAnalysisSelectionView: View {
    let latinService: LatinService
    let psalmService: PsalmService
    let hoursService = HoursService.shared
    let liturgicalDay: LiturgicalDay?
    let hourKey: String?
    
    // Hardcoded psalms as fallback
    let psalmUsages: [PsalmUsage] = [
        PsalmUsage(number: "118", category: "aleph"),
        PsalmUsage(number: "4"),
        PsalmUsage(number: "90"),
        PsalmUsage(number: "133"),
        PsalmUsage(number: "17", category: "B"),
        PsalmUsage(number: "109"),
        PsalmUsage(number: "66")
    ]
    
    @State private var psalms: [String: [String]] = [:]
    @State private var availablePsalms: [PsalmUsage] = []
    @State private var selectedPsalmId: String
    @State private var isLoading = true
    
    init(latinService: LatinService, psalmService: PsalmService, liturgicalDay: LiturgicalDay?, hourKey: String?) {
        self.latinService = latinService
        self.psalmService = psalmService
        self.liturgicalDay = liturgicalDay
        self.hourKey = hourKey
        self._selectedPsalmId = State(initialValue: "")
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                List {
                    psalmSelectionSection
                    analysisSection
                }
            }
        }
        .navigationTitle(hourKey != nil ? "\(hourKey!.capitalized) Analysis" : "Psalm Analysis")
        .task {
            await loadData()
        }
    }
    
    private var psalmSelectionSection: some View {
        Section {
            Picker("Select Psalm", selection: $selectedPsalmId) {
                ForEach(availablePsalms) { usage in
                    Text(usage.displayTitle)
                        .tag(usage.id)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    private var analysisSection: some View {
        Section {
            if let selectedUsage = availablePsalms.first(where: { $0.id == selectedPsalmId }) {
                if psalms[selectedPsalmId] != nil {
                    NavigationLink {
                        if let psalmText = psalms[selectedUsage.id] {
                            let analysis = latinService.analyzePsalm(text: psalmText)
                            PsalmAnalysisView(analysis: analysis, psalmTitle: selectedUsage.displayTitle)
                        }
                    } label: {
                        Text("Analyze \(selectedUsage.displayTitle)")
                    }
                } else {
                    HStack {
                        Text("Loading text...")
                        Spacer()
                        ProgressView()
                    }
                }
            }
        }
    }
    
    private func loadData() async {
        // Load either hour-specific psalms or fallback to hardcoded list
        if let hourKey = hourKey, let liturgicalDay = liturgicalDay {
            await loadHourPsalms(hourKey: hourKey, liturgicalDay: liturgicalDay)
        } else {
            availablePsalms = psalmUsages
        }
        
        // Load psalm texts
        await loadPsalmTexts()
        
        // Set initial selection if none exists
        if selectedPsalmId.isEmpty {
            selectedPsalmId = availablePsalms.first?.id ?? ""
        }
        
        isLoading = false
    }
    
    private func loadHourPsalms(hourKey: String, liturgicalDay: LiturgicalDay) async {
        if let hourPsalms = hoursService.getPsalmsForWeekday(
            weekday: liturgicalDay.weekday,
            hourKey: hourKey,
            season: liturgicalDay.benedictineSeason.description
        ) {
            availablePsalms = hourPsalms
        } else {
            // Fallback to hardcoded psalms if hour-specific loading fails
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


// Extension for display formatting
extension PsalmUsage {
    var displayTitle: String {
        if let category = category {
            return "Psalm \(number) (\(category))"
        }
        return "Psalm \(number)"
    }
}

struct PsalmAnalysisView: View {
    let analysis: PsalmAnalysisResult
    let psalmTitle: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with basic stats
                VStack(alignment: .leading, spacing: 8) {
                    Text(psalmTitle)
                        .font(.title)
                        .bold()
                    
                    HStack(spacing: 16) {
                        StatView(value: "\(analysis.totalWords)", label: "Total Words")
                        StatView(value: "\(analysis.uniqueWords)", label: "Unique Words")
                        StatView(value: "\(analysis.uniqueLemmas)", label: "Unique Lemmas")
                    }
                }
                .padding(.bottom)
                
                // Word frequency section
                LatinSectionView(title: "Word Frequency") {
                    let sortedWords = analysis.dictionary.sorted { $0.value.count > $1.value.count }
                    ForEach(sortedWords.prefix(10), id: \.key) { lemma, info in
                        WordRow(lemma: lemma, info: info)
                    }
                    
                    if analysis.dictionary.count > 10 {
                        NavigationLink {
                            FullWordListView(analysis: analysis)
                        } label: {
                            Text("View all \(analysis.dictionary.count) words...")
                                .font(.subheadline)
                        }
                    }
                }
                
                // Most common forms section
                LatinSectionView(title: "Common Forms") {
                    let allForms = analysis.dictionary.flatMap { lemma, info in
                        info.forms.map { (form: $0.key, count: $0.value, lemma: lemma) }
                    }
                    let sortedForms = allForms.sorted { $0.count > $1.count }
                    
                    ForEach(sortedForms.prefix(5), id: \.form) { form, count, lemma in
                        HStack {
                            Text(form).bold()
                            Text("(\(lemma))")
                            Spacer()
                            Text("\(count)×")
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Psalm Analysis")
        .navigationBarTitleDisplayMode(.inline)
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
    let content: Content  // Changed from closure to direct Content
    
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
                content  // Now using the content directly
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


