//
//  AutoTwoCollectionViewCell.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 11/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class AutoTwoCollectionViewCell: UICollectionViewCell {
    lazy var titleLab:UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 17.scale())
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.cornerRadius = 11
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1).cgColor
        self.contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10.scale(), left: 10.scale(), bottom: 10.scale(), right: 10.scale()))
        }
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        self.setNeedsLayout()
        self.layoutIfNeeded()
        return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
