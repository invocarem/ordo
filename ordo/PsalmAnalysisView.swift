//
//  PsalmAnalysisView.swift
//  ordo
//
//  Created by Chen Chen on 2025-05-15.
//
import SwiftUI
struct PsalmAnalysisView: View {
    let latinService: LatinService
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
        LinePairAnalysisView(
            latinService: latinService, // You'll need to pass this in
            psalmText: psalmText,
            psalmTitle: psalmTitle
        )
    }
}

// Update the initialization in PsalmAnalysisSelectionView

