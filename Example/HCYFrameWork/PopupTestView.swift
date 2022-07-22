//
//  PopupTestView.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class PopupTestView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func btnAction(_ sender: UIButton) {
        TSSBasePoputEvents.shared.sendToPoputView(index: sender.tag)
    }
    
}
