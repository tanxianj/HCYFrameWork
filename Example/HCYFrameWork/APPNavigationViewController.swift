//
//  APPNavgationViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class APPNavigationViewController: TSSBaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tss_ResetNavigationConfig(navTitleColor: UIColor.colorWithAppearanceMode(.black, .white), navTitleFont: .systemFont(ofSize: 18.scale()), navbackgroundColor: .colorWithAppearanceMode(.white, .black))
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
