//
//  TSSActionSheetTableViewCell.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 28/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class TSSActionSheetTableViewCell: UITableViewCell {
    lazy var titleLab:UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        return title
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabel()
    }
    func addLabel(){
        self.contentView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12.scale())
            make.top.equalToSuperview().offset(10.scale())
            make.height.greaterThanOrEqualTo(30.scale())
        }
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
