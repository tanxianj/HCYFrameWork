//
//  TSSScaleCommon.swift
//  
//
//  Created by Jupiter_TSS on 13/7/22.
//

import Foundation
import UIKit
fileprivate var IsIpadW:CGFloat = 810.0
fileprivate var IsPhoneW:CGFloat = 428.0
extension Int{
    
    /// display Proportion
    /// - Returns: Proportion
    public func scale()-> CGFloat{
        return ScaleClass.scale(CGFloat(self))
    }
}
extension CGFloat{
    
    /// display Proportion
    /// - Returns: Proportion
    public func scale()-> CGFloat{
        return ScaleClass.scale(self)
    }
}

extension Double{
    /// display Proportion
    /// - Returns: Proportion
    public func scale()-> CGFloat{
        return ScaleClass.scale(self)
    }
}

fileprivate class ScaleClass{
    /// display Proportion
    /// - Returns: Proportion
    static func scale(_ value:CGFloat)-> CGFloat{
        if let path = Bundle.main.path(forResource: "TSSFrameWork-info", ofType: "plist"),
           let data = NSDictionary(contentsOfFile: path),
           let isIpadWidth = data["TSS_DESIGN_PAD_WIDTH"] as? NSNumber,
           let iphoneWidth = data["TSS_DESIGN_PHONE_WIDTH"] as? NSNumber{
            IsIpadW = CGFloat(truncating: isIpadWidth)
            IsPhoneW = CGFloat(truncating: iphoneWidth)
            
        }
            
        if TSSIsIpad{
            return (TSSScreenW / IsIpadW) * value
        }else{
            return (TSSScreenW / IsPhoneW) * value
        }
    }
}


extension UITextField{
    
    /// display Proportion
    @IBInspectable public var scale: Bool {
        get {
            return true
        }
        set{
            guard newValue else{return}
            self.font = self.font!.withSize(self.font!.pointSize.scale())
        }
    }
}
extension UITextView{
    /// display Proportion
    @IBInspectable public var scale: Bool {
        get {
            return true
        }
        set{
            guard newValue else{return}
            self.font = self.font!.withSize(self.font!.pointSize.scale())
        }
    }
}
extension UILabel{
    /// display Proportion font size
    @IBInspectable public var scale: Bool {
        get {
            return true
        }
        set{
            guard newValue else{return}
            self.font = self.font.withSize(self.font.pointSize.scale())
        }
    }
    
}

extension UIButton {
    /// display Proportion fontSize
    @IBInspectable public var scale: Bool {
        
        get {
            return true
        }
        set{
            guard newValue else{return}
            let testfont = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize.scale())!)
            self.titleLabel?.font = testfont
            
        }
    }
}

extension NSLayoutConstraint{
    /// display Proportion constant
    @IBInspectable public var scale:Bool{
        get{
            return true
        }
        set{
            guard newValue else{return}
            self.constant = self.constant.scale()
        }
    }
}
extension UIStackView{
    @IBInspectable public var scale:Bool{
        get{
            return true
        }
        set{
            guard newValue else{return}
            self.spacing = self.spacing.scale()
        }
    }
}


