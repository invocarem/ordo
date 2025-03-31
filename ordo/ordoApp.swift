//
//  ordoApp.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-24.
//

import SwiftUI

@main
struct ordoApp: App {
    // Shared instances
        @StateObject private var progressTracker = PsalmProgressTracker()
        let psalmService = PsalmService.shared
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(progressTracker)
                .environment(\.psalmService, psalmService)
        }
    }
}
// Helper to pass psalmService via environment
extension EnvironmentValues {
    var psalmService: PsalmService {
        get { self[PsalmServiceKey.self] }
        set { self[PsalmServiceKey.self] = newValue }
    }
}

private struct PsalmServiceKey: EnvironmentKey {
    static let defaultValue: PsalmService = .shared
}
