//
//  TSSNotiFicationViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 4/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
import RxCocoa
import RxSwift
class TSSNotiFicationViewController: TSSBaseViewController {
    let name = "已经进入前台"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default
            .rx
            .notification(Notification.Name(rawValue: name))
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { userInfo in
                DebugLog("userInfo is \(userInfo.userInfo as! [String:Any])")
            
        }).disposed(by: disposeBag)
    }

    deinit{
        DebugLog("TSSNotiFication deinit")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
