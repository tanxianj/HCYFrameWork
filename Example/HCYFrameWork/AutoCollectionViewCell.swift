//
//  AutoCollectionViewCell.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 11/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class AutoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 11
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1).cgColor
        // Initialization code
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.layoutIfNeeded()
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
}
