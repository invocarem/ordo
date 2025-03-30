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
    
    @State private var psalmContent: [String] = []
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(psalmHeader)
                .font(.headline)
            
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
        }
    }
    
    private var psalmHeader: String {
        var headerParts = [String]()
        headerParts.append("Psalm \(psalm.number)")
        
        if let category = psalm.category, !category.isEmpty {
            headerParts.append("(\(category))")
        }
        
        if let startVerse = psalm.startVerse, startVerse != 1 {
            headerParts.append("starting at verse \(startVerse)")
        }
        
        if let verses = psalm.verses {
            headerParts.append("specific verses: \(verses)")
        }
        
        return headerParts.joined(separator: " ")
    }
    
    private func loadPsalmContent() {
        print("Loading psalm \(psalm.number) for category: \(psalm.category ?? "none")")
          
        do {
            guard let psalmNumber = Int(psalm.number) else {
                throw PsalmError.invalidNumberFormat(psalm.number)
            }
            
            let psalmSections = try psalmService.getPsalms(number: psalmNumber)
            
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
}

enum PsalmError: Error {
    case invalidNumberFormat(String)
    case versesNotFound(Int)
}
