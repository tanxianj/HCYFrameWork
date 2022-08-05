//
//  ActionSheetViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 28/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class ActionSheetViewController: TSSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addEventHandler {
            let config = TSSActionSheetConfig()
            config.offset = 0.0
            config.title = "这是title"
            config.notice = "这是notice"
            let closeBtn = UIButton()
            closeBtn.setTitle("close", for: .normal)
            closeBtn.titleLabel?.font = .systemFont(ofSize: 17.scale())
            closeBtn.backgroundColor = .red
            config.close = closeBtn
            
            let middleBtn = UIButton()
            middleBtn.setTitle("cancelBtn", for: .normal)
            
            middleBtn.backgroundColor = .red
            middleBtn.cornerRadius = 20.scale()
            config.cancelBtn = middleBtn
            
            let leftBtn = UIButton()
            
            leftBtn.setTitle("sureBtn", for: .normal)
            leftBtn.backgroundColor = .green
            leftBtn.cornerRadius = 20.scale()
            config.sureBtn = leftBtn
            config.bottomBtnHeight = 55.scale()
            config.rowHeight =  70.scale()
            config.cornerRadius = 20.scale()
            
            
            
            
            TSSActionSheetManager.sharedInstance().showActionSheetWith(actionSheet:["1111","2222","3333"],
                                                                       delegate: self,
                                                                       type: [
                                                                              .notice,
                                                                              .close,
                                                                              .sure,
                                                                              
                                                                              ],
                                                                       config: config, sureTap:  { multiSelect in
                print("multiSelect is \(multiSelect)")
            })
            
        }
        // Do any additional setup after loading the view.
    }
}
extension ActionSheetViewController:TSSActionSheetManagerDelegate{
    func tableView(_ tableView: UITableView, _ dataSource: Any, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionSheetCell", for: indexPath) as! ActionSheetCell
        cell.tltleLab.text = "\(dataSource as! String)12333"
        cell.descLab.text = "\(indexPath.row)"
        return cell
    }
    func registerTableViewforCellReuseIdentifier() -> String? {
        return "ActionSheetCell"
    }
    func registerTableViewWithNib() -> UINib? {
        return UINib.init(nibName: "ActionSheetCell", bundle: nil)
    }
}
