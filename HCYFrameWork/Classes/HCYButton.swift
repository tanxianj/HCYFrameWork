//
//  Button.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit

public class HCYButton:UIButton{
    var buttonAction:(() -> Void)?
    
    public func addBlock(callblock:@escaping (()->(Void))){
        self.buttonAction = callblock
    }
}
fileprivate var BTNACTION_KEY = ""
extension UIButton{
    
    typealias hcy_btn_Action = ()->()
    var btnAction:hcy_btn_Action{
        get{
            return (objc_getAssociatedObject(self, &BTNACTION_KEY) as? UIButton.hcy_btn_Action)!
        }
        set{
            objc_setAssociatedObject(self, &BTNACTION_KEY, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    public  func addEventHandler(action:@escaping ()->(),event:UIControl.Event = .touchUpInside) {
        UIViewController.getCurrentVC().view.endEditing(true)
        self.btnAction = action
        self.addTarget(self, action: #selector(addbtnAction), for: event)
    }
    @objc func addbtnAction()  {
        self.btnAction()
    }
}
