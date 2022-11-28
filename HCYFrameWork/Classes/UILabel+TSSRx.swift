//
//  TSSUILabel+Rx.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 3/8/22.
//

import UIKit
import RxSwift
import RxCocoa
extension Reactive where Base:UILabel{
    public var fontsize:Binder<CGFloat>{
        return Binder(self.base){ label ,fontsize in
            let font = label.font.withSize(fontsize.scale())
            label.font = font
            
        }
    }
    public var textColor:Binder<UIColor>{
        return Binder(self.base){label,textColor in
            label.textColor = textColor
        }
    }
}

