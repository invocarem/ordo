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
                        .padding(8)
                        .frame(maxWidth: .infinity)
                } else if let info = info {
                    VStack(alignment: .leading, spacing: 4) { // Reduced spacing
                        // First row: Seasons and weekday
                        HStack(spacing: 8) { // Reduced spacing
                            // Benedictine season
                            benedictineSeasonPill(info.benedictineSeason)
                            
                            Divider()
                                .frame(height: 20) // Shorter divider
                            
                            // Liturgical season
                            seasonPill(info.season)
                            
                            Divider()
                                .frame(height: 20) // Shorter divider
                            
                            // Weekday with Sunday/Vigil indicators
                            weekdayView(info)
                        }
                        .padding(.horizontal, 8) // Reduced padding
                        
                        // Second row: Feast day if available
                        if let feast = info.feast {
                            feastPill(feast)
                                .padding(.top, 2) // Reduced padding
                        }
                    }
                    .padding(.vertical, 8) // Reduced vertical padding
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8) // Smaller corner radius
                            .fill(Color(.secondarySystemBackground))
                    )
                    .padding(.horizontal)
                } else {
                    Text("No liturgical information available")
                        .foregroundColor(.secondary)
                        .padding(8)
                }
            }
        }
    private func weekdayView(_ info: LiturgicalDay) -> some View {
           HStack(spacing: 4) { // Reduced spacing
               Text(info.weekday)
                   .font(.caption)
                   .fontWeight(.medium)
                   .foregroundColor(.primary)
               
               if info.isSunday {
                   Image(systemName: "sun.max.fill")
                       .font(.caption2)
                       .foregroundColor(.yellow)
               }
               
               if info.isVigil {
                   Image(systemName: "moon.stars.fill")
                       .font(.caption2)
                       .foregroundColor(.blue)
               }
           }
           .padding(.horizontal, 6) // Reduced padding
           .padding(.vertical, 3) // Reduced padding
           .background(
               Capsule()
                   .fill(Color.gray.opacity(0.15)))
       }
       
    private func seasonPill(_ season: LiturgicalSeason) -> some View {
           HStack(spacing: 4) { // Reduced spacing
               Image(systemName: season.iconName)
                   .font(.caption2) // Smaller icon
               Text(season.description.uppercased())
                   .font(.caption2) // Smaller text
                   .fontWeight(.medium)
           }
           .padding(.horizontal, 6) // Reduced padding
           .padding(.vertical, 3) // Reduced padding
           .background(
               Capsule()
                   .fill(season.color.opacity(0.15)))
       }
       
   
    
    private func benedictineSeasonPill(_ season: BenedictineSeason) -> some View {
            HStack(spacing: 4) { // Reduced spacing
                Image(systemName: season.iconName)
                    .font(.caption2) // Smaller icon
                Text(season.description.uppercased())
                    .font(.caption2) // Smaller text
                    .fontWeight(.medium)
            }
            .padding(.horizontal, 6) // Reduced padding
            .padding(.vertical, 3) // Reduced padding
            .background(
                Capsule()
                    .fill(season.color.opacity(0.15))
            )
        }
    private func feastPill(_ feast: Feast) -> some View {
            let style = feastStyle(for: feast.type)
            
            return HStack(spacing: 4) { // Reduced spacing
                Image(systemName: style.icon)
                    .font(.caption2) // Smaller icon
                
                Text(feast.name)
                    .font(.caption) // Smaller text
                    .fontWeight(.medium)
                    .lineLimit(1) // Single line to save space
                
                if feast.rank == "Solemnity" || feast.rank == "Major" {
                    Image(systemName: "star.fill")
                        .font(.caption2) // Smaller icon
                }
            }
            .padding(.horizontal, 8) // Reduced padding
            .padding(.vertical, 4) // Reduced padding
            .background(
                Capsule()
                    .fill(style.color.opacity(0.15)))
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

extension LiturgicalText {
    func getAppropriateText(for liturgicalInfo: LiturgicalDay) -> [String] {
        switch self {
        case .simple(let lines):
            return lines
            
        case .structured(let data):
            if let feastName = liturgicalInfo.feast?.name.lowercased() {
                print ("feastname \(feastName)")
                if let feastText = data.feasts?[feastName] {
                    
                    return feastText
                }
            }
            
            
            let seasonKey: String
            switch liturgicalInfo.season {
                case .advent: seasonKey = "advent"
                case .lent: seasonKey = "lent"
                case .pascha: seasonKey = "pascha"
                case .christmas: seasonKey = "christmas"
                case .ordinaryTime: seasonKey = "ordinary"
            }
                
            if let seasonText = data.seasons?[seasonKey] {
                return seasonText
            }
            
            // Fall back to default
            return data.default
        }
    }
}
