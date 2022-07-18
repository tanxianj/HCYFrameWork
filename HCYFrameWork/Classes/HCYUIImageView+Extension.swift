//
//  HCYUIImageView+Extension.swift
//  HCYFrameWork
//
//  Created by Jupiter_TSS on 14/7/22.
//

import Foundation
import Kingfisher
extension UIImageView{
    public func hcySetImageWith(url:String ,placeholder:String = ""){
        if HCYValidate.URL(url).isRight{
            self.kf.setImage(with: URL(string: url),placeholder: UIImage(named: placeholder))
        }else{
            self.kf.setImage(with: URL(string: ""),placeholder: UIImage(named: placeholder))
        }
        
    }
}
