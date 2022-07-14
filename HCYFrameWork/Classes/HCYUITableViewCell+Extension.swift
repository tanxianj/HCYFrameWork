//
//  UITableViewCell+HCYExtension.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 13/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//


import UIKit
extension UITableViewCell{
    public class func Identifier()->String{
        var cellid = ""
        cellid = String(cString: object_getClassName(self)).components(separatedBy: ".").last!
        return cellid
    }
}

extension UICollectionViewCell{
    public class  func Identifier() -> String {
        var cellid = ""
        cellid = String(cString: object_getClassName(self)).components(separatedBy: ".").last!
        return cellid
    }
}
