import SwiftUI

struct LinePairAnalysisView: View {
    let latinService: LatinService
    let psalmText: [String]
    let psalmTitle: String
    
    @State private var selectedPairIndex = 0
    @State private var linePairs: [LinePair] = []
    
    // Create PsalmIdentity from the psalm title (e.g., "Psalm 4" or "Psalm 118:aleph")
    private var psalmIdentity: PsalmIdentity {
        let components = psalmTitle.replacingOccurrences(of: "Psalm ", with: "").components(separatedBy: ":")
        let number = Int(components[0]) ?? 0
        let section = components.count > 1 ? components[1].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "") : nil
        return PsalmIdentity(number: number, section: section)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Navigation bar for line pairs (unchanged)
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
            
            // Main content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if linePairs.indices.contains(selectedPairIndex) {
                        let pair = linePairs[selectedPairIndex]
                        let analysis = latinService.analyzePsalm(
                            psalmIdentity, // Using the computed identity
                            text: pair.lines.joined(separator: " "),
                            startingLineNumber: pair.startLine
                        )
                        
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
                            
                            ForEach(analysis.orderedLemmas, id: \.self) { lemma in
                                if let info = analysis.dictionary[lemma] {
                                    NavigationLink(destination: WordDetailView(lemma: lemma, lemmaInfo: info)) {
                                        WordRow(lemma: lemma, info: info)
                                    }
                                }
                            }
                            
                            if !analysis.themes.isEmpty {
                                        let filteredThemes = analysis.themes.filter { theme in
                                            guard let themeRange = theme.lineRange else { return false }
                                            print ("themeRange: \(themeRange)")
                                            return themeRange.overlaps(pair.startLine...pair.endLine)
                                        }
                                        
                                        if !filteredThemes.isEmpty {
                                            VStack(alignment: .leading, spacing: 8) {
                                                Text("Themes")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                                
                                                ForEach(filteredThemes, id: \.name) { theme in
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        Text(theme.name)
                                                            .font(.headline)
                                                        Text(theme.description)
                                                            .font(.caption)
                                                            .foregroundColor(.secondary)
                                                        if !theme.supportingLemmas.isEmpty {
                                                            FlowLayout(spacing: 4) {
                                                                ForEach(theme.supportingLemmas, id: \.self) { lemma in
                                                                                            if let lemmaInfo = analysis.dictionary[lemma] {
                                                                                                VStack(spacing: 2) {
                                                                                                    Text(lemma)
                                                                                                        .font(.caption)
                                                                                                        .bold()
                                                                                                    if let translation = lemmaInfo.translation {
                                                                                                        Text(translation)
                                                                                                            .font(.caption2)
                                                                                                    }
                                                                                                }
                                                                                                .padding(.horizontal, 6)
                                                                                                .padding(.vertical, 4)
                                                                                                .background(Color.accentColor.opacity(0.1))
                                                                                                .cornerRadius(6)
                                                                                            }
                                                                                        }
                                                            }
                                                        }
                                                    }
                                                    .padding(.vertical, 4)
                                                }
                                            }
                                            .padding(.top, 8)
                                        }
                                    }
                        }
                        
                        
                    }
                }
                .padding()
            }
        }
        .onAppear {
            linePairs = createLinePairs()
        }
    }
    
    private func createLinePairs() -> [LinePair] {
        stride(from: 0, to: psalmText.count, by: 2).map { i in
            let endIndex = min(i + 2, psalmText.count)
            let lines = Array(psalmText[i..<endIndex])
            return LinePair(
                id: "\(i)",
                startLine: i + 1, // Line numbers start at 1
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
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var totalHeight: CGFloat = 0
        var currentLineWidth: CGFloat = 0
        var currentLineHeight: CGFloat = 0
        var totalWidth: CGFloat = 0
        
        for size in sizes {
            if currentLineWidth + size.width + spacing > proposal.width ?? 0 {
                totalHeight += currentLineHeight + spacing
                totalWidth = max(totalWidth, currentLineWidth)
                currentLineWidth = 0
                currentLineHeight = 0
            }
            
            currentLineWidth += size.width + spacing
            currentLineHeight = max(currentLineHeight, size.height)
        }
        
        totalHeight += currentLineHeight
        totalWidth = max(totalWidth, currentLineWidth)
        
        return CGSize(width: totalWidth, height: totalHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX = bounds.minX
        var currentY = bounds.minY
        var lineHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > bounds.maxX {
                currentX = bounds.minX
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                anchor: .topLeading,
                proposal: .unspecified
            )
            
            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
    }
}
