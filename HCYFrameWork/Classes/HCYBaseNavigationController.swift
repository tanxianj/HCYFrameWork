//
//  BaseNavigationController.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit

/// Base Navigation
open class HCYBaseNavigationController: UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: set Navigation bar parameter
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = .white
            
            /*
             navBarAppearance.backgroundImage = UIImage(colors: [RGBColor(r: 140, g: 228, b: 152),
             RGBColor(r:85,g:195,b:179),
             RGBColor(r:78,g:178,b:184)],
             size: CGSize(width: KScreenW, height: KNavigationH))
             */
            navBarAppearance.backgroundEffect = nil
            navBarAppearance.shadowColor = .clear
            navBarAppearance.titleTextAttributes = [.foregroundColor:UIColor.green ,.font:UIFont.systemFont(ofSize: 18.scale(), weight: .semibold)]
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationBar.standardAppearance = navBarAppearance
        }else{
            
            //        self.navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
            self.navigationBar.shadowImage = UIImage()
            self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.black,.font:UIFont.systemFont(ofSize: 18.0.scale(), weight: .semibold)]
        }
        self.navigationBar.isTranslucent = false
        //        self.navigationBar.prefersLargeTitles = true
        //        self.navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    
    /// override push function
    /// - Parameters:
    ///   - viewController: target  viewController
    ///   - animated: animated true or false
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0
        super.pushViewController(viewController, animated: animated)
    }
    /// override Status Bar Hidden
        open override var childForStatusBarHidden: UIViewController?{
            return self.topViewController
        }
    /// override Status Bar Style
        open override var childForStatusBarStyle: UIViewController?{
            return topViewController
        }
    
    
}
