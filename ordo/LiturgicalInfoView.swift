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
                        feastPill(feast)
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
                .font(.caption) // Smaller font size
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            if info.isSunday {
                Image(systemName: "sun.max.fill")
                    .font(.caption2) // Even smaller for icons
                    .foregroundColor(.yellow)
            }
            
            if info.isVigil {
                Image(systemName: "moon.stars.fill")
                    .font(.caption2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color.gray.opacity(0.15)) // Subtle background
        )
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
    private func feastPill(_ feast: Feast) -> some View {
        // Determine styling based on feast type
        let style = feastStyle(for: feast.type)
        
        return HStack(spacing: 5) {
            Image(systemName: style.icon)
                .font(.caption)
                .foregroundColor(style.color)
            
            Text(feast.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(style.color)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
            
            if feast.rank == "Solemnity" || feast.rank == "Major" {
                Image(systemName: "star.fill")
                    .font(.caption)
                    .foregroundColor(.yellow)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(style.color.opacity(0.15))
        )
    }

    // Helper to centralize feast styling
    private func feastStyle(for type: String) -> (icon: String, color: Color) {
        switch type.lowercased() {
        // Saint types
        case "martyr", "martyrs":
            return ("flame.fill", .red)
        case "virgin", "virgin-martyr":
            return ("lily", .white)
        case "apostle", "apostle-martyr":
            return ("cross.fill", .yellow)
        case "bishop":
            return ("mitre.fill", .purple)
        case "doctor":
            return ("book.fill", .blue)
        case "confessor":
            return ("person.fill", .green)
            
        // Temporal feasts
        case "pentecost":
            return ("wind", .red)
        case "epiphany":
            return ("star.fill", .yellow)
        case "pascha", "easter", "resurrection":
            return ("sun.max.fill", .yellow)
        case "nativity", "christmas":
            return ("sparkles", .red)
            
        // Default case
        default:
            print("Unrecognized feast type: \(type)")
            return ("star.fill", .gray)
        }
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

