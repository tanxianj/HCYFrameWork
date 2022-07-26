//
//  TSSTimeHelper.swift
//  
//
//  Created by Jupiter_TSS on 11/3/22.
//

import UIKit

public class TSSTimeHelper: NSObject {
    
    /// get timeInterval
    /// - Returns: timeInterval String
    public static  func getTimeInterval() -> String{
        // 当前时间戳
        let timestamp = Date().timeIntervalSince1970
        // 秒级时间戳
        let timeStamp2 = Int(timestamp)
        // 毫秒级时间戳
//        let timeStamp3 = CLongLong(round(timestamp*1000))
        return "\(timeStamp2)"
    }
    
    /// dateStr To TimeInterval
    /// - Parameters:
    ///   - dateStr: Date String
    ///   - dateFormat: dateFormat
    /// - Returns: TimeInterval
    public class func dateStrToTimeInterval(dateStr: String ,dateFormat: String) -> Int  {
          let dateformatter = DateFormatter()
          dateformatter.dateFormat = dateFormat
          let date = dateformatter.date(from: dateStr)
          let dateTimeInterval:TimeInterval = date!.timeIntervalSince1970
          return Int(dateTimeInterval)
      }
    
    /// date To TimeInterval
    /// - Parameter date: date
    /// - Returns: TimeInterval
    public class func dateToTimeInterval(date:Date) -> Int  {
        let dateTimeInterval:TimeInterval = date.timeIntervalSince1970
          return Int(dateTimeInterval)
      }
    
    /// get Curent Month Days
    /// - Returns: Number of days
    public class func getNumberOfDaysInCurrentMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: Date())
        return range!.count
    }
    
    /// get Weeday Frome Date
    /// - Parameter date: date
    /// - Returns: Weeday
    public class func getWeedayFromeDate(date: Date) -> String {
        let timeZone =  NSTimeZone.system
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
//        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
       }
    
    
    /// date Convert String
    /// - Parameters:
    ///   - date: Date
    ///   - dateFormat: dateFormat
    /// - Returns: String
    public class func dateConvertString(date:Date,dateFormat:String) -> String {
    
        let timeZone =  NSTimeZone.system
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
//        formatter.locale = Locale.init(identifier: "en_US_POSIX")
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    /// string Convert Date
    /// - Parameters:
    ///   - dateStr: date String
    ///   - dateFormat: dateFormat
    /// - Returns: Date
    public class func stringConvertDate(dateStr:String,dateFormat:String) -> Date {
        let formatter = DateFormatter()
//        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        formatter.timeZone = .init(identifier: "UTC")
        formatter.calendar = Calendar(identifier: .iso8601)
        let date = formatter.date(from: dateStr)
        return date!
    }
    
    /// timeStamp To DateString
    /// - Parameters:
    ///   - timeStamp: timeStamp
    ///   - dateFormat: dateFormat
    /// - Returns: DateString
    public class func timeStampToDateString(timeStamp:String,dateFormat:String = "yyyy-MM-dd HH:mm") -> String{
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        return dateformatter.string(from: date as Date)
    }
    
    /// timeStamp To Date
    /// - Parameter timeStamp: timeStamp
    /// - Returns: Date
    public class func timeStampToDate(timeStamp:String) -> Date{
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = .init(identifier: "UTC")
        let date = dateFormatter.date(from: timeStampToDateString(timeStamp: timeStamp))
        return date!
    }
    
}
