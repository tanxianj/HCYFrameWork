//
//  AutoLayoutViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import HCYFrameWork
class AutoLayoutViewController: TSSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let sb = UIStoryboard.init(name: "SbAutoLayoutViewController", bundle: nil).instantiateViewController(withIdentifier: "SbAutoLayoutViewController")
        let items = Observable.just([
            ["title":"纯代码自适应布局","vc":codeAutoLayoutViewController()],
            ["title":"Xib自适应布局","vc":XibAutoLayoutViewController()],
            ["title":"Sb自适应布局","vc":sb]
            
            
        ])
        items.bind(to: tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element["title"]!)"
            cell.textLabel?.font = .systemFont(ofSize: 17.scale())
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected([String:Any].self).subscribe(onNext: { data in
            guard let vc = data["vc"] as? UIViewController ,let title = data["title"] as? String else { return  }
            vc.title =  title
            self.tss_currentVCpushTo(vc)
            
        }).disposed(by: disposeBag)
    }
    override func setupNavigationItems() {
        title = "我的"
        tss_addRightButton(title:"haha") {
            
        }
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
