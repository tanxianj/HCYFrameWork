//
//  HCYUITextField+Extension.swift
//  HCYFrameWork
//
//  Created by Jupiter_TSS on 14/7/22.
//

import Foundation
extension UITextField{
    
    /// extension UITextField placeHolder Color
    @IBInspectable public var placeHolderColor: UIColor? {
         get {
             return self.placeHolderColor
         }
         set {
             self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
         }
     }
}
