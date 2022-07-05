//
//  Number+Extension.swift
//  
//
//  Created by Jupiter_TSS on 13/4/22.
//

import Foundation
import UIKit
fileprivate let IsIpadW:CGFloat = 810.0
fileprivate let IsPhoneW:CGFloat = 428.0
extension Int{
    public func scale()-> CGFloat{
         return ScaleClass.scale(CGFloat(self))
    }
}
extension CGFloat{
    public func scale()-> CGFloat{
         return ScaleClass.scale(self)
    }
}

extension Double{
    public func scale()-> CGFloat{
         return ScaleClass.scale(self)
    }
}

fileprivate class ScaleClass{
    static func scale(_ value:CGFloat)-> CGFloat{
        if IsIpad{
            return (KScreenW / IsIpadW) * value
        }else{
            return (KScreenW / IsPhoneW) * value
        }
    }
}


extension UITextField{
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
/*
 import RxSwift
 extension Reactive where Base:UILabel{
     public var fontsize:Binder<CGFloat>{
         return Binder(self.base){ label ,fontsize in
             let ff = label.font.withSize(fontsize.scale())
             label.font = ff
             
         }
     }
 }
 */
