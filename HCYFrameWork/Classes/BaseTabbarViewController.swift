//
//  TabbarController.swift
//
//
//  Created byon 2020/10/24.
//  Copyright © 2020 swift
//

import UIKit

class BaseTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let tabbar = UITabBarAppearance()
            
            tabbar.shadowImage = UIImage()
            tabbar.shadowColor = .clear
            tabbar.backgroundImage = UIImage(named: "tab_back")
            tabbar.backgroundEffect = nil
            tabbar.stackedLayoutAppearance.selected.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12.scale()),.foregroundColor:UIColor.red]
            tabbar.stackedLayoutAppearance.selected.iconColor = .red
            tabbar.stackedLayoutAppearance.normal.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12.scale()),.foregroundColor:UIColor.blue]
            self.tabBar.scrollEdgeAppearance = tabbar
            self.tabBar.standardAppearance = tabbar
        } else {
            // Fallback on earlier versions
            UITabBar.appearance().backgroundImage = UIColor.imageFromColor(color: UIColor.blue, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            UITabBar.appearance().shadowImage = UIImage()
    //        UITabBar.appearance().backgroundColor = UIColor.appBGColor()
            self.tabBar.backgroundImage = UIImage(named: "tab_back")
            UITabBar.appearance().tintColor = .red
            if #available(iOS 10.0, *) {
                UITabBar.appearance().unselectedItemTintColor = .red
            } else {
                // Fallback on earlier versions
            }
            
        }
        self.tabBar.isTranslucent = false
//        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().backgroundImage = UIImage()
      
        
    }
}
