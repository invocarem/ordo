
import SwiftUI

struct LinePairAnalysisView: View {
    let latinService: LatinService
    let psalmText: [String]
    let psalmTitle: String
    
    @State private var selectedPairIndex = 0
    @State private var linePairs: [LinePair] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Simple navigation bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(linePairs.enumerated()), id: \.offset) { index, pair in
                        Button(action: {
                            selectedPairIndex = index
                        }) {
                            Text("\(pair.startLine)-\(pair.endLine)")
                                .font(.subheadline)
                                .padding(10)
                                .background(selectedPairIndex == index ? Color.accentColor : Color(.secondarySystemBackground))
                                .foregroundColor(selectedPairIndex == index ? .white : .primary)
                                .cornerRadius(15)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 44)
            .background(Color(.systemBackground))
            
            // Main content - simple vertical stack
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    Text(psalmTitle)
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                    // Display only the selected line pair
                    if linePairs.indices.contains(selectedPairIndex) {
                        let pair = linePairs[selectedPairIndex]
                        let inputText = pair.lines.joined(separator: " ")
                        
                        
                        let analysis = latinService.analyzePsalm(text: pair.lines.joined(separator: " "))
                        
                       
                        
                        LatinSectionView(title: "Lines \(pair.startLine)-\(pair.endLine)") {
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(pair.lines, id: \.self) { line in
                                    Text(line)
                                        .font(.system(.body, design: .serif))
                                        .italic()
                                        .padding(.vertical, 4)
                                }
                            }
                            .padding(.bottom, 8)
                            
                            ForEach(analysis.dictionary.sorted(by: { $0.key < $1.key }), id: \.key) { lemma, info in
                                NavigationLink(destination: WordDetailView(lemma: lemma, lemmaInfo: info)) {
                                    WordRow(lemma: lemma, info: info)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                linePairs = createLinePairs()
            }
        }
    }
    
    private func createLinePairs() -> [LinePair] {
        stride(from: 0, to: psalmText.count, by: 2).map { i in
            let endIndex = min(i + 2, psalmText.count)
            let lines = Array(psalmText[i..<endIndex])
            return LinePair(
                id: "\(i)",
                startLine: i + 1,
                endLine: i + lines.count,
                lines: lines
            )
        }
    }
}

struct LinePair: Identifiable {
    let id: String
    let startLine: Int
    let endLine: Int
    let lines: [String]
}
