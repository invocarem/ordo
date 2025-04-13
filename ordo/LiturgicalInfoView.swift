//
//  LiturgicalInfoView.swift
//  ordo
//
//  Created by Chen Chen on 2025-04-13.
//
import SwiftUI

struct LiturgicalInfoView: View {
    let info: LiturgicalDay?
    let isLoading: Bool
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .padding()
                    .frame(maxWidth: .infinity)
            } else if let info = info {
                VStack(alignment: .leading, spacing: 8) {
                    // First row: Seasons and weekday
                    HStack(spacing: 12) {
                        // Benedictine season
                        benedictineSeasonPill(info.benedictineSeason)
                        
                        Divider()
                            .frame(height: 30)
                        
                        // Liturgical season
                        seasonPill(info.season)
                        
                        Divider()
                            .frame(height: 30)
                        
                        // Weekday with Sunday/Vigil indicators
                        weekdayView(info)
                    }
                    
                    // Second row: Feast day if available
                    if let feast = info.feast {
                        HStack {
                            Text(feast.name)
                                .font(.subheadline)
                                .lineLimit(2)
                                .minimumScaleFactor(0.7)
                            Spacer()
                        }
                        .padding(.top, 4)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                )
                .padding(.horizontal)
            } else {
                Text("No liturgical information available")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func weekdayView(_ info: LiturgicalDay) -> some View {
        HStack(spacing: 6) {
            Text(info.weekday)
                .font(.headline)
                .fontWeight(.regular)
            
            if info.isSunday {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(.yellow)
                    .font(.caption)
            }
            
            if info.isVigil {
                Image(systemName: "moon.stars.fill")
                    .foregroundColor(.blue)
                    .font(.caption)
            }
        }
    }
    
    private func seasonPill(_ season: LiturgicalSeason) -> some View {
        HStack(spacing: 5) {
            Image(systemName: season.iconName)
                .font(.caption)
                .foregroundColor(season.color)
            Text(season.description.uppercased())
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(season.color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(season.color.opacity(0.15))
        )
    }
    
    private func benedictineSeasonPill(_ season: BenedictineSeason) -> some View {
        HStack(spacing: 5) {
            Image(systemName: season.iconName)
                .font(.caption)
                .foregroundColor(season.color)
            Text(season.description.uppercased())
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(season.color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(season.color.opacity(0.15))
        )
    }
}
                    
extension LiturgicalSeason {
    var color: Color {
        switch self {
        case .advent: return .blue
        case .christmas: return .white
        case .lent: return .purple
        case .pascha: return .yellow
        default: return .green
        }
    }
    
    var iconName: String {
        switch self {
        case .advent: return "star.fill"
        case .christmas: return "sparkles"
        case .lent: return "cross.fill"
        case .pascha: return "sun.max.fill"
        default: return "leaf.fill"
        }
    }
}

extension BenedictineSeason {
    var color: Color {
        switch self {
        case .summer: return .orange
        case .winter: return .blue
        }
    }
    
    var iconName: String {
        switch self {
        case .summer: return "sun.max.fill"
        case .winter: return "snowflake"
        }
    }
}
