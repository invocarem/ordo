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
            
            // Map possessive forms
            mapPossessiveForms(from: entity, to: &mapping)
            
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
        
        guard let forms = entity.forms else { return }
        
        for (formKey, formValue) in forms {
            // Handle _f, _n, and _participle forms
            if formKey.hasSuffix("_f") || formKey.hasSuffix("_n") || formKey.hasSuffix("_participle") {
                if let stringArray = formValue as? [String] {
                    stringArray.forEach { form in
                        mapping[form.lowercased()] = lemma
                    }
                } else if let string = formValue as? String {
                    mapping[string.lowercased()] = lemma
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
    
    private func mapPossessiveForms(from entity: LatinWordEntity, to mapping: inout [String: String]) {
        let lemma = entity.lemma.lowercased()
        
        guard let possessive = entity.possessive else { return }
        
        // Singular forms
        possessive.singular?.values.forEach { genderForms in
            genderForms.values.forEach { form in
                mapping[form.lowercased()] = lemma
            }
        }
        
        // Plural forms
        possessive.plural?.values.forEach { genderForms in
            genderForms.values.forEach { form in
                mapping[form.lowercased()] = lemma
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