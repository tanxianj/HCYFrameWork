//
//  TSSColorViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork

class TSSColorViewController: TSSBaseViewController {
    let viewModel = TSSColorViewModel()
    @IBOutlet weak var rfield: UITextField!
    @IBOutlet weak var gfield: UITextField!
    @IBOutlet weak var bfield: UITextField!
    
    @IBOutlet weak var rgbBtn: UIButton!
    
    @IBOutlet weak var hexfield: UITextField!
    
    @IBOutlet weak var hexbtn: UIButton!
    
    
    @IBOutlet weak var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        rfield.rx.text.orEmpty => viewModel.input.r
        gfield.rx.text.orEmpty => viewModel.input.g
        bfield.rx.text.orEmpty => viewModel.input.b
        
        hexfield.rx.text.orEmpty => viewModel.input.hex
        
        rgbBtn.rx.tap => viewModel.input.rgbbtn
        hexbtn.rx.tap => viewModel.input.hexBtn
        
        viewModel.output.rgbBtn => rgbBtn.rx.isEnabled
        viewModel.output.hexBtn => hexbtn.rx.isEnabled
        
        viewModel.output.rgb => testView.rx.backgroundColor
        viewModel.output.hexColor => testView.rx.backgroundColor
        

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

