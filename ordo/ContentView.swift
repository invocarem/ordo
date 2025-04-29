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
    @State private var selectedHour = getCurrentHour()
    
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
            
            NavigationStack {
                PsalmAnalysisSelectionView(latinService: LatinService.shared, psalmService: psalmService, liturgicalDay: liturgicalInfo, hourKey: selectedHour)
                   }
                   .tabItem {
                       Label("Analysis", systemImage: "text.magnifyingglass")
                   }
                   .tag(2)
        }
    }
    
    private var calendarTab: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    LiturgicalInfoView(info: liturgicalInfo, isLoading: isLoading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    DatePicker("Select a date",
                              selection: $selectedDate,
                              displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                        .frame(maxHeight: 400)
                        .onChange(of: selectedDate) {
                            triggerLiturgicalUpdate()
                        }
                    //Spacer()
                    
                    CanonicalHourPicker(selectedHour: $selectedHour)
                        .frame(height: 70)
                    
                    Spacer()
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
            Label("Sine intermissione orate", systemImage: "hands.sparkles.fill")
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.headline) // More prominent text
        }
        .padding(.horizontal)
        .shadow(radius: 3) // Subtle elevation
    }
    private var xprayerButton: some View {
        Button(action: { showingPrayerView = true }) {
            Text("Sine intermissione orate")
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
    private static func getCurrentHour() -> String {
           let calendar = Calendar.current
           let now = Date()
           let components = calendar.dateComponents([.hour, .minute], from: now)
           let totalMinutes = (components.hour ?? 0) * 60 + (components.minute ?? 0)
           
           switch totalMinutes {
           case 150..<300:     // 2:30 AM–5:00 AM: Matins
               return "matins"
           case 300..<420:     // 5:00 AM–7:00 AM: Lauds
               return "lauds"
           case 420..<540:     // 7:00 AM–9:00 AM: Prime
               return "prime"
           case 540..<720:     // 9:00 AM–12:00 PM: Terce
               return "terce"
           case 720..<900:     // 12:00 PM–3:00 PM: Sext
               return "sext"
           case 900..<1140:    // 3:00 PM–7:00 PM: None
               return "none"
           case 1140..<1260:   // 7:00 PM–9:00 PM: Vespers
               return "vespers"
           default:            // 9:00 PM–2:30 AM: Compline
               return "compline"
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


