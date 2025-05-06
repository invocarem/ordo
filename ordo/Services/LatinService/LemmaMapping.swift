struct LemmaMapping {
    private let wordEntities: [LatinWordEntity]
    
    init(wordEntities: [LatinWordEntity]) {
        self.wordEntities = wordEntities
    }
    func dump(entity: LatinWordEntity) {
        let dumpkey = "deprecor"
        if entity.lemma.lowercased() == dumpkey {
                print("\n=== Generating forms for \(dumpkey) ===")
                let forms = entity.generatedVerbForms()

                print("\nAll forms of \(dumpkey):")
                print("\(entity)")
                forms.sorted(by: { $0.key < $1.key }).forEach { formType, forms in
                    print("- \(formType): \(forms.joined(separator: ", "))")
                }
                
                
                
                // Print the lemma mapping being created
                print("\nResulting mappings:")
            }
        }
    
    func createFormToLemmaMapping() -> [String: [String]] {
        var mapping: [String: [String]] = [:]
        
        for entity in wordEntities {
        
            
            // Map all standard case forms
            mapStandardForms(from: entity, to: &mapping)

            mapSpecialForms(from: entity, to: &mapping)
            
            // Map verb forms if applicable
            if entity.partOfSpeech == .verb {
                mapVerbForms(from: entity, to: &mapping)

                //dump(entity: entity)

                // Then add generated forms (won't override existing entries)
                let generated = entity.generatedVerbForms()
                for (_, forms) in generated {
                    for form in forms {
                        if !mapping[form, default: []].contains(entity.lemma) {
                            mapping[form, default: []].append(entity.lemma)
                        }
                    }
                }
            }
            
            
        }
        
       
        
        return mapping
    }
    private func mapStandardForms(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
    let lemma = entity.lemma.lowercased()
    
    // Original case forms array (keeping the same variable name)
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
    ]
    
    // Get generated forms
    let generatedForms = Array(entity.generatedForms.values)
    
    // Combine both sets of forms (compactMap filters out nil values)
    let allForms = caseForms.compactMap { $0 } + generatedForms
    
    // Map all forms to the lemma
    allForms.forEach { form in
        let lowerForm = form.lowercased()
        mapping[lowerForm, default: []].append(lemma)
    }
}
   
    private func mapStandardFormsOrig(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
        let lemma = entity.lemma.lowercased()
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
        ]
        
        caseForms.compactMap { $0?.lowercased() }
            .forEach { form in
                mapping[form, default: []].append(lemma)
            }
    }
    
    private func mapSpecialForms(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
        let lemma = entity.lemma.lowercased()
        
        // Handle forms (singular declensions or singular verb forms)
        if let forms = entity.forms {
            for (_, formValue) in forms {
                formValue.forEach { form in
                    let lowerForm = form.lowercased()
                    mapping[lowerForm, default: []].append(lemma)
                }
            }
        }
        
       
        
        // Handle formsPlural (plural declensions or plural verb forms)
        if let formsPlural = entity.formsPlural {
            for (_, formValues) in formsPlural {
                formValues.forEach { form in
                    let lowerForm = form.lowercased()
                   
                    mapping[lowerForm, default: []].append(lemma)
                }
            }
        }
        
       
    }
    
    private func mapVerbForms(from entity: LatinWordEntity, to mapping: inout [String: [String]]) {
        let lemma = entity.lemma.lowercased()
        
        // Map principal parts
        [entity.infinitive, entity.perfect].compactMap { $0?.lowercased() }
            .forEach { form in
                mapping[form, default: []].append(lemma)
            }
        
        // Map all verb forms
        if let verbForms = entity.forms {
            for (_, formArray) in verbForms {
                for formVariants in formArray {
                    formVariants.lowercased()
                        .components(separatedBy: "/")
                        .forEach { variant in
                           
                            mapping[variant, default: []].append(lemma)
                        }
                }
            }
        }
        let generatedForms = Array(entity.generatedForms.values)
    
       
    }
}