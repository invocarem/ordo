import Foundation
extension LatinWordEntity {
    func generatedVerbForms() -> [String: [String]] {
        guard partOfSpeech == .verb else { return [:] }
        
        // Validate required fields
        guard let infinitive = infinitive?.lowercased(),
              let conjugation = conjugation else { return [:] }


        let isDeponent: Bool = {
            let presentForm = self.present?.lowercased() ?? ""
            return presentForm.hasSuffix("or") && 
                   (infinitive.hasSuffix("ari") || 
                    infinitive.hasSuffix("eri") || 
                    infinitive.hasSuffix("i"))
        }()
     
        let presentStem: String
        if isDeponent {
            if infinitive.hasSuffix("ari") || infinitive.hasSuffix("eri") {
                presentStem = String(infinitive.dropLast(3)) // dominari → domin
            } else {
                presentStem = String(present!.lowercased().dropLast(2)) // gratulor → gratul
            }
        } else {
            presentStem = String(infinitive.dropLast(3)) // Regular verbs (laudare → laud)
        }

        let stems = VerbStems(
            present: presentStem,
            perfect: isDeponent ? perfect!.lowercased() : 
                (perfect != nil ? String(perfect!.lowercased().dropLast(1)) : ""),
            supine: supine != nil ? String(supine!.lowercased().dropLast(2)) : ""
        )
 
        
        var forms = [String: [String]]()
        let addForm = { (key: String, values: [String]) in
            forms[key] = values.map { $0.lowercased() }
        }

       if !isDeponent {
            generateImperativeForms(conjugation: conjugation, stems: stems, addForm: addForm)
            generatePresentActiveSubjunctive(conjugation: conjugation, stems: stems, addForm: addForm)
        }  

        // Generate all forms
        generatePresentSystemForms(conjugation: conjugation, stems: stems, isDeponent: isDeponent, addForm: addForm)
        generatePerfectSystemForms(stems: stems, isDeponent: isDeponent, addForm: addForm)
        generateNonFiniteForms(infinitive: infinitive, stems: stems, addForm: addForm)
        generateParticipleForms(conjugation: conjugation, stems: stems, addForm: addForm)
        generateSubjunctiveForms(conjugation: conjugation, stems: stems, isDeponent: isDeponent, addForm: addForm)
        generatePresentPassiveForms(conjugation: conjugation, stems: stems, addForm: addForm)
        
        // In generatedVerbForms() function, add:
        generateFuturePassiveFromFutureStem(conjugation: conjugation, stems: stems, addForm: addForm)
        //generateFuturePassiveForms(conjugation: conjugation, stems: stems, addForm: addForm)
        generateImperfectPassiveForms(conjugation: conjugation, stems: stems, addForm: addForm)

        // Apply manual overrides if any
        if let manualForms = self.forms {
            for (key, values) in manualForms {
                forms[key] = values.map { $0.lowercased() }
            }
        }
        
        return forms
    }
    
    // MARK: - Helper Types
    private struct VerbStems {
        let present: String
        let perfect: String
        let supine: String
    }
    
