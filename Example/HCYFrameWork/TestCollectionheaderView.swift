//
//  TestCollectionheaderView.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 23/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
protocol TestCollectionheaderViewDelegate:NSObjectProtocol{
    func cellReadMoreBtnAction(isSelected:Bool)
}
class TestCollectionheaderView: UICollectionReusableView {
    weak var delegate:TestCollectionheaderViewDelegate?
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var testLab: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func readMoreBtnAction(_ sender: UIButton) {
        readMoreBtn.isSelected.toggle()
        delegate?.cellReadMoreBtnAction(isSelected: readMoreBtn.isSelected)
        
    }
    
}
