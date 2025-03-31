//
//  ContentView.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    @State private var selectedDate = Date()
    @State private var liturgicalInfo = ""
    @State private var showingPrayerView = false
    
    
    private let liturgicalService = LiturgicalService()
    private let hoursService = HoursService.shared
    
    @Environment(\.psalmService) private var psalmService
    @EnvironmentObject private var progressTracker: PsalmProgressTracker
    @State private var selectedHour = "prime"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack(spacing: 16) {
                    DatePicker("Select a date",
                               selection: $selectedDate,
                               displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: selectedDate) {
                        updateLiturgicalInfo()
                    }
                    
                    CanonicalHourPicker(selectedHour: $selectedHour)
                        .frame(height: 70)
                    
                    
                    
                    Text(liturgicalInfo)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        showingPrayerView = true
                    }) {
                        Text("Show Prayer for Selected Date")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
#if os(iOS)
                .navigationBarTitle("Liturgical Calendar")
#endif
                .background(
                    
                    NavigationLink(
                        destination: PrayerView(
                            date: selectedDate,
                            liturgicalInfo: liturgicalInfo,
                            hour: hoursService.getHour(for: selectedHour),
                            hourName: selectedHour.capitalized,
                            weekday: extractWeekday(from: liturgicalInfo) ?? "Unknown",
                            psalmService: psalmService
                        ),
                        isActive: $showingPrayerView,
                        label: { EmptyView() }
                    )
                )
                .onAppear {
                    updateLiturgicalInfo()
#if os(macOS)
                    NSApp.mainWindow?.title = "Liturgical Calendar"
#endif
                }
            }
            .tabItem {
                Label("Liturgical Calendar", systemImage: "calendar")
            }
            .tag(0)
            
            // New Psalm Tracker
            ProgressSummaryView(
                psalmService: psalmService,
                tracker: progressTracker)
                .tabItem {
                    Label("Psalms", systemImage: "book")
                }
                .tag(1)
        }
    }
    
    private func updateLiturgicalInfo() {
        liturgicalInfo = liturgicalService.getLiturgicalInfo(for: selectedDate)
        let calendar = Calendar.current
           let weekdayNumber = calendar.component(.weekday, from: selectedDate) // 1-7 (Sun-Sat)
           let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
           print("Actual calendar weekday: \(weekdays[weekdayNumber-1])")
           print("Extracted weekday: \(extractWeekday(from: liturgicalInfo) ?? "nil")")
    }
    func extractWeekday(from liturgicalInfo: String) -> String? {
        let components = liturgicalInfo.components(separatedBy: .whitespaces)
        
        // Check for format like "29 Mar 2025 is Saturday after the 3rd Sunday of Lent"
        if let isIndex = components.firstIndex(of: "is"),
           isIndex + 1 < components.count,
           let afterIndex = components.firstIndex(of: "after"),
           afterIndex > isIndex + 1
        {
            return components[isIndex + 1].capitalized
        }
        // Check for format like "30 Mar 2025 is the 4th Sunday of Lent"
        else if let isIndex = components.firstIndex(of: "is"),
                isIndex + 1 < components.count,
                components[isIndex + 1] == "the"
        {
            // Check if the description contains "Sunday"
            let description = Array(components[isIndex + 2..<components.count]).joined(separator: " ")
            if description.lowercased().contains("sunday") {
                return "Sunday"
            } else {
                return description
            }
        }
        
        return nil
    }
        
        
    
    }




#Preview {
    ContentView()
}