    // MARK: - Form Generators
    private func generatePresentSystemForms(conjugation: Int, stems: VerbStems, isDeponent: Bool, addForm: (String, [String]) -> Void) {
        // Present Active Indicative (or Passive for deponents)
        let presentActive: [String]
        switch conjugation {
        case 1:
            presentActive = [
                stems.present + (isDeponent ? "or" : "o"), 
                stems.present + (isDeponent ? "aris" : "as"),
                stems.present + (isDeponent ? "atur" : "at"),
                stems.present + "amus",
                stems.present + "atis",
                stems.present + (isDeponent ? "antur" : "ant")
            ]
        case 2:
            presentActive = [
                stems.present + (isDeponent ? "eor" : "eo"),
                stems.present + (isDeponent ? "eris" : "es"),
                stems.present + (isDeponent ? "etur" : "et"),
                stems.present + "emus",
                stems.present + "etis",
                stems.present + (isDeponent ? "entur" : "ent")
            ]
        case 3:
            let isIOVerb = stems.present.hasSuffix("i")
            
            // For 3rd conjugation -io verbs, include both regular and alternative forms
            if isIOVerb {
                let regularThirdConjugation = [
                    stems.present + (isDeponent ? "or" : "o"),
                    stems.present + (isDeponent ? "eris" : "is"),
                    stems.present + (isDeponent ? "itur" : "it"),
                    stems.present + "imus",
                    stems.present + "itis",
                    stems.present + (isDeponent ? "iuntur" : "iunt")
                ]
                
                let alternativeForms = [
                    stems.present + (isDeponent ? "ior" : "io"),
                    stems.present + (isDeponent ? "eris" : "is"),
                    stems.present + (isDeponent ? "itur" : "it"),
                    stems.present + "imus",
                    stems.present + "itis",
                    stems.present + (isDeponent ? "iuntur" : "iunt")
                ]
                
                presentActive = regularThirdConjugation + alternativeForms
            } else {
                presentActive = [
                    stems.present + (isDeponent ? "or" : "o"),
                    stems.present + (isDeponent ? "eris" : "is"),
                    stems.present + (isDeponent ? "itur" : "it"),
                    stems.present + "imus",
                    stems.present + "itis",
                    stems.present + (isDeponent ? "untur" : "unt")
                ]
            }
        case 4:
            presentActive = [
                stems.present + (isDeponent ? "ior" : "io"),
                stems.present + (isDeponent ? "iris" : "is"),
                stems.present + (isDeponent ? "itur" : "it"),
                stems.present + "imus",
                stems.present + "itis",
                stems.present + (isDeponent ? "iuntur" : "iunt")
            ]
        default:
            presentActive = []
        }
        addForm("present", presentActive)
        
        // Imperfect Active Indicative (or Passive for deponents)
        let imperfectActive: [String]
        switch conjugation {
        case 1:
            imperfectActive = [
                stems.present + (isDeponent ? "abar" : "abam"),
                stems.present + (isDeponent ? "abaris" : "abas"),
                stems.present + (isDeponent ? "abatur" : "abat"),
                stems.present + "abamus",
                stems.present + "abatis",
                stems.present + (isDeponent ? "abantur" : "abant")
            ]
        case 2, 3:
            imperfectActive = [
                stems.present + (isDeponent ? "ebar" : "ebam"),
                stems.present + (isDeponent ? "ebaris" : "ebas"),
                stems.present + (isDeponent ? "ebatur" : "ebat"),
                stems.present + "ebamus",
                stems.present + "ebatis",
                stems.present + (isDeponent ? "ebantur" : "ebant")
            ]
        case 4:
            imperfectActive = [
                stems.present + (isDeponent ? "iebar" : "iebam"),
                stems.present + (isDeponent ? "iebaris" : "iebas"),
                stems.present + (isDeponent ? "iebatur" : "iebat"),
                stems.present + "iebamus",
                stems.present + "iebatis",
                stems.present + (isDeponent ? "iebantur" : "iebant")
            ]
        default:
            imperfectActive = []
        }
        addForm("imperfect_active", imperfectActive)
        
        // Future Active Indicative (or Passive for deponents)
        let futureActive: [String]
        switch conjugation {
        case 1:
            futureActive = [
                stems.present + (isDeponent ? "abor" : "abo"),
                stems.present + (isDeponent ? "aberis" : "abis"),
                stems.present + (isDeponent ? "abitur" : "abit"),
                stems.present + "abimus",
                stems.present + "abitis",
                stems.present + (isDeponent ? "abuntur" : "abunt")
            ]
        case 2:
            futureActive = [
                stems.present + (isDeponent ? "ebor" : "ebo"),
                stems.present + (isDeponent ? "eberis" : "ebis"),
                stems.present + (isDeponent ? "ebitur" : "ebit"),
                stems.present + "ebimus",
                stems.present + "ebitis",
                stems.present + (isDeponent ? "ebuntur" : "ebunt")
            ]
        case 3:
            let isIOVerb = stems.present.hasSuffix("i")
            
            if isIOVerb {
                // Include both regular and alternative forms for 3rd-io verbs
                let regularThirdConjugation = [
                    stems.present + (isDeponent ? "ar" : "am"),
                    stems.present + (isDeponent ? "eris" : "es"),
                    stems.present + (isDeponent ? "etur" : "et"),
                    stems.present + "emus",
                    stems.present + "etis",
                    stems.present + (isDeponent ? "entur" : "ent")
                ]
                
                let alternativeForms = [
                    stems.present + (isDeponent ? "iar" : "iam"),
                    stems.present + (isDeponent ? "ieris" : "ies"),
                    stems.present + (isDeponent ? "ietur" : "iet"),
                    stems.present + "iemus",
                    stems.present + "ietis",
                    stems.present + (isDeponent ? "ientur" : "ient")
                ]
                
                futureActive = regularThirdConjugation + alternativeForms
            } else {
                futureActive = [
                    stems.present + (isDeponent ? "ar" : "am"),
                    stems.present + (isDeponent ? "eris" : "es"),
                    stems.present + (isDeponent ? "etur" : "et"),
                    stems.present + "emus",
                    stems.present + "etis",
                    stems.present + (isDeponent ? "entur" : "ent")
                ]
            }
        case 4:
            futureActive = [
                stems.present + (isDeponent ? "iar" : "iam"),
                stems.present + (isDeponent ? "ieris" : "ies"),
                stems.present + (isDeponent ? "ietur" : "iet"),
                stems.present + "iemus",
                stems.present + "ietis",
                stems.present + (isDeponent ? "ientur" : "ient")
            ]
        default:
            futureActive = []
        }
        addForm("future", futureActive)
    }
    
