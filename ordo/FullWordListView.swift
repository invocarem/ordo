import SwiftUI
struct FullWordListView: View {
    let analysis: PsalmAnalysisResult
    
    var body: some View {
        List {
            ForEach(analysis.dictionary.sorted(by: { $0.key < $1.key }), id: \.key) { lemma, info in
                NavigationLink(destination: WordDetailView(lemma: lemma,lemmaInfo: info)) {
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
        guard entity.partOfSpeech == .verb else { return "" }
        
        if let presentForms = entity.forms?["present"], presentForms.contains(form) {
            if form.hasSuffix("o") || form.hasSuffix("m") { return "1sg present" }
            if form.hasSuffix("s") { return "2sg present" }
            if form.hasSuffix("t") { return "3sg present" }
            if form.hasSuffix("mus") { return "1pl present" }
            if form.hasSuffix("tis") { return "2pl present" }
            if form.hasSuffix("nt") { return "3pl present" }
        }
        
        // Check imperfect tense
        if let imperfectForms = entity.forms?["imperfect"], imperfectForms.contains(form) {
            if form.hasSuffix("m") { return "1sg imperfect" }
            if form.hasSuffix("s") { return "2sg imperfect" }
            if form.hasSuffix("t") { return "3sg imperfect" }
            if form.hasSuffix("mus") { return "1pl imperfect" }
            if form.hasSuffix("tis") { return "2pl imperfect" }
            if form.hasSuffix("nt") { return "3pl imperfect" }
        }
        
        // Check perfect forms
        if let perfectForms = entity.forms?["perfect"], perfectForms.contains(form) {
            if form.hasSuffix("i") { return "1sg perfect" }
            if form.hasSuffix("isti") { return "2sg perfect" }
            if form.hasSuffix("it") { return "3sg perfect" }
            if form.hasSuffix("imus") { return "1pl perfect" }
            if form.hasSuffix("istis") { return "2pl perfect" }
            if form.hasSuffix("erunt") || form.hasSuffix("erint") { return "3pl perfect" }
        }
        
        // Check future perfect
        if let futurePerfectForms = entity.forms?["future perfect"], futurePerfectForms.contains(form) {
            if form.hasSuffix("ero") { return "1sg future perfect" }
            if form.hasSuffix("eris") { return "2sg future perfect" }
            if form.hasSuffix("erit") { return "3sg future perfect" }
            if form.hasSuffix("erimus") { return "1pl future perfect" }
            if form.hasSuffix("eritis") { return "2pl future perfect" }
            if form.hasSuffix("erint") { return "3pl future perfect" }
        }
        
        // Check pluperfect
        if let pluperfectForms = entity.forms?["pluperfect"], pluperfectForms.contains(form) {
            if form.hasSuffix("eram") { return "1sg pluperfect" }
            if form.hasSuffix("eras") { return "2sg pluperfect" }
            if form.hasSuffix("erat") { return "3sg pluperfect" }
            if form.hasSuffix("eramus") { return "1pl pluperfect" }
            if form.hasSuffix("eratis") { return "2pl pluperfect" }
            if form.hasSuffix("erant") { return "3pl pluperfect" }
        }
        
        // Check subjunctive forms
        if let subjunctiveForms = entity.forms?["subjunctive"], subjunctiveForms.contains(form) {
            // Present subjunctive
            if form.hasSuffix("em") || form.hasSuffix("m") { return "1sg present subjunctive" }
            if form.hasSuffix("es") || form.hasSuffix("s") { return "2sg present subjunctive" }
            if form.hasSuffix("et") || form.hasSuffix("t") { return "3sg present subjunctive" }
            if form.hasSuffix("emus") { return "1pl present subjunctive" }
            if form.hasSuffix("etis") { return "2pl present subjunctive" }
            if form.hasSuffix("ent") { return "3pl present subjunctive" }
            
            // Imperfect subjunctive
            if form.hasSuffix("rem") { return "1sg imperfect subjunctive" }
            if form.hasSuffix("res") { return "2sg imperfect subjunctive" }
            if form.hasSuffix("ret") { return "3sg imperfect subjunctive" }
            if form.hasSuffix("remus") { return "1pl imperfect subjunctive" }
            if form.hasSuffix("retis") { return "2pl imperfect subjunctive" }
            if form.hasSuffix("rent") { return "3pl imperfect subjunctive" }
        }
        
        // Check imperative forms
        if let imperativeForms = entity.forms?["imperative"], imperativeForms.contains(form) {
            if form == entity.lemma { return "2sg present imperative" }
            if form.hasSuffix("te") { return "2pl present imperative" }
        }
        
        return ""
    }
}

// View for displaying grammatical properties
struct GrammaticalInfoView: View {
    let entity: LatinWordEntity
    
    var body: some View {
        HStack(spacing: 8) {
            if let pos = entity.partOfSpeech?.rawValue {
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
            
            if let gender = entity.gender?.rawValue {
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
    let lemma: String
    let lemmaInfo: PsalmAnalysisResult.LemmaInfo
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    // Lemma and count
                    HStack {
                        Text(lemma)
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("\(lemmaInfo.count)×")
                            .foregroundColor(.secondary)
                    }
                    
                    // Translation
                    if let translation = lemmaInfo.translation {
                        Text(translation)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            
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
    private func frequencyDescription(count: Int) -> String {
            switch count {
            case 1: return "Rare (1 occurrence)"
            case 2..<5: return "Uncommon (\(count) occurrences)"
            case 5..<10: return "Frequent (\(count) occurrences)"
            case 10..<20: return "Very frequent (\(count) occurrences)"
            case 20...: return "Extremely frequent (\(count) occurrences)"
            default: return "Not found"
            }
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
