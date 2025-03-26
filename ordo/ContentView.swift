//
//  ContentView.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var liturgicalInfo = ""
    @State private var showingPrayerView = false
    private let liturgicalService = LiturgicalService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Liturgical Day Calculator")
                    .font(.title)
                    .padding()
                
                DatePicker("Select a date",
                          selection: $selectedDate,
                          displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: selectedDate) { _ in
                        updateLiturgicalInfo()
                    }
                
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
                        psalms: liturgicalService.getPsalmsForPrime(for: selectedDate)
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
    }
    
    private func updateLiturgicalInfo() {
        liturgicalInfo = liturgicalService.getLiturgicalInfo(for: selectedDate)
    }
}

struct ContentViewOld: View {
    @State private var selectedDate = Date()
    @State private var liturgicalInfo = ""
    private let liturgicalService = LiturgicalService()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Liturgical Day Calculator")
                .font(.title)
                .padding()
            
            DatePicker("Select a date",
                      selection: $selectedDate,
                      displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
                .onChange(of: selectedDate) { _ in
                    updateLiturgicalInfo()
                }
            
            Text(liturgicalInfo)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .onAppear {
            updateLiturgicalInfo()
        }
    }
    
    private func updateLiturgicalInfo() {
        liturgicalInfo = liturgicalService.getLiturgicalInfo(for: selectedDate)
    }
}



#Preview {
    ContentView()
}
