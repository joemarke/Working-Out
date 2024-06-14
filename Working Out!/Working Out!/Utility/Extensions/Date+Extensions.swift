//
//  Date+Extensions.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import Foundation

extension Date {
    // CAN BE REMOVED - Dummy data only
    func getDateIn(days: Int) -> Date {
        let calendar = Calendar.current
        // If adding days to the date returns nil (likely a timezone issue occurring once a year), manually add 24 hours * the number of days to the day.
        return calendar.date(byAdding: .day, value: days, to: self) ?? self.addingTimeInterval(60 * 60 * 24 * Double(days))
    }
    
    func getDayOfWeek() -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEE"
        return dayFormatter.string(from: self)
    }
    
    func getDayNumber() -> String {
        let dayNumberFormatter = DateFormatter()
        dayNumberFormatter.dateFormat = "dd"
        return dayNumberFormatter.string(from: self)
    }
    
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: date)
    }
}
