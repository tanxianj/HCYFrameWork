//
//  APPTabbarViewController.swift
//  ProjectMould
//
//  Created by Jupiter_TSS on 1/6/22.
//

import UIKit
import HCYFrameWork
class APPTabbarViewController: TSSBaseTabbarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tss_ResetTabbarConfig(selectedColor: .colorWithAppearanceMode(.red, .red), normalColor: .gray, backGround: UIImage(named: "tab_back"))
        setupChildControllers()
        self.selectedIndex = 1
//        setTabbarConfig(selectedColor: .green, normalColor: .gray)
    }
    
    fileprivate func setupChildControllers(){
        let array = [
            /*
             ["className":"HomeViewController",
              "title":"Home",
              "normalImage":"Tab_Notes",
              "selectImage":"Tab_Notes_Selected"],
             */
            
            
            ["className":"MeViewController",
             "title":"Me",
             "normalImage":"Tab_Downloads",
             "selectImage":"Tab_Downloads_Selected"],
        ]
        var arrayM = [UIViewController]()
        array.forEach { dic in
            arrayM.append(controller(dic))
        }
        viewControllers = arrayM
    }
    
    fileprivate func controller(_ dic:[String:String])->UIViewController{
        guard let className = dic["className"],
              let title = dic["title"],
              let normalImage = dic["normalImage"],
              let selectImage = dic["selectImage"],
              let workName = Bundle.main.infoDictionary?["CFBundleExecutable"],
              let cls = NSClassFromString("\(workName).\(className)") as? UIViewController.Type  else {
                  return UIViewController()
              }
//        let vc = cls.init()
        let vc = UIStoryboard.init(name: className, bundle: nil).instantiateViewController(withIdentifier: className)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: normalImage)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectImage)?.withRenderingMode(.alwaysOriginal)
        
        vc.navigationItem.title = title
        let nav = APPNavigationViewController(rootViewController: vc)
        return nav
    }
   

}
