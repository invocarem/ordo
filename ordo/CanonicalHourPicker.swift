//
//  CanonicalHourPicker.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-29.
//
import SwiftUI
struct CanonicalHourPicker: View {
    @Binding var selectedHour: String
    private let hours = ["matins", "lauds", "prime", "terce", "sext", "none", "vespers", "compline"]
    
    private var hourBinding: Binding<Double> {
        Binding(
            get: { Double(hours.firstIndex(of: selectedHour) ?? 0) },
            set: { newValue in
                let index = Int(round(newValue)).clamped(to: 0...hours.count-1)
                selectedHour = hours[index]
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Current hour display
            Text(selectedHour.capitalized)
                .font(.headline)
                .padding(.bottom, 4)
            
            // Custom slider
            Slider(
                value: hourBinding,
                in: 0...Double(hours.count - 1),
                step: 1
            )
            .padding(.horizontal)
            
            // Hour labels
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(hours.enumerated()), id: \.offset) { index, hour in
                        VStack(spacing: 2) {
                            Text(hour.prefix(2).uppercased())
                                .font(.caption2)
                                .fontWeight(.medium)
                            Circle()
                                .fill(selectedHour == hour ? Color.blue : Color.clear)
                                .frame(width: 4, height: 4)
                        }
                        .frame(width: 24)
                        .foregroundColor(selectedHour == hour ? .blue : .gray)
                        .onTapGesture {
                            selectedHour = hour
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 30)
        }
    }
    
    init(selectedHour: Binding<String>) {
        self._selectedHour = selectedHour
        
        // Validate and set default if needed
        if !hours.contains(selectedHour.wrappedValue.lowercased()) {
            selectedHour.wrappedValue = "prime"
        } else {
            // Ensure case matches our internal representation
            selectedHour.wrappedValue = selectedHour.wrappedValue.lowercased()
        }
    }
}

// Helper extension for clamping values
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

