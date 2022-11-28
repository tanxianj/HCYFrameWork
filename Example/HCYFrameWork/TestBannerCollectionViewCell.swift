//
//  TestBannerCollectionViewCell.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 11/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class TestBannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .arc4Color()
        // Initialization code
    }

}