    private func generatePerfectSystemForms(stems: VerbStems, isDeponent: Bool, addForm: (String, [String]) -> Void) {
        guard !stems.perfect.isEmpty else { return }
        
         if isDeponent {
            // For deponent verbs, use the perfect participle for all perfect forms
            let perfectParticiple = stems.perfect // + "us" // "dominatus"
            addForm("perfect", [
                perfectParticiple, perfectParticiple, perfectParticiple,
                perfectParticiple, perfectParticiple, perfectParticiple
            ])
        } else {
            // Regular active perfect forms
            addForm("perfect", [
                stems.perfect + "i", stems.perfect + "isti", stems.perfect + "it",
                stems.perfect + "imus", stems.perfect + "istis", stems.perfect + "erunt"
            ])
            addForm("pluperfect",  [
                stems.perfect + "eram", stems.perfect + "eras", stems.perfect + "erat",
                stems.perfect + "eramus", stems.perfect + "eratis", stems.perfect + "erant"
            ])
        
            addForm("future_perfect",  [
                stems.perfect + "ero", stems.perfect + "eris", stems.perfect + "erit",
                stems.perfect + "erimus", stems.perfect + "eritis", stems.perfect + "erint"
            ])
         }
       
    }
    
    private func generateImperativeForms(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
        var imperativeForms = [String]()
        
        switch conjugation {
        case 1:
            imperativeForms = [stems.present + "a", stems.present + "ate"]
        case 2:
            imperativeForms = [stems.present + "e", stems.present + "ete"]
        case 3:
            imperativeForms = [stems.present + "e", stems.present + "ite"]
        case 4:
            imperativeForms = [stems.present + "i", stems.present + "ite"]
        default:
            break
        }
        
        addForm("imperative", imperativeForms)
    }
    private func generateImperfectPassiveForms(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
        let imperfectPassive: [String]
        
        switch conjugation {
        case 1:
            imperfectPassive = [
                stems.present + "abar",
                stems.present + "abaris",
                stems.present + "abatur",
                stems.present + "abamur",
                stems.present + "abamini",
                stems.present + "abantur"
            ]
        case 2:
            imperfectPassive = [
                stems.present + "ebar",
                stems.present + "ebaris",
                stems.present + "ebatur",
                stems.present + "ebamur",
                stems.present + "ebamini",
                stems.present + "ebantur"
            ]
        case 3:
            imperfectPassive = [
                stems.present + "ebar",
                stems.present + "ebaris",
                stems.present + "ebatur",
                stems.present + "ebamur",
                stems.present + "ebamini",
                stems.present + "ebantur"
            ]
        case 4:
            imperfectPassive = [
                stems.present + "iebar",
                stems.present + "iebaris",
                stems.present + "iebatur",
                stems.present + "iebamur",
                stems.present + "iebamini",
                stems.present + "iebantur"
            ]
        default:
            imperfectPassive = []
        }
        
        addForm("imperfect_passive", imperfectPassive)
    }

