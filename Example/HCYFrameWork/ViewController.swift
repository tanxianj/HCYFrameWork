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
        view.addEventHandler {
            DebugLog("视图点击事件")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

