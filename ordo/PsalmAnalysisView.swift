//
//  PsalmAnalysisView.swift
//  ordo
//
//  Created by Chen Chen on 2025-05-15.
//
import SwiftUI
struct PsalmAnalysisView: View {
    let analysis: PsalmAnalysisResult
    let psalmTitle: String
    let psalmText: [String] // Add this to receive the psalm text lines
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with basic stats
                headerView
                
                // Display the psalm analysis grouped by line pairs
                linePairAnalysisView
            }
            .padding()
        }
        .navigationTitle("Psalm Analysis")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var headerView: some View {
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
    }
    
    private var linePairAnalysisView: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Create line pairs (1-2, 3-4, etc.)
            let linePairs = stride(from: 0, to: psalmText.count, by: 2).map {
                Array(psalmText[$0..<min($0 + 2, psalmText.count)])
            }
            
            ForEach(Array(linePairs.enumerated()), id: \.offset) { index, pair in
                LatinSectionView(title: "Lines \(index * 2 + 1)-\(index * 2 + pair.count)") {
                    // Display the Latin text
                    VStack(alignment: .leading, spacing: 4) {
                        
                        ForEach(pair, id: \.self) { line in
                            Text(line)
                                .font(.system(.body, design: .serif)) // Traditional serif font
                                .italic()
                                .foregroundColor(.primary)
                                .padding(.vertical, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 8)
                        .background(Color(.systemBackground))
                        .cornerRadius(4)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                        
                    }
                    .padding(.bottom, 8)
                    
                    
                    // Display words found in these lines
                    let wordsInLines = analysis.dictionary.filter { entry in
                        // Only show lemmas whose forms actually appear as whole words
                        pair.joined(separator: " ").components(separatedBy: .whitespacesAndNewlines)
                            .map { $0.trimmingCharacters(in: .punctuationCharacters) }
                            .contains { fullWord in
                                entry.value.forms.keys.contains { form in
                                    fullWord == form
                                }
                            }
                    }

                    
                    ForEach(wordsInLines.sorted(by: { $0.key < $1.key }), id: \.key) { lemma, info in
                        NavigationLink(destination: WordDetailView(lemma: lemma, lemmaInfo: info)) {
                            WordRow(lemma: lemma, info: info)
                        }
                    }
                }
            }
            
            // Add a link to view all words if needed
            if analysis.dictionary.count > 0 {
                NavigationLink {
                    FullWordListView(analysis: analysis)
                } label: {
                    Text("View all \(analysis.dictionary.count) words...")
                        .font(.subheadline)
                }
            }
        }
    }
}

// Update the initialization in PsalmAnalysisSelectionView

