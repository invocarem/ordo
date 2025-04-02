//
//  PsalterService.swift
//  ordo
//
//  Created by [Your Name] on [Current Date].
//

import Foundation

public class PsalterService {
    private let officeData: OfficeData
    private let calendar: Calendar
    
    public init(officeData: OfficeData, calendar: Calendar = .current) {
        self.officeData = officeData
        self.calendar = calendar
    }
    
    public enum Hour: String, CaseIterable {
        case matins, lauds, prime, terce, sext, none, vespers, compline
    }
    
    public enum DayType {
        case sunday, weekday, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    public enum SeasonType {
        case winter, summer
    }


    private func getPsalmsForHourRule(_ hourRule: OfficeData.Psalter.Hours.HourRule, dayType: DayType) -> [String] {
        switch dayType {
        case .sunday: return hourRule.sunday ?? hourRule.weekday ?? hourRule.default ?? []
        case .monday: return hourRule.monday ?? hourRule.weekday ?? hourRule.default ?? []
        case .tuesday: return hourRule.tuesday ?? hourRule.weekday ?? hourRule.default ?? []
        case .wednesday: return hourRule.wednesday ?? hourRule.weekday ?? hourRule.default ?? []
        case .thursday: return hourRule.thursday ?? hourRule.weekday ?? hourRule.default ?? []
        case .friday: return hourRule.friday ?? hourRule.weekday ?? hourRule.default ?? []
        case .saturday: return hourRule.saturday ?? hourRule.weekday ?? hourRule.default ?? []
        default: return hourRule.weekday ?? hourRule.default ?? []
        }
    }
    
    // MARK: - Public Interface
    
    public func getPsalms(for hour: Hour, 
                         on date: Date, 
                         dayType: DayType? = nil) -> [String] {
        let season = getSeasonType(for: date)
        let resolvedDayType = dayType ?? getDayType(for: date)
        
        switch hour {
        case .matins:
            return getMatinsPsalms(season: season, dayType: resolvedDayType)
        case .lauds:
            return getLaudsPsalms(season: season, dayType: resolvedDayType)
        case .prime:
             return getPsalmsForHourRule(officeData.psalter.hours.prime, dayType: resolvedDayType)
        case .terce:
            return getPsalmsForHourRule(officeData.psalter.hours.terce, dayType: resolvedDayType)
        case .sext:
            return getPsalmsForHourRule(officeData.psalter.hours.sext, dayType: resolvedDayType)
        case .none:
            return getPsalmsForHourRule(officeData.psalter.hours.none, dayType: resolvedDayType)
        case .vespers:
            return getPsalmsForHourRule(officeData.psalter.hours.vespers, dayType: resolvedDayType)
        case .compline:
            return getPsalmsForHourRule(officeData.psalter.hours.compline, dayType: resolvedDayType)
        }
    }
    
    public func getHourNotes(for hour: Hour) -> String? {
        switch hour {
        case .lauds:
            return officeData.psalter.hours.lauds.notes?.canticles
        case .terce:
            return officeData.psalter.hours.terce.notes
        case .vespers:
            return officeData.psalter.hours.vespers.notes
        default:
            return nil
        }
    }
    
    // MARK: - Private Helpers
    
    private func getSeasonType(for date: Date) -> SeasonType {
        // We'll need to get this from LiturgicalService or implement our own simple logic
        // For now, using a simplified version
        let month = calendar.component(.month, from: date)
        return (month >= 11 || month <= 3) ? .winter : .summer
    }
    
    private func getDayType(for date: Date) -> DayType {
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case 1: return .sunday
        case 2: return .monday
        case 3: return .tuesday
        case 4: return .wednesday
        case 5: return .thursday
        case 6: return .friday
        case 7: return .saturday
        default: return .weekday
        }
    }
    
    // MARK: - Hour-specific psalm getters
    
    private func getMatinsPsalms(season: SeasonType, dayType: DayType) -> [String] {
        switch season {
        case .winter:
            switch dayType {
            case .sunday: return officeData.psalter.hours.matins.winter.sunday
            default: return officeData.psalter.hours.matins.winter.weekday
            }
        case .summer:
            switch dayType {
            case .sunday: return officeData.psalter.hours.matins.summer.sunday
            default: return officeData.psalter.hours.matins.summer.weekday
            }
        }
    }
    
    private func getLaudsPsalms(season: SeasonType, dayType: DayType) -> [String] {
        switch dayType {
        case .sunday:
            return officeData.psalter.hours.lauds.sunday
        default:
            switch season {
            case .winter: return officeData.psalter.hours.lauds.weekday.winter
            case .summer: return officeData.psalter.hours.lauds.weekday.summer
            }
        }
    }
    
   
    
  
    
  
}