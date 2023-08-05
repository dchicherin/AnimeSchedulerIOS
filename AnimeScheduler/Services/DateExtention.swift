//
//  GetNextDay.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 26/7/2566 BE.
//

import Foundation

extension Date {
  // weekday is in form 1...7
    enum WeekDay: Int{
        
        
    case Sundays = 1, Mondays, Tuesdays, Wednesdays, Thursdays, Fridays, Saturdays
  }
  
  enum SearchDirection {
    case next
    case previous
    
    var calendarOptions: NSCalendar.Options {
      switch self {
      case .next:
        return .matchNextTime
      case .previous:
        return [.searchBackwards, .matchNextTime]
      }
    }
  }
  
  func get(direction: SearchDirection, dayName: WeekDay, considerToday consider: Bool = false) -> Date {
    
    let nextWeekDayIndex = dayName.rawValue
    let today = self
    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    
    if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
      return today
    }
    
    var nextDateComponent = DateComponents()
    nextDateComponent.weekday = nextWeekDayIndex
    
    let date = calendar.nextDate(after: today, matching: nextDateComponent, options: direction.calendarOptions)!
    return date
  }
    public func setTime(hour: Int, min: Int, sec: Int, timeZoneAbbrev: String = "UTC") -> Date? {
            let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
            let cal = Calendar.current
            var components = cal.dateComponents(x, from: self)

            components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
            components.hour = hour
            components.minute = min
            components.second = sec

            return cal.date(from: components)
        }
}
