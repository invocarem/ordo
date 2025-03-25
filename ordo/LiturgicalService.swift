//
//  LiturgicalService.swift
//  ordo
//
//  Created by Chen Chen on 2025-03-24.
//

import Foundation

class LiturgicalService {
    private let calendar: Calendar
    
    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
    
    // MARK: - Public Interface
    
    func getLiturgicalInfo(for date: Date) -> String {
        let dateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        
        if isEaster(date) {
            return "\(dateString) is Easter Sunday"
        }
        
        if isChristmas(date) {
            return "\(dateString) is Christmas Day"
        }
        
        let (season, week) = getLiturgicalSeasonAndWeek(for: date)
        let weekdayName = calendar.weekdaySymbols[calendar.component(.weekday, from: date) - 1]
        
        switch season {
        case "Ash Wednesday":
            return "\(dateString) is Ash Wednesday"
            
        case "Lent":
            return getLentInfo(date: date, dateString: dateString, week: week, weekdayName: weekdayName)
            
        case "Advent":
            return getAdventInfo(date: date, dateString: dateString, week: week, weekdayName: weekdayName)
            
        case "Easter":
            return getEasterInfo(date: date, dateString: dateString, week: week, weekdayName: weekdayName)
            
        case "Christmas":
            return "\(dateString) is \(weekdayName) in the Christmas Season"
            
        default: // Ordinary Time
            return getOrdinaryTimeInfo(date: date, dateString: dateString, week: week, weekdayName: weekdayName)
        }
    }
    
    // MARK: - Season Calculations
    
    private func getLiturgicalSeasonAndWeek(for date: Date) -> (String, Int) {
        let year = calendar.component(.year, from: date)
        
        guard let adventStart = getAdventStart(year: year),
              let christmas = getChristmas(year: year),
              let ordinaryTimeAfterChristmas = calendar.date(byAdding: .day, value: 7, to: christmas),
              let ashWednesday = getAshWednesday(year: year),
              let easter = getEaster(year: year),
              let pentecost = calendar.date(byAdding: .day, value: 49, to: easter),
              let ordinaryTimeAfterPentecost = calendar.date(byAdding: .day, value: 1, to: pentecost) else {
            return ("Ordinary Time", 1)
        }
        
        if date >= adventStart && date < christmas {
            let components = calendar.dateComponents([.weekOfYear], from: adventStart, to: date)
            let week = (components.weekOfYear ?? 0) + 1
            return ("Advent", min(week, 4))
        }
        else if date >= christmas && date < ordinaryTimeAfterChristmas {
            return ("Christmas", 1)
        }
        else if date >= ordinaryTimeAfterChristmas && date < ashWednesday {
            let components = calendar.dateComponents([.weekOfYear], from: ordinaryTimeAfterChristmas, to: date)
            let week = (components.weekOfYear ?? 0) + 1
            return ("Ordinary Time", week)
        }
        else if date >= ashWednesday && date < easter {
            return calculateLentPeriod(date: date, ashWednesday: ashWednesday)
        }
        else if date >= easter && date < pentecost {
            let components = calendar.dateComponents([.weekOfYear], from: easter, to: date)
            let week = (components.weekOfYear ?? 0) + 1
            return ("Easter", min(week, 7))
        }
        else {
            let components = calendar.dateComponents([.weekOfYear], from: ordinaryTimeAfterPentecost, to: date)
            let week = (components.weekOfYear ?? 0) + 1
            return ("Ordinary Time", week)
        }
    }
    
    // MARK: - Season-specific Helpers
    
    private func calculateLentPeriod(date: Date, ashWednesday: Date) -> (String, Int) {
        if calendar.isDate(date, inSameDayAs: ashWednesday) {
            return ("Ash Wednesday", 0)
        }
        
        var currentDate = ashWednesday
        var sundayCount = 0
        
        while currentDate < date {
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            if calendar.component(.weekday, from: currentDate) == 1 {
                sundayCount += 1
            }
        }
        
        return sundayCount == 0 ? ("Lent", 0) : ("Lent", sundayCount)
    }
    
    private func getLentInfo(date: Date, dateString: String, week: Int, weekdayName: String) -> String {
        if week == 0 {
            return "\(dateString) is \(weekdayName) after Ash Wednesday"
        } else if calendar.component(.weekday, from: date) == 1 {
            return "\(dateString) is the \(week.ordinalString()) Sunday of Lent"
        } else {
            return "\(dateString) is \(weekdayName) after the \(week.ordinalString()) Sunday of Lent"
        }
    }
    
