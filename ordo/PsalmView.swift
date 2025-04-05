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
    @State private var errorMessage: String?
    @State private var isCompleted: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(psalmHeader)
                    .font(.headline)
                Spacer()
                // Completion toggle button
                Button(action: toggleCompletion) {
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isCompleted ? .green : .gray)
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ForEach(psalmContent, id: \.self) { verse in
                    Text(verse)
                        .padding(.vertical, 2)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) 
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
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
            
            if psalmSections.count == 1 {
                psalmContent = psalmSections.first?.text ?? []
            } else {
                guard let section = psalm.category,
                      let psalmSection = psalmSections.first(where: { $0.section?.lowercased() == section.lowercased() })
                else {
                    throw PsalmError.versesNotFound(psalmNumber)
                }
                psalmContent = psalmSection.text
            }
        } catch PsalmError.invalidNumberFormat(let number) {
            errorMessage = "Invalid psalm number format: '\(number)'"
        } catch PsalmError.versesNotFound(let number) {
            errorMessage = "No verses found for Psalm \(number)"
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }
    }
    private func toggleCompletion() {
            isCompleted.toggle()
            observableTracker.markPsalm( // Now using wrapper's method
                number: Int(psalm.number) ?? 0,
                section: psalm.category,
                completed: isCompleted
            )
        }
        
        private func loadCompletionState() {
            if let progress = observableTracker.getProgress( // Now using wrapper
                number: Int(psalm.number) ?? 0,
                section: psalm.category
            ) {
                isCompleted = progress.isCompleted
            }
        }
}

enum PsalmError: Error {
    case invalidNumberFormat(String)
    case versesNotFound(Int)
}
