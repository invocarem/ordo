//
//  WeeklyProgress.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-30.
//
import Foundation

// Weekly progress record
public struct WeeklyProgress: Codable {
    public let weekStart: Date
    public let completedItems: Set<PsalmIdentifier>
}


