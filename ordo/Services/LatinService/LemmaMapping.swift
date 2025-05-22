struct LemmaMapping {
    private let wordEntities: [LatinWordEntity]
    private let debugEnabled: Bool
    private let debugTarget: String?
    
    init(wordEntities: [LatinWordEntity], debugTarget: String? = nil) {
        self.wordEntities = wordEntities
        self.debugEnabled = debugTarget != nil
        self.debugTarget = debugTarget?.lowercased()
    }


    func createFormToLemmaMapping() -> [String: [String]] {
        var mapping: [String: [String]] = [:]
        
        wordEntities.forEach { dumpIfNeeded(entity: $0) }
        
        for entity in wordEntities {
            let lemma = entity.lemma.lowercased()
            
            // Map the lemma itself (ensure no duplicates)
            addMapping(form: lemma, lemma: lemma, to: &mapping)
            
            // Map all forms
            mapStandardForms(from: entity, to: &mapping)
            mapSpecialForms(from: entity, to: &mapping)
            
            
            if entity.partOfSpeech == .verb {
                let generated = entity.generatedVerbForms()
                for (_, forms) in generated {
                    for form in forms {
                        addMapping(form: form, lemma: lemma, to: &mapping)
                    }
                }
            } else {
                for form in entity.generatedForms.values {
                    addMapping(form: form, lemma: lemma, to: &mapping)
                }
            }
        }
        
        return mapping
    }
    
    // Unified mapping function that prevents duplicates
    private func addMapping(form: String, lemma: String, to mapping: inout [String: [String]]) {
        let lowerForm = form.lowercased()
        let lowerLemma = lemma.lowercased()
        
        if !(mapping[lowerForm]?.contains(lowerLemma) ?? false) {
            mapping[lowerForm, default: []].append(lowerLemma)
        }
    }
    
    private func mapStandardForms(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
        let lemma = entity.lemma.lowercased()
        
        // Get all case forms (nil values filtered out)
        let caseForms = [
            entity.nominative,
            entity.vocative,
            entity.dative,
            entity.accusative,
            entity.genitive,
            entity.ablative,
            entity.nominative_plural,
            entity.genitive_plural,
            entity.dative_plural,
            entity.accusative_plural,
            entity.ablative_plural
        ].compactMap { $0 }
        
        // Get generated forms
        let generatedForms = Array(entity.generatedForms.values)
        
        // Map all forms
        (caseForms + generatedForms).forEach { form in
            addMapping(form: form, lemma: lemma, to: &mapping)
        }
    }
    
    private func mapSpecialForms(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
        let lemma = entity.lemma.lowercased()
        
        // Handle singular forms
        if let forms = entity.forms {
            for formArray in forms.values {
                for form in formArray {
                    addMapping(form: form, lemma: lemma, to: &mapping)
                }
            }
        }
        
        // Handle plural forms
        if let formsPlural = entity.formsPlural {
            for formArray in formsPlural.values {
                for form in formArray {
                    addMapping(form: form, lemma: lemma, to: &mapping)
                }
            }
        }
    }
    
    private func mapVerbForms(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
        let lemma = entity.lemma.lowercased()
        
        // Map principal parts
        [entity.infinitive, entity.perfect].compactMap { $0 }.forEach { form in
            addMapping(form: form, lemma: lemma, to: &mapping)
        }
        
        // Map all verb forms
        if let verbForms = entity.forms {
            for formArray in verbForms.values {
                for formVariants in formArray {
                    formVariants.components(separatedBy: "/").forEach { variant in
                        addMapping(form: variant, lemma: lemma, to: &mapping)
                    }
                }
            }
        }
    }


    private func dumpIfNeeded(entity: LatinWordEntity) {
        guard debugEnabled, 
              let target = debugTarget,
              entity.lemma.lowercased() == target else { return }
        
        print("\n=== DEBUGGING '\(target)' ===")
        
        switch entity.partOfSpeech {
        case .verb:
            printVerbDebug(entity: entity)
        case .noun:
            printNounDebug(entity: entity)
        case .adjective:
            printNounDebug(entity: entity)
        default:
            print(" - Lemma: \(entity.lemma)")
            print(" - POS: \(entity.partOfSpeech)")
        }
    }


    private func printVerbDebug(entity: LatinWordEntity) {
        print(" - Principal Parts:")
        print("   • Infinitive: \(entity.infinitive ?? "N/A")")
        print("   • Perfect: \(entity.perfect ?? "N/A")")
        print("   • Supine: \(entity.supine ?? "N/A")")
        
        let forms = entity.generatedVerbForms()
        print(" - Generated Forms:")
        forms.sorted(by: { $0.key < $1.key }).forEach { formType, forms in
            print("   • \(formType): \(forms.joined(separator: ", "))")
        }
    }
    
    private func printNounDebug(entity: LatinWordEntity) {
        print(" - Declension: \(entity.declension ?? 0)")
        print(" - Gender: \(entity.gender)")
        print(" - Case Forms:")
        print("   • Nom: \(entity.nominative ?? "N/A")")
        print("   • Gen: \(entity.genitive ?? "N/A")")
        print("   • Dat: \(entity.dative ?? "N/A")")
        print("   • Acc: \(entity.accusative ?? "N/A")")
        print("   • Abl: \(entity.ablative ?? "N/A")")
        
        let forms = entity.generatedForms
        print(" - Generated Forms:")
        forms.sorted(by: { $0.key < $1.key }).forEach { caseName, form in
            print("   • \(caseName): \(form)")
        }
        if let specialForms = entity.forms {
            print(" - Special Forms (including gender variants):")
            for (formType, forms) in specialForms.sorted(by: { $0.key < $1.key }) {
                print("   • \(formType): \(forms.joined(separator: ", "))")
            }
        }
    }

}


