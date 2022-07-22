//
//  PopUpDemoViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class PopUpDemoViewController: TSSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    @IBAction func btnAction(_ sender: UIButton) {
        let config = TSSBasePopupConfig()
        config.withDuration  = 0.2
        let view =  PopupTestView.viewForXib() as! PopupTestView
        
        TSSBasePopupViewManager.sharedInstance().showPoputWith( contentView: view ,popupType: TSSBasePopupType(rawValue: sender.tag)!,config: config) { index in
            print("点击视图按钮 \(index)")
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
