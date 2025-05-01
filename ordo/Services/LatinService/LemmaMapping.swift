import Foundation

struct LemmaMapping {
    private let wordEntities: [LatinWordEntity]
    
    init(wordEntities: [LatinWordEntity]) {
        self.wordEntities = wordEntities
    }
    
    func createFormToLemmaMapping() -> [String: String] {
        var mapping: [String: String] = [:]
        
        for entity in wordEntities {
            let lemma = entity.lemma.lowercased()
            
            // Map all standard case forms
            mapStandardForms(from: entity, to: &mapping)

            mapSpecialForms(from: entity, to: &mapping)
            
            // Map verb forms if applicable
            if entity.partOfSpeech == .verb {
                mapVerbForms(from: entity, to: &mapping)
            }
            
           
            
            // Map generated forms
            mapGeneratedForms(from: entity, to: &mapping)
        }
        

        return mapping
    }
    
    private func mapStandardForms(from entity: LatinWordEntity, to mapping: inout [String: String]) {
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
            .forEach { mapping[$0] = lemma }
    }
    
     private func mapSpecialForms(from entity: LatinWordEntity, to mapping: inout [String: String]) {
        let lemma = entity.lemma.lowercased()
        
        // Handle forms (singular declensions or singular verb forms)
        if let forms = entity.forms {
            for (formKey, formValue) in forms {
                // Map all forms, including declensions (e.g., nominative_f, nominative) and verb forms (e.g., present_active_indicative)
                formValue.forEach { form in
                    mapping[form.lowercased()] = lemma
                }
            }
        }
        
        // Handle formsPlural (plural declensions or plural verb forms)
        if let formsPlural = entity.formsPlural {
            for (formKey, formValue) in formsPlural {
                // Exclude participle keys from formsPlural, as they belong in forms
                if !formKey.contains("participle") {
                    formValue.forEach { form in
                        mapping[form.lowercased()] = lemma
                    }
                }
            }
        }
    }
    
    private func mapVerbForms(from entity: LatinWordEntity, to mapping: inout [String: String]) {
        let lemma = entity.lemma.lowercased()
        
        // Map principal parts
        [entity.infinitive, entity.perfect].compactMap { $0?.lowercased() }
            .forEach { mapping[$0] = lemma }
        
        // Map all verb forms
        if let verbForms = entity.forms {
            for (_, formArray) in verbForms {
                for formVariants in formArray {
                    formVariants.lowercased()
                        .components(separatedBy: "/")
                        .forEach { variant in
                            mapping[variant] = lemma
                        }
                }
            }
        }
    }
    
    
    
    private func mapGeneratedForms(from entity: LatinWordEntity, to mapping: inout [String: String]) {
        let lemma = entity.lemma.lowercased()
        
        entity.generatedForms.values
            .map { $0.lowercased() }
            .forEach { mapping[$0] = lemma }
    }
}