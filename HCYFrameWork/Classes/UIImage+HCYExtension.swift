//
//  UIImage+Extension.swift
//  
//
//  Created by on 2022/1/10.
//

import Foundation
import UIKit
import SVGKit
extension UIImage{
    
    
    /*
     Assertion failure in SVGLength.m when running on Apple Silicon Simulator
     
     https://github.com/BurleighCreative/SVGKit/commit/c4dbac4fd86ad8108afb85004213209b214c9739
     
     
     SVGLength.m 232 line if( [platform hasPrefix:@"x86_64"] || [platform hasPrefix:@"arm64"])
     */
    
    /// SVG image change color and orientation
    /// - Parameters:
    ///   - name: svg Name
    ///   - size: change  size
    ///   - color: change size
    ///   - orientation: orientation
    /// - Returns: UIimage
    public class func svgImgWith(name:String, size:CGSize, color:UIColor,orientation:Orientation = .up) -> UIImage{
        let svgImg = SVGKImage.init(named: name)
        svgImg?.size = size
        svgImg?.caLayerTree.sublayers?.forEach({ layer in
            (layer as? CAShapeLayer)?.fillColor = color.cgColor
        })
        if let ciimage =  svgImg?.uiImage.cgImage{
            let tmpImage = UIImage(cgImage: ciimage, scale: 1.0, orientation: orientation)
            return tmpImage
        }
        return svgImg?.uiImage ?? UIImage()
    }
    
    /// Create Image With Color
    /// - Parameters:
    ///   - color: Color
    ///   - size: size
    /// - Returns: UIimage
    public class func CreateImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        color.setFill()
        
        UIRectFill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    /// Create Image With Grad colors
    /// - Parameters:
    ///   - colors: colors
    ///   - size: size
    ///   - direction: direction Type
    ///   - locations: locations 0...1
    /// - Returns: UIimage
    public class func CreateImageWithGrad(colors: [UIColor], size: CGSize,direction:DirectionType = .leftToRight,locations:[NSNumber]? = nil) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        
        let gradientLayer = CAGradientLayer()
        
        
        var gradientColors:[UIColor] = []
        
        if colors.count == 0{
            gradientColors = [UIColor.red,UIColor.blue]
        }else if colors.count == 1{
            return CreateImageWithColor(color: colors.first!, size: size)
        }else{
            gradientColors = colors.map {(color: UIColor) -> UIColor in return color }
        }
        
        //how many colors
        gradientLayer.colors = gradientColors.map{ $0.cgColor }
        if locations == nil{
            let a = 1.0 / CGFloat(colors.count - 1) as NSNumber
            var tmplocations:[NSNumber] = []
            if colors.count > 0 {
                for i in 0..<colors.count{
                    tmplocations.append( CGFloat(i) * CGFloat(a) as NSNumber)    
                }
                gradientLayer.locations = tmplocations
                print("tmplocations is \(tmplocations)")
            }
            
        }else{
            gradientLayer.locations = locations!
        }
        
        var start:CGPoint = .zero
        var end:CGPoint = .zero
        switch direction {
        case .leftToRight:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: 1, y: 0)
        case .topToBottom:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: 0, y: 1)
        case .leftTopToRightBottom:
            start = CGPoint(x: 0, y: 0)
            end = CGPoint(x: 1, y: 1)
        case .rightTopToleftBottom:
            start = CGPoint(x: 0, y: 1)
            end = CGPoint(x: 1, y: 0)
        case .custom(let s, let e):
            start = s
            end = e
        }
        //startPoint
        gradientLayer.startPoint = start
        //endPoint
        gradientLayer.endPoint = end
        //size
        gradientLayer.frame = rect
        
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        
        if let context = UIGraphicsGetCurrentContext(){
            
            gradientLayer.render(in: context)
            
            let outputImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return outputImage ?? UIImage()
        }else{
            return UIImage()
        }
        
    }
}

/// Direction Type
public enum DirectionType{
    case leftToRight
    case topToBottom
    case leftTopToRightBottom
    case rightTopToleftBottom
    case custom(start:CGPoint,end:CGPoint)
}
extension UIImage{
    
    
    /// back Image with Colors
    /// - Parameters:
    ///   - colors: colors
    ///   - direction: direction
    ///   - size: size
    public convenience init(colors:[UIColor],direction:DirectionType = .leftToRight,size:CGSize){
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        let context = UIGraphicsGetCurrentContext()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var gradientColors:NSArray!
        
        if colors.count == 0{
            gradientColors = [UIColor.red.cgColor,UIColor.blue.cgColor] as NSArray
        }else if colors.count == 1{
            gradientColors = [colors.first!.cgColor,colors.first!.cgColor] as NSArray
        }else{
            gradientColors = colors.map {(color: UIColor) -> AnyObject? in return color.cgColor as AnyObject? } as NSArray
        }
        
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors, locations: nil)!
        // 第二个参数是起始位置，第三个参数是终止位置
        var start:CGPoint = .zero
        var end:CGPoint = .zero
        switch direction {
        case .leftToRight:
            end =  CGPoint(x: size.width, y: 0)
        case .topToBottom:
            start = CGPoint(x: size.width / 2, y: 0)
            end =  CGPoint(x: size.width / 2, y: size.height)
        case .leftTopToRightBottom:
            end = CGPoint(x: size.width, y: size.height)
        case .rightTopToleftBottom:
            start = CGPoint(x: size.width , y: 0)
            end = CGPoint(x: 0, y: size.height)
        case .custom(let s, let e):
            start = CGPoint(x: size.width * s.x, y: size.height * s.y)
            end =  CGPoint(x: size.width * e.x, y: size.height * e.y)
        }
        context!.drawLinearGradient(gradient, start: start, end: end, options: CGGradientDrawingOptions(rawValue: 0))
        
        self.init(cgImage: (UIGraphicsGetImageFromCurrentImageContext()?.cgImage)!)
        UIGraphicsEndImageContext()
        
    }
}
extension UIImage{
    
    /// Image Scale
    /// - Parameters:
    ///   - image:  Image before
    ///   - newSize: newSize
    /// - Returns: UIimage
    public func ScaleImage(image:UIImage, newSize:CGSize)->UIImage{
        let imageSize  = image.size
        let w = imageSize.width
        let h = imageSize.height
        let wfactor = newSize.width / w
        let hfactor = newSize.width / h
        
        let scaleFactor = min(wfactor, hfactor)
        
        let scaleWidth = w * scaleFactor
        let scaleHeight = h * scaleFactor
        let targetSize = CGSize(width: scaleWidth, height: scaleHeight)
        UIGraphicsBeginImageContext(targetSize)
        image.draw(in: CGRect(origin: .zero, size: targetSize))
        let newimage = UIGraphicsGetImageFromCurrentImageContext()
        return newimage!
    }
}
extension UIImage{
    
    /// change image Color
    /// - Parameter color: -
    /// - Returns: image
    public func changeColor(color:UIColor,orientation:Orientation = .up)->UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        color.setFill()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(rect)
        self.draw(at: .zero, blendMode: .overlay, alpha: 1.0)
        self.draw(at: .zero, blendMode: .destinationIn, alpha: 1.0)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        if let ciimage =  image.cgImage{
            let tmpImage = UIImage(cgImage: ciimage, scale: 1.0, orientation: orientation)
            return tmpImage
        }
        return image
    }
}
