//
//  ViewController.swift
//  HCYFrameWork
//
//  Created by tanxianj on 07/05/2022.
//  Copyright (c) 2022 tanxianj. All rights reserved.
//

import UIKit
import HCYFrameWork
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DebugLog("这是测试DeBUGLog")
        DebugLog("w is \(view.mj_w) h is \(view.mj_h)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

