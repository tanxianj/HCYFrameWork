//
//  Date+TSSExtension.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 28/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
extension Date {

    var zeroSeconds: Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)
    }

}

extension Date {
    func getStartAndEndOfDay() -> (Start: Date,End :Date)
    {
        let Start = Calendar.current.startOfDay(for: self)
        let End: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: Start)!
        }()
        
        return (Start,End)
    }
    func getStartAndEndOfMonth() -> (Start: Date,End :Date)
    {
        let interval = Calendar.current.dateInterval(of: .month, for: self)!
        let Start = interval.start
        let End = Calendar.current.date(byAdding: DateComponents(month: 1, day: 0 , hour: 0 , minute : 0 , second: -1), to: Start)!
        return (Start,End)
    }
    func getStartAndEndOfYear() -> (Start: Date,End :Date)
    {
        let interval = Calendar.current.dateInterval(of: .year, for: self)!
        let Start = interval.start
        let End = Calendar.current.date(byAdding: DateComponents(year: 1,month: 0, day: 0 , hour: 0 , minute : 0 , second: -1), to: Start)!
        return (Start,End)
    }
    func getDaysInMonth() -> [Date]
    {
        var MonthDaysArray = [Date]()
        let interval = Calendar.current.dateInterval(of: .month, for: self)!
        var firstDay = interval.start
        let lastDay = Calendar.current.date(byAdding: .day, value: -1, to: interval.end)
        
        while firstDay.compare(lastDay!) != .orderedDescending {
            MonthDaysArray.append(firstDay)
            firstDay = Calendar.current.date(byAdding: .day, value: 1, to: firstDay)!
        }
        return MonthDaysArray
    }
    func getMonths(monthValue : Int) -> [Date]
    {
        var MonthArray = [Date]()
        var StartDate = Calendar.current.date(byAdding: .month, value: 0, to: self)!
        let EndDate = Calendar.current.date(byAdding: .month, value: monthValue-1, to: StartDate)
        
        while StartDate.compare(EndDate!) != .orderedDescending {
            MonthArray.append(StartDate)
            StartDate = Calendar.current.date(byAdding: .month, value: 1, to: StartDate)!
        }
        return MonthArray
    }
    func getDaysDifference(date : Date) ->Int
    {
        let date1 = Calendar.current.startOfDay(for: self)
        let date2 = Calendar.current.startOfDay(for: date)
        return Calendar.current.dateComponents([.day], from: date1, to: date2).day!
    }
    func getWeekAndDayDifference(date : Date) ->DateComponents
    {
        let date1 = Calendar.current.startOfDay(for: self)
        let date2 = Calendar.current.startOfDay(for: date)
        return Calendar.current.dateComponents([.weekOfMonth,.day], from: date1, to: date2)
    }
    func getPreviousDateFromNow(beforeDays: Int) -> Date {
        
         return Calendar.current.date(byAdding: .day, value: -(beforeDays), to: Date())!
        
    }
    func getPreviousDayDate(beforeDays: Int) -> Date {
        
        //let Start = Calendar.current.startOfDay(for: self)
        let totalhour = beforeDays * 24
        let components = DateComponents(hour: -(totalhour), second: 1)
        return Calendar.current.date(byAdding: components, to: self)!
        //return Calendar.current.date(byAdding: .day, value: -(beforeDays), to: self)!
        
    }
    func getPreviousMonthDate(beforeMonths: Int) -> Date {
        
        let components = DateComponents(month: -(beforeMonths), second: 1)
        return Calendar.current.date(byAdding: components, to: self)!
    }
    func getPreviousDateFromDate(beforeYears: Int) -> Date
    {
        return Calendar.current.date(byAdding: .year, value: -(beforeYears), to: self)!
    }
    func getNextDateFromNow(nextDays: Int) -> Date {
        
        return Calendar.current.date(byAdding: .day, value: nextDays, to: Date())!
        
    }
    func getNextDate(nextMonths : Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: nextMonths, to: self)!
    }
    func getNextDate(nextDays: Int) -> Date {
        
        return Calendar.current.date(byAdding: .day, value: nextDays, to: self)!
        
    }
    func getNextDate(nextSeconds: Int) -> Date {
        
        return Calendar.current.date(byAdding: .second, value: nextSeconds, to: self)!
        
    }
    func getDayNumberOfWeek() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    func getDay() -> Int {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd"
        
        let day = Int(dateFormatter.string(from: self))!
        
        return day
        
    }
    func getMonth() -> Int {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM"
        
        let month = Int(dateFormatter.string(from: self))!
        
        return month
    }
    
    func getYear() -> Int {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY"
        
        let year = Int(dateFormatter.string(from: self))!
        
        return year
        
    }
    
    func getSixMonthFromDate() -> Date {
        
        let month = self.getMonth()
        let year =  self.getYear()
        
        let sixMonthsLaterMonth = month + 5 > 12 ? (month + 5) % 12 : month + 5
        let sixMonthsLaterYear = month + 5 > 12 ? year + 1 : year
        
        let monthstring = String(format: "%02d", sixMonthsLaterMonth)
        
        let dateString = "01/\(monthstring)/\(sixMonthsLaterYear)"

        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let sixMonth = dateFormatter.date(from: dateString)!.endOfMonth()

        return sixMonth
        
    }
    
    func getTwelveMonthFromDate() -> Date {
        
        let month = self.getMonth()
        let year =  self.getYear()
        
        let twelveMonthsLaterMonth = month + 11 > 12 ? (month + 11) % 12 : month + 11
        let twelveMonthsLaterYear = month + 11 > 12 ? year + 1 : year
        
        let monthstring = String(format: "%02d", twelveMonthsLaterMonth)
        
        let dateString = "01/\(monthstring)/\(twelveMonthsLaterYear)"
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let twelveMonth = dateFormatter.date(from: dateString)!.endOfMonth()
        
        return twelveMonth
        
    }

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func from(year: Int, month: Int, day: Int) -> Date?
    {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return Calendar.current.date(from: dateComponents) ?? nil
    }
    func allDates(till endDate: Date) -> [Date] {
        var date = self
        var array: [Date] = []
        while date <= endDate {
          array.append(date)
          date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return array
      }
}
//String result from date
extension Date
{
    ///Convert Date to String in Long format
    func toString() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: self)

    }
    ///EEE, ddMMMyyyy, HH:mm a
    func toFullString() -> String {
        let string = getDateStringWith(format: "EEE, ddMMMyyyy, HH:mm a")
        return string
    }
    ///use this to get date string with custom format
    func getDateStringWith(format: String = "" ,smallCase: Bool = true,is12hrMode: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = is12hrMode ? Locale(identifier: "en_US") : Locale(identifier: "en_GB")
        dateFormatter.dateFormat = format
        if smallCase {
            //change am and pm to lower case
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
        }
        let result = dateFormatter.string(from: self)
        
        return result
    }
    
    func toEMMMdyyyyString() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d yyyy"
        
        return "   \(formatter.string(from: self))"
        
    }
    
    func todMMMyyyyEString() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy, E"
        
        return "\(formatter.string(from: self))"
        
    }
    
    func toHHmmString() -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return "   \(formatter.string(from: self))"
        
    }
    //add on
    func getMonthString() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM"
        
        let month = dateFormatter.string(from: self)
        
        return month
    }
    
    func getFullMonthString() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM"
        
        let month = dateFormatter.string(from: self)
        
        return month
    }
    func getTime() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: self)
        
    }
    func toMonthString() -> String
    {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
        
    }
    
    func toMonthFullString() -> String
    {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM yyyy"
        
        return dateFormatter.string(from: self)
        
    }
}
extension Date {
    func compareTo(date: Date, toGranularity: Calendar.Component ) -> ComparisonResult
    {
        let cal = Calendar.current
        //cal.timeZone = TimeZone(identifier: "Europe/Paris")!
        return cal.compare(self, to: date, toGranularity: toGranularity)
    }
}
extension Date{
    func dateSimplificator(format:String = "yyyy-MM-dd") -> String {
        let formatterD = DateFormatter()
        formatterD.locale =  Locale.current//Locale(identifier: "en_US")
        formatterD.dateFormat = format
        let dayString = formatterD.string(from: self)
        return dayString
    }

}
