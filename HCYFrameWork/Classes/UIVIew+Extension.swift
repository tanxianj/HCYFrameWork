//
//  UIVIew+Extension.swift
//  MyFrameWork
//
//  Created by Jupiter_TSS on 4/7/22.
//

import UIKit

fileprivate var VIEW_ACTION_KEY = ""

extension UIView{
    typealias View_action = ()->()
    var vaiewAction:View_action{
        get{
            return objc_getAssociatedObject(self, &VIEW_ACTION_KEY) as! UIView.View_action
        }
        set{
            objc_setAssociatedObject(self, &VIEW_ACTION_KEY, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
   public func addEventHandler(action:@escaping()->()) {
        UIViewController.getCurrentVC().view.endEditing(true)
        self.isUserInteractionEnabled = true
        self.vaiewAction = action
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap)))
    }
    @objc func viewTap() {
        self.vaiewAction()
    }
    
    
    class func viewForXib() -> UIView{
        
        let name = String(cString: object_getClassName(self)).components(separatedBy: ".").last!
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil).last as! UIView
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue.scale()
            clipsToBounds = true
//            layer.masksToBounds = true
        }
    }
    
    @IBInspectable public var borderwidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue.scale()
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var shadowColor:UIColor{
        get{
            UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set{
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var shadowOffset:CGSize{
        get{
            return layer.shadowOffset
        }
        set{
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable public var shadowOpacity:Float{
        get{
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable public var shadowRadius:CGFloat{
        get{
            return layer.shadowRadius
        }
        set{
            layer.shadowRadius = newValue
        }
    }
    
    public var mj_h: CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            self.bounds.size.height = newValue
        }
    }
    
    public var mj_w: CGFloat {
        get {
            return self.bounds.size.width
        }
        set {
            self.bounds.size.width = newValue
        }
    }
    
    public var mj_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    public var mj_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
}
