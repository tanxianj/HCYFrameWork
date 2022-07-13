//
//  BasePoputEnum.swift
//  设计模式学习
//
//  Created by Jupiter_TSS on 10/4/22.
//

import Foundation
import UIKit
fileprivate let KWindow = UIApplication.shared.keyWindow

/// Popup show Type
public enum BasePopupType:Int{
    case bottomToTop = 0
    case bottomToCenter
    case topToCenter
    case topToBottom
    case leftToRight
    case rightToLeft
}

/// Popup Show In Type
public enum BasePopupShowInType{
    case viewIsWindow
    case viewIs(_ view:UIView)
}
extension BasePopupShowInType{
    public  var view:UIView{
        switch self {
        case .viewIsWindow:
            return KWindow!
        case .viewIs(let view):
            if let superView = view.superview ,superView.mj_h == KWindow!.mj_h{
                return KWindow!
            }else{
                return view
            }
            
        }
    }
}
