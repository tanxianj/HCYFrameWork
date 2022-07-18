//
//  APPNavgationViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class APPNavigationViewController: HCYBaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hcy_ResetNavigationConfig(navTitleColor: .black, navTitleFont: .systemFont(ofSize: 18.scale()), navbackgroundColor: .white)
        // Do any additional setup after loading the view.
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
