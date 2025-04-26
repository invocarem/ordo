//
//  PsalmAnalysisSectionView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-25.
//
import SwiftUI
struct PsalmAnalysisSelectionView: View {
    let latinService: LatinService
    @State private var selectedPsalm: String = "Psalm 109"
    
    let psalms = [
        "Psalm 109": [
            "Dixit Dominus Domino meo: Sede a dextris meis, donec ponam inimicos tuos scabellum pedum tuorum.",
            "Virgam virtutis tuae emittet Dominus ex Sion: dominare in medio inimicorum tuorum.",
            "Tecum principium in die virtutis tuae in splendoribus sanctorum: ex utero ante luciferum genui te.",
            "Juravit Dominus, et non poenitebit eum: Tu es sacerdos in aeternum secundum ordinem Melchisedech.",
            "Dominus a dextris tuis; confregit in die irae suae reges.",
            "Judicabit in nationibus, implebit ruinas; conquassabit capita in terra multorum.",
            "De torrente in via bibet; propterea exaltabit caput."
        ],
        "Psalm 66": [
            "Deus misereatur nostri, et benedicat nobis; illuminet vultum suum super nos, et misereatur nostri.",
            "Ut cognoscamus in terra viam tuam, in omnibus gentibus salutare tuum.",
            "Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.",
            "Laetentur et exsultent gentes, quoniam judicas populos in aequitate, et gentes in terra dirigis.",
            "Confiteantur tibi populi, Deus; confiteantur tibi populi omnes.",
            "Terra dedit fructum suum; benedicat nos Deus, Deus noster.",
            "Benedicat nos Deus; et metuant eum omnes fines terrae."
        ]
    ]
    
    var body: some View {
        List {
            Section {
                Picker("Select Psalm", selection: $selectedPsalm) {
                    ForEach(Array(psalms.keys.sorted()), id: \.self) { psalm in
                        Text(psalm).tag(psalm)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Section {
                NavigationLink {
                    if let psalmText = psalms[selectedPsalm] {
                        let analysis = latinService.analyzePsalm(text: psalmText)
                        PsalmAnalysisView(analysis: analysis, psalmTitle: selectedPsalm)
                    }
                } label: {
                    Text("Analyze \(selectedPsalm)")
                }
            }
        }
        .navigationTitle("Psalm Analysis")
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

// Full word list view
struct FullWordListView: View {
    let analysis: PsalmAnalysisResult
    
    var body: some View {
        List {
            ForEach(analysis.dictionary.sorted { $0.key < $1.key }, id: \.key) { lemma, info in
                WordRow(lemma: lemma, info: info)
            }
        }
        .listStyle(.plain)
        .navigationTitle("All Words")
    }
}
