//
//  String+TSSExtension.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 7/7/22.
//

import Foundation
import CommonCrypto
extension String{
    
    /// String to md5
    public var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    
    /// string to double
    public var doubleValue: Double {
        guard let double = Double(self) else {
            return 0.0
        }
        return double
    }
    
    /// String to Dictionary
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
            result = dic
            
        }
        return result
    }
    
    /// get Label Size
    /// - Parameters:
    ///   - font: label font
    ///   - viewSize: label size
    /// - Returns: size
    fileprivate func getStringSize(font: UIFont, labelSize: CGSize) -> CGSize {
        let rect = self.boundingRect(with: labelSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size
    }
    
    /// get Label width
    /// - Parameters:
    ///   - font:  label font
    ///   - height:  label height
    /// - Returns: Label width
    public func getLabelWidth(font:UIFont,height:CGFloat)->CGFloat{
        return getStringSize(font: font, labelSize: CGSize(width: 0, height: height)).width
    }
    
    /// get Label height
    /// - Parameters:
    ///   - font: label font
    ///   - width: label width
    /// - Returns: Label height
    public func getLabelHeight(font:UIFont,width:CGFloat)->CGFloat{
        return getStringSize(font: font, labelSize: CGSize(width: width, height: 0)).height
    }
}
extension Dictionary{
    //MARK:字典转String
    public func toJsonString() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.sortedKeys) else {
            return nil
        }
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return string
    }
}
