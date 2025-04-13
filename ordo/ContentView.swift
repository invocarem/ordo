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
            calendarTab
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
    
    private var calendarTab: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    LiturgicalInfoView(info: liturgicalInfo, isLoading: isLoading)
                    
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
                    
                    if let errorMessage = errorMessage {
                        ErrorMessageView(message: errorMessage)
                    }
                    
                    prayerButton
                    
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
    }
    
    private var prayerButton: some View {
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
    }
    
    private func triggerLiturgicalUpdate() {
        liturgicalUpdateTask?.cancel()
        liturgicalUpdateTask = Task {
            try? await Task.sleep(nanoseconds: 200_000_000)
            guard !Task.isCancelled else { return }
            await updateLiturgicalInfo()
        }
    }
    
    @MainActor
    private func updateLiturgicalInfo() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        liturgicalInfo = liturgicalService.getLiturgicalInfo(for: selectedDate)
        
        if let info = liturgicalInfo {
            debugPrintLiturgicalInfo(info)
        }
    }
    
    private func debugPrintLiturgicalInfo(_ info: LiturgicalDay) {
        let calendar = Calendar.current
        let weekdayNumber = calendar.component(.weekday, from: selectedDate)
        let weekdays = calendar.weekdaySymbols
        
        print("Actual calendar weekday: \(weekdays[weekdayNumber-1])")
        print("Extracted weekday: \(info.weekday)")
        print("Season: \(info.season)")
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
            Text("Liturgical information not available\nPlease select another date")
                .multilineTextAlignment(.center)
        }
    }
}

struct ErrorMessageView: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle")
            Text(message)
        }
        .foregroundColor(.red)
        .font(.subheadline)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}