    private func generateNonFiniteForms(infinitive: String, stems: VerbStems, addForm: (String, [String]) -> Void) {
    addForm("infinitive", [infinitive])

    if !stems.supine.isEmpty {
        addForm("supine", [stems.supine + "um"])

        // Use correct gerund/gerundive suffix for -io, 4th, and deponent verbs
        let usesIendum = infinitive.hasSuffix("i")

        let gerundStem = usesIendum ? stems.present + "iendum" : stems.present + "andum"
        let gerundiveStem = usesIendum ? stems.present + "iendus" : stems.present + "andus"

        addForm("gerund", [gerundStem])
        addForm("gerundive", [gerundiveStem])
    }
}

       
    private func generateParticipleForms(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
    // Present Active Participle
    let participleStem: String
    switch conjugation {
    case 1: participleStem = stems.present + "a"
    case 2: participleStem = stems.present + "e"
    case 3: participleStem = stems.present + "e"
    case 4: participleStem = stems.present + "ie"
    default: participleStem = stems.present
    }
    
    let presentActiveParticiple = [
        participleStem + "ns", participleStem + "ntis", participleStem + "nti",
        participleStem + "ntem", participleStem + "nte", participleStem + "ntes",
        participleStem + "ntium", participleStem + "ntibus", participleStem + "ntis"
    ]
    addForm("present_active_participle", presentActiveParticiple)
    
    // Perfect Passive Participle (if supine stem exists)
    if !stems.supine.isEmpty {
        let supineStem = stems.supine

        // Masculine forms (nominative, genitive, dative, accusative, ablative + plural forms)
        let masculineForms = [
            supineStem + "us", supineStem + "i", supineStem + "o", supineStem + "um", supineStem + "o",
            supineStem + "i", supineStem + "orum", supineStem + "is", supineStem + "os", supineStem + "is"
        ]
        addForm("perfect_passive_participle_m", masculineForms)
        
        // Feminine forms
        let feminineForms = [
            supineStem + "a", supineStem + "ae", supineStem + "ae", supineStem + "am", supineStem + "a",
            supineStem + "ae", supineStem + "arum", supineStem + "is", supineStem + "as", supineStem + "is"
        ]
        addForm("perfect_passive_participle_f", feminineForms)
        
        // Neuter forms
        let neuterForms = [
            supineStem + "um", supineStem + "i", supineStem + "o", supineStem + "um", supineStem + "o",
            supineStem + "a", supineStem + "orum", supineStem + "is", supineStem + "a", supineStem + "is"
        ]
        addForm("perfect_passive_participle_n", neuterForms)
        
    }
}
    
    private func generateSubjunctiveForms(conjugation: Int, stems: VerbStems, isDeponent: Bool, addForm: (String, [String]) -> Void) {

        let imperfectStem: String
        switch conjugation {
        case 1: 
            imperfectStem = stems.present + "are"  // 1st conjugation: -are-
        case 2, 3, 4: 
            imperfectStem = stems.present + "ere"  // Others: -ere-
        default: 
            imperfectStem = stems.present
        }

        // Imperfect Active Subjunctive
        addForm("imperfect_active_subjunctive", [
            imperfectStem + "m", imperfectStem + "s", imperfectStem + "t",
            imperfectStem + "mus", imperfectStem + "tis", imperfectStem + "nt"
        ])
        
        // Imperfect Passive Subjunctive
        addForm("imperfect_passive_subjunctive", [
            imperfectStem + "r", imperfectStem + "ris", imperfectStem + "tur",
            imperfectStem + "mur", imperfectStem + "mini", imperfectStem + "ntur"
        ])
        
        // Present Passive Subjunctive
        let presentPassiveSubjunctive: [String]
        switch conjugation {
        case 1:
            let stem =  stems.present 
            presentPassiveSubjunctive = [
                stem + "er", stem + "eris", stem + "etur",
                stem + "emur", stem + "emini", stem + "entur"  // laeter, laeteris, laetetur, etc.
            ]

        case 2:
            presentPassiveSubjunctive = [
                stems.present + "ear", stems.present + "earis", stems.present + "eatur",
                stems.present + "eamur", stems.present + "eamini", stems.present + "eantur"
            ]
        case 3:
            if stems.present.hasSuffix("i") { // 3rd-io verb
                presentPassiveSubjunctive = [
                    stems.present + "ar",     // eripiar
                    stems.present + "aris",    // eripiaris
                    stems.present + "atur",   // eripiatur
                    stems.present + "amur",   // eripiamur
                    stems.present + "amini",  // eripiamini
                    stems.present + "antur"   // eripiantur
                ]
            } else {
                presentPassiveSubjunctive = [
                    stems.present + "ar", stems.present + "aris", stems.present + "atur",
                    stems.present + "amur", stems.present + "amini", stems.present + "antur"
                ] 
            }
        case 4:
            presentPassiveSubjunctive = [
                stems.present + "iar", stems.present + "iaris", stems.present + "iatur",
                stems.present + "iamur", stems.present + "iamini", stems.present + "iantur"
            ]
        default:
            presentPassiveSubjunctive = []
        }
        addForm("present_passive_subjunctive", presentPassiveSubjunctive)
    }
    
