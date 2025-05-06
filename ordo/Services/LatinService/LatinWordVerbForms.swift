import Foundation

extension LatinWordEntity {
    func generatedVerbForms() -> [String: [String]] {
        guard partOfSpeech == .verb else { return [:] }
        var forms = [String: [String]]()
        
        // Get principal parts with nil checks
        let lemma = lemma.lowercased()
        
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
            imperativeForms.append(presentStem + "ē")
            imperativeForms.append(presentStem + "ēte")
            
        case 3: // -ere verbs (rege, regite)
            imperativeForms.append(presentStem + "e")
            imperativeForms.append(presentStem + "ite")
            
            // Special case for "educo" (short form "educ")
            //if lemma == "educo" {
            //    imperativeForms.append("educ")
            //}
            
        case 4: // -ire verbs (audi, audite)
            imperativeForms.append(presentStem + "ī")
            imperativeForms.append(presentStem + "īte")
            
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
    public var xgeneratedVerbForms: [String: String] {
        guard partOfSpeech == .verb else { return [:] }
        var forms = [String: String]()
        
        // Get the verb's principal parts
        let infinitive = self.infinitive ?? ""
        let perfect = self.perfect ?? ""
        let supine = self.supine ?? ""
        
        // Extract stems
        let presentStem = infinitive.isEmpty ? "" : String(infinitive.dropLast(3)) // -are -> a, -ere -> e, etc.
        let perfectStem = perfect.isEmpty ? "" : String(perfect.dropLast(1)) // drop -i
        let supineStem = supine.isEmpty ? "" : String(supine.dropLast(2)) // drop -um
        
        // Determine conjugation based on infinitive ending
        let conjugation: Int
        if infinitive.hasSuffix("are") {
            conjugation = 1
        } else if infinitive.hasSuffix("ēre") {
            conjugation = 2
        } else if infinitive.hasSuffix("ere") {
            conjugation = 3
        } else if infinitive.hasSuffix("ire") {
            conjugation = 4
        } else {
            return [:] // unknown conjugation
        }
        
        // Common function to generate perfect system forms
        func generatePerfectSystem() {
            if !perfect.isEmpty {
                // Perfect active indicative
                forms["perfect_1s"] = perfectStem + "i"
                forms["perfect_2s"] = perfectStem + "isti"
                forms["perfect_3s"] = perfectStem + "it"
                forms["perfect_1p"] = perfectStem + "imus"
                forms["perfect_2p"] = perfectStem + "istis"
                forms["perfect_3p"] = perfectStem + "erunt"
                
                // Pluperfect active indicative
                forms["pluperfect_1s"] = perfectStem + "eram"
                forms["pluperfect_2s"] = perfectStem + "eras"
                forms["pluperfect_3s"] = perfectStem + "erat"
                forms["pluperfect_1p"] = perfectStem + "eramus"
                forms["pluperfect_2p"] = perfectStem + "eratis"
                forms["pluperfect_3p"] = perfectStem + "erant"
                
                // Future perfect active indicative
                forms["future_perfect_1s"] = perfectStem + "ero"
                forms["future_perfect_2s"] = perfectStem + "eris"
                forms["future_perfect_3s"] = perfectStem + "erit"
                forms["future_perfect_1p"] = perfectStem + "erimus"
                forms["future_perfect_2p"] = perfectStem + "eritis"
                forms["future_perfect_3p"] = perfectStem + "erint"
            }
            
            if !supine.isEmpty {
                // Passive perfect system would require "esse" which we can't generate here
                forms["past_participle"] = supineStem + "us"
            }
        }
        
        // Generate forms based on conjugation
        switch conjugation {
        case 1: // First conjugation (-are)
            // Present active indicative
            forms["present_1s"] = presentStem + "o"
            forms["present_2s"] = presentStem + "as"
            forms["present_3s"] = presentStem + "at"
            forms["present_1p"] = presentStem + "amus"
            forms["present_2p"] = presentStem + "atis"
            forms["present_3p"] = presentStem + "ant"
            
            // Present active subjunctive
            forms["present_subjunctive_1s"] = presentStem + "em"
            forms["present_subjunctive_2s"] = presentStem + "es"
            forms["present_subjunctive_3s"] = presentStem + "et"
            forms["present_subjunctive_1p"] = presentStem + "emus"
            forms["present_subjunctive_2p"] = presentStem + "etis"
            forms["present_subjunctive_3p"] = presentStem + "ent"
            
            // Imperfect active indicative
            forms["imperfect_1s"] = presentStem + "abam"
            forms["imperfect_2s"] = presentStem + "abas"
            forms["imperfect_3s"] = presentStem + "abat"
            forms["imperfect_1p"] = presentStem + "abamus"
            forms["imperfect_2p"] = presentStem + "abatis"
            forms["imperfect_3p"] = presentStem + "abant"
            
            // Imperfect active subjunctive
            forms["imperfect_subjunctive_1s"] = presentStem + "arem"
            forms["imperfect_subjunctive_2s"] = presentStem + "ares"
            forms["imperfect_subjunctive_3s"] = presentStem + "aret"
            forms["imperfect_subjunctive_1p"] = presentStem + "aremus"
            forms["imperfect_subjunctive_2p"] = presentStem + "aretis"
            forms["imperfect_subjunctive_3p"] = presentStem + "arent"
            
            // Future active indicative
            forms["future_1s"] = presentStem + "abo"
            forms["future_2s"] = presentStem + "abis"
            forms["future_3s"] = presentStem + "abit"
            forms["future_1p"] = presentStem + "abimus"
            forms["future_2p"] = presentStem + "abitis"
            forms["future_3p"] = presentStem + "abunt"
            
            // Present passive indicative
            forms["present_passive_1s"] = presentStem + "or"
            forms["present_passive_2s"] = presentStem + "aris"
            forms["present_passive_3s"] = presentStem + "atur"
            forms["present_passive_1p"] = presentStem + "amur"
            forms["present_passive_2p"] = presentStem + "amini"
            forms["present_passive_3p"] = presentStem + "antur"
            
            // Present passive subjunctive
            forms["present_passive_subjunctive_1s"] = presentStem + "er"
            forms["present_passive_subjunctive_2s"] = presentStem + "eris"
            forms["present_passive_subjunctive_3s"] = presentStem + "etur"
            forms["present_passive_subjunctive_1p"] = presentStem + "emur"
            forms["present_passive_subjunctive_2p"] = presentStem + "emini"
            forms["present_passive_subjunctive_3p"] = presentStem + "entur"
            
            // Imperative
            forms["imperative_s"] = presentStem + "a"
            forms["imperative_p"] = presentStem + "ate"
            
            // Generate perfect system
            generatePerfectSystem()
            
        case 2: // Second conjugation (-ēre)
            // Present active indicative
            forms["present_1s"] = presentStem + "eo"
            forms["present_2s"] = presentStem + "es"
            forms["present_3s"] = presentStem + "et"
            forms["present_1p"] = presentStem + "emus"
            forms["present_2p"] = presentStem + "etis"
            forms["present_3p"] = presentStem + "ent"
            
            // Present active subjunctive
            forms["present_subjunctive_1s"] = presentStem + "eam"
            forms["present_subjunctive_2s"] = presentStem + "eas"
            forms["present_subjunctive_3s"] = presentStem + "eat"
            forms["present_subjunctive_1p"] = presentStem + "eamus"
            forms["present_subjunctive_2p"] = presentStem + "eatis"
            forms["present_subjunctive_3p"] = presentStem + "eant"
            
            // Imperfect active indicative
            forms["imperfect_1s"] = presentStem + "ebam"
            forms["imperfect_2s"] = presentStem + "ebas"
            forms["imperfect_3s"] = presentStem + "ebat"
            forms["imperfect_1p"] = presentStem + "ebamus"
            forms["imperfect_2p"] = presentStem + "ebatis"
            forms["imperfect_3p"] = presentStem + "ebant"
            
            // Imperfect active subjunctive
            forms["imperfect_subjunctive_1s"] = presentStem + "erem"
            forms["imperfect_subjunctive_2s"] = presentStem + "eres"
            forms["imperfect_subjunctive_3s"] = presentStem + "eret"
            forms["imperfect_subjunctive_1p"] = presentStem + "eremus"
            forms["imperfect_subjunctive_2p"] = presentStem + "eretis"
            forms["imperfect_subjunctive_3p"] = presentStem + "erent"
            
            // Future active indicative
            forms["future_1s"] = presentStem + "ebo"
            forms["future_2s"] = presentStem + "ebis"
            forms["future_3s"] = presentStem + "ebit"
            forms["future_1p"] = presentStem + "ebimus"
            forms["future_2p"] = presentStem + "ebitis"
            forms["future_3p"] = presentStem + "ebunt"
            
            // Present passive indicative
            forms["present_passive_1s"] = presentStem + "eor"
            forms["present_passive_2s"] = presentStem + "eris"
            forms["present_passive_3s"] = presentStem + "etur"
            forms["present_passive_1p"] = presentStem + "emur"
            forms["present_passive_2p"] = presentStem + "emini"
            forms["present_passive_3p"] = presentStem + "entur"
            
            // Imperative
            forms["imperative_s"] = presentStem + "e"
            forms["imperative_p"] = presentStem + "ete"
            
            // Generate perfect system
            generatePerfectSystem()
            
        case 3: // Third conjugation (-ere)
            // Present active indicative
            forms["present_1s"] = presentStem + "o"
            forms["present_2s"] = presentStem + "is"
            forms["present_3s"] = presentStem + "it"
            forms["present_1p"] = presentStem + "imus"
            forms["present_2p"] = presentStem + "itis"
            forms["present_3p"] = presentStem + "unt"
            
            // Present active subjunctive
            forms["present_subjunctive_1s"] = presentStem + "am"
            forms["present_subjunctive_2s"] = presentStem + "as"
            forms["present_subjunctive_3s"] = presentStem + "at"
            forms["present_subjunctive_1p"] = presentStem + "amus"
            forms["present_subjunctive_2p"] = presentStem + "atis"
            forms["present_subjunctive_3p"] = presentStem + "ant"
            
            // Imperfect active indicative
            forms["imperfect_1s"] = presentStem + "ebam"
            forms["imperfect_2s"] = presentStem + "ebas"
            forms["imperfect_3s"] = presentStem + "ebat"
            forms["imperfect_1p"] = presentStem + "ebamus"
            forms["imperfect_2p"] = presentStem + "ebatis"
            forms["imperfect_3p"] = presentStem + "ebant"
            
            // Imperfect active subjunctive
            forms["imperfect_subjunctive_1s"] = presentStem + "erem"
            forms["imperfect_subjunctive_2s"] = presentStem + "eres"
            forms["imperfect_subjunctive_3s"] = presentStem + "eret"
            forms["imperfect_subjunctive_1p"] = presentStem + "eremus"
            forms["imperfect_subjunctive_2p"] = presentStem + "eretis"
            forms["imperfect_subjunctive_3p"] = presentStem + "erent"
            
            // Future active indicative
            forms["future_1s"] = presentStem + "am"
            forms["future_2s"] = presentStem + "es"
            forms["future_3s"] = presentStem + "et"
            forms["future_1p"] = presentStem + "emus"
            forms["future_2p"] = presentStem + "etis"
            forms["future_3p"] = presentStem + "ent"
            
            // Present passive indicative
            forms["present_passive_1s"] = presentStem + "or"
            forms["present_passive_2s"] = presentStem + "eris"
            forms["present_passive_3s"] = presentStem + "itur"
            forms["present_passive_1p"] = presentStem + "imur"
            forms["present_passive_2p"] = presentStem + "imini"
            forms["present_passive_3p"] = presentStem + "untur"
            
            // Imperative
            forms["imperative_s"] = presentStem + "e"
            forms["imperative_p"] = presentStem + "ite"
            
            // Generate perfect system
            generatePerfectSystem()
            
        case 4: // Fourth conjugation (-ire)
            // Present active indicative
            forms["present_1s"] = presentStem + "io"
            forms["present_2s"] = presentStem + "is"
            forms["present_3s"] = presentStem + "it"
            forms["present_1p"] = presentStem + "imus"
            forms["present_2p"] = presentStem + "itis"
            forms["present_3p"] = presentStem + "iunt"
            
            // Present active subjunctive
            forms["present_subjunctive_1s"] = presentStem + "iam"
            forms["present_subjunctive_2s"] = presentStem + "ias"
            forms["present_subjunctive_3s"] = presentStem + "iat"
            forms["present_subjunctive_1p"] = presentStem + "iamus"
            forms["present_subjunctive_2p"] = presentStem + "iatis"
            forms["present_subjunctive_3p"] = presentStem + "iant"
            
            // Imperfect active indicative
            forms["imperfect_1s"] = presentStem + "iebam"
            forms["imperfect_2s"] = presentStem + "iebas"
            forms["imperfect_3s"] = presentStem + "iebat"
            forms["imperfect_1p"] = presentStem + "iebamus"
            forms["imperfect_2p"] = presentStem + "iebatis"
            forms["imperfect_3p"] = presentStem + "iebant"
            
            // Imperfect active subjunctive
            forms["imperfect_subjunctive_1s"] = presentStem + "irem"
            forms["imperfect_subjunctive_2s"] = presentStem + "ires"
            forms["imperfect_subjunctive_3s"] = presentStem + "iret"
            forms["imperfect_subjunctive_1p"] = presentStem + "iremus"
            forms["imperfect_subjunctive_2p"] = presentStem + "iretis"
            forms["imperfect_subjunctive_3p"] = presentStem + "irent"
            
            // Future active indicative
            forms["future_1s"] = presentStem + "iam"
            forms["future_2s"] = presentStem + "ies"
            forms["future_3s"] = presentStem + "iet"
            forms["future_1p"] = presentStem + "iemus"
            forms["future_2p"] = presentStem + "ietis"
            forms["future_3p"] = presentStem + "ient"
            
            // Present passive indicative
            forms["present_passive_1s"] = presentStem + "ior"
            forms["present_passive_2s"] = presentStem + "iris"
            forms["present_passive_3s"] = presentStem + "itur"
            forms["present_passive_1p"] = presentStem + "imur"
            forms["present_passive_2p"] = presentStem + "imini"
            forms["present_passive_3p"] = presentStem + "iuntur"
            
            // Imperative
            forms["imperative_s"] = presentStem + "i"
            forms["imperative_p"] = presentStem + "ite"
            
            // Generate perfect system
            generatePerfectSystem()
            
        default:
            break
        }
        
        // Add non-finite forms
        forms["infinitive"] = infinitive
        if !supine.isEmpty {
            forms["supine"] = supine
            forms["past_participle"] = supineStem + "us"
            forms["future_participle"] = supineStem + "urus"
            forms["gerund"] = presentStem + "andum"
            forms["gerundive"] = presentStem + "andus"
        }
        
        // Add present active participle (same for all conjugations)
        forms["present_participle"] = presentStem + "ans" // For 1st conj., others vary slightly
        
        return forms
    }
    
    
}