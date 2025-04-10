import SwiftUI
struct ContentView: View {
    @State private var selectedTab = 0
    @State private var selectedDate = Date()
    @State private var liturgicalInfo: LiturgicalDay?
    @State private var showingPrayerView = false
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var liturgicalUpdateTask: Task<Void, Never>?
    
    private let liturgicalService = LiturgicalService()
    private let hoursService = HoursService.shared
    
    @Environment(\.psalmService) private var psalmService
    @EnvironmentObject private var progressTracker: PsalmObservableTracker
    @State private var selectedHour = "prime"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 16) {
                        DatePicker("Select a date",
                                  selection: $selectedDate,
                                  displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                            .frame(maxHeight: 400)
                            .onChange(of: selectedDate) {
                                
                                triggerLiturgicalUpdate()
                                
                            }
                        
                        CanonicalHourPicker(selectedHour: $selectedHour)
                            .frame(height: 70)
                        
                        //LiturgicalInfoView(info: liturgicalInfo, isLoading: isLoading)
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        Button(action: { showingPrayerView = true }) {
                            Text("Show Prayer for Selected Date")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .disabled(liturgicalInfo == nil || isLoading)
                        
                        Spacer()
                    }
                    .padding()
                }
                .navigationTitle("Liturgical Calendar")
                .navigationDestination(isPresented: $showingPrayerView) {
                    destinationView
                }
                .task {
                                   await updateLiturgicalInfo()
                               }
                .onAppear {
                    
                    #if os(macOS)
                    NSApp.mainWindow?.title = "Liturgical Calendar"
                    #endif
                }
                .animation(.easeInOut, value: liturgicalInfo?.weekday)
                .animation(.easeInOut, value: isLoading)
            }
            .tabItem {
                Label("Liturgical Calendar", systemImage: "calendar")
            }
            .tag(0)
            
            ProgressSummaryView(
                psalmService: psalmService,
                tracker: progressTracker,
                liturgicalDay: liturgicalInfo
            )
            .tabItem {
                Label("Psalms", systemImage: "book")
            }
            .tag(1)
        }
    }
    private func triggerLiturgicalUpdate() {
            liturgicalUpdateTask?.cancel()
            liturgicalUpdateTask = Task {
                // Add small delay to handle rapid date changes
                try? await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds
                guard !Task.isCancelled else { return }
                await updateLiturgicalInfo()
            }
        }

        @MainActor
    private func updateLiturgicalInfo() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false } // Ensure isLoading is always reset
        
        
        liturgicalInfo = liturgicalService.getLiturgicalInfo(for: selectedDate)
        let calendar = Calendar.current
        let weekdayNumber = calendar.component(.weekday, from: selectedDate)
        let weekdays = calendar.weekdaySymbols
        
        if let info = liturgicalInfo {
            print("Actual calendar weekday: \(weekdays[weekdayNumber-1])")
            print("Extracted weekday: \(info.weekday)")
            print("season: \(info.season)")
            
        }
    
    }
   
    
    @ViewBuilder
    private var destinationView: some View {
        if let liturgicalInfo = liturgicalInfo {
            PrayerView(
                date: selectedDate,
                liturgicalInfo: liturgicalInfo,
                hour: hoursService.getHour(for: selectedHour),
                hourName: selectedHour.capitalized,
                weekday: liturgicalInfo.weekday,
                psalmService: psalmService
            )
        } else {
            VStack {
                Text("Liturgical information not available")
                Text("Please select another date")
            }
        }
    }
}
struct LiturgicalInfoView: View {
    let info: LiturgicalDay?
    let isLoading: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else if let info = info {
            VStack {
                Text(info.weekday)
                    .font(.headline)
                if let feast = info.feast {
                    Text(feast.name)
                        .font(.subheadline)
                }
                Text(info.season.description)
                    .font(.subheadline)
            }
            .multilineTextAlignment(.center)
            .padding()
        } else {
            Text("Loading liturgical information...")
                .foregroundColor(.secondary)
        }
    }
}
