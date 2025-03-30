//
//  StorageProtocol.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-30.
//
import Foundation
// Storage protocol
public protocol ProgressStorage {
    func save(weeklyProgress: [WeeklyProgress]) throws
    func loadWeeklyProgress() throws -> [WeeklyProgress]
}
