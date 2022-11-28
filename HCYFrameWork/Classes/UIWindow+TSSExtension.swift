//
//  UIWindow+TSSExtension.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 14/7/22.
//

import Foundation
import UIKit

#if DEBUG
import FLEX
extension UIWindow{
    
    /// Shake Device show Flex Tools only Debug 
    /// - Parameters:
    ///   - motion: -
    ///   - event: -
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake{
            FLEXManager.shared.isNetworkDebuggingEnabled = true
            FLEXManager.shared.showExplorer()
        }
    }
}
#endif
