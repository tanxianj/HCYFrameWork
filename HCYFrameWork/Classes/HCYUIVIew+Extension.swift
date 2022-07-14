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
    var viewAction:View_action{
        get{
            return objc_getAssociatedObject(self, &VIEW_ACTION_KEY) as! UIView.View_action
        }
        set{
            objc_setAssociatedObject(self, &VIEW_ACTION_KEY, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// any view add GestureRecognizer
    /// - Parameter action: action
    public func addEventHandler(action:@escaping()->()) {
        UIViewController.getCurrentVC().view.endEditing(true)
        self.isUserInteractionEnabled = true
        self.viewAction = action
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTap)))
    }
    @objc func viewTap() {
        self.viewAction()
    }
    
    
    /// View for Xib
    /// - Returns: VIew
    public class func viewForXib() -> UIView{
        
        let name = String(cString: object_getClassName(self)).components(separatedBy: ".").last!
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil).last as! UIView
    }
    /// Parameter subviews: array of subviews to add to self.
    /// - Parameter subviews: Parameter subviews: array of subviews to add to self.
    public  func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    /// set self corner Radius
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
    
    /// set self border width
    @IBInspectable public var borderwidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue.scale()
        }
    }
    /// set self border Color
    @IBInspectable public var borderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    /// set self shadow Color
    @IBInspectable public var shadowColor:UIColor{
        get{
            UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
        set{
            layer.shadowColor = newValue.cgColor
        }
    }
    /// set self shadow Offset
    @IBInspectable public var shadowOffset:CGSize{
        get{
            return layer.shadowOffset
        }
        set{
            layer.shadowOffset = newValue
        }
    }
    
    /// set self shadow Opacity
    @IBInspectable public var shadowOpacity:Float{
        get{
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    
    /// set self shadow Radius
    @IBInspectable public var shadowRadius:CGFloat{
        get{
            return layer.shadowRadius
        }
        set{
            layer.shadowRadius = newValue
        }
    }
    ///  back self height
    public var mj_h: CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            self.bounds.size.height = newValue
        }
    }
    ///  back self width
    public var mj_w: CGFloat {
        get {
            return self.bounds.size.width
        }
        set {
            self.bounds.size.width = newValue
        }
    }
    /// back self frame origin x
    public var mj_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    /// back self frame origin y
    public var mj_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
}
