//
//  UITabbar+TSSExtenstion.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 22/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
fileprivate let TSSTABBARTAG = 888
extension UITabBar{
    
    public func showBadgeOnItem(index:Int,badgeValue:String? = nil){
        
        guard index <= self.items!.count - 1 else{return}
        
        
        self.removeBadgeOnItem(index: index)
         
        
        
        if let badgeValue = badgeValue {
            let item = self.items![index]
            item.badgeValue = badgeValue
            item.badgeColor = .red
        }else{
            let badgeView = UIView()
            badgeView.tag = TSSTABBARTAG + index
            badgeView.layer.cornerRadius = 4.0
            badgeView.backgroundColor = .red
            
            let tabFrame = self.frame
            
            guard let itemsCount = self.items?.count else { return }
            
            let percentX:CGFloat = (CGFloat(index) + 0.6) / CGFloat(itemsCount)
            
            let x = ceilf(Float(percentX * tabFrame.size.width))
            let y = ceilf(0.1 * Float(tabFrame.size.height))
            
            badgeView.frame = CGRect(x: Int(x) - 2, y: Int(TSSisIphoneX ? y - 3 : y) , width: 8, height: 8)
            self.addSubview(badgeView)
        }
    }
    
    public func hideBadgeOnItem(index:Int){
        self.removeBadgeOnItem(index: index)
    }
    private func removeBadgeOnItem(index:Int){
        guard index <= self.items!.count - 1 else{return}
        let item = self.items![index]
        item.badgeValue = nil
        
        guard let subView = self.subviews.first(where: {$0.tag == TSSTABBARTAG + index}) else { return }
        subView.removeFromSuperview()

    }
}
