//
//  BasePopupConfig.swift
//  设计模式学习
//
//  Created by Jupiter_TSS on 10/4/22.
//

import Foundation
import UIKit
public class HCYBasePopupConfig{
    public var offset:CGFloat = 0.0
    public var clearance:CGFloat = 20.0.scale()
    public var withDuration:CGFloat = 0.2
    public var bgcolor:UIColor = .black.alpha(0.3)
    public init(offset:CGFloat = 0.0,clearance:CGFloat = 20.0.scale(),withDuration:CGFloat = 0.2,bgcolor:UIColor = .black.alpha(0.3)){
        self.offset = offset
        self.clearance = clearance
        self.withDuration = withDuration
        self.bgcolor = bgcolor
        
    }
}
