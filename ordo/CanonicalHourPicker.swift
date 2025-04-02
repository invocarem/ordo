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
    
    @State private var sliderValue: Double
    @State private var lastSelectedIndex: Int
    
    init(selectedHour: Binding<String>) {
        self._selectedHour = selectedHour
        let initialIndex = hours.firstIndex(of: selectedHour.wrappedValue) ?? 0
        self._sliderValue = State(initialValue: Double(initialIndex))
        self._lastSelectedIndex = State(initialValue: initialIndex)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Current hour display
            Text(selectedHour.capitalized)
                .font(.headline)
                .padding(.bottom, 4)
                .transition(.opacity)
                .id("hourTitle-\(selectedHour)")
            
            // Interactive slider
            Slider(
                value: $sliderValue,
                in: 0...Double(hours.count - 1),
                step: 1
            )
            .padding(.horizontal)
            .onChange(of: sliderValue) { newValue in
                updateSelectedHour(from: newValue)
            }
            
            // Equally distributed hour indicators
            hourIndicators
        }
        .padding(.vertical, 8)
    }
    
    private var hourIndicators: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(Array(hours.enumerated()), id: \.offset) { index, hour in
                    hourIndicator(hour: hour, index: index)
                        .frame(width: geometry.size.width / CGFloat(hours.count))
                }
            }
        }
        .frame(height: 30)
    }
    
    private func hourIndicator(hour: String, index: Int) -> some View {
        Button(action: {
            selectHour(index: index)
        }) {
            VStack(spacing: 2) {
                Text(hour.prefix(2).uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                Circle()
                    .fill(selectedHour == hour ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 4, height: 4)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedHour == hour ? .blue : .gray)
        }
        .buttonStyle(.plain)
    }
    
    private func updateSelectedHour(from sliderValue: Double) {
        let newIndex = Int(round(sliderValue)).clamped(to: 0...hours.count-1)
        
        if newIndex != lastSelectedIndex {
            lastSelectedIndex = newIndex
            let newHour = hours[newIndex]
            
            DispatchQueue.main.async {
                withAnimation {
                    selectedHour = newHour
                }
            }
        }
    }
    
    private func selectHour(index: Int) {
        sliderValue = Double(index)
        let newHour = hours[index]
        
        DispatchQueue.main.async {
            withAnimation {
                selectedHour = newHour
            }
        }
    }
}

// Helper extension for clamping values
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

