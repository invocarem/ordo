//
//  PrayerView.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-24.
//
import SwiftUI

struct PrayerView: View {
    let date: Date
    let liturgicalInfo: String
    let psalms: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(liturgicalInfo)
                    .font(.title2)
                    .padding(.bottom)
                
                Text("Psalms for Prime Hour")
                    .font(.headline)
                
                ForEach(psalms, id: \.self) { psalm in
                    VStack(alignment: .leading) {
                        Text("Psalm \(psalm)")
                            .font(.headline)
                        Text(getPsalmText(number: psalm))
                            .font(.body)
                            .padding(.vertical, 4)
                    }
                    .padding()
                    #if os(iOS)
                    .background(Color(.systemGray6))
                    #endif
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Daily Prayer")
    }
    
    private func getPsalmText(number: String) -> String {
        // In a real app, you would have complete psalm texts here
        // This is just a placeholder implementation
        return "This is a placeholder for Psalm \(number). In a complete app, this would contain the full text of the psalm in your preferred translation."
    }
}
