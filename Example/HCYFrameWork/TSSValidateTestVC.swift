//
//  TSSValidateTestVC.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 3/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TSSValidateTestVC: TSSBaseViewController {
    @IBOutlet weak var resultLab: UILabel!
    @IBOutlet weak var textField: UITextField!
    let viewModel = TSSValidateViewModel()
    
    var type:TSSValidateTest!
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.rx.text.orEmpty => viewModel.input.textfiled
        Observable.just(type) => viewModel.input.type

        viewModel.output.statusColor => resultLab.rx.textColor
        viewModel.output.result => resultLab.rx.text

    }

  

}
