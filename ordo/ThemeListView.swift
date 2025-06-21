//
//  ThemeListView.swift
//  ordo
//
//  Created by Chen Chen on 2025-06-20.
//
import SwiftUI

// Reusable Component
public struct ThemeListView: View {
    let themes: [PsalmAnalysisResult.Theme]
    let analysis: PsalmAnalysisResult
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(themes, id: \.name) { theme in
                ThemeCardView(theme: theme, analysis: analysis)
            }
        }
        .padding(.top, 12)
    }
}

private struct ThemeCardView: View {
    let theme: PsalmAnalysisResult.Theme
    let analysis: PsalmAnalysisResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ThemeHeaderView(name: theme.name, description: theme.description)
            
            if let comment = theme.comment?.trimmedNonEmpty {
                CommentView(comment: comment)
            }
            
            if !theme.supportingLemmas.isEmpty {
                LemmaListView(lemmas: theme.supportingLemmas, analysis: analysis)
            }
        }
        .themeCardStyle()
    }
}

private struct ThemeHeaderView: View {
    let name: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .themeNameStyle()
            
            Text(description)
                .themeDescriptionStyle()
        }
    }
}

private struct CommentView: View {
    let comment: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Commentary")
                .commentHeaderStyle()
            
            Text(comment)
                .commentBodyStyle()
        }
        .commentContainerStyle()
    }
}

private struct LemmaListView: View {
    let lemmas: [String]
    let analysis: PsalmAnalysisResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Key Terms")
                .lemmaHeaderStyle()
            
            FlowLayout(spacing: 8) {
                ForEach(lemmas, id: \.self) { lemma in
                    if let lemmaInfo = analysis.dictionary[lemma] {
                        LemmaView(lemma: lemma, translation: lemmaInfo.translation)
                    }
                }
            }
        }
    }
}

private struct LemmaView: View {
    let lemma: String
    let translation: String?
    
    var body: some View {
        VStack(spacing: 4) {
            Text(lemma)
                .lemmaTextStyle()
            
            if let translation = translation {
                Text(translation)
                    .lemmaTranslationStyle()
            }
        }
        .lemmaContainerStyle()
    }
}

// MARK: - View Modifiers
private extension Text {
    func themeNameStyle() -> some View {
        self
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
    }
    
    func themeDescriptionStyle() -> some View {
        self
            .font(.body)
            .foregroundColor(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    func commentHeaderStyle() -> some View {
        self
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.accentColor)
    }
    
    func commentBodyStyle() -> some View {
        self
            .font(.body)
            .foregroundColor(.primary.opacity(0.8))
            .italic()
    }
    
    func lemmaHeaderStyle() -> some View {
        self
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundColor(.secondary)
    }
    
    func lemmaTextStyle() -> some View {
        self
            .font(.callout)
            .bold()
            .foregroundColor(.accentColor)
    }
    
    func lemmaTranslationStyle() -> some View {
        self
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

private extension View {
    func themeCardStyle() -> some View {
        self
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
            )
            .padding(.vertical, 4)
    }
    
    func commentContainerStyle() -> some View {
        self
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.vertical, 8)
    }
    
    func lemmaContainerStyle() -> some View {
        self
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.accentColor.opacity(0.1))
            )
    }
}

// MARK: - String Extension
private extension String {
    var trimmedNonEmpty: String? {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
