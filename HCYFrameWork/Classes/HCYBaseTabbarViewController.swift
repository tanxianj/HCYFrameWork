//
//  TabbarController.swift
//
//
//  Created byon 2020/10/24.
//  Copyright © 2020 swift
//

import UIKit
import RxSwift
import RxRelay

/// Base Tabbar
open class HCYBaseTabbarViewController: UITabBarController {
    
    /// Rxswift disposeBag
    let disposeBag = DisposeBag()
    
    /// tabbar Background Image
    fileprivate let imageName = PublishSubject<String>()
    
    /// init function
    /// - Parameter withtabbarImage: tabbar Background Image Name
    public convenience init(withtabbarImage:String){
        self.init(nibName: nil, bundle: nil)
        imageName.onNext(withtabbarImage)
    }
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: init tabbar parameter
        if #available(iOS 15.0, *) {
            let tabbar = UITabBarAppearance()
            tabbar.shadowImage = UIImage()
            //            tabbar.backgroundImage = UIImage(named: "tab_back")
            tabbar.shadowColor = .clear
            tabbar.backgroundEffect = nil
            tabbar.stackedLayoutAppearance.selected.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12.scale()),.foregroundColor:UIColor.red]
            tabbar.stackedLayoutAppearance.selected.iconColor = .red
            tabbar.stackedLayoutAppearance.normal.titleTextAttributes = [.font:UIFont.systemFont(ofSize: 12.scale()),.foregroundColor:UIColor.blue]
            
            
            imageName.asObserver().observeOn(MainScheduler.instance).subscribe(onNext: { name in
                tabbar.backgroundImage = UIImage(named: name)
                self.tabBar.scrollEdgeAppearance = tabbar
                self.tabBar.standardAppearance = tabbar
            }).disposed(by: disposeBag)
            
        } else {
            // Fallback on earlier versions
            UITabBar.appearance().backgroundImage = UIColor.imageFromColor(color: UIColor.blue, viewSize: CGSize(width: KScreenW, height: KtabbarH))
            UITabBar.appearance().shadowImage = UIImage()
            //        UITabBar.appearance().backgroundColor = UIColor.appBGColor()
            //            self.tabBar.backgroundImage = UIImage(named: "tab_back")
            imageName.asObserver().observeOn(MainScheduler.instance).subscribe(onNext: { name in
                self.tabBar.backgroundImage = UIImage(named: name)
            }).disposed(by: disposeBag)
            UITabBar.appearance().tintColor = .red
            if #available(iOS 10.0, *) {
                UITabBar.appearance().unselectedItemTintColor = UIColor.blue
            } else {
                // Fallback on earlier versions
            }
            
        }
        self.tabBar.isTranslucent = false
        //        UITabBar.appearance().backgroundColor = UIColor.white
        //        UITabBar.appearance().backgroundImage = UIImage()
        
        
    }
}
