//
//  CanonicalHourPicker.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-29.
//
import SwiftUI

struct CanonicalHourPicker: View {
    @Binding var selectedHour: String
    
    private let hours = [
        ("matins", "moon.fill"),
        ("lauds", "sunrise.fill"),
        ("prime", "sun.max.fill"),
        ("terce", "sun.haze.fill"),
        ("sext", "sun.dust.fill"),
        ("none", "sun.min.fill"),
        ("vespers", "sunset.fill"),
        ("compline", "moon.stars.fill")
    ]
    
    @State private var sliderValue: Double
    @State private var lastSelectedIndex: Int
    
    init(selectedHour: Binding<String>) {
        self._selectedHour = selectedHour
        let initialIndex = hours.firstIndex(where: { $0.0 == selectedHour.wrappedValue }) ?? 0
        self._sliderValue = State(initialValue: Double(initialIndex))
        self._lastSelectedIndex = State(initialValue: initialIndex)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            // Current hour display with icon
            currentHourDisplay
            
            // Interactive slider
            hourSlider
            
            // Hour indicators
            hourIndicators
        }
        .padding(.vertical, 12)
        //.background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
    
    private var currentHourDisplay: some View {
        HStack(spacing: 8) {
            if let hour = hours.first(where: { $0.0 == selectedHour }) {
                Image(systemName: hour.1)
                    .foregroundColor(.blue)
            }
            Text(selectedHour.capitalized)
                .font(.headline)
        }
        .padding(.bottom, 4)
        .transition(.opacity)
        .id("hourTitle-\(selectedHour)")
    }
    
    private var hourSlider: some View {
        Slider(
            value: $sliderValue,
            in: 0...Double(hours.count - 1),
            step: 1
        )
        .padding(.horizontal)
        .tint(.blue)
        .valueChanged(of: sliderValue) { oldValue, newValue in
            updateSelectedHour(from: newValue)
        }
    }
    
    private var hourIndicators: some View {
        HStack(spacing: 0) {
            ForEach(Array(hours.enumerated()), id: \.offset) { index, hour in
                hourIndicator(hour: hour, index: index)
                    .frame(maxWidth: .infinity)
            }
        }
        .frame(height: 30)
        .padding(.horizontal, 8)
    }
    
    private func hourIndicator(hour: (String, String), index: Int) -> some View {
        Button(action: {
            selectHour(index: index)
        }) {
            VStack(spacing: 4) {
                Text(hour.0.prefix(2).uppercased())
                    .font(.system(size: 10, weight: .medium))
                Circle()
                    .fill(selectedHour == hour.0 ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedHour == hour.0 ? .blue : .gray)
        }
        .buttonStyle(.plain)
    }
    
    private func updateSelectedHour(from sliderValue: Double) {
        let newIndex = Int(round(sliderValue)).clamped(to: 0...hours.count-1)
        
        if newIndex != lastSelectedIndex {
            lastSelectedIndex = newIndex
            let newHour = hours[newIndex].0
            
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedHour = newHour
                }
            }
        }
    }
    
    private func selectHour(index: Int) {
        sliderValue = Double(index)
        let newHour = hours[index].0
        
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.2)) {
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

extension View {
    func valueChanged<T: Equatable>(of value: T, initial: Bool = false, action: @escaping (T?, T) -> Void) -> some View {
        modifier(ValueChangeModifier(value: value, initial: initial, action: action))
    }
}

struct ValueChangeModifier<T: Equatable>: ViewModifier {
    let value: T
    let initial: Bool
    let action: (T?, T) -> Void
    
    @State private var oldValue: T?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if initial {
                    action(nil, value)
                }
                oldValue = value
            }
            .onChange(of: value) { newValue in
                action(oldValue, newValue)
                oldValue = newValue
            }
    }
}
