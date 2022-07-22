//
//  Common.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit

//MARK: Screen width and height
public let KScreenW = UIScreen.main.bounds.width
public let KScreenH = UIScreen.main.bounds.height
//MARK: KeyWindow
public let Keywindow = UIApplication.shared.keyWindow

//MARK: Determine if it's an iPhone
public let kIsIphone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//Judge whether it is a model after iphonex
public let KisIphoneX = Bool(KScreenW >= 375.0 && KScreenH >= 812.0 && kIsIphone)
//MARK:Navigation bar height
public let KNavigationH:CGFloat = KisIphoneX ? 88.0 : 64.0
//MARK:Status bar height
public let KStatusBarH:CGFloat  = KisIphoneX ? 44.0 : 20.0

//Bottom safearea height
public let KBottomSafeAreaH:CGFloat  = KisIphoneX ? 34.0 : 0.0

//tabbar height
public let KtabbarH:CGFloat = KisIphoneX ? (49.0+34.0) : 49.0

/// One pixel
public let KonePx:CGFloat = 1.0/UIScreen.main.scale

public let IsIpad = UIDevice.current.model.contains("iPad")
//Custom RGB color

public func RGBColor(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat = 1) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}


//Font size is based on iphpnex

//func customFont(fontSize:CGFloat) -> UIFont {
//    // IphoneX
//    guard KScreenH <= 736 else {
//        return UIFont.systemFont(ofSize: fontSize)
//    }
//    // 5.5
//    guard KScreenH == 736 else {
//        return UIFont.systemFont(ofSize: fontSize - 2)
//    }
//    // 4.7
//    guard KScreenH >= 736 else {
//        return UIFont.systemFont(ofSize: fontSize - 4)
//    }
//    
//    return UIFont.systemFont(ofSize: fontSize)
//}

/// Debugging method printout

public func DebugLog<T>(_ message: T, filePath: String = #file, function:String = #function, rowCount: Int = #line) {
#if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
    print("file: " + fileName +  "  line"  + " \(rowCount) " + "function: " + "\(function)" + "\n\(message)\n")
#endif
}

//MARK: Generic closure definition
public typealias KAppBlockToVoid<T> = (T)->()
//MARK: Generic ancestor
public typealias KAppYuanZu<T> = (T)

let delay = {(time:Double,action:@escaping block) in
    DispatchQueue.main.asyncAfter(deadline:.now() + time) {
        action()
    }
}