    private func getAdventInfo(date: Date, dateString: String, week: Int, weekdayName: String) -> String {
        if calendar.component(.weekday, from: date) == 1 {
            return "\(dateString) is the \(week.ordinalString()) Sunday of Advent"
        } else {
            return "\(dateString) is \(weekdayName) after the \(week.ordinalString()) Sunday of Advent"
        }
    }
    
    private func getEasterInfo(date: Date, dateString: String, week: Int, weekdayName: String) -> String {
        if week == 1 {
            return "\(dateString) is \(weekdayName) in the Octave of Easter"
        } else if calendar.component(.weekday, from: date) == 1 {
            return "\(dateString) is the \(week.ordinalString()) Sunday of Easter"
        } else {
            return "\(dateString) is \(weekdayName) of the \(week.ordinalString()) Week of Easter"
        }
    }
    
    private func getOrdinaryTimeInfo(date: Date, dateString: String, week: Int, weekdayName: String) -> String {
        if calendar.component(.weekday, from: date) == 1 {
            return "\(dateString) is the \(week.ordinalString()) Sunday in Ordinary Time"
        } else {
            return "\(dateString) is \(weekdayName) of the \(week.ordinalString()) Week in Ordinary Time"
        }
    }
    
    // MARK: - Key Date Calculations
    
    private func getAdventStart(year: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = 12
        components.day = 25
        guard let christmas = calendar.date(from: components) else { return nil }
        
        let weekday = calendar.component(.weekday, from: christmas)
        let daysToSubtract = (weekday - 1) + 7 * 3
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: christmas)
    }
    
    private func getChristmas(year: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = 12
        components.day = 25
        return calendar.date(from: components)
    }
    
    private func getAshWednesday(year: Int) -> Date? {
        guard let easter = getEaster(year: year) else { return nil }
        return calendar.date(byAdding: .day, value: -46, to: easter)
    }
    
    private func getEaster(year: Int) -> Date? {
        // Anonymous Gregorian algorithm
        let a = year % 19
        let b = year / 100
        let c = year % 100
        let d = b / 4
        let e = b % 4
        let f = (b + 8) / 25
        let g = (b - f + 1) / 3
        let h = (19 * a + b - d - g + 15) % 30
        let i = c / 4
        let k = c % 4
        let l = (32 + 2 * e + 2 * i - h - k) % 7
        let m = (a + 11 * h + 22 * l) / 451
        let month = (h + l - 7 * m + 114) / 31
        let day = ((h + l - 7 * m + 114) % 31) + 1
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return calendar.date(from: components)
    }
    
    private func isEaster(_ date: Date) -> Bool {
        let year = calendar.component(.year, from: date)
        guard let easter = getEaster(year: year) else { return false }
        return calendar.isDate(date, inSameDayAs: easter)
    }
    
    private func isChristmas(_ date: Date) -> Bool {
        let components = calendar.dateComponents([.month, .day], from: date)
        return components.month == 12 && components.day == 25
    }
}
extension LiturgicalService {
    func getPsalmsForPrime(for date: Date) -> [String] {
        let weekday = calendar.component(.weekday, from: date)
        let (season, _) = getLiturgicalSeasonAndWeek(for: date)
        
        // Default psalms for Ordinary Time by weekday
        var psalms: [String]
        
        switch weekday {
        case 1: // Sunday
            psalms = ["119Aleph", "119Beta", "119C", "119D"]
        case 2: // Monday
            psalms = ["1", "2", "6"]
        case 3: // Tuesday
            psalms = ["7", "8", "9A"]
        case 4: // Wednesday
            psalms = ["9B", "10", "11"]
        case 5: // Thursday
            psalms = ["12", "13", "14"]
        case 6: // Friday
            psalms = ["15", "16", "17A"]
        case 7: // Saturday
            psalms = ["17B", "18", "19"]
        default:
            psalms = ["1", "2", "6"]
        }
        
        
        return psalms
    }
    
    // Helper to get psalm display name
    func getPsalmDisplayName(_ psalm: String) -> String {
        if psalm.contains("A") || psalm.contains("B") {
            return "Psalm \(psalm)"
        }
        return "Psalm \(psalm)"
    }
}

