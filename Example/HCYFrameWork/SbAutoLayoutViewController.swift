//
//  SbAutoLayoutViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class SbAutoLayoutViewController: TSSBaseViewController {
    @IBOutlet weak var testLab: UILabel!
    
    @IBOutlet weak var testBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        testLab.text = "UILabel:文字原始size 17 当前size \(17.scale())"
        testBtn.titleLabel?.text = "This is UIButton"
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
