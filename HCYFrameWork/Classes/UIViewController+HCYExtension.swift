//
//  UIViewController+Extension.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit
typealias block = () ->()?
public enum itemType{
    case left
    case right
}
extension UIViewController{
    public typealias itemAction = ()->()
    
    /// Create Navigation Item
    /// - Parameters:
    ///   - type: left or right
    ///   - title: btn title
    ///   - imageName: btn image
    ///   - titleColor: btn color
    ///   - itemAction: btn tap
    /// - Returns: UIBarButtonItem
    public func CreateNavigationItem(type:itemType,title:String? = nil,imageName:String? = nil, titleColor:UIColor? = nil,itemAction: itemAction?) -> UIBarButtonItem {
        let btn = HCYButton.init(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 44)
        var tmpImgName = imageName
        if imageName != nil {
            if imageName == "return" {
                switch self.preferredStatusBarStyle {
                case .default:
                    tmpImgName = "icon_nav_back"
                    //                    tmpImgName = "icon_nav_back_white"
                    break
                case .lightContent:
                    tmpImgName = "icon_nav_back_white"
                    break
                default:
                    tmpImgName = "icon_nav_back_white"
                    break
                }
            }
            btn.setImage(UIImage.init(named: tmpImgName!), for: .normal)
            switch type {
            case .left:
                btn.contentHorizontalAlignment = .left
                //                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            case .right:
                btn.contentHorizontalAlignment = .right
                //                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            }
        }
        
        if let tmpTitle = title {
            btn.setTitle(tmpTitle, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0.scale())
            if titleColor != nil {
                btn.setTitleColor(titleColor, for: .normal)
            }else{
                btn.setTitleColor(UIColor.white, for: .normal)
            }
            switch type {
            case .left:
                btn.contentHorizontalAlignment = .left
                //                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            case .right:
                btn.contentHorizontalAlignment = .right
                //                btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            }
        }
        if let action = itemAction {
            btn.addBlock {
                action()
            }
        }
        
        btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
        
        return UIBarButtonItem(customView: btn)
    }
    @objc func BarButtonItemAction(btn:HCYButton){
        if let action = btn.buttonAction  {
            action()
        }else{
            let rootvc:UIViewController = UIViewController.getCurrentVC()
            rootvc.navigationController?.popViewController(animated: true)
        }
    }
    @objc func btnAction(btn:HCYButton) {
        if let action = btn.buttonAction  {
            action()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    /// Returns the current controller
    /// - Returns: Returns the current controller
    public class func getCurrentVC() -> UIViewController {
        
        guard UIApplication.shared.keyWindow?.rootViewController == nil else {
            
            let rootViewController:UIViewController  = (UIApplication.shared.keyWindow?.rootViewController)!
            
            let currentVC:UIViewController = self.getCurrentVCFrom(rootVC: rootViewController)
            
            return currentVC
        }
        return UIViewController()
    }
    
    public class func getCurrentVCFrom(rootVC:UIViewController) -> UIViewController {
        var currentVC:UIViewController
        
        if (rootVC.presentedViewController != nil) {
            currentVC = rootVC.presentedViewController!
        }
        if rootVC .isKind(of: UITabBarController.self) {
            let tabbar:UITabBarController = rootVC as!UITabBarController
            
            currentVC = self.getCurrentVCFrom(rootVC: tabbar.selectedViewController!)
        }else if rootVC .isKind(of: UINavigationController.self){
            let nav:UINavigationController = rootVC as!UINavigationController
            currentVC = self.getCurrentVCFrom(rootVC: nav.visibleViewController!)
        }else{
            currentVC = rootVC
        }
        
        return currentVC
    }
}
