//
//  ActionSheetCell.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 28/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    @IBOutlet weak var tltleLab:UILabel!
    @IBOutlet weak var descLab:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tltleLab.textColor = selected ? .red : .black
        // Configure the view for the selected state
    }
    
}
