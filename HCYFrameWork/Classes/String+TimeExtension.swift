//
//  String+Time.swift
//  
//
//  Created by Jupiter_TSS on 11/3/22.
//

import UIKit

public class HCYStringWithTime: NSObject {
    
    /// get timeInterval
    /// - Returns: timeInterval String
    public static  func gettimeInterval()->String{
        // 当前时间戳
        let timestamp = Date().timeIntervalSince1970
        // 秒级时间戳
        let timeStamp2 = Int(timestamp)
        // 毫秒级时间戳
        //        let timeStamp3 = CLongLong(round(timestamp*1000))
        return "\(timeStamp2)"
        //        例如：
        //        let time = Date().timeIntervalSince1970
        //        print(time)      // 1586851311.174374
        //        print(Int(time)) // 1586851311
        //        print(CLongLong(round(time*1000))) // 1586851311174
    }
    
    /// date Convert String
    /// - Parameter date: Date
    /// - Returns: Date String yyyy-MM-dd
    public static func dateConvertString(date:Date) -> String {
        /*
         let timeZone = TimeZone.init(identifier: "UTC")
         let formatter = DateFormatter()
         formatter.timeZone = timeZone
         formatter.locale = Locale.init(identifier: "zh_CN")
         formatter.dateFormat = dateFormat
         let date = formatter.string(from: date)
         
         
         return date.components(separatedBy: " ").first!
         */
        
        
        let timeZone = NSTimeZone.system
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        
        let daydateFormat = "dd "
        formatter.dateFormat = daydateFormat
        let day = formatter.string(from: date)
        
        let monthdateFormat = "MM"
        formatter.dateFormat = monthdateFormat
        let moth = HCYStringWithTime.backmonth(formatter.string(from: date))
        
        let yearFormat = " yyyy"
        formatter.dateFormat = yearFormat
        let year = formatter.string(from: date)
        
        
        return day + moth + year
    }
    
    /// Date Convert AM PM
    /// - Parameter date: date
    /// - Returns: HH:mm  AM  or PM
    public static func dateConvertHourMinString(date:Date) -> String {
        /*
         let timeZone = TimeZone.init(identifier: "UTC")
         let formatter = DateFormatter()
         formatter.timeZone = timeZone
         formatter.locale = Locale.init(identifier: "zh_CN")
         formatter.dateFormat = dateFormat
         let date = formatter.string(from: date)
         
         
         return date.components(separatedBy: " ").first!
         */
        
        
        let timeZone = NSTimeZone.system
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        
        let hourdateFormat = "HH"
        formatter.dateFormat = hourdateFormat
        let hour = formatter.string(from: date)
        
        
        let mindateFormat = "mm"
        formatter.dateFormat = mindateFormat
        let min = formatter.string(from: date)
        if Int(hour)! <= 12 {
            return "\(hour):\(min) AM"
        }else{
            return "\(Int(hour)! - 12):\(min) PM"
        }
    }
    
    
    /// 日期字符串转化为Date类型
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
    /// - Returns: Date类型
    public static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    
    // 转化成格式化后的日期字符串
    private func convertDateString(string: String) -> String{
        let date = HCYStringWithTime.stringConvertDate(string: string)
        let tempString = HCYStringWithTime.dateConvertString(date: date)
        return tempString
    }
    
    /// Roman numerals Month convert English Month
    /// - Parameter number: Roman numerals Month
    /// - Returns: English Month
    public static func backmonth(_ number:String)->String{
        return ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"][Int(number)! - 1]
    }
}
