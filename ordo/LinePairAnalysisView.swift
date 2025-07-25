import SwiftUI

struct LinePairAnalysisView: View {
    let latinService: LatinService
    let psalmText: [String]
    let psalmTitle: String
    
    @State private var selectedPairIndex = 0
    @State private var linePairs: [LinePair] = []
    
    // Create PsalmIdentity from the psalm title (e.g., "Psalm 4" or "Psalm 118 (aleph)")
    private var psalmIdentity: PsalmIdentity {
        // Remove "Psalm " prefix
        let cleanTitle = psalmTitle.replacingOccurrences(of: "Psalm ", with: "")
        
        // Split into main part and section (handling both : and parentheses)
        let mainPart: String
        let category: String?
        
        if let parenRange = cleanTitle.range(of: "(") {
            mainPart = String(cleanTitle[..<parenRange.lowerBound]).trimmingCharacters(in: .whitespaces)
            let sectionPart = String(cleanTitle[parenRange.lowerBound...])
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .trimmingCharacters(in: .whitespaces)
                .lowercased() // Convert to lowercase for consistency
            category = sectionPart.isEmpty ? nil : sectionPart
        } else {
            let components = cleanTitle.components(separatedBy: ":")
            mainPart = components[0].trimmingCharacters(in: .whitespaces)
            let sectionPart = components.count > 1 ? components[1].trimmingCharacters(in: .whitespaces).lowercased() : nil
            category = sectionPart?.isEmpty ?? true ? nil : sectionPart
        }
        
        let number = Int(mainPart) ?? 0
        
        print("psalmTitle: \(psalmTitle)   number: \(number)   category: \(category ?? "")")
        return PsalmIdentity(number: number, category: category?.lowercased())
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
                            text: pair.lines, //.joined(separator: " "),
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
                            
                            if !analysis.themes.isEmpty {
                                let filteredThemes = analysis.themes.filter { theme in
                                    guard let themeRange = theme.lineRange else { return false }
                                    // Check if theme range overlaps with the pair's range OR if the pair's range contains any part of the theme range
                                    return pair.startLine...pair.endLine ~= themeRange.lowerBound ||
                                           pair.startLine...pair.endLine ~= themeRange.upperBound ||
                                           themeRange ~= pair.startLine ||
                                           themeRange ~= pair.endLine
                                }
                                // Main View Code
                                if !filteredThemes.isEmpty {
                                    ThemeListView(themes: filteredThemes, analysis: analysis)
                                }

                                
                            }
                            Section(header: Text("All Lemmas in Range")
                                        .font(.headline)
                                        .padding(.bottom, 4)) {

                                FlowLayout(spacing: 8) {
                                    ForEach(analysis.orderedLemmas, id: \.self) { lemma in
                                        if let info = analysis.dictionary[lemma] {
                                            NavigationLink(destination: WordDetailView(lemma: lemma, lemmaInfo: info)) {
                                                LemmaView(lemma: lemma, translation: info.translation)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                )
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
struct DebugModifier: ViewModifier {
    let message: String
    @State private var debugMessage = ""
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                // Print to console
                print(message)
                // Also store for visual debugging
                debugMessage = message
            }
            .overlay(
                Text(debugMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .border(Color.red, width: 1)
                    .padding(),
                alignment: .topLeading
            )
    }
}


private struct LemmaCardView: View {
    let lemma: String
    let info: PsalmAnalysisResult.LemmaInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(lemma)
                .font(.headline)
                .foregroundColor(.accentColor)

            if let translation = info.translation {
                Text(translation)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if info.count > 1 {
                Text("Occurrences: \(info.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.accentColor.opacity(0.05))
        )
    }
}

extension View {
    func debug(_ message: String) -> some View {
        #if DEBUG
        return modifier(DebugModifier(message: message))
        #else
        return self
        #endif
    }
}
