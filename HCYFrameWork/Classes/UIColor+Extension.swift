//
//  UIColor+Extension.swift
//
//
//  Created by Jupiter_TSS on 8/3/22.
//

import UIKit
enum UserInterfaceStyle {
    case light
    case dark
}
extension UIColor{
    //MARK:Hex color
    public class func colorWithHexString(_ hexString:String) -> UIColor {
        colorWithHexString(hexString, alpha: 1)
    }
    //MARK:Hex color and alpha
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
    public class func appBGColor()->UIColor{
        
        return .white
    }
    public class func APPColor_000000_1()->UIColor {
        return backCurrentMode(.colorWithHexString("000000"), .colorWithHexString("000000"))
    }
    public class func AppColor_019AE8() -> UIColor {
        backCurrentMode(.colorWithHexString("019AE8"), .colorWithHexString("019AE8"))
    }
    public class func AppColor_222222() -> UIColor {
        backCurrentMode(.colorWithHexString("222222"), .colorWithHexString("222222"))
    }
    public class func AppColor_F2F2F2() -> UIColor {
        backCurrentMode(.colorWithHexString("F2F2F2"), .colorWithHexString("F2F2F2"))
    }
    public class func AppColor_070707() -> UIColor {
        backCurrentMode(.colorWithHexString("070707"), .colorWithHexString("070707"))
    }
    public class func AppColor_F4F4F4() -> UIColor {
        backCurrentMode(.colorWithHexString("F4F4F4"), .colorWithHexString("F4F4F4"))
    }
    
    public class func AppColor_BEBEBE() -> UIColor {
        backCurrentMode(.colorWithHexString("BEBEBE"), .colorWithHexString("BEBEBE"))
    }
    public class func AppColor_00FF92() -> UIColor {
        backCurrentMode(.colorWithHexString("00FF92"), .colorWithHexString("00FF92"))
    }
    
    public class func AppColor_FC4E82() -> UIColor {
        backCurrentMode(.colorWithHexString("FC4E82"), .colorWithHexString("FC4E82"))
    }
    public class func AppColor_009A4C() -> UIColor {
        backCurrentMode(.colorWithHexString("009A4C"), .colorWithHexString("009A4C"))
    }
    public class func AppColor_01D97D() -> UIColor {
        backCurrentMode(.colorWithHexString("01D97D"), .colorWithHexString("01D97D"))
    }
    
    
    /// 渐变按钮左侧
    /// - Returns: -
    public class func APPColor_btnleft_FA3179_1()->UIColor {
        return backCurrentMode(.colorWithHexString("FA3179"), .colorWithHexString("FA3179"))
    }
    
    /// /// 渐变按钮右侧
    /// - Returns: -
    public class func APPColor_btnright_FB5E4A_1()->UIColor {
        return backCurrentMode(.colorWithHexString("FB5E4A"), .colorWithHexString("FB5E4A"))
    }
    
    public func alpha(_ alpha:CGFloat)->UIColor{
        
        let color = UIColor.init(red: self.rgba.red, green: self.rgba.green, blue: self.rgba.blue, alpha: alpha)
        return color
    }
    
    
    public func color() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red,UIColor.yellow]
        
    }
    // Turn colors into pictures

     

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
    fileprivate var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
           var red: CGFloat = 0
           var green: CGFloat = 0
           var blue: CGFloat = 0
           var alpha: CGFloat = 0
           getRed(&red, green: &green, blue: &blue, alpha: &alpha)

           return (red, green, blue, alpha)
       }
}
