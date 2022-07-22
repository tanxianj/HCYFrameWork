//
//  UITableViewCell+TSSExtension.swift
//  TSSFrameWork_Example
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

extension UITableView{
    func defaultConfig(){
        backgroundColor = .white
        separatorColor = .clear
        estimatedRowHeight = 100
        rowHeight = UITableView.automaticDimension
        tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0.01)))
        tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0.01)))
        rowHeight = UITableView.automaticDimension
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
}
extension UICollectionView{
    func defaultConfig(){
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}
