//
//  UIDeviceViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class UIDeviceViewController: TSSBaseViewController {
    @IBOutlet weak var deviceLab: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    let viewModel = UIDeviceModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        inputField.rx.textInput => viewModel.input.inputmm
        viewModel.output.deviceName => deviceLab.rx.text
        viewModel.output.actualWidth => viewWidth.rx.constant
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
