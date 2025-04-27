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
    let psalmIdentifiers = [
        ("37", nil),
        ("38", nil),
        ("119", nil),
        ("120", nil),
        ("4", nil) ,
        ("90", nil),
        ("133", nil),
           
        ("17", "B"), // Psalm 17 (B)
        ("109", nil), // Psalm 109
        ("66", nil)  // Psalm 66
    ]
    
    @State private var psalms: [String: [String]] = [:]
    @State private var selectedPsalmIdentifier = "37"
    
    
    
    
    var body: some View {
        List {
            Section {
               Picker("Select Psalm", selection: $selectedPsalmIdentifier) {
                   ForEach(psalmIdentifiers, id: \.0) { (number, section) in
                       Text(formatPsalmTitle(number: number, section: section))
                           .tag(number + (section ?? ""))
                   }
               }
               .pickerStyle(.menu)
           }
            Section {
                            NavigationLink {
                                if let psalmText = psalms[selectedPsalmIdentifier] {
                                    let analysis = latinService.analyzePsalm(text: psalmText)
                                    let title = formatPsalmTitle(for: selectedPsalmIdentifier)
                                    PsalmAnalysisView(analysis: analysis, psalmTitle: title)
                                }
                            } label: {
                                Text("Analyze \(formatPsalmTitle(for: selectedPsalmIdentifier))")
                            }
                            .disabled(psalms[selectedPsalmIdentifier] == nil)
                        }
            
           
        }
        .navigationTitle("Psalm Analysis")
        .task {
                    await loadPsalms()
                }
    }
    private func loadPsalms() async {
        for (numberStr, section) in psalmIdentifiers {
            // Safely convert string to Int
            guard let number = Int(numberStr) else {
                print("Invalid psalm number: \(numberStr)")
                continue
            }
            
            // Create a more robust identifier
            let identifier = "\(number)" + (section.map { $0 } ?? "")
            
            // Get the psalm - no need to unwrap text since it's non-optional
            if let psalm = psalmService.getPsalm(number: number, section: section) {
                psalms[identifier] = psalm.text
            } else {
                print("Failed to load Psalm \(number)\(section.map { "(\($0))" } ?? "")")
            }
        }
    }
    
    private func formatPsalmTitle(number: String, section: String? = nil) -> String {
           if let section = section {
               return "Psalm \(number) (\(section))"
           }
           return "Psalm \(number)"
       }
       
       private func formatPsalmTitle(for identifier: String) -> String {
           // This assumes identifiers are in format "number" or "numberSection" (like "17B")
           if identifier.count > 3 && identifier.last?.isLetter == true {
               let number = String(identifier.dropLast())
               let section = String(identifier.last!)
               return formatPsalmTitle(number: number, section: section)
           }
           return formatPsalmTitle(number: identifier)
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

