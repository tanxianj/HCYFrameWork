//
//  BasePopupConfig.swift
//  
//
//  Created by Jupiter_TSS on 10/4/22.
//

import Foundation
import UIKit

/// Base Popup Config
public class HCYBasePopupConfig{
    
    /// offset 偏移量
    public var offset:CGFloat = 0.0
    
    /// clearance 间隙
    public var clearance:CGFloat = 20.0.scale()
    
    /// animation Duration
    public var withDuration:CGFloat = 0.2
    
    /// backgroung color
    public var bgcolor:UIColor = .black.alpha(0.3)
    public init(offset:CGFloat = 0.0,clearance:CGFloat = 20.0.scale(),withDuration:CGFloat = 0.2,bgcolor:UIColor = .black.alpha(0.3)){
        self.offset = offset
        self.clearance = clearance
        self.withDuration = withDuration
        self.bgcolor = bgcolor
        
    }
}
