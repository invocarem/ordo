//
//  PsalmSectionView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-06.
//
import SwiftUI

struct PrayerSectionView: View {
    let title: String
    let content: [String]
    let contentB: [String]?
    var showToggle: Bool
    var isCompleted: Binding<Bool>?
    var onToggle: ((Bool) -> Void)?
    
    @State private var expandedLines: Set<Int> = []
    
    init(title: String,
         content: [String],
         contentB: [String]? = nil,
         showToggle: Bool = false,
         isCompleted: Binding<Bool>? = nil,
         onToggle: ((Bool) -> Void)? = nil) {
        self.title = title
        self.content = content
        self.contentB = contentB
        self.showToggle = showToggle
        self.isCompleted = isCompleted
        self.onToggle = onToggle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with title and toggle
            headerView
            
            // Main content with tap-to-reveal functionality
            if let contentB = contentB {
                bilingualContentView(contentB: contentB)
            } else {
                simpleContentView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            Text(title)
                .font(.headline)
            
            if showToggle, let binding = isCompleted {
                Spacer()
                Toggle("", isOn: binding)
                    .toggleStyle(CircleToggleStyle())
                    .labelsHidden()
                    .onChange(of: binding.wrappedValue) { oldValue, newValue in
                        onToggle?(newValue)
                    }
            }
        }
        .padding(.bottom, 2)
    }
    
    private var simpleContentView: some View {
        VStack(alignment: .leading) {
            ForEach(content, id: \.self) { line in
                Text(line)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private func bilingualContentView(contentB: [String]) -> some View {
        VStack(alignment: .leading) {
            ForEach(0..<content.count, id: \.self) { index in
                VStack(alignment: .leading) {
                    // Latin text (always shown)
                    Text(content[index])
                    
                        //.fontWeight(.medium) // Latin slightly bolder
                        .foregroundColor(.primary)
                        .onTapGesture {
                            withAnimation {
                                toggleLineExpansion(index)
                            }
                        }
                        .padding(.vertical, 2)
                    
                    // English translation (shown when expanded)
                    if expandedLines.contains(index) {
                        Text(contentB[index])
                          //  .fontWeight(.regular)
                            .foregroundColor(.secondary)
                            .padding(.top, 2)
                            .transition(.opacity)
                            .padding(.vertical, 2)
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func toggleLineExpansion(_ index: Int) {
        if expandedLines.contains(index) {
            expandedLines.remove(index)
        } else {
            expandedLines.insert(index)
        }
    }
}

// Your existing CircleToggleStyle remains the same
struct CircleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .blue : .gray)
        }
        .buttonStyle(.plain)
    }
}



extension View {
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print("DEBUG:", value)
        #endif
        return self
    }
}
