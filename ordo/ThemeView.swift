// ConceptualThemesView.swift
import SwiftUI

struct ConceptualThemeCardView: View {
    let theme: PsalmAnalysisResult.ConceptualTheme
    let analysis: PsalmAnalysisResult
    let color: Color

    // Calculate text color based on background brightness for better contrast
    private var textColor: Color {
        // For light theme colors, use dark text; for very light colors, adjust accordingly
        return .primary
    }

    // Create a lighter version of the theme color for the background
    private var backgroundColor: Color {
        color.opacity(0.15) // Light background with the theme color tint
    }

    // Create a slightly darker version for the border
    private var borderColor: Color {
        color.opacity(0.4)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Theme header
            VStack(alignment: .leading, spacing: 4) {
                Text(theme.name)
                    .font(.headline)
                    .foregroundColor(textColor)

                Text(theme.description)
                    .font(.subheadline)
                    .foregroundColor(textColor.opacity(0.8))
            }

            // Supporting lemmas
            if !theme.supportingLemmas.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Key Terms")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(textColor.opacity(0.7))

                    FlowLayout(spacing: 8) {
                        ForEach(theme.supportingLemmas, id: \.self) { lemma in
                            if let lemmaInfo = analysis.dictionary[lemma] {
                                NavigationLink(destination: WordDetailView(lemma: lemma, lemmaInfo: lemmaInfo)) {
                                    LemmaView(lemma: lemma, translation: lemmaInfo.translation)
                                        .background(
                                            Capsule()
                                                .fill(color.opacity(0.25))
                                        )
                                        .overlay(
                                            Capsule()
                                                .stroke(borderColor, lineWidth: 1)
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: 2)
        )
        .shadow(color: color.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct ConceptualThemesView: View {
    let themes: [PsalmAnalysisResult.ConceptualTheme]
    let analysis: PsalmAnalysisResult

    // Color palette for themes - you can customize these colors
    private func getColorForCategory(_ category: ThemeCategory) -> Color {
        switch category {
        case .divine: return .blue // Heavenly intervention
        case .justice: return .green // Balanced judgment, life
        case .virtue: return .yellow // Golden virtue, value
        case .conflict: return .red // Bloodshed, violence
        case .sin: return .purple // Penance, sacrifice
        case .opposition: return .gray // Spiritual opposition
        case .worship: return .white // Pure worship
        case .unknown: return Color(white: 0.9) // Very light gray (almost white)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(Array(themes.enumerated()), id: \.element.name) { _, theme in
                        ConceptualThemeCardView(
                            theme: theme,
                            analysis: analysis,
                            color: getColorForCategory(theme.category)
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ThemeView: View {
    let themes: [PsalmAnalysisResult.StructuralTheme]
    let dictionary: [String: PsalmAnalysisResult.LemmaInfo]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Themes")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)

                if themes.isEmpty {
                    Text("No themes identified")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(themes, id: \.name) { theme in
                        themeCard(for: theme)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .background(Color(.systemBackground))
        }
    }

    private func themeCard(for theme: PsalmAnalysisResult.StructuralTheme) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Theme header with name and description
            VStack(alignment: .leading, spacing: 4) {
                Text(theme.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                if !theme.description.isEmpty {
                    Text(theme.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let range = theme.lineRange {
                    Text("Lines \(range.lowerBound)-\(range.upperBound)")
                        .font(.caption)
                        .foregroundColor(.accentColor)
                }
            }

            // Supporting lemmas
            if !theme.supportingLemmas.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Key Words:")
                        .font(.subheadline)
                        .bold()

                    WrappingHStack(items: theme.supportingLemmas, spacing: 8, alignment: .leading) { lemma in
                        if let info = dictionary[lemma] {
                            NavigationLink(destination: WordDetailView(lemma: lemma, lemmaInfo: info)) {
                                lemmaPill(lemma: lemma, info: info)
                            }
                        } else {
                            lemmaPill(lemma: lemma, info: nil)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }

    private func lemmaPill(lemma: String, info: PsalmAnalysisResult.LemmaInfo?) -> some View {
        HStack(spacing: 4) {
            Text(lemma)
                .font(.caption)
                .bold()

            if let translation = info?.translation {
                Text(translation)
                    .font(.caption)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.accentColor.opacity(0.2))
        .cornerRadius(12)
    }
}

// Simplified FlexibleView for wrapping content
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    @State private var availableWidth: CGFloat = 0

    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .top)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }

            _FlexibleView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}

struct WrappingHStack<Item, ItemView: View>: View {
    let items: [Item]
    let itemView: (Item) -> ItemView
    let spacing: CGFloat
    let alignment: HorizontalAlignment

    init(items: [Item],
         spacing: CGFloat = 8,
         alignment: HorizontalAlignment = .leading,
         @ViewBuilder itemView: @escaping (Item) -> ItemView)
    {
        self.items = items
        self.spacing = spacing
        self.alignment = alignment
        self.itemView = itemView
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                itemView(item)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= lastHeight
                        }
                        let result = width
                        if index == items.count - 1 {
                            width = 0
                        } else {
                            width -= dimension.width + spacing
                        }
                        return result
                    }
                    .alignmentGuide(.top) { dimension in
                        let result = height
                        lastHeight = dimension.height
                        if index == items.count - 1 {
                            height = 0
                        }
                        return result
                    }
            }
        }
    }
}

private struct _FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content

    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { element in
                        content(element)
                    }
                }
            }
        }
    }

    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let view = content(element)
            let elementSize = view.getSize()

            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
                remainingWidth -= elementSize.width + spacing
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth - elementSize.width - spacing
            }
        }

        return rows
    }
}

// Size reader extension
extension View {
    func concat(_ other: AnyView) -> AnyView {
        AnyView(HStack(spacing: 0) { self; other })
    }

    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }

    func getSize() -> CGSize {
        var size = CGSize.zero
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        view?.layoutIfNeeded()
        size = view?.intrinsicContentSize ?? .zero

        return size
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// Preview remains the same
