//
//  MJRefresh+extension.swift
//  
//
//  Created by Jupiter_TSS on 13/5/22.
//

import Foundation
import MJRefresh
public class HCYMJRefreshTools{
    
    /// scroll view pull refresh data
    /// - Parameter block: action
    /// - Returns: -
    public static func mj_header(block:@escaping MJRefreshComponentAction)->MJRefreshHeader{
        let header = MJRefreshNormalHeader(refreshingBlock: block)
        header.isAutomaticallyChangeAlpha = true
        //        header.lastUpdatedTimeLabel?.isHidden = true
        //        header.setAnimationDisabled()
        return header
        
    }
    
    /// scroll view pull up load data
    /// - Parameter block: action
    /// - Returns: -
    public static func mj_footer(block:@escaping MJRefreshComponentAction)->MJRefreshFooter{
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: block)
        //        footer.setAnimationDisabled()
        footer.setTitle("", for: .idle)
        footer.stateLabel?.textColor = .red
        
        return footer
    }
}
