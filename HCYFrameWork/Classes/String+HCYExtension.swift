//
//  String+HCYExtension.swift
//  HCYFrameWork
//
//  Created by Jupiter_TSS on 7/7/22.
//

import Foundation
extension String{
    //MARK:String转字典
    
    /// string to Dictionary
    /// - Returns: Dictionary
    public func toDictionary() -> [String:Any] {
        var result = [String:Any]()
        guard !self.isEmpty else {
            return result
        }
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf, options: .mutableContainers) as? [String:Any]{
            result = dic ?? [:]
            
        }
        return result
    }
}
