//
//  TimeHelperViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 25/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import HCYFrameWork
class TimeHelperViewController: TSSBaseViewController {
    let timeStamp = "1658719230"
    let timeStr = "2022-07-25 11:20:30"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 初始化数据
        let items = Observable.just([
            "当前时间戳:\(TSSTimeHelper.getTimeInterval())",
            
            "时间字符串转时间戳 \(TSSTimeHelper.dateStrToTimeInterval(dateStr: timeStr, dateFormat: "yyyy-MM-dd HH:mm:ss"))",
            
            "Date转时间戳:\(TSSTimeHelper.dateToTimeInterval(date: Date()))",
            
            "当前月份天数:\(TSSTimeHelper.getNumberOfDaysInCurrentMonth())",
            
            "某天是星期几:\(TSSTimeHelper.getWeedayFromeDate(date: Date()))",
            
            "时间转字符串:\(TSSTimeHelper.dateConvertString(date: Date(), dateFormat: "yyyy-MMM-dd hh:mm aa"))",
            
            "字符串转Date:\(TSSTimeHelper.stringConvertDate(dateStr: timeStr, dateFormat: "yyyy-MM-dd HH:mm:ss"))",
            
            "时间戳转时间字符串:\(TSSTimeHelper.timeStampToDateString(timeStamp: timeStamp, dateFormat: "yyyy-MMM-dd hh:mm aa"))",
            
            "时间戳转时间Date:\(TSSTimeHelper.timeStampToDate(timeStamp: timeStamp))"
            
        ])
        
        // 设置单元格数据（其实就是对 cellForRowAt 的封装）
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                cell.textLabel?.text = "\(row)：\(element)"
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    

}
