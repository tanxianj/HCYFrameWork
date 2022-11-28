//
//  TestCollectionViewCell.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 11/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.layoutIfNeeded()
       return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
    

}
