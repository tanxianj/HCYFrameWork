//
//  TSSValidateViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 3/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HCYFrameWork
public enum TSSValidateTest{
    case email
    case phoneNumber
    case userName
    case password
    case nickName
    case postalCode
    case URL
    case IP
    case money
    case onlyNumber
    case numberSpace
}
class TSSValidateViewController: TSSBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let name = "已经进入前台"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        NotificationCenter.default
            .rx
            .notification(Notification.Name(rawValue: name))
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { userInfo in
                TSSLog("userInfo is \(userInfo.userInfo as! [String:Any])")
            
        }).disposed(by: disposeBag)
        
        
//        TSSNotiFicationCenter.shared.removeAllObServer(name: name2)
//        TSSNotiFicationCenter.shared.removeAllObServer(name: name3)
        let items = Observable.just([
            ["title":"email","type":TSSValidateTest.email],
            ["title":"phoneNumber","type":TSSValidateTest.phoneNumber],
            ["title":"userName","type":TSSValidateTest.userName],
            ["title":"password","type":TSSValidateTest.password],
            ["title":"nickName","type":TSSValidateTest.nickName],
            ["title":"postalCode","type":TSSValidateTest.postalCode],
            ["title":"URL","type":TSSValidateTest.URL],
            ["title":"IP","type":TSSValidateTest.IP],
            ["title":"money","type":TSSValidateTest.money],
            ["title":"onlyNumber","type":TSSValidateTest.onlyNumber],
            ["title":"numberSpace","type":TSSValidateTest.numberSpace],
        ])
        items.bind(to: tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element["title"]!)"
            cell.textLabel?.font = .systemFont(ofSize: 17.scale())
            return cell
        }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected([String:Any].self)
            .subscribe(onNext: {[weak self] data in
                
                guard let weakSelf = self else {return}
            guard let type = data["type"] as? TSSValidateTest ,let title = data["title"] as? String else { return  }
            let vc = TSSValidateTestVC()
            vc.title =  title
            vc.type = type
                weakSelf.tss_currentVCpushTo(vc)

        }).disposed(by: disposeBag)
        
        
    }

    deinit{
        TSSLog("TSSValidate deinit")
        
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
