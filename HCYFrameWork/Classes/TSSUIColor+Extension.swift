//
//  TSSUIColor+Extension.swift
//
//
//  Created by Jupiter_TSS on 8/3/22.
//

import UIKit
enum UserInterfaceStyle {
    case light
    case dark
}
//MARK: UIColor extension
extension UIColor{
    
    /// ex color
    /// - Parameter hexString: hexString
    /// - Returns: UIColor
    public class func colorWithHexString(_ hexString:String) -> UIColor {
        colorWithHexString(hexString, alpha: 1)
    }
    
    /// Hex color and alpha
    /// - Parameters:
    ///   - hexString: hexString
    ///   - alpha: alpha
    /// - Returns: UIColor
    public class func colorWithHexString(_ hexString:String,alpha:CGFloat) -> UIColor {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
        
    }
    
    /// Back Color with Current Mode
    /// - Parameters:
    ///   - light: light Color
    ///   - dark: dark color
    /// - Returns: Back Color with Current Mode
    public class func backCurrentMode(_ light:UIColor,_ dark:UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            let currentMode = UITraitCollection.current.userInterfaceStyle
            if currentMode == .light{
                return light
            }else{
                return dark
            }
        }else{
            return light
        }
    }
    
    /// sample
    /// - Returns: sample Color
    public class func APPColor_000000_1()->UIColor {
        return backCurrentMode(.colorWithHexString("000000"), .colorWithHexString("000000"))
    }
    
    /// change Color alpha
    /// - Parameter alpha: alpha 0 ~1
    /// - Returns: Color
    public func alpha(_ alpha:CGFloat)->UIColor{
        
        let color = UIColor.init(red: self.rgba.red, green: self.rgba.green, blue: self.rgba.blue, alpha: alpha)
        return color
    }
    
    // Turn colors into pictures
    
    
    
    /// image From Color
    /// - Parameters:
    ///   - color: color Array
    ///   - viewSize: view Size
    /// - Returns: UIImage
    public class func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        
        return image!
        
    }
    
    /// random color
    /// - Returns: random color
    public class func arc4Color()->UIColor {
        
        return UIColor.init(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
    
    /// back Color rgba
    fileprivate var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}
