//
//  TabbarController.swift
//
//
//  Created byon 2020/10/24.
//  Copyright © 2020 swift
//

import UIKit

/// Base Tabbar
open class HCYBaseTabbarViewController: UITabBarController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        hcy_ResetTabbarConfig()
    }
    
    /// 设置 Tabbar 参数
    /// - Parameters:
    ///   - fontSize:文字大小 默认14
    ///   - selectedColor: 选中颜色
    ///   - normalColor: 默认颜色
    ///   - backGround: 背景 可传入 1.图片 2.颜色 3.文字 文字将被视为图片Name
    public func hcy_ResetTabbarConfig(fontSize:CGFloat = 12.0,
                                selectedColor:UIColor = .red,
                                normalColor:UIColor = .blue,
                                backGround:Any? = nil){
        
        //MARK: init tabbar parameter
        if #available(iOS 15.0, *) {
            let tabbar = UITabBarAppearance()
            tabbar.shadowImage = UIImage()
            //            tabbar.backgroundImage = UIImage(named: "tab_back")
            tabbar.shadowColor = .clear
            tabbar.backgroundEffect = nil
            
            
            tabbar.stackedLayoutAppearance.selected.iconColor = selectedColor
            tabbar.stackedLayoutAppearance.selected.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12.scale()),.foregroundColor:selectedColor]
            
            
            tabbar.stackedLayoutAppearance.normal.iconColor = normalColor
            tabbar.stackedLayoutAppearance.normal.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12.scale()),.foregroundColor:normalColor]
            if let backGround = backGround as? UIColor  {
                tabbar.backgroundImage = UIColor.imageFromColor(color: backGround, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            }
            if let backGround = backGround as? UIImage  {
                tabbar.backgroundImage = backGround
            }
            if let backGround = backGround as? String  {
                tabbar.backgroundImage = UIImage(named: backGround)
            }
            
            if backGround == nil{
                tabbar.backgroundImage = UIColor.imageFromColor(color: UIColor.white, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            }
            self.tabBar.scrollEdgeAppearance = tabbar
            self.tabBar.standardAppearance = tabbar
            
        } else {
            // Fallback on earlier versions
            UITabBar.appearance().backgroundImage = UIColor.imageFromColor(color: UIColor.blue, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            UITabBar.appearance().shadowImage = UIImage()
            //        UITabBar.appearance().backgroundColor = UIColor.appBGColor()
            //            self.tabBar.backgroundImage = UIImage(named: "tab_back")
            
            if let backGround = backGround as? UIColor  {
                self.tabBar.backgroundImage = UIColor.imageFromColor(color: backGround, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            }
            if let backGround = backGround as? UIImage  {
                self.tabBar.backgroundImage = backGround
            }
            if let backGround = backGround as? String  {
                self.tabBar.backgroundImage = UIImage(named: backGround)
            }
            if backGround == nil{
                self.tabBar.backgroundImage = UIColor.imageFromColor(color: UIColor.white, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            }
            UITabBar.appearance().tintColor = selectedColor
            if #available(iOS 10.0, *) {
                UITabBar.appearance().unselectedItemTintColor = normalColor
            } else {
                // Fallback on earlier versions
            }
            
        }
        self.tabBar.isTranslucent = false
        //        UITabBar.appearance().backgroundColor = UIColor.white
        //        UITabBar.appearance().backgroundImage = UIImage()
        
    }
}
