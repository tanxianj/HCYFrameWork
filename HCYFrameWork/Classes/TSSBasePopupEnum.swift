//
//  BasePoputEnum.swift
//
//
//  Created by Jupiter_TSS on 10/4/22.
//

import Foundation
import UIKit
fileprivate let KWindow = UIApplication.shared.keyWindow

/// Popup show Type
public enum TSSBasePopupType:Int{
    case bottomToTop = 0
    case bottomToCenter
    case topToCenter
    case topToBottom
    case leftToRight
    case rightToLeft
}

/// Popup Show In Type
public enum TSSBasePopupShowInType{
    case viewIsWindow
    case viewIs(_ view:UIView)
}
extension TSSBasePopupShowInType{
    public  var view:UIView{
        switch self {
        case .viewIsWindow:
            return KWindow!
        case .viewIs(let view):
            if let superView = view.superview ,superView.tss_h == KWindow!.tss_h{
                return KWindow!
            }else{
                return view
            }
            
        }
    }
}
