import SwiftUI
struct FullWordListView: View {
    let analysis: PsalmAnalysisResult
    
    var body: some View {
        List {
            ForEach(analysis.dictionary.sorted(by: { $0.key < $1.key }), id: \.key) { lemma, info in
                NavigationLink(destination: WordDetailView(lemmaInfo: info)) {
                    HStack {
                        Text(lemma)
                        Spacer()
                        Text("\(info.count)")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Word List")
    }
}
struct xFullWordListView: View {
    let analysis: PsalmAnalysisResult
    
    var body: some View {
        List {
            Section("DEBUG") {
                Text("Total words: \(analysis.totalWords)")
                Text("Unique lemmas: \(analysis.uniqueLemmas)")
                if let inimicus = analysis.dictionary["inimicus"] {
                    Text("Found 'inimicus' with \(inimicus.forms.count) forms")
                } else {
                    Text("Missing 'inimicus'").foregroundColor(.red)
                }
            }
            ForEach(analysis.dictionary.sorted(by: { $0.key < $1.key }), id: \.key) { lemma, info in
                Section {
                    // Main lemma card
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(lemma)
                                .font(.body.monospaced())
                                .bold()
                            
                            if let translation = info.translation {
                                Text("• \(translation)")
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        // Add grammatical info if available
                        if let entity = info.entity {
                            GrammaticalInfoView(entity: entity)
                        }
                    }
                    .padding(.vertical, 4)
                    
                    // Forms list
                    ForEach(info.forms.sorted(by: { $0.key < $1.key }), id: \.key) { form, count in
                        if form != lemma { // Skip duplicate lemma entry
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(form)
                                        .font(.body.monospaced())
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.7)
                                    
                                    // Add grammatical analysis for verbs
                                    if let entity = info.entity, form.count > 6 { // Only for longer forms
                                        VerbFormAnalysisView(form: form, entity: entity)
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Spacer()
                                
                                Text("(x\(count))")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                } header: {
                    Text(lemma.capitalized)
                        .font(.headline)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Word Analysis")
    }
}

// Helper view for grammatical analysis
struct VerbFormAnalysisView: View {
    let form: String
    let entity: LatinWordEntity
    
    var body: some View {
        let analysis = analyzeVerbForm()
        if !analysis.isEmpty {
            Text(analysis)
        }
    }
    
    private func analyzeVerbForm() -> String {
        guard entity.partOfSpeech == "verb" else { return "" }
        
        // Check perfect forms
        if let perfectForms = entity.forms?["perfect"], perfectForms.contains(form) {
            if form.hasSuffix("i") { return "1sg perfect" }
            if form.hasSuffix("isti") { return "2sg perfect" }
            if form.hasSuffix("it") { return "3sg perfect" }
            if form.hasSuffix("imus") { return "1pl perfect" }
            if form.hasSuffix("istis") { return "2pl perfect" }
            if form.hasSuffix("erunt") || form.hasSuffix("erint") { return "3pl perfect" }
        }
        
        // Add more verb form checks as needed...
        
        return ""
    }
}

// View for displaying grammatical properties
struct GrammaticalInfoView: View {
    let entity: LatinWordEntity
    
    var body: some View {
        HStack(spacing: 8) {
            if let pos = entity.partOfSpeech {
                Text(pos)
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)
            }
            
            if let declension = entity.declension {
                Text("Decl. \(declension)")
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(4)
            }
            
            if let gender = entity.gender {
                Text(gender.prefix(3))
                    .font(.caption)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(4)
            }
        }
    }
}

struct WordDetailView: View {
    let lemmaInfo: PsalmAnalysisResult.LemmaInfo
    
    var body: some View {
        List {
            // ... existing lemma header section ...
            
            // ACTUAL FORMS SECTION
            if !lemmaInfo.forms.isEmpty {
                Section(header: Text("Forms Found in Text")) {
                    ForEach(lemmaInfo.forms.sorted(by: { $0.key < $1.key }), id: \.key) { form, count in
                        formRow(form: form, count: count, isGenerated: false)
                    }
                }
            }
            
            // GENERATED FORMS SECTION
            if !lemmaInfo.generatedForms.isEmpty {
                Section(header: Text("Possible Forms")) {
                    ForEach(lemmaInfo.generatedForms.sorted(), id: \.self) { form in
                        // Only show if not already in main forms
                        if lemmaInfo.forms[form] == nil {
                            formRow(form: form, count: 0, isGenerated: true)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func formRow(form: String, count: Int, isGenerated: Bool) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text(form)
                        .font(.body.monospaced())
                    
                    if isGenerated {
                        Image(systemName: "function")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                if let analysis = lemmaInfo.entity?.analyzeFormWithMeaning(form) {
                    Text(analysis)
                        .font(.caption)
                        .foregroundColor(isGenerated ? .secondary : .blue)
                }
            }
            
            Spacer()
            
            if count > 0 {
                Text("×\(count)")
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
        .opacity(isGenerated ? 0.8 : 1.0)
    }
}


// Helper View Modifier for grammatical tags
extension View {
    func tagView() -> some View {
        self
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
    }
}
