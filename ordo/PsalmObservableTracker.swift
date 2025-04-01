//
//  PsalmObservableTracker.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-31.
//



import Foundation
import Combine

public final class PsalmObservableTracker: ObservableObject {
    public let tracker: PsalmProgressTracker
    private var cancellables = Set<AnyCancellable>()
    private var lastProgressCount: Int = 0
    private var lastCompletedCount: Int = 0
    
    public init() {
        let savePath: String
               if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                   let customPath = documentsDir.appendingPathComponent("ordo_psalm_progress.json").path
                   _ = Self.ensureDirectoryExists(for: customPath)
                   savePath = customPath
               } else {
                   savePath = "psalm_progress.json" // Fallback
               }
               
        self.tracker = PsalmProgressTracker(savePath: savePath)
        self.lastProgressCount = tracker.progress.count
        self.lastCompletedCount = tracker.overallProgress().completed
        
        // Safe observation using only public methods
        Timer.publish(every: 0.2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                let currentCount = self.tracker.progress.count
                let currentCompleted = self.tracker.overallProgress().completed
                
                if currentCount != self.lastProgressCount ||
                   currentCompleted != self.lastCompletedCount {
                    self.lastProgressCount = currentCount
                    self.lastCompletedCount = currentCompleted
                    self.objectWillChange.send()
                }
            }
            .store(in: &cancellables)
    }
    
    // Mirror all public methods
    public func markPsalm(number: Int, section: String? = nil, completed: Bool = true) {
        tracker.markPsalm(number: number, section: section, completed: completed)
    }
    
    public func getProgress(number: Int, section: String? = nil) -> PsalmProgress? {
        tracker.getProgress(number: number, section: section)
    }
    
    public func overallProgress() -> (completed: Int, total: Int) {
        tracker.overallProgress()
    }
    private func getCompletedPsalms() -> [PsalmProgress] {
        
        tracker.getCompletedPsalms()
    }
    // Add other public methods as needed...
    private static func ensureDirectoryExists(for filePath: String) -> Bool {
            let url = URL(fileURLWithPath: filePath)
            let directory = url.deletingLastPathComponent()
            
            do {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
                return true
            } catch {
                print("Directory creation failed: \(error)")
                return false
            }
        }
}
