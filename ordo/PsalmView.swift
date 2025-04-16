//
//  PsalmView.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-29.
//
import SwiftUI

struct PsalmView: View {
    let psalm: PsalmUsage
    let psalmService: PsalmService
    @EnvironmentObject private var observableTracker: PsalmObservableTracker
    
    @State private var psalmContent: [String] = []
    @State private var englishContent: [String] = []
    @State private var errorMessage: String?
    @State private var isCompleted: Bool = false
    
    // Gloria Patri configuration
    private var shouldShowGloria: Bool {        
        !(Int(psalm.number) == 115)
    }
    
    var body: some View {
        PrayerSectionView(
            title: psalmHeader,
            content: psalmContent + (shouldShowGloria ? LiturgicalConstants.gloriaPatri : []),
            contentB: englishContent.isEmpty ? nil : (englishContent + (shouldShowGloria ? LiturgicalConstants.gloriaPatriEnglish : [])),
            showToggle: true,
            isCompleted: Binding<Bool>(
                get: { isCompleted },
                set: { newValue in
                    isCompleted = newValue
                    observableTracker.markPsalm(
                        number: Int(psalm.number) ?? 0,
                        section: psalm.category,
                        completed: newValue
                    )
                }
            )
        )
        .onAppear {
            loadPsalmContent()
            loadCompletionState()
        }
    }
    
    private var psalmHeader: String {
        var headerParts = [String]()
        headerParts.append("Psalm \(psalm.number)")
        
        if let category = psalm.category, !category.isEmpty {
            headerParts.append("(\(category))")
        }
        
        return headerParts.joined(separator: " ")
    }
    
    private func loadPsalmContent() {
        print("Loading psalm \(psalm.number) for category: \(psalm.category ?? "none")")
          
        do {
            guard let psalmNumber = Int(psalm.number) else {
                throw PsalmError.invalidNumberFormat(psalm.number)
            }
            
            let psalmSections = psalmService.getPsalms(number: psalmNumber)
            
            if psalmSections.isEmpty {
                throw PsalmError.versesNotFound(psalmNumber)
            }
            
            let selectedSection: Psalm
            if psalmSections.count == 1 {
                selectedSection = psalmSections.first!
            } else {
                guard let section = psalm.category,
                      let psalmSection = psalmSections.first(where: { $0.section?.lowercased() == section.lowercased() })
                else {
                    throw PsalmError.versesNotFound(psalmNumber)
                }
                selectedSection = psalmSection
            }
            
            psalmContent = selectedSection.text
            englishContent = selectedSection.englishText ?? []
            
        } catch PsalmError.invalidNumberFormat(let number) {
            errorMessage = "Invalid psalm number format: '\(number)'"
            psalmContent = [errorMessage!]
        } catch PsalmError.versesNotFound(let number) {
            errorMessage = "No verses found for Psalm \(number)"
            psalmContent = [errorMessage!]
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
            psalmContent = [errorMessage!]
        }
    }
    
    private func loadCompletionState() {
        if let progress = observableTracker.getProgress(
            number: Int(psalm.number) ?? 0,
            section: psalm.category
        ) {
            isCompleted = progress.isCompleted
        }
    }
}

// MARK: - Constants
private enum LiturgicalConstants {
    static let gloriaPatri = [
        "𝄆 Gloria Patri, et Filio, et Spiritui Sancto.",
        "Sicut erat in principio, et nunc, et semper,",
        "et in saecula saeculorum. Amen. 𝄇"
    ]
    
    static let gloriaPatriEnglish = [
        "𝄆 Glory be to the Father, and to the Son, and to the Holy Spirit.",
        "As it was in the beginning, is now, and ever shall be,",
        "world without end. Amen. 𝄇"
    ]
}

struct StandalonePsalmView: View {
    let psalm: PsalmUsage
    let psalmService: PsalmService
    
    var body: some View {
        ScrollView {
            PsalmView(psalm: psalm, psalmService: psalmService)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
        }
        .background(Color(.systemBackground))
    }
}

enum PsalmError: Error {
    case invalidNumberFormat(String)
    case versesNotFound(Int)
}