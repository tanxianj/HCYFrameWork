//
//  TSSCycleScrollViewDefaultCell.swift
//  HCYFrameWork
//
//  Created by Jupiter_TSS on 12/8/22.
//

import UIKit

public class TSSCycleScrollViewDefaultCell: UICollectionViewCell {
    public lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
     override init(frame: CGRect) {
        super.init(frame: frame)
         setUpUI()
    }
    private func setUpUI(){
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
}
