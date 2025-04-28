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
    
    // Using PsalmUsage for identifiers
    let psalmUsages: [PsalmUsage] = [
        PsalmUsage(number: "118", category: "aleph"),
        PsalmUsage(number: "118", category: "daleth"),
        PsalmUsage(number: "118", category: "he"),
        PsalmUsage(number: "118", category: "vau"),
        PsalmUsage(number: "37"),
        PsalmUsage(number: "38"),
        PsalmUsage(number: "119"),
        PsalmUsage(number: "120"),
        PsalmUsage(number: "4"),
        PsalmUsage(number: "90"),
        PsalmUsage(number: "133"),
        PsalmUsage(number: "17", category: "B"),
        PsalmUsage(number: "109"),
        PsalmUsage(number: "66")
    ]
    
    @State private var psalms: [String: [String]] = [:]
    @State private var selectedPsalmId: String  // Now tracking by ID
   
    
    init(latinService: LatinService, psalmService: PsalmService) {
        self.latinService = latinService
        self.psalmService = psalmService
        // Default to Psalm 37
        self._selectedPsalmId = State(initialValue: PsalmUsage(number: "90").id)
    }
    
    var body: some View {
        List {
            Section {
                Picker("Select Psalm", selection: $selectedPsalmId) {
                    ForEach(psalmUsages) { usage in
                        Text(usage.displayTitle)
                            .tag(usage.id)
                    }
                }
                .pickerStyle(.menu)
            }
            Section {
                NavigationLink {
                    if let selectedUsage = psalmUsages.first(where: { $0.id == selectedPsalmId }),
                       let psalmText = psalms[selectedUsage.id] {
                        let analysis = latinService.analyzePsalm(text: psalmText)
                        PsalmAnalysisView(analysis: analysis, psalmTitle: selectedUsage.displayTitle)
                    }
                } label: {
                    if let selectedUsage = psalmUsages.first(where: { $0.id == selectedPsalmId }) {
                        Text("Analyze \(selectedUsage.displayTitle)")
                    }
                }
                .disabled(psalms[selectedPsalmId] == nil)
                        }
          
        }
        .navigationTitle("Psalm Analysis")
        .task {
            await loadPsalms()
        }
    }
    
    private func loadPsalms() async {
        for usage in psalmUsages {
            guard let number = Int(usage.number) else {
                print("Invalid psalm number: \(usage.number)")
                continue
            }
            
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


