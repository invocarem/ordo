//
//  LatinWordEntity.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-27.
//

import Foundation

public struct LatinWordEntity: Codable {
    public let lemma: String
    public let partOfSpeech: PartOfSpeech?
    public let declension: Int?
    public let gender: Gender?
    
    // Case forms
    public let vocative: String?
    public let nominative: String?
    public let dative: String?
    public let accusative: String?
    public let genitive: String?
    public let ablative: String?
    
    // Plural forms
    public let nominative_plural: String?
    public let genitive_plural: String?
    public let dative_plural: String?
    public let accusative_plural: String?
    public let ablative_plural: String?
    
    // Possessive forms
    public let possessive: PossessiveForms?
    
    // Verb-specific properties
    public let perfect: String?
    public let infinitive: String?
    public let supine: String?

    public let conjugation: Int?
    
    public let forms: [String: [String]]?
    public let formsPlural: [String: [String]]?
    
    public let baseForm: String?
    public let derivedFrom: DerivedFrom?

    // Translations
    public let translations: [String: String]?
    
    public struct PossessiveForms: Codable {
        public let singular: [String: [String: String]]?
        public let plural: [String: [String: String]]?
    }

    public struct DerivedFrom: Codable {
        public let lemma: String
        public let partOfSpeech: PartOfSpeech
        
        private enum CodingKeys: String, CodingKey {
            case lemma
            case partOfSpeech = "part_of_speech"
        }
    }

    public init(
        lemma: String,
        partOfSpeech: PartOfSpeech? = nil,
        declension: Int? = nil,
        gender: Gender? = nil,
        
        vocative: String? = nil,
        
        nominative: String? = nil,
        dative: String? = nil,
        accusative: String? = nil,
        genitive: String? = nil,
        ablative: String? = nil,
        
        nominative_plural: String? = nil,
        genitive_plural: String? = nil,
        dative_plural: String? = nil,
        accusative_plural: String? = nil,
        ablative_plural: String? = nil,
        possessive: PossessiveForms? = nil,
        perfect: String? = nil,
        infinitive: String? = nil,
        supine: String? = nil,
        conjugation: Int? = nil,
        forms: [String: [String]]? = nil,
        formsPlural: [String: [String]]? = nil,
        baseForm: String? = nil,
        derivedFrom: DerivedFrom? = nil,
        translations: [String: String]? = nil
    ) {
        self.lemma = lemma
        self.partOfSpeech = partOfSpeech
        self.gender = gender
        self.declension = declension
        self.vocative = vocative
        
        self.nominative = nominative
        self.dative = dative
        self.accusative = accusative
        self.genitive = genitive
        self.ablative = ablative
        self.nominative_plural = nominative_plural
        self.genitive_plural = genitive_plural
        self.dative_plural = dative_plural
        self.accusative_plural = accusative_plural
        self.ablative_plural = ablative_plural
        self.possessive = possessive
        self.perfect = perfect
        self.infinitive = infinitive
        self.supine = supine
        self.conjugation = conjugation
        self.forms = forms
        self.formsPlural = formsPlural
        self.baseForm = baseForm
        self.derivedFrom = derivedFrom
        self.translations = translations
    }
    
    // CodingKeys would remain here
    // CodingKeys for backward compatibility
    private enum CodingKeys: String, CodingKey {
        case lemma
        case partOfSpeech = "part_of_speech"
        case gender
        case declension
        case vocative
        case nominative, dative, accusative, genitive, ablative
        case nominative_plural = "nominative_plural"
        case genitive_plural = "genitive_plural"
        case dative_plural = "dative_plural"
        case accusative_plural = "accusative_plural"
        case ablative_plural = "ablative_plural"
        case possessive
        case perfect, infinitive, forms
        case supine
        case conjugation
        case formsPlural = "forms_plural"
        case baseForm = "base_form"
        case derivedFrom = "derived_from"
        case translations
    }

}

// Enums for type safety
public enum PartOfSpeech: String, Codable {
    case noun, verb, pronoun, adjective, adverb,preposition,conjunction,interjection
}

public enum Gender: String, Codable {
    case masculine, feminine, neuter
}
