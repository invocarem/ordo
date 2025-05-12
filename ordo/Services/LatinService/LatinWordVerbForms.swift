import Foundation

extension LatinWordEntity {
    func generatedVerbForms() -> [String: [String]] {
        guard partOfSpeech == .verb else { return [:] }
        var forms = [String: [String]]()
        
        // Get principal parts with nil checks
        //let lemma = lemma.lowercased()
        
        guard  let infinitive = infinitive?.lowercased() else { return [:] }
        let perfect = perfect?.lowercased() ?? ""
        let supine = supine?.lowercased() ?? ""
        

        // Determine conjugation (1st-4th)
        let conjugation: Int
        if infinitive.hasSuffix("are") { conjugation = 1 }
        else if infinitive.hasSuffix("ere") { conjugation = 2 }
        else if infinitive.hasSuffix("ere") { conjugation = 3 }
        else if infinitive.hasSuffix("ire") { conjugation = 4 }
        else { return [:] } // Unknown conjugation
        
       
        // Extract stems
        let presentStem = String(infinitive.dropLast(3))
        let perfectStem = perfect.isEmpty ? "" : String(perfect.dropLast(1))
        let supineStem = supine.isEmpty ? "" : String(supine.dropLast(2))
        
        // Helper for adding forms with variants
        func addForm(_ key: String, values: [String]) {
            forms[key] = values.map { $0.lowercased() }
        }


         // MARK: - Imperative Mood
        var imperativeForms = [String]()
        switch conjugation {
        case 1: // -are verbs (ama, amate)
            imperativeForms.append(presentStem + "a")
            imperativeForms.append(presentStem + "ate")
            
        case 2: // -ēre verbs (monē, monēte)
            imperativeForms.append(presentStem + "e")
            imperativeForms.append(presentStem + "ete")
            
        case 3: // -ere verbs (rege, regite)
            imperativeForms.append(presentStem + "e")
            imperativeForms.append(presentStem + "ite")
            
            // Special case for "educo" (short form "educ")
            //if lemma == "educo" {
            //    imperativeForms.append("educ")
            //}
            
        case 4: // -ire verbs (audi, audite)
            imperativeForms.append(presentStem + "i")
            imperativeForms.append(presentStem + "ite")
            
        default: break
        }
        addForm("imperative", values: imperativeForms)
        
        // MARK: - Present System (Active)
        switch conjugation {
        case 1: // -are verbs
            addForm("present", values: [
                presentStem + "o", presentStem + "as", presentStem + "at",
                presentStem + "amus", presentStem + "atis", presentStem + "ant"
            ])
            addForm("imperfect", values: [
                presentStem + "abam", presentStem + "abas", presentStem + "abat",
                presentStem + "abamus", presentStem + "abatis", presentStem + "abant"
            ])
            addForm("future", values: [
                presentStem + "abo", presentStem + "abis", presentStem + "abit",
                presentStem + "abimus", presentStem + "abitis", presentStem + "abunt"
            ])
            
        case 2: // -ēre verbs
            addForm("present", values: [
                presentStem + "eo", presentStem + "es", presentStem + "et",
                presentStem + "emus", presentStem + "etis", presentStem + "ent"
            ])
            
        case 3: // -ere verbs
            addForm("present", values: [
                presentStem + "o", presentStem + "is", presentStem + "it",
                presentStem + "imus", presentStem + "itis", presentStem + "unt"
            ])
            
        case 4: // -ire verbs
            addForm("present", values: [
                presentStem + "io", presentStem + "is", presentStem + "it",
                presentStem + "imus", presentStem + "itis", presentStem + "iunt"
            ])
            
        default: break
        }
        
        // MARK: - Perfect System (Active)
        if !perfectStem.isEmpty {
            addForm("perfect", values: [
                perfectStem + "i", perfectStem + "isti", perfectStem + "it",
                perfectStem + "imus", perfectStem + "istis", perfectStem + "erunt"
            ])
            addForm("pluperfect", values: [
                perfectStem + "eram", perfectStem + "eras", perfectStem + "erat",
                perfectStem + "eramus", perfectStem + "eratis", perfectStem + "erant"
            ])
            addForm("future_perfect", values: [
                perfectStem + "ero", perfectStem + "eris", perfectStem + "erit",
                perfectStem + "erimus", perfectStem + "eritis", perfectStem + "erint"
            ])
        }
        
        // MARK: - Passive Voice
        if !supineStem.isEmpty {
            let passiveParticiple = supineStem + "us"
            addForm("past_participle", values: [passiveParticiple])
            
            // Present passive differs by conjugation
            switch conjugation {
            case 1:
                addForm("present_passive", values: [
                    presentStem + "or", presentStem + "aris", presentStem + "atur",
                    presentStem + "amur", presentStem + "amini", presentStem + "antur"
                ])
            case 3:
                addForm("present_passive", values: [
                    presentStem + "or", presentStem + "eris", presentStem + "itur",
                    presentStem + "imur", presentStem + "imini", presentStem + "untur"
                ])
            // Add cases 2 and 4 similarly
            default: break
            }
        }
        
        // MARK: - Non-Finite Forms
        addForm("infinitive", values: [infinitive])
        if !supine.isEmpty {
            addForm("supine", values: [supine])
            addForm("gerund", values: [presentStem + "andum"])
            addForm("gerundive", values: [presentStem + "andus"])
        }
        
        // MARK: - Irregular Form Handling
        // Override with manually specified forms if they exist
        if let manualForms = self.forms {
            for (key, values) in manualForms {
                forms[key] = values.map { $0.lowercased() }
            }
        }

        addForm("imperfect_subjunctive", values: [
            presentStem + "erem", presentStem + "eres", presentStem + "eret",
            presentStem + "eremus", presentStem + "eretis", presentStem + "erent"
        ])
        if conjugation == 1 {
           addForm("present_passive_subjunctive", values: [
                presentStem + "er", presentStem + "eris", presentStem + "etur",
                presentStem + "emur", presentStem + "emini", presentStem + "entur"
            ])
        }
        
        return forms
    }
   
    
    
}
