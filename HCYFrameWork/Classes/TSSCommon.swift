//
//  TSSCommon.swift
//  
//
//  Created by Jupiter_TSS on 7/3/22.
//

import UIKit

//MARK: Screen width and height
public let TSSScreenW = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
public let TSSScreenH = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
//MARK: KeyWindow
public let TSSKeywindow = UIApplication.shared.keyWindow

//MARK: Determine if it's an iPhone
public let TSSisIphone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//Judge whether it is a model after iphonex
public let TSSisIphoneX = Bool(TSSScreenW >= 375.0 && TSSScreenH >= 812.0 && TSSisIphone)

//MARK:Navigation bar height
public let TSSNavigationH:CGFloat = TSSisIphoneX ? 88.0 : 64.0

//MARK:Status bar height
public let TSSStatusBarH:CGFloat  = TSSisIphoneX ? 44.0 : 20.0

//Bottom safearea height
public let TSSBottomSafeAreaH:CGFloat  = TSSisIphoneX ? 34.0 : 0.0

//tabbar height
public let TSSTabbarH:CGFloat = TSSisIphoneX ? (49.0+34.0) : 49.0

/// One pixel
public let TSSOnePx:CGFloat = 1.0/UIScreen.main.scale

public let TSSIsIpad = UIDevice.current.model.contains("iPad")
/// Work Name
public let TSSWorkName = Bundle.main.infoDictionary?["CFBundleExecutable"]

/// Debugging method printout

public func TSSLog<T>(_ message: T, filePath: String = #file, function:String = #function, rowCount: Int = #line) {
#if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
    print("file: " + fileName +  "  line"  + " \(rowCount) " + "function: " + "\(function)" + "\n\(message)\n")
#endif
}

/// 根据不同的模式返回不同模式下的值
/// - Parameters:
///   - light: light 模式下的 T
///   - dark: dark 模式下的 T
/// - Returns: T
public func tss_DataWithAppearanceMode<T>(_ light:T,_ dark:T)->T{
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
//MARK: once token
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
