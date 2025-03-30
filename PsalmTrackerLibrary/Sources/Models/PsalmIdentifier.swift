
//
//  PsalmIdentifier.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-30.
//
import Foundation
// Unique identifier for a psalm section
public struct PsalmIdentifier: Hashable, Codable {
    public let number: Int
    public let section: String? // nil for entire psalm
    
    public init(number: Int, section: String? = nil) {
        self.number = number
        self.section = section
    }
}