    private func generatePresentActiveSubjunctive(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
    let presentActiveSubjunctive: [String]
    
    switch conjugation {
    case 1:
        presentActiveSubjunctive = [
            stems.present + "em", stems.present + "es", stems.present + "et",
            stems.present + "emus", stems.present + "etis", stems.present + "ent"
        ]
    case 2:
        presentActiveSubjunctive = [
            stems.present + "eam", stems.present + "eas", stems.present + "eat",
            stems.present + "eamus", stems.present + "eatis", stems.present + "eant"
        ]
    case 3:
        presentActiveSubjunctive = [
            // Short forms (classical)
            stems.present + "am", stems.present + "as", stems.present + "at",
            stems.present + "amus", stems.present + "atis", stems.present + "ant",
            // Long forms (-io verbs)
            stems.present + "iam", stems.present + "ias", stems.present + "iat",
            stems.present + "iamus", stems.present + "iatis", stems.present + "iant"
        ]
    case 4:
        presentActiveSubjunctive = [
            stems.present + "iam", stems.present + "ias", stems.present + "iat",
            stems.present + "iamus", stems.present + "iatis", stems.present + "iant"
        ]
    default:
        presentActiveSubjunctive = []
    }
    
    addForm("present_active_subjunctive", presentActiveSubjunctive)
}

private func generateFuturePassiveForms(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
    let futurePassive: [String]
    let isThirdIO = conjugation == 3 && self.present?.hasSuffix("io") == true
    let isDeponent = self.present?.hasSuffix("or") == true
    switch conjugation {
    case 1:
        futurePassive = [
            stems.present + "abor",       // dominabor
            stems.present + "aberis",     // dominaberis
            stems.present + "abitur",     // dominabitur
            stems.present + "abimur",     // dominabimur
            stems.present + "abimini",    // dominabimini
            stems.present + "abuntur"     // dominabuntur
        ]
    case 2:
        futurePassive = [
            stems.present + "ebor",      // monebor
            stems.present + "eberis",    // moneberis
            stems.present + "ebitur",    // monebitur
            stems.present + "ebimur",    // monebimur
            stems.present + "ebimini",   // monebimini
            stems.present + "ebuntur"    // monebuntur
        ]
    case 3:

        // Check if the verb is a 3rd conjugation -io verb
        if isThirdIO || isDeponent {
            // Follow 4th conjugation pattern
            futurePassive = [
                stems.present + "iar",       // eripiar
                stems.present + "ieris",     // eripieris
                stems.present + "ietur",     // eripietur
                stems.present + "iemur",     // eripiemur
                stems.present + "iemini",    // eripiemini
                stems.present + "ientur"     // eripientur
            ]
        } else {
            // Regular 3rd conjugation
            futurePassive = [
                stems.present + "ar",        // regar
                stems.present + "eris",      // regeris
                stems.present + "etur",      // regetur
                stems.present + "emur",      // regemur
                stems.present + "emini",     // regemini
                stems.present + "entur"      // regentur
            ]
        }
    case 4:
        futurePassive = [
            stems.present + "iar",       // audiar
            stems.present + "ieris",     // audieris
            stems.present + "ietur",     // audietur
            stems.present + "iemur",     // audiemur
            stems.present + "iemini",    // audiemini
            stems.present + "ientur"     // audientur
        ]
    default:
        futurePassive = []
    }
    
    addForm("future_passive", futurePassive)
}
private func generatePresentPassiveForms(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
    let presentPassive: [String]
    let isThirdIO = conjugation == 3 && self.present?.hasSuffix("io") == true
    let isDeponent = self.present?.hasSuffix("or") == true
    let presentStem: String
    if isDeponent, let presentForm = present?.lowercased() {
        presentStem = String(presentForm.dropLast(2)) // drops "or"
    } else {
        presentStem = stems.present
    }
    switch conjugation {
    case 1: // -a- (e.g., dominor)
        if isDeponent {
            presentPassive = [
                presentStem + "or",       // gratulor (from gratul- + or)
                presentStem + "aris",     // gratularis
                presentStem + "atur",    // gratulatur
                presentStem + "amur",     // gratulamur
                presentStem + "amini",    // gratulamini
                presentStem + "antur"     // gratulantur
            ]
        } else {
            presentPassive = [
                presentStem + "or",       // dominor
                presentStem + "aris",     // dominaris
                presentStem + "atur",     // dominatur
                presentStem + "amur",     // dominamur
                presentStem + "amini",    // dominamini
                presentStem + "antur"     // dominantur
            ]
        }
        
        
    case 2: // -e- (e.g., moneor)
        presentPassive = [
            stems.present + "eor",      // moneor
            stems.present + "eris",     // moneris
            stems.present + "etur",     // monetur
            stems.present + "emur",     // monemur
            stems.present + "emini",    // monemini
            stems.present + "entur"     // monentur
        ]
    case 3: // -i-/-e- (e.g., regor, capior)
        if isThirdIO {
            presentPassive = [
            stems.present + "ior",      
            stems.present + "eris",    // regeris / caperis
            stems.present + "itur",    // regitur / capitur
            stems.present + "imur",     // regimur / capimur
            stems.present + "imini",    // regimini / capimini
            stems.present + "iuntur"     // reguntur / capiuntur
        ] 
        }   
        else { 
            presentPassive = [
            stems.present + "or",       // regor / capior
            stems.present + "eris",    // regeris / caperis
            stems.present + "itur",    // regitur / capitur
            stems.present + "imur",     // regimur / capimur
            stems.present + "imini",    // regimini / capimini
            stems.present + "untur"     // reguntur / capiuntur
        ] 
        }
    case 4: // -i- (e.g., audior)
        presentPassive = [
            stems.present + "ior",      // audior
            stems.present + "iris",     // audiris
            stems.present + "itur",     // auditur
            stems.present + "imur",     // audimur
            stems.present + "imini",    // audimini
            stems.present + "iuntur"    // audiuntur
        ]
    default:
        presentPassive = []
    }
    
    addForm("present_passive", presentPassive)
}


private func generateFuturePassiveFromFutureStem(conjugation: Int, stems: VerbStems, addForm: (String, [String]) -> Void) {
    guard let futureForm = future?.lowercased() else { return }
    
    // Extract future stem from future form (e.g., "transferam" -> "transfer")
    let futureStem = String(futureForm.dropLast(2)) // drop "am"
    
    let futurePassive: [String]
    switch conjugation {
    case 1:
        futurePassive = [
            futureStem + "bor",       // transferbor
            futureStem + "beris",     // transferberis
            futureStem + "bitur",     // transferbitur
            futureStem + "bimur",     // transferbimur
            futureStem + "bimini",    // transferbimini
            futureStem + "buntur"     // transferbuntur
        ]
    case 2:
        futurePassive = [
            futureStem + "bor",      // monebor
            futureStem + "beris",    // moneberis
            futureStem + "bitur",    // monebitur
            futureStem + "bimur",    // monebimur
            futureStem + "bimini",   // monebimini
            futureStem + "buntur"    // monebuntur
        ]
    case 3:
        let isThirdIO = conjugation == 3 && self.present?.hasSuffix("io") == true
        
        if isThirdIO {
            // 3rd-io verbs follow 4th conjugation pattern
            futurePassive = [
                futureStem + "ar",       // capiar
                futureStem + "eris",     // capieris
                futureStem + "etur",     // capietur
                futureStem + "emur",     // capiemur
                futureStem + "emini",    // capiemini
                futureStem + "entur"     // capientur
            ]
        } else {
            // Regular 3rd conjugation
            futurePassive = [
                futureStem + "ar",        // transferar
                futureStem + "eris",      // transfereris
                futureStem + "etur",      // transferetur
                futureStem + "emur",      // transferemur
                futureStem + "emini",     // transferemini
                futureStem + "entur"      // transferentur
            ]
        }
    case 4:
        futurePassive = [
            futureStem + "ar",       // audiar
            futureStem + "eris",     // audieris
            futureStem + "etur",     // audietur
            futureStem + "emur",     // audiemur
            futureStem + "emini",    // audiemini
            futureStem + "entur"     // audientur
        ]
    default:
        futurePassive = []
    }
    
    addForm("future_passive", futurePassive)
}
}

