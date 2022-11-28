//
//  UIImageView+TSSExtension.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 14/7/22.
//

import Foundation
import Kingfisher
extension UIImageView{
    public func tssSetImageWith(url:String ,placeholder:String = ""){
        if TSSValidate.URL(url).isRight{
            self.kf.setImage(with: URL(string: url),placeholder: UIImage(named: placeholder))
        }else{
            self.kf.setImage(with: URL(string: ""),placeholder: UIImage(named: placeholder))
        }
        
    }
}
